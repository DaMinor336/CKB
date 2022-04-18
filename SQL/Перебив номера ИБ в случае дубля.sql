declare
  ak_num number;
begin
    ak_num     := t_chrt_codes.get_numb_next(
      'ИБ', 
      1,
      99999999,
      'ANY',
      'FIRST_FREE',
      'I_MC');

    t_chrt_codes.lock_chart_number(
      ak_num,
      'ИБ',
      'I_MC');
  dbms_output.put_line('ib_num= '||ak_num);
end;
