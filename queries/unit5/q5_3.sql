-- For these queries i will use properties and amenties tables from Rental Marketplace

-- 1. Count the rows in each table

SELECT COUNT(*) AS total_properties
FROM properties;

SELECT COUNT(*) AS total_amenities
FROM amenities;

-- table	Number of Rows
-- properties	15
-- amenities	5

-- 2. Write the CROSS JOIN query
SELECT
    p.property_label,
    a.amenity_name
FROM properties p
         CROSS JOIN amenities a
ORDER BY p.property_id, a.amenity_id;


-- 3.Show how the result matches the multiplication of the two source table counts.
-- 15 Properties × 5 Amenities = 75 Combinations
-- I verified the counts using the data in your uploaded SQL file.
-- The Cartesian product produces exactly 75 rows.

-- 4. Explain when a Cartesian product might be useful and when it could indicate a query error.
-- A Cartesian product can be useful when generating all possible combinations between two tables.
-- For example, in a rental marketplace, a CROSS JOIN could be used to generate all possible property
-- and amenity combinations to identify which amenities could potentially be added to each property.

-- Part B: Examine a Query Execution Plan
-- 1. Capture the full execution plan

EXPLAIN ANALYZE
SELECT
    p.property_label,
    v.attended_at,
    r.renter_name
FROM viewings v
         INNER JOIN properties p
                    ON v.property_id = p.property_id
         INNER JOIN renters r
                    ON v.renter_id = r.renter_id
WHERE v.viewing_status = 'attended'
GROUP BY
    r.renter_name,
    p.property_label,
    v.attended_at;




-- 2. Identify the join algorithms

-- Nested Loop: PostgreSQL uses a Nested Loop to match the 156 attended viewings with their corresponding properties. It uses the primary key index on properties and caches repeated lookups through Memoize.

-- Hash Join: PostgreSQL uses a Hash Join to match the resulting records with renters. It builds a hash table containing the 30 renter records and uses renter_id to identify matching renters.

-- 3. Why PostgreSQL may select these algorithms
-- PostgreSQL likely selected these algorithms because the dataset is relatively small.
-- - The viewings table contains 200 records, so a Sequential Scan is inexpensive. It filters out 44 records and processes the remaining 156.
-- - The Nested Loop efficiently retrieves property information using the properties_pkey index.
-- - Memoize improves efficiency by recording 143 cache hits and only 13 misses, reducing repeated property lookups.
-- - The Hash Join is efficient because the renters table has only 30 records, allowing PostgreSQL to build a small hash table using 10 kB of memory.


-- 4. Which part may become less efficient as the dataset grows?

-- The Sequential Scan on the viewings table could become less efficient as the number
-- of viewing events increases. PostgreSQL currently scans all 200 viewing records to identify the 156 attended events.

-- As the dataset grows to thousands or millions of viewings, scanning and filtering the entire
-- table could become more expensive. The joins and aggregation would also need to process more records.

-- Depending on the size of the dataset and the proportion of attended viewings, an index on
-- viewing_status or a more targeted index could improve performance.