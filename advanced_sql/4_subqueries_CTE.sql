-- Subqueries

SELECT * 
FROM ( --subquries start here
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

-- CTE
WITH january_jobs AS (
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT * FROM january_jobs;

SELECT company_id, name AS company_name
FROM company_dim
WHERE company_id IN (
  SELECT company_id
  FROM job_postings_fact
  WHERE job_no_degree_mention = true
)

WITH posted_table AS (SELECT company_id, COUNT(job_id) AS posted_count
FROM job_postings_fact
GROUP BY company_id)

SELECT name AS company_name, posted_table.posted_count
FROM company_dim
LEFT JOIN posted_table
ON company_dim.company_id = posted_table.company_id
ORDER BY posted_table.posted_count DESC;

-- Problem Test Subqueries and CTE

-- Problem 1
-- Identify the top 5 skills that are most frequently mentioned in job postings. Use a subquery to find the skills IDS with the highest counts in the skills_job_dim table and the join the result with the skills_dim table to get the skill names

-- USED SUBQUERY

SELECT skills AS skills_name, top_skills.count_job
FROM skills_dim
LEFT JOIN (SELECT skill_id, COUNT(job_id) AS count_job 
FROM skills_job_dim
GROUP BY skill_id
LIMIT 5) AS top_skills
ON skills_dim.skill_id = top_skills.skill_id
WHERE top_skills.count_job IS NOT NULL
ORDER BY top_skills.count_job DESC;

-- Problem 2

-- Determine the size category (Small, medium, large) for each companyby first identifying the number of job postings they have. Use a subquery to calculate the toital jobn postings per company. A company is considered 'Small' if it has less than 10 job postings, 'Medium' if the number of job postings is between 10 and 50, and 'Large' if it has more than 50 jobs postings. Implement a subquery to aggregaate job counts per company before classifying them based on size.

-- USED CTE and CASE

WITH company_posted_job AS 
(
  SELECT company_id, COUNT(job_id) AS posted_count 
FROM job_postings_fact
GROUP BY company_id
)

SELECT name AS company_name,
CASE
  WHEN cpj.posted_count > 50 THEN 'Large'
  WHEN cpj.posted_count >= 10 THEN 'Medium'
  ELSE 'Small'
END AS Bucket,
cpj.posted_count
FROM company_dim AS cd
LEFT JOIN company_posted_job AS cpj
ON cd.company_id = cpj.company_id


-- Problem 7
-- Find the count of the number of remote job postings per skill
-- - Display the top 5 skills by their demand in remote jobs
-- - Include skill ID, name, and count of postings requiring the skill

WITH remote_job_skills AS 
(
SELECT 
  skill_id,
  COUNT(*) AS skill_count
FROM
  skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings
ON skills_to_job.job_id = job_postings.job_id
WHERE job_postings.job_work_from_home = True AND
job_postings.job_title_short = 'Data Analyst'
GROUP BY skills_to_job.skill_id
)

SELECT
  skills_dim.skill_id,
  skills_dim.skills,
  remote_job_skills.skill_count
FROM skills_dim
INNER JOIN remote_job_skills
ON skills_dim.skill_id = remote_job_skills.skill_id
ORDER BY remote_job_skills.skill_count DESC
LIMIT 5;