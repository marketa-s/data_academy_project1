/*
 * QUESTION 2 
*/

-- milk already in litres
SELECT 
	*,
	round ((t1.avg_payroll / t1.food_price),2) AS n_milk_l
FROM t_marketa_safrankova_project_sql_primary_final t1
WHERE 
	t1.year_x IN (2006, 2018)
	AND t1.food_c_code = 114201; -- 1st step

-- result:
SELECT 
	t1.year_x,
	t1.food_price,
	t1.food_name,
	round(avg(t1.avg_payroll), 2) AS avg_payroll,
	round ((avg(t1.avg_payroll) / t1.food_price),2) AS n_milk_l
FROM t_marketa_safrankova_project_sql_primary_final t1
WHERE 
	t1.year_x IN (2006, 2018)
	AND t1.food_c_code = 114201
GROUP BY	
	t1.food_price,
	t1.food_name;

-- bread already in kgs
SELECT 
	*,
	round ((t1.avg_payroll / t1.food_price),2) AS n_bread_kg
FROM t_marketa_safrankova_project_sql_primary_final t1
WHERE 
	t1.year_x IN (2006, 2018)
	AND t1.food_c_code = 111301; -- 1st step

-- result:
SELECT 
	t1.year_x,
	t1.food_price,
	t1.food_name,
	round(avg(t1.avg_payroll), 2) AS avg_payroll,
	round ((avg(t1.avg_payroll) / t1.food_price),2) AS n_bread_kg
FROM t_marketa_safrankova_project_sql_primary_final t1
WHERE 
	t1.year_x IN (2006, 2018)
	AND t1.food_c_code = 111301
GROUP BY	
	t1.food_price,
	t1.food_name;
