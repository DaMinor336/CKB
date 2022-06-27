--Интеграция с парусом
--
-- Ошибки в импорте заместительст. Журнал интеграция
select *
from z.ckb_import_logs
where process='Импорт заместителей' and
      action='Ошибка' and
      crt_date>to_date('01.05.2022 13:00','dd.mm.yyyy hh24:mi')
order by id
--
-- Отсутствуют даты заврешения замещений

select *
from usr_prordersp_zamest_ar@parus
where dwork>to_date('01.05.2022','dd.mm.yyyy') and
      dbend_for is null and
      dbend_for_alt is null and
      dbend_for_alt2 is null

      --and sdocpref = '2019Л' and sdocnumb = '2660'

   --  and sclnpersons like 'Рафаэлова%'
 --
 -- Пакет импорта из паруса
 Z.CKB_IMPORT_PARUS
