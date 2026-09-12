Role	Relation schema	Primary key

Schema Definition
Roles
1. User (Actor)
2. Host (Producer)
3. Booking (Event)
4. Property (Catalog)
5. User_Fav_properties (Junction)

Relation Schema
1. User(
   user_id INTEGER, 
   first_name VARCHAR(50), 
   last_name VARCHAR(50), 
    email VARCHAR(100),
    phone VARCHAR(20))
PRIMARY_KEY (user_id)

2. Host(
   host_id INTEGER,
   user_id INTEGER, 
   host_since DATE,
   rating DECIMAL(2,1))
PRIMARY_KEY ( host_id )

3. Booking(
   booking_id INTEGER,
   user_id INTEGER,
   property_id INTEGER,
   check_in_date DATE, 
   check_out_date DATE,
   total_price DECIMAL(10,2))	
PRIMARY_KEY (booking_id )

4. Property(
   property_id INTEGER, 
   host_id INTEGER,
   title VARCHAR(100),
   address VARCHAR(200),
   property_type VARCHAR(30),
   price_per_night DECIMAL(10,2))	
PRIMARY_KEY(property_id)

5. User_Fav_Property( property_id INTEGER, user_id INTEGER )	
PRIMARY_KEY (property_id, user_id)
   