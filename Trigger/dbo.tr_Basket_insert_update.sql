-- Установление размера скидки при добавлении записей покупок
create or alter trigger dbo.tr_Basket_insert_update on dbo.Basket
after insert, update
as
begin
    update b
    set b.DiscountValue =
        case
            when b.ID_SKU in (
                -- Определение продуктов со скидкой
                select i.ID_SKU
                from inserted as i
                group by i.ID_SKU
                having count(*) > 1
            )
                then 0.05 * Value
            else 0
        end
    from dbo.Basket as b
    where b.DiscountValue is null
end
