-- Вычисление стоимости передаваемого продукта из таблицы dbo.Basket
create or alter function dbo.udf_GetSKUPrice(
    @ID_SKU int 
)
returns decimal(18, 2)
as
begin
    declare @SKUPrice decimal(18, 2)

    select @SKUPrice = sum(Value) / sum(Quantity)
    from dbo.Basket as b
    where ID_SKU = @ID_SKU
    return @SKUPrice
end