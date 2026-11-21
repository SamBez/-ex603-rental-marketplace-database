-- 1. Compare each event to its producer’s average

SELECT
    viewing_id,
    property_id,
    duration_min,
    ROUND(AVG(duration_min) OVER (
        PARTITION BY property_id
        ), 2) AS avg_duration,
    ROUND(duration_min - AVG(duration_min) OVER (
        PARTITION BY property_id
        ), 2) AS difference
FROM viewings
ORDER BY property_id, viewing_id;

-- 2. Rank producers three ways
WITH property_counts AS (
    SELECT
        p.property_id,
        p.property_label,
        COUNT(v.viewing_id) AS total_viewings
    FROM properties p
             LEFT JOIN viewings v
                       ON p.property_id = v.property_id
    GROUP BY p.property_id, p.property_label
)
SELECT
    property_id,
    property_label,
    total_viewings,
    ROW_NUMBER() OVER (
        ORDER BY total_viewings DESC, property_id
        ) AS row_num,
    RANK() OVER (
        ORDER BY total_viewings DESC
        ) AS property_rank,
    DENSE_RANK() OVER (
        ORDER BY total_viewings DESC
        ) AS dense_rank
FROM property_counts
ORDER BY total_viewings DESC, property_id;

-- 3. Sort producers into four bands

WITH property_counts AS (
    SELECT
        p.property_id,
        p.property_label,
        COUNT(v.viewing_id) AS total_viewings
    FROM properties p
             LEFT JOIN viewings v
                       ON p.property_id = v.property_id
    GROUP BY p.property_id, p.property_label
)
SELECT
    property_id,
    property_label,
    total_viewings,
    NTILE(4) OVER (
        ORDER BY total_viewings DESC, property_id
        ) AS viewing_band
FROM property_counts
ORDER BY total_viewings DESC, property_id;