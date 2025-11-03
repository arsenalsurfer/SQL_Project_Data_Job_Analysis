/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skills for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
  skills,
  ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
  job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
  AND job_work_from_home = True
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25

/*

Data Engineering & Cloud Tools Dominate: High-paying skills like PySpark, Databricks, Airflow, and GCP show strong demand for analysts who can manage large-scale, cloud-based data systems.

AI/ML & Python Ecosystem Pay Premiums: Tools such as Watson, DataRobot, Pandas, and Scikit-learn boost salaries as analytics shifts toward machine learning and automation.

DevOps & Collaboration Integration: Skills in Bitbucket, GitLab, Jenkins, and Notion highlight rising value for analysts who can version, automate, and integrate workflows across teams.

*/