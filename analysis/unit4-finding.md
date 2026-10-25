# Task 4.3

### The overall failure rate for the rental marketplace is 22%, with 44 cancelled or disputed viewings out of 200 total events. Failure rates vary across properties, with some performing much better than others. I would investigate properties 3, 1, and 9 because they have the highest failure rates. I would review their cancellation reasons and disputed viewings to understand what is causing these differences and whether improvements are needed.

## Reflection
### Conditional aggregation calculates total events and failed events in a single query, but separate queries calculate them individually. With a massive number of rows, conditional aggregation can be more efficient because the database can process the data in one scan instead of scanning it multiple times. This reduces unnecessary processing and can improve query performance, especially with large datasets.