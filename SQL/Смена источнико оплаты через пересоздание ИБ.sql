select row_number() over(order by lpad(c1.org, 10, '0')  ' '  c1.fio) rn,
       c1.*,
       c2.*
--,c2.in_date - c1.out_date 
  from (select m.t_person_id,
               w.t_med_chrt_id,
               'ИБ'  ' '  m.code chart_code,
               --to_char(w.in_date, 'dd.mm.yyyy') in_date,
               --to_char(w.out_date, 'dd.mm.yyyy') out_date,
               w.in_date,
               w.out_date,
               initcap(f.family  ' '  f.name  ' '  f.patronimic) fio,
               wix.stat_hsp_ckbudp.get_main_payment(m.id, 'name') agreem,
               s.code  ' '  nvl(s.sname, nvl(s.shortname, s.fullname)) org
          from t_med_chrts m,
               t_tlists    t,
               t_fios      f,
               s_dep_ways  w,
               s_str_orgs  s
         where m.id = t.med_chrt_id
           and t.fio_id = f.id
           and m.id = w.t_med_chrt_id
           and w.s_str_org_s_str_org_id = s.s_str_org_id
           and m.status = 0
           and t.status = 0
           and m.kind = 'ИБ'
           and nvl(m.note, '?') != 'ПИБ'
           and w.kind = 'ПОЛОЖЕН'
           and w.status = 0
           and w.out_date is not null
           and (select wix.stat_hsp_ckbudp.get_tlist_conts(m.id, 'NEWBORN')
                  from dual) = '0'
           and nvl(wix.stat_hsp_ckbudp.get_tlist_conts(m.id, 'HOSP_TYPE'),
                   '?') != 'По уходу'
           and m.code != '-1'
           and w.in_date between
               to_date('01.01.2022', 'dd.mm.yyyy hh24:mi:ss') and
               to_date('10.02.2022', 'dd.mm.yyyy hh24:mi:ss')) c1
  join (select m.t_person_id t_person_id2,
               w.t_med_chrt_id t_med_chrt_id2,
               'ИБ'  ' '  m.code chart_code2,
               --to_char(w.in_date, 'dd.mm.yyyy') in_date,
               --to_char(w.out_date, 'dd.mm.yyyy') out_date,
               w.in_date in_date2,
               w.out_date out_date2,
               initcap(f.family  ' '  f.name  ' '  f.patronimic) fio2,
               wix.stat_hsp_ckbudp.get_main_payment(m.id, 'name') agreem2,
               s.code  ' '  nvl(s.sname, nvl(s.shortname, s.fullname)) org2
          from t_med_chrts m,
               t_tlists    t,
               t_fios      f,
               s_dep_ways  w,
               s_str_orgs  s
         where m.id = t.med_chrt_id
           and t.fio_id = f.id
           and m.id = w.t_med_chrt_id
           and w.s_str_org_s_str_org_id = s.s_str_org_id
           and m.status = 0
           and t.status = 0
           and m.kind = 'ИБ'
           and nvl(m.note, '?') != 'ПИБ'
           and w.kind = 'ПОЛОЖЕН'
           and w.status = 0
           and (select wix.stat_hsp_ckbudp.get_tlist_conts(m.id, 'NEWBORN')
                  from dual) = '0'
           and nvl(wix.stat_hsp_ckbudp.get_tlist_conts(m.id, 'HOSP_TYPE'),
                   '?') != 'По уходу'
           and m.code != '-1'
           and w.in_date between
               to_date('01.01.2022', 'dd.mm.yyyy hh24:mi:ss') and
               to_date('10.02.2022', 'dd.mm.yyyy hh24:mi:ss')) c2
    on c1.t_person_id = c2.t_person_id2
   and c1.chart_code != c2.chart_code2
   and c2.in_date2 > c1.out_date
   and (c2.in_date2 - c1.out_date) <= 1.5
 order by rn