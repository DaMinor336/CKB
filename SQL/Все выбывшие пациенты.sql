-- Все выбывшие пациенты 
--
  SELECT u.in_date hosp_in_date,
         w.out_date hosp_out_date,
         case when trunc (w.out_date) - trunc (u.in_date) = 0
              then 1
              else trunc (w.out_date) - trunc (u.in_date)
         end bed_days,
         m.code ib_code,
         initcap (f.family ' ' f.name ' ' f.patronimic) fio,
         b.birthday,
         floor (months_between (trunc (w.out_date) , b.birthday) / 12) age,
         k.code mkb,
         (SELECT nvl (n.name , j.contents)
            FROM ddg_heads j,
            a.mkb10_ n
            WHERE j.mkb10_id = n.id (+)
            and j.status = 0
            and j.kind = 'патологоанатомический'
            and j.id in (SELECT max (id)
                         FROM ddg_heads
                         WHERE status = 0
                               and kind = 'патологоанатомический'
                               and chart_id = j.chart_id)
                               and j.chart_id = m.id) diag_name_pat
    FROM s_dep_ways w,
         t_med_chrts m,
         t_tlists t,
         t_fios f,
         t_births b,
         t_sexs x,
         s_str_orgs s,
         t_whosents r,
         s_dep_ways u,
         wdischarges d,
         ddg_heads h,
         a.mkb10_ k,
         t_address al
    WHERE w.t_med_chrt_id = m.id
      and m.id = t.med_chrt_id
      and t.fio_id = f.id (+)
      and t.birth_id = b.id (+)
      and t.sex_id = x.id (+)
      and w.s_str_org_s_str_org_id = s.s_str_org_id
      and m.id = r.t_med_chrt_id (+)
      and m.id = u.t_med_chrt_id
      and m.id = d.t_med_chrt_id (+)
      and d.end_ddg_head_id = h.id (+)
      and h.mkb10_id = k.id (+)
      and t.address_id = al.id (+)
      and t.address_reg_id = al.id (+)
      and m.status = 0
      and t.status = 0
      and r.status (+) = 0
      and u.status = 0
      and d.status (+) != 99
      and w.kind != 'ПО'
      and w.result is not null
      and m.kind = 'ИБ'
      and nvl (m.note , '?') != 'ПИБ'
      and u.kind = 'ПО'
      and w.status = 0
