-- Обновляет данные поля бюджета семьи в зависимости от размера покупок
create or alter procedure dbo.usp_MakeFamilyPurchase(
    @FamilySurName varchar(255)
)
as
begin
    -- Проверка существования семьи
    if exists (
        select f.ID
        from dbo.Family as f
        where f.SurName = @FamilySurName
    )
    begin
        -- Вычисление стоимости покупок на семью
        declare @FamilyBasketValue decimal(18, 2)
        select @FamilyBasketValue = sum(b.Value)
        from dbo.Family as f
            inner join dbo.Basket as b on b.ID_Family = f.ID
        where f.SurName = @FamilySurName

        update f
        set f.BudgetValue = f.BudgetValue - @FamilyBasketValue
        from dbo.Family as f
        where f.SurName = @FamilySurName
    end
    else raiserror('Ошибка. Отсутствует такая семья', 1, 1)
end