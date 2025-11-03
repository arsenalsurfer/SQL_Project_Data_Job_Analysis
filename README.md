# Introduction

📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰top-paying jobs, 🔥in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔎SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background

Driven by a guest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, strealining other work to find optimal jobs.

### The questions I wanted to anser through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I used

For mt deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code**: My go-to for database management and executing SQL queries.
- **Git & Github**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
  job_id,
  job_title,
  job_location,
  job_schedule_type,
  salary_year_avg,
  job_posted_date,
  name AS company_name
FROM
  job_postings_fact
LEFT JOIN
  company_dim
ON job_postings_fact.company_id = company_dim.company_id
WHERE
  job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;
```

Here's the breakdown of the top data analyst jobs in 2023:

- **_Salary Trends_**

Highest salary: ₱650,000 (Data Analyst at Mantys) — seems like an outlier.

Average of the rest ranges ₱184,000 – ₱336,500, indicating director or principal roles earn ~2–3× regular data analyst roles.

- **_Job Levels & Titles_**

Roles vary from Data Analyst → Principal → Director → Associate Director, showing a clear hierarchy.

Higher titles correspond strongly to higher salaries (e.g., Director of Analytics at Meta: ₱336,500).

- **_Location & Flexibility_**

All roles are remote (“Anywhere”), with a few explicitly noting hybrid options.

Flexibility is a consistent factor for top-paying data roles in 2023.

- **_Posting Date Insights_**

Jobs are spread throughout 2023; some of the highest-paying (Mantys, Meta) were posted early in the year, suggesting companies budget big for remote talent proactively.

- **_Company Patterns_**

Tech & data-driven firms dominate: Meta, Pinterest, SmartAsset, AT&T.

Companies offering strategic data roles (director/principal) pay more than operational analyst roles.

| Job ID  | Job Title                                       | Location | Schedule Type | Avg Salary ($) | Posted Date         | Company Name                            |
| ------- | ----------------------------------------------- | -------- | ------------- | -------------- | ------------------- | --------------------------------------- |
| 226942  | Data Analyst                                    | Anywhere | Full-time     | 650,000        | 2023-02-20 15:13:33 | Mantys                                  |
| 547382  | Director of Analytics                           | Anywhere | Full-time     | 336,500        | 2023-08-23 12:04:42 | Meta                                    |
| 552322  | Associate Director- Data Insights               | Anywhere | Full-time     | 255,829.5      | 2023-06-18 16:03:12 | AT&T                                    |
| 99305   | Data Analyst, Marketing                         | Anywhere | Full-time     | 232,423        | 2023-12-05 20:00:40 | Pinterest Job Advertisements            |
| 1021647 | Data Analyst (Hybrid/Remote)                    | Anywhere | Full-time     | 217,000        | 2023-01-17 00:17:23 | Uclahealthcareers                       |
| 168310  | Principal Data Analyst (Remote)                 | Anywhere | Full-time     | 205,000        | 2023-08-09 11:00:01 | SmartAsset                              |
| 731368  | Director, Data Analyst - HYBRID                 | Anywhere | Full-time     | 189,309        | 2023-12-07 15:00:13 | Inclusively                             |
| 310660  | Principal Data Analyst, AV Performance Analysis | Anywhere | Full-time     | 189,000        | 2023-01-05 00:00:25 | Motional                                |
| 1749593 | Principal Data Analyst                          | Anywhere | Full-time     | 186,000        | 2023-07-11 16:00:05 | SmartAsset                              |
| 387860  | ERM Data Analyst                                | Anywhere | Full-time     | 184,000        | 2023-06-09 08:01:04 | Get It Recruit - Information Technology |

### 2. Top Paying Job Skills

To identify the top-paying skills for a data analyst job, it provides a detailed look at which skills to develop that align with top salaries.

**Here's the breakdown of the most demanded skills for data analysts in 2023, based on job postings:**

- SQL, Python, and Tableau stand out as the core trio of high-paying data analyst roles.

- R, Snowflake, and Pandas follow closely — showing the value of statistical analysis and modern data stack skills.

- Excel still holds relevance, proving traditional tools remain important.

- Azure and other cloud or DevOps-related tools (e.g., Bitbucket, GitLab) appear, indicating that data analysts are moving toward cloud-integrated, collaborative workflows.

```sql
WITH top_paying_jobs AS
(
SELECT
  job_id,
  job_title,
  salary_year_avg,
  name AS company_name
FROM
  job_postings_fact
LEFT JOIN
  company_dim
ON job_postings_fact.company_id = company_dim.company_id
WHERE
  job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10
)

SELECT
  top_paying_jobs.*,
  skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```

| **Job ID** | **Job Title**                                   | **Company**                             | **Avg Salary ($/yr)** | **Skills**                                                                                                          |
| ---------- | ----------------------------------------------- | --------------------------------------- | --------------------- | ------------------------------------------------------------------------------------------------------------------- |
| 552322     | Associate Director – Data Insights              | AT&T                                    | 255,829.5             | SQL, Python, R, Azure, Databricks, AWS, Pandas, PySpark, Jupyter, Excel, Tableau, Power BI, PowerPoint              |
| 99305      | Data Analyst, Marketing                         | Pinterest Job Advertisements            | 232,423.0             | SQL, Python, R, Hadoop, Tableau                                                                                     |
| 1021647    | Data Analyst (Hybrid/Remote)                    | UCLA Healthcareers                      | 217,000.0             | SQL, Crystal, Oracle, Tableau, Flow                                                                                 |
| 168310     | Principal Data Analyst (Remote)                 | SmartAsset                              | 205,000.0             | SQL, Python, Go, Snowflake, Pandas, NumPy, Excel, Tableau, GitLab                                                   |
| 731368     | Director, Data Analyst – HYBRID                 | Inclusively                             | 189,309.0             | SQL, Python, Azure, AWS, Oracle, Snowflake, Tableau, Power BI, SAP, Jenkins, Bitbucket, Atlassian, Jira, Confluence |
| 310660     | Principal Data Analyst, AV Performance Analysis | Motional                                | 189,000.0             | SQL, Python, R, Git, Bitbucket, Atlassian, Jira, Confluence                                                         |
| 1749593    | Principal Data Analyst                          | SmartAsset                              | 186,000.0             | SQL, Python, Go, Snowflake, Pandas, NumPy, Excel, Tableau, GitLab                                                   |
| 387860     | ERM Data Analyst                                | Get It Recruit – Information Technology | 184,000.0             | SQL, Python, R                                                                                                      |

### 3. Top Demanded Skills

Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.

**_Here’s a short summary of your top-demanded data skills:_**

- **SQL (7,291)** – Still the core data skill; essential for querying and managing databases. Nearly every analytics or BI role lists it as a must-have.

- **Excel (4,611)** – Widely used for quick analysis, reporting, and dashboards; still dominant in business settings despite newer tools.

- **Python (4,330)** – Rising fast for automation, data cleaning, and analytics; adds flexibility beyond spreadsheets and SQL.

- **Tableau (3,745)** – Key visualization tool for turning data into insights; valued for storytelling and dashboards.

- **Power BI (2,609)** – Microsoft’s BI tool, strong demand in enterprise environments; often paired with Excel and SQL.

- **Trend:** SQL + Excel remain foundational, Python adds versatility, and Tableau/Power BI show strong demand for data visualization and business intelligence.

```sql
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
```

| **Skill** | **Demand Count** |
| --------- | ---------------: |
| SQL       |            7,291 |
| Excel     |            4,611 |
| Python    |            4,330 |
| Tableau   |            3,745 |
| Power BI  |            2,609 |

**_📊 Quick insight:_**

1. SQL is the most in-demand skill.

2. Excel and Python follow closely.

3. Tableau and Power BI show strong demand for data visualization expertise.

# What I Learned

Through this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro andf wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analutical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, with the highest at $650,000.
2. **Skills of Top-Paying Jobs:** High-paying data analyst jobs require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills:** SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries:** Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided a valuable insight into the data analyst job market. The findings from the data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuos learning and adaptation to emerging trends in the field of data analytics.
