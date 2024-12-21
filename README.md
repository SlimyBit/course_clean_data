# Human Activity Recognition Analysis

## Overview  
This project processes and analyzes the **UCI HAR Dataset**, combining training and test data to create a clean, tidy dataset with descriptive variable names. It extracts only the **mean** and **standard deviation** features, computes averages for each activity and subject, and saves the result as `TidyData.txt`.

---

## How It Works  
1. **Environment Setup**:  
   - Downloads the dataset.  
   - Unzips and sets up the working directory.

2. **Data Loading**:  
   - Loads **subjects**, **activities**, and **features** from the dataset.

3. **Data Merging**:  
   - Combines training and test datasets into a single dataset.

4. **Feature Extraction**:  
   - Extracts columns with `mean` and `std` in their names.  

5. **Renaming Variables**:  
   - Replaces shorthand with descriptive variable names (e.g., `tBody` → `TimeDomainBody`).

6. **Tidy Dataset**:  
   - Calculates averages grouped by activity and subject.  
   - Saves the result as `TidyData.txt`.

---
