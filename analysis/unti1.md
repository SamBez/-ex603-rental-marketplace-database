For this rental marketplace database, I created five main tables: User, Host, Property, Booking, and User_Fav_Prp. For User, Host, Property, and Booking, I used an ID as the primary key. For example, user_id uniquely identifies each user and property_id uniquely identifies each property. I chose IDs instead of values such as email or property address because those values could change over time, while an ID can stay the same.

The User_Fav_Prp table is a little different because it connects users and properties. I used both user_id and property_id together as the primary key. This makes sure that a user cannot add the same property to their favorites more than once.

I also used foreign keys to connect the tables. A Host is connected to a User, a Property is connected to a Host, and a Booking is connected to both a User and a Property. The User_Fav_Prp table also connects a User to a Property. These foreign keys make sure that, for example, a booking cannot be created for a user or property that does not exist.

I chose different ON DELETE rules depending on the type of data. For User_Fav_Prp, I used ON DELETE CASCADE. If a user or property is deleted, there is no reason to keep its favorite record. I also used CASCADE between User and Host because a host profile should not exist if its user account is deleted. Properties are also connected to their host using CASCADE, since they are listings created by that host.

For Booking, I used ON DELETE RESTRICT. A user or property should not be deleted when it has existing bookings because booking information may need to be kept as a record of past transactions.

Reflection

One decision I made was to keep User and Host as separate tables. Another designer could choose to have only a User table and add a column that says whether the user is a host.

I chose separate tables because not every user will be a host. Information such as host_since and rating only applies to hosts. If I put those fields in the User table, regular users would have empty values for them.