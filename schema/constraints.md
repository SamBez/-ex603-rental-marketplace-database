 Constraints and  Justifications
 
User Entity
user_id(primary_key) Every user needs a unique identifier
firstname NOT NULL every user must provide firstname
lastname NOT NULL every user must provide lastname
email NOT NULL UNIQUE Every user must provide email. Email should be unique
phone can be NULL  


Host Entity
host_id (primary_key) Every host needs a unique identifier
user_id (foreign_key) NOT NULL Every host must be associated with a valid user
host_since NOT NULL Every host must have a date showing when they became a host
rating can be NULL A new host may not have a rating yet
rating CHECK (rating >= 1 AND rating <= 5) A host rating must be between 1 and 5
user_id UNIQUE A user should have only one host profile
user_id ON DELETE CASCADE If a user is deleted, their host profile should also be deleted because the host profile cannot exist without the user


Bookings
booking_id (primary_key) Every booking needs a unique identifier
user_id (foreign_key) Every booking must belong to a valid user
property_id (foreign_key) Every booking must be associated with a valid property
check_in_date NOT NULL Every booking must have a check-in date
check_out_date NOT NULL Every booking must have a check-out date
total_price NOT NULL CHECK (total_price >= 0) Every booking must have a valid non-negative total price
CHECK (check_out_date > check_in_date) The check-out date must be after the check-in date
user_id ON DELETE RESTRICT A user cannot be deleted if they have existing bookings because booking history should be preserved
property_id ON DELETE RESTRICT A property cannot be deleted if it has existing bookings because booking history should be preserved

Property Entity
property_id (primary_key) Every property needs a unique identifier
host_id (foreign_key) NOT NULL Every property must belong to a valid host
title NOT NULL Every property must have a title
address NOT NULL Every property must have an address
property_type NOT NULL Every property must specify its type, such as house or apartment
price_per_night NOT NULL Every property must have a rental price
price_per_night CHECK (price_per_night > 0) The rental price must be greater than zero
host_id ON DELETE CASCADE If a host is deleted, their property listings will also be deleted because the properties are associated with that host

User_fav_pro
user_id (foreign_key) NOT NULL Every favorite must belong to a valid user
property_id (foreign_key) NOT NULL Every favorite must be associated with a valid property
date_added NOT NULL Every favorite must record when the property was added to the user's favorites
(user_id, property_id) (primary_key) The combination makes user that a user cannot add the same property to their favorites more than once
user_id ON DELETE CASCADE If a user is deleted, their favorite records should also be deleted
property_id ON DELETE CASCADE If a property is deleted, its favorite records should also be deleted because the property no longer exists