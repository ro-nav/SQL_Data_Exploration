-- Query 1: Select COVID-19 data where the continent is not null and order by the third and fourth columns.

Select *
From PortfolioProject..CovidDeaths
Where continent is not null 
order by 3,4


-- Query 2: Select specific columns from the COVID-19 data where the continent is not null and order by location and date.

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null 
order by 1,2


-- Query 3: Show the total cases, total deaths, and death percentage in India.
-- The death percentage is calculated as (total_deaths / total_cases) * 100.

Select Location, date, total_cases,total_deaths, (cast(total_deaths as float)/cast(total_cases as float))*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%india%'
and continent is not null 
order by 1,2


-- Query 4: Show the percentage of population infected with COVID-19 in each location.

Select Location, date, Population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%ando%'
Where continent is not null 
order by 1,2


-- Query 5: Show countries with the highest infection rate compared to their population.
-- It calculates the percentage of the population infected and lists the highest values.

Select Location, Population, MAX(cast(total_cases as float)) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%india%'
Where continent is not null 
Group by Location, Population
order by PercentPopulationInfected desc


-- Query 6: Show countries with the highest death count per population.
-- It calculates the total death count for each location and lists the highest values.

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%india%'
Where continent is not null 
Group by Location
order by TotalDeathCount desc



-- Query 7: Show continents with the highest death count per population.
-- It calculates the total death count for each continent and lists the highest values.

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%india%'
Where continent is not null 
Group by continent
order by TotalDeathCount desc


Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%india%'
Where continent is null 
and location not in ('World', 'European Union', 'International', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')
Group by location
order by TotalDeathCount desc



-- Query 8: Show global numbers of new cases, total cases, total deaths, and death percentage.

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%india%'
where continent is not null 
--Group By date
order by 1,2



-- Query 9: Show the percentage of the population that has received at least one COVID-19 vaccine in each location.

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3


-- Query 10: Using a Common Table Expression (CTE) to perform a calculation on the previous query's result and show the percentage of the population vaccinated.

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Query 11: Using a temporary table to perform a calculation on the previous query's result and show the percentage of the population vaccinated, specifically for India.

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated
where Location like '%india%'




-- Query 12: Creating a view named "PercentPopulationVaccinated" to store data for later visualizations, which is based on the second query.

Drop View PercentPopulationVaccinated

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

select *
from PercentPopulationVaccinated
