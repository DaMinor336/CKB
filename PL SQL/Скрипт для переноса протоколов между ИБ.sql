--
-- Перенос диагностических протоколов между разными ИБ со сменой источника оплаты
-- ВНИМАТЕЛЬНО ПРОВЕРЯЙТЕ УСЛОВИЯ ПЕРЕД ЗАПУСКОМ СКРИПТА!!!
--

declare
 -- Старое
  old_chart_id number := 591660; -- старый t_med_chrt_id
 -- Новое
  new_chart_id number := 595924; -- новый t_med_chrt_id
  new_tpay_id  number := 994202; -- новый id из t_tl_tpays
begin
  update od_vorders -- Таблица с заказами исследований
     set chart_id     = new_chart_id,
         t_tl_tpay_id = new_tpay_id
  where id in (select od_order_id from od_vpriem_protocols where t_med_chrt_id = old_chart_id and crt_date > to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi'));

  update od_vpriems -- Таблица с приемами
     set t_med_chrt_id= new_chart_id,
         t_tl_tpay_id = new_tpay_id
  where id in (select od_priem_id from od_vpriem_protocols where t_med_chrt_id = old_chart_id and crt_date > to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi'));

  update wi.xs$fd -- Хранилище с протоколами приемов
     set parent_id= new_chart_id
  where id in (select attr_value from od_veattrs where od_exec_id in (
                 select od_exec_id from od_vpriem_protocols where t_med_chrt_id = old_chart_id and crt_date > to_date('08.12.2021 09:00','dd.mm.yyyy hh24:mi')
               ) and attr_name='WI_DOC_ID');
end;

-- Для проверки себя

  select * from od_vorders where id in (select od_order_id from od_vpriem_protocols where t_med_chrt_id=583516)

  select * from od_vpriems where id in (select od_priem_id from od_vpriem_protocols where t_med_chrt_id=583516)

  select * from wi.xs$fd where id in (select attr_value from od_veattrs where od_exec_id in (select od_exec_id from od_vpriem_protocols where t_med_chrt_id=583516) and attr_name='WI_DOC_ID')

  select * from t_tl_tpays where t_med_chrt_id=595924 -- получить новый t_tl_tpay_id
