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
### performance Data Quality & Timeliness: 
### This dataset contains data points that includes information such as country names, populations, number of deaths, new cases and the number of people tested.
### Shwoing our raw data in SQL:
###
![1- Showing our raw data](https://github.com/HaidarEmadAbdo/European_Union_Covid_19_Portfolio_Project/assets/139217562/0ca45ca8-2499-4503-8c85-e61619a79294)
###
###
### Selecting data that we are going to use:
###
![2- Selecting data that we are going to us](https://github.com/HaidarEmadAbdo/European_Union_Covid_19_Portfolio_Project/assets/139217562/d82ae71e-5673-4ef9-8fe2-151d2e411909)
<h3>The two tables (deaths_stats_per_week /a/ + cases_stats_per_week /b/) are originally one table containing a (state column) 
and this column contained two values (deaths - cases), each of which has the same number of lines of the other value (because every week
they study the number of cases in addition to the number of deaths).
So we separated this table into two separated tables and then merged them into (our_table) horizontally after they were merged vertically.
-The third table (cases_and_test/c/) have less records from the other two ones, because the other two ones have a records for
the (EU/EEE total) and we don't need this records, we need just the records for every single country so as not to cause chaos during the analysis 
and consider (EU/EEE total) a country alone, so we used (Right join) to filter (EU/EEE total) records.</h3> 





