-- Part A: Compare INNER JOIN and LEFT JOIN

-- Write two queries to compare the results of an inner join and a left join.
-- Use LEFT JOIN to return all producers, including those who have never had an event.


SELECT
    p.property_id,
    p.property_label,
    COUNT(v.viewing_id) AS total_viewings
FROM properties p
         LEFT JOIN viewings v
                   ON p.property_id = v.property_id
GROUP BY p.property_id, p.property_label
ORDER BY p.property_id;


-- Write an equivalent query using INNER JOIN.
SELECT
    p.property_id,
    p.property_label,
    COUNT(v.viewing_id) AS total_viewings
FROM properties p
INNER JOIN viewings v
    ON p.property_id = v.property_id
GROUP BY p.property_id, p.property_label
ORDER BY p.property_id;

-- Compare the results and determine how many producers are excluded by the inner join.

-- The LEFT JOIN returned all 15 properties, including those without any viewing activity, while the INNER JOIN returned only 13 properties.
-- The two excluded properties were Property_14 and Property_15 because they had no matching records in the viewings table.

-- Explain which producers are missing and why.

-- Property ID	Property Name	Total Viewings
-- 14	Property_14	0
-- 15	Property_15	0
--
-- These properties are excluded because they have no matching records in the viewings table.
-- An INNER JOIN returns only rows with matching records in both tables, while a LEFT JOIN preserves all properties even when no viewing exists.

-- Part B: Explore RIGHT JOIN and FULL OUTER JOIN

-- 1. Write a RIGHT JOIN that returns the same records as your LEFT JOIN from Part A.
SELECT
    p.property_id,
    p.property_label,
    COUNT(v.viewing_id) AS total_viewings
FROM viewings v
         RIGHT JOIN properties p
                   ON p.property_id = v.property_id
GROUP BY p.property_id, p.property_label
ORDER BY p.property_id;
-- 2. Compare the results to confirm that they match.
-- Both the LEFT JOIN and RIGHT JOIN returned the same 15 properties,
-- including Property_14 and Property_15, which have no viewing records.
-- The results match because the LEFT JOIN preserves all records from the left table
-- (`properties`), while the RIGHT JOIN preserves all records from the right table
-- (`properties`). By reversing the table order, both queries produce identical results,
-- including the viewing counts for each property.

-- 3. Write a FULL OUTER JOIN that includes matching and unmatched records from both tables.

SELECT
    p.property_id,
    p.property_label,
    v.viewing_id,
    v.property_id AS viewing_property_id,
    v.scheduled_at
FROM properties p
         FULL OUTER JOIN viewings v
                         ON p.property_id = v.property_id
ORDER BY p.property_id;

-- 4. Explain what a full outer join can reveal that a left join or right join alone may not show.
-- A FULL OUTER JOIN returns all records from both the properties and viewings tables,
-- including those without matching records. Unlike a LEFT JOIN or RIGHT JOIN alone,
-- it can identify both properties that have never received viewings and viewing records
-- that are not associated with an existing property.

-- Part C: Find Producers with No Events Using Two Approaches
-- Write two queries that identify producers who have never had an event and compare them.

-- ✓  NOT EXISTS.
    SELECT
        p.property_id,
        p.property_label
    FROM properties p
    WHERE NOT EXISTS (
        SELECT 1
        FROM viewings v
        WHERE p.property_id = v.property_id
    );

-- ✓  EXCEPT.
SELECT
    p.property_id
FROM properties p
EXCEPT
SELECT property_id FROM viewings;


-- The NOT EXISTS query checks each property to determine whether
-- it has any matching viewing records, while EXCEPT removes properties
-- that appear in the viewing records from the complete list of properties.
-- Both queries returned the same two properties, Property_14 and Property_15,
-- confirming that neither has any viewing events.