-- ============================================================
-- Data profiling: understand raw date/quarter formats and
-- confirm the correct CPI series before writing final queries
-- ============================================================

SELECT DISTINCT "Kwartał" FROM housing_prices LIMIT 15;
SELECT DISTINCT "Kwartał" FROM gdp LIMIT 15;
SELECT DISTINCT "Kwartał" FROM wibor3m LIMIT 15;
SELECT DISTINCT "Rok", "Kwartał" FROM cpi LIMIT 15;
SELECT DISTINCT "Sposób prezentacji" FROM cpi;


-- ============================================================
-- Final exploratory queries: cleaned, converted, ready to feed
-- into the Python pipeline in step 4
-- ============================================================

-- 1. CPI: filtered to the year-over-year series, comma decimal converted
SELECT "Rok" AS year, "Kwartał" AS quarter,
       CAST(REPLACE("Wartość", ',', '.') AS REAL) AS cpi_index
FROM cpi
WHERE "Sposób prezentacji" LIKE 'Analogiczny okres%'
ORDER BY "Rok", "Kwartał";

-- 2. Unemployment: monthly -> quarterly average, old-methodology series only
-- Note: uses IS NOT, not !=, because SQLite's != never matches against NULL
SELECT
  year,
  CASE
    WHEN month IN (1,2,3)   THEN 1
    WHEN month IN (4,5,6)   THEN 2
    WHEN month IN (7,8,9)   THEN 3
    WHEN month IN (10,11,12) THEN 4
  END AS quarter,
  ROUND(AVG(CAST(unemployment_rate AS REAL)), 2) AS avg_unemployment_rate
FROM unemployment
WHERE methodology_variant IS NOT 'b_new_methodology'
  AND unemployment_rate IS NOT NULL AND unemployment_rate != ''
GROUP BY year, quarter
ORDER BY year, quarter;

-- 3. Housing prices: comma decimal + thousand-separator space removed,
-- sorted chronologically despite the "I 2008" roman-numeral format
SELECT "Kwartał",
       CAST(REPLACE(REPLACE(REPLACE("Cena", CHAR(160), ''), ' ', ''), ',', '.') AS REAL) AS price
FROM housing_prices
ORDER BY
  CAST(SUBSTR("Kwartał", -4) AS INTEGER),
  CASE SUBSTR("Kwartał", 1, INSTR("Kwartał", ' ') - 1)
    WHEN 'I'    THEN 1
    WHEN 'II'   THEN 2
    WHEN 'III'  THEN 3
    WHEN 'IV'   THEN 4
  END;

-- 4. GDP growth: quarter format "2008 Q1" (year first)
SELECT "Kwartał",
       CAST(REPLACE(REPLACE(REPLACE("Wartość", CHAR(160), ''), ' ', ''), ',', '.') AS REAL) AS gdp_growth_pct
FROM gdp
ORDER BY
  CAST(SUBSTR("Kwartał", 1, 4) AS INTEGER),
  CAST(SUBSTR("Kwartał", -1) AS INTEGER);

-- 5. WIBOR 3M: quarter format "Q1 2008" (quarter first)
SELECT "Kwartał",
       CAST(REPLACE(REPLACE(REPLACE("Wartość (%)", CHAR(160), ''), ' ', ''), ',', '.') AS REAL) AS wibor_3m_pct
FROM wibor3m
ORDER BY
  CAST(SUBSTR("Kwartał", -4) AS INTEGER),
  CAST(SUBSTR("Kwartał", 2, 1) AS INTEGER);