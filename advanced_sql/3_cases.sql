-- CREATE A NEW TABLE FOR ALL JANUARY TO MARCH job_postings_fact

-- January
CREATE TABLE january_jobs AS
SELECT * 
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE february_jobs AS
SELECT * 
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
SELECT * 
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT * FROM march_jobs;

-- CASES

SELECT 
  COUNT(job_id) AS number_of_jobs,
  CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
  END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;

-- PRACTICE PROBLEM CASE
-- I want to categorize the salaries from each job posting. To see if it fits in my desired salary range.
-- Put salary into different buckets
-- Define whats a high, standard, or low salary with our own condition
-- Why? It is easy to determine which job postings are worth looking at based on salary.
-- Bucketing is a common practice in data analysis when viewing categories.
-- I only want to look at data analyst roles
-- Order from highest to lowest

SELECT
  job_title_short,
  salary_year_avg,
  CASE
    WHEN salary_year_avg > 80000 THEN 'High'
    WHEN salary_year_avg > 70000 THEN 'Medium'
    ELSE 'LOW'
  END AS bucket
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;