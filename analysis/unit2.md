
The constraints table

For host.user_id, ON DELETE CASCADE governs what happens when a user account that has a host profile is deleted. 
The corresponding row in host is automatically deleted. A host profile is an extension of that user and does not 
make sense without the underlying user. Using RESTRICT instead would mean the user could not be deleted until 
someone manually removed the host record first.

For property.host_id, the event is the removal of a host. With CASCADE, properties owned by that host are 
automatically removed as well. Those listings depend on the host who created and manages them. 
Without cascading, removing a host could either be blocked by RESTRICT or, without proper referential 
integrity, leave properties pointing to a host that no longer exists.

For booking.user_id, I would use RESTRICT. The real event is a user attempting to delete their account 
while bookings still exist under their identity. The database prevents the deletion until those booking 
records are handled appropriately. This protects booking history. With CASCADE, deleting a user could 
automatically erase all of their bookings, including records that may be needed for transaction history, 
disputes, or reporting.

For booking.property_id, RESTRICT similarly protects booking history. If a host attempts to remove a 
property that has associated bookings, the property cannot simply disappear while those bookings 
depend on it. Using CASCADE here could cause deleting one property listing to delete its historical 
bookings as well, which is generally undesirable.

For user_fav_prp.user_id, CASCADE makes sense because favorites are user-specific preference data 
rather than transaction history. When a user is removed, their rows in user_fav_prp are automatically 
deleted. RESTRICT would unnecessarily prevent account deletion merely because the user had saved some 
properties as favorites.

Finally, for user_fav_prp.property_id, CASCADE means that removing a property automatically removes that 
property from every user's favorites. The affected records are only the favorite associations, not the users 
themselves. Using RESTRICT would mean a host could be prevented from deleting a property simply because one or 
more users had favorited it, requiring those favorite records to be manually removed first.





The CHECK constraints

Host Rating
Ensures ratings stay between 0 and 5. Without it, input errors or application bugs could store invalid ratings such as 6.5.
Property Price per Night
Prevents negative nightly prices. Without it, data-entry or application errors could store values such as -75.
Booking Dates
Ensures the checkout date is after the check-in date. Without it, users or application errors could create bookings with reversed or identical dates.
Booking Total Price
Prevents a negative booking total. Without it, calculation or discount errors could result in invalid negative prices being stored.