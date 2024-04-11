-- Возвращает все атрибуты продуктов и расчёт стоимости одного продукта
create or alter view dbo.vw_SKUPrice
as
select
    s.*
    ,dbo.udf_GetSKUPrice(ID) as Price
from dbo.SKU as s