/*
 * QUESTION 1
*/

SELECT
	DISTINCT t1.avg_payroll,
	t1.i_b_code,
	t1.year_x
FROM t_marketa_safrankova_project_sql_primary_final t1
WHERE 
	t1.year_x IN (2006, 2018)
ORDER BY
	t1.i_b_code,	
	t1.avg_payroll DESC,
	t1.year_x;
-- the answer is there, nonetheless it can likely be answered in a smarter way, just couldn't figure it out yet
