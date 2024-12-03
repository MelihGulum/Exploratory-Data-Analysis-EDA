/* P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

    * 
    * * 
    * * * 
    * * * * 
    * * * * *
   Write a query to print the pattern P(20). */

DECLARE @NUMBER INT = 1;
WHILE(@NUMBER <= 20)
    BEGIN PRINT(REPLICATE('* ', @NUMBER));
    SET @NUMBER = @NUMBER + 1;
END;