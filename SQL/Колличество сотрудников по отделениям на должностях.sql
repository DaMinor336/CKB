select o.s_str_org_id "ID отделения",
       min(o.fullname) "Полное название отделения",
       min(o.shortname) "Короткое название отделения",
       a.s_appoint_id "ID Должности",
       min(a.fullname) "Название должности",
       min(a.kind) "Тип должности",
       count(s.t_person_id) "Колличество сотрудников"
from s_str_orgs o,
     s_sht_rasps r,
     S_APPOINTS a,
     S_SHT_ZAPS s
where o.s_str_org_id = r.s_str_org_s_str_org_id
  and r.s_appoint_s_appoint_id = a.s_appoint_id
  and r.s_sht_rasp_id = s.s_sht_rasp_s_sht_rasp_id
  and s.status = 0
  and o.status = 0
  and r.status = 0
  and a.status = 0
  group by a.s_appoint_id, o.s_str_org_id
  order by min(o.fullname)
