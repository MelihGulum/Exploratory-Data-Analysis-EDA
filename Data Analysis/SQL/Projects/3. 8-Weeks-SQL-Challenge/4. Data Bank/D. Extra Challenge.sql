/*
    Data Bank wants to try another option which is a bit more difficult to implement 
        - they want to calculate data growth using an interest calculation, just like in a traditional savings account you might have with a bank.

    If the annual interest rate is set at 6% and the Data Bank team wants to reward its customers 
	by increasing their data allocation based off the interest calculated on a daily basis at the end of each day, 
	how much data would be required for this option on a monthly basis?

    Special notes:
    Data Bank wants an initial calculation which does not allow for compounding interest,
	however they may also be interested in a daily compounding interest calculation so you can try to perform this calculation if you have the stamina!
*/


WITH day_cal_cte AS(SELECT customer_id,
                           txn_date,
                           txn_amount,
                           DATETRUNC(month, txn_date) AS month_start_date,
                           DAY(EOMONTH(DATETRUNC(month, txn_date))) AS days_in_month,
                           DAY(EOMONTH(DATETRUNC(month, txn_date))) - DAY(txn_date) AS Day_interval
                    FROM customer_transactions
                    WHERE txn_type = 'deposit'
                    GROUP BY customer_id,
                            txn_date,
                            txn_amount
                    ),
     interest_cte AS(SELECT customer_id,
                            txn_date,
                            ROUND(txn_amount * (0.06 / 365) * Day_interval, 2) AS daily_interest_data
                     FROM day_cal_cte
                     GROUP BY customer_id,
                              txn_date,
                              Day_interval,
                              txn_amount
                     )
SELECT MONTH(txn_date) AS txn_month,
       ROUND(CAST(SUM(daily_interest_data) AS FLOAT), 2) AS monthly_data_required
FROM interest_cte
GROUP BY MONTH(txn_date)
ORDER BY MONTH(txn_date);