select * from (

select c1.mk_code "№",
       c1.mk_fio "ФИО",
       c1.mk_birthday "Дата рождения",
       c1.mk_age "Возраст",
       case when length (substr (c1.clob1, instr(c1.clob1, 'CODE'  ) +7,
                                           instr(c1.clob1, '","NAME":' )  -7 -
                                           instr(c1.clob1, 'CODE' ))) < 10
            then substr (c1.clob1, instr(c1.clob1, 'CODE'  ) +7,
                                   instr(c1.clob1, '","NAME":' )  -7 -
                                   instr(c1.clob1, 'CODE' ))
            else  substr (c1.clob1, instr(c1.clob1, 'CODE'  ) +7,
                                    instr(c1.clob1, '","CONTENTS":"' ) -17   -
                                    instr(c1.clob1, 'CODE' ))
      end || ' ' || --"Код диагноза",
       case when length (substr (c1.clob1, instr(c1.clob1, 'NAME'  ) +7,
                                           instr(c1.clob1, '","CONTENTS"' )  -7 -
                                           instr(c1.clob1, 'NAME' ))) > 10
            then substr (c1.clob1, instr(c1.clob1, 'NAME'  ) +7,
                                   instr(c1.clob1, '","CONTENTS"' )  -7 -
                                   instr(c1.clob1, 'NAME' ))
           when length (substr (c1.clob1, instr(c1.clob1, '"CONTENTS"'  ) +13,
                                          instr(c1.clob1, '","NAME_CONTENTS"' )  -13 -
                                          instr(c1.clob1, '"CONTENTS"' )))> 10
           then substr (c1.clob1, instr(c1.clob1, '"CONTENTS"'  ) +12,
                                  instr(c1.clob1, '","NAME_CONTENTS"' )  -12 -
                                  instr(c1.clob1, '"CONTENTS"' ))
           else substr (c1.clob1, instr(c1.clob1, '"CONTENTS"'  ) +12,
                                  instr(c1.clob1, '","CLASS_TYPE"' )  -12 -
                                  instr(c1.clob1, '"CONTENTS"' ))
     end "Диагноз",
     c1.c_srv_code "Код операции",
     substr (c1.clob2, instr(c1.clob2, '"OPER_NAME"'  ) +13,
                       instr(c1.clob2, '","OPER_NAME2"' )  -13 -
                       instr(c1.clob2, '"OPER_NAME"' )) "Название операции",
     substr (c1.clob3, instr(c1.clob3, '"CONTENTS"'  ) +12,
                       instr(c1.clob3, '","KIND_ID"' )  -12 -
                       instr(c1.clob3, '"CONTENTS"' ))  "Осложнения"
   from
   (select
          m.kind || ' ' || m.code                    as mk_code,
          initcap(o_ib.get_full_fio(m.id))           as mk_fio,
          o_ib.get_birthday(m.id)                    as mk_birthday,
          o_ib.get_age(m.id)                         as mk_age,
          sc.code                                    as c_srv_code,
          x.id,
          to_char (substr(x.json_data, instr(x.json_data, 'PREOPER_DIAG') ,4000)) clob1,
          to_char (substr(x.json_data, 1 ,4000)) clob2,
          to_char (substr(x.json_data, instr(x.json_data, 'COMPLS') ,4000)) clob3
     from d_oper_cons c,
          doprots p,
          od_vec_srvs sc,
          wi.x$fd_fields fc,
          wi.x$fd_fields fp,
          t_med_chrts m,
          wi.xs$fd x
    where c.ec_srv_id is not null
      and c.status             != 99
      and p.status(+)          != 99
      and fc.status(+)          < 90
      and p.opcon_id(+)         = c.ID
      and sc.id                 = c.ec_srv_id
      and fc.f_d_oper_con_id(+) = c.id
      and fp.f_doprot_id    (+) = p.id
      and m.id                  = c.chart_id

      and sc.code1 like 'A16%'
      and p.s_str_org_id in ('1390')
      and fp.id  = x.id
      ) c1


   UNION
   select c1.mk_code "№",
       c1.mk_fio "ФИО",
       c1.mk_birthday "Дата рождения",
       c1.mk_age "Возраст",
       case when length (substr (c1.clob1, instr(c1.clob1, 'CODE'  ) +7,
                                           instr(c1.clob1, '","NAME":' )  -7 -
                                           instr(c1.clob1, 'CODE' ))) < 10
            then substr (c1.clob1, instr(c1.clob1, 'CODE'  ) +7,
                                   instr(c1.clob1, '","NAME":' )  -7 -
                                   instr(c1.clob1, 'CODE' ))
            else  substr (c1.clob1, instr(c1.clob1, 'CODE'  ) +7,
                                    instr(c1.clob1, '","CONTENTS":"' ) -17   -
                                    instr(c1.clob1, 'CODE' ))
      end || ' ' || --"Код диагноза",
       case when length (substr (c1.clob1, instr(c1.clob1, 'NAME'  ) +7,
                                           instr(c1.clob1, '","CONTENTS"' )  -7 -
                                           instr(c1.clob1, 'NAME' ))) > 10
            then substr (c1.clob1, instr(c1.clob1, 'NAME'  ) +7,
                                   instr(c1.clob1, '","CONTENTS"' )  -7 -
                                   instr(c1.clob1, 'NAME' ))
           when length (substr (c1.clob1, instr(c1.clob1, '"CONTENTS"'  ) +13,
                                          instr(c1.clob1, '","NAME_CONTENTS"' )  -13 -
                                          instr(c1.clob1, '"CONTENTS"' )))> 10
           then substr (c1.clob1, instr(c1.clob1, '"CONTENTS"'  ) +12,
                                  instr(c1.clob1, '","NAME_CONTENTS"' )  -12 -
                                  instr(c1.clob1, '"CONTENTS"' ))
           else substr (c1.clob1, instr(c1.clob1, '"CONTENTS"'  ) +12,
                                  instr(c1.clob1, '","CLASS_TYPE"' )  -12 -
                                  instr(c1.clob1, '"CONTENTS"' ))
     end "Диагноз",
     c1.c_srv_code "Код операции",
     substr (c1.clob2, instr(c1.clob2, '"OPER_NAME"'  ) +13,
                       instr(c1.clob2, '","OPER_NAME2"' )  -13 -
                       instr(c1.clob2, '"OPER_NAME"' )) "Название операции",
     substr (c1.clob3, instr(c1.clob3, '"CONTENTS"'  ) +12,
                       instr(c1.clob3, '","KIND_ID"' )  -12 -
                       instr(c1.clob3, '"CONTENTS"' ))  "Осложнения"
   from (
   select m.kind || ' ' || m.code                    as mk_code,
          initcap(o_ib.get_full_fio(m.id))           as mk_fio,
          o_ib.get_birthday(m.id)                    as mk_birthday,
          o_ib.get_age(m.id)                         as mk_age,
          sc.code                                    as c_srv_code,
          x.id,
          to_char (substr(x.json_data, instr(x.json_data, 'PREOPER_DIAG') ,4000)) clob1,
          to_char (substr(x.json_data, 1 ,4000)) clob2,
          to_char (substr(x.json_data, instr(x.json_data, 'COMPLS') ,4000)) clob3
     from doprots p,
          od_vec_srvs sc,
          wi.x$fd_fields fc,
          t_med_chrts m,
          wi.xs$fd x
    where opcon_id is null
      and p.status         != 99
      and fc.status(+)      < 90
      and sc.id             = p.ec_srv_id
      and fc.f_doprot_id(+) = p.id
      and m.id              = p.chart_id

      and sc.code1 like 'A16%'
      and p.s_str_org_id in ('1390')
      and fc.id  = x.id) c1
      )
order by "ФИО"
