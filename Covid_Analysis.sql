-- Viewing the top 10 rows for both the datasets

-- Covid Deaths
SELECT TOP 10 * 
FROM PortfolioProject1..CovidDeaths
ORDER BY 3, 4;

-- Covid Vaccinations
SELECT TOP 10 *
FROM PortfolioProject1..CovidVaccinations
ORDER BY 3, 4;

-- Filtering the infected data from the good data
SELECT * 
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3, 4

SELECT location, date, population, total_cases, new_cases, total_deaths
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;

-- Total Cases VS Total Deaths
SELECT location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 AS 'Death Percentage'
FROM PortfolioProject1..CovidDeaths
wHERE continent IS NOT NULL
ORDER BY 1, 2;

-- Total Cases VS Total Deaths in India
SELECT location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 AS 'Death Percentage'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL AND location LIKE '%India%'
ORDER BY 1,2;

-- Total Cases VS Total Deaths in India and USA
(SELECT location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 AS 'Death Percentage'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL AND location LIKE '%India%')
UNION 
(SELECT location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 AS 'Death Percentage'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL AND location LIKE '%states%')
ORDER BY 1,2;

-- Total Infection Rate Each Day by Location
SELECT location, date, population, total_cases, (total_cases/population) AS '%Infection_Rate'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;

-- Total Infection Rate Each Day in India
SELECT location, date, population, total_cases, (total_cases/population)*100 AS '%Infection_Rate'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL AND location LIKE '%India%'
ORDER BY location, date;

-- Country with the highest Infected Rate w.r.t the population
SELECT location, population, MAX(total_cases) AS 'Total Cases', MAX(total_cases/population)*100 AS '%Infection_Rate'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY location, population
ORDER BY 4 DESC;

-- Countries with highest Death Count 
SELECT continent, location, MAX(CAST(total_deaths AS INT)) AS 'Total Deaths'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY continent, location 
ORDER BY 3 DESC; 

-- Countries with highest Death Percentage w.r.t infected cases 
SELECT location, population, MAX(CAST(total_deaths AS INT)) AS 'Total Deaths', 
MAX(CAST(total_deaths AS INT))/MAX(total_cases)*100 AS '%Death_Rate'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY location, population
ORDER BY 4 DESC;

-- Highest Death Percentage for India, USA and China
(SELECT location, population, MAX(CAST(total_deaths AS INT)) AS 'Total Deaths', 
MAX(CAST(total_deaths AS INT)/population)*100 AS '%Death_Rate'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL AND location LIKE 'India'
GROUP BY location, population)
UNION
(SELECT location, population, MAX(CAST(total_deaths AS INT)) AS 'Total Deaths', 
MAX(CAST(total_deaths AS INT)/population)*100 AS '%Death_Rate'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL AND location LIKE '%states'
GROUP BY location, population)
UNION
(SELECT location, population, MAX(CAST(total_deaths AS INT)) AS 'Total Deaths', 
MAX(CAST(total_deaths AS INT)/population)*100 AS '%Death_Rate'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL AND location LIKE 'China'
GROUP BY location, population)
ORDER BY 4 DESC;

-- Continents with Total Infected Cases
SELECT continent, SUM(total_cases) AS 'Total Infected'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 2 DESC;

-- Continents with Death Counts
SELECT continent, SUM(CAST(total_deaths AS INT)) AS 'Total Deaths'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 2 DESC;

-- Continents with Death Percentage w.r.t to infected cases
SELECT continent, SUM(total_cases) AS 'Total Infected', SUM(CAST(total_deaths AS INT)) AS 'Total Deaths', 
(SUM(CAST(total_deaths AS INT))/SUM(total_cases))*100 AS '%Mortality'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 2 DESC;


-- Total Cases per Day
SELECT date, SUM(total_cases) as 'Total Cases'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1;

-- Percentage of poeple getting infected per day
SELECT date, SUM(total_cases) as 'Total Cases', SUM(total_cases)/SUM(population) AS '% Infected'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1;
-- The above results will be a cummulative table as each day new cases will be added with previous cases, the daily Infected percentage for new cases are shown below.
SELECT date, SUM(new_cases) as 'Total Cases', SUM(new_cases)/SUM(population) AS '% Infected'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1;

-- Total Deaths per Day
SELECT date, SUM(total_cases) as 'Total Cases', SUM(CAST(total_deaths AS INT)) as 'Total Deaths'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1;

-- Death percentage each day
SELECT date,SUM(total_cases) as 'Total Cases', SUM(CAST(total_deaths AS INT)) as 'Total Deaths', 
SUM(CAST(total_deaths AS INT))/SUM(total_cases) AS '%Mortality'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1;

-- Total Infected due to this virus
SELECT SUM(total_cases) as 'Total_People_Infected'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL;

-- Total Deaths due to this infection
SELECT SUM(CAST(total_deaths AS INT)) as 'Total Deaths'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL;

-- Global Percentages
-- Total Deaths for new cases per day
SELECT date, SUM(new_cases) as 'Total New Cases', SUM(CAST(new_deaths AS INT)) AS 'Total Deaths', 
SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 as ' Death Percentage'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1;

-- Total Deaths overall
SELECT SUM(new_cases) as 'Total New Cases', SUM(CAST(new_deaths AS INT)) AS 'Total Deaths', 
SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 as ' Death Percentage'
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1;

-- Vaccination Dataset
SELECT *
FROM PortfolioProject1..CovidVaccinations;

-- Merging both the datasets
SELECT *
FROM PortfolioProject1..CovidDeaths       dea
JOIN PortfolioProject1..CovidVaccinations vac
	ON dea.location = vac.location AND dea.date = vac.date;

-- Total Population VS Vaccinnation
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject1..CovidDeaths       dea
JOIN PortfolioProject1..CovidVaccinations vac
	ON dea.location = vac.location AND dea.date = vac.date
where dea.continent IS NOT NULL AND dea.location = 'India'
ORDER BY 1, 2, 3;

-- Location VS Vaccination
SELECT dea.continent, dea.location, dea.population, SUM(CAST(vac.new_vaccinations AS INT)) as 'Total Vaccinated'
FROM PortfolioProject1..CovidDeaths       dea
JOIN PortfolioProject1..CovidVaccinations vac
	ON dea.location = vac.location AND dea.date = vac.date
where dea.continent IS NOT NULL
GROUP BY dea.continent, dea.location, dea.population
ORDER BY 1, 2, 3;

-- Percentage Vaccinated per location w.r.t their population
SELECT dea.continent, dea.location, dea.population, SUM(CAST(vac.new_vaccinations AS INT)) as 'Total Vaccinated',  
SUM(CAST(vac.new_vaccinations AS INT))/(dea.population) AS '%Vaccinated'
FROM PortfolioProject1..CovidDeaths       dea
JOIN PortfolioProject1..CovidVaccinations vac
	ON dea.location = vac.location AND dea.date = vac.date
where dea.continent IS NOT NULL
GROUP BY dea.continent, dea.location, dea.population;


-- Location VS Vaccination for India
SELECT dea.continent, dea.location, dea.population, SUM(CAST(vac.new_vaccinations AS INT)) as 'Total Vaccinated'
FROM PortfolioProject1..CovidDeaths       dea
JOIN PortfolioProject1..CovidVaccinations vac
	ON dea.location = vac.location AND dea.date = vac.date
where dea.continent IS NOT NULL AND dea.location LIKE 'India'
GROUP BY dea.continent, dea.location, dea.population
ORDER BY 1, 2, 3;

-- Continent VS Vaccination 
SELECT dea.continent, SUM(dea.population) AS 'Total Population', SUM(CAST(vac.new_vaccinations AS INT)) as 'Total Vaccinated'
FROM PortfolioProject1..CovidDeaths       dea
JOIN PortfolioProject1..CovidVaccinations vac
	ON dea.location = vac.location AND dea.date = vac.date
where dea.continent IS NOT NULL 
GROUP BY dea.continent;

-- Percentage Vaccinated per Continent
SELECT dea.continent, SUM(dea.population) AS 'Total Population', SUM(CAST(vac.new_vaccinations AS INT)) as 'Total Vaccinated', 
(SUM(CAST(vac.new_vaccinations AS INT))/SUM(dea.population)*100) AS 'Percentage'
FROM PortfolioProject1..CovidDeaths       dea
JOIN PortfolioProject1..CovidVaccinations vac
	ON dea.location = vac.location AND dea.date = vac.date
where dea.continent IS NOT NULL 
GROUP BY dea.continent;

-- Total Population vs Vaccination 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject1..CovidDeaths			dea
JOIN PortfolioProject1..CovidVaccinations	vac
	ON dea.location = vac.location AND dea.location = vac.location 
WHERE dea.continent IS NOT NULL
ORDER BY 1, 2;

-- Location Wise Total Vaccinated
SELECT dea.continent, dea.location, dea.population, SUM(CAST(vac.new_vaccinations AS INT)) as 'Total Vaccinated'
FROM PortfolioProject1..CovidDeaths			dea
JOIN PortfolioProject1..CovidVaccinations	vac
	ON dea.location = vac.location AND dea.date = vac.date 
WHERE dea.continent IS NOT NULL
group by dea.continent, dea.location, dea.population;

-- With CTE's
-- Getting the countries where total vaccinnation have crossed 100 million
WITH PopvsVac(Continent, Location, population, Vaccinated) AS 
(
SELECT dea.continent, dea.location, dea.population, SUM(CAST(vac.new_vaccinations AS INT))
FROM PortfolioProject1..CovidDeaths			dea
JOIN PortfolioProject1..CovidVaccinations	vac
	ON dea.location = vac.location AND dea.date = vac.date 
WHERE dea.continent IS NOT NULL
group by dea.continent, dea.location, dea.population
) 
SELECT Location, Population, SUM(CAST(Vaccinated AS INT)) AS 'Total_Vaccinated', (SUM(CAST(Vaccinated AS INT))/Population) *100 AS 'Total % Vaccinated'
FROM PopvsVac
GROUP BY Location, Population
HAVING SUM(CAST(Vaccinated AS INT)) > 100000000
ORDER BY Total_Vaccinated DESC;

-- Getting Countries where vaccination haven't started yet.
WITH PopvsVac(Continent, Location, population, Vaccinated) AS 
(
SELECT dea.continent, dea.location, dea.population, SUM(CAST(vac.new_vaccinations AS INT))
FROM PortfolioProject1..CovidDeaths			dea
JOIN PortfolioProject1..CovidVaccinations	vac
	ON dea.location = vac.location AND dea.date = vac.date 
WHERE dea.continent IS NOT NULL
group by dea.continent, dea.location, dea.population
) 
SELECT Location, Population, SUM(CAST(Vaccinated AS INT)) AS 'Total_Vaccinated'
FROM PopvsVac
GROUP BY Location, Population
HAVING SUM(CAST(Vaccinated AS INT)) is NULL
ORDER BY Population DESC;

-- Cross Checking for Afghanistan
SELECT location, SUM(CAST(new_vaccinations AS INT))
FROM PortfolioProject1..CovidVaccinations
WHERE location LIKE 'Afgha%'
GROUP BY location;


