# 🛒 Blinkit Sales Analysis – SQL Project (PostgreSQL)

# 📌 Project Overview

This project focuses on analyzing **Blinkit sales data** using **PostgreSQL**.
The goal is to transform raw sales data into **meaningful business insights** by performing **data cleaning, preparation, 
and structured SQL analysis**.

The project follows a real-world analytics workflow:

1. Data understanding
2. Data cleaning & preparation
3. Business analysis (overall + granular)
___________________________________________________________________________________________________________________________________

# 🗄️ Database & Tools Used

* **Database:** PostgreSQL
* **Tool:** pgAdmin
* **Language:** SQL
* **Dataset:** Blinkit sales dataset (single fact table)
___________________________________________________________________________________________________________________________________

# 📂 Dataset Overview

The dataset contains transactional and outlet-level information, including:

* Product attributes (item type, fat content)
* Sales values
* Customer ratings
* Outlet details (size, type, location, establishment year)
___________________________________________________________________________________________________________________________________

# 🧱 Table Used

## `blinkit`

Key columns used:

* `totalsales`
* `rating`
* `itemfatcontent`
* `itemtype`
* `outletlocationtype`
* `outletsize`
* `outlettype`
* `outletestablishyear`
____________________________________________________________________________________________________________________________________

# 🧹 Data Cleaning & Preparation (IMPORTANT STEP)

Before performing any analysis, the dataset was **reviewed and prepared** to ensure accurate results.

# Data Cleaning Actions Performed

* Checked for **NULL or missing values** in critical columns such as:

  * `totalsales`
  * `rating`
  * categorical fields
* Ensured **numeric consistency** for sales-related columns
* Standardized **categorical values** (e.g., fat content, outlet size, outlet type)
* Verified that:

  * Sales values are non-negative
  * Ratings fall within a valid range
* Removed formatting issues that could affect aggregations

📌 Purpose:
To ensure that all aggregations, averages, and percentages are based on **clean and reliable data**.
___________________________________________________________________________________________________________________________________

# 🔍 Analysis Approach (Step-by-Step)

# Step 1: Overall Business Performance**

High-level metrics to understand overall performance:

* Total revenue generated
* Revenue formatted in **INR Lakhs**
* Average revenue per sale
* Total number of items sold
* Average customer rating

# 📌 Insight Goal:
Measure overall business health and customer satisfaction.
____________________________________________________________________________________________________________________________________

# Step 2: Sales Analysis by Fat Content**

* Total sales grouped by fat content
* For **2022**, analyze:

  * Total sales
  * Average sales
  * Number of sales
  * Average rating

# 📌 Insight Goal:
Understand customer preference based on fat content.
_____________________________________________________________________________________________________________________________________

# Step 3: Sales Analysis by Item Type**

* Total sales by item type
* **Top 5 item types** analysis for the year 2020
* Metrics analyzed:

  * Total sales
  * Average sales
  * Number of items sold
  * Average rating

# 📌 Insight Goal:
Identify top-performing product categories.
_____________________________________________________________________________________________________________________________________

# Step 4: Fat Content Performance by Outlet Location**

* Compare total sales by:

  * Outlet location type
  * Fat content (Low Fat vs Regular)
* Used `CASE` and `COALESCE` for clean conditional aggregation
* Calculated:

  * Total sales
  * Average sales
  * Number of sales
  * Average rating

# 📌 Insight Goal:
Evaluate how product composition performs across outlet locations.
_______________________________________________________________________________________________________________________________________

# Step 5: Sales by Outlet Establishment Year**

* Total sales by outlet establishment year
* Additional metrics:

  * Average sales
  * Number of sales
  * Average rating

# 📌 Insight Goal:
Assess the impact of outlet age on performance.
_________________________________________________________________________________________________________________________________________

# Step 6: Sales Contribution by Outlet Size**

* Total sales by outlet size
* Percentage contribution using **window functions**

# 📌 Insight Goal:
Understand revenue contribution by outlet size.
_________________________________________________________________________________________________________________________________________

# Step 7: Sales by Outlet Location (2022)**

* Geographic sales distribution for 2022
* Metrics analyzed:

  * Total sales
  * Sales percentage
  * Average sales
  * Number of sales
  * Average rating

# 📌 Insight Goal:
Identify high-performing locations in a specific year.
_________________________________________________________________________________________________________________________________________

# Step 8: Key Metrics by Outlet Type**

Final consolidated view:

* Total sales
* Sales percentage
* Average sales
* Number of items sold
* Average rating

# 📌 Insight Goal:
Provide a complete performance snapshot by outlet type.
_________________________________________________________________________________________________________________________________________

# 🛠️ SQL Concepts Used

* Data Cleaning & Validation
* Aggregation (`SUM`, `AVG`, `COUNT`)
* Filtering (`WHERE`)
* Grouping (`GROUP BY`)
* Conditional Aggregation (`CASE WHEN`)
* Window Functions (`OVER()`)
* Formatting (`CAST`, `TO_CHAR`)
* Ordering (`ORDER BY`)
__________________________________________________________________________________________________________________________________________

# 🎯 Key Outcomes

* Clear understanding of revenue drivers
* Product performance insights
* Outlet-level performance comparison
* Business-ready KPIs using SQL
___________________________________________________________________________________________________________________________________________

# ✅ Conclusion

This project demonstrates a **complete SQL analytics workflow**, starting from **data cleaning** and ending with **business insights**.
It reflects real-world data analysis practices and is well-suited for **data analyst and business analyst portfolios**.
____________________________________________________________________________________________________________________________________________
