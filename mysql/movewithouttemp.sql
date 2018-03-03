SELECT NSID, NSNAME, NSYEAR, NSCODE, NSDATE, COMMENTS, `TYPE`, RISKLEVEL, PNSID, OLDID
FROM lims_st.st_inspection;

select count(NSID) FROM lims_st.st_inspection;

SELECT ID, NSID, STATUS, TYPE1, TYPE2, TYPE3, TYPE4, RISKLEVEL, COMMENTS
FROM lims_st.st_inspectiondetail limit 10;

delete FROM lims_st.st_inspection where oldid is not null;

-- level 1
insert into lims_st.st_inspection ( NSID, NSNAME, PNSID, TYPE , OLDID)
select  uuid() as NSID,   TYPE1 as NSNAME , NSID as PNSID, 1 as  `TYPE`,  max( ID ) as OLDID 
FROM lims_st.st_inspectiondetail  group by  TYPE1 , NSID;

-- level 2
insert into lims_st.st_inspection ( NSID, NSNAME, PNSID, TYPE , OLDID)
select  uuid() as NSID, d.TYPE2 as NSNAME , t.nsid as PNSID, 2 as `TYPE`,  max( ID ) as OLDID
FROM lims_st.st_inspectiondetail as d left join lims_st.st_inspection t on d.TYPE1 = t.NSNAME
where t.`TYPE` = 1
group by t.nsid , d.TYPE2 ;

-- level 3
insert into lims_st.st_inspection ( NSID, NSNAME, PNSID, TYPE , OLDID)
select  uuid() as NSID, d.TYPE3 as NSNAME , t.nsid as PNSID, 3 as `TYPE`,  max( ID ) as OLDID
FROM lims_st.st_inspectiondetail as d left join lims_st.st_inspection t on d.TYPE2 = t.NSNAME
where t.`TYPE` = 2
group by t.nsid , d.TYPE3 ;

-- level 4
insert into lims_st.st_inspection ( NSID, NSNAME, PNSID, TYPE , RISKLEVEL, COMMENTS, OLDID)
select  ID as NSID, d.TYPE4 as NSNAME , t.nsid as PNSID, 4 as `TYPE`,  ID as OLDID ,  t.RISKLEVEL, t.COMMENTS
FROM lims_st.st_inspectiondetail as d left join lims_st.st_inspection t on d.TYPE3 = t.NSNAME
where t.`TYPE` = 3  ;

SELECT * FROM lims_st.st_inspection;


SELECT DISTINCT(T.NSDID),d.ID,d.TYPE1,d.TYPE2,d.TYPE3,d.TYPE4 FROM st_spec_test t,st_inspection d WHERE t.NSDID = d.ID ORDER BY d.type1 DESC,d.type2 DESC,d.type3 DESC,d.type4 DESC;