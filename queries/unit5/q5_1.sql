
-- Who are the people behind the events?
-- Write a query that joins three tables to display the
-- actor who performed each event, the producer associated with
-- the event, and the event's date and time.

SELECT
    v.viewing_id,
    r.renter_name,
    p.property_label,
    v.scheduled_at
FROM viewings v
         INNER JOIN properties p
                    ON v.property_id = p.property_id
         INNER JOIN renters r
                    ON v.renter_id = r.renter_id;

-- 2. Do the producers identified in Assignment 4 share certain
-- catalog credentials or tags? Write a query that connects the
-- producer table to the catalog table through the junction table.
-- Return the producers associated with your theme's catalog tag

SELECT
    p.property_label,
    a.amenity_name
FROM properties p
         INNER JOIN listing_amenities la
                    ON p.property_id = la.property_id
         INNER JOIN amenities a
                    ON la.amenity_id = a.amenity_id
WHERE a.amenity_name = 'Pool';

-- 3. How do the producers compare with one another?
-- Write a self join to compare records within the producer table.
-- Use the results to explore whether the producers identified in
-- Assignment 4 share characteristics with other producers or whether
-- differences in activity levels may explain their performance.

SELECT
    p1.property_label AS property_1,
    p2.property_label AS property_2,
    p1.city,
    p1.monthly_rent AS rent_1,
    p2.monthly_rent AS rent_2,
    p1.is_available AS available_1,
    p2.is_available AS available_2
FROM properties p1
         INNER JOIN properties p2
                    ON p1.city = p2.city
                        AND p1.property_id < p2.property_id
ORDER BY p1.city;


