# Unit 3 Finding — Rental Marketplace Dashboard


After reviewing the rental marketplace data, I found that the dashboard's viewing calculations may not be showing the complete picture. 
The dataset contains 200 property viewing records, including 156 attended viewings, 34 cancellations, and 10 disputed viewings. Of these 
records, 12 were marked with the reason "Renter no show," while 22 had other cancellation reasons. The remaining 166 records did not have a no-show reason recorded.

The issue comes from how missing information is handled when filtering records. When the dashboard checks for reasons other than "Renter 
no show," it returns only 22 records and leaves out the 166 records with missing reasons. This can make the results misleading because missing 
information is not the same as a confirmed no-show. I also verified the renter information using three different methods, and all three returned
the same 20 renters, confirming that the results were consistent.

I recommend that the dashboard team update the calculations to handle missing information correctly and distinguish cancelled viewings from disputed ones.
The frozen payout should be reviewed against the corrected records before a final decision is made. If the review confirms that the payout was frozen incorrectly,
it should be released. This will help ensure that payout decisions are based on accurate and complete information.