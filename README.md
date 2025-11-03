# Introduction

📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰top-paying jobs, 🔥in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔎SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background

Driven by a guest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, strealining other work to find optimal jobs.

### The questions I wanted to anser through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. WHat skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I used

For mt deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgresSQL**: The chosen database management system, ideal for handling the job posting data.
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

1. Salary Trends

Highest salary: ₱650,000 (Data Analyst at Mantys) — seems like an outlier.

Average of the rest ranges ₱184,000 – ₱336,500, indicating director or principal roles earn ~2–3× regular data analyst roles.

2. Job Levels & Titles

Roles vary from Data Analyst → Principal → Director → Associate Director, showing clear hierarchy.

Higher titles correspond strongly to higher salaries (e.g., Director of Analytics at Meta: ₱336,500).

3. Location & Flexibility

All roles are remote (“Anywhere”), with a few explicitly noting hybrid options.

Flexibility is a consistent factor for top-paying data roles in 2023.

4. Posting Date Insights

Jobs are spread throughout 2023; some of the highest paying (Mantys, Meta) were posted early in the year, suggesting companies budget big for remote talent proactively.

5. Company Patterns

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

# What I Learned

# Conclusions
