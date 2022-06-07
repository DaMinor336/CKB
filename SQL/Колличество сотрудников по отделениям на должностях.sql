select o.s_str_org_id "ID ���������",
       min(o.fullname) "������ �������� ���������",
       min(o.shortname) "�������� �������� ���������",
       a.s_appoint_id "ID ���������",
       min(a.fullname) "�������� ���������",
       min(a.kind) "��� ���������",
       count(s.t_person_id) "����������� �����������"
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
