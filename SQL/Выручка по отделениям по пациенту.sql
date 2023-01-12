select  R."Отделение",
        R."Отделение полное название",
        R."ФИО",
        R."№",
        R."Дата",
        R."Период",
        R."Код карты",
        R."Тип",
        R."Договор",
        R."Тип договора",
        R."Услуг",
        R.SRVS_SUMM_WD "Сумма",
          nvl(srvs_summ_wd, 0) - nvl(srvs_summ, 0) as "Скидка, надбавка",
        R.SRVS_SUMM "Итого"
     from (
   select s.shortname "Отделение",
          s.fullname "Отделение полное название",
          initcap (f.family ||' ' || f.name || ' ' || f.patronimic) "ФИО",
          --B.id "№",
          B.numbr || decode (B.numbr_seria, null, '',' ' || B.numbr_seria) as "№",
          to_char(B.billr_date,'dd.mm.yy') "Дата" ,
          to_char(b.period_from,'dd.mm.yy')||' - '||to_char(b.period_till,'dd.mm.yy') "Период",
          M.kind || ' ' || M.code "Код карты",
          L.name "Тип",
          (A.num || decode (A.seria, null, '', '/' || A.seria)
                 || decode (A.num || A.seria, null, ' ', ' ')
                 || decode (nvl(A.doc_date, A.from_date),null, '',' от ' || to_char (nvl(A.doc_date, A.from_date), 'dd.mm.yy'))) as "Договор",
          A.kind as "Тип договора",
          (select count(P.id) from ec_payments P where P.status < 99 and P.e_bill_id = B.id) as "Услуг",
          nvl((select sum(nvl(P.r_total, 0) * nvl(P.r_cost, 0)) from ec_payments P where P.status < 99 and P.e_bill_id = B.id), 0) as srvs_summ_wd,
          nvl((select sum(nvl(P.r_vsego, 0)) from ec_payments P where P.status < 99 and P.e_bill_id = B.id), 0) as srvs_summ,
          B.status,
          B.period_from,
          B.period_till,
          B.discount,
          B.author_up_id,
          B.author_in_id,

          B.bill_state,
          B.t_med_chrt_id


     from ec_bills    B,
          t_lovs      L,
          t_agreem_   A,
          t_med_chrts M,
          t_tlists t,
          t_fios f,
          s_dep_ways w,
          s_str_orgs s
    where A.ID = B.t_agreem_id
      and B.status <> 99
      and B.bill_state = L.id(+)
      and B.t_med_chrt_id = M.id
      and B.type = 1
      and M.status = 0
      and m.id = t.med_chrt_id
      and t.status = 0
      and t.fio_id = f.id (+)
      and w.t_med_chrt_id = m.id
      and w.s_str_org_s_str_org_id = s.s_str_org_id
      and w.kind != 'ПО'
      and w.result is not null
      and w.status = 0
      and s.s_str_org_id in (1391, 1395, 1749, 2654, 2656)
      and B.billr_date between to_date('01.01.2021', 'dd.mm.yyyy') and to_date('31.12.2021', 'dd.mm.yyyy')) R
