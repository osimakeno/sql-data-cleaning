SQL Data Cleaning and Transformation for Layoffs Dataset

Overview

This SQL script demonstrates the process of cleaning and transforming data from a layoffs table to ensure data accuracy, standardization, and usability. The cleaning process includes removing duplicates, handling null values, standardizing formats, and creating a sandbox environment for safe manipulation of the data.

Steps Performed

1. Create a Sandbox Table
	•	A sandbox table, layoffs_sandbox, is created as an exact replica of the original layoffs table.
	•	Data from the original table is inserted into the sandbox for manipulation, preserving the integrity of the raw data.

2. Removing Duplicate Records
	•	Identify Duplicate Rows: A ROW_NUMBER() function is used with the OVER() clause to identify duplicate rows based on specific columns (company, industry, total_laid_off, etc.).
	•	Create a Table to Handle Duplicates: A new table, layoffs_sandbox2, is created with an additional column (row_num) to flag duplicates.
	•	Remove Duplicates: Rows where row_num > 1 are deleted to retain only the first occurrence of each duplicate.

3. Standardizing Data
	•	Trim Whitespace: Leading and trailing spaces from the company column are removed using the TRIM() function.
	•	Format Dates: The date column is updated to a proper DATE data type to ensure consistent formatting.

4. Handling Null or Blank Values
	•	Rows with null values in critical columns (total_laid_off and percentage_laid_off) are identified and removed.

5. Remove Unnecessary Columns
	•	The row_num column, used temporarily to identify duplicates, is dropped from the final dataset.

Key SQL Concepts Used
	•	Sandboxing: Working with a duplicate table (layoffs_sandbox) ensures raw data remains unaffected.
	•	Window Functions: The ROW_NUMBER() function is used to detect duplicate rows.
	•	CTE (Common Table Expression): Used for better readability when identifying duplicates.
	•	Data Standardization: Formatting columns for consistency (e.g., trimming text, converting date formats).
	•	Null Handling: Identifying and deleting rows with incomplete data.

Final Result

The cleaned and standardized dataset is stored in the layoffs_sandbox2 table, ensuring:
	1.	No duplicate records.
	2.	Standardized data formats.
	3.	Removal of unnecessary and null data.
	4.	Preservation of raw data integrity.
