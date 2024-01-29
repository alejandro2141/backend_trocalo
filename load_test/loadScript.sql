/*
--- INSERT USER ---
INSERT INTO user_created 
(names , last_name1, last_name2 , email, phone, id_number, passwd, address_street_name, address_street_number , address_street_apartment , address_location_zone , address_reference) 
VALUES  
('Juan Alejando' , 'MORALES' , 'Miranda' , 'alejandro2141@gmail.com' ,'975397200','13909371-2'
,'paranoid','tristan cornejo ','957','1','100','Mi casa queda al lado de un arbol'    ) RETURNING *


--- INSERT OBJECT ---
INSERT INTO user_object
  ( title, description, alternative1, alternative2, alternative3, 
    others, owner_id , owner_name , img_ref1 , img_ref2, img_ref3, img_ref4, img_ref5, category1, category2, category3 ) 
  VALUES  
  ('Zapatillas gastadas y sucias' , 'Zapatillas sucias y gastadas  con olor nauseabundo y vomitadas ' , 'auto usado' , 'zapatilals Limpias' ,'ferrary',
   true ,'6' ,'Juan Alejandro  ' 
   , 'img_6_1_1706214268001.jpg' 
   , 'img_6_2_1706214268001.jpg'  
   , 'img_6_3_1706214268001.jpg'  
   , 'img_6_4_1706214268001.jpg'  
   , 'img_6_5_1706214268001.jpg'  
   ,  1
   ,  2
   ,  3
   ) RETURNING * 

--- INSERT PROPOSAL ---
INSERT INTO proposal (timestamp,updated,user_id_creator,user_id_destination,amount,status,loop_number,user_id_source,dest_object1,source_object1,source_object2,creator_name,dest_owner_name,source_owner_name,proposal_days,title) VALUES ('2024-01-25T20:27:23.095Z','2024-01-25T20:27:23.095Z',6,7,17990 ,1,1,6,64,61,63,'Juan Alejandro ','matilde ','Juan Alejandro  ','7','vestido completo amarillo') RETURNING * 
*/


DO $$

DECLARE 

v_obj_title text;
v_profid bigint;
v_profname text;
v_objcounter bigint;

v_object_id bigint;


v_proposal_id bigint ; 

v_centerid1 bigint;
v_centerid2 bigint;
v_centerid3 bigint;
v_calendarid1 bigint;
v_calendarid2 bigint;
v_calendarid3 bigint;

v_calendarDate1 date ;
v_calendarDate2 date ;
v_calendarTime1 time ;
v_calendarTime2 time ;

v_specialty bigint;

cnt bigint;
cnt_obj bigint;
cnt_specialty bigint;

BEGIN 

v_calendarDate1 	= '2023-09-01T04:00:00.000Z' ;
v_calendarDate2 	= '2023-09-25T04:00:00.000Z'  ;
v_calendarTime1 	= '09:00:00-4' ;
v_calendarTime2 	= '11:00:00-4' ;

v_objcounter = 0 ; 

TRUNCATE TABLE user_created RESTART IDENTITY CASCADE;
TRUNCATE TABLE user_object  RESTART IDENTITY CASCADE;
TRUNCATE TABLE proposal     RESTART IDENTITY CASCADE;

/*
TRUNCATE TABLE professional_calendar RESTART IDENTITY CASCADE;
TRUNCATE TABLE center RESTART IDENTITY CASCADE;
TRUNCATE TABLE account RESTART IDENTITY CASCADE;
TRUNCATE TABLE professional_specialty  RESTART IDENTITY CASCADE;
TRUNCATE TABLE professional RESTART IDENTITY CASCADE ;
TRUNCATE TABLE appointment  RESTART IDENTITY CASCADE ;

TRUNCATE TABLE send_calendar_patient RESTART IDENTITY CASCADE ;
TRUNCATE TABLE send_email_patient_cancel_appointment RESTART IDENTITY CASCADE;
TRUNCATE TABLE request_app_confirm RESTART IDENTITY CASCADE;
TRUNCATE TABLE professional_register RESTART IDENTITY CASCADE;

TRUNCATE TABLE session RESTART IDENTITY CASCADE;

ALTER SEQUENCE  account_id_seq RESTART ;
ALTER SEQUENCE  appointment_cancelled_id_seq RESTART ;
*/

-----------------------
--   CREATE USERS  ------
-------------------------
-------------------------

  for cnt in 1..11 loop 
	  --  v_profname := CONCAT('user','Test',cnt);
      INSERT INTO user_created 
      (names , last_name1, last_name2 , email, phone, id_number, passwd, address_street_name, address_street_number , address_street_apartment , address_location_zone , address_reference) 
      VALUES  
      (CONCAT('userNameTest',cnt), CONCAT('primapellido',cnt) , CONCAT('segapellido',cnt) , CONCAT('user',cnt,'@gmail.com') ,'975397200','13909371-2'
      ,CONCAT('user',cnt) ,'tristan cornejo ','957','1','100','Mi casa queda al lado de un arbol'    ) RETURNING id INTO v_profid  ;
	  
	  	-----------------------
		--   CREATE OBJECTS  ------
		-------------------------
	  
	 for cnt_obj in 1..10 loop 

			v_obj_title := CONCAT('Object ',cnt_obj,' belong to',v_profid );
	
		INSERT INTO user_object
	  ( title, description, alternative1, alternative2, alternative3, 
		others, owner_id , owner_name , img_ref1 , img_ref2, img_ref3, img_ref4, img_ref5, category1, category2, category3 ) 
	  VALUES  
	  ( v_obj_title , CONCAT('Descripcion del Objeto ',cnt_obj,'-',v_obj_title ) , 'auto usado' , 'zapatilals Limpias' ,'ferrary',
	   true , v_profid ,'Juan Alejandro  ' 
	   , CONCAT('testImg', v_objcounter,'.jpg')
	   , CONCAT('testImg',v_objcounter+1,'.jpg')
	   , CONCAT('testImg',v_objcounter+2,'.jpg')
	   , CONCAT('testImg',v_objcounter+3,'.jpg')
	   , CONCAT('testImg',v_objcounter+4,'.jpg')
	   ,  1
	   ,  2
	   ,  3
 	   ) RETURNING id INTO v_object_id   ;
	   
		--------------------------------------
		--- CREATE PROPOSAL
	   ---------------------------------------------
	   
	   INSERT INTO proposal 
	   (timestamp      ,updated        , user_id_creator,user_id_destination,amount  ,status,loop_number,user_id_source,dest_object1     , source_object1,source_object2,source_object3,creator_name   ,  dest_owner_name  ,source_owner_name          ,proposal_days,title) 
	   VALUES 
	   (v_calendarDate1,v_calendarDate1, v_profid       ,v_profid+1          , v_profid*1000+1  ,1     ,1          ,v_profid      , v_object_id+10  , v_profid*10 ,v_profid*10+1,v_profid*10+2    ,'userNameTest1', 'noseelnombre'    , CONCAT('userNameTest',cnt),'7'          ,'Titulo del producto que me interesa') 
	   
	   RETURNING id INTO v_proposal_id; 
	   
	   v_objcounter = v_objcounter + 5;
	  
	end loop;
	
	  
	  
	  
---end loop 1	  
  end loop;


end ; $$


/*
-----------------------
--   CREATE KINE ------
-------------------------
-- Cycle to create FIXED 8 SPECIALTIES --
-------------------------
for cnt_specialty in 1..8 loop 
v_specialty = 100 * cnt_specialty;

-- Cycle How many professional per specialty
	for cnt in 1..11 loop 

		v_profname := CONCAT('prof',v_specialty,'-',cnt);
		-- INSERT PROFESSIONAL DATA
		INSERT INTO professional (name, document_number, license_number,  email, address, phone , active) VALUES (v_profname, CONCAT(CONCAT( CONCAT(CONCAT(cnt,cnt)),'-'), cnt )  ,'123', CONCAT(v_profname,'@nada.com'), 'avsiempreviva', '77777', true   ) 
		RETURNING id INTO v_profid;
		-- INSERT AN ACCOUNT
		INSERT INTO account  (user_id, pass , active ) VALUES ( v_profid , cnt , true ) ;
		
		--INSERT TWO SPECIALTIES to this professional
		INSERT INTO professional_specialty ( professional_id , specialty_id ) VALUES ( v_profid , v_specialty) ;
		
		-- INSERT CENTERs
		INSERT INTO center ( name , address , phone1,phone2, active, country, comuna, center_deleted, center_color, home_comuna1, home_comuna2 , home_visit,center_visit, remote_care, professional_id , date  ) 
	                values ( CONCAT('consulta1Center',v_profname) , CONCAT('Avenida consulta1 ', v_profname) ,  '7454333' , '56975397201', 1 , 1 , 1511 , false , '#FFE6EE' , null , null ,  false  , true , false ,  v_profid ,  NOW() )  
					RETURNING id INTO v_centerid1;
					
		INSERT INTO center ( name , address , phone1,phone2, active, country, comuna, center_deleted, center_color, home_comuna1, home_comuna2 , home_visit,center_visit, remote_care, professional_id , date  ) 
	                values ( CONCAT('consulta2Remote',v_profname) , null ,  '7454333' , '56975397201', 1 , 1 , null , false , '#FF4244' , 1511, 1509,  true  , false , false ,  v_profid ,  NOW() )  
					RETURNING id INTO v_centerid2; 
	
		INSERT INTO center ( name , address , phone1,phone2, active, country, comuna, center_deleted, center_color, home_comuna1, home_comuna2 , home_visit,center_visit, remote_care, professional_id , date  ) 
	                values ( CONCAT('consulta2HomeVisit',v_profname) , null  ,  '7454333' , '56975397201', 1 , 1 , null , false , '#FF4244' , null , null ,  false  , false , true ,  v_profid ,  NOW() )  
					RETURNING id INTO v_centerid3; 
					
						
		-- INSERT CALENDARs
		--calendarColorArray : ["#FF4244","#4ebeef","#AF8536", "#f6a700", "#32b780", "#dd6da4"],
		INSERT INTO professional_calendar (professional_id , start_time,  end_time, specialty1, duration, time_between, monday, tuesday, wednesday, thursday, friday, saturday , sunday, date_start, date_end,   center_id,  status , deleted_professional, color ,date ,price , active ) 
		VALUES ( v_profid,  v_calendarTimeStart1 , v_calendarTimeEnd1  , v_specialty , '50' , '10' ,  'true' ,  'true'  ,  'true' ,  'true'  ,  'true'  , 'true'  ,  'false'  , v_calendarDateStart1 ,  v_calendarDateEnd1 , v_centerid1 , '1' , false , '#FF4244' ,  NOW() , 11111, true ) 
		RETURNING id INTO v_calendarid1 ; 
		
		INSERT INTO professional_calendar (professional_id , start_time,  end_time, specialty1, duration, time_between, monday, tuesday, wednesday, thursday, friday, saturday , sunday, date_start, date_end,   center_id,  status , deleted_professional, color ,date ,price , active ) 
		VALUES ( v_profid, v_calendarTimeStart2  , v_calendarTimeEnd2 , v_specialty , '45' , '15' ,  'true' ,  'true'  ,  'true' ,  'true'  ,  'true'  , 'false'  ,  'false'  , v_calendarDateStart2 ,  v_calendarDateEnd2 , v_centerid2 , '1' , false , '#f6a700' ,  NOW() , 22222 , true ) 
		RETURNING id INTO v_calendarid2 ; 
	    -- INSERT INTO professional_calendar (professional_id , start_time,  end_time, specialty1, duration, time_between, monday, tuesday, wednesday, thursday, friday, saturday , sunday, date_start, date_end,   center_id,  status , deleted_professional, color ,date ,price , active ) VALUES ( '1',  '02:00:00-4' , '23:00:00-4', '100' , '50' , '10' ,  'true' ,  'true'  ,  'true' ,  'true'  ,  'true'  , 'false'  ,  'false'  ,   '2023-08-23T04:00:00.000Z'  ,  '2023-10-22T02:59:59.997Z'  ,   251 , '1' , false , '#FF4244' ,  '2023-08-23T21:51:21.307Z' ,  '666' , true ) ;
		INSERT INTO professional_calendar (professional_id , start_time,  end_time, specialty1, duration, time_between, monday, tuesday, wednesday, thursday, friday, saturday , sunday, date_start, date_end,   center_id,  status , deleted_professional, color ,date ,price , active ) 
		VALUES ( v_profid,  v_calendarTimeStart3 ,  v_calendarTimeEnd3 , v_specialty , '45' , '15' ,  'true' ,  'true'  ,  'true' ,  'true'  ,  'true'  , 'false'  ,  'false'  , v_calendarDateStart3 ,  v_calendarDateEnd3 , v_centerid3 , '1' , false , '#f6a700' ,  NOW() , 33333 , true ) 
		RETURNING id INTO v_calendarid3 ; 
	    -- INSERT INTO professional_calendar (professional_id , start_time,  end_time, specialty1, duration, time_between, monday, tuesday, wednesday, thursday, friday, saturday , sunday, date_start, date_end,   center_id,  status , deleted_professional, color ,date ,price , active ) VALUES ( '1',  '02:00:00-4' , '23:00:00-4', '100' , '50' , '10' ,  'true' ,  'true'  ,  'true' ,  'true'  ,  'true'  , 'false'  ,  'false'  ,   '2023-08-23T04:00:00.000Z'  ,  '2023-10-22T02:59:59.997Z'  ,   251 , '1' , false , '#FF4244' ,  '2023-08-23T21:51:21.307Z' ,  '666' , true ) ;
				
		
		-- INSERT APPOINTMENTS
		INSERT INTO appointment (  date , start_time,  duration,  center_id, confirmation_status, professional_id, patient_doc_id, patient_name,    patient_email, patient_phone1,  patient_age,  app_available, app_status, app_blocked, app_public,  location1, location2, location3, location4, location5, location6,   app_type_home, app_type_center,  app_type_remote, patient_notification_email_reserved , specialty_reserved , patient_address , calendar_id , app_price)   
		VALUES ( '2023-09-15T11:00:00.000Z' , '2023-09-15T11:00:00.000Z' , '10' ,  v_centerid1 , '0' , v_profid , '13909371--2' ,  CONCAT('MATILDE AURORA MIRANDA',v_profname)  , 'ALEJANDRO2141@NADA.COM' , '555566534' ,  '43' ,'false' , '1' , '0' , '1', 1708 , 1662 ,null ,null ,null ,null , 'false' , 'true' , 'false' , '1' , v_specialty , 'null'  , v_calendarid1 , '666' 	) ; 

		INSERT INTO appointment (  date , start_time,  duration,  center_id, confirmation_status, professional_id, patient_doc_id, patient_name,    patient_email, patient_phone1,  patient_age,  app_available, app_status, app_blocked, app_public,  location1, location2, location3, location4, location5, location6,   app_type_home, app_type_center,  app_type_remote, patient_notification_email_reserved , specialty_reserved , patient_address , calendar_id , app_price)   
		VALUES ('2023-09-15T14:00:00.000Z' , '2023-09-15T14:00:00.000Z' , '10' ,  v_centerid2 , '0' , v_profid , '13909371--2' ,  CONCAT('MATILDE AURORA MIRANDA',v_profname)  , 'ALEJANDRO2141@NADA.COM' , '555566534' ,  '43' ,'false' , '1' , '0' , '1', 1708 , 1662 ,null ,null ,null ,null , 'false' , 'true' , 'false' , '1' , v_specialty , 'null'  , v_calendarid2 , '666' 	) ; 

		INSERT INTO appointment (  date , start_time,  duration,  center_id, confirmation_status, professional_id, patient_doc_id, patient_name,    patient_email, patient_phone1,  patient_age,  app_available, app_status, app_blocked, app_public,  location1, location2, location3, location4, location5, location6,   app_type_home, app_type_center,  app_type_remote, patient_notification_email_reserved , specialty_reserved , patient_address , calendar_id , app_price)   
		VALUES ( NOW() , NOW() , '10' ,  v_centerid1 , '0' , v_profid , '13909371-2' ,  CONCAT('MATILDE AURORA MIRANDA',v_profname)  , 'ALEJANDRO2141@NADA.COM' , '555566534' ,  '43' ,'false' , '1' , '0' , '1', 1708 , 1662 ,null ,null ,null ,null , 'false' , 'true' , 'false' , '1' , v_specialty , 'null'  , v_calendarid1 , '666' 	) ; 

		INSERT INTO appointment (  date , start_time,  duration,  center_id, confirmation_status, professional_id, patient_doc_id, patient_name,    patient_email, patient_phone1,  patient_age,  app_available, app_status, app_blocked, app_public,  location1, location2, location3, location4, location5, location6,   app_type_home, app_type_center,  app_type_remote, patient_notification_email_reserved , specialty_reserved , patient_address , calendar_id , app_price)   
		VALUES (NOW() , NOW(), '10' ,  v_centerid2 , '0' , v_profid , '13909371-2' ,  CONCAT('MATILDE AURORA MIRANDA',v_profname)  , 'ALEJANDRO2141@NADA.COM' , '555566534' ,  '43' ,'false' , '1' , '0' , '1', 1708 , 1662 ,null ,null ,null ,null , 'false' , 'true' , 'false' , '1' , v_specialty , 'null'  , v_calendarid2 , '666' 	) ; 

 	end loop;
	
end loop;



end ; $$

  */