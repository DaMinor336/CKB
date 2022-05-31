   select s.s_str_org_id,
          i.fullname inst,
          s.code,
          s.shortname name,
          nvl((select sum(nvl(db.numb_shtat,0))
                  from s_depbeds db
                 where db.status = 1 and
                       db.s_str_org_id = s.s_str_org_id and
                       sysdate between db.bdate and nvl(db.edate,future_date)),0) cnt_bed_sht,
          f.room,
          fcq.code c_code,
          fcq.name c_name,
          (select count(*) from s_beds b where f.s_funcstr_id = b.s_funcstr_s_funcstr_id and b.status = 0) bed_cnt
     from s_str_orgs s,
          s_funcstrs f,
          s_categories fc,
          t_lovquotas fcq,
          sd_instances i
    where s.status = 0
      and s.medkind = 'КОЕЧНЫЙ ФОНД'
      and s.s_str_org_id = f.s_str_org_s_str_org_id
      and f.status = 0
      and f.kind = 'ПАЛАТА'
      and s.instance = i.name
      and f.category_id = fc.id(+)
      and fc.status (+)= 0
      and fc.t_lovquota_id = fcq.id(+)
    order by i.code, s.shortname, room
