#**NBA Player Stats ETL Project**
Welcome to the NBA Player Stats ETL Project! This project focuses on web scraping NBA player statistics, transforming the data, and loading it into an MSSQL server. The goal is to automate the process of retrieving up-to-date player stats, clean and transform the data for analysis, and store it in a database for easy access.

The project follows an ETL (Extract, Transform, Load) pipeline to:

1. **Extract** NBA player stats using Selenium for web scraping.
2. **Transform** the data using Pandas and Numpy to clean and format the data.
3. **Load** the transformed data into an MSSQL Server database using pyodbc.

Throughout the process, the logging library is used to log each step of the ETL pipeline, providing insights and tracking for every operation.

![flowchart](https://github.com/user-attachments/assets/bf1854c1-1788-44f4-8aca-788367a86aeb)
