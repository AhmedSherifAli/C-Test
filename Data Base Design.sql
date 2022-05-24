Create DataBase [Task]

drop DataBase [Task]

-------------------------------------------------------
---------- Tables 
-------------------------------------------------------

Create Table UsersProfile
(
   UserId varchar(11) primary key,
   UserName nvarchar(30) not null,
   Email varchar(50) not null,
   UserPass nvarchar(30) not null,
   UserDep nvarchar(50) foreign key references [dbo].[Departments](DepName),
   UserRole nvarchar(30) foreign key references [dbo].[Roles](RoleName),
   AccountStatus nvarchar(30) foreign key references [dbo].[UserStatus](StatusName),
   RegisterDate datetime not null
)

insert into UsersProfile values (1,'احمد شريف','ahmed@gmail.com','احمد','Network','Admin','Active',GETDATE())

select * from UsersProfile

Drop Table  UsersProfile

truncate Table UsersProfile

Create Table UsersAudit
(
	
)



Create Table Departments
(
  DepId varchar(3) not null,
  DepName nvarchar(50) primary key
)

select * from Departments

drop table Departments

insert into Departments values (1,'Network')
insert into Departments values (2,'Mis')
insert into Departments values (3,'E-Learning')
insert into Departments values (4,'Computer Maintenance')
insert into Departments values (5,'Portal')


Create Table Roles
(
	RoleId varchar(2) not null,
	RoleName nvarchar(30) primary key
)

select * from Roles

insert into Roles values (1,'Admin')
insert into Roles values (2,'User')

Create Table UserStatus
(
	StatusId varchar(2) not null,
	StatusName nvarchar(30) primary key
)

insert into UserStatus values (1,'Active')
insert into UserStatus values (2,'Suspend')
insert into UserStatus values (3,'Deleted')

select * from UserStatus


Create Table Reset_Record
(
	id uniqueidentifier primary key,
	Uid varchar(11),
	ResetTime datetime
)

----------------------------------------------------------
----------------- Stored Proc-----------------------------
----------------------------------------------------------

Create Proc GetDep
as
Select * from Departments



Create Proc ID_Generator_For_Users 
@SmGuid varchar(11) ='' out
as
Begin
   DECLARE @bigintdata BIGINT = cast(cast(reverse(NEWID()) as varbinary(max)) as bigint)
   DECLARE @charSet VARCHAR(70) = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
   DECLARE @cBase int = LEN(@charSet)
   DECLARE @sUID varchar(8) = ''
   DECLARE @x int
   WHILE (@bigintdata <> 0)
     BEGIN 
       SET @x = CAST(@bigintdata % @cBase as INT) + 1
       SET @bigintdata = @bigintdata / @cBase
       Set @sUID = SUBSTRING(@charSet, @x, 1) + @sUID;
	    select @SmGuid = @sUID
		--print @SmGuid
     END
End

alter Proc Insert_User
@UserName nvarchar(30),
@Email varchar(50),
@UserPass nvarchar(30),
@National_ID varchar(50),
@UserDep nvarchar(50),
@UserRole nvarchar(30),
@AccountStatus nvarchar(30)

as
Begin

        Declare @SmaGuid varchar(22)=''
        Declare @Col varchar(22)
        --- Cheak Member Exists
        Select @Col = UserId from UsersProfile where Email=lower(Ltrim(Rtrim(@Email)))
        if(@Col is not null)
          Begin
	  
             Print 'This Member is Exists'

          End
		Else
		Begin

        Exec ID_Generator_For_Users @SmGuid=@SmaGuid out
	    --Print @SmaGuid
	    insert into UsersProfile values(@SmaGuid,@UserName,lower(Ltrim(Rtrim(@Email))),@UserPass,@National_ID,@UserDep,@UserRole,@AccountStatus,GETDATE())

		End
End
Go

exec Insert_User 'Ahmed','AHMED@aswu.edu.eg','as1+me2','29110012803035','Network','Admin','Active'

Select * from UsersProfile

create Proc CheckUserExistsbeforReg
@Email varchar(50)
as
Begin
-- Check Email befor Password
 select * from UsersProfile where Email = lower(Ltrim(Rtrim(@Email)))
end
Go

Create Proc UpdateUserPass
@Uid varchar(11),
@UserPass nvarchar(30)
as
update UsersProfile set UserPass=@UserPass where UserId=@Uid


Create Proc Suspend_User_Login
@Email varchar(50)
as
Update UsersProfile set AccountStatus='Suspend' where Email=@Email

exec Suspend_User 'hekaetaeter88@gmail.com'

Create Proc Reset_Insert
@myGUID uniqueidentifier,
@Uid varchar(11)
as
insert into Reset_Record values(@myGUID,@Uid,GETDATE())

select * from Reset_Record

alter Proc CheckReset_Record
@id varchar(50)
as
Declare @Valueguid uniqueidentifier = convert(uniqueidentifier,@id)
Select * from Reset_Record where id=@Valueguid

exec CheckReset_Record 'B01893EB-4299-45F1-9236-D5003390C656'

alter Proc Change_User_Role_ByAdmin
@Email varchar(50),
@UserRole nvarchar(30) 
as
Update UsersProfile set UserRole=@UserRole where Email=@Email

alter Proc Change_User_Status_ByAdmin
@Email varchar(50),
@AccountStatus nvarchar(30) 
as
Update UsersProfile set AccountStatus=@AccountStatus where Email=@Email
