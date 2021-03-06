-- Расшифровка json анкет диетпитания
select x.id,
       x.date_in,
       x.date_out,
       x.author_in,
       x.code ib,
       x.parent_id,
       wi.jsdb.get_value('fd', x.id ,'FIO' ) fio,
       wi.jsdb.get_value('fd', x.id ,'AGE' ) age,
       x.status,
       x.doc_type,
       x.name,
       case when
            decode(wi.jsdb.get_value('fd', x.id ,'FISH' ),'true', 1, 0) = '1'  or
            decode(wi.jsdb.get_value('fd', x.id ,'SEA'  ),'true', 1, 0) = '1'  or
            decode(wi.jsdb.get_value('fd', x.id ,'ORE'  ),'true', 1, 0) = '1'  or
            decode(wi.jsdb.get_value('fd', x.id ,'MILK' ),'true', 1, 0) = '1'  or
            decode(wi.jsdb.get_value('fd', x.id ,'MEAT' ),'true', 1, 0) = '1'  or
            decode(wi.jsdb.get_value('fd', x.id ,'EGG'  ),'true', 1, 0) = '1'  or
            decode(wi.jsdb.get_value('fd', x.id ,'VEG'  ),'true', 1, 0) = '1'  or
            decode(wi.jsdb.get_value('fd', x.id ,'FRU'  ),'true', 1, 0) = '1'  or
            decode(wi.jsdb.get_value('fd', x.id ,'CIT'  ),'true', 1, 0) = '1'  or
            decode(wi.jsdb.get_value('fd', x.id ,'GLU'  ),'true', 1, 0) = '1'  or
            decode(wi.jsdb.get_value('fd', x.id ,'ANOTHER'  ),'Да', 1, 0) = '1'
            then 'Да'
            else 'Нет'
       end all_alerg,
       wi.jsdb.get_value('fd', x.id ,'VIP'  ) VIP,
       decode(wi.jsdb.get_value('fd', x.id ,'SUGAR'),'true', 'Да', 'Нет') sugar,
       decode(wi.jsdb.get_value('fd', x.id ,'FISH' ),'true',  'Да', 'Нет') fish,
       decode(wi.jsdb.get_value('fd', x.id ,'NOT1' ),'true',  'Да', 'Нет') vfish,
       decode(wi.jsdb.get_value('fd', x.id ,'SEA'  ),'true',  'Да', 'Нет') sea,
       decode(wi.jsdb.get_value('fd', x.id ,'NOT2' ),'true',  'Да', 'Нет') vsea,
       decode(wi.jsdb.get_value('fd', x.id ,'ORE'  ),'true',  'Да', 'Нет') ore,
       decode(wi.jsdb.get_value('fd', x.id ,'NOT3' ),'true',  'Да', 'Нет') vore,
       decode(wi.jsdb.get_value('fd', x.id ,'MILK' ),'true',  'Да', 'Нет') milk,
       decode(wi.jsdb.get_value('fd', x.id ,'NOT4' ),'true',  'Да', 'Нет') vmilk,
       decode(wi.jsdb.get_value('fd', x.id ,'MEAT' ),'true',  'Да', 'Нет') meat,
       decode(wi.jsdb.get_value('fd', x.id ,'NOT5' ),'true',  'Да', 'Нет') vmeat,
       decode(wi.jsdb.get_value('fd', x.id ,'EGG'  ),'true',  'Да', 'Нет') egg,
       decode(wi.jsdb.get_value('fd', x.id ,'NOT6' ),'true',  'Да', 'Нет') vegg,
       decode(wi.jsdb.get_value('fd', x.id ,'VEG'  ),'true',  'Да', 'Нет') veg,
       decode(wi.jsdb.get_value('fd', x.id ,'NOT7' ),'true',  'Да', 'Нет') vveg,
       decode(wi.jsdb.get_value('fd', x.id ,'FRU'  ),'true',  'Да', 'Нет') fru,
       decode(wi.jsdb.get_value('fd', x.id ,'NOT8' ),'true',  'Да', 'Нет') vfru,
       decode(wi.jsdb.get_value('fd', x.id ,'CIT'  ),'true',  'Да', 'Нет') cit,
       decode(wi.jsdb.get_value('fd', x.id ,'NOT9' ),'true',  'Да', 'Нет') vcit,
       decode(wi.jsdb.get_value('fd', x.id ,'GLU'  ),'true',  'Да', 'Нет') glu,
       decode(wi.jsdb.get_value('fd', x.id ,'NOT10'),'true',  'Да', 'Нет') vglu,
       wi.jsdb.get_value('fd', x.id ,'ANOTHER1') comm_al,
       wi.jsdb.get_value('fd', x.id ,'COMM') comm
from  wi.xs$fd x
where x.doc_type like 'FD.ANKETA_PIT' and
      x.status = 0
