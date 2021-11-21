
Select *
from [CovidDeaths-Project]..CoivdDeaths
order by location asc


--Slect data that we going to be using

select location, date, total_cases, new_cases, total_deaths, population
from [CovidDeaths-Project]..CoivdDeaths
order by location asc


--Total cases vs Total deaths
--total cases vs total deaths in thailand

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from [CovidDeaths-Project]..CoivdDeaths
where continent is not null
order by total_cases desc

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from [CovidDeaths-Project]..CoivdDeaths
where location like '%thailand%'
order by total_cases desc


--Looking at Total case vs population
-- What percentage of poppulation got covid
-- What percentage of poppulation got covid in Thailand

select location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
from [CovidDeaths-Project]..CoivdDeaths
order by PercentPopulationInfected desc

select location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
from [CovidDeaths-Project]..CoivdDeaths
where location like '%thailand%'
order by PercentPopulationInfected desc

--What country is highest Infection rate compare to population

select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
from [CovidDeaths-Project]..CoivdDeaths
Group by location, population
order by PercentPopulationInfected desc


--What county is highest death count per population

select location, max(cast(total_deaths as int)) as TotalDeathCount 
from [CovidDeaths-Project]..CoivdDeaths
where continent is not null
Group by location
order by TotalDeathCount desc


--What continent is highest death count 

select continent, max(cast(total_deaths as int)) as TotalDeathCount 
from [CovidDeaths-Project]..CoivdDeaths
where continent is not null
Group by continent
order by TotalDeathCount desc


--GLOBAL NUMBER
--Total gobal number of death percentage

select sum(new_cases) as TotalCases, sum(cast(new_deaths as int)) as TotalDeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from [CovidDeaths-Project]..CoivdDeaths
where continent is not null
--group by date
--order by date asc


--gobal number of death percentage each day

select date, sum(new_cases) as TotalCases, sum(cast(new_deaths as int)) as TotalDeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from [CovidDeaths-Project]..CoivdDeaths
where continent is not null
group by date
order by date asc


Select *
from [CovidDeaths-Project]..CoivdVaccinations
order by location asc

Select *
from [CovidDeaths-Project]..CoivdDeaths dea
Join [CovidDeaths-Project]..CoivdVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date


--Total popoulation vs Vaccinations
-- Total popoulation vs Vaccinations in Thailand
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from [CovidDeaths-Project]..CoivdDeaths dea
Join [CovidDeaths-Project]..CoivdVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from [CovidDeaths-Project]..CoivdDeaths dea
Join [CovidDeaths-Project]..CoivdVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.location like '%Thailand%'
order by 2,3


--Progress of vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(bigint, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as VaccinationProgress
from [CovidDeaths-Project]..CoivdDeaths dea
Join [CovidDeaths-Project]..CoivdVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


--Fully vaccinated vs Poppulation

Select dea.continent, dea.location, dea.date, dea.population, vac.people_fully_vaccinated
, (vac.people_fully_vaccinated/dea.population)*100 as FullyVaccinatedPercentage
from [CovidDeaths-Project]..CoivdDeaths dea
Join [CovidDeaths-Project]..CoivdVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


--Fully vaccinated vs Poppulation in Thailand

Select dea.continent, dea.location, dea.date, dea.population, vac.people_fully_vaccinated
, (vac.people_fully_vaccinated/dea.population)*100 as FullyVaccinatedPercentage
from [CovidDeaths-Project]..CoivdDeaths dea
Join [CovidDeaths-Project]..CoivdVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.location like '%Thailand%'
order by 3


--
