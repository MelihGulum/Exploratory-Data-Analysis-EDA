# Time Series Analysis and Predictive Modeling
This project delivers a comprehensive time series analysis and forecasting framework for USD/TRY exchange rates, using advanced statistical techniques and predictive modeling.

**Key Highlights**
* **Statistical Tests & Diagnostics:** Stationarity checks (ADF, KPSS), trend analysis (Hodrick-Prescott filter), and Kruskal-Wallis tests for median differences.
* **Exploratory Data Analysis (EDA)**: STL Decomposition for trend and seasonality, and insights on price trends, moving averages, and volatility metrics.
* **Predictive Modeling**: ARIMA and SARIMA models with optimized parameters, validated using TimeSeriesSplit and cross-validation.
* **Model Comparison**: In-depth evaluation with Ljung-Box tests and confidence interval visualizations for reliable forecasts.
* **Backtesting & Performance**: Rolling-window backtesting to assess model stability (ARIMA) and trend sensitivity (SARIMA), highlighting key trade-offs in forecasting.

This project is ideal for anyone looking to apply rigorous time series forecasting methods to real-world financial data, blending data analysis with advanced model evaluation.

## **1. Project Structure**
This project is divided into two main notebooks for clarity and modularity:

1. Time Series Data Analysis and Preparation - Covers data retrieval, preprocessing, and exploratory analysis.
2. Time Series Predictive Modeling and Forecasting - Focuses on model selection, hyperparameter tuning, and performance comparison between ARIMA and SARIMA.

## **2. About The Dataset**
The dataset consists of daily USD/TRY exchange rate data retrieved from Yahoo Finance. This dataset includes key price metrics like:

* Open, High, Low, Close prices
* Volume of trades
* Adjusted Close for split or dividend-adjusted prices

## **3. Data Preprocessing**
* **Date Parsing and Feature Engineering:** Extracted features like month, day, year, and seasonal flags to capture temporal trends.
* **Technical Indicators:** Included moving averages (SMA_20, SMA_50) to identify short and long-term trends.
* **Missing Value Handling:** Addressed missing data by custom imputation methods to avoid distortions, particularly for moving averages.

## **4. Exploratory Data Analysis (EDA)**
The analysis notebook dives into a detailed EDA of the dataset to understand the underlying trends, seasonality, and volatility of USD/TRY exchange rates. Key visualizations include:

* **Yearly and Monthly Price Analysis:** Visualizes long-term and short-term patterns in exchange rates.
* **Moving Averages and Price Differences:** Highlights volatility and trend strength over time.
* **High-Low and Close-Open Price Comparisons:** Explores the daily range and fluctuations.
* **STL Decomposition:** Breaks down the series into trend, seasonal, and residual components to capture periodic patterns in the data.

## **5. Data Diagnostics and Statistical Tests**
Before modeling, several statistical tests were applied to assess stationarity, seasonality, and trend, helping in informed model selection:

* **Augmented Dickey-Fuller (ADF) Test**: Assesses the stationarity of the series.
* **Kwiatkowski-Phillips-Schmidt-Shin (KPSS) Test**: Provides a complementary stationarity check.
* **Kruskal-Wallis Test**: Determines the significance of observed seasonal differences.
* **Hodrick-Prescott (HP) Filter**: Separates the cyclical component from the trend for deeper insights into macroeconomic cycles.

## **6. Predictive Modeling**
The predictive modeling notebook includes detailed steps for implementing ARIMA and SARIMA models, model tuning, and comparative analysis.

#### **Modeling Steps**
1. **Time Series Cross-Validation**: Used TimeSeriesSplit to evaluate model performance with a cross-validation approach specific to time series data.
2. **ARIMA Modeling:**
    * **Hyperparameter Tuning**: Selected optimal (p, d, q) values based on ACF/PACF plots and Akaike Information Criterion (AIC).
    * **Evaluation**: Included detailed evaluation metrics like Mean Absolute Error (MAE) and Root Mean Squared Error (RMSE).
3. **SARIMA Modeling**:
    * **Seasonal Order Selection**: Experimented with seasonal order parameters (P, D, Q, s) to capture seasonality in the data.
    * **Optimized Model**: Chose the model configuration that minimized AIC while balancing performance.

## **7. Model Comparison**
A comprehensive comparison between ARIMA and SARIMA models was conducted to understand their forecasting effectiveness. Key elements of the comparison:

* **Training Set Predictions**: Visualized in-sample predictions to check model fit.
* **Out-of-Sample Forecasting (30-Day)**: Compared 30-day forecasts for both models, including confidence intervals.
* **Ljung-Box Test**: Performed residual diagnostics to validate model assumptions.
* **Forecast Accuracy Metrics**: Compared MAE, RMSE, and Mean Absolute Percentage Error (MAPE) to assess model performance.

## **8. Conclusion and Future Work**
The project concluded with several key insights:

* ARIMA proved effective for conservative forecasting, performing well with stable market trends.
* SARIMA offered flexibility with seasonality but sometimes exhibited trend overfitting, suitable for capturing periodic fluctuations.

#### **Future Directions**
* Expand Data Sources: Integrate other economic indicators or currency pairs to enhance predictive accuracy.
* Experiment with Advanced Models: Implement machine learning or deep learning approaches (e.g., LSTM, Prophet) for potential accuracy gains.
* Extend Backtesting: Apply more sophisticated backtesting techniques for enhanced validation.

## **9.Summary**
This project provides a complete pipeline for analyzing and forecasting USD/TRY exchange rates using time series techniques. Through rigorous diagnostics, ARIMA and SARIMA models were tested and compared, providing a robust framework for exchange rate prediction. Future improvements could leverage additional data and advanced modeling techniques to build on these findings.
