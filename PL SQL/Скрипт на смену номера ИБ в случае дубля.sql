declare
  ak_num number;
begin
    ak_num     := t_chrt_codes.get_numb_next(
      'ИБ',
      1,
      99999999,
      'ANY',
      'FIRST_FREE',
      'I_MC'); -- Для круглостуточного стационара.
					     -- Для дневного и третьего стационара, а также для амбулаторных
               -- необходимо использовать другую компоненту

    t_chrt_codes.lock_chart_number(
      ak_num,
      'ИБ',
      'I_MC');

	 update t_med_chrts m
		 set m.code = ak_num
	where m.id = ??????? --ID ИБ

  dbms_output.put_line('ib_num= '||ak_num); -- Строка для отладки
end;
