-- НЕ УВЕРЕН КАК ДЕЛАТЬ - НЕ ЗАПУСКАЙ!!
-- По-большей части это не скрипт, а перечисление таблиц, которые нужно менять
-- В зависимости от года, того, что нужно перенсти, типа МК - МОГУТ МЕНЯТЬСЯ ТАБЛИЦЫ И ПОЛЯ, КОТОРЫЕ НУЖНО ПЕРЕБИВАТЬ
-- ПЕРЕД ПЕРЕБИВОМ НА БОЕВОЙ - ПРОБУЙТЕ НА ТЕСТОВОЙ
-- ПОЛУЧИЛОСЬ - ИДЕМ НА ТЕСТОВУЮ
-- НЕ ГОНИМ СРАЗУ ВСЕ, ДЕЛАЕМ ВСЕ ПОСТЕПЕННО
-- ПЕРЕД КОММИТАМИ - ПРОВЕРЯЕМ СЕЛЕКТАМИ, ПРАВИЛЬНО ЛИ ВСЕ ЗАПИСАЛОСЬ

--
-- Заменить операции эпикризы и протоколы
select * from dopers where t_med_chrt_id=591660
select * from doprots where chart_id in (591660,595924)
select * from d_oper_cons where chart_id in (591660,595924)

select * from wi.x$FD_FIELDS where f_d_oper_con_id=26324

select * from wi.x$FD_FIELDS where f_doprot_id=30023

select * from wi.xs$fd where id='31C95CD0DC6D428CBE785FF846A586F1'
select * from wi.xs$fd where id='B574696311194CAFA9C282BEF2D74F1E'

-- Скрипт на перебив id ИБ в протоколах, саму таблицу wi.xs$fd МЕНЯТЬ НЕ НАДО!
-- ПЕРЕД ЗАПУСКОМ СКРИПТА УБЕДИТЕСЬ КАКОЕ ПОЛЕ В JSON ВАМ НАДО ПОМЕНЯТЬ, В КАКИХ-ТО НУЖНО МЕНЯТЬ PARENT_ID, В КАКИХ-ТО CHART_ID
-- А ГДЕ-ТО НУЖНО МЕНЯТЬ ОБА ПОЛЯ

declare
  obj json;
begin
  obj := wi.jsdb.get('fd','31C95CD0DC6D428CBE785FF846A586F1');
  obj.put('PARENT_ID','595924');
  obj.put('CHART_ID',595924);
  wi.jsdb.put(obj);
end;

--
-- Перенос анализов

select * from od_vorders -- Таблица с заказами
 where chart_id=591660
   and stype='ST_LAB'
   and r_status=0
   and o_date > to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi')

select * from od_vblanks -- Таблица с бланками
 where t_med_chrt_id=591660
   and crt_date> to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi')

update od_vorders
   set chart_id=595924, t_tl_tpay_id=994202
 where chart_id=591660 and stype='ST_LAB' and r_status=0 and o_date > to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi'

update od_vblanks
   set t_med_chrt_id=595924, t_tl_tpay_id=994202
 where t_med_chrt_id=591660 and crt_date> to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi')

--
-- Перенос медикаментозных назначений

select * from od_vorders -- Таблица с заказами
 where chart_id=591660
   and stype='ST_MED'
   and r_status=0
   and o_date > to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi')

update od_vorders
   set chart_id=595924, t_tl_tpay_id=994202
 where chart_id=591660 and stype='ST_MED' and r_status=0 and o_date > to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi')


-- Проверка

select * from od_vorders where chart_id=591660 and o_date > to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi')

select * from od_vpriems where t_med_chrt_id=591660 and crt_date > to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi')

select * from od_vpriem_protocols where t_med_chrt_id=595924 and crt_date > to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi') order by od_priem_id
