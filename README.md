# -ex603-rental-marketplace-database

## **Project Title**: Property Rental Marketplace

## **Summary**: This project is a rental marketplace where users can browse available properties, make bookings, and save properties to their favorites
## **Theme**:Rental Market Place

## **Domain**
### This project is a rental marketplace where users can browse available rental properties, make bookings, and save properties to their favorites. Hosts can list properties for users to view and rent. The database will store information about users, hosts, properties, bookings, and favorites.

### The platform should be able to answer questions such as which properties are available for rent, which properties belong to a specific host, which properties a user has saved as favorites, and which properties a user has booked. It should also provide information about each property, such as its location and rental price.



## Unit 4 – Query Catalogue

### Unit 4.1 – Aggregate Queries (`q4_1.sql`)

| Query | SQL Concept | Business Question | SQL Reference |
|---|---|---|---|
| 1 | Aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) | How many viewing events and unique renters are there across the platform, and what are the total, average, shortest, and longest viewing durations? | [View SQL](q4_1.sql#L3-L10) |
| 2 | `GROUP BY`, `LEFT JOIN` | How many viewing events does each property have, and what is its average viewing duration, including properties with no viewings? | [View SQL](q4_1.sql#L15-L25) |
| 3 | `GROUP BY`, `HAVING` | Which properties have at least five viewing events, and what are their average viewing durations? | [View SQL](q4_1.sql#L30-L42) |
| 4 | Multi-dimensional grouping | How do viewing counts, durations, and unique renter counts vary by city and property? | [View SQL](q4_1.sql#L50-L69) |

### Unit 4.2 – Advanced Aggregation Queries (`q4_2.sql`)

| Query | SQL Concept | Business Question | SQL Reference |
|---|---|---|---|
| Part A | Conditional aggregation (`CASE WHEN`) | How many viewing events and failed events (cancelled or disputed) does each property have? | [View SQL](q4_2.sql#L2-L19) |
| Part B | `GROUPING SETS` | How many total and failed viewing events occur in each city, and how do these regional subtotals compare with the platform-wide grand total? | [View SQL](q4_2.sql#L22-L45) |
| Part C | Common Table Expression (`WITH`) | What is the average property failure rate among properties with at least five viewing events? | [View SQL](q4_2.sql#L56-L69) |