--- Write a query with a negation or inequality predicate on that column — for example WHERE status != 'completed' — and record the row count it returns.

-- Counts rows with reasons other than  'Renter no show' and excluding NULL
SELECT count(*) AS first_count
FROM viewings
WHERE no_show_reason != 'Renter no show';

-- Counts rows with reason  'Renter no show', also excluding NULLS

SELECT count(*) AS sec_count
FROM viewings
WHERE no_show_reason = 'Renter no show';

-- Counts all rows in total
SELECT count(*) AS total_count
FROM viewings;


-- Repair the first query using an explicit IS NULL condition or COALESCE, so it returns what you intended.
SELECT count(*) AS fixed_count
FROM viewings
WHERE no_show_reason != 'Renter no show' OR no_show_reason IS NULL ;




-- Part B: The alias that did not exist yet
-- SQL is written FROM, WHERE, SELECT, ORDER BY, but it is not evaluated in that order.



-- Write a query defining an alias in SELECT and referencing that alias in WHERE. Capture the error message verbatim.
SELECT
    viewing_id,
    interest_score AS renter_interest
FROM viewings
WHERE renter_interest >= 4;

-- Produce two correct rewrites:
-- one repeating the expression in WHERE,
SELECT
    viewing_id,
    interest_score AS renter_interest
FROM viewings
WHERE interest_score >= 4;

-- one wrapping the query in a CTE or subquery so the alias becomes a real column.
WITH viewing_interest AS (
    SELECT
        viewing_id,
        interest_score AS renter_interest
    FROM viewings
)
SELECT
    viewing_id,
    renter_interest
FROM viewing_interest
WHERE renter_interest >= 4;