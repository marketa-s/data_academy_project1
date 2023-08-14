/*
 * QUESTION 3
*/

SELECT 
	*,
	t1_2.year_x + 11 as year_compare,
    round( ( t1.food_price - t1_2.food_price ) / t1_2.food_price * 100, 2 ) as price_diff_percent
FROM t_marketa_safrankova_project_sql_primary_final t1
JOIN t_marketa_safrankova_project_sql_primary_final t1_2
   	ON t1.food_name = t1_2.food_name
    AND t1.year_x = t1_2.year_x + 1
	AND t1.year_x <= 2018
WHERE t1.year_x = 2007
ORDER BY t1.year_x DESC; -- 1st step

SELECT 
	t1.food_name,
	t1.food_price AS newer_price,
	t1.year_x,
	t1_2.food_price AS older_price,
	t1_2.year_x,
	round( ( t1.food_price - t1_2.food_price ) / t1_2.food_price * 100, 2 ) as price_increase
FROM t_marketa_safrankova_project_sql_primary_final t1
JOIN t_marketa_safrankova_project_sql_primary_final t1_2
   	ON t1.food_name = t1_2.food_name
   	AND t1.industry_name = t1_2.industry_name
    AND t1.year_x = t1_2.year_x + 1
	AND t1.year_x <= 2018
WHERE t1.i_b_code = 'A'; -- this compares each year to the next one
-- I use industry branch A to minimize rows, but all the branches would work fine

-- I intend to compare price in 2006 to price in 2018:
SELECT 
	t1.food_name,
	t1.food_price AS newer_price,
	t1.year_x AS more_recent,
	t1_2.food_price AS older_price,
	t1_2.year_x AS more_past,
	round( ( t1.food_price - t1_2.food_price ) / t1_2.food_price * 100, 2 ) as price_increase
FROM t_marketa_safrankova_project_sql_primary_final t1
JOIN t_marketa_safrankova_project_sql_primary_final t1_2
   	ON t1.food_name = t1_2.food_name
   	AND t1.industry_name = t1_2.industry_name
    AND t1.year_x = t1_2.year_x + 12
	AND t1.year_x <= 2018
WHERE t1.i_b_code = 'A'
ORDER BY price_increase
LIMIT 1; -- sugar even got cheaper over time

-- caution! white wine only has values since 2015:
SELECT 
	t1.food_price,
	t1.food_name,
	t1.year_x
FROM t_marketa_safrankova_project_sql_primary_final t1
WHERE t1.food_name = 'Jakostní víno bílé';

-- to compare the price increase of sugar and white wine:
SELECT 
	t1.food_price AS newer_price,
	t1.food_name,
	t1.year_x AS more_recent,
	t1_2.food_price AS older_price,
	t1_2.year_x AS more_past,
	round( ( t1.food_price - t1_2.food_price ) / t1_2.food_price * 100, 2 ) as price_increase
FROM t_marketa_safrankova_project_sql_primary_final t1
JOIN t_marketa_safrankova_project_sql_primary_final t1_2
   	ON t1.food_name = t1_2.food_name
   	AND t1.industry_name = t1_2.industry_name
    AND t1.year_x = t1_2.year_x + 3
	AND t1.year_x <= 2018
WHERE 
	t1.i_b_code = 'A'
	AND t1.food_name = 'Jakostní víno bílé'
ORDER BY price_increase; -- price increase of wine is bigger than in case of sugar
