### 6.1

## 1. Comparing individual events to their group’s average
   Question: Which individual property viewings lasted longer or shorter than the average viewing duration of their respective properties?

Using GROUP BY alone cannot answer this question because it aggregates all viewing records for each property into a single row, losing individual viewing durations and IDs. Using AVG() OVER (PARTITION BY property_id) allows us to retain every viewing record alongside its property's average viewing duration. This makes it possible to identify unusually long or short viewings and investigate potential reasons for those differences.
## 2. Ranking producers and handling ties
   Platform feature: A property popularity leaderboard on a rental platform that ranks properties based on their total number of viewings.

I would use DENSE_RANK() because properties with the same number of viewings should receive the same ranking, regardless of their property ID or position in the dataset. Unlike ROW_NUMBER(), it does not arbitrarily rank one property higher than another when they have equal viewing counts. Unlike RANK(), it does not leave gaps in the ranking sequence.

For example, if two properties have 18 viewings and both rank fourth, the next property would rank fifth rather than sixth. This provides a fair and easy-to-understand leaderboard where properties with equal viewing counts receive equal recognition.


### 6.2

## Write-up
## 1. What would a large delta tell someone about your platform, and what should they do about it?
   A large delta indicates a significant change in viewing duration between two consecutive viewing events for the same property. For example, Property_01 experienced a decrease of 22 minutes between June 22 and June 27, and the latter viewing was marked as disputed. This could indicate renter dissatisfaction, an issue with the property, or a problem with the viewing process. The platform should investigate the viewing status and related records before drawing conclusions about the cause.
## 2. Why does a running total answer a question that a plain SUM cannot?
   A plain SUM() provides the total number of viewing events but does not show how that total was accumulated over time. A running total preserves the chronological progression, allowing leadership to monitor progress toward a target at different points throughout the year. In this dataset, the running total shows how the platform gradually reached 200 viewing events, achieving 80% of its annual target of 250 events.
## 3. Why did you pick your moving-average window size?
   I chose a seven-row moving average because it provides a balance between identifying recent changes in viewing activity and reducing the impact of individual fluctuations. A smaller window would be more sensitive to sudden changes, while a larger window, such as 30 rows, would provide a smoother representation of longer-term trends. However, because the dataset excludes dates without recorded viewing events from the daily aggregation, seven rows do not necessarily represent seven calendar days.
## 4. What does a gap mean in your platform?
   In the rental marketplace, a gap could represent a period of low renter demand, temporary property unavailability, or missing viewing records. For example, Property_09 had approximately 113 days without a recorded viewing before activity resumed. I would classify this as an observed gap in recorded activity with an unconfirmed cause, rather than a confirmed data quality problem or a real stoppage. The dataset does not provide enough evidence to distinguish between these possibilities. Historical property availability records, booking records, and event ingestion logs would need to be examined to determine the actual cause.


### 6.3

## Write-up
## 1. Name the feature in your platform that top-N would power. Explain why three is the right number, rather than one or ten.
   The top-N query could power a Property Viewing Insights feature on the property owner's dashboard, displaying the three longest viewing sessions for each property. This would help property owners identify viewing sessions that may indicate strong renter engagement or require further investigation.

Displaying only one viewing could be misleading because a single event might be an outlier. Displaying ten could overwhelm the property owner with unnecessary information and reduce the usefulness of the feature. Three provides a reasonable balance between presenting meaningful information and keeping the dashboard concise. However, viewing duration alone should not be treated as proof of renter interest and should be considered alongside viewing status and interest scores.
## 2. What would a large month-over-month change mean in your domain, and what should someone do about it?
   A large month-over-month change in the rental marketplace could indicate changes in renter demand, property availability, seasonal trends, marketing effectiveness, or platform reliability. For example, the 47.62% decrease in March could indicate reduced renter engagement or fewer available property listings.

The platform's leadership should investigate the decrease by comparing active listings, cancellation rates, renter registrations, marketing activities, and potential technical issues during that period. Depending on the findings, leadership could increase marketing efforts, improve property recommendations, address technical problems, or encourage property owners to list more properties. The purpose of tracking month-over-month changes is not simply to report fluctuations but to identify areas requiring investigation and actionable improvements.


### Reflection

In my rental marketplace platform, one useful reporting question is: Which property viewings lasted significantly longer or shorter than the average viewing duration of their respective properties? Answering this question could help property owners identify unusual viewing patterns and investigate potential issues in the viewing process.

Using GROUP BY with AVG() would calculate the average viewing duration for each property. However, it would collapse individual viewing records into a single row per property, losing information such as viewing IDs, timestamps, statuses, and individual durations. To compare individual viewings against their property's average, I would need an additional subquery or join.

In contrast, using AVG(duration_min) OVER (PARTITION BY property_id) preserves every viewing record while calculating the average duration for its associated property. This allows me to calculate the difference between each viewing's duration and the property's average directly within the same query.


This exercise helped me understand that window functions are particularly useful when reporting requires both individual records and aggregated information. While GROUP BY is effective for generating summaries, window functions provide greater flexibility for analyzing individual events within the context of their groups.