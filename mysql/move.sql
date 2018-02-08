 
SELECT ID, NSID, STATUS, TYPE1, TYPE2, TYPE3, TYPE4, RISKLEVEL, COMMENTS
FROM lims_st.st_inspectiondetail where id = 'fa3a9d6b-050c-11e8-9e05-00155d051606';

select * FROM lims_st.st_inspectiondetail limit 10;


SELECT NSID, NSNAME, NSYEAR, NSCODE, NSDATE, COMMENTS, TYPE, RISKLEVEL, PNSID, OLDID
FROM lims_st.liusz_t;

select * from lims_st.liusz_t t where t.NSID ='3' ;
select * from lims_st.liusz_t t where t.PNSID ='0' ;
select * from lims_st.liusz_t t where t.PNSID ='107' ;
 
select * from lims_st.liusz_t t where t.type = 3;

select type1,max(id) from lims_st.st_inspectiondetail
group by type1

select type1,type2,max(id) from lims_st.st_inspectiondetail
group by type1,type2

select type1,type2,type3,max(id) from lims_st.st_inspectiondetail
group by type1,type2,type3;

select type1,type2,type3,type4,max(id) from lims_st.st_inspectiondetail
group by type1,type2,type3,type4



SELECT NSID, NSNAME, NSYEAR, NSCODE, NSDATE, COMMENTS, TYPE, RISKLEVEL, PNSID, OLDID
FROM lims_st.st_inspection order by type;

select * from lims_st.st_inspection 

select count(NSID)  FROM lims_st.st_inspection;

delete from  lims_st.st_inspection where NSYEAR is null;
 
insert into lims_st.st_inspection ( NSID, PNSID,  NSNAME, TYPE , COMMENTS)
select distinct id as NSID, NSID, TYPE1 as NSNAME , 1, COMMENTS  from lims_st.st_inspectiondetail
 



insert into lims_st.st_inspection ( NSID, PNSID,  NSNAME, TYPE , COMMENTS) select id as NSID, NSID, TYPE1 as NSNAME , 1, COMMENTS  from lims_st.st_inspectiondetail


SELECT NSID, NSNAME, NSYEAR, NSCODE, NSDATE, COMMENTS, PNSID
FROM lims_st.st_temp_inspection;

 



--  细类, 第一级
insert into lims_st.st_inspection ( NSID, OLDID, PNSID , NSNAME, TYPE ,RISKLEVEL, COMMENTS)  
select  uuid(), id as OLDID, NSID, TYPE1 as NSNAME , 1, RISKLEVEL, COMMENTS  from lims_st.st_inspectiondetail;

 
--  细类, 第二级
insert into lims_st.st_inspection ( NSID, OLDID, NSNAME, TYPE ,RISKLEVEL, COMMENTS)   select  uuid(), id as OLDID,  TYPE2 as NSNAME , 2, RISKLEVEL, COMMENTS  from lims_st.st_inspectiondetail;
  
--  细类, 第三级
insert into lims_st.st_inspection ( NSID, OLDID, NSNAME, TYPE ,RISKLEVEL, COMMENTS)   select  uuid(), id as OLDID,  TYPE3 as NSNAME , 3, RISKLEVEL, COMMENTS  from lims_st.st_inspectiondetail;

 --  细类, 第四级
insert into lims_st.st_inspection ( NSID, OLDID, NSNAME, TYPE ,RISKLEVEL, COMMENTS) select id as NSID, id as OLDID, TYPE4 as NSNAME , 4, RISKLEVEL, COMMENTS  from lims_st.st_inspectiondetail;

select  * from lims_st.st_inspection as a where a.TYPE = 1  or a.type is null  order by NSNAME ;
 
select  a.NSID as PNSID , b.* from lims_st.st_inspection as a , lims_st.st_inspection b where a.TYPE = 1 and  b.type =2  and a.OLDID = b.OLDID order by NSNAME ;

select  a.NSID as PNSID , b.* from lims_st.st_inspection as a , lims_st.st_inspection b where a.TYPE = 2 and  b.type =3  and a.OLDID = b.OLDID order by NSNAME ;

select  a.NSID as PNSID , b.* from lims_st.st_inspection as a , lims_st.st_inspection b where a.TYPE = 3 and  b.type =4 and a.OLDID = b.OLDID order by NSNAME ;
 


SELECT menuid, parentid, menudesc, ordercode, menubaseid, leaf, recordercode, recorderdesc, recordtime, i18ncode
FROM dbs_lims_st.base_menu;

SELECT producttypeid, producttypecode, productcatid, producttypename, parentid, comments, version, recordercode, recorderdesc, recordtime, auditorcode, auditordesc, audittime, auditflag, auditlevel, submitcorp, workflowid, sorter, status, modifycode, modifydesc, modifytime, recordercorp, freezeflag, freezercode, freezerdesc, freezetime
FROM dbs_lims_st.st_producttype where parentid = 0 ;


SELECT producttypeid, producttypecode, productcatid, producttypename, parentid, comments, version, recordercode, recorderdesc, recordtime, auditorcode, auditordesc, audittime, auditflag, auditlevel, submitcorp, workflowid, sorter, status, modifycode, modifydesc, modifytime, recordercorp, freezeflag, freezercode, freezerdesc, freezetime
FROM dbs_lims_st.st_producttype where productcatid = 13  and parentid = 325 and  producttypename like "蔬菜%";

SELECT *  FROM dbs_lims_st.st_producttype where  producttypename like "%蔬菜%" and  productcatid = 13 ;

select * from ST_SPEC_TEST;

select * from ST_SPEC limit 1 , 10 


SELECT menuid, parentid, menudesc, ordercode, menubaseid, leaf, recordercode, recorderdesc, recordtime, i18ncode
FROM dbs_lims_st.base_menu  where menudesc like
SELECT NSID, NSNAME, NSYEAR, NSCODE, NSDATE, COMMENTS, PNSID
FROM lims_st.st_inspection;
 '产品标准%' ;


SELECT menubaseid, parentid, menubasecode, menudesc, href, leaf, ordercode, freezeflag, freezercode, freezerdesc, freezedate, remarker, tablename, i18ncode, CUSTOMERNAME, menutype, hiddenflag, ICONCLASS
FROM dbs_lims_st.base_menubase  where  menubaseid = '2017121204';


delete FROM dbs_lims_st.base_menu  where menuid =  '2017121205' ;

delete FROM dbs_lims_st.base_menubase  where  menubaseid = '2017121205';
SELECT NSID, NSNAME, NSYEAR, NSCODE, NSDATE, COMMENTS, PNSID
FROM lims_st.st_inspection;


SELECT NSID, NSNAME, NSYEAR, NSCODE, NSDATE, COMMENTS, PNSID
FROM lims_st.st_inspection;



SELECT SPEC_VALUEID, SPEC_VALUECODE, SPECID, SPEC_PRODUCTID, LIMITS, LOW, HIGH, UNITS, PICTURE, COMMENTS, GDSP_SPECID, GDSP_ANALYTEID, GDSP_CLAUSEID, GDSP_TESTID, GDSP_SPECPRODUCTID, GDSP_TETSNAME, GDSP_TESTNAME_EN, spec_testid, sorter
FROM dbs_lims_st.st_spec_value;


show tables   ;


SELECT SPEC_VALUEID, SPEC_VALUECODE, SPECID, SPEC_PRODUCTID, LIMITS, LOW, HIGH, UNITS, PICTURE, COMMENTS, GDSP_SPECID, GDSP_ANALYTEID, GDSP_CLAUSEID, GDSP_TESTID, GDSP_SPECPRODUCTID, GDSP_TETSNAME, GDSP_TESTNAME_EN, spec_testid, sorter
FROM dbs_lims_st.st_spec_value;




SELECT ID, NSID, STATUS, TYPE1, TYPE2, TYPE3, TYPE4, RISKLEVEL, COMMENTS
FROM lims_st.st_inspectiondetail;




 