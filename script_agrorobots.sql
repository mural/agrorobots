USE [master]
GO
/****** Object:  Database [agrorobots]    Script Date: 22/09/2015 18:31:33 ******/
CREATE DATABASE [agrorobots]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'agrorobots', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\agrorobots.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'agrorobots_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\agrorobots_log.ldf' , SIZE = 2816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [agrorobots] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [agrorobots].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [agrorobots] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [agrorobots] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [agrorobots] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [agrorobots] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [agrorobots] SET ARITHABORT OFF 
GO
ALTER DATABASE [agrorobots] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [agrorobots] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [agrorobots] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [agrorobots] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [agrorobots] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [agrorobots] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [agrorobots] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [agrorobots] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [agrorobots] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [agrorobots] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [agrorobots] SET  DISABLE_BROKER 
GO
ALTER DATABASE [agrorobots] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [agrorobots] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [agrorobots] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [agrorobots] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [agrorobots] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [agrorobots] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [agrorobots] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [agrorobots] SET RECOVERY FULL 
GO
ALTER DATABASE [agrorobots] SET  MULTI_USER 
GO
ALTER DATABASE [agrorobots] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [agrorobots] SET DB_CHAINING OFF 
GO
ALTER DATABASE [agrorobots] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [agrorobots] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [agrorobots]
GO
/****** Object:  StoredProcedure [dbo].[AsignarCompAFam]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[AsignarCompAFam]
(
@child int,
@parent int
)
as
insert into componente_parent
(Child_Id, Parent_Id)
values
(@child, @parent)


GO
/****** Object:  StoredProcedure [dbo].[AssignPermissionToUser]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[AssignPermissionToUser]
(
@Usu_Id int,
@Comp_Id int
)
as
insert into usuario_componente
(
Usu_id,
Comp_id
)
values
(
@Usu_Id,
@Comp_Id
)


GO
/****** Object:  StoredProcedure [dbo].[CleanFamily]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[CleanFamily]
(
@parent int
)
as
delete from componente_Parent
where Parent_Id=@parent


GO
/****** Object:  StoredProcedure [dbo].[CreateBackUp]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[CreateBackUp]
(
@location varchar(2000)
)
as
BACKUP DATABASE [agrorobots] TO DISK = @location WITH NOFORMAT, NOINIT,  NAME = N'Agrorobots-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10




GO
/****** Object:  StoredProcedure [dbo].[CreateIdioma]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateIdioma]
	-- Add the parameters for the stored procedure here
	@IdiomaID As Integer,
	@IdiomaDesc As varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
INSERT INTO [dbo].[Idioma]
           ([ID], [Nombre])
     VALUES
           (@IdiomaID, @IdiomaDesc)

INSERT INTO [dbo].[Idioma_Control]
           ([Idioma_ID]
           ,[Traduccion]
           ,[Control_ID])
     SELECT TOP 2000 
      @IdiomaID,
      ''
      ,[Control_ID]
  FROM [agrorobots].[dbo].[Idioma_Control]
  WHERE [Idioma_ID] = 1
END

GO
/****** Object:  StoredProcedure [dbo].[CreateTraduccion]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateTraduccion]
	-- Add the parameters for the stored procedure here
	(
 @Idioma_ID as int,
 @Traduccion as varchar(255),
 @Control_ID as int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Idioma_Control]
           ([Idioma_ID]
           ,[Traduccion]
           ,[Control_ID])
     VALUES
           (@Idioma_ID
           ,@Traduccion
           ,@Control_ID)
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteComponente]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[DeleteComponente]
(
@id int
)
as
delete from componente
where ID=@id


GO
/****** Object:  StoredProcedure [dbo].[DeleteIdioma]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteIdioma]
	-- Add the parameters for the stored procedure here
	@IdiomaID As Integer
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[Idioma_Control]
      WHERE [Idioma_ID] = @IdiomaID

	DELETE FROM [dbo].[Idioma]
      WHERE [ID] = @IdiomaID
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteTraduccion]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteTraduccion]
	-- Add the parameters for the stored procedure here
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[Idioma_Control]
      WHERE ID = @ID
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[DeleteUser]
(
@ID int
)
as
delete from usuario
where id=@ID


GO
/****** Object:  StoredProcedure [dbo].[ElementoAcademicoActualizar]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ElementoAcademicoActualizar]	@CodigoAcademico int,	@Comentario varchar(255),	@Contenido varchar(255),	@CriteriosAprobacion varchar(255),	@Descripcion varchar(255),	@Duracion int,	@FechaInicio date,	@Nombre varchar(100),	@Temas varchar(255),	@Cupo int,	@Clases int,	@Precio decimalASSET NOCOUNT ONIF @CodigoAcademico = 0 BEGIN	INSERT INTO ElementoAcademico (		[Comentario],		[Contenido],		[CriteriosAprobacion],		[Descripcion],		[Duracion],		[FechaInicio],		[Nombre],		[Temas],		[Cupo],		[Clases],		[Precio]	)	VALUES (		@Comentario,		@Contenido,		@CriteriosAprobacion,		@Descripcion,		@Duracion,		@FechaInicio,		@Nombre,		@Temas,		@Cupo,		@Clases,		@Precio	)	SELECT SCOPE_IDENTITY() As InsertedIDENDELSE BEGIN	UPDATE ElementoAcademico SET 		[Comentario] = @Comentario,		[Contenido] = @Contenido,		[CriteriosAprobacion] = @CriteriosAprobacion,		[Descripcion] = @Descripcion,		[Duracion] = @Duracion,		[FechaInicio] = @FechaInicio,		[Nombre] = @Nombre,		[Temas] = @Temas,		[Cupo] = @Cupo,		[Clases] = @Clases,		[Precio] = @Precio	WHERE [CodigoAcademico] = @CodigoAcademicoENDSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[ElementoAcademicoBorrar]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ElementoAcademicoBorrar]	@CodigoAcademico intASSET NOCOUNT ONDELETE FROM ElementoAcademicoWHERE [CodigoAcademico] = @CodigoAcademicoSET NOCOUNT OFF

GO
/****** Object:  StoredProcedure [dbo].[ElementoAcademicoListar]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ElementoAcademicoListar]ASSET NOCOUNT ONSELECT * FROM ElementoAcademicoSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[ElementoAcademicoObtener]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ElementoAcademicoObtener]	@CodigoAcademico intASSET NOCOUNT ONSELECT * FROM ElementoAcademicoWHERE [CodigoAcademico] = @CodigoAcademicoSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[GetAllComponents]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetAllComponents]
as
select c.ID, c.Nombre, c.Descripcion, c.Control_ID, c.URL from componente c


GO
/****** Object:  StoredProcedure [dbo].[GetAllDigits]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[GetAllDigits]
as
select Tabla, DigitoV from DigitoV




GO
/****** Object:  StoredProcedure [dbo].[GetAllFamilies]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetAllFamilies]
as
select ID, Nombre, Descripcion from componente 
where Control_ID is null


GO
/****** Object:  StoredProcedure [dbo].[GetAllIdioms]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[GetAllIdioms]
as
select i.ID, i.Nombre from idioma i
order by Nombre


GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetAllUsers]
as
select ID, Apellido, Nombre, UserName, Activo, Admin, Idioma_Id, Password, Intentos, Email from usuario
order by UserName



GO
/****** Object:  StoredProcedure [dbo].[GetCapacidadesPorPerfil]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCapacidadesPorPerfil]
(
	@id_perfil int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT c.ID, c.Descripcion, cp.Nivel
	FROM Capacidades c
	INNER JOIN Capacidad_Perfil cp ON c.ID = cp.ID_Capacidad
	WHERE cp.ID_Perfil = @id_perfil 
END


GO
/****** Object:  StoredProcedure [dbo].[GetComponentsByFamily]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetComponentsByFamily]
(
@fam int
)
as
select C.* from componente_parent CP
inner join componente C on CP.Child_ID=C.ID
where Parent_ID=@fam


GO
/****** Object:  StoredProcedure [dbo].[GetComponentsByUsu]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[GetComponentsByUsu]
(
@usu int
)
as
select C.* from usuario U
inner join usuario_componente UC on U.ID=UC.Usu_ID
inner join componente C on UC.Comp_ID=C.ID
where U.id=@usu


GO
/****** Object:  StoredProcedure [dbo].[GetItemsBitacora]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetItemsBitacora]
as
select * from bitacora
order by FechaHora desc


GO
/****** Object:  StoredProcedure [dbo].[GetRow4DH]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[GetRow4DH]
(
@table varchar(50),
@id varchar(100)
)
as

exec('select * from ' + @table + ' where ' + @id);



GO
/****** Object:  StoredProcedure [dbo].[GetTable4DV]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[GetTable4DV]
(
@table varchar(50)
)
as
exec('select * from ' + @table);




GO
/****** Object:  StoredProcedure [dbo].[GetTranslationsByForm]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[GetTranslationsByForm]
(
@FormId int,
@Idiom int
)
as
select IC.Control_ID, IC.Traduccion from control C 
inner join Idioma_Control IC on C.ID=IC.Control_ID
where C.Form_ID = @FormId and Idioma_ID = @Idiom
union
select IC.Control_ID, IC.Traduccion from control C 
inner join Idioma_Control IC on C.ID=IC.Control_ID
where 
C.Id=@FormId and Idioma_ID = @Idiom


GO
/****** Object:  StoredProcedure [dbo].[GetTranslationsByIdiom]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTranslationsByIdiom]
	-- Add the parameters for the stored procedure here
	@Idiom int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [ID]
      ,[Idioma_ID]
      ,[Traduccion]
      ,[Control_ID]
  FROM [agrorobots].[dbo].[Idioma_Control]
  WHERE [Idioma_ID] = @Idiom
  ORDER BY [Control_ID]
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserByUserName]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetUserByUserName](
@usu varchar(20)
)
as
select * from usuario
where UserName=@usu


GO
/****** Object:  StoredProcedure [dbo].[ListarMensajes]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ListarMensajes]
AS
SET NOCOUNT ON

SELECT [ID], 
	[Contenido], 
	[UsuarioEmisor], 
	[EmailEmisor],
	[RolEmisor], 
	[UsuarioReceptor], 
	[EmailReceptor],
	[RolReceptor], 
	[Broadcast], 
	[ID_Conversacion], 
	[Leido], 
	[Fecha]
FROM Mensajes


SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[LogInBitagora]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[LogInBitagora]
(
@tipo varchar(10),
@desc varchar(2000),
@user varchar(50)
)
as
insert into Bitacora
(
FechaHora,
Tipo,
Descripcion,
[User]
)
values
(
getdate(),
@tipo,
@desc,
@user
)




GO
/****** Object:  StoredProcedure [dbo].[MensajeActualizar]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MensajeActualizar]

	@ID int,
	@Contenido varchar(50),
	@UsuarioEmisor int,
	@EmailEmisor varchar(50),
	@RolEmisor int,
	@UsuarioReceptor int,
	@EmailReceptor varchar(50),
	@RolReceptor int,
	@Broadcast bit,
	@ID_Conversacion int,
	@Leido bit,
	@Fecha datetime
AS
SET NOCOUNT ON
IF @ID = 0 BEGIN
	INSERT INTO Mensajes (
		[Contenido],
		[UsuarioEmisor],
		[EmailEmisor],
		[RolEmisor],
		[UsuarioReceptor],
		[EmailReceptor],
		[RolReceptor],
		[Broadcast],
		[ID_Conversacion],
		[Leido],
		[Fecha]
	)
	VALUES (
		@Contenido,
		@UsuarioEmisor,
		@EmailEmisor,
		@RolEmisor,
		@UsuarioReceptor,
		@EmailReceptor,
		@RolReceptor,
		@Broadcast,
		@ID_Conversacion,
		@Leido,
		@Fecha
	)
	SELECT SCOPE_IDENTITY() As InsertedID
END
ELSE BEGIN
	UPDATE Mensajes SET 
		[Contenido] = @Contenido,
		[UsuarioEmisor] = @UsuarioEmisor,
		[EmailEmisor] = @EmailEmisor,
		[RolEmisor] = @RolEmisor,
		[UsuarioReceptor] = @UsuarioReceptor,
		[EmailReceptor] = @EmailReceptor,
		[RolReceptor] = @RolReceptor,
		[Broadcast] = @Broadcast,
		[ID_Conversacion] = @ID_Conversacion,
		[Leido] = @Leido,
		[Fecha] = @Fecha
	WHERE [ID] = @ID

END

SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[MensajeBorrar]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MensajeBorrar]	@ID intASSET NOCOUNT ONDELETE FROM MensajesWHERE [ID] = @IDSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[MensajeListar]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MensajeListar]ASSET NOCOUNT ONSELECT * FROM MensajesSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[MensajeObtener]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MensajeObtener]	@ID intASSET NOCOUNT ONSELECT * FROM MensajesWHERE [ID] = @IDSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[MensajeObtenerPorRol]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MensajeObtenerPorRol]
	@Rol int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [ID], 
	[Contenido], 
	[UsuarioEmisor], 
	[EmailEmisor],
	[RolEmisor], 
	[UsuarioReceptor], 
	[EmailReceptor],
	[RolReceptor], 
	[Broadcast], 
	[ID_Conversacion], 
	[Leido], 
	[Fecha]
FROM Mensajes
WHERE [RolEmisor] = @Rol OR [RolReceptor] = @Rol
END

GO
/****** Object:  StoredProcedure [dbo].[MensajeObtenerPorUsuario]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MensajeObtenerPorUsuario]
	@Usuario int
AS
SET NOCOUNT ON

SELECT [ID], 
	[Contenido], 
	[UsuarioEmisor], 
	[EmailEmisor],
	[RolEmisor], 
	[UsuarioReceptor], 
	[EmailReceptor],
	[RolReceptor], 
	[Broadcast], 
	[ID_Conversacion], 
	[Leido], 
	[Fecha]
FROM Mensajes
WHERE [UsuarioEmisor] = @Usuario OR [UsuarioReceptor] = @Usuario
GO
/****** Object:  StoredProcedure [dbo].[NewFamilia]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[NewFamilia]
(
@name varchar(20),
@desc varchar(50)
)
as
insert into Componente
(Nombre, Descripcion)
values
(@name, @desc);

SELECT @@IDENTITY AS 'Identity';


GO
/****** Object:  StoredProcedure [dbo].[NewUser]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[NewUser]
(
@Activo bit,
@Admin bit,
@Apellido varchar(50),
@Idioma_Id int,
@Nombre varchar(50),
@Password varchar(50),
@UserName varchar(50),
@Email varchar(50)
)
as
insert into Usuario
(
Activo,
Admin,
Apellido,
Idioma_ID,
Nombre,
Password,
UserName,
Intentos,
Email 
)
values
(
@Activo,
@Admin,
@Apellido,
@Idioma_Id,
@Nombre,
@Password,
@UserName,
0,
@Email
);

SELECT @@IDENTITY AS 'Identity';


GO
/****** Object:  StoredProcedure [dbo].[RemoveAllComponentesFromUsu]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[RemoveAllComponentesFromUsu]
(
@UsuId int
)
as

delete from usuario_componente
where Usu_ID=@UsuId;


GO
/****** Object:  StoredProcedure [dbo].[SetDHToRow]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[SetDHToRow]
(
@table varchar(50),
@id varchar(100),
@hash varchar(1000)
)
as

DECLARE @str varchar(1000);

set @str = 'update ' + @table + ' set DigitoH=' + char(39) + @hash + char(39) + ' where ' + @id;

exec(@str);




GO
/****** Object:  StoredProcedure [dbo].[SetDVbyTable]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[SetDVbyTable]
(
@table varchar(50),
@hash varchar(50)
)
as
declare @exist int;
set @exist = (select Count(*) from DigitoV where Tabla=@table);

if @exist = 0
begin
    insert into DigitoV(Tabla,DigitoV) values (@table,@hash);
end
else
begin
    update DigitoV set DigitoV=@hash where Tabla=@table;
end



GO
/****** Object:  StoredProcedure [dbo].[UpdateFamilia]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Procedure [dbo].[UpdateFamilia]
(
@ID int,
@name varchar(50),
@desc varchar(50)
)
as
update componente
set
Nombre=@name,
Descripcion=@desc
where
ID=@ID


GO
/****** Object:  StoredProcedure [dbo].[UpdateIdioma]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateIdioma]
	-- Add the parameters for the stored procedure here
	@ID as smallint,
	@Desc as varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Idioma]
   SET [Nombre] = @Desc
	WHERE [ID] = @ID
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateTraduccionByID]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateTraduccionByID]
	-- Add the parameters for the stored procedure here
	@ID int,
	@Traduccion varchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update [Idioma_Control]
set
Traduccion = @Traduccion
where
ID = @ID
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateUserByUsuOrId]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[UpdateUserByUsuOrId](
@ID int,
@Activo bit,
@Admin bit,
@Apellido varchar(50),
@Idioma_ID smallint,
@Nombre varchar(50),
@UserName varchar(20),
@Intentos int,
@Email varchar(50)
)
as
update usuario
set
Activo = @Activo,
Admin = @Admin,
Apellido = @Apellido,
Idioma_ID = @Idioma_ID,
Nombre = @Nombre,
UserName = @UserName,
Intentos = @Intentos,
Email = @Email
where
ID = @ID


GO
/****** Object:  StoredProcedure [dbo].[UpdateUserPassword]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateUserPassword]
	-- Add the parameters for the stored procedure here
	@ID int,
	@Password varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Usuario]
   SET Password = @Password
	WHERE ID = @ID
END

GO
/****** Object:  StoredProcedure [dbo].[UsuarioObtenerPorId]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UsuarioObtenerPorId]
	
@IDUsuario int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from usuario
where ID = @IDUsuario
END

GO
/****** Object:  Table [dbo].[Bitacora]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bitacora](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[FechaHora] [datetime] NULL,
	[Tipo] [varchar](10) NULL,
	[Descripcion] [varchar](2000) NULL,
	[User] [varchar](50) NULL,
 CONSTRAINT [PK_Bitacora] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Componente]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Componente](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Descripcion] [varchar](50) NULL,
	[Control_ID] [int] NULL,
	[URL] [varchar](50) NULL,
 CONSTRAINT [PK_Componente] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Componente_Parent]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Componente_Parent](
	[Child_Id] [int] NOT NULL,
	[Parent_Id] [int] NOT NULL,
 CONSTRAINT [PK_Component_Parent] PRIMARY KEY CLUSTERED 
(
	[Child_Id] ASC,
	[Parent_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Control]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Control](
	[ID] [int] NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Form_ID] [int] NULL,
 CONSTRAINT [PK_Control] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DigitoV]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DigitoV](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Tabla] [varchar](50) NULL,
	[DigitoV] [varchar](50) NULL,
 CONSTRAINT [PK_DigitoV] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ElementoAcademico]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ElementoAcademico](
	[CodigoAcademico] [int] IDENTITY(1,1) NOT NULL,
	[Comentario] [varchar](255) NULL,
	[Contenido] [varchar](255) NULL,
	[CriteriosAprobacion] [varchar](255) NULL,
	[Descripcion] [varchar](255) NULL,
	[Duracion] [int] NULL,
	[FechaInicio] [date] NULL,
	[Nombre] [varchar](100) NULL,
	[Temas] [varchar](255) NULL,
	[Cupo] [int] NULL,
	[Clases] [int] NULL,
	[Precio] [decimal](18, 2) NULL,
 CONSTRAINT [PK_ElementoAcademico] PRIMARY KEY CLUSTERED 
(
	[CodigoAcademico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Formulario]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Formulario](
	[ID] [int] NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Formulario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Idioma]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Idioma](
	[ID] [smallint] NOT NULL,
	[Nombre] [varchar](50) NULL,
 CONSTRAINT [PK_Idioma] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Idioma_Control]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Idioma_Control](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Idioma_ID] [smallint] NOT NULL,
	[Traduccion] [varchar](200) NULL,
	[Control_ID] [int] NULL,
 CONSTRAINT [PK_Idioma_Control] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Mensajes]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mensajes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Contenido] [varchar](255) NULL,
	[UsuarioEmisor] [int] NULL,
	[EmailEmisor] [varchar](50) NULL,
	[RolEmisor] [int] NULL,
	[UsuarioReceptor] [int] NULL,
	[EmailReceptor] [varchar](50) NULL,
	[RolReceptor] [int] NULL,
	[Broadcast] [bit] NULL,
	[ID_Conversacion] [int] NULL,
	[Leido] [bit] NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_Mensajes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Activo] [bit] NULL,
	[Admin] [bit] NULL,
	[Apellido] [varchar](50) NULL,
	[Idioma_ID] [smallint] NULL,
	[Nombre] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[UserName] [varchar](20) NOT NULL,
	[Intentos] [smallint] NULL,
	[DigitoH] [varchar](1050) NULL,
	[Email] [varchar](50) NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario_Componente]    Script Date: 22/09/2015 18:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Componente](
	[Usu_ID] [int] NOT NULL,
	[Comp_ID] [int] NOT NULL,
 CONSTRAINT [PK_Usuario_Componente] PRIMARY KEY CLUSTERED 
(
	[Usu_ID] ASC,
	[Comp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Bitacora] ON 

INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1908, CAST(N'2015-07-15 02:20:34.047' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1909, CAST(N'2015-07-15 19:16:45.697' AS DateTime), N'Restore', N'Restore realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1910, CAST(N'2015-07-15 22:50:37.527' AS DateTime), N'Login', N'Login insatisfactorio', N'pepe_alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1911, CAST(N'2015-07-15 22:50:43.160' AS DateTime), N'Login', N'Login insatisfactorio', N'pepe_alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1912, CAST(N'2015-07-15 23:56:49.480' AS DateTime), N'Restore', N'Restore realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1913, CAST(N'2015-07-15 23:59:34.697' AS DateTime), N'Login', N'Login exitoso', N'pepe_profe')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1914, CAST(N'2015-07-16 00:01:41.163' AS DateTime), N'Logout', N'Logout exitoso', N'pepe_profe')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1915, CAST(N'2015-07-16 00:01:53.557' AS DateTime), N'Login', N'Login exitoso', N'pepe_director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1916, CAST(N'2015-07-16 00:02:06.357' AS DateTime), N'Logout', N'Logout exitoso', N'pepe_director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1917, CAST(N'2015-07-16 00:03:44.457' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1918, CAST(N'2015-06-26 02:01:00.957' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1919, CAST(N'2015-06-26 02:05:38.413' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1920, CAST(N'2015-07-15 23:14:32.377' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1921, CAST(N'2015-07-16 00:05:15.810' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1922, CAST(N'2015-07-16 00:07:37.120' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1923, CAST(N'2015-07-16 00:13:21.947' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1924, CAST(N'2015-07-16 00:14:45.530' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1925, CAST(N'2015-07-16 00:15:35.220' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1926, CAST(N'2015-07-16 00:15:47.217' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1927, CAST(N'2015-07-16 00:25:11.013' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1928, CAST(N'2015-07-16 00:26:04.620' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1929, CAST(N'2015-07-16 00:31:45.917' AS DateTime), N'Login', N'Login insatisfactorio', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1930, CAST(N'2015-07-16 00:31:49.680' AS DateTime), N'Login', N'Login insatisfactorio', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1931, CAST(N'2015-07-16 00:31:53.783' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1932, CAST(N'2015-07-16 00:32:14.330' AS DateTime), N'Login', N'Login insatisfactorio', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1933, CAST(N'2015-07-16 00:32:58.643' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1934, CAST(N'2015-07-16 00:36:14.177' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1935, CAST(N'2015-07-16 00:36:53.467' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1936, CAST(N'2015-07-16 00:43:53.897' AS DateTime), N'Login', N'Login insatisfactorio', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1937, CAST(N'2015-07-16 00:43:55.513' AS DateTime), N'Login', N'Login insatisfactorio', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1938, CAST(N'2015-07-16 00:44:01.357' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1939, CAST(N'2015-07-16 00:44:53.813' AS DateTime), N'Login', N'Login insatisfactorio', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1940, CAST(N'2015-07-16 00:44:54.840' AS DateTime), N'Login', N'Login insatisfactorio', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1941, CAST(N'2015-07-16 00:47:45.637' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1942, CAST(N'2015-07-16 00:48:03.613' AS DateTime), N'Login', N'Login insatisfactorio', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1943, CAST(N'2015-07-16 00:48:14.800' AS DateTime), N'Login', N'Login insatisfactorio', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1944, CAST(N'2015-07-16 00:52:14.187' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1945, CAST(N'2015-07-16 00:52:20.290' AS DateTime), N'Login', N'Login insatisfactorio', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1946, CAST(N'2015-07-16 00:52:21.227' AS DateTime), N'Login', N'Login insatisfactorio', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1947, CAST(N'2015-07-16 01:10:53.380' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1948, CAST(N'2015-07-16 01:35:48.193' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1949, CAST(N'2015-07-16 01:35:49.723' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1950, CAST(N'2015-07-16 01:47:57.903' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1951, CAST(N'2015-07-16 01:48:50.383' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1952, CAST(N'2015-07-16 01:49:54.330' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1953, CAST(N'2015-07-16 01:50:07.503' AS DateTime), N'Login', N'Login insatisfactorio', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1954, CAST(N'2015-07-16 01:50:49.387' AS DateTime), N'Login', N'Login insatisfactorio', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1955, CAST(N'2015-07-16 01:54:21.767' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1956, CAST(N'2015-07-16 01:59:49.067' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1957, CAST(N'2015-07-16 02:01:52.280' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1958, CAST(N'2015-07-16 02:02:23.160' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1959, CAST(N'2015-07-16 02:04:07.670' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1960, CAST(N'2015-07-16 03:10:27.673' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1961, CAST(N'2015-07-16 03:10:51.430' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1962, CAST(N'2015-07-16 03:14:52.660' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1963, CAST(N'2015-07-16 03:15:59.420' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1964, CAST(N'2015-07-16 03:16:02.027' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1965, CAST(N'2015-07-16 03:17:44.080' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1966, CAST(N'2015-07-16 04:15:51.087' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1967, CAST(N'2015-07-16 04:17:42.267' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1968, CAST(N'2015-07-16 04:22:37.283' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1969, CAST(N'2015-07-16 04:38:26.137' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1970, CAST(N'2015-07-16 04:38:52.500' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1971, CAST(N'2015-07-16 04:54:46.697' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1972, CAST(N'2015-07-16 04:55:19.680' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (1973, CAST(N'2015-07-16 05:04:13.317' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11920, CAST(N'2015-08-17 17:05:09.740' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11921, CAST(N'2015-08-17 17:15:21.380' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11922, CAST(N'2015-08-17 17:47:51.163' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11923, CAST(N'2015-08-17 18:47:26.127' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11924, CAST(N'2015-08-17 18:47:57.393' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11925, CAST(N'2015-08-17 18:48:11.660' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11926, CAST(N'2015-08-17 18:52:20.440' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11927, CAST(N'2015-08-17 19:08:42.870' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11928, CAST(N'2015-08-17 19:08:46.050' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11929, CAST(N'2015-08-17 19:08:49.327' AS DateTime), N'Login', N'Login insatisfactorio', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11930, CAST(N'2015-08-17 19:08:57.453' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11931, CAST(N'2015-08-17 19:09:37.353' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11932, CAST(N'2015-08-17 19:14:22.037' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11933, CAST(N'2015-08-17 19:14:32.957' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11934, CAST(N'2015-08-17 19:14:39.483' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11935, CAST(N'2015-08-17 19:15:41.247' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11936, CAST(N'2015-08-17 19:17:56.030' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11937, CAST(N'2015-08-17 19:18:02.207' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11938, CAST(N'2015-08-17 19:24:51.340' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11939, CAST(N'2015-08-17 19:25:03.697' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11940, CAST(N'2015-08-17 19:25:03.720' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11941, CAST(N'2015-08-17 19:29:36.173' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11942, CAST(N'2015-08-17 19:29:58.150' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11943, CAST(N'2015-08-17 19:29:58.170' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11944, CAST(N'2015-08-17 19:32:49.580' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11945, CAST(N'2015-08-17 19:32:57.800' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11946, CAST(N'2015-08-17 19:32:57.817' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11947, CAST(N'2015-08-17 20:19:29.410' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11948, CAST(N'2015-08-17 20:19:29.440' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11949, CAST(N'2015-08-17 20:20:31.127' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11950, CAST(N'2015-08-17 20:20:31.160' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11951, CAST(N'2015-08-17 20:20:55.723' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11952, CAST(N'2015-08-17 20:20:55.757' AS DateTime), N'500', N'501', N'Test de permisos')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11953, CAST(N'2015-08-17 20:22:10.543' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11954, CAST(N'2015-08-17 20:22:10.577' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11955, CAST(N'2015-08-17 20:24:51.883' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11956, CAST(N'2015-08-17 20:25:29.910' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11957, CAST(N'2015-08-17 20:25:32.547' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11958, CAST(N'2015-08-17 20:26:10.880' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11959, CAST(N'2015-08-17 20:27:06.317' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11960, CAST(N'2015-08-17 20:27:09.413' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11961, CAST(N'2015-08-17 20:27:14.723' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11962, CAST(N'2015-08-17 20:30:36.760' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11963, CAST(N'2015-08-17 20:30:41.150' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11964, CAST(N'2015-08-17 20:36:07.193' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11965, CAST(N'2015-08-17 20:36:07.243' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11966, CAST(N'2015-08-17 20:41:51.427' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11967, CAST(N'2015-08-17 20:41:51.447' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11968, CAST(N'2015-08-17 23:40:34.930' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11969, CAST(N'2015-08-17 23:40:34.980' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11970, CAST(N'2015-08-17 23:43:28.813' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11971, CAST(N'2015-08-17 23:43:28.860' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11972, CAST(N'2015-08-17 23:54:30.077' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11973, CAST(N'2015-08-17 23:54:30.123' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11974, CAST(N'2015-08-17 23:54:57.780' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11975, CAST(N'2015-08-17 23:54:57.823' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11976, CAST(N'2015-08-18 00:28:59.197' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11977, CAST(N'2015-08-18 00:28:59.243' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11978, CAST(N'2015-08-18 00:32:07.170' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11979, CAST(N'2015-08-18 00:32:07.220' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11980, CAST(N'2015-08-18 00:37:23.270' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11981, CAST(N'2015-08-18 00:37:23.320' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11982, CAST(N'2015-08-18 00:38:53.907' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11983, CAST(N'2015-08-18 00:38:53.957' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11984, CAST(N'2015-08-18 00:40:30.563' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11985, CAST(N'2015-08-18 00:40:30.610' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11986, CAST(N'2015-08-18 00:41:21.803' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11987, CAST(N'2015-08-18 00:41:21.850' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11988, CAST(N'2015-08-18 00:42:17.737' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11989, CAST(N'2015-08-18 00:42:17.790' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11990, CAST(N'2015-08-18 01:24:41.917' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11991, CAST(N'2015-08-18 01:24:41.950' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11992, CAST(N'2015-08-18 01:31:06.367' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11993, CAST(N'2015-08-18 01:31:06.413' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11994, CAST(N'2015-08-18 01:37:37.937' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11995, CAST(N'2015-08-18 01:37:37.983' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11996, CAST(N'2015-08-18 01:38:50.313' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11997, CAST(N'2015-08-18 01:38:50.360' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11998, CAST(N'2015-08-18 01:52:36.830' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (11999, CAST(N'2015-08-18 01:52:36.877' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12000, CAST(N'2015-08-18 02:07:01.793' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12001, CAST(N'2015-08-18 02:07:01.843' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12002, CAST(N'2015-08-18 02:09:17.557' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12003, CAST(N'2015-08-18 02:09:17.603' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12004, CAST(N'2015-08-18 02:11:37.383' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12005, CAST(N'2015-08-18 02:11:37.430' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12006, CAST(N'2015-08-18 16:39:02.690' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12007, CAST(N'2015-08-18 16:39:02.737' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12008, CAST(N'2015-08-18 16:43:25.807' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12009, CAST(N'2015-08-18 16:43:25.860' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12010, CAST(N'2015-08-18 16:44:59.010' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12011, CAST(N'2015-08-18 16:44:59.060' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12012, CAST(N'2015-08-18 16:46:24.217' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12013, CAST(N'2015-08-18 16:46:24.263' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12014, CAST(N'2015-08-18 16:57:46.897' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12015, CAST(N'2015-08-18 16:57:46.950' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12016, CAST(N'2015-08-18 17:02:10.690' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12017, CAST(N'2015-08-18 17:02:10.693' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12018, CAST(N'2015-08-18 17:03:14.583' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12019, CAST(N'2015-08-18 17:03:14.633' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12020, CAST(N'2015-08-18 17:03:59.437' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12021, CAST(N'2015-08-18 17:03:59.487' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12022, CAST(N'2015-08-18 17:04:24.937' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12023, CAST(N'2015-08-18 17:04:24.973' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12024, CAST(N'2015-08-18 17:07:33.857' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12025, CAST(N'2015-08-18 17:07:33.910' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12026, CAST(N'2015-08-18 17:18:00.423' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12027, CAST(N'2015-08-18 17:18:00.473' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12028, CAST(N'2015-08-18 17:21:20.677' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12029, CAST(N'2015-08-18 17:21:20.710' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12030, CAST(N'2015-08-18 17:22:53.090' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12031, CAST(N'2015-08-18 17:22:53.127' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12032, CAST(N'2015-08-18 17:23:02.550' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12033, CAST(N'2015-08-18 17:23:02.567' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12034, CAST(N'2015-08-18 17:23:17.087' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12035, CAST(N'2015-08-18 17:23:17.120' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12036, CAST(N'2015-08-18 17:28:54.593' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12037, CAST(N'2015-08-18 17:28:54.597' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12038, CAST(N'2015-08-18 17:33:15.230' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12039, CAST(N'2015-08-18 17:33:18.420' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12040, CAST(N'2015-08-18 17:33:26.483' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12041, CAST(N'2015-08-18 17:33:26.523' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12042, CAST(N'2015-08-18 17:33:45.073' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12043, CAST(N'2015-08-18 17:33:45.123' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12044, CAST(N'2015-08-18 17:35:24.940' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12045, CAST(N'2015-08-18 17:35:24.973' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12046, CAST(N'2015-08-18 17:36:44.643' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12047, CAST(N'2015-08-18 17:36:44.693' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12048, CAST(N'2015-08-18 17:37:59.683' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12049, CAST(N'2015-08-18 17:37:59.717' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12050, CAST(N'2015-08-18 17:38:28.567' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12051, CAST(N'2015-08-18 17:38:28.587' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12052, CAST(N'2015-08-18 17:53:33.910' AS DateTime), N'Login', N'Login exitoso', N'profesor')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12053, CAST(N'2015-08-18 17:53:33.950' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12054, CAST(N'2015-08-18 17:54:59.123' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12055, CAST(N'2015-08-18 17:54:59.143' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12056, CAST(N'2015-08-18 17:55:08.503' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12057, CAST(N'2015-08-18 17:55:08.527' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12058, CAST(N'2015-08-18 17:58:41.570' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12059, CAST(N'2015-08-18 17:58:41.593' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12060, CAST(N'2015-08-18 17:59:56.133' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12061, CAST(N'2015-08-18 17:59:56.167' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12062, CAST(N'2015-08-18 18:00:13.747' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12063, CAST(N'2015-08-18 18:00:13.770' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12064, CAST(N'2015-08-18 18:02:14.430' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12065, CAST(N'2015-08-18 18:02:14.467' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12066, CAST(N'2015-08-18 18:03:27.980' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12067, CAST(N'2015-08-18 18:03:28.003' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12068, CAST(N'2015-08-18 18:03:53.820' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12069, CAST(N'2015-08-18 18:03:53.850' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12070, CAST(N'2015-08-18 18:26:58.597' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12071, CAST(N'2015-08-18 18:26:58.620' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12072, CAST(N'2015-08-18 18:27:33.660' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12073, CAST(N'2015-08-18 18:27:33.680' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12074, CAST(N'2015-08-18 18:28:13.977' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12075, CAST(N'2015-08-18 18:28:14.000' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12076, CAST(N'2015-08-18 18:28:35.323' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12077, CAST(N'2015-08-18 18:28:35.343' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12078, CAST(N'2015-08-18 18:28:47.063' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12079, CAST(N'2015-08-18 18:28:47.087' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12080, CAST(N'2015-08-18 18:30:25.247' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12081, CAST(N'2015-08-18 18:30:25.270' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12082, CAST(N'2015-08-18 18:30:32.940' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12083, CAST(N'2015-08-18 18:30:32.963' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12084, CAST(N'2015-08-18 19:21:53.747' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12085, CAST(N'2015-08-18 19:21:57.073' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12086, CAST(N'2015-08-18 19:21:57.337' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12087, CAST(N'2015-08-18 19:22:22.163' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12088, CAST(N'2015-08-18 19:22:22.193' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12089, CAST(N'2015-08-18 19:22:41.383' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12090, CAST(N'2015-08-18 19:22:41.427' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12091, CAST(N'2015-08-18 19:22:56.353' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12092, CAST(N'2015-08-18 19:22:56.383' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12093, CAST(N'2015-08-18 19:29:49.937' AS DateTime), N'Login', N'Login exitoso', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12094, CAST(N'2015-08-18 19:29:49.983' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12095, CAST(N'2015-08-18 19:31:43.360' AS DateTime), N'Login', N'Login exitoso', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12096, CAST(N'2015-08-18 19:31:43.390' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12097, CAST(N'2015-08-18 19:35:28.150' AS DateTime), N'Login', N'Login exitoso', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12098, CAST(N'2015-08-18 19:35:28.180' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12099, CAST(N'2015-08-18 19:37:28.007' AS DateTime), N'Login', N'Login exitoso', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12100, CAST(N'2015-08-18 19:37:28.037' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12101, CAST(N'2015-08-18 19:38:44.730' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12102, CAST(N'2015-08-18 19:38:44.760' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12103, CAST(N'2015-08-18 19:44:50.600' AS DateTime), N'Login', N'Login insatisfactorio', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12104, CAST(N'2015-08-18 19:44:54.103' AS DateTime), N'Login', N'Login insatisfactorio', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12105, CAST(N'2015-08-18 20:47:31.380' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12106, CAST(N'2015-08-18 20:47:31.433' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12107, CAST(N'2015-08-18 20:55:08.843' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12108, CAST(N'2015-08-18 20:55:08.883' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12109, CAST(N'2015-08-19 00:21:37.520' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12110, CAST(N'2015-08-19 00:22:31.193' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12111, CAST(N'2015-08-19 00:22:49.297' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12112, CAST(N'2015-08-19 00:23:21.183' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12113, CAST(N'2015-08-19 00:28:58.377' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12114, CAST(N'2015-08-19 00:28:58.380' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12115, CAST(N'2015-08-19 00:29:46.100' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12116, CAST(N'2015-08-19 00:29:46.100' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12117, CAST(N'2015-08-19 00:32:39.490' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12118, CAST(N'2015-08-19 00:32:39.490' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12119, CAST(N'2015-08-19 00:33:09.540' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12120, CAST(N'2015-08-19 00:33:09.577' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12121, CAST(N'2015-08-19 01:09:52.777' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12122, CAST(N'2015-08-19 01:09:52.813' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12123, CAST(N'2015-08-19 01:28:20.647' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12124, CAST(N'2015-08-19 01:28:20.680' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12125, CAST(N'2015-08-19 01:30:30.777' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12126, CAST(N'2015-08-19 01:30:30.813' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12127, CAST(N'2015-08-19 01:30:49.527' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12128, CAST(N'2015-08-19 01:30:49.563' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12129, CAST(N'2015-08-19 01:31:57.943' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12130, CAST(N'2015-08-19 01:31:57.983' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12131, CAST(N'2015-08-19 01:50:02.247' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12132, CAST(N'2015-08-19 01:50:02.287' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12133, CAST(N'2015-08-19 01:51:19.353' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12134, CAST(N'2015-08-19 01:51:19.390' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12135, CAST(N'2015-08-19 01:51:43.507' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12136, CAST(N'2015-08-19 01:51:43.543' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12137, CAST(N'2015-08-19 01:57:07.237' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12138, CAST(N'2015-08-19 01:57:07.273' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12139, CAST(N'2015-08-19 02:01:54.943' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12140, CAST(N'2015-08-19 02:01:54.980' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12141, CAST(N'2015-08-19 02:03:25.690' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12142, CAST(N'2015-08-19 02:03:25.727' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12143, CAST(N'2015-08-19 02:05:37.850' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12144, CAST(N'2015-08-19 02:05:37.890' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12145, CAST(N'2015-08-19 02:08:08.387' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12146, CAST(N'2015-08-19 02:08:08.427' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12147, CAST(N'2015-08-19 02:12:38.850' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12148, CAST(N'2015-08-19 02:12:38.890' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12149, CAST(N'2015-08-19 02:15:38.430' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12150, CAST(N'2015-08-19 02:15:38.467' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12151, CAST(N'2015-08-19 02:16:41.800' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12152, CAST(N'2015-08-19 02:16:41.847' AS DateTime), N'500', N'501', N'Test de permisos')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12153, CAST(N'2015-08-19 02:18:20.507' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12154, CAST(N'2015-08-19 02:18:20.543' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12155, CAST(N'2015-08-19 02:20:51.830' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12156, CAST(N'2015-08-19 02:20:51.873' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12157, CAST(N'2015-08-19 02:24:50.027' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12158, CAST(N'2015-08-19 02:24:50.063' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12159, CAST(N'2015-08-19 02:28:36.400' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12160, CAST(N'2015-08-19 02:28:36.440' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12161, CAST(N'2015-08-19 02:30:36.433' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12162, CAST(N'2015-08-19 02:30:36.470' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12163, CAST(N'2015-08-19 02:31:18.810' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12164, CAST(N'2015-08-19 02:31:18.853' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12165, CAST(N'2015-08-19 02:31:58.203' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12166, CAST(N'2015-08-19 02:31:58.243' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12167, CAST(N'2015-08-19 02:36:08.080' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12168, CAST(N'2015-08-19 02:36:08.117' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12169, CAST(N'2015-08-19 02:37:55.100' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12170, CAST(N'2015-08-19 02:37:55.137' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12171, CAST(N'2015-08-19 02:39:03.763' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12172, CAST(N'2015-08-19 02:39:03.800' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12173, CAST(N'2015-08-19 02:41:55.060' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12174, CAST(N'2015-08-19 02:41:55.110' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12175, CAST(N'2015-08-19 02:42:29.357' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12176, CAST(N'2015-08-19 02:42:29.393' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12177, CAST(N'2015-08-19 03:09:36.693' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12178, CAST(N'2015-08-19 03:09:36.733' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12179, CAST(N'2015-08-19 03:14:11.080' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12180, CAST(N'2015-08-19 03:14:11.130' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12181, CAST(N'2015-08-19 03:18:55.750' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12182, CAST(N'2015-08-19 03:18:55.790' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12183, CAST(N'2015-08-19 03:21:27.943' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12184, CAST(N'2015-08-19 03:21:27.980' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12185, CAST(N'2015-08-19 03:24:05.073' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12186, CAST(N'2015-08-19 03:24:05.110' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12187, CAST(N'2015-08-19 03:26:07.060' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12188, CAST(N'2015-08-19 03:26:07.097' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12189, CAST(N'2015-08-19 03:31:33.697' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12190, CAST(N'2015-08-19 03:31:33.737' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12191, CAST(N'2015-08-19 03:32:17.123' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12192, CAST(N'2015-08-19 03:32:17.160' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12193, CAST(N'2015-08-19 03:32:56.217' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12194, CAST(N'2015-08-19 03:32:56.240' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12195, CAST(N'2015-08-19 03:33:47.370' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12196, CAST(N'2015-08-19 03:33:47.393' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12197, CAST(N'2015-08-19 03:35:54.973' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12198, CAST(N'2015-08-19 03:35:55.010' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12199, CAST(N'2015-08-19 23:35:33.627' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12200, CAST(N'2015-08-19 23:35:33.630' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12201, CAST(N'2015-08-19 23:38:40.607' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12202, CAST(N'2015-08-19 23:38:40.643' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12203, CAST(N'2015-08-19 23:39:38.067' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12204, CAST(N'2015-08-19 23:39:38.100' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12205, CAST(N'2015-08-19 23:41:11.760' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12206, CAST(N'2015-08-19 23:41:11.800' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12207, CAST(N'2015-08-19 23:43:23.153' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12208, CAST(N'2015-08-19 23:43:23.190' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12209, CAST(N'2015-08-19 23:44:55.380' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12210, CAST(N'2015-08-19 23:44:55.420' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12211, CAST(N'2015-08-19 23:48:16.043' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12212, CAST(N'2015-08-19 23:48:16.080' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12213, CAST(N'2015-08-19 23:48:45.767' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12214, CAST(N'2015-08-19 23:48:45.790' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12215, CAST(N'2015-08-19 23:49:09.510' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12216, CAST(N'2015-08-19 23:49:09.547' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12217, CAST(N'2015-08-19 23:57:06.947' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12218, CAST(N'2015-08-19 23:57:06.983' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12219, CAST(N'2015-08-20 00:02:51.957' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12220, CAST(N'2015-08-20 00:02:51.990' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12221, CAST(N'2015-08-20 00:05:26.747' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12222, CAST(N'2015-08-20 00:05:26.783' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12223, CAST(N'2015-08-20 00:11:28.797' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12224, CAST(N'2015-08-20 00:11:28.833' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12225, CAST(N'2015-08-20 00:14:11.510' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12226, CAST(N'2015-08-20 00:14:11.547' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12227, CAST(N'2015-08-20 00:16:31.580' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12228, CAST(N'2015-08-20 00:16:31.583' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12229, CAST(N'2015-08-20 00:17:19.307' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12230, CAST(N'2015-08-20 00:17:19.310' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12231, CAST(N'2015-08-20 00:29:05.993' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12232, CAST(N'2015-08-20 00:29:06.033' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12233, CAST(N'2015-08-20 00:29:18.670' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12234, CAST(N'2015-08-20 00:29:18.690' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12235, CAST(N'2015-08-20 00:30:26.060' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12236, CAST(N'2015-08-20 00:30:31.127' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12237, CAST(N'2015-08-20 00:30:34.460' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12238, CAST(N'2015-08-20 00:30:34.490' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12239, CAST(N'2015-08-20 00:31:00.187' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12240, CAST(N'2015-08-20 00:31:00.210' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12241, CAST(N'2015-08-20 00:31:58.130' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12242, CAST(N'2015-08-20 00:31:58.130' AS DateTime), N'500', N'501', N'Test de permisos')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12243, CAST(N'2015-08-20 00:33:09.213' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12244, CAST(N'2015-08-20 00:57:32.570' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12245, CAST(N'2015-08-20 00:57:41.043' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12246, CAST(N'2015-08-21 01:41:13.937' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12247, CAST(N'2015-08-21 01:41:19.077' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12248, CAST(N'2015-08-21 01:41:37.283' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12249, CAST(N'2015-08-21 01:42:58.180' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12250, CAST(N'2015-08-21 01:48:09.330' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12251, CAST(N'2015-08-21 01:50:07.370' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12252, CAST(N'2015-08-21 01:53:56.120' AS DateTime), N'Login', N'Login exitoso', N'admin')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12253, CAST(N'2015-08-21 02:13:00.797' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12254, CAST(N'2015-08-21 02:13:45.933' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12255, CAST(N'2015-08-21 02:14:59.223' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12256, CAST(N'2015-08-21 02:15:33.763' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12257, CAST(N'2015-08-21 02:16:04.347' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12258, CAST(N'2015-08-21 02:17:34.980' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12259, CAST(N'2015-08-21 02:18:17.873' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12260, CAST(N'2015-08-21 02:19:09.887' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12261, CAST(N'2015-08-21 02:21:40.800' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12262, CAST(N'2015-08-21 02:23:59.257' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12263, CAST(N'2015-08-21 02:26:53.577' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12264, CAST(N'2015-08-23 16:35:55.393' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12265, CAST(N'2015-08-23 16:57:29.587' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12266, CAST(N'2015-08-23 17:09:10.480' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12267, CAST(N'2015-08-23 17:17:28.963' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12268, CAST(N'2015-08-23 17:18:12.967' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12269, CAST(N'2015-08-23 17:20:53.100' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12270, CAST(N'2015-08-23 17:25:07.333' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12271, CAST(N'2015-08-23 17:54:18.097' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12272, CAST(N'2015-08-23 18:23:19.057' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12273, CAST(N'2015-08-23 18:23:34.763' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12274, CAST(N'2015-08-23 18:28:56.880' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12275, CAST(N'2015-08-23 18:32:22.483' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12276, CAST(N'2015-08-23 18:41:21.780' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12277, CAST(N'2015-08-23 18:42:42.320' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12278, CAST(N'2015-08-23 18:43:15.897' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12279, CAST(N'2015-08-23 19:03:53.617' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12280, CAST(N'2015-08-23 19:23:37.517' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12281, CAST(N'2015-08-23 19:25:43.657' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12282, CAST(N'2015-08-23 19:26:53.733' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12283, CAST(N'2015-08-23 19:27:54.323' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12284, CAST(N'2015-08-23 19:28:41.650' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12285, CAST(N'2015-08-23 19:29:11.210' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12286, CAST(N'2015-08-23 19:34:37.033' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12287, CAST(N'2015-08-23 19:49:20.920' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12288, CAST(N'2015-08-23 19:50:09.397' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12289, CAST(N'2015-08-23 19:55:14.980' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12290, CAST(N'2015-08-23 20:00:08.443' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12291, CAST(N'2015-08-23 20:05:08.537' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12292, CAST(N'2015-08-23 20:06:00.083' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12293, CAST(N'2015-08-23 20:06:47.353' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12294, CAST(N'2015-08-23 20:07:58.613' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12295, CAST(N'2015-08-23 20:10:57.480' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12296, CAST(N'2015-08-23 20:15:42.020' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12297, CAST(N'2015-08-23 20:20:07.283' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12298, CAST(N'2015-08-23 20:21:00.007' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12299, CAST(N'2015-08-23 20:22:03.260' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12300, CAST(N'2015-08-23 20:22:46.147' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12301, CAST(N'2015-08-23 20:25:39.947' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12302, CAST(N'2015-08-23 20:34:46.003' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12303, CAST(N'2015-08-23 20:35:55.587' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12304, CAST(N'2015-08-23 20:37:38.573' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12305, CAST(N'2015-08-23 20:39:38.013' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12306, CAST(N'2015-08-23 20:40:27.150' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12307, CAST(N'2015-08-23 20:44:22.523' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12308, CAST(N'2015-08-23 20:49:52.427' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12309, CAST(N'2015-08-23 20:55:59.423' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12310, CAST(N'2015-08-23 21:11:05.860' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12311, CAST(N'2015-08-23 21:12:48.597' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12312, CAST(N'2015-08-23 21:13:30.007' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12313, CAST(N'2015-08-23 21:13:48.373' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12314, CAST(N'2015-08-23 21:16:28.950' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12315, CAST(N'2015-08-23 21:17:31.757' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12316, CAST(N'2015-08-23 21:19:10.150' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12317, CAST(N'2015-08-23 21:20:15.380' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12318, CAST(N'2015-08-23 21:20:44.360' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12319, CAST(N'2015-08-23 21:21:53.520' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12320, CAST(N'2015-08-23 21:23:12.547' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12321, CAST(N'2015-08-23 21:24:53.380' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12322, CAST(N'2015-08-23 21:28:31.100' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12323, CAST(N'2015-08-23 21:31:36.677' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12324, CAST(N'2015-08-23 21:44:57.420' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12325, CAST(N'2015-08-23 21:51:15.283' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12326, CAST(N'2015-08-23 22:39:51.333' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12327, CAST(N'2015-08-23 22:40:50.797' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12328, CAST(N'2015-08-23 22:49:14.057' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12329, CAST(N'2015-08-23 22:50:07.763' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12330, CAST(N'2015-08-23 22:53:13.173' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12331, CAST(N'2015-08-23 22:53:43.927' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12332, CAST(N'2015-08-23 22:55:57.863' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12333, CAST(N'2015-08-23 22:58:00.463' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12334, CAST(N'2015-08-23 23:13:18.357' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12335, CAST(N'2015-08-23 23:16:27.763' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12336, CAST(N'2015-08-23 23:22:01.543' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12337, CAST(N'2015-08-23 23:26:11.027' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12338, CAST(N'2015-08-23 23:38:35.173' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12339, CAST(N'2015-08-23 23:44:33.580' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12340, CAST(N'2015-08-23 23:46:29.820' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12341, CAST(N'2015-08-23 23:48:20.567' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12342, CAST(N'2015-08-23 23:49:09.880' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12343, CAST(N'2015-08-23 23:49:41.373' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12344, CAST(N'2015-08-23 23:50:00.567' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12345, CAST(N'2015-08-24 00:02:16.840' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12346, CAST(N'2015-08-24 00:04:46.767' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12347, CAST(N'2015-08-24 00:07:26.827' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12348, CAST(N'2015-08-24 00:14:41.923' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12349, CAST(N'2015-08-24 00:15:55.560' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12350, CAST(N'2015-08-24 00:16:52.760' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12351, CAST(N'2015-08-24 00:20:01.823' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12352, CAST(N'2015-08-24 00:21:51.963' AS DateTime), N'Login', N'Login exitoso', N'admin')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (12353, CAST(N'2015-08-24 00:24:12.867' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22264, CAST(N'2015-08-24 00:36:23.020' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22265, CAST(N'2015-08-24 00:53:54.500' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22266, CAST(N'2015-08-24 01:02:57.773' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22267, CAST(N'2015-08-24 01:04:16.077' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22268, CAST(N'2015-08-24 01:06:39.813' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22269, CAST(N'2015-08-24 01:17:38.100' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22270, CAST(N'2015-08-24 01:18:24.703' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22271, CAST(N'2015-08-24 01:19:12.823' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22272, CAST(N'2015-08-24 01:23:56.800' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22273, CAST(N'2015-08-24 01:26:05.817' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22274, CAST(N'2015-08-24 01:27:07.843' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22275, CAST(N'2015-08-24 01:31:50.027' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22276, CAST(N'2015-08-24 01:32:23.747' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22277, CAST(N'2015-08-24 01:36:07.643' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22278, CAST(N'2015-08-24 01:37:34.240' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22279, CAST(N'2015-08-24 15:11:01.457' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22280, CAST(N'2015-08-24 15:12:09.130' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22281, CAST(N'2015-08-24 15:13:00.457' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22282, CAST(N'2015-08-24 15:15:35.330' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22283, CAST(N'2015-08-24 15:32:22.690' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22284, CAST(N'2015-08-24 15:39:39.677' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22285, CAST(N'2015-08-24 15:39:47.710' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22286, CAST(N'2015-08-24 15:39:54.507' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22287, CAST(N'2015-08-24 15:55:17.640' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22288, CAST(N'2015-08-24 15:57:27.840' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22289, CAST(N'2015-08-24 16:03:03.840' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22290, CAST(N'2015-08-24 16:05:36.483' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22291, CAST(N'2015-08-24 16:08:19.230' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22292, CAST(N'2015-08-24 16:41:00.710' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22293, CAST(N'2015-08-24 19:41:02.553' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22294, CAST(N'2015-08-24 19:56:44.990' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22295, CAST(N'2015-08-24 19:57:22.030' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22296, CAST(N'2015-08-24 19:57:26.013' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22297, CAST(N'2015-08-24 19:57:51.690' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22298, CAST(N'2015-08-24 19:57:54.407' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22299, CAST(N'2015-08-24 20:04:34.620' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22300, CAST(N'2015-08-24 20:05:43.800' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22301, CAST(N'2015-08-24 20:31:47.537' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22302, CAST(N'2015-08-24 20:34:43.867' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22303, CAST(N'2015-08-24 20:34:47.880' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22304, CAST(N'2015-08-24 20:38:02.097' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22305, CAST(N'2015-08-24 20:49:35.750' AS DateTime), N'Login', N'Login insatisfactorio', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22306, CAST(N'2015-08-24 20:49:38.933' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22307, CAST(N'2015-08-24 21:02:33.027' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22308, CAST(N'2015-08-24 21:03:03.437' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22309, CAST(N'2015-08-24 21:04:06.727' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22310, CAST(N'2015-08-24 21:04:22.580' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22311, CAST(N'2015-08-24 21:07:25.557' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22312, CAST(N'2015-08-24 21:22:28.293' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22313, CAST(N'2015-08-24 21:23:23.893' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22314, CAST(N'2015-08-24 21:23:32.443' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22315, CAST(N'2015-08-24 21:24:10.090' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22316, CAST(N'2015-08-24 21:24:44.913' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22317, CAST(N'2015-08-24 21:24:56.417' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22318, CAST(N'2015-08-24 21:37:28.510' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22319, CAST(N'2015-08-24 21:37:51.537' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22320, CAST(N'2015-08-24 21:38:07.303' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22321, CAST(N'2015-08-24 21:38:12.610' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22322, CAST(N'2015-08-24 21:38:14.620' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22323, CAST(N'2015-08-24 21:39:00.207' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22324, CAST(N'2015-08-24 21:39:26.323' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22325, CAST(N'2015-08-24 21:39:45.820' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22326, CAST(N'2015-08-24 21:39:48.563' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22327, CAST(N'2015-08-24 21:47:24.733' AS DateTime), N'Backup', N'Error creando el Backup', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22328, CAST(N'2015-08-24 22:00:16.690' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22329, CAST(N'2015-08-24 22:00:20.823' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22330, CAST(N'2015-08-24 22:01:29.437' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22331, CAST(N'2015-08-24 22:03:38.060' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22332, CAST(N'2015-08-24 22:04:30.210' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22333, CAST(N'2015-08-24 23:05:55.203' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22334, CAST(N'2015-08-24 23:09:24.857' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22335, CAST(N'2015-08-24 23:17:39.937' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22336, CAST(N'2015-08-24 23:57:23.303' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22337, CAST(N'2015-08-25 00:00:21.010' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22338, CAST(N'2015-08-25 00:00:55.520' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22339, CAST(N'2015-08-25 00:27:51.347' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22340, CAST(N'2015-08-25 00:31:29.987' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22341, CAST(N'2015-08-25 00:35:08.087' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22342, CAST(N'2015-08-25 00:37:58.373' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22343, CAST(N'2015-08-25 00:38:09.210' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22344, CAST(N'2015-08-25 00:38:34.833' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22345, CAST(N'2015-08-25 00:39:19.787' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22346, CAST(N'2015-08-25 00:39:47.297' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22347, CAST(N'2015-08-25 00:46:32.820' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22348, CAST(N'2015-08-25 00:48:58.437' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22349, CAST(N'2015-08-25 00:55:30.433' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22350, CAST(N'2015-08-25 01:04:05.640' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22351, CAST(N'2015-08-25 01:06:04.470' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22352, CAST(N'2015-08-25 01:08:41.073' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22353, CAST(N'2015-08-25 01:19:18.850' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22354, CAST(N'2015-08-25 01:22:02.357' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22355, CAST(N'2015-08-25 01:29:23.173' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22356, CAST(N'2015-08-25 01:40:39.307' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22357, CAST(N'2015-08-25 01:52:54.763' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22358, CAST(N'2015-08-25 01:53:45.457' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22359, CAST(N'2015-08-25 01:55:07.633' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22360, CAST(N'2015-08-25 02:08:33.667' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22361, CAST(N'2015-08-25 02:13:07.920' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22362, CAST(N'2015-08-25 02:34:05.393' AS DateTime), N'Login', N'Login exitoso', N'admin')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22363, CAST(N'2015-08-25 02:37:04.140' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22364, CAST(N'2015-08-25 02:52:13.283' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22365, CAST(N'2015-08-25 04:26:38.567' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22366, CAST(N'2015-08-25 04:33:19.243' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22367, CAST(N'2015-08-25 04:33:32.720' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22368, CAST(N'2015-08-25 04:38:14.870' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22369, CAST(N'2015-08-25 04:42:09.027' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22370, CAST(N'2015-08-25 04:44:41.653' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22371, CAST(N'2015-08-25 04:48:04.630' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22372, CAST(N'2015-08-25 04:55:37.827' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22373, CAST(N'2015-08-25 04:56:17.903' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22374, CAST(N'2015-08-25 12:49:58.093' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22375, CAST(N'2015-08-25 13:06:49.943' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22376, CAST(N'2015-08-25 13:10:15.480' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22377, CAST(N'2015-08-25 13:17:15.340' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22378, CAST(N'2015-08-25 16:37:47.427' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22379, CAST(N'2015-08-25 16:38:47.687' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22380, CAST(N'2015-08-25 16:41:55.397' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22381, CAST(N'2015-08-25 16:43:33.907' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22382, CAST(N'2015-08-25 16:44:38.527' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22383, CAST(N'2015-08-25 16:45:00.547' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22384, CAST(N'2015-08-25 16:45:59.833' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22385, CAST(N'2015-08-25 22:23:17.910' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22386, CAST(N'2015-08-25 22:24:17.743' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22387, CAST(N'2015-08-25 22:25:37.993' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22388, CAST(N'2015-08-25 23:54:12.917' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22389, CAST(N'2015-08-25 23:55:56.960' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22390, CAST(N'2015-08-25 23:59:35.887' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22391, CAST(N'2015-08-26 00:01:17.437' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22392, CAST(N'2015-08-26 00:02:21.447' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22393, CAST(N'2015-08-26 00:13:38.983' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22394, CAST(N'2015-08-26 01:14:16.037' AS DateTime), N'Restore', N'Restore realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22395, CAST(N'2015-08-26 01:17:11.930' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22396, CAST(N'2015-08-26 01:17:17.287' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22397, CAST(N'2015-08-26 01:17:22.600' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22398, CAST(N'2015-08-26 01:58:07.803' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22399, CAST(N'2015-08-26 02:08:01.333' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22400, CAST(N'2015-08-26 02:10:19.510' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22401, CAST(N'2015-08-26 02:13:11.867' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22402, CAST(N'2015-08-26 02:14:48.407' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22403, CAST(N'2015-08-26 02:19:22.723' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22404, CAST(N'2015-08-26 02:19:53.467' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22405, CAST(N'2015-08-26 02:33:26.413' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22406, CAST(N'2015-08-26 02:33:35.183' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22407, CAST(N'2015-08-26 02:35:36.717' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22408, CAST(N'2015-08-26 02:38:08.930' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22409, CAST(N'2015-08-26 02:51:39.877' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22410, CAST(N'2015-08-26 02:52:42.113' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22411, CAST(N'2015-08-26 03:23:51.460' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22412, CAST(N'2015-08-26 03:28:55.910' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22413, CAST(N'2015-08-26 03:34:56.490' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22414, CAST(N'2015-08-26 03:35:47.510' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22415, CAST(N'2015-08-26 03:37:21.513' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22416, CAST(N'2015-08-26 03:41:08.773' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22417, CAST(N'2015-08-26 13:26:52.280' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22418, CAST(N'2015-08-26 15:01:16.167' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22419, CAST(N'2015-08-26 15:07:37.337' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22420, CAST(N'2015-08-26 15:12:38.947' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22421, CAST(N'2015-08-26 15:13:49.277' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22422, CAST(N'2015-08-26 15:20:46.190' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22423, CAST(N'2015-08-26 15:21:50.713' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22424, CAST(N'2015-08-26 15:25:51.473' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22425, CAST(N'2015-08-26 16:27:18.773' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22426, CAST(N'2015-08-26 16:38:59.930' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22427, CAST(N'2015-08-26 16:40:40.520' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22428, CAST(N'2015-08-26 16:50:14.747' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22429, CAST(N'2015-08-26 16:53:43.690' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22430, CAST(N'2015-08-26 16:55:34.970' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22431, CAST(N'2015-08-26 16:57:59.070' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22432, CAST(N'2015-08-26 17:01:03.507' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22433, CAST(N'2015-08-26 17:02:57.023' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22434, CAST(N'2015-08-26 17:08:20.677' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22435, CAST(N'2015-08-26 17:11:12.730' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22436, CAST(N'2015-08-26 17:16:11.033' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22437, CAST(N'2015-08-26 17:17:50.437' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22438, CAST(N'2015-08-26 17:29:23.007' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22439, CAST(N'2015-08-26 17:31:54.543' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22440, CAST(N'2015-08-26 17:38:42.300' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22441, CAST(N'2015-08-26 17:40:48.160' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22442, CAST(N'2015-08-26 17:45:55.600' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22443, CAST(N'2015-08-26 17:48:59.260' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22444, CAST(N'2015-08-26 18:13:11.337' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22445, CAST(N'2015-08-26 18:18:53.697' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22446, CAST(N'2015-08-26 18:42:01.377' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22447, CAST(N'2015-08-26 18:46:55.587' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22448, CAST(N'2015-08-26 18:52:36.800' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22449, CAST(N'2015-08-26 18:52:53.430' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22450, CAST(N'2015-08-26 18:54:24.730' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22451, CAST(N'2015-08-26 18:55:27.017' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22452, CAST(N'2015-08-26 18:56:38.010' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22453, CAST(N'2015-08-26 18:57:48.817' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22454, CAST(N'2015-08-26 19:08:27.670' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22455, CAST(N'2015-08-26 19:15:29.797' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22456, CAST(N'2015-08-26 19:20:50.677' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22457, CAST(N'2015-08-26 19:40:31.830' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22458, CAST(N'2015-08-26 19:41:43.667' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22459, CAST(N'2015-08-26 19:47:07.147' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22460, CAST(N'2015-08-26 19:49:44.020' AS DateTime), N'Login', N'Login exitoso', N'pepito')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22461, CAST(N'2015-08-26 19:50:03.110' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22462, CAST(N'2015-08-26 19:51:50.307' AS DateTime), N'Login', N'Login exitoso', N'admin')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22463, CAST(N'2015-08-26 19:56:32.687' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22464, CAST(N'2015-08-26 19:59:45.367' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22465, CAST(N'2015-08-26 20:04:55.777' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22466, CAST(N'2015-08-26 20:43:37.593' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22467, CAST(N'2015-08-26 20:44:18.943' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22468, CAST(N'2015-08-26 20:44:31.883' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22469, CAST(N'2015-08-26 20:44:39.647' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22470, CAST(N'2015-08-26 20:44:48.647' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (22471, CAST(N'2015-08-26 20:46:08.040' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32471, CAST(N'2015-08-27 00:34:38.223' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32472, CAST(N'2015-08-27 00:46:50.647' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32473, CAST(N'2015-08-27 01:03:08.697' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32474, CAST(N'2015-08-27 01:23:53.907' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32475, CAST(N'2015-08-27 01:40:35.920' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32476, CAST(N'2015-08-27 01:43:29.560' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32477, CAST(N'2015-08-27 02:19:27.027' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32478, CAST(N'2015-08-27 02:58:17.527' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32479, CAST(N'2015-08-27 03:14:34.230' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32480, CAST(N'2015-08-27 03:15:39.433' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32481, CAST(N'2015-08-27 03:16:55.730' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32482, CAST(N'2015-08-27 03:19:39.997' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32483, CAST(N'2015-08-27 03:20:25.537' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32484, CAST(N'2015-08-27 03:21:29.200' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32485, CAST(N'2015-08-27 03:22:31.890' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32486, CAST(N'2015-08-27 03:25:31.540' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32487, CAST(N'2015-08-27 03:28:23.490' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32488, CAST(N'2015-08-27 03:35:18.380' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32489, CAST(N'2015-08-27 03:36:01.423' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32490, CAST(N'2015-08-27 03:36:39.680' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32491, CAST(N'2015-08-27 03:37:20.563' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32492, CAST(N'2015-08-27 03:38:46.940' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32493, CAST(N'2015-08-27 03:39:33.640' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32494, CAST(N'2015-08-27 03:44:04.840' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32495, CAST(N'2015-08-27 03:47:09.267' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32496, CAST(N'2015-08-27 03:48:33.610' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32497, CAST(N'2015-08-29 18:27:28.750' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32498, CAST(N'2015-08-29 18:29:46.740' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32499, CAST(N'2015-08-29 18:31:37.917' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32500, CAST(N'2015-08-29 18:34:09.400' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32501, CAST(N'2015-08-29 18:40:18.477' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32502, CAST(N'2015-08-29 18:41:19.270' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32503, CAST(N'2015-08-29 18:42:29.460' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32504, CAST(N'2015-08-29 18:49:32.283' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32505, CAST(N'2015-08-29 18:52:30.507' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32506, CAST(N'2015-08-29 18:56:12.370' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32507, CAST(N'2015-08-29 18:59:30.357' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32508, CAST(N'2015-08-29 19:39:49.513' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32509, CAST(N'2015-08-30 18:31:26.463' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32510, CAST(N'2015-08-30 18:42:53.440' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32511, CAST(N'2015-08-30 18:47:03.077' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32512, CAST(N'2015-08-30 18:48:57.617' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32513, CAST(N'2015-08-30 18:53:21.143' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32514, CAST(N'2015-08-30 18:55:40.273' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32515, CAST(N'2015-08-30 18:58:23.693' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32516, CAST(N'2015-08-30 19:09:13.727' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32517, CAST(N'2015-08-30 19:09:43.623' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32518, CAST(N'2015-08-30 19:25:51.543' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (32519, CAST(N'2015-08-30 19:26:46.653' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42471, CAST(N'2015-09-01 12:49:43.977' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42472, CAST(N'2015-09-01 12:58:24.357' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42473, CAST(N'2015-09-01 13:00:59.580' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42474, CAST(N'2015-09-01 13:01:35.700' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42475, CAST(N'2015-09-01 13:05:14.067' AS DateTime), N'Restore', N'Restore realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42476, CAST(N'2015-09-01 13:05:40.570' AS DateTime), N'Restore', N'Error realizando el Restore', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42477, CAST(N'2015-09-01 13:05:49.913' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42478, CAST(N'2015-09-01 13:11:01.923' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42479, CAST(N'2015-09-01 13:13:05.523' AS DateTime), N'Restore', N'Error realizando el Restore', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42480, CAST(N'2015-09-01 13:13:52.357' AS DateTime), N'Restore', N'Error realizando el Restore', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42481, CAST(N'2015-09-01 13:15:42.697' AS DateTime), N'Restore', N'Error realizando el Restore', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42482, CAST(N'2015-09-01 13:17:57.943' AS DateTime), N'Restore', N'Error realizando el Restore', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42483, CAST(N'2015-09-01 13:18:55.687' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42484, CAST(N'2015-09-02 00:14:09.933' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42485, CAST(N'2015-09-02 00:47:57.607' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42486, CAST(N'2015-09-02 01:04:51.763' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42487, CAST(N'2015-09-06 22:22:59.680' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42488, CAST(N'2015-09-06 22:27:38.887' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42489, CAST(N'2015-09-06 22:28:32.810' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42490, CAST(N'2015-09-06 22:30:26.367' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42491, CAST(N'2015-09-06 22:35:06.263' AS DateTime), N'Restore', N'Error realizando el Restore', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42492, CAST(N'2015-09-07 00:24:42.580' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42493, CAST(N'2015-09-07 00:25:13.010' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42494, CAST(N'2015-09-07 00:47:41.143' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42495, CAST(N'2015-09-07 00:52:46.743' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42496, CAST(N'2015-09-07 00:57:05.030' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42497, CAST(N'2015-09-07 01:07:31.083' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42498, CAST(N'2015-09-07 01:08:02.580' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42499, CAST(N'2015-09-07 01:08:04.760' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42500, CAST(N'2015-09-07 01:09:17.660' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42501, CAST(N'2015-09-07 01:09:18.583' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42502, CAST(N'2015-09-07 01:14:39.923' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42503, CAST(N'2015-09-07 01:17:25.353' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42504, CAST(N'2015-09-07 01:19:31.920' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42505, CAST(N'2015-09-07 01:20:50.560' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42506, CAST(N'2015-09-07 01:21:29.220' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42507, CAST(N'2015-09-07 01:22:47.420' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42508, CAST(N'2015-09-07 01:22:48.230' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42509, CAST(N'2015-09-07 01:29:19.850' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42510, CAST(N'2015-09-07 01:33:44.017' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42511, CAST(N'2015-09-07 02:13:13.910' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42512, CAST(N'2015-09-07 02:13:51.030' AS DateTime), N'Login', N'Login exitoso', N'admin')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42513, CAST(N'2015-09-07 02:14:08.420' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42514, CAST(N'2015-09-07 02:16:18.370' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42515, CAST(N'2015-09-07 02:16:59.597' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42516, CAST(N'2015-09-07 02:17:04.897' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42517, CAST(N'2015-09-07 02:19:24.097' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42518, CAST(N'2015-09-07 02:19:25.000' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42519, CAST(N'2015-09-07 02:20:34.720' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42520, CAST(N'2015-09-07 02:20:38.110' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42521, CAST(N'2015-09-07 02:32:20.760' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42522, CAST(N'2015-09-07 02:32:24.887' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42523, CAST(N'2015-09-07 02:32:29.517' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42524, CAST(N'2015-09-07 02:32:32.463' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42525, CAST(N'2015-09-07 02:34:31.003' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42526, CAST(N'2015-09-07 02:39:11.910' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42527, CAST(N'2015-09-07 02:39:17.707' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42528, CAST(N'2015-09-07 02:39:20.790' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42529, CAST(N'2015-09-07 02:46:32.230' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42530, CAST(N'2015-09-07 02:46:35.310' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42531, CAST(N'2015-09-07 02:46:37.440' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42532, CAST(N'2015-09-07 02:50:44.030' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42533, CAST(N'2015-09-07 02:50:47.547' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (42534, CAST(N'2015-09-07 02:50:49.537' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52525, CAST(N'2015-09-07 19:03:03.383' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52526, CAST(N'2015-09-07 19:45:12.970' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52527, CAST(N'2015-09-07 19:46:35.930' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52528, CAST(N'2015-09-07 19:50:56.613' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52529, CAST(N'2015-09-07 20:00:09.617' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52530, CAST(N'2015-09-07 20:18:05.600' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52531, CAST(N'2015-09-07 20:19:49.390' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52532, CAST(N'2015-09-07 20:20:55.130' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52533, CAST(N'2015-09-07 20:25:19.267' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52534, CAST(N'2015-09-07 20:27:32.540' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52535, CAST(N'2015-09-07 20:27:37.837' AS DateTime), N'Login', N'Login exitoso', N'facu')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52536, CAST(N'2015-09-07 20:27:49.800' AS DateTime), N'Logout', N'Logout exitoso', N'Gonzales')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52537, CAST(N'2015-09-07 20:27:52.083' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52538, CAST(N'2015-09-07 21:36:20.183' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52539, CAST(N'2015-09-07 21:37:49.417' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52540, CAST(N'2015-09-07 21:40:49.660' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52541, CAST(N'2015-09-07 21:43:16.903' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52542, CAST(N'2015-09-07 21:44:19.637' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52543, CAST(N'2015-09-07 22:06:50.670' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52544, CAST(N'2015-09-07 23:13:58.180' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52545, CAST(N'2015-09-07 23:22:17.517' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52546, CAST(N'2015-09-07 23:29:30.350' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52547, CAST(N'2015-09-07 23:33:21.033' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52548, CAST(N'2015-09-07 23:36:40.000' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52549, CAST(N'2015-09-07 23:38:58.150' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52550, CAST(N'2015-09-07 23:52:56.153' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52551, CAST(N'2015-09-08 00:17:39.577' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52552, CAST(N'2015-09-08 00:38:17.403' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52553, CAST(N'2015-09-08 00:38:58.843' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52554, CAST(N'2015-09-08 00:39:59.093' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52555, CAST(N'2015-09-08 00:49:18.177' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52556, CAST(N'2015-09-08 00:57:50.267' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52557, CAST(N'2015-09-08 01:04:45.693' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52558, CAST(N'2015-09-08 01:06:00.823' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52559, CAST(N'2015-09-08 01:09:23.093' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52560, CAST(N'2015-09-08 01:25:50.940' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52561, CAST(N'2015-09-08 01:37:04.340' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52562, CAST(N'2015-09-08 01:40:16.430' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52563, CAST(N'2015-09-08 01:43:19.620' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52564, CAST(N'2015-09-08 01:48:18.543' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52565, CAST(N'2015-09-08 01:49:58.013' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52566, CAST(N'2015-09-08 01:54:05.093' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52567, CAST(N'2015-09-08 01:59:03.950' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52568, CAST(N'2015-09-08 02:00:47.233' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52569, CAST(N'2015-09-08 02:09:12.083' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52570, CAST(N'2015-09-08 02:09:37.973' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52571, CAST(N'2015-09-08 02:24:40.407' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52572, CAST(N'2015-09-08 02:28:13.403' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52573, CAST(N'2015-09-08 02:34:31.667' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52574, CAST(N'2015-09-08 02:37:19.400' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52575, CAST(N'2015-09-08 02:39:04.110' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52576, CAST(N'2015-09-08 02:45:24.597' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52577, CAST(N'2015-09-08 02:46:52.757' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52578, CAST(N'2015-09-08 02:47:35.200' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (52579, CAST(N'2015-09-08 02:47:36.043' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62525, CAST(N'2015-09-08 03:04:05.333' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62526, CAST(N'2015-09-08 03:51:53.720' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62527, CAST(N'2015-09-08 03:54:35.600' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62528, CAST(N'2015-09-08 03:57:44.143' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62529, CAST(N'2015-09-08 04:00:00.330' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62530, CAST(N'2015-09-08 04:00:27.247' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62531, CAST(N'2015-09-08 04:05:39.127' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62532, CAST(N'2015-09-08 04:08:04.103' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62533, CAST(N'2015-09-08 04:12:19.067' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62534, CAST(N'2015-09-08 04:13:21.283' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62535, CAST(N'2015-09-08 18:20:57.537' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (62536, CAST(N'2015-09-08 18:21:05.147' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (72536, CAST(N'2015-09-16 18:39:32.040' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82536, CAST(N'2015-09-16 19:43:47.517' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82537, CAST(N'2015-09-16 20:16:01.437' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82538, CAST(N'2015-09-16 20:29:43.630' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82539, CAST(N'2015-09-16 20:31:28.540' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82540, CAST(N'2015-09-16 20:44:45.720' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82541, CAST(N'2015-09-16 20:50:24.640' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82542, CAST(N'2015-09-16 20:51:19.057' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82543, CAST(N'2015-09-16 20:51:39.883' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82544, CAST(N'2015-09-16 20:51:46.587' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82545, CAST(N'2015-09-16 20:51:57.737' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82546, CAST(N'2015-09-16 20:51:59.017' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82547, CAST(N'2015-09-16 20:53:50.467' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82548, CAST(N'2015-09-16 20:53:51.450' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82549, CAST(N'2015-09-16 21:11:46.427' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82550, CAST(N'2015-09-16 21:13:22.830' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82551, CAST(N'2015-09-16 21:13:28.310' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82552, CAST(N'2015-09-16 21:21:05.693' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82553, CAST(N'2015-09-16 21:28:43.010' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82554, CAST(N'2015-09-16 21:45:05.310' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82555, CAST(N'2015-09-17 01:13:36.190' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82556, CAST(N'2015-09-17 01:13:39.057' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82557, CAST(N'2015-09-17 01:27:03.623' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82558, CAST(N'2015-09-17 01:27:19.903' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82559, CAST(N'2015-09-17 01:29:15.343' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82560, CAST(N'2015-09-17 01:30:51.757' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82561, CAST(N'2015-09-17 01:49:11.790' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82562, CAST(N'2015-09-17 01:52:12.310' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82563, CAST(N'2015-09-17 02:42:35.430' AS DateTime), N'Login', N'Login exitoso', N'poto')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82564, CAST(N'2015-09-17 02:42:54.150' AS DateTime), N'Logout', N'Logout exitoso', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (82565, CAST(N'2015-09-17 03:07:50.867' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92536, CAST(N'2015-09-18 02:54:21.980' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92537, CAST(N'2015-09-18 02:55:49.077' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92538, CAST(N'2015-09-18 03:05:19.667' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92539, CAST(N'2015-09-18 03:05:20.860' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92540, CAST(N'2015-09-18 03:49:07.183' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92541, CAST(N'2015-09-18 03:49:31.133' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92542, CAST(N'2015-09-18 03:49:31.940' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92543, CAST(N'2015-09-18 03:51:23.407' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92544, CAST(N'2015-09-18 03:55:36.387' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92545, CAST(N'2015-09-18 03:55:39.050' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92546, CAST(N'2015-09-18 03:56:35.780' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (92547, CAST(N'2015-09-18 03:57:00.797' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102547, CAST(N'2015-09-19 03:44:00.560' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102548, CAST(N'2015-09-19 03:44:05.410' AS DateTime), N'Logout', N'Logout exitoso', N'Apellido')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102549, CAST(N'2015-09-19 04:14:18.300' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102550, CAST(N'2015-09-19 14:11:26.997' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102551, CAST(N'2015-09-19 17:31:24.563' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102552, CAST(N'2015-09-19 17:50:56.247' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102553, CAST(N'2015-09-19 17:52:57.823' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102554, CAST(N'2015-09-19 18:17:02.190' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102555, CAST(N'2015-09-19 18:18:42.750' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102556, CAST(N'2015-09-19 18:23:28.913' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102557, CAST(N'2015-09-19 18:48:41.640' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102558, CAST(N'2015-09-19 18:49:39.970' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102559, CAST(N'2015-09-19 18:50:50.530' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102560, CAST(N'2015-09-19 18:55:21.970' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102561, CAST(N'2015-09-19 19:10:07.563' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102562, CAST(N'2015-09-19 19:16:50.590' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102563, CAST(N'2015-09-19 19:20:31.850' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102564, CAST(N'2015-09-19 19:52:37.753' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102565, CAST(N'2015-09-19 19:53:29.233' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102566, CAST(N'2015-09-19 20:02:07.243' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102567, CAST(N'2015-09-19 20:11:25.363' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102568, CAST(N'2015-09-19 20:19:20.023' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102569, CAST(N'2015-09-19 20:20:26.203' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102570, CAST(N'2015-09-19 20:20:31.743' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102571, CAST(N'2015-09-19 20:20:45.793' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102572, CAST(N'2015-09-19 20:20:46.943' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102573, CAST(N'2015-09-19 21:25:45.417' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102574, CAST(N'2015-09-19 21:26:17.213' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102575, CAST(N'2015-09-19 21:34:15.860' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102576, CAST(N'2015-09-19 21:34:16.900' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102577, CAST(N'2015-09-19 21:57:23.567' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102578, CAST(N'2015-09-19 21:58:49.470' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102579, CAST(N'2015-09-19 22:07:33.073' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102580, CAST(N'2015-09-19 22:09:38.940' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102581, CAST(N'2015-09-19 22:12:20.340' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102582, CAST(N'2015-09-19 22:14:39.647' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102583, CAST(N'2015-09-19 22:19:52.450' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102584, CAST(N'2015-09-19 23:47:43.090' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102585, CAST(N'2015-09-20 00:08:50.467' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102586, CAST(N'2015-09-20 00:16:13.010' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102587, CAST(N'2015-09-20 00:26:56.470' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102588, CAST(N'2015-09-20 00:36:49.000' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102589, CAST(N'2015-09-20 00:37:55.640' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102590, CAST(N'2015-09-20 00:47:16.200' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102591, CAST(N'2015-09-20 00:53:03.923' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102592, CAST(N'2015-09-20 00:53:10.880' AS DateTime), N'Login', N'Login insatisfactorio', N'ALUMNO')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102593, CAST(N'2015-09-20 00:53:14.097' AS DateTime), N'Login', N'Login exitoso', N'ALUMNO')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102594, CAST(N'2015-09-20 00:53:32.620' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102595, CAST(N'2015-09-20 00:53:35.233' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102596, CAST(N'2015-09-20 01:12:16.837' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102597, CAST(N'2015-09-20 01:12:48.457' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102598, CAST(N'2015-09-20 01:13:55.163' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102599, CAST(N'2015-09-20 01:19:56.097' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102600, CAST(N'2015-09-20 01:21:38.413' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102601, CAST(N'2015-09-20 01:23:20.570' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102602, CAST(N'2015-09-20 01:24:44.070' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102603, CAST(N'2015-09-20 01:27:55.240' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102604, CAST(N'2015-09-20 01:28:32.247' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102605, CAST(N'2015-09-20 01:37:56.537' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102606, CAST(N'2015-09-20 01:38:06.723' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102607, CAST(N'2015-09-20 01:38:09.740' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102608, CAST(N'2015-09-20 01:38:11.607' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102609, CAST(N'2015-09-20 01:40:49.953' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102610, CAST(N'2015-09-20 01:46:59.607' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102611, CAST(N'2015-09-20 01:47:43.430' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102612, CAST(N'2015-09-20 01:47:45.973' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102613, CAST(N'2015-09-20 01:49:40.930' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102614, CAST(N'2015-09-20 01:53:25.837' AS DateTime), N'Login', N'Login exitoso', N'profesor')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102615, CAST(N'2015-09-20 01:57:01.983' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102616, CAST(N'2015-09-20 01:57:06.393' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102617, CAST(N'2015-09-20 01:59:23.930' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102618, CAST(N'2015-09-20 02:02:02.230' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102619, CAST(N'2015-09-20 02:02:30.243' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102620, CAST(N'2015-09-20 02:05:24.440' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102621, CAST(N'2015-09-20 02:07:58.700' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102622, CAST(N'2015-09-20 02:08:00.940' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102623, CAST(N'2015-09-20 02:11:49.173' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102624, CAST(N'2015-09-20 02:11:51.877' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102625, CAST(N'2015-09-20 02:11:55.193' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102626, CAST(N'2015-09-20 02:11:58.403' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102627, CAST(N'2015-09-20 02:18:19.530' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102628, CAST(N'2015-09-20 02:18:39.027' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102629, CAST(N'2015-09-20 02:18:41.477' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102630, CAST(N'2015-09-20 02:21:24.643' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102631, CAST(N'2015-09-20 02:21:45.047' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102632, CAST(N'2015-09-20 02:21:47.750' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102633, CAST(N'2015-09-20 02:22:40.997' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102634, CAST(N'2015-09-20 02:23:14.677' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102635, CAST(N'2015-09-20 02:23:16.907' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102636, CAST(N'2015-09-20 02:24:18.450' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102637, CAST(N'2015-09-20 02:24:25.710' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102638, CAST(N'2015-09-20 02:24:27.760' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102639, CAST(N'2015-09-20 02:25:39.997' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102640, CAST(N'2015-09-20 02:25:52.440' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102641, CAST(N'2015-09-20 02:25:54.927' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102642, CAST(N'2015-09-20 02:26:23.533' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102643, CAST(N'2015-09-20 02:26:27.190' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102644, CAST(N'2015-09-20 02:26:28.837' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102645, CAST(N'2015-09-20 02:27:06.740' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102646, CAST(N'2015-09-20 02:27:09.243' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102647, CAST(N'2015-09-20 02:27:11.590' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102648, CAST(N'2015-09-20 02:29:08.230' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102649, CAST(N'2015-09-20 02:29:10.427' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102650, CAST(N'2015-09-20 02:29:16.483' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102651, CAST(N'2015-09-20 02:30:02.557' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102652, CAST(N'2015-09-20 02:30:05.017' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102653, CAST(N'2015-09-20 02:30:14.510' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102654, CAST(N'2015-09-20 02:30:15.653' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102655, CAST(N'2015-09-20 02:30:23.587' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102656, CAST(N'2015-09-20 02:30:24.767' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102657, CAST(N'2015-09-20 02:30:27.513' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102658, CAST(N'2015-09-20 15:14:20.107' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102659, CAST(N'2015-09-20 16:54:58.563' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102660, CAST(N'2015-09-20 17:08:14.747' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102661, CAST(N'2015-09-20 17:09:26.227' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102662, CAST(N'2015-09-20 17:09:35.423' AS DateTime), N'Login', N'Login insatisfactorio', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102663, CAST(N'2015-09-20 17:09:39.870' AS DateTime), N'Login', N'Login exitoso', N'profesor')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102664, CAST(N'2015-09-20 17:09:50.433' AS DateTime), N'Logout', N'Logout exitoso', N'Lopez')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102665, CAST(N'2015-09-20 17:09:52.163' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102666, CAST(N'2015-09-20 17:11:20.160' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102667, CAST(N'2015-09-20 17:54:30.700' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102668, CAST(N'2015-09-20 19:18:26.403' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102669, CAST(N'2015-09-20 19:29:10.400' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102670, CAST(N'2015-09-20 19:29:16.297' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102671, CAST(N'2015-09-20 19:37:25.740' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102672, CAST(N'2015-09-20 19:37:27.723' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102673, CAST(N'2015-09-20 19:37:34.437' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102674, CAST(N'2015-09-20 19:49:09.203' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102675, CAST(N'2015-09-20 19:49:10.350' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102676, CAST(N'2015-09-20 19:52:26.913' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102677, CAST(N'2015-09-20 19:57:28.067' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102678, CAST(N'2015-09-20 20:00:21.857' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102679, CAST(N'2015-09-20 20:31:24.533' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102680, CAST(N'2015-09-20 20:33:55.703' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102681, CAST(N'2015-09-20 20:34:30.133' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102682, CAST(N'2015-09-20 20:35:11.747' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102683, CAST(N'2015-09-20 20:36:13.263' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102684, CAST(N'2015-09-20 20:56:35.080' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102685, CAST(N'2015-09-20 20:57:45.160' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102686, CAST(N'2015-09-20 21:07:54.590' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102687, CAST(N'2015-09-20 21:14:42.650' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102688, CAST(N'2015-09-20 21:15:59.077' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102689, CAST(N'2015-09-20 22:13:30.020' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102690, CAST(N'2015-09-20 22:19:46.360' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102691, CAST(N'2015-09-20 22:21:38.440' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102692, CAST(N'2015-09-20 22:38:13.127' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102693, CAST(N'2015-09-20 22:44:18.580' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102694, CAST(N'2015-09-20 22:45:00.313' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102695, CAST(N'2015-09-20 22:46:12.367' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102696, CAST(N'2015-09-20 22:57:48.550' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102697, CAST(N'2015-09-20 22:59:57.143' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102698, CAST(N'2015-09-20 23:34:09.370' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102699, CAST(N'2015-09-20 23:44:53.333' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102700, CAST(N'2015-09-20 23:45:49.330' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102701, CAST(N'2015-09-20 23:47:04.327' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102702, CAST(N'2015-09-20 23:49:03.050' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102703, CAST(N'2015-09-20 23:49:55.107' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102704, CAST(N'2015-09-20 23:55:06.807' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102705, CAST(N'2015-09-21 00:02:18.243' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102706, CAST(N'2015-09-21 00:06:22.850' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102707, CAST(N'2015-09-21 00:09:13.330' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102708, CAST(N'2015-09-21 00:13:55.427' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102709, CAST(N'2015-09-21 00:25:07.367' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102710, CAST(N'2015-09-21 00:26:21.430' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102711, CAST(N'2015-09-21 00:28:11.050' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102712, CAST(N'2015-09-21 00:29:40.053' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102713, CAST(N'2015-09-21 00:30:48.187' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102714, CAST(N'2015-09-21 00:33:22.370' AS DateTime), N'Login', N'Login exitoso', N'alumno')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102715, CAST(N'2015-09-21 00:41:18.713' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102716, CAST(N'2015-09-21 00:43:46.150' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102717, CAST(N'2015-09-21 00:46:49.827' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102718, CAST(N'2015-09-21 00:46:51.633' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102719, CAST(N'2015-09-21 00:47:33.270' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102720, CAST(N'2015-09-21 00:47:34.303' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102721, CAST(N'2015-09-21 00:49:15.103' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102722, CAST(N'2015-09-21 01:33:09.863' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102723, CAST(N'2015-09-21 01:55:42.160' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102724, CAST(N'2015-09-21 01:57:55.763' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102725, CAST(N'2015-09-21 01:57:58.417' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102726, CAST(N'2015-09-21 01:58:48.983' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102727, CAST(N'2015-09-21 01:58:54.130' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102728, CAST(N'2015-09-21 02:01:54.767' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102729, CAST(N'2015-09-21 02:07:45.840' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102730, CAST(N'2015-09-21 19:51:12.597' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102731, CAST(N'2015-09-21 19:51:15.273' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102732, CAST(N'2015-09-21 19:53:12.150' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102733, CAST(N'2015-09-21 19:53:14.113' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102734, CAST(N'2015-09-21 19:53:15.950' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102735, CAST(N'2015-09-21 19:53:19.013' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102736, CAST(N'2015-09-21 19:53:43.790' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102737, CAST(N'2015-09-21 19:56:47.293' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102738, CAST(N'2015-09-21 20:13:58.470' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102739, CAST(N'2015-09-21 20:20:55.583' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102740, CAST(N'2015-09-21 20:23:43.367' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102741, CAST(N'2015-09-21 20:27:50.263' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102742, CAST(N'2015-09-21 20:31:05.450' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102743, CAST(N'2015-09-21 20:31:19.550' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102744, CAST(N'2015-09-21 20:31:45.740' AS DateTime), N'Logout', N'Logout exitoso', N'Lugo')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102745, CAST(N'2015-09-21 20:31:47.573' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102746, CAST(N'2015-09-21 20:41:26.050' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102747, CAST(N'2015-09-21 21:24:35.190' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102748, CAST(N'2015-09-21 21:28:18.373' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102749, CAST(N'2015-09-21 21:28:19.490' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102750, CAST(N'2015-09-21 21:34:49.790' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102751, CAST(N'2015-09-21 21:48:03.730' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102752, CAST(N'2015-09-21 21:51:42.937' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102753, CAST(N'2015-09-21 21:52:11.737' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102754, CAST(N'2015-09-21 21:52:15.190' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102755, CAST(N'2015-09-21 21:58:53.430' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102756, CAST(N'2015-09-21 21:59:47.610' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102757, CAST(N'2015-09-21 22:03:25.680' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102758, CAST(N'2015-09-21 22:05:50.947' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102759, CAST(N'2015-09-21 22:07:42.910' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102760, CAST(N'2015-09-21 22:08:47.200' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102761, CAST(N'2015-09-21 22:11:06.053' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102762, CAST(N'2015-09-21 22:11:09.250' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102763, CAST(N'2015-09-21 22:12:19.030' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102764, CAST(N'2015-09-21 22:12:19.940' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102765, CAST(N'2015-09-21 23:09:46.080' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102766, CAST(N'2015-09-21 23:10:53.713' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102767, CAST(N'2015-09-21 23:11:41.600' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102768, CAST(N'2015-09-21 23:20:04.380' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102769, CAST(N'2015-09-21 23:51:42.900' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102770, CAST(N'2015-09-21 23:52:41.083' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102771, CAST(N'2015-09-22 00:04:10.520' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102772, CAST(N'2015-09-22 00:21:19.650' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102773, CAST(N'2015-09-22 00:57:09.827' AS DateTime), N'Sesion', N'sesion expirada', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102774, CAST(N'2015-09-22 00:57:13.930' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102775, CAST(N'2015-09-22 00:57:13.980' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102776, CAST(N'2015-09-22 00:57:16.827' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102777, CAST(N'2015-09-22 00:57:16.863' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102778, CAST(N'2015-09-22 00:57:20.373' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102779, CAST(N'2015-09-22 00:57:22.243' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102780, CAST(N'2015-09-22 00:57:22.900' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102781, CAST(N'2015-09-22 00:57:24.437' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102782, CAST(N'2015-09-22 00:57:25.150' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102783, CAST(N'2015-09-22 00:57:25.190' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102784, CAST(N'2015-09-22 00:58:42.050' AS DateTime), N'Sesion', N'sesion expirada', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102785, CAST(N'2015-09-22 00:58:43.403' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102786, CAST(N'2015-09-22 00:58:43.460' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102787, CAST(N'2015-09-22 01:01:47.450' AS DateTime), N'Sesion', N'sesion expirada', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102788, CAST(N'2015-09-22 01:01:57.623' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102789, CAST(N'2015-09-22 01:01:57.677' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102790, CAST(N'2015-09-22 01:10:25.010' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102791, CAST(N'2015-09-22 01:10:25.020' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102792, CAST(N'2015-09-22 01:10:27.327' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102793, CAST(N'2015-09-22 01:10:27.330' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102794, CAST(N'2015-09-22 01:12:19.827' AS DateTime), N'Sesion', N'sesion expirada', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102795, CAST(N'2015-09-22 01:12:19.843' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102796, CAST(N'2015-09-22 01:12:20.960' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102797, CAST(N'2015-09-22 01:12:20.967' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102798, CAST(N'2015-09-22 01:12:31.103' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102799, CAST(N'2015-09-22 01:12:31.107' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102800, CAST(N'2015-09-22 01:12:33.387' AS DateTime), N'Sesion', N'sesion expirada', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102801, CAST(N'2015-09-22 01:12:33.387' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102802, CAST(N'2015-09-22 01:13:47.150' AS DateTime), N'Sesion', N'sesion expirada', N'no identificado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102803, CAST(N'2015-09-22 01:13:48.390' AS DateTime), N'Sesion', N'sesion expirada', N'no identificado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102804, CAST(N'2015-09-22 01:13:48.440' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102805, CAST(N'2015-09-22 01:13:51.803' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102806, CAST(N'2015-09-22 01:13:51.837' AS DateTime), N'Sesion', N'sesion expirada', N'no identificado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102807, CAST(N'2015-09-22 01:13:53.240' AS DateTime), N'Sesion', N'sesion expirada', N'no identificado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102808, CAST(N'2015-09-22 01:13:53.280' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102809, CAST(N'2015-09-22 01:38:03.740' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102810, CAST(N'2015-09-22 01:38:03.747' AS DateTime), N'Sesion', N'sesion expirada', N'no identificado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102811, CAST(N'2015-09-22 01:38:06.040' AS DateTime), N'Sesion', N'sesion expirada', N'no identificado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102812, CAST(N'2015-09-22 01:38:08.900' AS DateTime), N'Sesion', N'sesion expirada', N'no identificado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102813, CAST(N'2015-09-22 01:38:11.790' AS DateTime), N'Sesion', N'sesion expirada', N'no identificado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102814, CAST(N'2015-09-22 01:38:14.713' AS DateTime), N'Sesion', N'sesion expirada', N'no identificado')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102815, CAST(N'2015-09-22 01:40:16.407' AS DateTime), N'Sesion', N'sesion expirada', N'no identificado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102816, CAST(N'2015-09-22 01:40:22.830' AS DateTime), N'Sesion', N'sesion expirada', N'no identificado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102817, CAST(N'2015-09-22 01:46:28.980' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102818, CAST(N'2015-09-22 01:46:50.670' AS DateTime), N'Logout', N'Logout exitoso', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102819, CAST(N'2015-09-22 01:46:53.200' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102820, CAST(N'2015-09-22 01:48:16.153' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102821, CAST(N'2015-09-22 01:48:20.317' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102822, CAST(N'2015-09-22 01:48:21.257' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102823, CAST(N'2015-09-22 01:48:23.903' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102824, CAST(N'2015-09-22 01:49:56.260' AS DateTime), N'Login', N'Login exitoso', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102825, CAST(N'2015-09-22 01:49:59.747' AS DateTime), N'Logout', N'Logout exitoso', N'Garcia')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102826, CAST(N'2015-09-22 02:10:43.727' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102827, CAST(N'2015-09-22 02:13:55.733' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102828, CAST(N'2015-09-22 02:45:14.410' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102829, CAST(N'2015-09-22 02:48:26.357' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102830, CAST(N'2015-09-22 02:51:50.870' AS DateTime), N'Login', N'Login insatisfactorio', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102831, CAST(N'2015-09-22 02:51:53.813' AS DateTime), N'Login', N'Login exitoso', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102832, CAST(N'2015-09-22 02:51:58.597' AS DateTime), N'Logout', N'Logout exitoso', N'Garcia')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102833, CAST(N'2015-09-22 02:52:02.750' AS DateTime), N'Login', N'Login insatisfactorio', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102834, CAST(N'2015-09-22 02:52:04.520' AS DateTime), N'Login', N'Login insatisfactorio', N'director')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102835, CAST(N'2015-09-22 02:53:23.540' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102836, CAST(N'2015-09-22 02:57:32.650' AS DateTime), N'Login', N'Login exitoso', N'gomera')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102837, CAST(N'2015-09-22 02:57:36.860' AS DateTime), N'Logout', N'Logout exitoso', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102838, CAST(N'2015-09-22 03:03:49.457' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102839, CAST(N'2015-09-22 03:03:56.697' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102840, CAST(N'2015-09-22 03:03:59.080' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102841, CAST(N'2015-09-22 03:06:28.303' AS DateTime), N'Login', N'Login exitoso', N'gomera')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102842, CAST(N'2015-09-22 03:06:32.147' AS DateTime), N'Logout', N'Logout exitoso', N'mera')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102843, CAST(N'2015-09-22 03:33:39.190' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102844, CAST(N'2015-09-22 03:34:20.037' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102845, CAST(N'2015-09-22 03:37:20.407' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102846, CAST(N'2015-09-22 03:37:36.403' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102847, CAST(N'2015-09-22 03:37:37.150' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102848, CAST(N'2015-09-22 03:38:29.757' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102849, CAST(N'2015-09-22 03:39:16.290' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102850, CAST(N'2015-09-22 03:39:19.043' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102851, CAST(N'2015-09-22 03:39:22.983' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102852, CAST(N'2015-09-22 03:41:25.073' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102853, CAST(N'2015-09-22 03:41:40.323' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102854, CAST(N'2015-09-22 03:44:45.780' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102855, CAST(N'2015-09-22 03:50:40.463' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102856, CAST(N'2015-09-22 03:50:43.280' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102857, CAST(N'2015-09-22 03:54:03.380' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102858, CAST(N'2015-09-22 03:54:18.750' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102859, CAST(N'2015-09-22 03:54:19.563' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102860, CAST(N'2015-09-22 03:54:29.350' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102861, CAST(N'2015-09-22 04:03:54.093' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102862, CAST(N'2015-09-22 04:04:43.310' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102863, CAST(N'2015-09-22 04:15:51.787' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102864, CAST(N'2015-09-22 04:15:53.877' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102865, CAST(N'2015-09-22 04:17:04.897' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102866, CAST(N'2015-09-22 04:47:23.490' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102867, CAST(N'2015-09-22 04:47:26.233' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102868, CAST(N'2015-09-22 04:47:33.670' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102869, CAST(N'2015-09-22 04:47:35.050' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102870, CAST(N'2015-09-22 04:59:31.137' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102871, CAST(N'2015-09-22 05:02:30.740' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102872, CAST(N'2015-09-22 05:02:49.883' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102873, CAST(N'2015-09-22 05:05:27.073' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102874, CAST(N'2015-09-22 05:05:28.420' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102875, CAST(N'2015-09-22 05:10:08.890' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102876, CAST(N'2015-09-22 05:10:54.790' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102877, CAST(N'2015-09-22 13:15:21.397' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102878, CAST(N'2015-09-22 13:15:29.150' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102879, CAST(N'2015-09-22 18:12:00.423' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102880, CAST(N'2015-09-22 18:12:03.840' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102881, CAST(N'2015-09-22 18:12:08.357' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102882, CAST(N'2015-09-22 18:15:26.400' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102883, CAST(N'2015-09-22 18:18:06.167' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102884, CAST(N'2015-09-22 18:31:04.080' AS DateTime), N'Login', N'Login exitoso', N'admin')
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
SET IDENTITY_INSERT [dbo].[Componente] ON 

INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (41, N'Administrador', N'Para administradores', NULL, NULL)
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (47, N'Carreras_3003', N'Carreras', 0, N'Carreras.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (48, N'BackUp_10104', N'BackUp', 41, N'Backup.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (49, N'AbmFamilias', N'Asignar Familias', 41, N'AbmFamilias.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (50, N'AbmUsuarios_10107', N'Control de usuarios', 41, N'AbmUsuarios.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (51, N'Clave_3008', N'Cambiar password', 0, N'CambiarPassword.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (52, N'AbmIdiomas_10101', N'Abm Idiomas', 41, N'AbmIdiomas.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (74, N'Bitacora_10103', N'Ver bitacora', 41, N'Bitacora.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (76, N'Materias', N'Materias', 0, N'Materias.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (78, N'Examenes', N'Examenes', 94, N'Examenes.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (80, N'CarrerasMaterias', N'Carreras y Materias', 95, N'CarrerasMaterias.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (82, N'RendirExamen', N'Examen de Materia', 94, N'ExamenMateria.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (88, N'Profesor', N'Rol profesor', NULL, NULL)
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (90, N'Objetivos', N'Cargar objetivos', 88, N'ExamenCorrecion.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (91, N'Evaluar', N'Evaluar', 88, N'ContenidoCarrera.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (92, N'Fortalezas', N'Fortalezas y debilidades', 88, N'ContenidoMateria.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (93, N'Aumentos', N'Ascensos y aumentos', 96, N'Pago.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (94, N'Alumno', N'Rol alumno', NULL, NULL)
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (95, N'Empleado', N'Rol emp. administrativo', NULL, NULL)
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (96, N'Director', N'Rol director', NULL, NULL)
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (97, N'Empleado', N'Empleado', 96, N'ExamenEvaluacionRevision.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (98, N'AbmTraducciones_10102', N'Abm Traducciones', 41, N'AbmTraducciones.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (99, N'NuevaCarrera', N'Nueva Carrera', 96, N'NuevaCarrera.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (100, N'RevisionCarrera', N'Revision Carrera', 96, N'RevisionCarrera.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (101, N'NuevaMateria', N'Nueva Materia', 96, N'NuevaMateria.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (102, N'RevisionMateria', N'Revision Materia', 96, N'RevisionMateria.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (103, N'MateriasDetalle', N'Detalle de materia', 0, N'MateriasDetalle.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (104, N'ExamenResultado', N'Resultado de examen', 88, N'ExamenResultado.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (105, N'DetalleExamen', N'Detalle de Examen', 94, N'DetalleExamen.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (106, N'CarrerasDetalle', N'Detalle de carrera', 94, N'CarrerasDetalle.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (107, N'Alumnos', N'Alumnos', 95, N'Alumnos.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (108, N'Pago', N'Pago', 95, N'Pago.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (109, N'MateriasDetalle', N'Materias Detalle', 88, N'MateriasDetalle.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (110, N'ExamenResultado', N'Examen Resultado', 88, N'ExamenResultado.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (111, N'AbmPermisos_10106', N'Abm Permisos', 41, N'AbmPermisos.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (112, N'AbmUsuarios', N'Abm Usuarios', 41, N'AbmUsuarios.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (115, N'Tester', N'De pruebas', NULL, NULL)
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (1114, N'Mensajes_3009', N'Mensajes', 0, N'Mensajes.aspx')
SET IDENTITY_INSERT [dbo].[Componente] OFF
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (48, 41)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (48, 115)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (50, 41)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (52, 41)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (74, 41)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (76, 94)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (76, 96)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (78, 94)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (78, 96)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (80, 95)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (82, 94)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (90, 88)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (91, 88)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (92, 88)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (97, 96)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (98, 41)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (98, 115)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (99, 96)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (100, 96)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (101, 96)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (102, 96)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (103, 94)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (104, 94)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (105, 94)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (106, 94)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (107, 95)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (108, 95)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (109, 88)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (111, 41)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (1, N'File', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (2, N'Edit', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (3, N'View', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (4, N'Management', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (5, N'BackUp', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (6, N'Families', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (8, N'btnUsuarios', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (9, N'lblFamilia', 10003)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10, N'btnNuevo', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (11, N'lblFamiliaName', 10003)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (12, N'lblFamiliaDesc', 10003)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (13, N'btnDelete', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (14, N'btnCancelar', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (15, N'btnGuardar', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (16, N'grFamilia', 10003)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (17, N'lblUsuario', 10004)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (18, N'gbUser', 10004)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (19, N'chbActivo', 10004)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (20, N'chbAdmin', 10004)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (21, N'lblApellido', 10004)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (22, N'lblNombre', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (23, N'lblUserName', 10004)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (24, N'gbPermisos', 10004)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (25, N'btnCambiarPassword', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (26, N'lblOldPassWord', 10005)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (27, N'lblNewPassWord1', 10005)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (28, N'lblNewPassWord1', 10005)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (29, N'lbIdiomas', 10006)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (30, N'btnCambiarLenguage', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (31, N'Boton Buscar Path', 10002)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (32, N'Boton Crear BackUp', 10002)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (33, N'Boton Recuperar BackUp', 10002)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (34, N'TabPage BackUp', 10002)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (35, N'TabPage Restore', 10002)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (100, N'btnObraSociales', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (101, N'lblObraSocial', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (102, N'gbObraSocial', 10008)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (103, N'lblTelefono', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (104, N'lblDirección', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (105, N'btnEliminar', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (106, N'btnDireccion', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (107, N'lblNombre', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (108, N'lblApellido', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (109, N'lblEmail', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (110, N'gbPlan', 10009)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (111, N'btnOk', 10009)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (112, N'btnCancelarPlanes', 10009)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (113, N'lblnombre', 10009)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (114, N'mnuEvaluaciones', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (115, N'lblProfesional', 10010)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (116, N'gbProfesional', 10010)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (117, N'lblApellido', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (118, N'lblFechaNac', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (119, N'lblFechaIng', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (120, N'lblMail', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (121, N'lblObservaciones', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (122, N'btnEspecialidad', 10010)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (123, N'mnuRecursos', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (124, N'btnCargarObjetivos', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (125, N'btnEvaluar', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (126, N'bntModificar', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (127, N'btnEquipos', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (128, N'btnFortalezas', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (129, N'btnAumentos', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (130, N'Empleado', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (131, N'Editar objetivos', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (132, N'Detalle', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (133, N'Fecha a evaluar', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (134, N'Guardar', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (135, N'Eviar', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (136, N'Limpiar', 10009)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (137, N'Fortalezas', 10010)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (138, N'Debilidades', 10010)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (139, N'col Capacidad', 10010)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (140, N'col Nivel', 10010)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (141, N'Emp ascenso', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (142, N'Emp aumento', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (144, N'clm Cumplido', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (145, N'clm Motivo', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (146, N'clm Cargo', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (147, N'clm Antiguedad', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (148, N'clm FutCargo', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (149, N'clm SueldoActual', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (150, N'clm SueldoNuevo', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (151, N'clm Incremento', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (160, N'clmUsuario', 10025)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (161, N'clmFecha', 10025)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (162, N'clmTipo', 10025)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (163, N'clmDetalle', 10025)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (164, N'btnBitacora', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (167, N'btnLogOff', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (168, N'lblContrasena', 10004)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (500, N'Tipo Login', 10025)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (501, N'Msg Login Ok', 10025)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (502, N'Msg Loin Error', 10025)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (503, N'Tipo Logout', 10025)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (504, N'Msg Logout', 10025)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (510, N'Tipo Backup', 10025)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (511, N'Msg Backup Ok', 10025)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (512, N'Msg Restore Ok', 10025)
GO
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (600, N'Cargo GerenteGral', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (601, N'Cargo GerenteArea', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (602, N'Cargo GerenteProyecto', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (603, N'Cargo AquitectoSr', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (604, N'Cargo Arquitecto', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (605, N'Cargo TeamLeadSr', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (606, N'Cargo TeamLead', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (607, N'Cargo AnalistaSr', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (608, N'Cargo Analista', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (609, N'Cargo DesarroladorSr', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (610, N'Cargo Desarrollador', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (611, N'Cargo Junior', 10011)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10001, N'MDIForm', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10002, N'frmBackUp', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10003, N'frmFamilias', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10004, N'frmUsuarios', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10005, N'frmChangePassword', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10006, N'Form Change Idiom', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10007, N'Form Direccion', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10008, N'Form Obra Social', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10009, N'Form Evaluaciones', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10010, N'Form Recursos', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10011, N'FormEspecialidad', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10012, N'FormIngEspecialidades', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10013, N'FormPacientes', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10014, N'formTurnos', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (10025, N'Form Bitacora', NULL)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90001, N'Error Con.Open', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90002, N'Error Cmd.GetReader', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90003, N'Error No Controlado', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90004, N'Confirmar de Operación', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90005, N'Error BackUp', 10002)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90006, N'Error Restore', 10002)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90007, N'Error Guardar Familia', 10003)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90008, N'Error Eliminar Familia', 10003)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90009, N'Error Commit Transacción', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90010, N'Error SetHDigito', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90011, N'Error SetVDigito', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90012, N'Error Guardar Usuario', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90013, N'Error Usuario-contrasena incorrectos', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90014, N'Ok BackUp', 10002)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90015, N'Ok Restore', 10002)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90016, N'Error string', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90017, N'Error Integer', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90018, N'Error Date', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90027, N'ErrorDigitos', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90028, N'Error Unique Key', 10004)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90029, N'Error Delete User', 10004)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90030, N'Error New Password Incorrect', 10005)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90031, N'Error old Password', 10005)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90034, N'Error selecting Item', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90044, N'Error Direccion no seleccionada', 10001)
INSERT [dbo].[Control] ([ID], [Descripcion], [Form_ID]) VALUES (90045, N'Error CUIT', 10001)
SET IDENTITY_INSERT [dbo].[DigitoV] ON 

INSERT [dbo].[DigitoV] ([ID], [Tabla], [DigitoV]) VALUES (1, N'Usuario', N'4898914ECBE19011872F8EBE31A1522F')
SET IDENTITY_INSERT [dbo].[DigitoV] OFF
SET IDENTITY_INSERT [dbo].[ElementoAcademico] ON 

INSERT [dbo].[ElementoAcademico] ([CodigoAcademico], [Comentario], [Contenido], [CriteriosAprobacion], [Descripcion], [Duracion], [FechaInicio], [Nombre], [Temas], [Cupo], [Clases], [Precio]) VALUES (1, N'Comentario del director', N'Preparacion de cultivos. Regado. Tratamiento y mantenimiento.', N'Se toman 2 examenes y debe ser del 70%.', N'Este curso consiste en la preparacion de los cultivos hidroponicos.', 40, CAST(N'2015-10-20' AS Date), N'Cultivos I', N'Cultivos, Hidroponia, Regado.', 25, 8, CAST(1600.50 AS Decimal(18, 2)))
INSERT [dbo].[ElementoAcademico] ([CodigoAcademico], [Comentario], [Contenido], [CriteriosAprobacion], [Descripcion], [Duracion], [FechaInicio], [Nombre], [Temas], [Cupo], [Clases], [Precio]) VALUES (2, N'Comentario del director', N'Cultivos avanzados, tecnicas automatizadas.', N'Se toman 2 examenes y debe ser del 70%.', N'Este curso consiste en la preparacion de los cultivos hidroponicos.', 45, CAST(N'2015-10-20' AS Date), N'Cultivos II', N'Cultivos, Hidroponia, Regado.', 25, 8, CAST(1800.50 AS Decimal(18, 2)))
INSERT [dbo].[ElementoAcademico] ([CodigoAcademico], [Comentario], [Contenido], [CriteriosAprobacion], [Descripcion], [Duracion], [FechaInicio], [Nombre], [Temas], [Cupo], [Clases], [Precio]) VALUES (3, N'Comentario del director', N'Introduccion a la hidroponia. Cuidado de cultivos hidroponicos.', N'Se toman 2 examenes y debe ser del 70%.', N'Este curso consiste en la preparacion de los cultivos hidroponicos.', 50, CAST(N'2015-10-20' AS Date), N'Hidroponia I', N'Cultivos, Hidroponia, Regado.', 20, 10, CAST(2200.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[ElementoAcademico] OFF
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10001, N'MDIForm')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10002, N'FormBackUp')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10003, N'FormFamilies')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10004, N'FormUsuarios')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10005, N'FormPassword')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10006, N'FormChangeIdiom')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10008, N'FormEntrevistas')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10009, N'FormCargarObjetivos')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10010, N'FormFortalezas')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10011, N'FormAumentos')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10012, N'FormEvaluar')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10013, N'FormEquipos')
INSERT [dbo].[Formulario] ([ID], [Descripcion]) VALUES (10025, N'FormBitacora')
INSERT [dbo].[Idioma] ([ID], [Nombre]) VALUES (1, N'Español')
INSERT [dbo].[Idioma] ([ID], [Nombre]) VALUES (2, N'English')
SET IDENTITY_INSERT [dbo].[Idioma_Control] ON 

INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (6, 1, N'Administracion', 4)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (9, 1, N'Error intentando abrir la conexión a la BD.', 90001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (10, 1, N'Error intentando realizar una consulta a la BD.', 90002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (11, 1, N'Error del sistema. Consulte al Administrador.', 90003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (12, 1, N'¿Esta seguro que desea realizar esta operación?', 90004)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (13, 1, N'Error al intentar crear el BackUp.', 90005)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (14, 1, N'Error al intentar recuperar el BackUp.', 90006)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (15, 1, N'Error al intentar guardar la Familia.', 90007)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (16, 1, N'Error al intentar eliminar la Familia.', 90008)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (17, 1, N'Error al intentar confirmar la transacción.', 90009)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (20, 1, N'Error al intentar actualizar el usuario.', 90012)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (21, 1, N'Se creo el BackUp correctamente', 90014)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (22, 1, N'Se recupero el BackUp correctamente', 90015)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (23, 1, N'El dato {0} no es correcto. No puede ser vacío.', 90016)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (24, 1, N'El dato {0} no es correcto. Debe ser un dato numérico.', 90017)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (25, 1, N'El dato {0} no es correcto. Debe ser un dato tipo fecha.', 90018)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (26, 1, N'Familia', 9)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (27, 1, N'Nuevo', 10)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (28, 1, N'Nombre', 11)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (29, 1, N'Descripción', 12)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (30, 1, N'Eliminar', 13)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (31, 1, N'Cancelar', 14)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (32, 1, N'Guardar', 15)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (33, 1, N'Familia', 16)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (36, 1, N'Usuario', 17)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (38, 1, N'Intentos', 18)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (39, 1, N'Activo', 19)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (40, 1, N'Administrador', 20)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (41, 1, N'Apellido', 21)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (42, 1, N'Nombre', 22)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (43, 1, N'Usuario', 23)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (44, 1, N'Permisos', 24)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (45, 1, N'El nombre de usuario ya existe.', 90028)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (46, 1, N'Error al intentar eliminar el usuario', 90029)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (47, 1, N'Cambiar &password', 25)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (49, 1, N'Password actual', 26)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (50, 1, N'Nueva password', 27)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (51, 1, N'Repita la nueva password', 28)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (52, 1, N'Las nuevas contraseñas no coinciden.', 90030)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (53, 1, N'La contraseña actual es incorrecta.', 90031)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (58, 2, N'Administration', 4)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (61, 2, N'Error trying to open the connection to the Database.', 90001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (62, 2, N'Error trying to perform a query to the database.', 90002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (63, 2, N'System failure. Refer to the administrator.', 90003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (64, 2, N'Are you sure you want to perform this operation?', 90004)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (65, 2, N'Error trying to create the backup.', 90005)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (66, 2, N'Error retrieving the backup.', 90006)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (67, 2, N'Error while trying to save the family.', 90007)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (68, 2, N'Error deleting the family.', 90008)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (69, 2, N'Error when trying to confirm the transaction.', 90009)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (72, 2, N'Error trying to update the user.', 90012)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (73, 2, N'The BackUp was created correctly', 90014)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (74, 2, N'BackUp was retrieved correctly', 90015)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (75, 2, N'The data {0} is not correct. Can not be empty.', 90016)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (76, 2, N'The data {0} is not correct. Must be a numeric data.', 90017)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (77, 2, N'The data {0} is not correct. Must be a date data type.', 90018)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (78, 2, N'Family', 9)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (79, 2, N'New', 10)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (80, 2, N'Name', 11)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (81, 2, N'Description', 12)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (82, 2, N'Delete', 13)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (83, 2, N'Cancel', 14)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (84, 2, N'Save', 15)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (85, 2, N'Family', 16)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (87, 2, N'User management', 8)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (88, 2, N'User', 17)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (90, 2, N'Bad pass', 18)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (91, 2, N'Active', 19)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (92, 2, N'Administrator', 20)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (93, 2, N'Surname', 21)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (94, 2, N'Name', 22)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (95, 2, N'User', 23)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (96, 2, N'Permissions', 24)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (97, 2, N'The user name already exists.', 90028)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (98, 2, N'Error deleting user', 90029)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (99, 2, N'Change &password', 25)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (101, 2, N'Current password', 26)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (102, 2, N'New password', 27)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (103, 2, N'Repeat the new password', 28)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (104, 2, N'New passwords do not match.', 90030)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (105, 2, N'The current password is incorrect.', 90031)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (108, 1, N'Idiomas', 29)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (109, 2, N'Languages', 29)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (110, 1, N'Idioma', 30)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (111, 2, N'Language', 30)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (112, 1, N'Buscar', 31)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (113, 2, N'Search', 31)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (114, 1, N'Crear', 32)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (115, 2, N'Create', 32)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (116, 1, N'Recuperar', 33)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (117, 2, N'Restore', 33)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (118, 1, N'Resguardar', 34)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (119, 2, N'BackUp', 34)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (120, 1, N'Recuperar', 35)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (121, 2, N'Restore', 35)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (150, 1, N'Error al seleccionar del combo {0}.', 90034)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (151, 2, N'Error selecting on the combo {0}.', 90034)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (471, 1, N'Usuario', 160)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (472, 2, N'User', 160)
GO
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (473, 1, N'Fecha', 161)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (474, 2, N'Date', 161)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (475, 1, N'Tipo', 162)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (476, 2, N'Type', 162)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (477, 1, N'Detalle', 163)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (478, 2, N'Detail', 163)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (479, 1, N'Bitácora', 164)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (480, 2, N'Log', 164)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (489, 1, N'Cerrar &sesión', 167)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (490, 2, N'Log &out', 167)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (491, 1, N'Contraseña', 168)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (492, 2, N'Password', 168)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (515, 1, N'Nivel', 103)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (516, 2, N'Level', 103)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (517, 1, N'Buscar en el sitio', 104)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (518, 2, N'Search on site', 104)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (519, 1, N'Listado', 106)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (520, 2, N'List', 106)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (521, 1, N'Nombre', 107)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (522, 2, N'Name', 107)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (523, 1, N'Eliminar', 105)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (524, 2, N'Delete', 105)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (527, 1, N'Apellido', 108)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (528, 2, N'Last', 108)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (529, 1, N'Email', 109)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (530, 2, N'Email', 109)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (537, 1, N'Apellido', 117)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (538, 2, N'Last Name', 117)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (578, 1, N'Familias', 10003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (579, 2, N'Families', 10003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (583, 1, N'Back Up / Resguardo', 10002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (584, 2, N'Back Up', 10002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (585, 1, N'Usuarios', 10004)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (586, 2, N'Users', 10004)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (587, 1, N'Cambiar Password', 10005)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (588, 2, N'Change Password', 10005)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (589, 1, N'Cambiar Idioma', 10006)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (590, 2, N'Change Language', 10006)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (591, 1, N'Familias', 6)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (592, 2, N'Families', 6)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (593, 1, N'Bitacora', 10025)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (594, 2, N'Log', 10025)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (603, 1, N'Usuarios', 8)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (611, 1, N'Login', 500)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (612, 2, N'Login', 500)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (613, 1, N'Login correcto', 501)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (614, 2, N'Login succesfully', 501)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (615, 1, N'Login erroneo', 502)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (616, 2, N'Error on login', 502)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (617, 1, N'Cierre de sesion', 503)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (618, 2, N'Log off', 503)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (619, 1, N'Se cerro la sesion', 504)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (620, 2, N'Logged off', 504)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (621, 1, N'Resguardo', 510)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (622, 2, N'Backup', 510)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (623, 1, N'Se realizo un resguardo de la base de datos', 511)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (624, 2, N'A backup of the database was performed', 511)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (625, 1, N'Se recuperaron los datos de una copia guardada', 512)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (626, 2, N'The database was retrieved', 512)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (627, 1, N'Empleado: ', 130)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (628, 2, N'Employee: ', 130)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (629, 1, N'Cargar Objetivos', 10009)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (630, 2, N'Load Objetives', 10009)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (631, 1, N'Edite los objetivos', 131)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (632, 2, N'Edit the objetives', 131)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (633, 1, N'Detalle', 132)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (634, 2, N'Detail', 132)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (635, 1, N'Fecha', 133)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (636, 2, N'Date', 133)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (642, 1, N'Guardar', 134)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (643, 2, N'Save', 134)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (645, 1, N'Enviar', 135)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (646, 2, N'Send', 135)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (657, 1, N'Nivel', 140)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (658, 2, N'Level', 140)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (659, 1, N'Gestion roles', 10106)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (660, 2, N'Role management', 10106)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (671, 1, N'Evaluar', 125)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (672, 2, N'Evaluate', 125)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (673, 1, N'Evaluar', 10012)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (674, 2, N'Evaluate', 10012)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (675, 1, N'Formar Equipo', 10013)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (676, 2, N'Create Team', 10013)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (683, 1, N'Cargo', 146)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (684, 2, N'Position', 146)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (690, 1, N'Sueldo', 149)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (691, 2, N'Salary', 149)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (692, 1, N'Nuevo sueldo', 150)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (693, 2, N'New salary', 150)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (694, 1, N'Incremento', 151)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (695, 2, N'Increase', 151)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (696, 1, N'Gerente General', 600)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (697, 2, N'Managing Director', 600)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (698, 1, N'Gerente de Area', 601)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (699, 2, N'Area Director', 601)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (700, 1, N'Gerente de Proyecto', 602)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (701, 2, N'Project Director', 602)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (702, 1, N'Arquitecto Senior', 603)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (703, 2, N'Senior Architect', 603)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (704, 1, N'Arquitecto', 604)
GO
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (705, 2, N'Architect', 604)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (706, 1, N'Jefe de Equipo Senior', 605)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (707, 2, N'Team Lead Senior', 605)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (708, 1, N'Jefe de Equipo', 606)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (709, 2, N'Team Lead', 606)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (710, 1, N'Analista Senior', 607)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (711, 2, N'Senior Analyst', 607)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (712, 1, N'Analista', 608)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (713, 2, N'Analyst', 608)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (714, 1, N'Desarrollador Senior', 609)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (715, 2, N'Senior Developer', 609)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (716, 1, N'Desarrollador', 610)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (717, 2, N'Developer', 610)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (718, 1, N'Principiante', 611)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (719, 2, N'Junior', 611)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (724, 2, N'Home', 3001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (726, 1, N'Inicio', 3001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (727, 2, N'Careers', 3003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (728, 1, N'Carreras', 3003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (729, 2, N'News', 3004)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (730, 1, N'Novedades', 3004)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (731, 2, N'Services', 3005)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (732, 1, N'Servicios', 3005)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (733, 2, N'Contact Us', 3006)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (734, 1, N'Contactenos', 3006)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (735, 2, N'Admin Menu', 3007)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (736, 1, N'Menu Admin', 3007)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (737, 2, N'Languages management', 10101)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (738, 1, N'Gestion idiomas', 10101)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (739, 2, N'Translations management', 10102)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (740, 1, N'Gestion traducciones', 10102)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (741, 2, N'Log', 10103)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (742, 1, N'Bitacora', 10103)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (743, 2, N'Back Up', 10104)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (744, 1, N'Backup', 10104)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (745, 2, N'Help', 10105)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (746, 1, N'Ayuda', 10105)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (747, 1, N'Seleccionar', 801)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (748, 2, N'Select', 801)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (749, 2, N'Update', 405)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (750, 1, N'Actualizar', 405)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (751, 2, N'Selected family:', 403)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (752, 1, N'Familia seleccionada: ', 403)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (753, 2, N'Users management', 10107)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (754, 1, N'Gestion usuarios', 10107)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (755, 2, N'Clear', 36)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (756, 1, N'Limpiar', 36)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (757, 2, N'You must select an user first', 90035)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (758, 1, N'Debe seleccionar un usuario primero', 90035)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (759, 2, N'Change password', 3008)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (760, 1, N'Cambiar clave', 3008)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1755, 2, N'There was an error processing the request', 90040)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1756, 1, N'Se produjo un error en la operacion', 90040)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1757, 1, N'La operación se realizo con éxito.', 80001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1758, 2, N'Operation successfully completed.', 80001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1759, 1, N'La clave debe tener al menos 4 caracteres.', 90036)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1760, 2, N'Password must contain at least 4 characters.', 90036)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1761, 1, N'Editar', 7)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1762, 2, N'Edit', 7)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1765, 1, N'Agregar', 5)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1766, 2, N'Add', 5)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1767, 1, N'Traduccion', 803)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1768, 2, N'Translation', 803)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1769, 1, N'ID Idioma', 804)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1771, 2, N'Language ID', 804)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1772, 2, N'Do you want to delete?', 80002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (1773, 1, N'Desea eliminarlo?', 80002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3011, 2, N'Control ID', 805)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3012, 1, N'ID de Control', 805)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3013, 1, N'Bienvenido', 40)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3014, 2, N'Welcome', 40)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3015, 2, N'You don''t have the permission to access the requested resource', 90050)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3016, 1, N'No tiene permisos para acceder a la seccion solicitada', 90050)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3017, 1, N'Error', 10001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3018, 2, N'Error', 10001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3019, 2, N'*password will be ignored on update action', 90037)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3021, 1, N'*la clave sera ignorada al actualizar', 90037)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3022, 2, N'{0} must contain at least {1} characters', 90042)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (3023, 1, N'El dato {0} debe tener al menos {1} caracteres.', 90042)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (4022, 1, N'Registrarse', 480)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (4023, 2, N'Register', 480)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5022, 2, N'Recover', 490)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5023, 1, N'Recuperar', 490)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5024, 2, N'Messages', 3009)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5025, 1, N'Mensajes', 3009)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5026, 1, N'Mensaje a enviar', 700)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5027, 2, N'Message to send', 700)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5028, 1, N'Contactar al administrador', 703)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5029, 1, N'Resolver problemas de usuarios', 704)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5030, 2, N'Contact administrator', 703)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5031, 2, N'Help to users', 704)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5032, 1, N'Contenido', 705)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5033, 1, N'Emisor', 706)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5034, 1, N'Email emisor', 707)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5035, 1, N'Leido', 708)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5036, 2, N'The message was sent.', 709)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5038, 1, N'No se pudo procesar la solicitud.', 90045)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5039, 1, N'Se proceso la solicitud con éxito.', 90046)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5040, 2, N'Content', 705)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5041, 2, N'Sender', 706)
GO
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5042, 2, N'Sender email', 707)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5043, 2, N'Read', 708)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5044, 2, N'Your request cannot be processed.', 90045)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5045, 2, N'Your request was processed.', 90046)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5046, 1, N'Se envió el mensaje.', 709)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5066, 1, N'Precio', 41)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5067, 2, N'Price', 41)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5070, 1, N'Sin datos.', 3)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5071, 2, N'No data.', 3)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5095, 1, N'Listado de carreras', 50)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5096, 1, N'Comparacion', 51)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5097, 2, N'Courses listing', 50)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5098, 2, N'Comparison', 51)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5099, 2, N'Recalculate digits.', 710)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5100, 1, N'Recalcular digitos.', 710)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5415, 1, N'Registro', 60)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5416, 2, N'Register', 60)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5417, 1, N'Ya es usuario ?', 61)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5418, 2, N'Already an user?', 61)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5419, 1, N'Registracion en Agrorobots E-Learning', 62)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5420, 2, N'Agrorobots E-Learning Registration', 62)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5421, 2, N'To activate your user please follow this link ', 63)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5422, 1, N'Para activar su usuario ingrese a ', 63)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5423, 2, N'Email sent, check you inbox.', 64)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5424, 1, N'Email enviado, verifique su casilla.', 64)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5425, 1, N'Error de envio de email.', 65)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5426, 2, N'There was an error sending the email.', 65)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5427, 2, N'Agrorobots E-Learning password restore', 66)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5428, 1, N'Recuperacion de clave de Agrorobots E-Learning', 66)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5429, 1, N'Se creo una nueva clave, ingrese al sistema y cambiela por una que rescuerde. Su clave es: ', 67)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5430, 2, N'A new password was created, Login into the site and change the password to one that yoy remember. Your password is: ', 67)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5431, 1, N'Error, no coinciden los datos con nuestros registros.', 90047)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5432, 2, N'Error, the data did not match with our records.', 90047)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5433, 1, N'Usuario activado, ingrese al sistema.', 68)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5434, 2, N'User activated, Login please.', 68)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5435, 1, N'Error al activar el usuario.', 69)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5436, 2, N'Error activating the user.', 69)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5437, 1, N'Datos invalidos.', 90048)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5438, 2, N'Invalid data.', 90048)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5439, 1, N'Intentos de Login superados', 70)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5440, 2, N'Login tries execeeded', 70)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5441, 1, N'recupere su clave.', 71)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5442, 2, N'please recover your password.', 71)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5443, 1, N'Olvido su clave?', 72)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5444, 2, N'Forgot your password?', 72)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5445, 2, N'Password recover', 491)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5446, 1, N'Recuperar clave', 491)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5447, 1, N'Usuario no activo, revise su email.', 73)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5448, 2, N'User not activated, check your email.', 73)
SET IDENTITY_INSERT [dbo].[Idioma_Control] OFF
SET IDENTITY_INSERT [dbo].[Mensajes] ON 

INSERT [dbo].[Mensajes] ([ID], [Contenido], [UsuarioEmisor], [EmailEmisor], [RolEmisor], [UsuarioReceptor], [EmailReceptor], [RolReceptor], [Broadcast], [ID_Conversacion], [Leido], [Fecha]) VALUES (1, N'Hola, necesito asistencia para poder cambiar el curso en el que me anote, como procedo? ', 11, N'mural@scvsoft.com', 0, 0, N'', 41, 0, 0, 0, CAST(N'2015-09-19 18:23:38.063' AS DateTime))
INSERT [dbo].[Mensajes] ([ID], [Contenido], [UsuarioEmisor], [EmailEmisor], [RolEmisor], [UsuarioReceptor], [EmailReceptor], [RolReceptor], [Broadcast], [ID_Conversacion], [Leido], [Fecha]) VALUES (2, N'Pasame los datos del curso al que queres anotarte ', 0, N'', 41, 11, N'', 41, 0, 0, 0, CAST(N'2015-09-19 19:50:07.737' AS DateTime))
INSERT [dbo].[Mensajes] ([ID], [Contenido], [UsuarioEmisor], [EmailEmisor], [RolEmisor], [UsuarioReceptor], [EmailReceptor], [RolReceptor], [Broadcast], [ID_Conversacion], [Leido], [Fecha]) VALUES (7, N'hola dmin soy horatin', 15, N'mural@scvsoft.com', 0, 0, N'', 41, 0, 0, 0, CAST(N'2015-09-20 01:50:50.560' AS DateTime))
INSERT [dbo].[Mensajes] ([ID], [Contenido], [UsuarioEmisor], [EmailEmisor], [RolEmisor], [UsuarioReceptor], [EmailReceptor], [RolReceptor], [Broadcast], [ID_Conversacion], [Leido], [Fecha]) VALUES (12, N'hola Horacio, cual es tu consulta?', 0, N'', 41, 15, N'', 0, 0, 0, 0, CAST(N'2015-09-20 17:08:52.787' AS DateTime))
SET IDENTITY_INSERT [dbo].[Mensajes] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email]) VALUES (2, 1, 1, N'Nistador', 2, N'Admi', N'21232F297A57A5A743894A0E4A801FC3', N'admin', 0, N'99A22B3F39C629C59F47D26B0693301D', N'mural@scvsoft.com')
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email]) VALUES (11, 1, 0, N'Sgarlata', 2, N'Agus', N'81DC9BDB52D04DC20036DBD8313ED055', N'alumno', 0, N'13552C81B8DFC6106F68CAAF7C12C9AB', N'mural@scvsoft.com')
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email]) VALUES (15, 1, 0, N'Lopez', 1, N'Horacio', N'81DC9BDB52D04DC20036DBD8313ED055', N'profesor', 0, N'78CC4938CC40D5FD807B4FC324D80215', N'mural@scvsoft.com')
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email]) VALUES (16, 1, 0, N'Lugo', 1, N'Martin', N'81DC9BDB52D04DC20036DBD8313ED055', N'empleado', 0, N'0D97F5F1D18B8CAD8A9075FAB6F64533', N'mural@scvsoft.com')
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email]) VALUES (17, 0, 0, N'Garcia', 1, N'Marcelo', N'81DC9BDB52D04DC20036DBD8313ED055', N'director', 3, N'C1E94C5242AFC0F5CFA9D40C910B939E', N'mural@scvsoft.com')
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email]) VALUES (2025, 1, 0, N'Gonzales', 1, N'Facundo', N'81DC9BDB52D04DC20036DBD8313ED055', N'facu', 0, N'6E3FB78E07B1F02EBA513BCEFF5C795C', N'mural@scvsoft.com')
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email]) VALUES (3030, 1, 0, N'mera', 1, N'diego ', N'81DC9BDB52D04DC20036DBD8313ED055', N'gomera', 0, N'85C551DFBA712B4137F8930C1645BDE0', N'mural@scvsoft.com')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (2, 41)
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (2, 115)
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (11, 94)
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (11, 115)
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (15, 88)
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (16, 95)
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (17, 96)
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (2025, 115)
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (3025, 41)
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (3026, 41)
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (3028, 94)
INSERT [dbo].[Usuario_Componente] ([Usu_ID], [Comp_ID]) VALUES (3030, 94)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_Usuario_UserName]    Script Date: 22/09/2015 18:31:33 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [UQ_Usuario_UserName] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Componente_Parent]  WITH CHECK ADD  CONSTRAINT [FK_Child_Id] FOREIGN KEY([Child_Id])
REFERENCES [dbo].[Componente] ([ID])
GO
ALTER TABLE [dbo].[Componente_Parent] CHECK CONSTRAINT [FK_Child_Id]
GO
ALTER TABLE [dbo].[Componente_Parent]  WITH CHECK ADD  CONSTRAINT [FK_Parent_Id] FOREIGN KEY([Parent_Id])
REFERENCES [dbo].[Componente] ([ID])
GO
ALTER TABLE [dbo].[Componente_Parent] CHECK CONSTRAINT [FK_Parent_Id]
GO
ALTER TABLE [dbo].[Control]  WITH CHECK ADD  CONSTRAINT [FK_Form_ID] FOREIGN KEY([Form_ID])
REFERENCES [dbo].[Formulario] ([ID])
GO
ALTER TABLE [dbo].[Control] CHECK CONSTRAINT [FK_Form_ID]
GO
ALTER TABLE [dbo].[Idioma_Control]  WITH CHECK ADD  CONSTRAINT [FK_Idioma_ID] FOREIGN KEY([Idioma_ID])
REFERENCES [dbo].[Idioma] ([ID])
GO
ALTER TABLE [dbo].[Idioma_Control] CHECK CONSTRAINT [FK_Idioma_ID]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Idioma_ID] FOREIGN KEY([Idioma_ID])
REFERENCES [dbo].[Idioma] ([ID])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Idioma_ID]
GO
ALTER TABLE [dbo].[Usuario_Componente]  WITH CHECK ADD  CONSTRAINT [FK_Comp_ID] FOREIGN KEY([Comp_ID])
REFERENCES [dbo].[Componente] ([ID])
GO
ALTER TABLE [dbo].[Usuario_Componente] CHECK CONSTRAINT [FK_Comp_ID]
GO
USE [master]
GO
ALTER DATABASE [agrorobots] SET  READ_WRITE 
GO
