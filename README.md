# -ex603-rental-marketplace-database

## **Project Title**: Property Rental Marketplace

## **Summary**: This project is a rental marketplace where users can browse available properties, make bookings, and save properties to their favorites
## **Theme**:Rental Market Place

## **Domain**
### This project is a rental marketplace where users can browse available rental properties, make bookings, and save properties to their favorites. Hosts can list properties for users to view and rent. The database will store information about users, hosts, properties, bookings, and favorites.

### The platform should be able to answer questions such as which properties are available for rent, which properties belong to a specific host, which properties a user has saved as favorites, and which properties a user has booked. It should also provide information about each property, such as its location and rental price.



## Unit 4 – Query Catalogue

This section documents the SQL queries developed in Unit 4 for the rental marketplace database and the business questions each query answers.

### Unit 4.1 – Aggregate Queries (`/queries/unit4/q4_1.sql`)

| Query | SQL Concept | Business Question |
|---|---|---|
| Query 1 | Aggregate Functions (COUNT, SUM, AVG, MIN, MAX) | What are the total number of property viewings, total viewing duration, average duration, minimum and maximum duration, and number of unique renters across the platform? |
| Query 2 | GROUP BY | How many viewings does each property receive, and what is the average viewing duration for each property? |
| Query 3 | GROUP BY and HAVING | Which properties have at least five viewings, and what are their average viewing durations? |
| Query 4 | Multi-Dimensional GROUP BY | How do viewing activity, viewing duration, and unique renter counts vary across cities and individual properties? |

### Unit 4.2 – Advanced Aggregation Queries (`/queries/unit4/q4_2.sql`)

| Query | SQL Concept | Business Question |
|---|---|---|
| Part A | Conditional Aggregation (CASE WHEN) | How many total viewing events and failed events (cancelled or disputed) does each property have? |
| Part B | GROUPING SETS | How do total viewing events and failed events compare across regions, and what are the platform-wide totals? |
| Part C | Common Table Expression (WITH) | What is the average property failure rate among properties with at least five viewing events? |
