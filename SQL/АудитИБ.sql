select au.in_date date_time,
  au.author_user user_log,
  au.subject_person_id,
  initcap(s_fgetfio(au.author_sht_zap_id)) AUTHOR_FIO_FULL,
  (select max(b.birthday) from t_births b where b.t_person_id = au.author_person_id) birtday,
  (select max(x.sex) from t_sexs x where x.t_person_id = au.author_person_id) sex,
  (select nvl(o.shortname,o.fullname) from s_str_orgs o, s_sht_zaps z, s_sht_rasps r where z.s_sht_rasp_s_sht_rasp_id=r.s_sht_rasp_id
                                                           and r.s_str_org_s_str_org_id=o.s_str_org_id
                                                           and z.s_sht_zap_id = au.author_sht_zap_id) org_name,
  (select lower(nvl(a.shortname,a.fullname)) from s_str_orgs o, s_sht_zaps z, s_sht_rasps r, s_appoints a where z.s_sht_rasp_s_sht_rasp_id=r.s_sht_rasp_id
                                                           and r.s_str_org_s_str_org_id=o.s_str_org_id
                                                           and r.s_appoint_s_appoint_id=a.s_appoint_id
                                                           and z.s_sht_zap_id = au.author_sht_zap_id) appoint,
  case when au.author_person_id = 3457 then 'Лечащий врач' else '' end prop,
  au.description descr
from sd_audit_lst au where au.subject_person_id = 467047 and  au.event_action = 'IB_VIEW'
