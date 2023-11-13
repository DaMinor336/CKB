select f.short_name "Страховая",
       case
         when c.kind = 'АК' then
          'Амбулатор'
         else
          'Стационар'
       end "Тип госпитализации",--hosp_kind,
       a.num "№ договора",
      -- b.t_med_chrt_id,
       c.code "№ ИБ",
       -- a.kind,
       to_char (b.billr_date, 'dd.mm.yyyy') "Дата реализации",
      (select sum(nvl(p.r_vsego, 0))
             from ec_payments p
            where p.e_bill_id = b.id
              and p.status <> 99
              and p.in_date between to_date('01.10.2023', 'dd.mm.yyyy') and
                  to_date('31.10.2023', 'dd.mm.yyyy')) "Выручка"
  from ec_bills b,
       t_agreems a, 
       t_med_chrts c, 
       t_firms f
 where b.t_agreem_id = a.id
   and c.id = b.t_med_chrt_id
   and a.t_firm_id = f.id
   and b.billr_date between to_date('01.10.2023', 'dd.mm.yyyy') and
       to_date('31.10.2023', 'dd.mm.yyyy')
   and b.status <> 99
   and c.status <> 99
   and a.status <> 99
   and a.kind in ('ДМС')
   and c.kind = 'ИБ'
  -- and a.kind not in ('Бюджетный', 'ОМС')
  -- group by f.short_name, b.t_med_chrt_id, a.kind, c.kind
 order by f.short_name, b.t_med_chrt_id, a.kind