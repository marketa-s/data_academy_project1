/*
 * PROJEKT 1
 *
 * Výzkumné otázky
 * 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 * 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 * 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
 * 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 * 5. Má výška HDP vliv na změny ve mzdách a cenách potravin?
   Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
*/

-- CREATE VIEW t_{marketa}_{safrankova}_project_SQL_primary_final AS

-- udělat .sql pro: 1.tab, 2.tab, každý dotaz, tzn. 7x .sql

-- nápověda - lekce 4 úkol 7 - kouknout

-- bude se hodit bonus úkol 5 z lekce 4 (meziroční procentní nárůst)
/*
 * bonus úkol 5 z lekce 4 (meziroční procentní nárůst)
 * 	SELECT e.country, e.year, e2.year + 1 as year_prev,
    	round( ( e.GDP - e2.GDP ) / e2.GDP * 100, 2 ) as GDP_growth,
    	round( ( e.population - e2.population ) / e2.population * 100, 2) as pop_growth_percent
	FROM economies e
	JOIN economies e2
   		ON e.country = e2.country
    	AND e.year = e2.year + 1
   		AND e.year < 2020
 */


-- when creating a table, firstly I search for the years on which I have the data for both the payrolls and the prices (I neglect the difference between date_from and date_to)
SELECT DISTINCT YEAR(cp.date_from) AS year_of_entry
FROM czechia_price cp
ORDER BY cp.date_from;

select * from countries;

SELECT DISTINCT cp.payroll_year
FROM czechia_payroll cp
ORDER BY cp.payroll_year;

SELECT
		avg(cp2.value),
		cp2.payroll_year,
		cp2.industry_branch_code
FROM czechia_payroll cp2
WHERE cp2.industry_branch_code IS NOT NULL
GROUP BY cp2.payroll_year, cp2.industry_branch_code;
-- špatný průměr

SELECT
		cp2.value,
		cp2.payroll_year,
		cp2.industry_branch_code
FROM czechia_payroll cp2
WHERE
	cp2.industry_branch_code IS NOT NULL
	AND cp2.value IS NOT NULL
	AND	cp2.value_type_code = 5958
	AND cp2.unit_code = 200
	AND cp2.calculation_code = 200; -- mezikrok

SELECT
		avg(cp2.value),
		cp2.payroll_year,
		cp2.industry_branch_code
FROM czechia_payroll cp2
WHERE
	cp2.industry_branch_code IS NOT NULL
	AND cp2.value IS NOT NULL
	AND	cp2.value_type_code = 5958
	AND cp2.unit_code = 200
	AND cp2.calculation_code = 200
GROUP BY
	cp2.payroll_year,
	cp2.industry_branch_code;
-- dá mi průměr plat v roce a období

SELECT
		avg(cp2.value)
FROM czechia_payroll cp2
WHERE
	cp2.industry_branch_code IS NOT NULL
	AND cp2.value IS NOT NULL
	AND	cp2.value_type_code = 5958
	AND cp2.unit_code = 200
	AND cp2.calculation_code = 200
GROUP BY
	cp2.payroll_year,
	cp2.industry_branch_code;

SELECT
	cp.value,
	cp.category_code,
	YEAR(cp.date_from),
	cp.region_code,
	cp2.value,
	cp2.industry_branch_code,
	cp2.payroll_year
FROM czechia_price cp
JOIN czechia_payroll cp2
	ON YEAR(cp.date_from) = cp2.payroll_year
WHERE
	cp2.value_type_code = 5958
	AND cp2.unit_code = 200
	AND cp2.calculation_code = 200,
	(
	SELECT
		avg(cp2.value)
	FROM czechia_payroll cp2
	WHERE
		cp2.industry_branch_code IS NOT NULL
		AND cp2.value IS NOT NULL
		AND	cp2.value_type_code = 5958
		AND cp2.unit_code = 200
		AND cp2.calculation_code = 200
	GROUP BY
		cp2.payroll_year,
		cp2.industry_branch_code
	),
ORDER BY cp2.payroll_year;
-- ne

WITH x AS
	(
	SELECT
		avg(cp2.value)
	FROM czechia_payroll cp2
	WHERE
		cp2.industry_branch_code IS NOT NULL
		AND cp2.value IS NOT NULL
		AND	cp2.value_type_code = 5958
		AND cp2.unit_code = 200
		AND cp2.calculation_code = 200
	GROUP BY
		cp2.payroll_year,
		cp2.industry_branch_code
	)
SELECT
	cp.value,
	cp.category_code,
	YEAR(cp.date_from),
	cp.region_code,
	cp2.value,
	cp2.industry_branch_code,
	cp2.payroll_year
FROM czechia_price cp
JOIN czechia_payroll cp2
	ON YEAR(cp.date_from) = cp2.payroll_year
WHERE
	cp2.value_type_code = 5958
	AND cp2.unit_code = 200
	AND cp2.calculation_code = 200
ORDER BY cp2.payroll_year;

SELECT
	cp.value AS price,
	cp.category_code,
	YEAR(cp.date_from) AS price_in_year_X,
	cp.region_code,
	cp2.value AS payroll,
	cp2.industry_branch_code,
	cp2.payroll_year
FROM czechia_price cp
JOIN czechia_payroll cp2
	ON YEAR(cp.date_from) = cp2.payroll_year
WHERE
	cp2.value_type_code = 5958
	AND cp2.unit_code = 200
	AND cp2.calculation_code = 200
	AND cp2.industry_branch_code = 'A'
ORDER BY cp2.payroll_year;

SELECT
	cp.value AS price,
	cp.category_code,
	YEAR(cp.date_from) AS price_in_year_X,
	cp.region_code,
	avg(cp2.value) AS payroll,
	cp2.industry_branch_code,
	cp2.payroll_year
FROM czechia_price cp
JOIN czechia_payroll cp2
	ON YEAR(cp.date_from) = cp2.payroll_year
WHERE
	cp2.value_type_code = 5958
	AND cp2.unit_code = 200
	AND cp2.calculation_code = 200
	AND cp2.industry_branch_code = 'A'
GROUP BY cp.region_code
	AND cp2.industry_branch_code
	AND cp2.payroll_year
	AND cp.category_code
ORDER BY cp2.payroll_year;
-- tohle mi ke každému odvětví a roku dává 4 hodnoty

SELECT
	cp.value AS price,
	cp.category_code,
	YEAR(cp.date_from) AS price_in_year_X,
	cp.region_code,
	avg(cp2.value)
	-- ?
		AS payroll,
	cp2.industry_branch_code,
	cp2.payroll_year
FROM czechia_price cp
JOIN czechia_payroll cp2
	ON YEAR(cp.date_from) = cp2.payroll_year
WHERE
	cp2.value_type_code = 5958
	AND cp2.unit_code = 200
	AND cp2.calculation_code = 200
ORDER BY cp2.payroll_year;



-- I create the 1st table as follows:
CREATE TABLE t_marketa_safrankova_project_SQL_primary_final AS
	SELECT *
	FROM czechia_payroll cp
	JOIN czechia_price cp2
		ON

-- question 1 using the whole database
SELECT
	cp.*,
	cpib.code,
	cpib.name
FROM czechia_payroll cp
JOIN czechia_payroll_industry_branch cpib
	ON cp.industry_branch_code = cpib.code
WHERE cp.value_type_code = 5958
	AND unit_code = 200
	AND calculation_code = 100
	AND industry_branch_code = 'A'
ORDER BY
	payroll_year,
	industry_branch_code;

-- question 1 using the 1st table


