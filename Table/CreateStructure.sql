-- Проверка наличия объекта
if object_id('dbo.SKU') is null
begin
    -- Продукты
    create table dbo.SKU (
        ID int not null identity,
        Code as 's' + convert(varchar(255), ID),
        Name varchar(255) not null,
        constraint PK_SKU primary key clustered (ID)
    )
    alter table dbo.SKU add constraint UK_SKU_Code unique (Code)
end

-- Проверка наличия объекта
if object_id('dbo.Family') is null
begin
    -- Семья
    create table dbo.Family (
        ID int not null identity,
        SurName varchar(255) not null,
        BudgetValue decimal(18, 2) not null,
        constraint PK_Family primary key clustered (ID)
    )
end

-- Проверка наличия объекта
if object_id('dbo.Basket') is null
begin
    -- Корзина продуктов
    create table dbo.Basket (
        ID int not null identity,
        ID_SKU int not null,
        ID_Family int not null,
        Quantity int not null,
        Value decimal(18, 2) not null,
        PurchaseDate date not null,
        DiscountValue decimal(18, 2),
        constraint PK_Basket primary key clustered (ID)
    )
    alter table dbo.Basket add constraint FK_Basket_ID_SKU_SKU foreign key (ID_SKU) references dbo.SKU(ID)
    alter table dbo.Basket add constraint FK_Basket_ID_Family_Family foreign key (ID_Family) references dbo.Family(ID)
    alter table dbo.Basket add constraint CK_Basket_Quantity_Value check (Quantity > 0 and Value > 0)
    alter table dbo.Basket add constraint DF_Basket_PurchaseDate default convert(date, getdate()) for PurchaseDate
end