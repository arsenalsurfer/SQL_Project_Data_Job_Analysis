SELECT *
FROM january_jobs;

SELECT *
FROM february_jobs;

SELECT *
FROM march_jobs;

-- UNION
SELECT
  job_title_short,
  company_id,
  job_location
FROM
  january_jobs

UNION

SELECT
  job_title_short,
  company_id,
  job_location
FROM
  february_jobs

UNION

SELECT
  job_title_short,
  company_id,
  job_location
FROM
  march_jobs;

-- UNION ALL
SELECT
  job_title_short,
  company_id,
  job_location
FROM
  january_jobs

UNION ALL

SELECT
  job_title_short,
  company_id,
  job_location
FROM
  february_jobs

UNION ALL

SELECT
  job_title_short,
  company_id,
  job_location
FROM
  march_jobs;

-- Practice Problem Union and Union All

-- Practice 1
-- UNION
SELECT job_title_short, sd.skills 
FROM january_jobs
LEFT JOIN skills_job_dim AS sjd 
ON january_jobs.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
WHERE january_jobs.salary_year_avg > 70000

UNION 

SELECT job_title_short, sd.skills  
FROM february_jobs
LEFT JOIN skills_job_dim AS sjd 
ON february_jobs.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
WHERE february_jobs.salary_year_avg > 70000


UNION

SELECT job_title_short, sd.skills  
FROM march_jobs
LEFT JOIN skills_job_dim AS sjd 
ON march_jobs.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
WHERE march_jobs.salary_year_avg > 70000 

ORDER BY skills DESC;


-- UNION ALL
SELECT job_title, sd.skills 
FROM january_jobs
LEFT JOIN skills_job_dim AS sjd 
ON january_jobs.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
WHERE january_jobs.salary_year_avg > 70000

UNION ALL

SELECT job_title, sd.skills  
FROM february_jobs
LEFT JOIN skills_job_dim AS sjd 
ON february_jobs.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
WHERE february_jobs.salary_year_avg > 70000


UNION ALL

SELECT job_title, sd.skills  
FROM march_jobs
LEFT JOIN skills_job_dim AS sjd 
ON march_jobs.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
WHERE march_jobs.salary_year_avg > 70000 

ORDER BY skills DESC

-- Problem No. 8
/* 
Find job positngs from the first quarter that have a salary greater than $70K
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/
SELECT
  quarter1_job_postings.job_title_short,
  quarter1_job_postings.job_location,
  quarter1_job_postings.job_via,
  quarter1_job_postings.job_posted_date::date,
  quarter1_job_postings.salary_year_avg
FROM 
(
  SELECT *
  FROM january_jobs
  UNION ALL
  SELECT *
  FROM february_jobs
  UNION ALL
  SELECT *
  FROM march_jobs
)  AS quarter1_job_postings
WHERE 
  quarter1_job_postings.salary_year_avg > 70000 AND quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY 
  quarter1_job_postings.salary_year_avg DESC;
