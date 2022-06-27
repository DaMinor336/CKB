/*
 ������ ������ ������������ ��� ����� ���� �������������� �����, ��� ��� �����. ��, ������ ������ ������� ������ �������,
��� - ��������������� ������, ������� ����� �������� ��� ������ ���������� ������. ����� ����������� ���������� � �������.
�������� � ������� s_dep_ways. ��������� �����, ��� �� ����� ����� ������ ���� �� ���� ������������.
*/

select * from t_med_chrts m where m.id = 636016  -- ���� ��

select * from s_j001us j where j.t_med_chrt_id = 636016  -- ��������� ������ �������������� 

select * from s_dep_ways s where s.t_med_chrt_id = 636016 -- ��������� ����������� � ���������� 

select * from t_tlists t where t.med_chrt_id = 636016 and t.status <> 99  -- ��������� ��������� ����

declare 

med_chrt number := 636016;  -- Id �� �� t_med_chrts 
new_date date := to_date('03.06.2022 08:46:00','dd.mm.yyyy hh24:mi:ss'); -- ���� �� ������� ����� �������� 

begin
  
   -- ������ ���� � ��� �����
    update t_med_chrts t 
       set t.in_date = new_date,
           t.crt_date = new_date
     where t.id = med_chrt;

   -- ������ ���� � ������������, � ���� ������ ����� ���� ��� ��������, �� ������ ���� ������ � 1-2, ������� ����������� � ��������� 
    update s_dep_ways s                       
       set s.in_date = new_date
     where s.t_med_chrt_id = med_chrt and s.status <> 99;
 
   -- ������ ���� �������� ���������� ����� 
    update t_tlists tl
       set tl.crt_date = new_date, 
           tl.in_date = new_date 
     where tl.med_chrt_id = med_chrt and status <> 99; 
    
   -- ������ ���� � ������� ��������������
    update s_j001us j 
       set j.in_date = new_date
     where j.t_med_chrt_id = med_chrt and j.status <> 99;
     
end;
