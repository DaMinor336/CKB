-- Вьюхи и таблицы ИНТЕРИН
--
select * from t_med_chrts -- Мед. карты

select * from t_tlists -- Титульные листы мед карт, id-шники Даты рождения, ФИО, Возраста; Привязаны к id t_med_chrts

select * from t_fios -- ФИО, id-шники в t_tlists

select * from t_sexs -- Полы, id-шники в t_tlists

select * from t_births -- Даты рождения, id-шники в t_tlists

select * from t_address -- Адреса, id-шники в t_tlists

select * from s_dep_ways -- Вьюха, перемещения больных, привязаны к id t_med_chrts

select * from ddg_heads -- Вьюха, талоны амбулаторных приевом, привязаны к id t_med_chrts

select * from od_vorders -- Заказы услуг

select * from s_str_orgs -- Отделения

select * from s_sht_rasps -- Штатное расписание

select * from s_sht_zaps -- Штатное заполнение (Исполнения) Список всех сотрудников и их должностей

select * from ddg_heads -- Шапки, привязаны к id t_med_chrts

select * from am_vsmp_ckbudp -- Вьюха, вызовы скорой помощи

select * from ec_srvs -- Услуги

 select * from od_orders -- Услуги по пациентам 

select * from ec_costs -- Стоимости услуг

select * from a.mkb10_ -- Коды МКБ по id

select * from t_lovquotas -- Системный справочник

select * from t_quotes -- Системный справочник

select * from t_lovgroups -- Системный справочник

select * from t_lovs -- Системный справочник

select * from od_vpriems -- Вьюха приемов пациента

select * from a.od_priems -- Таблица приемов пациента

select * from s_sht_rasps -- Коды должностей ЦКБ

select * from S_APPOINTS -- Название должностей в ЦКБ

select * from wi.xs$fd -- Хранилище с документами

select * from od_orders  -- Назначения на пациентов 

select * from n_medic_regs -- Лек. препараты

select * from od_drugs  -- Связь между назначениями и лек. препаратами 
