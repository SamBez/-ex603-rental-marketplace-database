-- 1. First as a subquery using IN or NOT IN.
-- Find renters involved in no-show viewings.
-- Requirement: Subquery using IN.

SELECT renter_id, renter_name
FROM renters
WHERE renter_id IN (
    SELECT renter_id
    FROM viewings
    WHERE viewing_status = 'cancelled'
);

-- 2. Then as a Common Table Expression using WITH.
-- Find renters involved in no-show viewings.
-- Requirement: Common Table Expression (CTE).

WITH no_show_renters AS (
    SELECT DISTINCT renter_id
    FROM viewings
    WHERE viewing_status = 'cancelled'
)
SELECT r.renter_id, r.renter_name
FROM renters r
         JOIN no_show_renters n
              ON r.renter_id = n.renter_id;

-- 3. Then a third way, distinct from both — a different subquery form, a CASE-based construction, or a set-based approach.
-- Find renters involved in no-show viewings.
-- Requirement: Correlated subquery using EXISTS.

SELECT r.renter_id, r.renter_name
FROM renters r
WHERE EXISTS (
    SELECT 1
    FROM viewings v
    WHERE v.renter_id = r.renter_id
      AND v.viewing_status = 'cancelled'
);

-- 4. Demonstrate that all three return identical result sets. Matching row counts is not enough: show that the rows themselves match.
WITH
    q1 AS (
        SELECT renter_id, renter_name
        FROM renters
        WHERE renter_id IN (
            SELECT renter_id
            FROM viewings
            WHERE viewing_status = 'cancelled'
        )
    ),
    q2 AS (
        WITH no_show_renters AS (
            SELECT DISTINCT renter_id
            FROM viewings
            WHERE viewing_status = 'cancelled'
        )
        SELECT r.renter_id, r.renter_name
        FROM renters r
                 JOIN no_show_renters n
                      ON r.renter_id = n.renter_id
    ),
    q3 AS (
        SELECT r.renter_id, r.renter_name
        FROM renters r
        WHERE EXISTS (
            SELECT 1
            FROM viewings v
            WHERE v.renter_id = r.renter_id
              AND v.viewing_status = 'cancelled'
        )
    )
SELECT 'Q1 vs Q2' AS comparison, *
FROM (
         (SELECT * FROM q1 EXCEPT ALL SELECT * FROM q2)
         UNION ALL
         (SELECT * FROM q2 EXCEPT ALL SELECT * FROM q1)
     ) differences

UNION ALL

SELECT 'Q1 vs Q3' AS comparison, *
FROM (
         (SELECT * FROM q1 EXCEPT ALL SELECT * FROM q3)
         UNION ALL
         (SELECT * FROM q3 EXCEPT ALL SELECT * FROM q1)
     ) differences;