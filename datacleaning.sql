-- Data Cleaning
-- 1. Remove duplicate Values.
-- 2. Standardize the Data.
-- 3. Remove Null or Blank Values.
-- 4. Remove Irrelevant Columns


-- Creating a Sandbox data

CREATE TABLE layoffs_sandbox
LIKE layoffs;
    
INSERT layoffs_sandbox
SELECT *
FROM layoffs;
    
    
-- Removing Duplicates
-- looking for duplicate rows
select * 
from layoffs_sandbox2
where row_num > 1;


SELECT *,
    ROW_NUMBER() 
    OVER(PARTITION BY 
					 company,
					 industry,
                     total_laid_off,
                     percentage_laid_off,
                     `date`,
                      stage,
                     country,
                     funds_raised
		) AS row_num
FROM layoffs_sandbox;

WITH duplicate_CTE AS
(
SELECT 
	*,
    ROW_NUMBER() 
    OVER(PARTITION BY 
					 company,
					 industry,
                     total_laid_off,
                     percentage_laid_off,
                     `date`,
                     stage,
                     country,
                     funds_raised
		) AS row_num
FROM layoffs_sandbox
)
SELECT *
FROM duplicate_CTE
WHERE row_num > 1;

-- creating a new table and adding a new column to identify duplicate rows

CREATE TABLE `layoffs_sandbox2` (
  `company` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `industry` varchar(50) DEFAULT NULL,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` double DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `funds_raised` double DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_sandbox2
SELECT *,
    ROW_NUMBER() 
    OVER(PARTITION BY 
					 company,
					 industry,
                     total_laid_off,
                     percentage_laid_off,
                     `date`,
					 stage,
                     country,
                     funds_raised
		) AS row_num
FROM layoffs_sandbox;

-- deleting duplicate rows

DELETE
FROM layoffs_sandbox2
WHERE row_num > 1;

-- standardizing data
-- removing preceeding spaces from company column

SELECT distinct company, TRIM(company)
FROM layoffs_sandbox2;
    
UPDATE layoffs_sandbox2
SET company = TRIM(company);

-- formating date column
ALTER TABLE layoffs_sandbox2
MODIFY COLUMN `date` DATE;

    
-- handling NULL and BLANK values

SELECT *
FROM  layoffs_sandbox2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM  layoffs_sandbox2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- deleting the row_num column created earlier

ALTER TABLE layoffs_sandbox2
DROP COLUMN row_num;
	
    
select count(company)
from layoffs;

