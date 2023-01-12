select --i.id id_strah,
       max (i.name) name_strah,
       max(i.numm) agreem_num,
      -- i.s_str_org_id,
       max(i.shortname) shortname,
       max(i.fullname) fullname,
       --i.count_persons,
       --min (i.count_persons) count_persons_period,
       (select   /*aa.id,
                      aa.name,
                      a.num numm,
                      a.id id_dogovor,
                      a.Header name_dogovor,*/
                      distinct count (distinct t.id) over (PARTITION BY  aa.id) count_persons/*,
                      o.s_str_org_id,
                      o.shortname,
                      o.fullname,
                      r.id od_order_id,
                      t.id t_med_chrt_id,
                      p.id od_priem_id,
                      c.id od_case_id,
                      t.id mk_id,
                      t.kind mk_kind,
                      t.code mk_code,
                      null mk_out_date,
                      trunc(r.r_date) srv_date,
                      trim(mp.seria||' '||mp.numb) srv_policy,
                      rq.name srv_pay,
                      s.id srv_id,
                      s.code srv_code,
                      s.code1 srv_code1,
                      nvl(s.fullname,s.name) srv_name,
                      s.code||' '||nvl(s.fullname,s.name) srv_code_name,
                      nvl(r.r_summ,0) srv_summ,
                      nvl2(p.id,1,0) srv_priem*/
                 from od_vorders r,
                      ec_srvs s,
                      t_lovs rq,
                      ec_dicts ed,
                      s_sht_zaps z1,
                      t_fios f1,
                      s_sht_zaps z2,
                      t_fios f2,
                      s_str_orgs o,
                      t_agreem_ a,
                      t_tl_tpays tp,
                      t_mpolicies mp,
                      t_med_chrts t,
                      t_tlists l,
                      t_fios f0,
                      od_vexecs e,
                      od_vpriems p,
                      od_vcase_conts cc,
                      od_vcases c,
                      t_firms aa
                where r.status = 0 and
                      r.r_status = 1 and
                      r.r_service_id = s.id and
                      r.payment_type_code = rq.code(+) and
                      rq.group_name (+) = 'Вид оплаты' and
                     -- r.payment_type_code = 'Д' and
                      r.stype = ed.name(+) and
                      ed.status (+)= 0 and
                      r.s_sht_zap_id = z1.s_sht_zap_id(+) and
                      z1.t_person_id = f1.t_person_id(+) and
                      f1.status (+)= 0 and
                      r.s_sht_zap2_id = z2.s_sht_zap_id(+) and
                      z2.t_person_id = f2.t_person_id(+) and
                      f2.status (+)= 0 and
                      r.s_str_org_id = o.s_str_org_id(+) and
                      r.t_agreem_id = a.id(+) and
                      r.t_tl_tpay_id = tp.id(+) and
                      tp.t_mpolicy_id = mp.id(+) and
                      r.chart_id = t.id and
                      t.kind = 'ИБ' and
                      t.status = 0 and
                      t.id = l.med_chrt_id and
                      l.status = 0 and
                      l.fio_id = f0.id and
                      r.id = e.od_order_id(+) and
                      e.status (+)= 0 and
                      e.od_priem_id = p.id(+) and
                      p.status (+)< 99 and
                      p.id = cc.doc_idl(+) and
                      cc.status (+)= 0 and
                      cc.doc_type (+)= 'PRIEM' and
                      cc.od_case_id = c.id(+) and
                      aa.id = a.t_firm_id and --(+)
                      aa.status <> 99 and
                      a.num = '67' and
                      r.r_date between to_date   ('01.01.2022' , 'dd.mm.yyyy')
                                   and to_date   ('31.12.2022' , 'dd.mm.yyyy')
                      and i.s_str_org_id = o.s_str_org_id
                      and a.id = i.id_dogovor
                      ) count_persons_period,
       --avg (i.count_persons) over (PARTITION BY i.s_str_org_id),
       count (i.srv_name) count_srv_period,
       sum (i.srv_summ) srv_summ_period--,
      -- round (avg (i.srv_summ), 2) avg_summ_period
  from      (select   aa.id,
                      aa.name,
                      a.num numm,
                      a.id id_dogovor,
                      a.Header name_dogovor,
                      count (distinct t.id) over (PARTITION BY  aa.id) count_persons,
                      o.s_str_org_id,
                      o.shortname,
                      o.fullname,
                      r.id od_order_id,
                      t.id t_med_chrt_id,
                      p.id od_priem_id,
                      c.id od_case_id,
                      t.id mk_id,
                      t.kind mk_kind,
                      t.code mk_code,
                      null mk_out_date,
                      trunc(r.r_date) srv_date,
                      trim(mp.seria||' '||mp.numb) srv_policy,
                      rq.name srv_pay,
                      s.id srv_id,
                      s.code srv_code,
                      s.code1 srv_code1,
                      nvl(s.fullname,s.name) srv_name,
                      s.code||' '||nvl(s.fullname,s.name) srv_code_name,
                      nvl(r.r_summ,0) srv_summ,
                      nvl2(p.id,1,0) srv_priem
                 from od_vorders r,
                      ec_srvs s,
                      t_lovs rq,
                      ec_dicts ed,
                      s_sht_zaps z1,
                      t_fios f1,
                      s_sht_zaps z2,
                      t_fios f2,
                      s_str_orgs o,
                      t_agreem_ a,
                      t_tl_tpays tp,
                      t_mpolicies mp,
                      t_med_chrts t,
                      t_tlists l,
                      t_fios f0,
                      od_vexecs e,
                      od_vpriems p,
                      od_vcase_conts cc,
                      od_vcases c,
                      t_firms aa
                where r.status = 0 and
                      r.r_status = 1 and
                      r.r_service_id = s.id and
                      r.payment_type_code = rq.code(+) and
                      rq.group_name (+) = 'Вид оплаты' and
                      --r.payment_type_code = 'Д' and
                      r.stype = ed.name(+) and
                      ed.status (+)= 0 and
                      r.s_sht_zap_id = z1.s_sht_zap_id(+) and
                      z1.t_person_id = f1.t_person_id(+) and
                      f1.status (+)= 0 and
                      r.s_sht_zap2_id = z2.s_sht_zap_id(+) and
                      z2.t_person_id = f2.t_person_id(+) and
                      f2.status (+)= 0 and
                      r.s_str_org_id = o.s_str_org_id(+) and
                      r.t_agreem_id = a.id(+) and
                      r.t_tl_tpay_id = tp.id(+) and
                      tp.t_mpolicy_id = mp.id(+) and
                      r.chart_id = t.id and
                      t.kind = 'ИБ' and
                      t.status = 0 and
                      t.id = l.med_chrt_id and
                      l.status = 0 and
                      l.fio_id = f0.id and
                      r.id = e.od_order_id(+) and
                      e.status (+)= 0 and
                      e.od_priem_id = p.id(+) and
                      p.status (+)< 99 and
                      p.id = cc.doc_idl(+) and
                      cc.status (+)= 0 and
                      cc.doc_type (+)= 'PRIEM' and
                      cc.od_case_id = c.id(+) and
                      aa.id = a.t_firm_id and --(+)
                      aa.status <> 99 and
                      a.num = '67' and
                      -- o.s_str_org_id = 1768 and --
                      r.r_date between to_date   ('01.01.2022' , 'dd.mm.yyyy')
                                   and to_date   ('31.12.2022' , 'dd.mm.yyyy')) i
  group by i.id_dogovor, i.s_str_org_id --,i.count_persons  --i.id, i.numm/*, i.t_med_chrt_id/*, mk_fio /*, i.srv_code --order by header */
 order by  max(i.shortname)
