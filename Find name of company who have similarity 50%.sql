CREATE OR REPLACE FUNCTION compare_name_alamat_telp()
RETURNS TABLE(
	date_time date,
	app_no varchar(25),
	cu_compname varchar(100),
	cu_job_code varchar(10),
	cu_worksince timestamp without time zone,
	cu_ofjabatan varchar(10),
	cu_ofstaf varchar(5),
	cu_ofnmatasan varchar(100),
	cu_income double precision,
	cu_ofaddr1 varchar(80),
	cu_ofaddr2 varchar(80),
	cu_ofaddr3 varchar(80),
	cu_ofcity varchar(30),
	cu_ofrt varchar(5),
	cu_ofrw varchar(5),
	cu_oflurah varchar(50),
	cu_ofcamat varchar(50),
	cu_ofzipcode varchar(10),
	cu_ofphonearea varchar(5),
	cu_ofphone varchar(11),
	cu_ofjabatasan varchar(80),
	cu_oftelpatasan varchar(30)
) as $$
DECLARE
   table_dummy business_info;
BEGIN
   FOR table_dummy IN
      SELECT * from business_info
   LOOP
   	if(
		SELECT COUNT(*) > 1 FROM business_info dummy WHERE SIMILARITY(dummy.cu_compname,table_dummy.cu_compname) > 0.1
		AND SIMILARITY(dummy.cu_ofaddr1,table_dummy.cu_ofaddr1) > 0.5
		AND SIMILARITY(dummy.cu_ofrt,table_dummy.cu_ofrt) > 0.5
		AND SIMILARITY(dummy.cu_ofrw,table_dummy.cu_ofrw) > 0.5
		AND SIMILARITY(dummy.cu_oflurah,table_dummy.cu_oflurah) > 0.5
		AND SIMILARITY(dummy.cu_ofcamat,table_dummy.cu_ofcamat) > 0.5
		AND SIMILARITY(dummy.cu_ofzipcode,table_dummy.cu_ofzipcode) > 0.5
		AND SIMILARITY (dummy.cu_ofphonearea,table_dummy.cu_ofphonearea) > 0.4
		AND SIMILARITY (dummy.cu_ofphone,table_dummy.cu_ofphone) > 0.5
	) then
	  RETURN QUERY SELECT * FROM business_info forreturn where forreturn.app_no = table_dummy.app_no;
	  END IF;
   END LOOP;
END
$$ LANGUAGE plpgsql;
SELECT * FROM compare_name_alamat_telp();