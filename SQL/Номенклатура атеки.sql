select --mr.id,
        -- mr.parent_id,
         --mr.in_date,
         mr.name "Учетное наименование",
         --mr.short_name,
        -- mr.form_name,
         --mr.drug_form,
         --mr.dosage,
         --m1.id measure_id,
         m1.short_name "Крупн. ед. изм.",--measure,
        -- mr.neu,
         mr.factor "Коэфф.",
        -- m2.id small_measure_id,
         m2.short_name "Мелк. ед. изм.",--small_measure,
         --mr.barcode_orig,
        -- mr.barcode_1,
        -- mr.barcode_2,
        -- mr.barcode_3,
        -- mr.inter_name_id,
        -- na_in.name inter_name,
        -- na_in.s_name inter_s_name,
        -- mr.pharm_gr_id,
        -- na_pg.name pharm_gr,
        -- mr.store_cond,
        -- mr.vital,
         --mr.latin_name,
         --mr.latin_form_name,
         --mr.country_id,
         --na_c.name country,
        -- mr.firm_id,
        -- na_f.name firm,
        -- mr.payment_id,
         --nvl(na_p.s_name,nvl(na_p.fullname,na_p.name)) payment,
        -- mr.store_gr_id,
         nvl(na_sg.fullname,na_sg.name) "Товарная группа"--store_gr--,
        -- decode(mr.object_stock,'Y','Y','N','N') object_stock_id,
         --decode(mr.object_stock,'Y','Да','N','Нет') object_stock,
        -- mr.stock_gr_id,
        -- na_sk.name stock_gr,
        -- mr.ethanol_qty,
        -- mr.method_use_id,
        -- na_mu.name method_use,
        -- mr.method_use method_use_text,
        -- mr.direction_for_use,
        -- (select max(a.value)
         --   from n_medreg_stores a
         --  where a.registry_id = mr.id and
         --        a.dictionary_id = 2) store_place,
        -- mr.status,
        -- decode(mr.status,0,'А','У') status_text,
       --  mr.name_doctor,
       --  mr.lat_name_doctor,
       --  mr.qt_doctor,
        -- mr.measure_id_doctor,
        -- m3.short_name measure_doctor,
        -- mr.qt_small_meas,
        -- mr.meas_qt_sm_id,
        -- m4.short_name meas_qt_sm,
        -- mr.form_name_doctor,
        -- mr.lat_form_name_doctor,
        -- mr.cell_flag,
        -- mr.lat_meas_id_doctor,
        -- m5.lat_short_name lat_meas_doctor,
       --  mr.course_flag,
        -- mr.product_size,
        -- mr.nom_source,
       --  mr.atx_code,
        -- (select max(r.name)
       --     from rls_clsatc r
        --   where r.code = mr.atx_code) atx_name,
       -- nvl(mr.gnvlp,0) gnvlp,
       -- decode(mr.gnvlp,1,'Да','Нет') gnvlp_name
    from n_medic_regs mr,
         n_measures m1,
         n_measures m2,
         n_measures m3,
         n_measures m4,
         n_measures m5,
         na_tree_dicts na_in,
         na_tree_dicts na_c,
         na_tree_dicts na_f,
         na_tree_dicts na_mu,
         na_tree_dicts na_pg,
         na_tree_dicts na_p,
         na_tree_dicts na_sg,
         na_tree_dicts na_sk
   where mr.measure_id = m1.id(+) and
         mr.small_measure_id = m2.id(+) and
         mr.measure_id_doctor = m3.id(+) and
         mr.meas_qt_sm_id = m4.id(+) and
         mr.lat_meas_id_doctor = m5.id(+) and
         mr.inter_name_id = na_in.id(+) and
         mr.country_id = na_c.id(+) and
         mr.firm_id = na_f.id(+) and
         mr.method_use_id = na_mu.id(+) and
         mr.pharm_gr_id = na_pg.id(+) and
         mr.payment_id = na_p.id(+) and
         mr.store_gr_id = na_sg.id(+) and
         mr.stock_gr_id = na_sk.id(+)
         and mr.status = 0   -- Актуальность нуменклатуры
         and not exists (select 1  -- Наличие расфасовки
                           from n_medic_reg_rasfs mrr
                          where mrr.head_registry_id = mr.id)
        and mr.factor !=1  -- коэффицент расфасовки
