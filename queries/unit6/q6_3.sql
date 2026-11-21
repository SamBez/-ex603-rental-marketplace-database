-- Part A: Top N per category

WITH ranked_viewings AS (
    SELECT
        property_id,
        viewing_id,
        scheduled_at,
        duration_min,
        ROW_NUMBER() OVER (
            PARTITION BY property_id
            ORDER BY duration_min DESC, viewing_id
            ) AS viewing_rank,
        FIRST_VALUE(duration_min) OVER (
            PARTITION BY property_id
            ORDER BY duration_min DESC, viewing_id
            ) AS longest_duration
    FROM viewings
)
SELECT *
FROM ranked_viewings
WHERE viewing_rank <= 3
ORDER BY property_id, viewing_rank;

-- Part B: Period over period
WITH monthly_viewings AS (
    SELECT
        DATE_TRUNC('month', scheduled_at)::DATE AS month,
        COUNT(*) AS total_viewings
    FROM viewings
    GROUP BY DATE_TRUNC('month', scheduled_at)::DATE
),
     monthly_comparison AS (
         SELECT
             month,
             total_viewings,
             LAG(total_viewings) OVER (
                 ORDER BY month
                 ) AS previous_month_viewings,
             LAG(month) OVER (
                 ORDER BY month
                 ) AS previous_month
         FROM monthly_viewings
     )
SELECT
    month,
    total_viewings,
    previous_month_viewings,
    CASE
        WHEN month = previous_month + INTERVAL '1 month'
            THEN ROUND(
                (total_viewings - previous_month_viewings)
                    * 100.0 / NULLIF(previous_month_viewings, 0),
                2
                 )
        ELSE NULL
        END AS percent_change,
    CASE
        WHEN previous_month IS NULL THEN 'First month'
        WHEN month <> previous_month + INTERVAL '1 month'
            THEN 'Missing month detected'
        ELSE 'No gap'
        END AS month_check
FROM monthly_comparison
ORDER BY month;