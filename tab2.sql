/*
 * TABLE 2
*/

-- creating the 2nd table:
CREATE OR REPLACE TABLE t_marketa_safrankova_project_SQL_secondary_final AS
	SELECT 
		e.`year`,
		e.country,
		e.GDP,
		e.gini,
		c.population_density,
		c.population,
		c.continent,
		c.region_in_world
	FROM countries c
	JOIN economies e
		ON e.country = c.country
	WHERE
		e.GDP IS NOT NULL
		AND e.gini IS NOT NULL
		AND e.`year` IN (2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018)
	ORDER BY
		e.`year`,
		c.country;

-- checking the 2nd table:
SELECT *
FROM t_marketa_safrankova_project_sql_secondary_final;

-- cheching Czech GDP over years:
SELECT *
FROM t_marketa_safrankova_project_sql_secondary_final t2
WHERE t2.country LIKE 'Czech%'
ORDER BY t2.year;
