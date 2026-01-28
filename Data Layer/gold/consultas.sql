-- Para o Mapa de Ofertas (FOR SALE)

SELECT dim.ste, COUNT(*) FROM dw.Fat_Rel_Est fat 
JOIN dw.Dim_Add dim ON fat.SRK_add = dim.SRK_add 
WHERE fat.sta = 'for_sale'
GROUP BY dim.ste;

-- Informações Totais que Ficaram ao Lado do Mapa
WITH cte_for_sale AS (
    SELECT * FROM dw.Fat_Rel_Est WHERE sta = 'for_sale'
)
SELECT COUNT(*) FROM cte_for_sale;
SELECT COUNT(*) FROM cte_for_sale WHERE SRK_rdc IS NOT NULL;
SELECT COUNT(*) FROM cte_for_sale WHERE SRK_lot IS NOT NULL;

SELECT sta, COUNT(*) FROM dw.Fat_Rel_Est GROUP BY sta;

-- Residence
-- Do Estado Selecionado no Power BI
WITH cte_residences AS (
    SELECT fat.prc, add.cty, add.zip_cde, rdc.hse_sze, rdc.prc_per_sqf
    FROM dw.Fat_Rel_Est fat
    JOIN dw.Dim_Add add ON fat.SRK_add = add.SRK_add
    JOIN dw.Dim_Rdc rdc ON fat.SRK_rdc = rdc.SRK_rdc
    WHERE add.ste = 'estado_selecionado' AND fat.sta = 'for_sale'
)
SELECT COUNT(*) FROM cte_residences;
SELECT cty, COUNT(*) FROM cte_residences GROUP BY cty;
SELECT cty, AVG(hse_sze) FROM cte_residences GROUP BY cty;
SELECT cty, AVG(prc_per_sqf) FROM cte_residences GROUP BY cty;

-- Da Cidade Selecionada no Power BI
SELECT * FROM cte_residences WHERE cty = 'cidade_selecionada';

-- Lotes
-- Do Estado Selecionado no Power BI
WITH cte_land_lots AS (
    SELECT fat.prc, add.cty, add.zip_cde, lot.acre_lot, lot.prc_per_acr, lot.tpe
    FROM dw.Fat_Rel_Est fat
    JOIN dw.Dim_Add add ON fat.SRK_add = add.SRK_add
    JOIN dw.Dim_Lnd_Lot lot ON fat.SRK_lot = lot.SRK_lot
    WHERE add.ste = 'estados_selecionado' AND fat.sta = 'for_sale'
)
SELECT COUNT(*) FROM cte_land_lots;
SELECT tpe, COUNT(*) FROM cte_land_lots GROUP BY tpe;

SELECT cty, COUNT(*) FROM cte_land_lots GROUP BY cty;
SELECT cty, AVG(acre_lot) FROM cte_land_lots GROUP BY cty;
SELECT cty, AVG(prc_per_acr) FROM cte_land_lots GROUP BY cty;

-- Da Cidade Selecionada no Power BI
SELECT tpe, COUNT(*) FROM cte_land_lots WHERE cty = 'cidade_selecionada' GROUP BY tpe;
SELECT * FROM cte_land_lots WHERE cty = 'cidade_selecionada';

-- Para as Propriedades Vendidade (SOLD)

SELECT dim.ste, COUNT(*) FROM dw.Fat_Rel_Est fat 
JOIN dw.Dim_Add dim ON fat.SRK_add = dim.SRK_add 
WHERE fat.sta = 'sold'
GROUP BY dim.ste;

WITH cte_sold AS (
    SELECT * FROM dw.Fat_Rel_Est WHERE sta = 'sold'
)
SELECT COUNT(*) FROM cte_sold;

SELECT COUNT(*) FROM cte_sold WHERE SRK_rdc IS NOT NULL;
SELECT COUNT(*) FROM cte_sold WHERE SRK_lot IS NOT NULL;

-- Residence
-- Do estado selecionado no BI
WITH cte_residences_sold AS (
    SELECT fat.prc, add.cty, add.zip_cde, rdc.hse_sze, rdc.prc_per_sqf
    FROM dw.Fat_Rel_Est fat
    JOIN dw.Dim_Add add ON fat.SRK_add = add.SRK_add
    JOIN dw.Dim_Rdc rdc ON fat.SRK_rdc = rdc.SRK_rdc
    WHERE add.ste = 'estado_selecionado' AND fat.sta = 'sold'
)
SELECT COUNT(*) FROM cte_residences_sold;

SELECT cty, COUNT(*) FROM cte_residences_sold GROUP BY cty;
SELECT cty, AVG(hse_sze) FROM cte_residences_sold GROUP BY cty;
SELECT cty, AVG(prc_per_sqf) FROM cte_residences_sold GROUP BY cty;

SELECT * FROM cte_residences_sold WHERE cty = 'cidade_selecionada';

-- Land Lot
-- Do estado selecionado no BI
WITH cte_land_lots_sold AS (
    SELECT fat.prc, add.cty, add.zip_cde, lot.acre_lot, lot.prc_per_acr, lot.tpe
    FROM dw.Fat_Rel_Est fat
    JOIN dw.Dim_Add add ON fat.SRK_add = add.SRK_add
    JOIN dw.Dim_Lnd_Lot lot ON fat.SRK_lot = lot.SRK_lot
    WHERE add.ste = 'estado_selecionado' AND fat.sta = 'sold'
)
SELECT COUNT(*) FROM cte_land_lots_sold;

SELECT tpe, COUNT(*) FROM cte_land_lots_sold GROUP BY tpe;
SELECT cty, COUNT(*) FROM cte_land_lots_sold GROUP BY cty;
SELECT cty, AVG(acre_lot) FROM cte_land_lots_sold GROUP BY cty;
SELECT cty, AVG(prc_per_acr) FROM cte_land_lots_sold GROUP BY cty;

SELECT tpe, COUNT(*) FROM cte_land_lots_sold WHERE cty = 'cidade_selecionada' GROUP BY tpe;
SELECT * FROM cte_land_lots_sold WHERE cty = 'cidade_selecionada';
