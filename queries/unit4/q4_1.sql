-- Calculate the following statistics across the entire event table using your theme's metric:
-- the count, total, average, minimum, and maximum of your theme’s metric across the whole event table
SELECT
    COUNT(*) AS total_viewings,
    SUM(duration_min) AS total_duration,
    AVG(duration_min) AS avg_duration,
    MIN(duration_min) AS min_duration,
    MAX(duration_min) AS max_duration,
    COUNT(DISTINCT renter_id) AS distinct_renters
FROM viewings;


-- 2. Write a query that calculates the event count and average metric for each producer.
-- Sort the results from the producer with the most events to the producer with the fewest.
SELECT
    p.property_id,
    p.property_label,
    COUNT(v.viewing_id) AS event_count,
    ROUND(AVG(v.duration_min), 2) AS avg_duration
FROM properties p
         LEFT JOIN viewings v ON p.property_id = v.property_id
GROUP BY
    p.property_id,
    p.property_label
ORDER BY event_count DESC;

-- 3. A producer with only a few events may have a high failure rate that is not representative of their usual performance.
-- Choose a minimum event-count threshold and use HAVING to include only producers who meet that threshold.

SELECT
    p.property_id,
    p.property_label,
    COUNT(v.viewing_id) AS event_count,
    ROUND(AVG(v.duration_min), 2) AS avg_duration
FROM properties p
         JOIN viewings v
              ON p.property_id = v.property_id
GROUP BY
    p.property_id,
    p.property_label
HAVING COUNT(v.viewing_id) >= 5
ORDER BY event_count DESC;

-- 4. How does the picture change along two dimensions at once?
-- For the two dimentions I will be using
-- Region: city from the properties table.
-- Producer: property_id and property_label from the properties table.


SELECT
    p.city AS region,
    p.property_id,
    p.property_label,
    COUNT(v.viewing_id) AS event_count,
    SUM(v.duration_min) AS total_duration,
    ROUND(AVG(v.duration_min), 2) AS avg_duration,
    MIN(v.duration_min) AS min_duration,
    MAX(v.duration_min) AS max_duration,
    COUNT(DISTINCT v.renter_id) AS distinct_renters
FROM properties p
         JOIN viewings v
              ON p.property_id = v.property_id
GROUP BY
    p.city,
    p.property_id,
    p.property_label
ORDER BY
    p.city,
    event_count DESC;
