
# Clustering Techniques Project

This project is an exploration of several clustering algorithms applied to a structured dataset. The focus is on comparing performance, evaluating different clustering methods, and analyzing their results. This project employs a variety of evaluation metrics and visualization techniques to gain deeper insights into the clustering results.

## **About the Dataset**
The [dataset](https://www.kaggle.com/datasets/vjchoudhary7/customer-segmentation-tutorial-in-python) used in this project contains numerical and categorical features suitable for unsupervised learning. After preprocessing, the data is ready for application of clustering techniques, including dimensionality reduction and noise handling.

## **Project Overview**
This project involves extensive analysis of clustering techniques, from data exploration to advanced feature engineering. We utilize different clustering algorithms and compare their performance using key metrics. Visual and statistical methods are employed to evaluate and compare the quality of clusters formed by each algorithm.

### **Table of Contents 📃**
1. **Import and Read the Dataset**
2. **EDA (Exploratory Data Analysis)**
    - **Rename the Columns**
    - **Numerical EDA**
    - **Visual EDA**
        - **Univariate Analysis**
        - **Bivariate Analysis**
        - **Multivariate Analysis**
3. **Feature Engineering** 
    - **Dimensionality Reduction with PCA:** Reducing the number of features using Principal Component Analysis for easier visualization and better clustering results.
     - **Feature Scaling:** Standardizing features to ensure algorithms perform optimally.
4. **Clustering Techniques**
- **Helper Functions for Identifying the Number of Clusters:**
    - **KElbow Method:** Used to identify the optimal number of clusters for algorithms like KMeans.
    - **Silhouette Score:** Measures how similar a point is to its own cluster compared to others.
    - **Davies-Bouldin (DB) Score:** Measures intra-cluster similarity and inter-cluster separation.
    - **Calinski-Harabasz (CH) Score:** Evaluates the ratio between within-cluster dispersion and between-cluster separation.
- **Clustering Algorithms:**
    - **KMeans:** Applied with different cluster sizes and evaluated using Elbow Method, Silhouette Score, CH Score, and DB Score.
    - **KMeans with PCA:** KMeans applied on PCA-reduced data to enhance interpretability.
    - **Hierarchical Clustering:** Built dendrograms to explore hierarchical relationships among clusters.
    - **DBSCAN:** Effective for handling noisy data points and detecting varying densities of clusters.
    - **Affinity Propagation:** A dynamic clustering algorithm that identifies clusters without pre-specifying the number of clusters.
    - **Mean Shift:** Detects modes in the feature space to create clusters.
    - **OPTICS:** An extension of DBSCAN that handles varying densities and produces better separation of clusters in complex datasets.
5. **Conclusion**
- Comparison of algorithms using scatter plots of clusters and performance metrics (Silhouette, DB, and CH Scores).
- Clusters’ value counts and their statistical values using descriptive statistics.

## **Key Insights**
- **Evaluation Metrics:**
    - A combination of **KElbow Method**, **Silhouette Score**, **Davies-Bouldin Score**, and **Calinski-Harabasz Score** were used to evaluate and compare cluster quality across different algorithms.
    - These metrics provided comprehensive insights into how well-separated and compact the clusters were, ensuring a robust evaluation process.
- **Dimensionality Reduction and PCA:**
    - **PCA** was applied to reduce the feature space, simplifying the data while maintaining the structure for clustering. This also helped in visualizing the clusters effectively.
- **Algorithm Comparison:**
    - KMeans and Hierarchical Clustering offered good performance for more defined, spherical clusters.
    - DBSCAN and OPTICS excelled in handling noise and clusters of varying densities, while Affinity Propagation provided flexibility by determining the number of clusters automatically.
- **Statistical Analysis:**
    - Descriptive statistics (like mean, standard deviation, and quartiles) were computed for each cluster to better understand their characteristics.

## **Conclusion**
This project compared multiple clustering algorithms on a dataset using various evaluation metrics. The following key takeaways were identified:

- **Scatter Plot Comparison:** Scatter plots were used to visually compare clusters across algorithms. These visualizations revealed differences in cluster compactness and separation.
- **Metrics Comparison:** The performance of each algorithm was evaluated using Silhouette, DB, and CH Scores. KMeans and Hierarchical Clustering showed strong performance for well-separated clusters, while DBSCAN and OPTICS were better suited for complex, noisy datasets.
- **Cluster Value Counts and Statistical Analysis:** The clusters' value counts were computed, along with their statistical summaries using describe(). This helped provide a more in-depth understanding of the internal structure of each cluster.

This analysis highlights how different clustering techniques can offer distinct insights depending on the nature of the dataset, and the importance of using multiple metrics and visualization methods for a comprehensive clustering evaluation.