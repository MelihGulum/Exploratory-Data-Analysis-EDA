-- Q1. How would you calculate the rate of growth for Foodie-Fi?
WITH monthly_revenue_2020 AS (SELECT MONTH(payment_date) AS months,
                                     SUM(amount) AS revenue
                              FROM payments_2020
                              GROUP BY MONTH(payment_date)
                              )
SELECT months,
       revenue,
       (revenue-LAG(revenue) OVER(ORDER BY months)) / revenue AS revenue_growth
FROM monthly_revenue_2020;


-- Q2. What key metrics would you recommend Foodie-Fi management to track over time to assess performance of their overall business?
--         Monthly revenue growth: How does Foodie-Fi's revenue increase or decrease by monthly? 
--             Are there any months that the number of customers increasing significantly?
--         Customers growth: How many customers increase by monthly? How does the rate look like (x1.5, x2,... after each month)?
--         Conversion rate: How many customers keep using Foodie-Fi after trial? How does the rate look like (x1.5, x2,...after each month)?
--         Churn rate: How many customers cancel the subscription by monthly? What plan they has used?


-- Q3. What are some key customer journeys or experiences that you would analyse further to improve customer retention?
/*
           Customers who downgraded their plan
           Customers who upgraded from basic monthly to pro monthly or pro annual
           Customers who cancelled the subscription
*/


-- Q4. If the Foodie-Fi team were to create an exit survey shown to customers who wish to cancel their subscription, 
/*         What questions would you include in the survey?
           What is the primary reason for the cancellation?
               - Price
               - Techinical issues
                - Customer support
                - Found an alternative
                - Others (please specify)
            Overall, how satisfied were you with the subscription? (Likert scale: Very Satisfied - Very Unsatisfied)
            Would you consider using our services in the future? (Likert scale: Very Satisfied - Very Unsatisfied)
            Would you recommend our company to a colleague, friend or family member? (Likert scale: Very Satisfied - Very Unsatisfied)
*/

-- Q5. What business levers could the Foodie-Fi team use to reduce the customer churn rate? How would you validate the effectiveness of your ideas?
/*         From the exit survey, look for the most common reasons why customers cancelled the subscription
               - Price: increase the number of discounts in some seasons of a year, extend the trial time, or add more benefits to customers
               - Service quality: work with the relevant department to fix the issue
               - Found an alternative: do some competitor analysis to see their competitive advantages over us
           To validate the effectiveness of those ideas, check:
               - Churn rate
               - Conversion rate
*/ 
