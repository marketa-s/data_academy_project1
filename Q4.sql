/*
 * QUESTION 4
*/

-- looking for the yearly differences:
SELECT 
	t1.year_x AS more_recent,
	t1.food_name,
	t1.food_price AS newer_price,
	t1.avg_payroll AS newer_payroll,
	t1_2.year_x AS more_past,
	t1_2.food_price AS older_price,
	t1_2.avg_payroll AS older_payroll,
	t1.i_b_code,
	round( ( t1.food_price - t1_2.food_price ) / t1_2.food_price * 100, 2 ) as price_increase,
	round( ( t1.avg_payroll - t1_2.avg_payroll ) / t1_2.avg_payroll * 100, 2 ) as avg_payroll_increase
FROM t_marketa_safrankova_project_sql_primary_final t1
JOIN t_marketa_safrankova_project_sql_primary_final t1_2
   	ON t1.food_name = t1_2.food_name
   	AND t1.industry_name = t1_2.industry_name
    AND t1.year_x = t1_2.year_x + 1
	AND t1.year_x <= 2018
ORDER BY 
	t1.year_x;
-- I decide to use average prices and payrolls
-- I will be needing CASE function

SELECT 
	t1.year_x AS more_recent,
	round(avg(t1.food_price), 2) AS newer_price,
	round(avg(t1.avg_payroll), 2) AS newer_payroll,
	t1_2.year_x AS more_past,
	round(avg(t1_2.food_price), 2) AS older_price,
	round(avg(t1_2.avg_payroll), 2) AS older_payroll,
	round((avg(t1.food_price) - avg(t1_2.food_price )) / avg(t1_2.food_price) * 100, 2) as price_increase,
	round((avg(t1.avg_payroll) - avg(t1_2.avg_payroll )) / avg(t1_2.avg_payroll) * 100, 2) as payroll_increase,
	CASE 
		WHEN (round((avg(t1.food_price) - avg(t1_2.food_price )) / avg(t1_2.food_price) * 100, 2)) - (round((avg(t1.avg_payroll) - avg(t1_2.avg_payroll )) / avg(t1_2.avg_payroll) * 100, 2)) > 10 THEN 'nok'
		ELSE 'ok'
	END	AS comparison	
FROM t_marketa_safrankova_project_sql_primary_final t1
JOIN t_marketa_safrankova_project_sql_primary_final t1_2
   	ON t1.food_name = t1_2.food_name
   	AND t1.industry_name = t1_2.industry_name
    AND t1.year_x = t1_2.year_x + 1
	AND t1.year_x <= 2018
GROUP BY 
	t1.year_x,
	t1_2.year_x
ORDER BY 
	t1.year_x; 
-- broader look

 -- result:
SELECT 
	t1.year_x AS more_recent,
	t1_2.year_x AS more_past,
	round((avg(t1.food_price) - avg(t1_2.food_price )) / avg(t1_2.food_price) * 100, 2) as price_increase,
	round((avg(t1.avg_payroll) - avg(t1_2.avg_payroll )) / avg(t1_2.avg_payroll) * 100, 2) as payroll_increase,
	CASE 
		WHEN (round((avg(t1.food_price) - avg(t1_2.food_price )) / avg(t1_2.food_price) * 100, 2)) - (round((avg(t1.avg_payroll) - avg(t1_2.avg_payroll )) / avg(t1_2.avg_payroll) * 100, 2)) > 10 THEN 'nok'
		ELSE 'ok'
	END	AS comparison	
FROM t_marketa_safrankova_project_sql_primary_final t1
JOIN t_marketa_safrankova_project_sql_primary_final t1_2
   	ON t1.food_name = t1_2.food_name
   	AND t1.industry_name = t1_2.industry_name
    AND t1.year_x = t1_2.year_x + 1
	AND t1.year_x <= 2018
GROUP BY 
	t1.year_x,
	t1_2.year_x
ORDER BY 
	t1.year_x;
