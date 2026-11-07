## Task 5.1

### **What feature or report on your platform could use the three-table join from Question 1? What information would it display?**
A Property Viewing History Report could use the three-table join to display which renters viewed specific properties and when those viewings occurred. The report would include the renter's name, property name, viewing date and time, and could also show the viewing status. This would help property managers track viewing activity and understand which properties are attracting more interest.


### **Why is the junction table important for answering Question 2? What would make this analysis more difficult without it?**
 The listing_amenities junction table is important because it manages the many-to-many relationship between properties and amenities. A property can have multiple amenities, such as parking, a gym, or a pool, and the same amenity can belong to multiple properties.

 Without the junction table, it would be difficult to efficiently identify properties that share certain amenities. We might need to store multiple amenities in a single column or create separate columns for each amenity, making the database harder to maintain and the queries more complicated.

## Task 5.2

### **1. Which producers were excluded by the INNER JOIN?**
   The INNER JOIN excluded 2 properties because they had no matching viewing records.
   Property ID	Property Name
   14	Property_14
   15	Property_15

### **2. What does it mean when a producer has no events? What are some possible explanations?**
    A property with no events means that no viewing activities have been recorded for that property. Possible explanations include low renter interest, limited visibility on the platform, uncompetitive rental prices, or the property being newly listed.
### **3. How could a report based only on an INNER JOIN give leadership an incomplete picture of the platform?**
   A report based only on an INNER JOIN would exclude properties without viewing activities. This could give leadership an incomplete picture by making it appear that all listed properties are receiving interest, while hiding properties that may need attention or improvement.
### **4. Why might leadership want to identify producers who have never been active?**
    Leadership might want to identify properties with no viewing activities to understand why they are not attracting renters. This could help identify issues with pricing, property descriptions, marketing, or overall demand.
### **5. What action could leadership take based on these findings?**
   Leadership could investigate why these properties have no viewing activity and take steps to improve their visibility. For example, they could recommend adjusting rental prices, improving listing descriptions and photos, or promoting these properties to attract more potential renters.


## Task 5.3: Understand Join Performance and Execution Plans

### 1. When could a Cartesian product be useful on the platform?

On the rental marketplace, a `CROSS JOIN` between `properties` and `amenities` could generate every possible property–amenity combination. This could be useful for reviewing which amenities each property might offer or for checking potential gaps in listing information.

With 15 properties and 5 amenities, the result would contain **15 × 5 = 75 combinations**. These are possible combinations, not necessarily amenities that a property actually has.

### 2. Which join algorithms did PostgreSQL choose?

PostgreSQL chose **Nested Loop** and **Hash Join** for my three-table query:

- **Nested Loop:** Joined the 156 attended viewing records with properties using the `properties_pkey` index.
- **Hash Join:** Matched the results with renters using `renter_id`.

The execution plan also included Sequential Scans, Memoize, and HashAggregate operations.

### 3. What information in the execution plan helps explain those choices?

The execution plan shows:

- The Sequential Scan examined **200 viewing records**, filtered out 44, and returned 156 attended viewings.
- The Nested Loop used the `properties_pkey` index to retrieve matching properties.
- Memoize recorded **143 cache hits** and **13 misses**, reducing repeated property lookups.
- The Hash Join used a small hash table containing **30 renters**, consuming only **10 kB** of memory.
- HashAggregate returned **156 rows**, using **48 kB** of memory.
- Total execution time was **0.948 ms**.

These observations suggest PostgreSQL selected these algorithms because the tables were relatively small, making indexed lookups and hash-based joins efficient.

### 4. Why is it useful to understand the selected join algorithms?

Understanding join algorithms helps identify performance bottlenecks and determine how queries might behave as the dataset grows.

For example, the execution plan shows that PostgreSQL scans all viewing records to filter attended events. Knowing this can help developers decide whether adding indexes or optimizing queries could improve performance.

### 5. What changes might make another join algorithm more appropriate?

As the rental marketplace grows, the `viewings` table could contain thousands or millions of records.

With larger datasets, PostgreSQL might prefer a **Hash Join** instead of repeated Nested Loop lookups. A **Merge Join** might also become appropriate if the joining records are already sorted or can be efficiently accessed in order.

Adding suitable indexes, changing data distribution, or increasing table sizes could influence PostgreSQL's choice of execution algorithm.


### Reflection

As the rental marketplace grows, changes in table sizes, indexes, and the number of matching records could cause PostgreSQL to choose different join algorithms.

For example, if the `viewings` table grows from 200 records to millions, PostgreSQL might prefer a **Hash Join** instead of a Nested Loop because it could be more efficient when processing large numbers of matching records. Adding indexes on `viewings.property_id` or `viewings.renter_id` could make indexed Nested Loop joins more efficient. A **Merge Join** might also become a better option if both tables are already sorted by their joining columns or can be accessed in sorted order.

Additionally, if fewer viewing records match the `attended` status, an index on `viewing_status` could help PostgreSQL retrieve those records without scanning the entire table. These changes could improve query performance by reducing unnecessary scans and repeated lookups.