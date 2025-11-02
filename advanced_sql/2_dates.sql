-- TYPE CASTING

SELECT '2023-02-19'::DATE,
'123'::INTEGER,
'true'::BOOLEAN,
'3.14'::REAL;

-- TIMEZONE determine first what the original timezon of the data before converting it to the desired enw timezone
SELECT 
  job_title_short AS title,
  job_location AS location,
  job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date 
FROM 
  job_postings_fact
LIMIT 10;

-- EXTRACT (months, days, year)
SELECT 
  job_title_short AS title,
  job_location AS location,
  job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date, 
  EXTRACT(MONTH FROM job_posted_date) AS date_month,
  EXTRACT(YEAR FROM job_posted_date) AS date_month
FROM 
  job_postings_fact
LIMIT 10;

SELECT 
  job_title_short AS title,
  job_location AS location,
  job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date, 
  EXTRACT(MONTH FROM job_posted_date) AS date_month,
  EXTRACT(YEAR FROM job_posted_date) AS date_year,
  COUNT(job_id)
FROM 
  job_postings_fact
LIMIT 10;

SELECT
  EXTRACT(MONTH FROM job_posted_date) AS date_month, 
  COUNT(job_id) AS Job_posted_count
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'  
GROUP BY date_month
ORDER BY Job_posted_count DESC;

-- Practice DATE TIME
-- Problem 1
-- Write a query to find the average salary both yearly (salary_year_avg) and hourly (salary_hour_avg)
-- for job postings that were posted after June 1, 2023. Group the results by job schedule type.

SELECT
  job_schedule_type,
  AVG(salary_year_avg) AS yearly_avg,
  AVG(salary_hour_avg) AS salary_hour_avg
FROM 
  job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY job_schedule_type;

-- Problem 2
-- Write a query to count the number of job postings for each month in 2023, adjusting the job_posted_date -- to be in 'America/New_York' time zone before extracting (hin) the month. 
-- Assume the job_posted_date is stored in UTC. Group by and order by the month.
SELECT 
  COUNT(job_id),
  EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS month
FROM job_postings_fact
GROUP BY month; 

-- Problem 3
-- Write a query to find companies (include company name) that have posted jobs offering health insurance, where these postings were made in the second quarter of 2023. Use date extraction to filter by quarter.
SELECT
  cd.name AS company,
  jpf.job_health_insurance AS insurance,
  EXTRACT(QUARTER FROM jpf.job_posted_date) AS quarter
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_health_insurance = TRUE AND EXTRACT(QUARTER FROM jpf.job_posted_date) = 2;
