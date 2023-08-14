/*
 * TABLE 1
*/

-- when creating the 1st table, I search for the years on which I have the data for both the payrolls and the prices (I neglect the difference between date_from and date_to)
SELECT DISTINCT YEAR(cpr.date_from) AS year_of_entry
FROM czechia_price cpr
ORDER BY cpr.date_from; -- 2006-2018

SELECT DISTINCT cpa.payroll_year
FROM czechia_payroll cpa
ORDER BY cpa.payroll_year; -- 2000-2021
-- I will only compare years 2006 to 2018

SELECT
	avg(cpa.value),
	cpa.payroll_year,
	cpa.industry_branch_code
FROM czechia_payroll cpa
WHERE
	cpa.industry_branch_code IS NOT NULL
	AND cpa.value IS NOT NULL
	AND	cpa.value_type_code = 5958
	AND cpa.unit_code = 200
	AND cpa.calculation_code = 200
GROUP BY
	cpa.payroll_year,
	cpa.industry_branch_code;
-- shows a sigle value for each year and industry branch

-- when creating the 1st table I begin work only with industry A to speed up the process:
SELECT
	avg(cpr.value) AS price,
	cpr.category_code,
	YEAR(cpr.date_from) AS price_in_year_X,
	avg(cpa.value) AS payroll,
	cpa.industry_branch_code,
	cpa.payroll_year
FROM czechia_price cpr
JOIN czechia_payroll cpa
	ON YEAR(cpr.date_from) = cpa.payroll_year
WHERE
	cpa.value_type_code = 5958
	AND cpa.unit_code = 200
	AND cpa.calculation_code = 200
	AND cpa.industry_branch_code = 'A'
GROUP BY 
	cpr.category_code,
	YEAR(cpr.date_from),
	cpa.industry_branch_code,
	cpa.payroll_year
ORDER BY cpa.payroll_year, cpr.category_code;

-- I create the 1st table as follows:
CREATE OR REPLACE TABLE t_marketa_safrankova_project_SQL_primary_final AS
	SELECT
		round(avg(cpr.value),2) AS food_price,
		cpr.category_code AS food_c_code,
		cpc.name AS food_name,
		avg(cpa.value) AS avg_payroll,
		cpa.industry_branch_code AS i_b_code,
		cpib.name AS industry_name,
		YEAR(cpr.date_from) AS year_x
	FROM czechia_price cpr
	JOIN czechia_payroll cpa
		ON YEAR(cpr.date_from) = cpa.payroll_year
	JOIN czechia_price_category cpc
    	ON cpr.category_code = cpc.code
	JOIN czechia_payroll_industry_branch cpib
    	ON cpa.industry_branch_code = cpib.code
	WHERE
		cpa.value_type_code = 5958
		AND cpa.unit_code = 200
		AND cpa.calculation_code = 200
		AND cpa.industry_branch_code IS NOT NULL
	GROUP BY 
		cpr.category_code,
		YEAR(cpr.date_from),
		cpa.industry_branch_code,
		cpa.payroll_year
	ORDER BY cpa.payroll_year, cpr.category_code, cpa.industry_branch_code;

-- checking the 1st table:
SELECT *
FROM t_marketa_safrankova_project_sql_primary_final;
