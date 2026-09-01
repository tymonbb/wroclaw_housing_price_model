## Wrocław Housing Price Model

Econometric model forecasting residential real estate prices in Wrocław's

primary market, based on macroeconomic regressors.

## Overview

Can macroeconomic indicators (inflation, unemployment, GDP growth, interest

rates) explain and forecast quarterly housing price movements in Wrocław?

This project builds an ARDL/OLS model on data from Q1 2008 to Q4 2025 and

produces forecasts for Q1–Q2 2026.


The model is framed around a question relevant to banking and real estate

analytics: how well can publicly available macro data support automated

property valuation (AVM) and mortgage risk assessment.

## Data

Five variables: housing prices, CPI, unemployment rate, GDP growth, and the

WIBOR 3M rate, plus structural dummy variables for specific market episodes.

Full source documentation, including collection method and any known data

quality caveats, is in \[`data/sources.md`](data/sources.md).


## Methodology

- Core model: ARDL/OLS, built and diagnostically validated in Gretl

x20; (Breusch-Pagan, Durbin-Watson, normality of residuals, parameter stability)

- Replication in Python (pandas, statsmodels) to validate results outside

x20; academic software

- SQL used for exploratory aggregation and data quality checks

- Interactive dashboard (Power BI / Streamlit) visualizing historical vs.

x20; forecasted prices


## Project structure

wroclaw\_housing\_price\_model/

├── README.md

├── data/

│ ├── raw/

│ ├── processed/

│ └── sources.md

├── gretl/

├── sql/

├── notebooks/

└── dashboard/

## Tools

Gretl, Python (pandas, statsmodels), SQL, Power BI / Streamlit, Git

## Results

[TODO — to be completed once the Python replication and dashboard are built]

## Status

In progress — data collection and documentation complete, Python replication

next.

