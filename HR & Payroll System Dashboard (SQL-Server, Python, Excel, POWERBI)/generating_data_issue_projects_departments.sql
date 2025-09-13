USE HR_PAYROLL;

SELECT p.project_id, p.project_name , count(distinct e_p.employee_id) employees_no
FROM projects p left join employees_projects e_p 
	ON p.project_id = e_p.project_id
GROUP BY p.project_id, p.project_name
ORDER BY p.project_id
;

SELECT e.dept_id, d.dept_name, count(distinct p.project_id)
FROM employees e, departments d, employees_projects e_p, projects p
WHERE e.dept_id = d.dept_id
	and e.employee_id = e_p.employee_id
	and e_p.project_id = p.project_id
GROUP BY e.dept_id, d.dept_name
ORDER BY e.dept_id
;


SELECT 
    d.dept_id,
    d.dept_name,
    COUNT(DISTINCT p.project_id) AS total_projects,
    COUNT(DISTINCT CASE 
                      WHEN p.end_date IS NULL OR p.end_date >= GETDATE() 
                      THEN p.project_id 
                   END) AS active_projects,
    COUNT(DISTINCT CASE 
                      WHEN p.start_date <= GETDATE() 
                       AND (p.end_date IS NULL OR p.end_date >= GETDATE()) 
                      THEN p.project_id 
                   END) AS ongoing_projects
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
JOIN employees_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
-- de-duplicate at dept/project level
GROUP BY d.dept_id, d.dept_name;


-- number of employees per department
SELECT d.dept_id, count(distinct ep.employee_id)
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
JOIN employees_projects ep ON e.employee_id = ep.employee_id
GROUP BY d.dept_id
ORDER BY d.dept_id
;

-- number of employees per department
SELECT d.dept_id, count(distinct ep.employee_id) emp_no, count(distinct ep.project_id) proj_no
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
JOIN employees_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
--WHERE d.dept_id = 1
GROUP BY d.dept_id
ORDER BY d.dept_id
;


SELECT e.employee_id, count(DISTINCT ep.project_id)
FROM employees e JOIN employees_projects ep ON e.employee_id = ep.employee_id
GROUP BY e.employee_id
ORDER BY e.employee_id 

