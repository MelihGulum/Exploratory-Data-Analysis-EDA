SELECT *
FROM PortfolioProject..CovidDeaths
ORDER BY 3, 4

SELECT *
FROM PortfolioProject..CovidVaccinations


-- Select Data that we are going to be starting with
SELECT location, 
       date, 
       total_cases, 
       new_cases, 
       total_deaths, 
       population
FROM PortfolioProject..CovidDeaths
ORDER BY 1, 
         2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
SELECT location, 
       date, 
       total_cases, 
       total_deaths, 
       ROUND((total_deaths / total_cases) * 100, 5) AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%turkey%'
ORDER BY 1, 
         2 


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
SELECT location, 
       date, 
       total_cases, 
       population,
       (total_cases / population) * 100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%turkey%'
ORDER BY 1, 
         2 


-- Countries with Highest Infection Rate compared to Population
SELECT Location, 
       Population, 
       MAX(total_cases) AS HighestInfectionCount,  
       MAX((total_cases / population)) * 100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
-- WHERE location LIKE '%turkey%'
GROUP BY Location, 
         Population
ORDER BY PercentPopulationInfected DESC


-- Countries with Highest Death Count per Population
SELECT location, 
       MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


-- BREAKING THINGS DOWN BY CONTINENT
-- Showing contintents with the highest death count per population
SELECT continent, 
       MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- GLOBAL Total Cases, Deaths and Death Percentage
SELECT SUM(new_cases) AS total_cases, 
       SUM(cast(new_deaths as int)) AS total_deaths, 
       SUM(cast(new_deaths as int)) / SUM(New_Cases) * 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
-- WHERE location LIKE '%turkey%' 
WHERE continent IS NOT NULL
ORDER BY 1, 
         2 

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
SELECT dea.population, 
       dea.continent, 
       dea.location, 
       dea.date, 
       vac.new_vaccinations, 
       SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths AS dea
    JOIN PortfolioProject..CovidVaccinations AS vac
        ON dea.location = vac.location
        AND dea.date = vac.date
where dea.continent is not null 
order by 2,
         3


-- Using CTE to perform Calculation on Partition By in previous query
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS(
	SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
	, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) AS RollingPeopleVaccinated
	--, (RollingPeopleVaccinated/population)*100
	FROM PortfolioProject..CovidDeaths dea
	JOIN PortfolioProject..CovidVaccinations vac
		ON dea.location = vac.location
		AND dea.date = vac.date
	WHERE dea.continent is not null 
	--order by 2,3
)
SELECT *, (RollingPeopleVaccinated / Population) * 100
FROM PopvsVac


-- Using Temp Table to perform Calculation on Partition By in previous query
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated(
	Continent nvarchar(255),
	Location nvarchar(255),
	Date datetime,
	Population numeric,
	New_vaccinations numeric,
	RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	   SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

SELECT *, (RollingPeopleVaccinated / Population) * 100
FROM #PercentPopulationVaccinated


-- Creating View to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.Location Order by dea.location, dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 