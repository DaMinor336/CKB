/*
 Данный скрипт предназначен для смены даты госпитализации везде, где это нужно. Но, каждый случай требует своего подхода,
это - унифицированный скрипт, который нужно изменять под каждый конкретный случай. Важно внимательно отнеститсь к условям.
Особеноо к таблице s_dep_ways. Вероятнее всего, вам не нужно будет менять даты во всех перемещениях.
*/

select * from t_med_chrts m where m.id = 636016  -- Ищем МК

select * from s_j001us j where j.t_med_chrt_id = 636016  -- Проверяем журнал госпитализаций

select * from s_dep_ways s where s.t_med_chrt_id = 636016 -- Проверяем перемещения в стационаре

select * from t_tlists t where t.med_chrt_id = 636016 and t.status <> 99  --- Проверяем титульный лист

declare

med_chrt number := 636016;  -- Id МК из t_med_chrts
new_date date := to_date('03.06.2022 08:46:00','dd.mm.yyyy hh24:mi:ss');  -- Дата на которую хотим поменять

begin

   -- Меняем дату в мед карте
    update t_med_chrts t
       set t.in_date = new_date,
           t.crt_date = new_date
     where t.id = med_chrt;

   -- Меняем дату в перемещениях, в моем случае нужно было все поменять,
   -- но обычно надо только в 1-2, поэтому внимательно с улсовиями
    update s_dep_ways s
       set s.in_date = new_date
     where s.t_med_chrt_id = med_chrt and s.status <> 99;

   -- Меняем дату создания титульного листа
    update t_tlists tl
       set tl.crt_date = new_date,
           tl.in_date = new_date
     where tl.med_chrt_id = med_chrt and status <> 99;

   -- Меняем дату в журнале госпитализаций
    update s_j001us j
       set j.in_date = new_date
     where j.t_med_chrt_id = med_chrt and j.status <> 99;

end;
