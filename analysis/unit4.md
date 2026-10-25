## For Rental Marketplace dataset I am considering:
- Producer: properties
- Event table: viewings
- Metric: duration_min
- Relationship: property_id


# Task 4.1 
## 1
### The dataset allows duration_min >= 0, so a minimum of zero is possible.

### If the query returns min_duration = 0, investigate whether those records represent canceled viewings, no-shows, or incorrect duration values.

## 2
### Properties with higher event counts attract more viewing activity, suggesting greater renter interest. Properties with longer average viewing durations may indicate that renters spend more time evaluating them.

## 3
### Why I chose 5 events
### I selected a threshold of 5 viewings because properties with fewer events may not have enough data for a meaningful comparison. Requiring at least five viewings reduces the influence of individual events on the average duration.

### However, five events is only a practical starting threshold, not a guarantee of statistical reliability. A higher threshold, such as 10 or 20, would provide more stable estimates if enough properties qualify.

## Write up
### In /analysis/unit4.md: Name the person who would act on the per-producer breakdown, and say what the aggregate hides — an average conceals its distribution, a count conceals who is counted. What would you need to see next?

### The Producers are properties. **A property manager** or regional rental manager would use the results to identify properties receiving fewer viewings or showing lower renter engagement.
### The query calculates COUNT() and AVG(), but these aggregate functions don't tell the whole story.

### For example:
### - Average hides distribution: A property might have an average viewing duration of 30 minutes, but some renters may spend only 5 minutes while others spend 55 minutes.The average doesn't show this variation.
### - Count hides who is counted: A property might have 20 viewing events, but those could come from 20 different renters or just 5 renters who scheduled multiple viewings.

### To better understand property performance, I would see the distribution of viewing durations, the number of unique renters, viewing statuses, and interest scores.


# Task 4.2
## Write up
### For Part A, state the two questions your conditional aggregation answers side by side.

### **Total Events (COUNT)	Failed Events (SUM(CASE))**
### How many total viewing events did each property have?	How many of those viewing events were cancelled or disputed?

### For Part B, name the reader who needs subtotals rather than detail rows, and say what decision the grand total supports that the group rows do not.

### The regional director needs subtotals rather than individual property details. The grand total provides an overall picture of performance and helps leadership decide whether failures are a platform-wide issue requiring broader action or are concentrated in specific regions.

### -- Note:
### -- The rows showing  cities represent regional subtotals, summarizing the total number of viewing events and failed events within each region. The row labeled "Platform Total" represents the grand total across all regions.  property-level detail rows are excluded, which lets the regional director to compare overall activity and failures by region and across the entire data set.



### For Part C, state the question the pipeline answers.

### With in 5 viewing events, What is the average failure rate among high-volume properties in the rental marketplace?