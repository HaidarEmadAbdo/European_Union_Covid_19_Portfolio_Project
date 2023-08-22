-- Showing our raw data
SELECT * FROM [dbo].[2- covid-19-cases-stats-per-week];
SELECT * FROM [dbo].[2- covid-19-deaths-stats-per-week];
SELECT * FROM [dbo].[3- covid-19-cases-and-tests-per-week];


-- Selcting data that we are going to use
SELECT a.country, a.year_week , a.population, a.weekly_count as deaths , a.cumulative_count as cumultive_count_for_deaths, 
       b.weekly_count as new_cases , b.cumulative_count as cumultive_count_for_new_cases,
	   c.tests_done , c.testing_rate , c.positivity_rate
FROM [dbo].[2- covid-19-deaths-stats-per-week] a 
JOIN [dbo].[2- covid-19-cases-stats-per-week] b ON a.country = b.country AND a.year_week=b.year_week
RIGHT JOIN [dbo].[3- covid-19-cases-and-tests-per-week] c ON b.country = c.country AND b.year_week = c.year_eek
ORDER BY 1,2;
/* -The two tables (deaths_stats_per_week /a/ + cases_stats_per_week /b/) are originally one table containing a (state column) 
    and this column contained two values (deaths - cases), each of which has the same number of lines of the other value (because every week
	they study the number of cases in addition to the number of deaths).
    So we separated this table into two separated tables and then merged them into (our_table) horizontally after they were merged vertically.
   -The third table (cases_and_test/c/) have less records from the other two ones, because the other two ones have a records for
    the (EU/EEE total) and we don't need this records, we need just the records for every single country so as not to cause chaos during the analysis 
	and consider (EU/EEE total) a country alone, so we used (Right join) to filter (EU/EEE total) records.   */


-- Adding data that we are going to use in a single table called "statics_for_each_country_over_time"
CREATE TABLE statics_for_each_country_over_time (
country nvarchar(50) null, year_week date null, population int null, deaths int null , cumulative_count_for_deaths int null,
new_cases int null , cumulative_count_for_new_cases int null,
tests_done int null , testing_rate float null ,positivity_rate float null) 
INSERT INTO statics_for_each_country_over_time
SELECT a.country, CONVERT(DATE, DATEADD(WEEK, CAST(RIGHT(a.year_week, 2) AS int) - 1, DATEADD(YEAR, CAST(LEFT(a.year_week, 4) AS int) - 1900, 0))),
       a.population, a.weekly_count as deaths , a.cumulative_count as cumultive_count_for_deaths, 
       b.weekly_count as new_cases , b.cumulative_count as cumultive_count_for_new_cases,
	   c.tests_done , c.testing_rate , c.positivity_rate
FROM [dbo].[2- covid-19-deaths-stats-per-week] a 
JOIN [dbo].[2- covid-19-cases-stats-per-week] b ON a.country = b.country AND a.year_week=b.year_week
RIGHT JOIN [dbo].[3- covid-19-cases-and-tests-per-week] c ON b.country = c.country AND b.year_week = c.year_eek
-- We have changed the column type (year_week) from (string) to (date) so that we can draw (line charts) in tableau.

-- Shoing data that we are going to use
SELECT * FROM statics_for_each_country_over_time


-- Looking at total_cases vs population over time
SELECT country, year_week, population, cumulative_count_for_new_cases as total_cases, 
       (CAST(cumulative_count_for_new_cases AS float)/CAST(population AS float))*100 as percent_population_infected
FROM [dbo].[statics_for_each_country_over_time]
-- Showing the countries with highest infection rate compared to popultion 
SELECT country, population, max(cumulative_count_for_new_cases) as highest_infection_count, 
       MAX((CAST(cumulative_count_for_new_cases AS float)/CAST(population AS float)))*100 as percent_population_infected
FROM [dbo].[statics_for_each_country_over_time]
GROUP BY country, population
ORDER BY 4 DESC
-- We can see that (1-Cyprus 2-Austria 3-Slovenia) are the most infection rated copmared to its population.


-- Looking at deaths vs new_cases over time
SELECT country, year_week, cumulative_count_for_deaths as total_deaths, cumulative_count_for_new_cases as total_cases, 
       (CAST(cumulative_count_for_deaths AS float)/CAST(cumulative_count_for_new_cases AS float))*100 as percentage
FROM [dbo].[statics_for_each_country_over_time]
WHERE cumulative_count_for_new_cases != 0 /*to avoid dividing by zero */
-- Showing countries with highest death rate compared to total cases
SELECT country, MAX(cumulative_count_for_deaths) as highest_deaths_count, MAX(cumulative_count_for_new_cases) as total_cases,
       MAX(CAST(cumulative_count_for_deaths AS float))/MAX(CAST(cumulative_count_for_new_cases AS float))*100 as death_per_cases
FROM [dbo].[statics_for_each_country_over_time]
WHERE cumulative_count_for_new_cases != 0 /*to avoid dividing by zero */
GROUP BY country
ORDER BY 4 DESC
/* We can see that countries (1-Bulgaria 2-Hungary 3-Romania 4-Poland) is the most death rate compared to its total cases
and by a good difference from the rest of the countries.
(This shows that may be there are other factors that have made this virus become more deadly in these countries than others). */


-- Looking at deaths vs population over time
SELECT country, year_week, population, cumulative_count_for_new_cases as total_cases, 
       (CAST(cumulative_count_for_deaths AS float)/CAST(population AS float))*100 as percent_population_infected
FROM [dbo].[statics_for_each_country_over_time]
-- Showing countries with highest death rate compared to popultion
SELECT country, population, MAX(cumulative_count_for_deaths) as highest_deaths_count, 
       MAX((CAST(cumulative_count_for_deaths AS float)/CAST(population AS float)))*100 as death_per_population
FROM [dbo].[statics_for_each_country_over_time]
GROUP BY country, population
ORDER BY 4 DESC
-- We can see that (Bulgaria + Hungary + Slovenia) is the most death rate compared to its population.


-- Europe Numbers by week
SELECT  year_week,  SUM(DISTINCT(population)) AS europe_population, MAX(cumulative_count_for_deaths) as highest_deaths_count, 
          MAX((CAST(cumulative_count_for_deaths AS float)/CAST(population AS float)))*100 as death_per_population, 
		  MAX(cumulative_count_for_new_cases) as total_cases, 
          MAX((CAST(cumulative_count_for_new_cases AS float)/CAST(population AS float)))*100 as total_cases_per_population
FROM [dbo].[statics_for_each_country_over_time]
GROUP BY year_week
ORDER BY 1;
-- Europe Numbers in total
WITH  total_statics_for_each_country AS (
SELECT country, population, MAX(cumulative_count_for_deaths) as highest_deaths_count, 
          MAX((CAST(cumulative_count_for_deaths AS float)/CAST(population AS float)))*100 as death_per_population,
	      MAX(cumulative_count_for_new_cases) as total_cases, MAX((CAST(cumulative_count_for_new_cases AS float)/CAST(population AS float)))*100 as percent_population_infected,
		  SUM(tests_done) AS tests_done
	  FROM [dbo].[statics_for_each_country_over_time]
	  GROUP BY country, population)
SELECT SUM(population) as Europe_population, SUM(highest_deaths_count) as highest_deaths_count , 
       SUM(CAST(highest_deaths_count AS float))/SUM(CAST(population AS float))*100 as deaths_per_pupulation_percentage,
       SUM(total_cases) as total_cases, SUM(CAST(total_cases AS float))/SUM(CAST(population AS float))*100 as percentage_of_population_infected,
	   SUM(CAST(highest_deaths_count AS float))/SUM(CAST(total_cases AS float))*100 as Percentage_of_infected_people_who_died, SUM(tests_done) AS tests_done
FROM   total_statics_for_each_country;                
/* We can see here that the total number of the tested persons is more than the total population, and the reason is that every single person tests 
his/herself more than one time, so we can't benefit from the tested_cases data, and also there is no data for the treates persons.*/



                     /* Please visit: https://public.tableau.com/app/profile/haidar.abdo/viz/Covid_19_in_The_European_Union_Portfolio_Project/Story1#1
                                    to see the tableau story we created from the results of the above queries.*/
