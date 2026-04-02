-- Geral

SELECT 
    dim.ste, 
    COUNT(*), 
    COUNT(*) FILTER (WHERE SRK_rdc IS NOT NULL) AS residences,
    COUNT(*) FILTER (WHERE SRK_lot IS NOT NULL) AS lots
FROM dw.Fat_Rel_Est fat 
JOIN dw.Dim_Add dim ON fat.SRK_add = dim.SRK_add 
GROUP BY dim.ste

SELECT
    dim.ste,
    COUNT(CASE WHEN fat.sta = 'for_sale' THEN 1 END) AS for_sale,
    COUNT(CASE WHEN fat.sta = 'sold' THEN 1 END)     AS sold
FROM dw.Fat_Rel_Est fat
JOIN dw.Dim_Add dim ON fat.SRK_add = dim.SRK_add 
GROUP BY dim.ste

-- Residencias

WITH cte_residences AS (
    SELECT
        fat.prc, fat.sta, fat.brk_by,
        add.ste, add.cty,
        rdc.hse_sze, rdc.bed, rdc.bat, rdc.rms, rdc.prc_per_sqf
    FROM dw.Fat_Rel_Est fat
    JOIN dw.Dim_Add add ON fat.SRK_add = add.SRK_add
    JOIN dw.Dim_Rdc rdc ON fat.SRK_rdc = rdc.SRK_rdc
)
SELECT * FROM cte_residences
SELECT ste, cty, COUNT(sta) 
FROM cte_residences 
WHERE sta = 'for_sale' GROUP BY ste, cty;

-- Lotes

WITH cte_lnd_lot AS (
    SELECT
        fat.prc, fat.sta, fat.brk_by,
        lot.acr_lot, lot.prc_per_acr, lot.tpe,
		add.ste, add.cty
    FROM dw.Fat_Rel_Est fat
    JOIN dw.Dim_Add add ON fat.SRK_add = add.SRK_add
    JOIN dw.Dim_Lnd_Lot lot ON fat.SRK_lot = lot.SRK_lot
)
SELECT * FROM cte_lnd_lot;
SELECT ste, cty, COUNT(sta) 
FROM cte_lnd_lot 
WHERE sta = 'for_sale' GROUP BY ste, cty;

-- Vendas

WITH cte_sales AS (
    SELECT
        fat.prc, fat.brk_by,
        add.ste, add.cty,
        dte.mon, dte.qtr, dte.yer, dte.prv_sld_dte,
        CASE
            WHEN fat.SRK_lot IS NULL THEN 'residence'
            ELSE 'lot'
        END AS tipo
    FROM dw.Fat_Rel_Est fat
    JOIN dw.Dim_Add add ON fat.SRK_add = add.SRK_add
    JOIN dw.Dim_Dte dte ON fat.SRK_dte = dte.SRK_dte
    WHERE fat.sta = 'sold'
)
SELECT * FROM cte_sales;


SELECT dim.ste, dim.cty, COUNT(fat.sta) 
FROM dw.Fat_Rel_Est fat 
JOIN dw.Dim_Add dim ON fat.srk_add = dim.srk_add
WHERE fat.sta = 'sold' AND fat.srk_rdc IS NOT NULL
GROUP BY dim.ste, dim.cty;