# Data File: 
# Data Name: Major Urban Area
# Data Link: https://www.cia.gov/library/publications/the-world-factbook/docs/notesanddefs.html?fieldkey=2219&term=Major%20urban%20areas%20-%20population


# * Section A: Joining Data In SQL

# 1. Introducing Joins
SELECT * FROM facts
INNER JOIN cities ON cities.facts_id = facts.id
LIMIT 10;

# 2. Understanding Inner Joins
SELECT c.*, f.name country_name FROM facts f
INNER JOIN cities c ON c.facts_id = f.id
LIMIT 5;

# 3. Practicing Inner Joins
SELECT f.name country, c.name capital_city FROM cities c
INNER JOIN facts f ON f.id = c.facts_id
WHERE c.capital = 1;
---------------------------------------------------------
# 4. Returning One of Several Conditions With OR
SELECT Major, Median, Unemployed FROM recent_grads
WHERE Median >= 10000 OR Unemployed <= 1000 
LIMIT 20;

# 5. Grouping Operators With Parentheses
SELECT Major, Major_category, ShareWomen, Unemployment_rate 
FROM recent_grads
WHERE (Major_category = 'Engineering')
AND (ShareWomen >=0.5 OR 
Unemployment_rate < 0.051);

# 6. Ordering Results Using ORDER BY
SELECT Major, ShareWomen, Unemployment_rate FROM 
recent_grads
WHERE ShareWomen > 0.3
AND Unemployment_rate < 0.1
ORDER BY ShareWomen DESC;

# 7. Practice Writing A Query
SELECT Major_category, Major, Unemployment_rate FROM
recent_grads WHERE
Major_category = 'Engineering' OR
Major_category = 'Physical Sciences'
ORDER BY Unemployment_rate;

# * Section B: Summary Statistics *
# (Aggregate functions)

# 1. Introduction
SELECT COUNT(Major) FROM recent_grads
WHERE ShareWomen < 0.5;

# 2. Finding a Column's Minimum and Maximum Values in SQL
SELECT MIN(Median) FROM
recent_grads
WHERE Major_category = 'Engineering';

# 3. Calculating Sums and Averages in SQL
SELECT SUM(Total) FROM recent_grads;

# 4. Combining Multiple Aggregation Functions
SELECT AVG(Total), MIN(Men), MAX(Women)
FROM recent_grads;

# 5. Customizing The Results
SELECT COUNT(*) "Number of Students", MAX(Unemployment_rate)
"Highest Unemployment Rate" FROM recent_grads;

# 6. Counting Unique Values
SELECT COUNT(DISTINCT(Major)) unique_majors,
COUNT (DISTINCT(Major_category)) unique_major_categories,
COUNT (DISTINCT(Major_code)) unique_major_codes
FROM recent_grads;

# 7. Performing Arithmetic in SQL
SELECT Major, Major_category, (P75th - P25th)
quartile_spread FROM recent_grads
ORDER BY quartile_spread
LIMIT 20;

# * Section C: Group Summary Statistics *

# 1. Introduction
SELECT * FROM recent_grads 
LIMIT 5;

# 2. Calculating Group-Level Summary 
SELECT Major_category, AVG(ShareWomen)
FROM recent_grads
GROUP BY Major_category;

# 3. Practice: Using GROUP BY
SELECT Major_category, AVG(Employed) / AVG(Total)
       AS share_employed 
FROM recent_grads
GROUP BY Major_category;

# 4. Querying Virtual Columns With the HAVING Statement
SELECT Major_category, AVG(Low_wage_jobs) / AVG(Total)
       AS share_low_wage 
FROM recent_grads
GROUP BY Major_category
HAVING share_low_wage >.1;

# 5. Rounding Results With the ROUND() Function
SELECT ROUND(ShareWomen, 4), Major_category
FROM recent_grads
LIMIT 10;

# 6. Nesting functions
SELECT Major_category, ROUND (AVG(College_jobs) / AVG(Total), 3)
       AS share_degree_jobs 
FROM recent_grads
GROUP BY Major_category
HAVING share_degree_jobs < .3;


# 7. Casting
SELECT Major_category, 
       CAST (SUM(Women) AS Float) / CAST(SUM(Total) AS Float)
       AS SW
FROM recent_grads
GROUP BY Major_category
ORDER BY SW;

# * Section D: Subqueries *

# 1. Subqueries
SELECT Major, Unemployment_rate 
FROM recent_grads
WHERE Unemployment_rate <
      (SELECT AVG(Unemployment_rate) FROM recent_grads)
ORDER BY Unemployment_rate;

# 2. Subquery In SELECT
SELECT CAST(COUNT(*) AS float) / 
CAST ((SELECT COUNT(*) FROM recent_grads)
      AS float)
      proportion_abv_avg
FROM recent_grads
WHERE ShareWomen > (SELECT AVG(ShareWomen) 
                    FROM recent_grads);
# 3. Returning Multiple Results In Subqueries
SELECT Major, Major_category
FROM recent_grads
WHERE Major_category IN (SELECT Major_category
                         FROM recent_grads
                         GROUP BY Major_category
                         ORDER BY SUM(Total) DESC
                         LIMIT 5);

# 4. Building Complex Subqueries
SELECT AVG(CAST(Sample_size AS Float) / 
           CAST(Total AS Float)) avg_ratio
FROM recent_grads;

# 5. Practice Integrating A Subquery With The Outer Query
SELECT Major, Major_category, CAST(Sample_size AS Float) /
                              CAST(Total AS Float) ratio
FROM recent_grads
WHERE ratio > (SELECT AVG(CAST(Sample_size AS Float) /
                          CAST(Total AS Float)) avg_ratio
                          FROM recent_grads);










