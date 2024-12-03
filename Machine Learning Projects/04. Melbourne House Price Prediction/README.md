
# Melbourne Property Price Prediction Project
This project focuses on predicting property prices in Melbourne, Australia. By utilizing exploratory data analysis, feature engineering, and multiple machine learning models, the goal is to accurately predict property prices and understand the key factors influencing them. The final model is optimized using hyperparameter tuning, with the best model saved for future predictions.

## **About the Dataset**
The [dataset](https://www.kaggle.com/datasets/anthonypino/melbourne-housing-market) contains information about property sales in Melbourne, including variables such as property type, location, size, and other features related to the sale. It has missing values, outliers, and some highly correlated variables that need to be handled during preprocessing.

## **Project Contents**
1. **EDA (Exploratory Data Analysis)**: Understand the dataset distribution, variable relationships, and basic statistics.

2. **Feature Engineering**
    - **Feature Extraction:** Extract additional features from existing columns to enrich the dataset.
    - **Dropping High Correlated Variables:** Identify and remove variables that are highly correlated to avoid multicollinearity.
    - **Handling Duplicated Rows:** Ensure data quality by eliminating duplicate entries.
    - **Missing Values Handling:** Handle missing data using appropriate strategies.
    - **Outlier Handling:** Detect and treat outliers to avoid skewed predictions.
    - **Encoding:** Convert categorical variables into numerical formats for model training.
3. **Model Building**
    - **Model Training for Baseline Score:** Train several regression models to establish a baseline score.
    - **Visual Comparison of Model Performances:** Compare the performance of different models using evaluation metrics like MSE and RMSE.
    - **Hyper-parameter Optimization:** Optimize hyperparameters for the best-performing models using grid search or random search.
    - Feature Importance Visualization of Best Model
        - **Feature Importance:** Visualize the most important features for prediction.
        - **Permutation Importance:** Assess the importance of each feature through permutation.
Building and Saving Best Model
The best model is trained and saved for future use.

## **Key Insights**
- **Feature Engineering:** Extracting new features and removing highly correlated variables significantly enhanced model performance.
- **Handling Outliers and Missing Values:** Proper treatment of outliers and imputation of missing values improved model stability and prediction accuracy.
- **Hyperparameter Optimization:** Fine-tuning models using methods like RandomizedSearchCV boosted prediction accuracy, especially for CatBoost.
- **Feature Importance:** Visualizing feature importance and validating through Permutation Importance allowed for a deeper understanding of the model’s decision-making process.
- **Final Model:** CatBoost was selected as the final model due to its excellent accuracy and performance, along with interpretability through SHAP and feature importance plots.

## **Summary**
This project effectively tackled property price prediction using a systematic approach to data preprocessing, feature engineering, and model building. By training multiple machine learning models and conducting hyperparameter optimization, **CatBoost** emerged as the best-performing model. Feature importance and permutation importance were explored to better interpret the model, ensuring the solution was both accurate and interpretable. The final model is robust, generalizes well, and is saved for future use.
