## Task 5.4: Write Your Recommendations
### The memo

**Properties with frequent unsuccessful viewings:** Leadership should investigate why scheduled viewings are being cancelled or not completed. They could contact property owners to identify scheduling issues, improve communication with renters, and introduce appointment reminders to reduce unsuccessful viewings.

**Properties with no viewing activity:** Leadership should focus on attracting initial renter interest rather than fixing viewing failures. They could review rental prices, improve property photos and descriptions, and promote these listings to increase visibility.

### Reflection

As the rental marketplace grows, changes in table sizes, indexes, and the number of matching records could cause PostgreSQL to choose different join algorithms.

For example, if the `viewings` table grows from 200 records to millions, PostgreSQL might prefer a **Hash Join** instead of a Nested Loop because it could be more efficient when processing large numbers of matching records. Adding indexes on `viewings.property_id` or `viewings.renter_id` could make indexed Nested Loop joins more efficient. A **Merge Join** might also become a better option if both tables are already sorted by their joining columns or can be accessed in sorted order.

Additionally, if fewer viewing records match the `attended` status, an index on `viewing_status` could help PostgreSQL retrieve those records without scanning the entire table. These changes could improve query performance by reducing unnecessary scans and repeated lookups.