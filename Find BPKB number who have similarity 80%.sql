CREATE OR REPLACE FUNCTION find_bpkb() 
RETURNS table (
	app_no varchar(25),
	veh_ketjaminan varchar(100),
	veh_no_mesin varchar(30),
	veh_no_bpkb varchar(30),
	veh_tgl_bpkb timestamp with time zone,
	veh_namabpkb varchar(255),
	veh_hubpemilik varchar(10),
	veh_jenis varchar(50),
	veh_namapemilik varchar(255),
	veh_nilaiappr numeric,
	veh_nilaipasar numeric,
	veh_thnmanufaktur varchar(4),
	veh_nopolisi varchar(15),
	date_time date
) as $$
DECLARE
   table_dummy info_veh;
BEGIN
   --CREATE EXTENSION pg_trgm;
   FOR table_dummy IN
      SELECT * from info_veh
   LOOP
   	if(SELECT COUNT(*) > 1 FROM eds_colltr_info_veh dummy WHERE SIMILARITY(dummy.veh_nobpkb,table_dummy.veh_nobpkb) > 0.8) then
  	  RETURN QUERY
	  SELECT * FROM info_veh forreturn where forreturn.app_no = table_dummy.app_no;
	  END IF;
   END LOOP;
END
$$ LANGUAGE plpgsql;

select * from find_bpkb();