select * from Bill_Meeting where MeetingName like '%11111%'

select a.name,b.MeetingName from Meeting a,Bill_Meeting b
where a.id=b.ApproveID

select ApproveID,field_1658375340,BeginDate,BeginTime,EndDate,EndTime
,cast(round(datediff(MINUTE,BeginDate+' '+BeginTime,EndDate+' '+EndTime)/60.0,4) as numeric(20,3))
  from Bill_Meeting where ApproveID=17402

  update Bill_Meeting 
  set field_1658375340=cast(round(datediff(MINUTE,BeginDate+' '+BeginTime,EndDate+' '+EndTime)/60.0,4) as numeric(20,3))
  where ApproveID=96

  create trigger tri_insert_bill_meeting
  on bill_meeting
  for insert,update
  as
  begin
  update a 
  set a.field_1658375340=cast(round(datediff(MINUTE,b.BeginDate+' '+b.BeginTime,b.EndDate+' '+b.EndTime)/60.0,4) as numeric(20,3))
  from Bill_Meeting a 
  inner join inserted b
  on a.ApproveID=b.ApproveID
  end
 

 
  alter trigger tri_insert_bill_meeting
  on bill_meeting
  for insert,update
  as
  begin
  update a 
  set a.field_1658375340=cast(round(datediff(MINUTE,b.BeginDate+' '+b.BeginTime,b.EndDate+' '+b.EndTime)/60.0,4) as numeric(20,3))
  from Bill_Meeting a,inserted b 
  where a.ApproveID=b.ApproveID
  end

 ----禁用触发器
 alter table bill_meeting
 disable trigger tri_insert_bill_meeting
 ----启用触发器
  alter table bill_meeting
 enable trigger tri_insert_bill_meeting