## SQL Data Exploration Project - COVID-19 Dataset

This GitHub repository contains a SQL Data Exploration project focused on the COVID-19 pandemic using data from the Our World in Data website. The goal of this project is to analyze and gain insights into various aspects of the pandemic using SQL queries on the provided dataset.

## Dataset

The dataset used for this project is sourced from [Our World in Data - COVID-19 Deaths](https://ourworldindata.org/covid-deaths). It has been divided into two main tables for the purpose of analysis:

1. **CovidDeaths:**
   - This table contains information related to COVID-19 cases and deaths, such as location, date, total cases, new cases, total deaths, and population.

2. **CovidVaccinations:**
   - This table contains information on COVID-19 vaccinations, such as location, date, and new vaccinations.

## SQL Queries

The following SQL queries have been performed on the dataset:

1. **Selecting Data to Start With:**
   - Retrieves essential information such as location, date, total cases, new cases, total deaths, and population from the CovidDeaths table.
   - Filters out records with null continents and orders the results by location and date.

2. **Total Cases vs Total Deaths:**
   - Calculates the death percentage based on the total number of cases and deaths for a specific location (e.g., India) from the CovidDeaths table.
   - Shows the likelihood of dying if someone contracts COVID-19 in the selected country.

3. **Total Cases vs Population:**
   - Calculates the percentage of the population infected with COVID-19 for each location over time from the CovidDeaths table.
   - Provides insights into the spread of the virus in different countries relative to their population.

4. **Countries with Highest Infection Rate compared to Population:**
   - Identifies countries with the highest infection rate relative to their population from the CovidDeaths table.
   - Displays the maximum infection count and the corresponding percentage of population infected.

5. **Countries with Highest Death Count per Population:**
   - Lists countries with the highest death count relative to their population from the CovidDeaths table.
   - Ranks countries based on the total number of deaths per location.

6. **Breaking Things Down by Continent:**
   - Presents continents with the highest death count relative to their population from the CovidDeaths table.
   - Groups the data by continent and displays the total death count for each continent.

7. **Global Numbers:**
   - Calculates global statistics such as total cases, total deaths, and death percentage from new cases from the CovidDeaths table.
   - Provides an overall picture of the pandemic on a global scale.

8. **Total Population vs Vaccinations:**
   - Compares the total population with the number of people who have received at least one COVID-19 vaccine dose from the CovidVaccinations table.
   - Shows the percentage of the population vaccinated in each location over time.

9. **Using CTE to Perform Calculation on Partition By:**
   - Utilizes Common Table Expressions (CTE) to perform calculations on the previously obtained data from the CovidDeaths and CovidVaccinations tables.
   - Calculates the percentage of the population vaccinated using the CTE approach.

10. **Using Temp Table to Perform Calculation on Partition By:**
    - Uses a temporary table to perform calculations on the previous dataset from the CovidDeaths and CovidVaccinations tables.
    - Calculates the percentage of the population vaccinated using the temp table approach.

11. **Creating a View to Store Data for Later Visualizations:**
    - Creates a view called "PercentPopulationVaccinated" to store data from the CovidDeaths and CovidVaccinations tables for later visualizations.
    - The view contains information about continents, locations, dates, populations, new vaccinations, and rolling vaccinated people count.

## Visualizations

In addition to the SQL queries, the project may include visualizations generated from the data stored in the "PercentPopulationVaccinated" view. These visualizations can provide further insights into the COVID-19 pandemic and its vaccination efforts.

Feel free to explore the SQL queries, run them against the dataset, and create your visualizations based on the data in the "PercentPopulationVaccinated" view.

Please note that the data is based on the Our World in Data source and might not be up-to-date. It's always a good practice to cross-verify the data with the latest sources for accurate analysis.

Happy exploring! 🚀
