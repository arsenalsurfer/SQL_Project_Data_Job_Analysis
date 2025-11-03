/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Idntify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
  providing insights into the most valuable skills for job seekers.
*/

SELECT 
  skills,
  COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim
ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND job_work_from_home = True
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5

/*
Here’s a short summary of your top-demanded data skills:


SQL (7,291) – Still the core data skill; essential for querying and managing databases. Nearly every analytics or BI role lists it as a must-have.


Excel (4,611) – Widely used for quick analysis, reporting, and dashboards; still dominant in business settings despite newer tools.


Python (4,330) – Rising fast for automation, data cleaning, and analytics; adds flexibility beyond spreadsheets and SQL.


Tableau (3,745) – Key visualization tool for turning data into insights; valued for storytelling and dashboards.


Power BI (2,609) – Microsoft’s BI tool, strong demand in enterprise environments; often paired with Excel and SQL.


Trend: SQL + Excel remain foundational, Python adds versatility, and Tableau/Power BI show strong demand for data visualization and business intelligence.
*/