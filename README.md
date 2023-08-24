<img src="https://th.bing.com/th/id/OIG.tlTNTSxj0uS8Ku5bQwia?pid=ImgGn" width="100%" alt="Superstore cast">

# **European Union Covid 19 Portfolio project**

## **Introduction**
### The project is a case study of the spread of the Covid-19 virus within the European Union, including a study of the countries most affected by the virus relative to their population and how this has changed over the years, in addition to the countries that have higher death rates due to the virus than others.
### Finally, presenting the conclusions we drew from this study and advice to stakeholders to help limit the spread of this virus. 

## **Some of the questions to answer will be:**
### What are the total numbers regarding the spread of this virus within the European Union?
### What is the percentage of infections of the total population within each country, and how has this changed over the years?
### What is the percentage of deaths out of the total number of infected people within each country, and how has this changed over the years?

## **Data Source:**
### The dataset to be used is from: ecdc (European Centre for Disease Prevention and Control).
### URL:
         http://www.ecdc.europa.eu/en/data/downloadable-datasets
### Performance Data Quality & Timeliness: 
### This dataset contains data points that includes information such as country names, populations, number of deaths, new cases and the number of people tested.
### Shwoing our raw data in SQL:
###
![1- Showing our raw data](https://github.com/HaidarEmadAbdo/European_Union_Covid_19_Portfolio_Project/assets/139217562/0ca45ca8-2499-4503-8c85-e61619a79294)
###
###
### Selecting data that we are going to use:
###
![2- Selecting data that we are going to us](https://github.com/HaidarEmadAbdo/European_Union_Covid_19_Portfolio_Project/assets/139217562/2af26806-4090-4640-a283-759f2faba02d)
<h3>The two tables (deaths_stats_per_week /a/ + cases_stats_per_week /b/) are originally one table containing a (state column) 
and this column contained two values (deaths - cases), each of which has the same number of lines of the other value (because every week
they study the number of cases in addition to the number of deaths).
So we separated this table into two separated tables and then merged them into (our_table) horizontally after they were merged vertically.
-The third table (cases_and_test/c/) have less records from the other two ones, because the other two ones have a records for
the (EU/EEE total) and we don't need this records, we need just the records for every single country so as not to cause chaos during the analysis 
and consider (EU/EEE total) a country alone, so we used (Right join) to filter (EU/EEE total) records.</h3> 

###
### Adding data that we are going to use in a single table called "statics_for_each_country_over_time":
###
![2- Showing data that we are going to use](https://github.com/HaidarEmadAbdo/European_Union_Covid_19_Portfolio_Project/assets/139217562/9b3c4c4e-324b-4e33-8bc6-8cd00af45760)
### We have changed the column type (year_week) from (string) to (date) so that we can draw (line charts) in tableau.
###
###
## Data Exploration
### Looking at total_cases vs population over time, and showing the countries with highest infection rate compared to popultion in SQL and Tableau:
###
![3- Looking at total cases vs population over time, and the countries with the highest infection rate compared to population](https://github.com/HaidarEmadAbdo/European_Union_Covid_19_Portfolio_Project/assets/139217562/da14c43f-7b99-4f17-ab1f-b0d6068afe49)
###
![3- Looking at total cases vs population over time, and the countries with the highest infection rate compared to population with tableau](https://github.com/HaidarEmadAbdo/European_Union_Covid_19_Portfolio_Project/assets/139217562/33a3f6ac-b5f1-4f7c-bac8-8c5ac97a8b22)
### We can see that (1-Cyprus 2-Austria 3-Slovenia) are the most infection rated copmared to its population.
###
### 
### Looking at deaths vs new_cases over time, and showing countries with highest death rate compared to total cases in SQL and Tableau:
###
![4- Looking at death vs new_cases over time, and the countries with the highes death rate compared to total cases](https://github.com/HaidarEmadAbdo/European_Union_Covid_19_Portfolio_Project/assets/139217562/33ffb533-57b6-467b-9ae8-350ccd16553a)
###
![4- Looking at death vs new_cases over time, and the countries with the highes death rate compared to total cases with tableau](https://github.com/HaidarEmadAbdo/European_Union_Covid_19_Portfolio_Project/assets/139217562/978e2c12-8bd7-49c1-9a30-19bb8ac3f16f)
<h3> We can see that countries (1-Bulgaria 2-Hungary 3-Romania 4-Poland) is the most death rate compared to its total cases
and by a good difference from the rest of the countries.
(This shows that may be there are other factors that have made this virus become more deadly in these countries than others) </h3>

###
###
### Showing Europe numbers by week, and Europe numbers in total in SQL and Tableau:
###
![5- Looking at total cases per week, and Europe numbers in total](https://github.com/HaidarEmadAbdo/European_Union_Covid_19_Portfolio_Project/assets/139217562/07d03f73-8cbe-423e-a5ca-925b6f90d6be)
###
![5- Looking at total cases per week, and Europe numbers in total with tableau](https://github.com/HaidarEmadAbdo/European_Union_Covid_19_Portfolio_Project/assets/139217562/b5aabf9d-ad91-4c1c-910a-acff82f960ab)
### We can see here that the total number of the tested persons is more than the total population, and the reason is that every single person tests 
### his/herself more than one time, so we can't benefit from the tested_cases data, and also there is no data for the treates persons.
###
## Data Visualization
### Please visit: https://public.tableau.com/app/profile/haidar.abdo/viz/Covid_19_in_The_European_Union_Portfolio_Project/Story1#1     
### to see the full Tableau story with the conclusions and recommendations using interactive dashboards.








