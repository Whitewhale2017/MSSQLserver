create function add1(@a int,@b int)
returns int
as 
begin
  declare @res int
  set @res=@a+@b
  return @res
end

select dbo.add1(4,6)

