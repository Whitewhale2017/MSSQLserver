--修改数据库所有者
exec sp_changedbowner  'sa'
--修改数据库中的对象所有者
exec sp_changedbowner 'objectName','sa'