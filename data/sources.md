Variable: Housing prices (Wroclaw)
File: raw/nbp_prices_wroclaw.xlsx
Source: NBP database (primary market subset)
Notes: 	exported from the original database after a change in project scope;
	only the column name and date format were adjusted post-export,
	data itself remains unchanged since extraction 

Variable: CPI (Inflation) 
File: raw/gus_cpi_source.xlsx
Source: GUS (Local Data Bank /  BDL export)
Notes:	original export contains three presentation bases
	(year-over-year, quarter-over-quarter, cumulative from December)
	and covers 1995-2026; only the year-over-year series
	("previous year period = 100") was used, filtered to the
	quarters matching the model's time range

Variable: Unemployment rate
File: raw/gus_unemployment_source.csv
Source: GUS — Registered unemployment rate 1990-2026
	(stat.gov.pl, Rynek pracy > Bezrobocie rejestrowane)
Notes:	no direct file export available on the source page — monthly 
	values were manually transcribed from the published HTML table
	(long format, one row per year-month). GUS revised its
	methodology around census years; December 2020 and all of 2021
	carry two parallel values (old vs. new methodology basis),
	flagged in the methodology_variant column. Model used the
	a_old_methodology series for that period.
	Quarterly values used in the model were computed as the mean
	of the relevant monthly figures.

Variable: Wibor3m rate
File: raw/gpw_wibor3m.xlsx
Source: GPW benchmark (polish stock market site)
Notes:	collected from historical interest rates on the website,
	aggregated to quarterly values

Variable: GDP yearly growth percent
File: raw/nbp_gdp.xlsx
Source: NBP data sources
Notes: 	manually collected from NBP website,
	aggregated to quartety values,
	changed the data format to percentage values
