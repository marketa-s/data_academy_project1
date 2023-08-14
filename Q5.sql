/*
 * QUESTION 5
*/

-- first, I get together the data needed:
SELECT
	t1.year_x AS more_recent,
	round(avg(t1.food_price), 2) AS newer_price,
	round(avg(t1.avg_payroll), 2) AS newer_payroll,
	t2.GDP AS newer_GDP,
	t1_2.year_x AS more_past,
	round(avg(t1_2.food_price), 2) AS older_price,
	round(avg(t1_2.avg_payroll), 2) AS older_payroll,
	t2_2.GDP AS older_GDP,
	round((avg(t1.food_price) - avg(t1_2.food_price )) / avg(t1_2.food_price) * 100, 2) as price_increase,
	round((avg(t1.avg_payroll) - avg(t1_2.avg_payroll )) / avg(t1_2.avg_payroll) * 100, 2) as payroll_increase,
	round((t2.GDP - t2_2.GDP) / t2_2.GDP * 100, 2) AS GDP_increase
FROM t_marketa_safrankova_project_sql_primary_final t1
JOIN t_marketa_safrankova_project_sql_secondary_final t2
	ON t1.year_x = t2.`year`
	AND t2.country = 'Czech Republic'
JOIN t_marketa_safrankova_project_sql_secondary_final t2_2
	ON t1.year_x = t2_2.`year` + 1
	AND t2_2.country = 'Czech Republic'
JOIN t_marketa_safrankova_project_sql_primary_final t1_2
   	ON t1.food_name = t1_2.food_name
   	AND t1.industry_name = t1_2.industry_name
    AND t1.year_x = t1_2.year_x + 1
	AND t1.year_x <= 2018	
GROUP BY 
	t2.`year`,
	t2.GDP,
	t1.year_x,
	t1_2.year_x;

-- I chose a limit of 10% (just like in Q4) to look for a more distinctive relationship:
SELECT
	t1.year_x AS more_recent,
	t1_2.year_x AS more_past,
	round((avg(t1.food_price) - avg(t1_2.food_price )) / avg(t1_2.food_price) * 100, 2) as price_increase,
	round((avg(t1.avg_payroll) - avg(t1_2.avg_payroll )) / avg(t1_2.avg_payroll) * 100, 2) as payroll_increase,
	round((t2.GDP - t2_2.GDP) / t2_2.GDP * 100, 2) AS GDP_increase,
	CASE
		WHEN 
			(((t2.GDP - t2_2.GDP) / t2_2.GDP * 100) - ((avg(t1.food_price) - avg(t1_2.food_price )) / avg(t1_2.food_price) * 100)) > 10
			THEN 'ok'
		ELSE 'nok'
	END AS influence_price,
	CASE
		WHEN 
			(((t2.GDP - t2_2.GDP) / t2_2.GDP * 100) - ((avg(t1.avg_payroll) - avg(t1_2.avg_payroll )) / avg(t1_2.avg_payroll) * 100)) > 10
			THEN 'ok'
		ELSE 'nok'
	END AS influence_payroll
FROM t_marketa_safrankova_project_sql_primary_final t1
JOIN t_marketa_safrankova_project_sql_secondary_final t2
	ON t1.year_x = t2.`year`
	AND t2.country = 'Czech Republic'
JOIN t_marketa_safrankova_project_sql_secondary_final t2_2
	ON t1.year_x = t2_2.`year` + 1
	AND t2_2.country = 'Czech Republic'
JOIN t_marketa_safrankova_project_sql_primary_final t1_2
   	ON t1.food_name = t1_2.food_name
   	AND t1.industry_name = t1_2.industry_name
    AND t1.year_x = t1_2.year_x + 1
	AND t1.year_x <= 2018	
GROUP BY 
	t2.`year`,
	t2.GDP,
	t1.year_x,
	t1_2.year_x;
