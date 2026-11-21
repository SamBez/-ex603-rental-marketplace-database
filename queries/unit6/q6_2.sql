-- Part A: Row to row

WITH viewing_trends AS (
    SELECT
        viewing_id,
        property_id,
        scheduled_at,
        viewing_status,
        duration_min,
        LAG(duration_min) OVER (
            PARTITION BY property_id
            ORDER BY scheduled_at, viewing_id
            ) AS previous_duration,
        LEAD(duration_min) OVER (
            PARTITION BY property_id
            ORDER BY scheduled_at, viewing_id
            ) AS next_duration
    FROM viewings
)
SELECT *,
       duration_min - previous_duration AS delta
FROM viewing_trends
WHERE property_id = 1
ORDER BY scheduled_at, viewing_id;

-- Part B: Cumulative and smoothed
WITH daily_viewings AS (
    SELECT
        scheduled_at::DATE AS viewing_date,
        COUNT(*) AS total_viewings
    FROM viewings
    GROUP BY scheduled_at::DATE
),
     viewing_trends AS (
         SELECT
             viewing_date,
             total_viewings,
             SUM(total_viewings) OVER (
                 ORDER BY viewing_date
                 ROWS BETWEEN UNBOUNDED PRECEDING
                     AND CURRENT ROW
                 ) AS running_total,
             ROUND(AVG(total_viewings) OVER (
                 ORDER BY viewing_date
                 ROWS BETWEEN 6 PRECEDING
                     AND CURRENT ROW
                 ), 2) AS moving_average
         FROM daily_viewings
     )
SELECT *,
       250 AS target,
       250 - running_total AS remaining_to_target,
       ROUND(running_total * 100.0 / 250, 2)
           AS target_percentage
FROM viewing_trends
ORDER BY viewing_date;

-- Part C: Where the series stops
WITH viewing_gaps AS (
    SELECT
        property_id,
        viewing_id,
        scheduled_at,
        LAG(scheduled_at) OVER (
            PARTITION BY property_id
            ORDER BY scheduled_at, viewing_id
            ) AS previous_viewing
    FROM viewings
),
     gap_calculation AS (
         SELECT *,
                scheduled_at - previous_viewing AS gap
         FROM viewing_gaps
     )
SELECT
    property_id,
    previous_viewing,
    scheduled_at AS current_viewing,
    gap
FROM gap_calculation
WHERE gap > INTERVAL '90 days'
ORDER BY gap DESC;