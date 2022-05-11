# Домашнее задание по второму модулю

## Установка БД

![img](https://github.com/lixikon2/DE-101/blob/main/Module2/PosgreSQL_installation.png)

## Загрузка данных в БД
### Создание таблиц и загрузка данных
SQL запросы для создания таблиц и загрузки данных:

[Orders](https://github.com/lixikon2/DE-101/blob/main/Module2/orders_creating.sql)

[Returns](https://github.com/lixikon2/DE-101/blob/main/Module2/returns_creating.sql)

[People](https://github.com/lixikon2/DE-101/blob/main/Module2/people_creating.sql)

Примеры аналитических SQL-запросов:

[Calculating some simple metricks](https://github.com/lixikon2/DE-101/blob/main/Module2/calculating_metricks.sql)

## Нарисовать модель данных в SQLdbm
### Модели данных
Намеренно были допущены некоторые ошибки в форматах данных при моделировании, чтобы затем попрактиковать ddl и dml.
Усвоил, что ключи лучше делать num. Просто тут в силу небольшого объема данных, не стал делать их для всех таблиц. 

Концептуальная:

![img](https://github.com/lixikon2/DE-101/blob/main/Module2/conceptual_model.png)

Логическая:

![img](https://github.com/lixikon2/DE-101/blob/main/Module2/logical_model.png)

Физическая:

![img](https://github.com/lixikon2/DE-101/blob/main/Module2/physical%20data%20model.png)

### DDL and data insert

[DDL](https://github.com/lixikon2/DE-101/blob/main/Module2/DDL_Kimball.sql)

[Data insert](https://github.com/lixikon2/DE-101/blob/main/Module2/Insert.sql)

## Облачная БД Superbase

В силу отсутсвия возможности зарегаться в AWS из РФ, был выбран сервис [Superbase](https://app.supabase.io).


## Нарисовать графики в Cloud BI Data Lens выбрав в качестве источника данных Cloud DB

![img](https://github.com/lixikon2/DE-101/blob/main/Module2/DataLens_1.png)

![img](https://github.com/lixikon2/DE-101/blob/main/Module2/DataLens_2.png)
