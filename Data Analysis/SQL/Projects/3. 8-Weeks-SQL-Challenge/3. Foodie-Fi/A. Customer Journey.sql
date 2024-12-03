-- Q1. Based off the 8 sample customers provided in the sample from the subscriptions table, 
--     write a brief description about each customer’s onboarding journey.

SELECT s.customer_id,
       p.*,
       s.start_date
FROM plans AS p
    JOIN subscriptions AS s
        ON p.plan_id = s.plan_id
WHERE s.customer_id IN (SELECT TOP 8 customer_id
                        FROM subscriptions
                        ORDER BY NEWID()
                        )

/*
    Customers ID's: 97, 202, 297, 483, 643, 644, 815, 852
    Date Format: yyyy/mm/dd
    
	Customer 97:  He/She signed up to 7-day free trial on 2020-10-29. 
                  After that time, he/she didn't cancel the subsciption, so the system automatically upgraded it to basic monthly plan on 2020-11-05.

    Customer 202: He/She signed up to 7-day free trial on 2020-07-01.
                  After that time, he/she upgraded to pro monthly plan on 2020-07-08.

    Customer 297: He/She signed up to 7-day free trial on 2020-08-13.
                  After that time, he/she upgraded to pro monthly plan on 2020-08-20. 
                      He/She continued using that plan for 4 months.
                  On 2020-12-20 (Last day of the 4th month using pro monthly plan), he/she upgraded to pro annual plan.

    Customer 483: He/She signed up to 7-day free trial on 2020-01-12.
                  After that time, he/she didn't cancel the subsciption, so the system automatically upgraded it to basic monthly plan on 2020-01-19.
                      He/she continued using that plan for 6 months.
                  On 2020-07-10 (Towards the end of the 6th month using basic monthly plan), he/she upgraded to pro monthly plan.

    Customer 643: He/She signed up to 7-day free trial on 2020-04-03.
                  After that time, he/she didn't cancel the subsciption, so the system automatically upgraded it to basic monthly plan on 2020-04-10.
                      He/she continued using that plan for 6 months.
                  On 2020-09-17 (still in the 6th month using basic monthly plan), he/she upgraded to pro monthly plan.

    Customer 644: He/She signed up to 7-day free trial on 2020-01-03.
                  After that time, he/she didn't cancel the subsciption, so the system automatically upgraded it to basic monthly plan on 2020-01-10.

    Customer 815: He/She signed up to 7-day free trial on 2020-12-02.
                  After the trial time, he/she upgraded the subscription to pro monthly plan on 2020-12-09.
                  On 2021-01-09 (Last day of the 2nd month using pro monthly plan), he/she upgraded to pro annual plan.

    Customer 852: He/She signed up to 7-day free trial on 2020-03-10.
                  After the trial time, he/she upgraded the subscription to pro monthly plan on 2020-03-10.

*/