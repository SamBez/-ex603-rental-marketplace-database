-- SELECT
--     table_name,
--     column_name,
--     data_type
-- FROM information_schema.columns
-- WHERE table_schema = 'public'
-- ORDER BY table_name, ordinal_position;
--

-- Find active, highly rated producers. Use your theme’s filter condition from the appendix. Sort them and return the first ten.
-- Available rental properties — the listings that anchor the rental marketplace audit. Requirement: SELECT, WHERE, ORDER BY, LIMIT.

SELECT property_id, property_label, monthly_rent
FROM properties
WHERE is_available = TRUE
  AND monthly_rent >= 1500
ORDER BY monthly_rent DESC
LIMIT 10;

-- Find all possible viewing statuses in the rental marketplace.
-- Requirement: SELECT DISTINCT.

SELECT DISTINCT viewing_status
FROM viewings
ORDER BY viewing_status;

-- Filter the events in two different ways. Write: one query that filters a numeric range, and one query that filters using an explicit list of values with IN.
-- Find property viewings with an interest score between 1 and 3.
-- Requirement: SELECT, WHERE, BETWEEN.
SELECT viewing_id, renter_id, property_id, interest_score
FROM viewings
WHERE interest_score BETWEEN 1 AND 3;

-- Find property viewings with specific viewing statuses.
-- Requirement: SELECT, WHERE, IN.

SELECT viewing_id, renter_id, property_id, viewing_status
FROM viewings
WHERE viewing_status IN ('scheduled', 'completed', 'cancelled');

-- Work with text and missing values. Write queries that: find producers whose names match a text pattern using LIKE, and identify records where a reason/value is missing (NULL). Use COALESCE to replace a missing value with a useful label such as: No reason provided.
SELECT viewings.booking_city, COALESCE(viewings.no_show_reason, 'No reason provided') AS no_show_reason, viewings.viewing_status
from viewings
where booking_city LIKE '%on%' AND no_show_reason IS NULL;

-- Make viewing results easier to understand by categorizing, renter interest scores into plain-language labels.

SELECT
    viewing_id,
    renter_id,
    property_id,
    interest_score,
    CASE
        WHEN interest_score >= 4 THEN 'High Interest'
        WHEN interest_score >= 2 THEN 'Moderate Interest'
        WHEN interest_score < 2 THEN 'Low Interest'
        ELSE 'Not Rated'
        END AS interest_category
FROM viewings;