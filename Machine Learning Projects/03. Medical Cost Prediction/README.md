
# Medical Cost Prediction Project

This project aims to predict medical insurance costs based on various factors such as age, sex, BMI, children, smoking habits, and region. The notebook explores the dataset through detailed exploratory data analysis (EDA), feature engineering, and builds machine learning models using optimized hyperparameters to accurately predict medical costs. The final model is selected based on performance metrics, and the feature importance is examined using SHAP values.

## **📊 About the Dataset**
The [dataset](https://www.kaggle.com/datasets/mirichoi0218/insurance) used in this project contains medical insurance cost data for individuals. It includes the following features:

- **age:** Age of the individual.
- **sex:** Gender of the individual.
- **bmi:** Body Mass Index (BMI), a measure of body fat based on height and weight.
- **children:** Number of children/dependents covered by the insurance plan.
- **smoker:** Whether the individual is a smoker or not.
- **region:** The individual's residential region in the United States.
- **charges:** The medical insurance cost charged to the individual (target variable).
This dataset allows us to explore how various factors like age, BMI, smoking habits, and region contribute to medical insurance costs. It is particularly useful for regression tasks, as we aim to predict the charges based on the other features.

## **📄 Project Contents**
1. **EDA (Exploratory Data Analysis)**
    - A thorough examination of the dataset for understanding key insights and identifying patterns.

2. **Data Visualization**: Visualization of both univariate and bivariate relationships.

    - Uni-variate Analysis
        - Categorical and numerical features.
    - Bi-variate Analysis
        - Categorical vs. target.
        - Numerical vs. target.
3. **Feature Engineering**
    - Handling missing values.
    - Outlier detection and treatment.
    - Extracting new features to enhance predictive performance.
    - Encoding categorical features and scaling numerical ones.
4. **Model Building**
    - Optuna Hyperparameter Optimization applied to key models such as LGBM, XGBoost, and CatBoost.
    - Training various algorithms, including GradientBoosting, RandomForest, DecisionTree, LinearRegression, and more.

5. **Model Evaluation**
    - Models were evaluated using various metrics, such as:
        - Mean Squared Error (MSE) and Root Mean Squared Error (RMSE) on both train and test sets.
        - R2 score to check how well the model fits the data.
        - Cross-validation to assess model stability.
The evaluation revealed strong performance across all models, with the final models producing low error rates and high R2 scores.

6. **Model Performance Visualization**
    - A visual comparison of model performances using train and test MSE, RMSE, and R2 scores was conducted. This helped in understanding how well each model generalizes to unseen data.
7. **Final Model Selection**
    - The **GradientBoostingRegressor** was selected as the final model due to its superior performance on test data. This model provided the best trade-off between accuracy and interpretability, ensuring robust and explainable predictions.
8. **Final Model: SHAP Feature Importance**
    - **Feature Importance using SHAP:** The SHAP values were used to interpret the final model's predictions and to rank feature importance, identifying the key drivers behind medical cost predictions.
    - **Save Final Model:** The final optimized model was saved for future use.

## **🔍 Key Insights**
- The **GradientBoostingRegressor** performed the best among all models in terms of predictive accuracy, with the lowest RMSE and highest R2 score.
- Features such as **smoking status**, **BMI**, and **age** significantly impacted medical cost predictions, as revealed by SHAP values.
- Optuna's hyperparameter optimization improved model performance for LGBM, XGBoost, and CatBoost, though GradientBoostingRegressor was ultimately more stable.

## **📌 Summary**
This project delves into predicting medical costs using various machine learning algorithms, with an emphasis on feature engineering and model optimization. Several models were trained and evaluated, including GradientBoosting, RandomForest, and LinearRegression, with GradientBoostingRegressor emerging as the best performer. Hyperparameter tuning via Optuna improved key models, and SHAP analysis provided insights into feature importance, confirming that factors like smoking status, BMI, and age have significant predictive power. The final model was saved for deployment, showcasing a complete workflow from exploratory data analysis to final model selection and evaluation.