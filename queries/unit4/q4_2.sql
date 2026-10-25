-- Part A: Two numbers in one pass
SELECT
    p.property_id,
    p.property_label,
    COUNT(v.viewing_id) AS total_events,
    SUM(
            CASE
                WHEN v.viewing_status IN ('cancelled', 'disputed')
                    THEN 1
                ELSE 0
                END
    ) AS failed_events
FROM properties p
         JOIN viewings v
              ON p.property_id = v.property_id
GROUP BY
    p.property_id,
    p.property_label
ORDER BY failed_events DESC;

--  For Part B, name the reader who needs subtotals rather than detail rows, and say what decision the grand total supports that the group rows do not.
SELECT
    CASE
        WHEN GROUPING(p.city) = 1
            THEN 'Platform Total'
        ELSE p.city
        END AS region,
    COUNT(v.viewing_id) AS total_events,
    SUM(
            CASE
                WHEN v.viewing_status IN ('cancelled', 'disputed')
                    THEN 1
                ELSE 0
                END
    ) AS failed_events
FROM properties p
         JOIN viewings v
              ON p.property_id = v.property_id
GROUP BY GROUPING SETS (
    (p.city),
    ()
    )
ORDER BY
    GROUPING(p.city),
    p.city;
-- Note:
-- The rows showing  cities represent regional subtotals, summarizing the total number of
-- viewing events and failed events within each region. The row labeled "Platform Total"
-- represents the grand total across all regions.  property-level detail rows
-- are excluded, which lets the regional director to compare overall activity and
-- failures by region and across the entire data set.


-- Part C: A two-step pipeline

WITH property_stats AS (
    SELECT
        property_id,
        COUNT(*) AS total_events,
        COUNT(CASE WHEN viewing_status IN ('cancelled', 'disputed')
                       THEN 1 END) AS failures
    FROM viewings
    GROUP BY property_id
)
SELECT
    ROUND(AVG(failures * 100.0 / total_events), 2)
        AS avg_failure_rate
FROM property_stats
WHERE total_events >= 5;


