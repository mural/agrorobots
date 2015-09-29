USE [master]
GO
/****** Object:  Database [agrorobots]    Script Date: 29/09/2015 18:36:14 ******/
CREATE DATABASE [agrorobots]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'agrorobots', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\agrorobots.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'agrorobots_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\agrorobots_log.ldf' , SIZE = 4224KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  StoredProcedure [dbo].[AsignarCompAFam]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[AssignPermissionToUser]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[CleanFamily]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[CreateBackUp]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[CreateTraduccion]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteComponente]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteTraduccion]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[ElementoAcademicoActualizar]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ElementoAcademicoActualizar]	@CodigoAcademico int,	@Comentario varchar(255),	@Contenido varchar(255),	@CriteriosAprobacion varchar(255),	@Descripcion varchar(255),	@Duracion int,	@FechaInicio date,	@Nombre varchar(100),	@Temas varchar(255),	@Cupo int,	@Clases int,	@Precio decimalASSET NOCOUNT ONIF @CodigoAcademico = 0 BEGIN	INSERT INTO ElementoAcademico (		[Comentario],		[Contenido],		[CriteriosAprobacion],		[Descripcion],		[Duracion],		[FechaInicio],		[Nombre],		[Temas],		[Cupo],		[Clases],		[Precio]	)	VALUES (		@Comentario,		@Contenido,		@CriteriosAprobacion,		@Descripcion,		@Duracion,		@FechaInicio,		@Nombre,		@Temas,		@Cupo,		@Clases,		@Precio	)	SELECT SCOPE_IDENTITY() As InsertedIDENDELSE BEGIN	UPDATE ElementoAcademico SET 		[Comentario] = @Comentario,		[Contenido] = @Contenido,		[CriteriosAprobacion] = @CriteriosAprobacion,		[Descripcion] = @Descripcion,		[Duracion] = @Duracion,		[FechaInicio] = @FechaInicio,		[Nombre] = @Nombre,		[Temas] = @Temas,		[Cupo] = @Cupo,		[Clases] = @Clases,		[Precio] = @Precio	WHERE [CodigoAcademico] = @CodigoAcademicoENDSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[ElementoAcademicoBorrar]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ElementoAcademicoBorrar]	@CodigoAcademico intASSET NOCOUNT ONDELETE FROM ElementoAcademicoWHERE [CodigoAcademico] = @CodigoAcademicoSET NOCOUNT OFF

GO
/****** Object:  StoredProcedure [dbo].[ElementoAcademicoListar]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ElementoAcademicoListar]ASSET NOCOUNT ONSELECT * FROM ElementoAcademicoSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[ElementoAcademicoObtener]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ElementoAcademicoObtener]	@CodigoAcademico intASSET NOCOUNT ONSELECT * FROM ElementoAcademicoWHERE [CodigoAcademico] = @CodigoAcademicoSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[GetAllComponents]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetAllComponents]
as
select c.ID, c.Nombre, c.Descripcion, c.Control_ID, c.URL from componente c


GO
/****** Object:  StoredProcedure [dbo].[GetAllDigits]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[GetAllDigits]
as
select Tabla, DigitoV from DigitoV




GO
/****** Object:  StoredProcedure [dbo].[GetAllFamilies]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetAllFamilies]
as
select ID, Nombre, Descripcion from componente 
where Control_ID is null


GO
/****** Object:  StoredProcedure [dbo].[GetCapacidadesPorPerfil]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[GetComponentsByFamily]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[GetComponentsByUsu]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[GetItemsBitacora]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetItemsBitacora]
as
select * from bitacora
order by FechaHora desc


GO
/****** Object:  StoredProcedure [dbo].[GetRow4DH]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTable4DV]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTranslationsByForm]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTranslationsByIdiom]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserByUserName]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[IdiomaActualizar]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IdiomaActualizar]
	-- Add the parameters for the stored procedure here
	@ID as smallint,
	@Desc as varchar(50),
	@Codigo as varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Idioma]
   SET [Nombre] = @Desc,
   [Codigo] = @Codigo
	WHERE [ID] = @ID
END

GO
/****** Object:  StoredProcedure [dbo].[IdiomaBorrar]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IdiomaBorrar]
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
/****** Object:  StoredProcedure [dbo].[IdiomaCrear]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IdiomaCrear]
	-- Add the parameters for the stored procedure here
	@IdiomaID As Integer,
	@IdiomaDesc As varchar(50),
	@Codigo as varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
INSERT INTO [dbo].[Idioma]
           ([ID], [Nombre], [Codigo])
     VALUES
           (@IdiomaID, @IdiomaDesc, @Codigo)

INSERT INTO [dbo].[Idioma_Control]
           ([Idioma_ID]
           ,[Traduccion]
           ,[Control_ID])
     SELECT TOP 2000 
      @IdiomaID,
      [Traduccion],
      [Control_ID]
  FROM [agrorobots].[dbo].[Idioma_Control]
  WHERE [Idioma_ID] = 1
END

GO
/****** Object:  StoredProcedure [dbo].[IdiomasListar]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[IdiomasListar]
as
select i.ID, i.Nombre, i.Codigo from idioma i
order by ID


GO
/****** Object:  StoredProcedure [dbo].[ListarMensajes]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[LogInBitagora]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[MensajeActualizar]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[MensajeBorrar]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MensajeBorrar]	@ID intASSET NOCOUNT ONDELETE FROM MensajesWHERE [ID] = @IDSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[MensajeListar]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MensajeListar]ASSET NOCOUNT ONSELECT * FROM MensajesSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[MensajeObtener]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MensajeObtener]	@ID intASSET NOCOUNT ONSELECT * FROM MensajesWHERE [ID] = @IDSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[MensajeObtenerPorRol]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[MensajeObtenerPorUsuario]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[NewFamilia]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[NewUser]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[RemoveAllComponentesFromUsu]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[SetDHToRow]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[SetDVbyTable]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateFamilia]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateTraduccionByID]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateUserByUsuOrId]    Script Date: 29/09/2015 18:36:14 ******/
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
@Email varchar(50),
@Foto image = NULL
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
Email = @Email,
Foto = @Foto
where
ID = @ID


GO
/****** Object:  StoredProcedure [dbo].[UpdateUserPassword]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  StoredProcedure [dbo].[UsuarioBorrar]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[UsuarioBorrar]
(
@ID int
)
as
delete from usuario
where id=@ID


GO
/****** Object:  StoredProcedure [dbo].[UsuarioListar]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[UsuarioListar]
as
select * from usuario
order by UserName



GO
/****** Object:  StoredProcedure [dbo].[UsuarioObtenerPorId]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  Table [dbo].[Componente]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  Table [dbo].[Componente_Parent]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  Table [dbo].[Control]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  Table [dbo].[DigitoV]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  Table [dbo].[ElementoAcademico]    Script Date: 29/09/2015 18:36:14 ******/
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
	[Imagen] [image] NULL,
 CONSTRAINT [PK_ElementoAcademico] PRIMARY KEY CLUSTERED 
(
	[CodigoAcademico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Formulario]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  Table [dbo].[Idioma]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Idioma](
	[ID] [smallint] NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Codigo] [varchar](10) NULL,
 CONSTRAINT [PK_Idioma] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Idioma_Control]    Script Date: 29/09/2015 18:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Idioma_Control](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Idioma_ID] [smallint] NOT NULL,
	[Traduccion] [varchar](max) NULL,
	[Control_ID] [int] NULL,
 CONSTRAINT [PK_Idioma_Control] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Mensajes]    Script Date: 29/09/2015 18:36:14 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 29/09/2015 18:36:14 ******/
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
	[Foto] [image] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario_Componente]    Script Date: 29/09/2015 18:36:14 ******/
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
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102885, CAST(N'2015-09-22 18:32:54.707' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102886, CAST(N'2015-09-22 18:41:25.903' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102887, CAST(N'2015-09-24 00:16:24.310' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102888, CAST(N'2015-09-24 00:16:39.327' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102889, CAST(N'2015-09-24 00:22:31.210' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102890, CAST(N'2015-09-24 00:22:32.623' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102891, CAST(N'2015-09-24 00:26:18.787' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102892, CAST(N'2015-09-24 00:26:41.630' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102893, CAST(N'2015-09-24 01:12:27.863' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102894, CAST(N'2015-09-24 01:36:14.977' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102895, CAST(N'2015-09-24 01:39:51.323' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102896, CAST(N'2015-09-24 01:45:39.707' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102897, CAST(N'2015-09-24 01:46:48.473' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102898, CAST(N'2015-09-24 01:46:51.020' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102899, CAST(N'2015-09-24 01:46:53.493' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102900, CAST(N'2015-09-24 01:46:58.970' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102901, CAST(N'2015-09-24 01:48:04.100' AS DateTime), N'Logout', N'Logout exitoso', N'Lugo')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102902, CAST(N'2015-09-24 01:48:42.520' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102903, CAST(N'2015-09-24 01:48:56.520' AS DateTime), N'Logout', N'Logout exitoso', N'Lugo')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102904, CAST(N'2015-09-24 01:54:35.120' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102905, CAST(N'2015-09-24 01:56:17.563' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102906, CAST(N'2015-09-24 01:56:37.847' AS DateTime), N'Logout', N'Logout exitoso', N'Lugo')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102907, CAST(N'2015-09-24 01:56:40.023' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102908, CAST(N'2015-09-24 02:03:40.733' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102909, CAST(N'2015-09-24 02:16:07.983' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102910, CAST(N'2015-09-24 02:16:22.143' AS DateTime), N'Logout', N'Logout exitoso', N'Lugo')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102911, CAST(N'2015-09-24 02:16:24.133' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102912, CAST(N'2015-09-24 02:19:00.600' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102913, CAST(N'2015-09-24 02:19:17.283' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102914, CAST(N'2015-09-24 02:28:18.650' AS DateTime), N'Login', N'Login exitoso', N'empleado')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102915, CAST(N'2015-09-24 02:28:21.117' AS DateTime), N'Logout', N'Logout exitoso', N'Lugo')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102916, CAST(N'2015-09-24 02:28:23.890' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102917, CAST(N'2015-09-24 02:30:29.410' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102918, CAST(N'2015-09-24 02:37:24.247' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102919, CAST(N'2015-09-24 02:38:44.390' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102920, CAST(N'2015-09-24 02:40:16.580' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102921, CAST(N'2015-09-24 02:49:59.330' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102922, CAST(N'2015-09-24 02:51:07.950' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102923, CAST(N'2015-09-24 02:53:57.803' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102924, CAST(N'2015-09-24 02:55:51.233' AS DateTime), N'Login', N'Login exitoso', N'empleado')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102925, CAST(N'2015-09-24 02:56:29.400' AS DateTime), N'Logout', N'Logout exitoso', N'Lugo')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102926, CAST(N'2015-09-24 02:56:33.743' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102927, CAST(N'2015-09-24 03:01:24.817' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102928, CAST(N'2015-09-24 03:06:43.937' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (102929, CAST(N'2015-09-25 23:47:40.623' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112885, CAST(N'2015-09-26 14:30:06.353' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112886, CAST(N'2015-09-26 14:30:21.630' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112887, CAST(N'2015-09-26 14:30:23.830' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112888, CAST(N'2015-09-26 14:31:03.953' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112889, CAST(N'2015-09-26 15:44:37.493' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112890, CAST(N'2015-09-26 15:50:07.473' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112891, CAST(N'2015-09-26 15:50:27.827' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112892, CAST(N'2015-09-26 15:54:34.983' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112893, CAST(N'2015-09-26 16:02:13.060' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112894, CAST(N'2015-09-26 16:30:35.170' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112895, CAST(N'2015-09-26 16:30:44.850' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112896, CAST(N'2015-09-26 16:30:45.940' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112897, CAST(N'2015-09-26 16:30:49.590' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112898, CAST(N'2015-09-26 16:31:15.320' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112899, CAST(N'2015-09-26 16:31:53.720' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112900, CAST(N'2015-09-26 16:32:14.820' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112901, CAST(N'2015-09-26 16:56:51.073' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112902, CAST(N'2015-09-26 16:56:55.610' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112903, CAST(N'2015-09-26 16:57:18.373' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112904, CAST(N'2015-09-26 16:57:22.950' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112905, CAST(N'2015-09-26 16:58:49.783' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112906, CAST(N'2015-09-26 17:11:22.417' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112907, CAST(N'2015-09-26 17:25:26.973' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112908, CAST(N'2015-09-26 17:29:41.450' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112909, CAST(N'2015-09-26 17:46:18.047' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112910, CAST(N'2015-09-26 18:32:40.857' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112911, CAST(N'2015-09-26 18:33:12.210' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112912, CAST(N'2015-09-26 18:39:06.713' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112913, CAST(N'2015-09-26 18:58:45.593' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112914, CAST(N'2015-09-26 19:00:51.943' AS DateTime), N'Logout', N'Logout exitoso', N'Agus')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112915, CAST(N'2015-09-26 19:14:54.680' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112916, CAST(N'2015-09-26 19:18:00.847' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112917, CAST(N'2015-09-26 19:20:13.320' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112918, CAST(N'2015-09-26 19:31:35.030' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112919, CAST(N'2015-09-26 20:02:00.593' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112920, CAST(N'2015-09-26 20:04:05.267' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112921, CAST(N'2015-09-26 20:09:06.850' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112922, CAST(N'2015-09-26 20:12:23.953' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112923, CAST(N'2015-09-26 20:12:36.757' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112924, CAST(N'2015-09-26 20:18:34.147' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112925, CAST(N'2015-09-26 20:18:47.700' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112926, CAST(N'2015-09-26 20:18:50.663' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112927, CAST(N'2015-09-26 20:32:09.320' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112928, CAST(N'2015-09-26 20:32:13.170' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112929, CAST(N'2015-09-27 13:25:33.947' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112930, CAST(N'2015-09-27 13:26:21.210' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112931, CAST(N'2015-09-27 13:40:14.057' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112932, CAST(N'2015-09-27 14:06:52.607' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112933, CAST(N'2015-09-27 14:21:55.803' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112934, CAST(N'2015-09-27 14:28:01.270' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112935, CAST(N'2015-09-27 14:28:04.930' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112936, CAST(N'2015-09-27 14:28:21.453' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112937, CAST(N'2015-09-27 14:28:25.857' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112938, CAST(N'2015-09-27 14:30:35.757' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112939, CAST(N'2015-09-27 14:30:38.913' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112940, CAST(N'2015-09-27 14:31:12.520' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112941, CAST(N'2015-09-27 14:31:15.550' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112942, CAST(N'2015-09-27 14:39:06.647' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112943, CAST(N'2015-09-27 14:46:23.420' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112944, CAST(N'2015-09-27 14:48:26.610' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112945, CAST(N'2015-09-27 14:59:07.990' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112946, CAST(N'2015-09-27 15:01:33.840' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112947, CAST(N'2015-09-27 15:04:26.260' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112948, CAST(N'2015-09-27 16:59:21.720' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112949, CAST(N'2015-09-27 16:59:27.103' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112950, CAST(N'2015-09-27 16:59:32.337' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112951, CAST(N'2015-09-27 16:59:54.450' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112952, CAST(N'2015-09-27 17:00:18.517' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112953, CAST(N'2015-09-27 17:01:34.763' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112954, CAST(N'2015-09-27 17:01:57.343' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112955, CAST(N'2015-09-27 17:05:22.920' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112956, CAST(N'2015-09-27 17:13:10.740' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112957, CAST(N'2015-09-27 17:13:27.603' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112958, CAST(N'2015-09-27 17:13:31.010' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112959, CAST(N'2015-09-27 17:27:08.497' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112960, CAST(N'2015-09-27 17:27:59.090' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112961, CAST(N'2015-09-27 17:36:18.257' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112962, CAST(N'2015-09-27 17:37:23.600' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112963, CAST(N'2015-09-27 17:42:28.040' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112964, CAST(N'2015-09-27 17:50:07.723' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112965, CAST(N'2015-09-27 17:55:31.397' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112966, CAST(N'2015-09-27 17:56:12.287' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112967, CAST(N'2015-09-27 17:59:32.103' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112968, CAST(N'2015-09-27 17:59:35.087' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112969, CAST(N'2015-09-27 17:59:58.790' AS DateTime), N'Login', N'Login exitoso', N'alumno')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112970, CAST(N'2015-09-27 18:00:23.317' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112971, CAST(N'2015-09-27 18:00:37.120' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112972, CAST(N'2015-09-27 18:02:23.880' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112973, CAST(N'2015-09-27 18:05:53.063' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112974, CAST(N'2015-09-27 18:15:28.977' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112975, CAST(N'2015-09-27 18:39:28.150' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112976, CAST(N'2015-09-27 18:52:24.160' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112977, CAST(N'2015-09-27 18:52:28.007' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112978, CAST(N'2015-09-27 18:56:54.647' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112979, CAST(N'2015-09-27 20:40:33.080' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112980, CAST(N'2015-09-27 20:46:58.350' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112981, CAST(N'2015-09-27 21:05:06.233' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112982, CAST(N'2015-09-27 21:11:23.337' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112983, CAST(N'2015-09-27 21:19:38.433' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112984, CAST(N'2015-09-27 21:20:03.193' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112985, CAST(N'2015-09-27 21:20:06.430' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112986, CAST(N'2015-09-27 21:23:33.890' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112987, CAST(N'2015-09-27 21:23:37.070' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112988, CAST(N'2015-09-27 21:23:40.963' AS DateTime), N'Backup', N'Backup realizado', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112989, CAST(N'2015-09-27 21:27:12.540' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112990, CAST(N'2015-09-27 21:27:16.447' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112991, CAST(N'2015-09-27 21:31:01.173' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112992, CAST(N'2015-09-27 21:31:04.807' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112993, CAST(N'2015-09-27 21:38:38.460' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112994, CAST(N'2015-09-27 21:38:40.743' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112995, CAST(N'2015-09-27 21:41:45.380' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112996, CAST(N'2015-09-27 21:45:25.133' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112997, CAST(N'2015-09-27 21:45:27.083' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112998, CAST(N'2015-09-27 21:54:35.517' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (112999, CAST(N'2015-09-27 21:59:14.727' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113000, CAST(N'2015-09-27 21:59:17.580' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113001, CAST(N'2015-09-27 22:00:36.637' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113002, CAST(N'2015-09-27 22:00:39.127' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113003, CAST(N'2015-09-27 22:01:47.100' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113004, CAST(N'2015-09-27 22:01:49.243' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113005, CAST(N'2015-09-27 22:01:56.670' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113006, CAST(N'2015-09-27 22:04:49.883' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113007, CAST(N'2015-09-27 22:07:25.837' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113008, CAST(N'2015-09-27 23:21:44.123' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113009, CAST(N'2015-09-27 23:23:26.267' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113010, CAST(N'2015-09-27 23:23:30.843' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113011, CAST(N'2015-09-28 02:42:46.737' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113012, CAST(N'2015-09-28 02:43:57.483' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113013, CAST(N'2015-09-28 02:44:15.053' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113014, CAST(N'2015-09-28 02:44:20.133' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113015, CAST(N'2015-09-28 02:50:31.530' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113016, CAST(N'2015-09-28 02:50:49.677' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113017, CAST(N'2015-09-28 02:51:01.757' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113018, CAST(N'2015-09-28 02:51:04.040' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113019, CAST(N'2015-09-28 02:58:24.500' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113020, CAST(N'2015-09-28 02:58:28.857' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113021, CAST(N'2015-09-28 02:58:47.320' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113022, CAST(N'2015-09-28 02:59:23.930' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113023, CAST(N'2015-09-28 02:59:27.567' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113024, CAST(N'2015-09-28 03:00:34.463' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113025, CAST(N'2015-09-28 03:00:38.127' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113026, CAST(N'2015-09-28 03:00:43.723' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113027, CAST(N'2015-09-28 03:01:02.323' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113028, CAST(N'2015-09-28 03:01:15.487' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113029, CAST(N'2015-09-28 03:38:38.807' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113030, CAST(N'2015-09-28 03:39:40.453' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113031, CAST(N'2015-09-28 03:40:42.930' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113032, CAST(N'2015-09-28 03:40:45.263' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113033, CAST(N'2015-09-28 03:40:50.557' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113034, CAST(N'2015-09-28 03:41:15.640' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113035, CAST(N'2015-09-28 19:09:32.013' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113036, CAST(N'2015-09-28 19:17:13.010' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113037, CAST(N'2015-09-28 19:20:06.330' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113038, CAST(N'2015-09-28 19:21:53.500' AS DateTime), N'Logout', N'Logout exitoso', N'Agus')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113039, CAST(N'2015-09-28 19:32:15.037' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113040, CAST(N'2015-09-28 19:40:13.553' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113041, CAST(N'2015-09-28 19:40:20.437' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113042, CAST(N'2015-09-28 19:40:23.237' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113043, CAST(N'2015-09-28 19:47:27.620' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113044, CAST(N'2015-09-28 19:49:45.667' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113045, CAST(N'2015-09-28 19:50:28.950' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113046, CAST(N'2015-09-28 19:50:30.833' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113047, CAST(N'2015-09-28 20:00:37.683' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113048, CAST(N'2015-09-28 20:01:00.593' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113049, CAST(N'2015-09-28 20:01:03.960' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113050, CAST(N'2015-09-28 20:25:20.817' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113051, CAST(N'2015-09-28 20:51:47.767' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113052, CAST(N'2015-09-28 21:25:34.843' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113053, CAST(N'2015-09-28 21:31:05.130' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113054, CAST(N'2015-09-28 21:49:59.493' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113055, CAST(N'2015-09-28 21:50:29.380' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113056, CAST(N'2015-09-28 21:50:34.033' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113057, CAST(N'2015-09-28 21:50:37.087' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113058, CAST(N'2015-09-28 21:52:04.240' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113059, CAST(N'2015-09-28 21:54:50.627' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113060, CAST(N'2015-09-28 22:10:53.517' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113061, CAST(N'2015-09-28 22:13:19.380' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113062, CAST(N'2015-09-28 22:16:39.930' AS DateTime), N'Logout', N'Logout exitoso', N'Nistador')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113063, CAST(N'2015-09-28 22:39:59.273' AS DateTime), N'Login', N'Login insatisfactorio', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113064, CAST(N'2015-09-28 22:40:01.837' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113065, CAST(N'2015-09-28 22:47:17.540' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113066, CAST(N'2015-09-28 22:49:08.873' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113067, CAST(N'2015-09-28 22:49:55.210' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113068, CAST(N'2015-09-28 22:50:34.987' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113069, CAST(N'2015-09-28 22:52:16.880' AS DateTime), N'Login', N'Login exitoso', N'alumno')
GO
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113070, CAST(N'2015-09-28 22:52:23.677' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113071, CAST(N'2015-09-28 22:52:50.093' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113072, CAST(N'2015-09-28 22:55:33.613' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113073, CAST(N'2015-09-28 22:55:41.620' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113074, CAST(N'2015-09-28 22:56:06.157' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113075, CAST(N'2015-09-28 22:58:04.687' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113076, CAST(N'2015-09-28 23:01:49.070' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113077, CAST(N'2015-09-28 23:03:20.760' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113078, CAST(N'2015-09-28 23:12:39.270' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113079, CAST(N'2015-09-28 23:13:12.090' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113080, CAST(N'2015-09-28 23:13:17.830' AS DateTime), N'Login', N'Login exitoso', N'admin')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113081, CAST(N'2015-09-29 00:42:41.497' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113082, CAST(N'2015-09-29 00:49:13.680' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113083, CAST(N'2015-09-29 00:51:14.390' AS DateTime), N'Logout', N'Logout exitoso', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113084, CAST(N'2015-09-29 00:51:17.397' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113085, CAST(N'2015-09-29 00:55:29.363' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113086, CAST(N'2015-09-29 01:01:17.957' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113087, CAST(N'2015-09-29 01:01:57.650' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113088, CAST(N'2015-09-29 01:02:17.930' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113089, CAST(N'2015-09-29 01:03:34.050' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113090, CAST(N'2015-09-29 01:07:36.850' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113091, CAST(N'2015-09-29 01:13:14.547' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113092, CAST(N'2015-09-29 01:17:03.420' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113093, CAST(N'2015-09-29 01:18:34.953' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113094, CAST(N'2015-09-29 01:23:24.700' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113095, CAST(N'2015-09-29 01:28:55.307' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113096, CAST(N'2015-09-29 01:32:37.660' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113097, CAST(N'2015-09-29 01:34:04.613' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113098, CAST(N'2015-09-29 01:34:27.280' AS DateTime), N'Logout', N'Logout exitoso', N'Sgarlata')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113099, CAST(N'2015-09-29 01:34:29.963' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113100, CAST(N'2015-09-29 01:36:50.690' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113101, CAST(N'2015-09-29 01:40:01.947' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113102, CAST(N'2015-09-29 01:42:30.927' AS DateTime), N'Logout', N'Logout exitoso', N'')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113103, CAST(N'2015-09-29 01:42:34.350' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113104, CAST(N'2015-09-29 02:12:39.710' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113105, CAST(N'2015-09-29 03:09:53.070' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113106, CAST(N'2015-09-29 03:11:04.050' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113107, CAST(N'2015-09-29 03:11:58.100' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113108, CAST(N'2015-09-29 03:13:38.280' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113109, CAST(N'2015-09-29 03:16:16.530' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113110, CAST(N'2015-09-29 03:17:04.447' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (113111, CAST(N'2015-09-29 03:18:03.030' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (122988, CAST(N'2015-09-29 18:30:48.370' AS DateTime), N'Login', N'Login exitoso', N'alumno')
INSERT [dbo].[Bitacora] ([ID], [FechaHora], [Tipo], [Descripcion], [User]) VALUES (122989, CAST(N'2015-09-29 18:30:55.533' AS DateTime), N'Backup', N'Backup realizado', N'alumno')
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
SET IDENTITY_INSERT [dbo].[Componente] ON 

INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (41, N'Administrador', N'Para administradores', NULL, NULL)
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (47, N'Carreras_3003', N'Carreras', 0, N'Carreras.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (48, N'BackUp_10104', N'BackUp', 41, N'Backup.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (49, N'AbmFamilias', N'Asignar Familias', 41, N'AbmFamilias.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (50, N'AbmUsuarios_10107', N'Control de usuarios', 41, N'AbmUsuarios.aspx')
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (51, N'Clave_3008', N'Cambiar password', 0, N'CambioClave.aspx')
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
INSERT [dbo].[Componente] ([ID], [Nombre], [Descripcion], [Control_ID], [URL]) VALUES (1116, N'Home Usuario', N'Bienvenida', 0, N'Pantalla_Principal.aspx')
SET IDENTITY_INSERT [dbo].[Componente] OFF
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (48, 41)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (48, 115)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (50, 41)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (50, 94)
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (51, 41)
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
INSERT [dbo].[Componente_Parent] ([Child_Id], [Parent_Id]) VALUES (1114, 41)
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

INSERT [dbo].[DigitoV] ([ID], [Tabla], [DigitoV]) VALUES (1, N'Usuario', N'766DF426A01A0302EA8CD8EFCBAF7E3A')
SET IDENTITY_INSERT [dbo].[DigitoV] OFF
SET IDENTITY_INSERT [dbo].[ElementoAcademico] ON 

INSERT [dbo].[ElementoAcademico] ([CodigoAcademico], [Comentario], [Contenido], [CriteriosAprobacion], [Descripcion], [Duracion], [FechaInicio], [Nombre], [Temas], [Cupo], [Clases], [Precio], [Imagen]) VALUES (1, N'Comentario del director', N'Preparacion de cultivos. Regado. Tratamiento y mantenimiento.', N'Se toman 2 examenes y debe ser del 70%.', N'Este curso consiste en la preparacion de los cultivos hidroponicos.', 40, CAST(N'2015-10-20' AS Date), N'Cultivos I', N'Cultivos, Hidroponia, Regado.', 25, 8, CAST(1600.50 AS Decimal(18, 2)), NULL)
INSERT [dbo].[ElementoAcademico] ([CodigoAcademico], [Comentario], [Contenido], [CriteriosAprobacion], [Descripcion], [Duracion], [FechaInicio], [Nombre], [Temas], [Cupo], [Clases], [Precio], [Imagen]) VALUES (2, N'Comentario del director', N'Cultivos avanzados, tecnicas automatizadas.', N'Se toman 2 examenes y debe ser del 70%.', N'Este curso consiste en la preparacion de los cultivos hidroponicos.', 45, CAST(N'2015-10-20' AS Date), N'Cultivos II', N'Cultivos, Hidroponia, Regado.', 25, 8, CAST(1800.50 AS Decimal(18, 2)), NULL)
INSERT [dbo].[ElementoAcademico] ([CodigoAcademico], [Comentario], [Contenido], [CriteriosAprobacion], [Descripcion], [Duracion], [FechaInicio], [Nombre], [Temas], [Cupo], [Clases], [Precio], [Imagen]) VALUES (3, N'Comentario del director', N'Introduccion a la hidroponia. Cuidado de cultivos hidroponicos.', N'Se toman 2 examenes y debe ser del 70%.', N'Este curso consiste en la preparacion de los cultivos hidroponicos.', 50, CAST(N'2015-10-20' AS Date), N'Hidroponia I', N'Cultivos, Hidroponia, Regado.', 20, 10, CAST(2200.00 AS Decimal(18, 2)), NULL)
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
INSERT [dbo].[Idioma] ([ID], [Nombre], [Codigo]) VALUES (1, N'Español', N'es-AR')
INSERT [dbo].[Idioma] ([ID], [Nombre], [Codigo]) VALUES (2, N'English', N'en-US')
INSERT [dbo].[Idioma] ([ID], [Nombre], [Codigo]) VALUES (3, N'Frances', N'fr-FR')
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
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5449, 1, N'Políticas de privacidad', 152)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5450, 2, N'Privacy Policies', 152)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5451, 1, N'Sobre nosotros', 153)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5452, 2, N'About Us', 153)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5453, 1, N'Menu lateral', 37)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5454, 1, N'Navegacion', 38)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5455, 2, N'Side Menu', 37)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5456, 2, N'Navigation', 38)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5457, 1, N'<p>En Agrorobots, en adelante &lsquo;este sitio web&rsquo;, respetamos su informaci&oacute;n personal y en vista de cumplir con las pol&iacute;ticas de seguridad respectivas concernientes a todo sitio web, que deber&iacute;an ser obligatorias, informo a ustedes lo siguiente.</p>

<h6>Privacidad de los datos personales:</h6>

<p>Sus datos personales le corresponden solo a usted y este sitio web es responsable de no revelar ninguna clase de informaci&oacute;n que le pertenezca (como email, n&uacute;meros de ip, etc.), salvo su expresa autorizaci&oacute;n o fuerzas de naturaleza mayor de tipo legal que lo involucren, como hackeos o suplantaciones.</p>

<h6>Responsabilidad de las opiniones vertidas:</h6>

<p>Las publicaciones a modo de art&iacute;culos (tambi&eacute;n llamados posts) son responsabilidad del autor del blog. Los comentarios, vertidos por los visitantes, son responsabilidad de ellos mismos y en caso alguno viole las reglas m&iacute;nimas de respeto a los dem&aacute;s y a las buenas costumbres, &eacute;stos ser&iacute;an borrados por el editor del blog, sin esperar su consentimiento.</p>

<h6>Seguridad de su informaci&oacute;n personal:</h6>

<p>Este sitio web se hace responsable de velar por su seguridad, por la privacidad de su informaci&oacute;n y por el respeto a sus datos, de acuerdo con las limitaciones que la actual Internet nos provee, siendo conscientes que no estamos exclu&iacute;dos de sufrir alg&uacute;n ataque por parte de crackers o usuarios malintencionados que ejerzan la delincuencia inform&aacute;tica.</p>

<h6>Obtenci&oacute;n de su informaci&oacute;n:</h6>

<p>Todos sus datos personales consignados en este sitio son suministrados por usted mismo, haciendo uso entero de su libertad. La informaci&oacute;n aqui almacenada solo comprende datos b&aacute;sicos ingresados mediante formularios de contacto, comentarios u otros similares.</p>

<h6>Uso de la informaci&oacute;n:</h6>

<p>Al proporcionarnos sus datos personales, estando de acuerdo con la Pol&iacute;tica de Privacidad aqu&iacute; consignada, nos autoriza para el siguiente uso de su informaci&oacute;n: a) para el fin mismo por lo cual se ha suministrado; b) para considerarlo dentro de nuestras estad&iacute;sticas de tr&aacute;fico, incrementando as&iacute; nuestra oferta publicitaria y de mercado; c) para orientar mejor los servicios aqu&iacute; ofrecidos y valorarlos a su criterio, y d) para enviar e-mails con nuestros boletines, responder inquietudes o comentarios, y mantener informado a nuestros usuarios.</p>

<h6>Uso de los cookies:</h6>

<p>El uso de cookies y su direcci&oacute;n IP, tomados por este sitio, se realiza solo con la finalidad de mantenerles un sitio de acuerdo a sus preferencias locales (tales como navegador web usado, sistema operativo, ISP, etc.). Las &quot;cookies&quot; permiten entregar un contenido ajustado a los intereses y necesidades de nuestros usuarios/visitantes. Tambi&eacute;n podr&iacute;an usarse cookies de Terceros que est&eacute;n presentes en este Weblog, como anunciantes o publicidad del mismo, con el &uacute;nico fin de proveer informaciones adicionales o reelevantes a la Navegaci&oacute;n del Usuario en este Sitio Web.</p>

<p>Modificaciones a nuestras Pol&iacute;ticas de Privacidad:</p>

<p>El sitio web se reserva el derecho de modificar, rectificar, alterar, agregar o eliminar cualquier punto del presente escrito en cualquier momento y sin previo aviso, siendo su responsabilidad el mantenerse informado del mismo para una adecuada administraci&oacute;n de su informaci&oacute;n.</p>
', 99002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5458, 2, N'            <p>In Agrorobots, hereinafter ''the website'', we respect your personal information and in view of meeting the respective security policies concerning the entire website, which should be mandatory, inform you as follows.</p>

            <h6>Privacy of personal data:</h6>

            <p>Your personal data will correspond only to you and this site is responsible for not disclose any kind of information that belongs to him (like email, ip numbers, etc.), unless specifically authorized or forces of nature more than the statutory rate involving, as hacking or spoofing.</p>

            <h6>Responsibility of the opinions:</h6>

            <p>Publications by way of articles (also called posts) are the responsibility of the author of the blog. Reviews, dumping by visitors, are responsible for themselves and in any case violates the basic rules of respect for others and decency, they would be deleted by the editor of the blog, without waiting for his consent.</p>

            <h6>Security of your personal information:</h6>

            <p>This web site is responsible for ensuring their safety, privacy of information and respect your data, in accordance with the limitations that the current Internet provides us, being aware that we are not excluded from suffering an attack by crackers or malicious users to exercise cybercrime.</p>

            <h6>Getting your information:</h6>

            <p>All your personal information contained in this site are provided for yourself, making full use of their freedom. The information stored here includes only basic data entered through contact forms, comments or the like.</p>

            <h6>Use of Information:</h6>

            <p>By providing their personal data, agreeing with the Privacy Policy herein will authorize us to use the following information: a) for the purpose for which it was provided; b) to consider it within our traffic statistics, thus increasing our advertising and market supply; c) to better target services and value offered here at its discretion, and d) to send e-mails with our newsletters, respond to concerns or comments and keep our users informed.</p>

            <h6>Use of cookies:</h6>

            <p>The use of cookies and IP address, taken from this site, is made only for the purpose of keeping a site according to local preferences (such as used web browser, operating system, ISP, etc.). &quot;Cookies&quot; allow deliver content tailored to the interests and needs of our users / visitors. They could also third-party cookies that are present in this Weblog, as advertisers or advertising thereof, with the sole purpose of providing additional information or importants to the user''s navigation on this Website used.</p>

            <h6>Changes to our Privacy Policy:</h6>

            <p>The website reserves the right to change, modify, alter, add or remove any part of this writing at any time and without notice, is your responsibility to stay informed of it for proper management of your information.</p>
', 99002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5459, 1, N'Terminos y condiciones', 154)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5460, 2, N'Terms and conditions', 154)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5461, 1, N'            <p>&Uacute;ltima actualizaci&oacute;n: 28 de septiembre 2015</p>

            <p>Por favor, lea estos t&eacute;rminos y condiciones (&quot;T&eacute;rminos&quot;, &quot;T&eacute;rminos y Condiciones&quot;) antes de utilizar el sitio web www.agrorobots.net (el &quot;Servicio&quot;) operado por Agrorobots (&quot;nosotros&quot;, &quot;nosotros&quot; o &quot;nuestro&quot;) .</p>

            <p>Su acceso y uso del Servicio est&aacute; condicionado a la aceptaci&oacute;n y cumplimiento de las presentes Condiciones. Estas Condiciones se aplican a todos los visitantes, usuarios y otras personas que accedan o usen el servicio.</p>

            <p>Al acceder o utilizar el Servicio, usted acepta que quedar&aacute; vinculado por estas Condiciones. Si no est&aacute; de acuerdo con alguna parte de los t&eacute;rminos, entonces no puede acceder al Servicio.</p>

            <h6>Cuentas</h6>

            <p>Al crear una cuenta con nosotros, debe proporcionar informaci&oacute;n que sea precisa, completa y actualizada en todo momento. El no hacerlo constituye una violaci&oacute;n de los t&eacute;rminos, que pueden resultar en la terminaci&oacute;n inmediata de su cuenta en nuestro servicio.</p>

            <p>Usted es responsable de salvaguardar la contrase&ntilde;a que utiliza para acceder al Servicio y para cualquier actividad o acciones bajo su contrase&ntilde;a, si su contrase&ntilde;a es con nuestro servicio o de un servicio de terceros.</p>

            <p>Usted se compromete a no revelar su contrase&ntilde;a a terceros. Usted debe notificarnos inmediatamente despu&eacute;s de haber tenido conocimiento de cualquier violaci&oacute;n de seguridad o uso no autorizado de su cuenta.</p>

            <h6>Enlaces a otros sitios Web Site</h6>

            <p>Nuestro Servicio puede contener enlaces a sitios web de terceros o servicios que no son propiedad o est&aacute;n controladas por Agrorobots.</p>

            <p>Agrorobots no tiene control sobre, y no asume ninguna responsabilidad por el contenido, pol&iacute;ticas de privacidad o las pr&aacute;cticas de sitios web o servicios de terceros. Adem&aacute;s, usted reconoce y acepta que Agrorobots no ser&aacute; responsable o estar&aacute; obligado, directa o indirectamente, por cualquier da&ntilde;o o p&eacute;rdida causada o supuestamente causada por o en conexi&oacute;n con el uso o la credibilidad en cualquier Contenido, bienes o servicios disponibles en oa trav&eacute;s de cualquiera de tales sitios o servicios web.</p>

            <p>Le aconsejamos que lea los t&eacute;rminos y condiciones y las pol&iacute;ticas de privacidad de los sitios Web de terceros o servicios que usted visite.</p>

            <h6>Terminaci&oacute;n</h6>

            <p>Podemos cancelar o suspender el acceso a nuestro servicio de inmediato, sin previo aviso o responsabilidad, por cualquier motivo, incluyendo, sin limitaci&oacute;n, si usted no cumple con las condiciones.</p>

            <p>Todas las disposiciones de los T&eacute;rminos que por su naturaleza deber&iacute;an sobrevivir terminaci&oacute;n, sobrevivir&aacute;n la terminaci&oacute;n, incluyendo, sin limitaci&oacute;n, las disposiciones de propiedad, renuncias de garant&iacute;a, indemnizaci&oacute;n y limitaciones de responsabilidad.</p>

            <p>Podemos cancelar o suspender su cuenta inmediatamente, sin previo aviso o responsabilidad, por cualquier motivo, incluyendo, sin limitaci&oacute;n, si usted no cumple con las condiciones.</p>

            <p>A la terminaci&oacute;n, su derecho a utilizar el Servicio cesar&aacute; inmediatamente. Si desea cancelar su cuenta, usted puede simplemente dejar de utilizar el Servicio.</p>

            <p>Todas las disposiciones de los T&eacute;rminos que por su naturaleza deber&iacute;an sobrevivir terminaci&oacute;n, sobrevivir&aacute;n la terminaci&oacute;n, incluyendo, sin limitaci&oacute;n, las disposiciones de propiedad, renuncias de garant&iacute;a, indemnizaci&oacute;n y limitaciones de responsabilidad.</p>

            <h6>Ley que rige</h6>

            <p>Estos T&eacute;rminos se regir&aacute;n e interpretar&aacute;n de acuerdo con las leyes de Argentina, sin consideraci&oacute;n a su conflicto de disposiciones legales.</p>

            <p>Nuestra incapacidad para hacer cumplir cualquier derecho o disposici&oacute;n de estas Condiciones no se considerar&aacute; una renuncia a esos derechos. Si alguna disposici&oacute;n de estos T&eacute;rminos es considerada inv&aacute;lida o inaplicable por un tribunal, las restantes disposiciones de estas Condiciones permanecer&aacute;n vigentes. Estos T&eacute;rminos y Condiciones constituyen el acuerdo completo entre nosotros en relaci&oacute;n con nuestro Servicio, y sustituyen y reemplazan cualquier acuerdo anterior, tengamos entre nosotros en relaci&oacute;n con el Servicio.</p>

            <h6>Cambios</h6>

            <p>Nos reservamos el derecho, a nuestra sola discreci&oacute;n, de modificar o sustituir estas Condiciones en cualquier momento. Si la revisi&oacute;n es el material vamos a tratar de proporcionar por lo menos 30 d&iacute;as de antelaci&oacute;n antes de las nuevas condiciones que surtan efecto. Lo que constituye un cambio material ser&aacute; determinado a nuestra discreci&oacute;n.</p>

            <p>Al continuar accediendo o utilizar nuestro servicio despu&eacute;s de esas revisiones se hacen efectivos, usted acepta que quedar&aacute; vinculado por los t&eacute;rminos revisados. Si no acepta los nuevos t&eacute;rminos, por favor, deje de usar el Servicio.</p>

            <p>Nuestra T&eacute;rminos y Condiciones Acuerdo fue creado por TermsFeed.</p>

            <h6>Cont&aacute;ctenos</h6>

            <p>Si usted tiene alguna pregunta acerca de estos T&eacute;rminos, por favor p&oacute;ngase en contacto con nosotros.</p>
', 99001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5462, 2, N'            <p>Last updated: September 28, 2015</p>

            <p>Please read these Terms and Conditions (&quot;Terms&quot;, &quot;Terms and Conditions&quot;) carefully before using the www.agrorobots.net website (the &quot;Service&quot;) operated by Agrorobots (&quot;us&quot;, &quot;we&quot;, or &quot;our&quot;).</p>

            <p>Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Service.</p>

            <p>By accessing or using the Service you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access the Service.</p>

            <h6>Accounts</h6>

            <p>When you create an account with us, you must provide us information that is accurate, complete, and current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service.</p>

            <p>You are responsible for safeguarding the password that you use to access the Service and for any activities or actions under your password, whether your password is with our Service or a third-party service.</p>

            <p>You agree not to disclose your password to any third party. You must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account.</p>

            <h6>Links To Other Web Sites</h6>

            <p>Our Service may contain links to third-party web sites or services that are not owned or controlled by Agrorobots.</p>

            <p>Agrorobots has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party web sites or services. You further acknowledge and agree that Agrorobots shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such content, goods or services available on or through any such web sites or services.</p>

            <p>We strongly advise you to read the terms and conditions and privacy policies of any third-party web sites or services that you visit.</p>

            <h6>Termination</h6>

            <p>We may terminate or suspend access to our Service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.</p>

            <p>All provisions of the Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability.</p>

            <p>We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.</p>

            <p>Upon termination, your right to use the Service will immediately cease. If you wish to terminate your account, you may simply discontinue using the Service.</p>

            <p>All provisions of the Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability.</p>

            <h6>Governing Law</h6>

            <p>These Terms shall be governed and construed in accordance with the laws of Argentina, without regard to its conflict of law provisions.</p>

            <p>Our failure to enforce any right or provision of these Terms will not be considered a waiver of those rights. If any provision of these Terms is held to be invalid or unenforceable by a court, the remaining provisions of these Terms will remain in effect. These Terms constitute the entire agreement between us regarding our Service, and supersede and replace any prior agreements we might have between us regarding the Service.</p>

            <h6>Changes</h6>

            <p>We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material we will try to provide at least 30 days notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.</p>

            <p>By continuing to access or use our Service after those revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, please stop using the Service.</p>

            <p>Our Terms and Conditions agreement was created by TermsFeed.</p>

            <h6>Contact Us</h6>

            <p>If you have any questions about these Terms, please contact us.</p>', 99001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5463, 1, N'Estoy de acuerdo con los', 155)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5464, 1, N'y las', 156)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5465, 2, N'I agree with', 155)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5466, 2, N'and', 156)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5467, 1, N'Debe aceptar para proceder', 157)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5468, 2, N'You must agree to continue', 157)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5469, 1, N'Formato de Email invalido', 158)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5470, 2, N'Invalid Email format', 158)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5471, 1, N'            <h6>Situacion Actual</h6>

            <p>Agrorobots es una empresa joven ubicada en la Ciudad de Buenos Aires formada con entusiasmo, determinaci&oacute;n y enfocada en satisfacer al cliente. Estamos formados por profesionales capacitados para brindar todo el apoyo necesario para una experiencia &uacute;nica con el producto. </p>

            <h6>Motivacion</h6>

            <p>Ante la creciente demanda de alimentos sanos, que nos ayuden a conservar nuestra salud y de los cuales podamos confiar en su proceso de cultivo hasta la llegada a nuestra mesa, mucha gente se opone a los cultivos masivos, con desinfectantes nocivos, el uso de transg&eacute;nicos y qu&iacute;micos, buscando en el mercado otras fuentes que les provean productos de origen m&aacute;s natural y sin tratamientos qu&iacute;micos que los adulteren. Una forma de lograr esto es cultivar nuestros propios alimentos de una forma sencilla, que requiera poco espacio.</p>

            <h6>Solucion brindada</h6>

            <p>Agrorobots es la soluci&oacute;n en monitoreo que ayuda a al control de los cultivos hidrop&oacute;nicos, facilitando el proceso con un seguimiento en tiempo real y la posibilidad de controlar diversos aparatos el&eacute;ctricos (actuadores y sensores) que intervienen en el cultivo as&iacute; asegurar un &oacute;ptimo ambiente de forma constante.</p>

            <p>Nosotros ofrecemos un producto innovador &uacute;nico en el mercado sumado a una excelente asistencia post-venta para guiar al cliente en su uso e instalaci&oacute;n.  De esta forma brindamos una experiencia satisfactoria en cada consumidor, para que este pueda aprovechar y utilizar el producto de la forma m&aacute;s eficiente.</p>

            <h6>Factores principales de &eacute;xito del negocio</h6>

            <p>&bull; Contamos con personal calificado en nuestro rubro y la experiencia necesaria para acompa&ntilde;ar al cliente en sus inquietudes. Brindamos el asesoramiento para asegurar que cada cliente quede satisfecho.</p>

            <p>&bull; Nuestro producto se adapta a cada situaci&oacute;n y/o lugar que nuestros clientes puedan requerir. Desde lugares peque&ntilde;os como un monoambiente hasta patios o galpones. </p>

            <p>&bull; El clima no es un inconveniente de ning&uacute;n tipo, ya que con nuestro producto se podr&aacute; lograr el ambiente &oacute;ptimo durante todo el a&ntilde;o.</p>

            <p>&bull; Apuntamos a un mercado incipiente, en crecimiento que a&uacute;n no est&aacute; explotado, ni tiene grandes avances tecnol&oacute;gicos. </p>
', 99003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5472, 2, N'            <h6>Current situation</h6>

<p>Agrorobots is a young company located in the City of Buenos Aires formed with enthusiasm, determination and focused on customer satisfaction. We are shaped by trained professionals to provide all necessary support for a unique experience with the product.</p>

<h6>Motivation</h6>

<p>Given the increasing demand for healthy food, to help us preserve our health and which we trust their growing process until arrival at our table, many people oppose mass crops with harmful disinfectants, the use of GMOs and chemicals in the market for other sources that provide them with more natural products without chemical treatments adulterating. One way to accomplish this is to grow our own food in a simple, requiring little space.</p>

<h6>Solution provided</h6>

<p>Agrorobots is monitoring solution that helps to control hydroponics, facilitating the process with real-time tracking and the ability to control various electrical appliances (actuators and sensors) involved in the cultivation and ensure an optimal environment so constant.</p>

<p>We offer a unique and innovative product in the market coupled with an excellent after-sales service to guide customer installation and use. Thus we provide a satisfying experience in every consumer, so that it can build on and use the product more efficiently.</p>

<h6>Main factors of business success</h6>

<p>&bull; We have qualified in our field and the necessary staff to accompany the customer experience in their concerns. We provide advice to ensure that every customer is satisfied.</p>

<p>&bull; Our product is tailored to each situation and / or place that our clients may require. From small places like a studio apartment up patios or sheds.</p>

<p>&bull; The weather is not a problem of any kind, because with our product can achieve the optimum environment throughout the year.</p>

<p>&bull; We aim at a nascent market, which is growing untapped, or has great technological advances.</p>', 99003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5473, 1, N'Imagen', 2)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5474, 2, N'Image', 2)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5475, 1, N'Codigo', 1)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5476, 2, N'Code', 1)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5477, 3, N'Administracion', 4)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5478, 3, N'Error intentando abrir la conexión a la BD.', 90001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5479, 3, N'Error intentando realizar una consulta a la BD.', 90002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5480, 3, N'Error del sistema. Consulte al Administrador.', 90003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5481, 3, N'¿Esta seguro que desea realizar esta operación?', 90004)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5482, 3, N'Error al intentar crear el BackUp.', 90005)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5483, 3, N'Error al intentar recuperar el BackUp.', 90006)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5484, 3, N'Error al intentar guardar la Familia.', 90007)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5485, 3, N'Error al intentar eliminar la Familia.', 90008)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5486, 3, N'Error al intentar confirmar la transacción.', 90009)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5487, 3, N'Error al intentar actualizar el usuario.', 90012)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5488, 3, N'Se creo el BackUp correctamente', 90014)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5489, 3, N'Se recupero el BackUp correctamente', 90015)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5490, 3, N'El dato {0} no es correcto. No puede ser vacío.', 90016)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5491, 3, N'El dato {0} no es correcto. Debe ser un dato numérico.', 90017)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5492, 3, N'El dato {0} no es correcto. Debe ser un dato tipo fecha.', 90018)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5493, 3, N'Familia', 9)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5494, 3, N'Nuevo', 10)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5495, 3, N'Nombre', 11)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5496, 3, N'Descripción', 12)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5497, 3, N'Eliminar', 13)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5498, 3, N'Cancelar', 14)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5499, 3, N'Guardar', 15)
GO
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5500, 3, N'Familia', 16)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5501, 3, N'Usuario', 17)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5502, 3, N'Intentos', 18)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5503, 3, N'Activo', 19)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5504, 3, N'Administrador', 20)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5505, 3, N'Apellido', 21)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5506, 3, N'Nombre', 22)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5507, 3, N'Usuario', 23)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5508, 3, N'Permisos', 24)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5509, 3, N'El nombre de usuario ya existe.', 90028)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5510, 3, N'Error al intentar eliminar el usuario', 90029)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5511, 3, N'Cambiar &password', 25)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5512, 3, N'Password actual', 26)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5513, 3, N'Nueva password', 27)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5514, 3, N'Repita la nueva password', 28)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5515, 3, N'Las nuevas contraseñas no coinciden.', 90030)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5516, 3, N'La contraseña actual es incorrecta.', 90031)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5517, 3, N'Idiomas', 29)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5518, 3, N'Idioma', 30)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5519, 3, N'Buscar', 31)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5520, 3, N'Crear', 32)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5521, 3, N'Recuperar', 33)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5522, 3, N'Resguardar', 34)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5523, 3, N'Recuperar', 35)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5524, 3, N'Error al seleccionar del combo {0}.', 90034)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5525, 3, N'Usuario', 160)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5526, 3, N'Fecha', 161)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5527, 3, N'Tipo', 162)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5528, 3, N'Detalle', 163)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5529, 3, N'Bitácora', 164)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5530, 3, N'Cerrar &sesión', 167)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5531, 3, N'Contraseña', 168)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5532, 3, N'Nivel', 103)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5533, 3, N'Buscar en el sitio', 104)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5534, 3, N'Listado', 106)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5535, 3, N'Nombre', 107)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5536, 3, N'Eliminar', 105)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5537, 3, N'Apellido', 108)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5538, 3, N'Email', 109)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5539, 3, N'Apellido', 117)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5540, 3, N'Familias', 10003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5541, 3, N'Back Up / Resguardo', 10002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5542, 3, N'Usuarios', 10004)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5543, 3, N'Cambiar Password', 10005)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5544, 3, N'Cambiar Idioma', 10006)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5545, 3, N'Familias', 6)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5546, 3, N'Bitacora', 10025)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5547, 3, N'Usuarios', 8)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5548, 3, N'Login', 500)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5549, 3, N'Login correcto', 501)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5550, 3, N'Login erroneo', 502)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5551, 3, N'Cierre de sesion', 503)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5552, 3, N'Se cerro la sesion', 504)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5553, 3, N'Resguardo', 510)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5554, 3, N'Se realizo un resguardo de la base de datos', 511)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5555, 3, N'Se recuperaron los datos de una copia guardada', 512)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5556, 3, N'Empleado: ', 130)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5557, 3, N'Cargar Objetivos', 10009)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5558, 3, N'Edite los objetivos', 131)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5559, 3, N'Detalle', 132)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5560, 3, N'Fecha', 133)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5561, 3, N'Guardar', 134)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5562, 3, N'Enviar', 135)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5563, 3, N'Nivel', 140)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5564, 3, N'Gestion roles', 10106)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5565, 3, N'Evaluar', 125)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5566, 3, N'Evaluar', 10012)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5567, 3, N'Formar Equipo', 10013)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5568, 3, N'Cargo', 146)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5569, 3, N'Sueldo', 149)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5570, 3, N'Nuevo sueldo', 150)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5571, 3, N'Incremento', 151)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5572, 3, N'Gerente General', 600)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5573, 3, N'Gerente de Area', 601)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5574, 3, N'Gerente de Proyecto', 602)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5575, 3, N'Arquitecto Senior', 603)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5576, 3, N'Arquitecto', 604)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5577, 3, N'Jefe de Equipo Senior', 605)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5578, 3, N'Jefe de Equipo', 606)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5579, 3, N'Analista Senior', 607)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5580, 3, N'Analista', 608)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5581, 3, N'Desarrollador Senior', 609)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5582, 3, N'Desarrollador', 610)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5583, 3, N'Principiante', 611)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5584, 3, N'Inicio', 3001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5585, 3, N'Carreras', 3003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5586, 3, N'Novedades', 3004)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5587, 3, N'Servicios', 3005)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5588, 3, N'Contactenos', 3006)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5589, 3, N'Menu Admin', 3007)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5590, 3, N'Gestion idiomas', 10101)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5591, 3, N'Gestion traducciones', 10102)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5592, 3, N'Bitacora', 10103)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5593, 3, N'Backup', 10104)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5594, 3, N'Ayuda', 10105)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5595, 3, N'Seleccionar', 801)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5596, 3, N'Actualizar', 405)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5597, 3, N'Familia seleccionada: ', 403)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5598, 3, N'Gestion usuarios', 10107)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5599, 3, N'Limpiar', 36)
GO
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5600, 3, N'Debe seleccionar un usuario primero', 90035)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5601, 3, N'Cambiar clave', 3008)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5602, 3, N'Se produjo un error en la operacion', 90040)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5603, 3, N'La operación se realizo con éxito.', 80001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5604, 3, N'La clave debe tener al menos 4 caracteres.', 90036)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5605, 3, N'Editar', 7)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5606, 3, N'Agregar', 5)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5607, 3, N'Traduccion', 803)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5608, 3, N'ID Idioma', 804)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5609, 3, N'Desea eliminarlo?', 80002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5610, 3, N'ID de Control', 805)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5611, 3, N'Bienvenido', 40)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5612, 3, N'No tiene permisos para acceder a la seccion solicitada', 90050)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5613, 3, N'Error', 10001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5614, 3, N'*la clave sera ignorada al actualizar', 90037)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5615, 3, N'El dato {0} debe tener al menos {1} caracteres.', 90042)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5616, 3, N'Registrarse', 480)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5617, 3, N'Recuperar', 490)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5618, 3, N'Mensajes', 3009)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5619, 3, N'Mensaje a enviar', 700)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5620, 3, N'Contactar al administrador', 703)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5621, 3, N'Resolver problemas de usuarios', 704)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5622, 3, N'Contenido', 705)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5623, 3, N'Emisor', 706)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5624, 3, N'Email emisor', 707)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5625, 3, N'Leido', 708)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5626, 3, N'No se pudo procesar la solicitud.', 90045)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5627, 3, N'Se proceso la solicitud con éxito.', 90046)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5628, 3, N'Se envió el mensaje.', 709)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5629, 3, N'Precio', 41)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5630, 3, N'Sin datos.', 3)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5631, 3, N'Listado de carreras', 50)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5632, 3, N'Comparacion', 51)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5633, 3, N'Recalcular digitos.', 710)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5634, 3, N'Registro', 60)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5635, 3, N'Ya es usuario ?', 61)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5636, 3, N'Registracion en Agrorobots E-Learning', 62)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5637, 3, N'Para activar su usuario ingrese a ', 63)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5638, 3, N'Email enviado, verifique su casilla.', 64)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5639, 3, N'Error de envio de email.', 65)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5640, 3, N'Recuperacion de clave de Agrorobots E-Learning', 66)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5641, 3, N'Se creo una nueva clave, ingrese al sistema y cambiela por una que rescuerde. Su clave es: ', 67)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5642, 3, N'Error, no coinciden los datos con nuestros registros.', 90047)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5643, 3, N'Usuario activado, ingrese al sistema.', 68)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5644, 3, N'Error al activar el usuario.', 69)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5645, 3, N'Datos invalidos.', 90048)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5646, 3, N'Intentos de Login superados', 70)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5647, 3, N'recupere su clave.', 71)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5648, 3, N'Olvido su clave?', 72)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5649, 3, N'Recuperar clave', 491)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5650, 3, N'Usuario no activo, revise su email.', 73)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5651, 3, N'Políticas de privacidad', 152)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5652, 3, N'Sobre nosotros', 153)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5653, 3, N'Menu lateral', 37)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5654, 3, N'Navegacion', 38)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5655, 3, N'<p>En Agrorobots, en adelante &lsquo;este sitio web&rsquo;, respetamos su informaci&oacute;n personal y en vista de cumplir con las pol&iacute;ticas de seguridad respectivas concernientes a todo sitio web, que deber&iacute;an ser obligatorias, informo a ustedes lo siguiente.</p>

<h6>Privacidad de los datos personales:</h6>

<p>Sus datos personales le corresponden solo a usted y este sitio web es responsable de no revelar ninguna clase de informaci&oacute;n que le pertenezca (como email, n&uacute;meros de ip, etc.), salvo su expresa autorizaci&oacute;n o fuerzas de naturaleza mayor de tipo legal que lo involucren, como hackeos o suplantaciones.</p>

<h6>Responsabilidad de las opiniones vertidas:</h6>

<p>Las publicaciones a modo de art&iacute;culos (tambi&eacute;n llamados posts) son responsabilidad del autor del blog. Los comentarios, vertidos por los visitantes, son responsabilidad de ellos mismos y en caso alguno viole las reglas m&iacute;nimas de respeto a los dem&aacute;s y a las buenas costumbres, &eacute;stos ser&iacute;an borrados por el editor del blog, sin esperar su consentimiento.</p>

<h6>Seguridad de su informaci&oacute;n personal:</h6>

<p>Este sitio web se hace responsable de velar por su seguridad, por la privacidad de su informaci&oacute;n y por el respeto a sus datos, de acuerdo con las limitaciones que la actual Internet nos provee, siendo conscientes que no estamos exclu&iacute;dos de sufrir alg&uacute;n ataque por parte de crackers o usuarios malintencionados que ejerzan la delincuencia inform&aacute;tica.</p>

<h6>Obtenci&oacute;n de su informaci&oacute;n:</h6>

<p>Todos sus datos personales consignados en este sitio son suministrados por usted mismo, haciendo uso entero de su libertad. La informaci&oacute;n aqui almacenada solo comprende datos b&aacute;sicos ingresados mediante formularios de contacto, comentarios u otros similares.</p>

<h6>Uso de la informaci&oacute;n:</h6>

<p>Al proporcionarnos sus datos personales, estando de acuerdo con la Pol&iacute;tica de Privacidad aqu&iacute; consignada, nos autoriza para el siguiente uso de su informaci&oacute;n: a) para el fin mismo por lo cual se ha suministrado; b) para considerarlo dentro de nuestras estad&iacute;sticas de tr&aacute;fico, incrementando as&iacute; nuestra oferta publicitaria y de mercado; c) para orientar mejor los servicios aqu&iacute; ofrecidos y valorarlos a su criterio, y d) para enviar e-mails con nuestros boletines, responder inquietudes o comentarios, y mantener informado a nuestros usuarios.</p>

<h6>Uso de los cookies:</h6>

<p>El uso de cookies y su direcci&oacute;n IP, tomados por este sitio, se realiza solo con la finalidad de mantenerles un sitio de acuerdo a sus preferencias locales (tales como navegador web usado, sistema operativo, ISP, etc.). Las &quot;cookies&quot; permiten entregar un contenido ajustado a los intereses y necesidades de nuestros usuarios/visitantes. Tambi&eacute;n podr&iacute;an usarse cookies de Terceros que est&eacute;n presentes en este Weblog, como anunciantes o publicidad del mismo, con el &uacute;nico fin de proveer informaciones adicionales o reelevantes a la Navegaci&oacute;n del Usuario en este Sitio Web.</p>

<p>Modificaciones a nuestras Pol&iacute;ticas de Privacidad:</p>

<p>El sitio web se reserva el derecho de modificar, rectificar, alterar, agregar o eliminar cualquier punto del presente escrito en cualquier momento y sin previo aviso, siendo su responsabilidad el mantenerse informado del mismo para una adecuada administraci&oacute;n de su informaci&oacute;n.</p>
', 99002)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5656, 3, N'Terminos y condiciones', 154)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5657, 3, N'            <p>&Uacute;ltima actualizaci&oacute;n: 28 de septiembre 2015</p>

            <p>Por favor, lea estos t&eacute;rminos y condiciones (&quot;T&eacute;rminos&quot;, &quot;T&eacute;rminos y Condiciones&quot;) antes de utilizar el sitio web www.agrorobots.net (el &quot;Servicio&quot;) operado por Agrorobots (&quot;nosotros&quot;, &quot;nosotros&quot; o &quot;nuestro&quot;) .</p>

            <p>Su acceso y uso del Servicio est&aacute; condicionado a la aceptaci&oacute;n y cumplimiento de las presentes Condiciones. Estas Condiciones se aplican a todos los visitantes, usuarios y otras personas que accedan o usen el servicio.</p>

            <p>Al acceder o utilizar el Servicio, usted acepta que quedar&aacute; vinculado por estas Condiciones. Si no est&aacute; de acuerdo con alguna parte de los t&eacute;rminos, entonces no puede acceder al Servicio.</p>

            <h6>Cuentas</h6>

            <p>Al crear una cuenta con nosotros, debe proporcionar informaci&oacute;n que sea precisa, completa y actualizada en todo momento. El no hacerlo constituye una violaci&oacute;n de los t&eacute;rminos, que pueden resultar en la terminaci&oacute;n inmediata de su cuenta en nuestro servicio.</p>

            <p>Usted es responsable de salvaguardar la contrase&ntilde;a que utiliza para acceder al Servicio y para cualquier actividad o acciones bajo su contrase&ntilde;a, si su contrase&ntilde;a es con nuestro servicio o de un servicio de terceros.</p>

            <p>Usted se compromete a no revelar su contrase&ntilde;a a terceros. Usted debe notificarnos inmediatamente despu&eacute;s de haber tenido conocimiento de cualquier violaci&oacute;n de seguridad o uso no autorizado de su cuenta.</p>

            <h6>Enlaces a otros sitios Web Site</h6>

            <p>Nuestro Servicio puede contener enlaces a sitios web de terceros o servicios que no son propiedad o est&aacute;n controladas por Agrorobots.</p>

            <p>Agrorobots no tiene control sobre, y no asume ninguna responsabilidad por el contenido, pol&iacute;ticas de privacidad o las pr&aacute;cticas de sitios web o servicios de terceros. Adem&aacute;s, usted reconoce y acepta que Agrorobots no ser&aacute; responsable o estar&aacute; obligado, directa o indirectamente, por cualquier da&ntilde;o o p&eacute;rdida causada o supuestamente causada por o en conexi&oacute;n con el uso o la credibilidad en cualquier Contenido, bienes o servicios disponibles en oa trav&eacute;s de cualquiera de tales sitios o servicios web.</p>

            <p>Le aconsejamos que lea los t&eacute;rminos y condiciones y las pol&iacute;ticas de privacidad de los sitios Web de terceros o servicios que usted visite.</p>

            <h6>Terminaci&oacute;n</h6>

            <p>Podemos cancelar o suspender el acceso a nuestro servicio de inmediato, sin previo aviso o responsabilidad, por cualquier motivo, incluyendo, sin limitaci&oacute;n, si usted no cumple con las condiciones.</p>

            <p>Todas las disposiciones de los T&eacute;rminos que por su naturaleza deber&iacute;an sobrevivir terminaci&oacute;n, sobrevivir&aacute;n la terminaci&oacute;n, incluyendo, sin limitaci&oacute;n, las disposiciones de propiedad, renuncias de garant&iacute;a, indemnizaci&oacute;n y limitaciones de responsabilidad.</p>

            <p>Podemos cancelar o suspender su cuenta inmediatamente, sin previo aviso o responsabilidad, por cualquier motivo, incluyendo, sin limitaci&oacute;n, si usted no cumple con las condiciones.</p>

            <p>A la terminaci&oacute;n, su derecho a utilizar el Servicio cesar&aacute; inmediatamente. Si desea cancelar su cuenta, usted puede simplemente dejar de utilizar el Servicio.</p>

            <p>Todas las disposiciones de los T&eacute;rminos que por su naturaleza deber&iacute;an sobrevivir terminaci&oacute;n, sobrevivir&aacute;n la terminaci&oacute;n, incluyendo, sin limitaci&oacute;n, las disposiciones de propiedad, renuncias de garant&iacute;a, indemnizaci&oacute;n y limitaciones de responsabilidad.</p>

            <h6>Ley que rige</h6>

            <p>Estos T&eacute;rminos se regir&aacute;n e interpretar&aacute;n de acuerdo con las leyes de Argentina, sin consideraci&oacute;n a su conflicto de disposiciones legales.</p>

            <p>Nuestra incapacidad para hacer cumplir cualquier derecho o disposici&oacute;n de estas Condiciones no se considerar&aacute; una renuncia a esos derechos. Si alguna disposici&oacute;n de estos T&eacute;rminos es considerada inv&aacute;lida o inaplicable por un tribunal, las restantes disposiciones de estas Condiciones permanecer&aacute;n vigentes. Estos T&eacute;rminos y Condiciones constituyen el acuerdo completo entre nosotros en relaci&oacute;n con nuestro Servicio, y sustituyen y reemplazan cualquier acuerdo anterior, tengamos entre nosotros en relaci&oacute;n con el Servicio.</p>

            <h6>Cambios</h6>

            <p>Nos reservamos el derecho, a nuestra sola discreci&oacute;n, de modificar o sustituir estas Condiciones en cualquier momento. Si la revisi&oacute;n es el material vamos a tratar de proporcionar por lo menos 30 d&iacute;as de antelaci&oacute;n antes de las nuevas condiciones que surtan efecto. Lo que constituye un cambio material ser&aacute; determinado a nuestra discreci&oacute;n.</p>

            <p>Al continuar accediendo o utilizar nuestro servicio despu&eacute;s de esas revisiones se hacen efectivos, usted acepta que quedar&aacute; vinculado por los t&eacute;rminos revisados. Si no acepta los nuevos t&eacute;rminos, por favor, deje de usar el Servicio.</p>

            <p>Nuestra T&eacute;rminos y Condiciones Acuerdo fue creado por TermsFeed.</p>

            <h6>Cont&aacute;ctenos</h6>

            <p>Si usted tiene alguna pregunta acerca de estos T&eacute;rminos, por favor p&oacute;ngase en contacto con nosotros.</p>
', 99001)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5658, 3, N'Estoy de acuerdo con los', 155)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5659, 3, N'y las', 156)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5660, 3, N'Debe aceptar para proceder', 157)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5661, 3, N'Formato de Email invalido', 158)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5662, 3, N'            <h6>Situacion Actual</h6>

            <p>Agrorobots es una empresa joven ubicada en la Ciudad de Buenos Aires formada con entusiasmo, determinaci&oacute;n y enfocada en satisfacer al cliente. Estamos formados por profesionales capacitados para brindar todo el apoyo necesario para una experiencia &uacute;nica con el producto. </p>

            <h6>Motivacion</h6>

            <p>Ante la creciente demanda de alimentos sanos, que nos ayuden a conservar nuestra salud y de los cuales podamos confiar en su proceso de cultivo hasta la llegada a nuestra mesa, mucha gente se opone a los cultivos masivos, con desinfectantes nocivos, el uso de transg&eacute;nicos y qu&iacute;micos, buscando en el mercado otras fuentes que les provean productos de origen m&aacute;s natural y sin tratamientos qu&iacute;micos que los adulteren. Una forma de lograr esto es cultivar nuestros propios alimentos de una forma sencilla, que requiera poco espacio.</p>

            <h6>Solucion brindada</h6>

            <p>Agrorobots es la soluci&oacute;n en monitoreo que ayuda a al control de los cultivos hidrop&oacute;nicos, facilitando el proceso con un seguimiento en tiempo real y la posibilidad de controlar diversos aparatos el&eacute;ctricos (actuadores y sensores) que intervienen en el cultivo as&iacute; asegurar un &oacute;ptimo ambiente de forma constante.</p>

            <p>Nosotros ofrecemos un producto innovador &uacute;nico en el mercado sumado a una excelente asistencia post-venta para guiar al cliente en su uso e instalaci&oacute;n.  De esta forma brindamos una experiencia satisfactoria en cada consumidor, para que este pueda aprovechar y utilizar el producto de la forma m&aacute;s eficiente.</p>

            <h6>Factores principales de &eacute;xito del negocio</h6>

            <p>&bull; Contamos con personal calificado en nuestro rubro y la experiencia necesaria para acompa&ntilde;ar al cliente en sus inquietudes. Brindamos el asesoramiento para asegurar que cada cliente quede satisfecho.</p>

            <p>&bull; Nuestro producto se adapta a cada situaci&oacute;n y/o lugar que nuestros clientes puedan requerir. Desde lugares peque&ntilde;os como un monoambiente hasta patios o galpones. </p>

            <p>&bull; El clima no es un inconveniente de ning&uacute;n tipo, ya que con nuestro producto se podr&aacute; lograr el ambiente &oacute;ptimo durante todo el a&ntilde;o.</p>

            <p>&bull; Apuntamos a un mercado incipiente, en crecimiento que a&uacute;n no est&aacute; explotado, ni tiene grandes avances tecnol&oacute;gicos. </p>
', 99003)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5663, 3, N'Imagen', 2)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5664, 3, N'Codigo', 1)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5853, 2, N'Test', 0)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5854, 1, N'Prueba', 0)
INSERT [dbo].[Idioma_Control] ([ID], [Idioma_ID], [Traduccion], [Control_ID]) VALUES (5855, 3, N'Teste', 0)
SET IDENTITY_INSERT [dbo].[Idioma_Control] OFF
SET IDENTITY_INSERT [dbo].[Mensajes] ON 

INSERT [dbo].[Mensajes] ([ID], [Contenido], [UsuarioEmisor], [EmailEmisor], [RolEmisor], [UsuarioReceptor], [EmailReceptor], [RolReceptor], [Broadcast], [ID_Conversacion], [Leido], [Fecha]) VALUES (1, N'Hola, necesito asistencia para poder cambiar el curso en el que me anote, como procedo? ', 11, N'mural@scvsoft.com', 0, 0, N'', 41, 0, 0, 0, CAST(N'2015-09-19 18:23:38.063' AS DateTime))
INSERT [dbo].[Mensajes] ([ID], [Contenido], [UsuarioEmisor], [EmailEmisor], [RolEmisor], [UsuarioReceptor], [EmailReceptor], [RolReceptor], [Broadcast], [ID_Conversacion], [Leido], [Fecha]) VALUES (2, N'Pasame los datos del curso al que queres anotarte ', 0, N'', 41, 11, N'', 41, 0, 0, 0, CAST(N'2015-09-19 19:50:07.737' AS DateTime))
INSERT [dbo].[Mensajes] ([ID], [Contenido], [UsuarioEmisor], [EmailEmisor], [RolEmisor], [UsuarioReceptor], [EmailReceptor], [RolReceptor], [Broadcast], [ID_Conversacion], [Leido], [Fecha]) VALUES (7, N'hola dmin soy horatin', 15, N'mural@scvsoft.com', 0, 0, N'', 41, 0, 0, 0, CAST(N'2015-09-20 01:50:50.560' AS DateTime))
INSERT [dbo].[Mensajes] ([ID], [Contenido], [UsuarioEmisor], [EmailEmisor], [RolEmisor], [UsuarioReceptor], [EmailReceptor], [RolReceptor], [Broadcast], [ID_Conversacion], [Leido], [Fecha]) VALUES (12, N'hola Horacio, cual es tu consulta?', 0, N'', 41, 15, N'', 0, 0, 0, 0, CAST(N'2015-09-20 17:08:52.787' AS DateTime))
SET IDENTITY_INSERT [dbo].[Mensajes] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email], [Foto]) VALUES (2, 1, 1, N'Nistador', 1, N'Admi', N'21232F297A57A5A743894A0E4A801FC3', N'admin', 0, N'6239EE4872197746B7026F3A4DB0228E', N'mural@scvsoft.com', NULL)
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email], [Foto]) VALUES (11, 1, 0, N'Sgarlata', 1, N'Agus', N'81DC9BDB52D04DC20036DBD8313ED055', N'alumno', 0, N'5F586CCDDE677A2FFEC58CB02BC95589', N'mural@scvsoft.com', NULL)
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email], [Foto]) VALUES (15, 1, 0, N'Lopez', 1, N'Horacio', N'81DC9BDB52D04DC20036DBD8313ED055', N'profesor', 0, N'78CC4938CC40D5FD807B4FC324D80215', N'mural@scvsoft.com', NULL)
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email], [Foto]) VALUES (16, 1, 0, N'Lugo Uno', 1, N'Martin', N'81DC9BDB52D04DC20036DBD8313ED055', N'empleado', 0, N'36CB78763C92234D03D0AF2A7498DF3C', N'mural@scvsoft.com', 0x89504E470D0A1A0A0000000D4948445200000074000000740806000000549A16270000001974455874536F6674776172650041646F626520496D616765526561647971C9653C0000036869545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A7265537A4E54637A6B633964223F3E203C783A786D706D65746120786D6C6E733A783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F626520584D5020436F726520352E332D633031312036362E3134353636312C20323031322F30322F30362D31343A35363A32372020202020202020223E203C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E7323223E203C7264663A4465736372697074696F6E207264663A61626F75743D222220786D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F6D6D2F2220786D6C6E733A73745265663D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F73547970652F5265736F75726365526566232220786D6C6E733A786D703D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F2220786D704D4D3A4F726967696E616C446F63756D656E7449443D22786D702E6469643A32414437323042373039323036383131384331344533464442333743334134432220786D704D4D3A446F63756D656E7449443D22786D702E6469643A36443644313832323639444231314533413743364637353434423046343646442220786D704D4D3A496E7374616E636549443D22786D702E6969643A36443644313832313639444231314533413743364637353434423046343646442220786D703A43726561746F72546F6F6C3D2241646F62652050686F746F73686F702043533620284D6163696E746F736829223E203C786D704D4D3A4465726976656446726F6D2073745265663A696E7374616E636549443D22786D702E6969643A4639374631313734303732303638313138363835414137354242333234454445222073745265663A646F63756D656E7449443D22786D702E6469643A3241443732304237303932303638313138433134453346444233374333413443222F3E203C2F7264663A4465736372697074696F6E3E203C2F7264663A5244463E203C2F783A786D706D6574613E203C3F787061636B657420656E643D2272223F3ED8B0555400001AE24944415478DAEC5D097854D5F5BF992DCB4C56B227241008212B040244847FA5F007352E28A27C2AB4F2553FB5208885568A16FE6EB445A86C56A5D25A10102AB55123B20790A0942C903D2621FB9E4926C924B3FEEF79B98FBC0CB3BC37F3DE24C19CEF7B9925336FEEBBBF77D67BCEB92E46A3118DD29D432EA3808E023A4AA3808ED228A0A3340AE8285900D4C5C5657466462001960E033AD41CEED23F587AC022F25C44FFDBE4F1D6B04D1E0DE4B961E0B29C73617C32CF8803D46560603468E213274E04C6C7C727797878C44BA5D2F11289245224120589C5623FFC715F7C48F0212763EDC6874EAFD72B0D06431B7E6CECEBEBABD66834156D6D6D85595959792B57AE6C24C0C2A167808D8400F927072803440050949B9B1B131E1EBEC8DDDDFD2E994C968A810BE3F3F7743A5D9D5AADFEBEA3A3E30AFEAD930F3CF04009BC4D0E1A68DEC0E51B50EA8FE9C1F5247C1F8403692E94E6E7E74FEDECECFC339EEC72A393097370654343C37BE9E9E977E1B178E1C31DC6C410EF2E0E5EEB9D0B280344C937DF7C13D2DEDEFE0A1687578DC384BABBBB732A2B2B7FBF79F3E689788C9EF87085B1D2E08E026A06C8A2A2A2243C71FBB18EEB350E5382B1B5B4B41C3C7AF4E86C3C666F7CB8D90BEC1D052813C8C2C2C244ACBB8EE0F7F5C691437A6C4C7D71E8D02100D6C71E60EF1840099892D3A74F87618EFC08BFA7358E50C21CABC37AF6C0A64D9B62899EA581757136A0BC59B971672FB1FA7CE1CFE7508604763524172E5CF8958F8FCFDBF8F7BCEF04C71EBB41AAE2E2E2B767CD9AF5715757570F7EAB8FB83EC6D833178D2CE6C6614045CEBC6002A618BB03D1D9D9D9A77D7D7DF7DC2960026117CA332E2EEE9DDADADA2F77EEDC9980DF52E04306FF22D73EFC437F6C3894E64AB8B0D6D6D61518C81DF8373C8762D20B545D28CE53E10C6EEDCEC9C9F9434A4ACA3FF1CB6E7C686C71EB88E0501A4C6CEA2BB0AEDCE7E7E7B76FA8C0D4180CE8B3BA466771AB7CFAF4E9DBEAEAEAF6CE9C393310BFE541FC571721B955E4043045972E5D1ABB71E3C6731E1E1E2B8652245E686B47391D9D4EFDCD90909025D8F04BDFB061430C7E292722582414A82281C11463BF32393535F5A2542A4D1E6A1D97D1D882CA7BD4486B70EE828242A188DFB265CB7FF6EEDD7B17D1ABAE42E955919060969595CD8D8E8E3E251289C2ED3D574D6F2F2F636AD76AD1E99636A4C37AA6A8ABDBE937939B9B5BD0B3CF3E7BE8C08103F3195126DE41150905665555D5CFA3A2A2D231980E59B13BCBAB5095DA71508FD737A13E43FFEAD85565C79048088944E2B96CD9B2FD870F1F5E2414A82221C02C2D2D9D131E1EFE39BD6CE50885BAB9A2E772F3511BE6307BA9576F40FBAB6B6FBDCEC4BA940FEAD2E9519B86DBB8B0B1E4FED8638FBDFFF1C71FCF13025411DF60E6E7E74F9B3061C2177C800934C5CB93E2D0E7720B9052ABB3EB1C9FD4D4A156C6C4FF8039B4A1AFCFA171C1985EBC5E80BCA4127B2C608FE5CB977FB463C78E5426A8E8F685F8A10194AC598AB03517191313F36FFCD28BAF1B65A2DCE396FFF8CBECEBA8B14FC3E9FB37D56AF47E65F5A0F7C0263A52DB60F798CEB5B6A1C7AFE6A249723992D8B99E89C5AFFCF9E79FFFF0A5975E8A650420448E822AE2094C97D5AB57CBE7CE9D7B04DF7D21BC9AFD58E48AC8259674F7A065FFCD45B99D2A56DF556191B8E67AD12DDDC9A40335F583B8960DA9F57AF4566939FA755E21EAD4E9D0FF068C71D4500AC0FEF91E6C6B0CF2531D01958F24316A11BAABABEB23B95CBE5C086362D6852C0A9C5B77371EDFAFC747A09563C39054647EACDD78F261E2BFB76200CDF3F743BB136359CDDE596C21BF535A71CBEAF69488D1A539B3ECE650269597977F85D5D4CBF8692B892AC19D66188A4811A537EBEAEA7E2114984072F1603D05AEC77BE537D183DF5F4347EB1A07810DE214267FC90F3956C1A441DA5050827A0DE6E70ECE75BEB51D2DC7A2FED7D70B07B950293EDEBC80098439342D2323E32934B05263B73E758443293033333327CD9933274BC870DE4CCCA15D0CD04C09B834C2DD1DF949A5E8472C96B95AC460493F121C88E2BD141448CD5814E761B17EBEA5DDA2F1B41A4B8817C68DE5ED1A753A5DCFDAB56B9FD8B3674F367EA9448C951A2E1CEA08A022EC9AB86217E524D605770B052670CFB4F397D170A30FA7C4A3397E3EBC9EB3A9A9296FECD8B14F6B341A0838438C52C345F43A227229EEBC7AF5EAB3428209543C04511D3614E1EEC6FB3903030393D2D3D357A0816434CEA257642798A24F3EF924242020608BD01397D1D4322C01F5954A0539EF3DF7DCF3C2A2458BC6A1FE403E67FFD45E40A50F3DF4D01F4422918F9093066E0584EC7E4A2493C9E4EFBEFBEE1AD49F7C065C2AE102A8C41EEEC486509C9797D72F6C7D18820062FC0D7F998CF385C18AC8AB85A5D882E5161D72138B509C4281C67BB8A3702C167DA512E42A1251BEA8069FB3098FA952AD4665D878AAEC51DB3DF11D3A2DE5BA0841717171F7AD5AB5EAD0EEDDBB2F13E348478C239B061257A308385AA652A90E2A148A476D9D5C8FCFFD5A5119E584CFF71F4359919178926182AD110410361797A19C0E7601846057579416E44FF995899E9E167D53536AD66850567B07FA068BF50BD83DD17148DADA9930192D7030B0608DCACACA32A3A3A38153EBE1FE61632071B5722943E8D4A953C9F3E7CFCF622BAE01D4DF614EFBAAB1997A2DC6E79E80B96782DC0305B8CA90B744823CC4628A83EA7AFBA828105B43689AB7177A2E321C5B9BBE48E4A04B0841F683B5F5E8604D3D7503DAA2078202D09FE2260906286413AE59B3E697BB76EDBA44020E5DB6DC18AE8052DCD9DEDEBECFC7C7E729AEE2F3B9BC7C74A59D9F65AB287C43FC2E7A3C0524DF0411A68F6ED650AB33D616C2E1C6FC243911257B0B974D73E3C68D93898989BF255CAAB4C5A55CDC164A77EEDDBB37D4DBDB7B09D7818108DC99104BE9354708B8F05711E1E8F88C6441C0EC8F4A89D1DAA848F4D9F429289A2C0C58923CCFE39B14A24D42516C6CECCFE6CD9B17C1B0786D06EFD97228BCE15A5B5BFBDBD0D0D0CDF60E107423AC52680C9CC394C81B1B37DBE262D0DD7E821AD683831A7A03DA52F223FAA2C1BAA53DD3C71B3D1C128866F878A13037B741330ED7DA800D3130EEC06A8714180F6CB83D121CC44AD79F3C7972FFC2850BDFC34F1B882EEDB32476B9885C30E73CFAFAFAB2B1593DC191490251F6E7B24ACEA1B97D53E2D1380739DC2E5D060650F94DF40116C36CA588422C413262599B5AE92BC686A2F513C651229B0D611557EFE7E7F7047E5A4D74690FD1A5768B5C3A736F86A36002FD223C0C257AB1CF8B0DC286D3FEA9094302267DF16BB0085E372192D5E741ED8251D5A2D10C0213CEB37EE238F4BB89E359834905307C7D43366CD8908C181983D6C42E5B40A5D8845EC2C704C11DFC7214BBC9013FEF03CC99630508B37125D0DD4F86D9BFD4FB6A74147A66AC7DB5C90F3FFC3024968142878990F201A8041B43697C4D4EAAAF0F65A9DAA2372647A349560C1367D3ABD8B2067DC9959E1F37163D1D6EFFCD101F1F0FA92A0AC42882B21750CAF73C76ECD8242C6E23F99C1C5BABFD4F8405A385023AEEF61088CA3F62DFD353C23EC0767FA03F7A697C8443BF8B992970D9B2651349285086ACC477D970A83825256521DF9333496139872C402643AF448D43C39140A7AF89620710A88A2D9327F2F2BB4B972EBDCB0450BB3914C46D2ADF1303D1214BF43236401402C549F9A0274283518CC27652E346AC37E5627EAE232626269EA14725F67228555DEDE1E13183EF4969B290BD0777F5834101683813885E08395AA31958D7FE6C0C7FC18F888888490450191AA812E70CA8F88D37DE08C6FA3398EF4939DDD26AF67DB004C523A093D9A2007F14EE66D9FA5E1A1AC4EBEF797A7AFAA4A6A606918891D492D815D9F23F172C5890C8F76440B82CB3F5F6EC7570C6EF0FF2472381C0FD82E890350EE59BD2D2D2262193CE2B9C01F5F7F78FE3735059ED4A2AD3CE1CFD0F16515E12091A29644D35784BF9BF0EAC4723191CCA19504AE4CAE5725ECC4D58B9D853594D9534C08A8639BACB776455E7435E51989BABD9FFD5AA7B79FFBD90909020A243ED12B9542F3D77777787721521DBFCB3BA0674FF95FFA23D155556179167F9FAA0914696C69C4ED67FF9A48080804086512436879FC45650412A9506D9CB917FBD594D951CB04923812C86C86110E2E34A9696D8A0402A0D8BE4681E235D601811EE94580A2ED8E250914422E16C7B83C1F3E8D51CAA48886D4E10882FF108ECD36B698D1796DE565F2F74B8CA8D4958FD2918808AB872282280B25E923FD1D442E94948C0E22C4E5C65682452A0957143C9E1B2FFE6A1BFC44F465379C86C70737373B3266E5959B9D6C24CB7F96681FEE8FF6226A2C743833967C4F115517136D91A3704509ECECEA30A9DECAD6FBD05888B8B9801A65D56AE0B14A772F951B81337C74C406766CFA01672C7C8D82524DBCA041CAEC4A66009D648FF8975EAC2ACABE82FE53739D7B8DEF2D36532993530D970A88B2377EE331161E844EA7456D11F6BC548C399D41CD269E01A3FBC5983165CBE4A55B34112B91D5C2B6260C39943A123568F23170C417858A93F302DD1A2CF06A4D2EB4624A05C13C1A939C5AE1B44CBB69655A08D85A5ACB32135986C4A0C5B1F8066937C5C38F44A38382D09ADCCB941254ADDEE88F78D4840AB390410809D12BC1454D2F9DC31BE28462EE7944F6C30D816073601D5E9742A6CE9F2D21C0F2C4228C37BE487EC4145BA4060DEF7E8F55697D58623B129A70003715958087A2C24C8A1749ADE5EDB4D9BAC895CAA9642ABD52AF99C00C8E05B6761F13A8F65EF84E144799D5D16FF077643BF1D9142E551399A1BD5D5459514D0BB5498AD75B1A5438DF8A6E03D86F54848A0594ECC6AEF1851604234EC6A4787456904D98A60E9FBF014A8EFE8A01A151A18A072E650834AA5AAE57B2260992C4A7E7B8445C82C7421E88A524945846E17B112F48FE40494E2E3C5EBEF353636C204E9AD816A8B430D4AA5B25AA8BBDB944ABB7B50E130ADD83647FFB650BBBA0E8BD74877FEF388ABABAB415AEA18A072E250EA2EA8ACAC2CE57B6060FCDCB4604C38D210CA990489D467CC4814286F78285898149AFCFCFC06646653202E22577FFCF8F102BE07F66D73ABC55632C71B1AED8EA43893FE5E5D67F61AA0B6C55D204BFDD4A95337517F051ACDA546AE1CAA3F70E040139F861114EF7C5059635514EFADAC1AD660C20D77C8822451EB8589788141949D9DDD6E0228270E45E44BDA9696963CBE06B6BBA29AEABF678D8ED535B2AEDE1E0A7ABBB4DC227050152E04A8A5A5A53477C2A1B54787D2DB2F6AB132BEC6C7A040E7FCADCA761517FCF0A6A252C1EE7647E8EBA61674B2B9D5B258C383BFD4A6E4FD777373732B20B680067A2E7016B934A03AAC47331D77C055E83705C5ACDB6241787073F18FC30ACC0A3CA63F1495D9FCDCA7021876870F1FBE4EC0EC6370E86DD369AB3E143C6258990DEAEAEA3A2397CB43EC05F3D9DC02BB02D97CB760B397A007C393D7F25877D786727DBEFCD0D6D6D6767F7FFF4D704F91033A8DA908A70E70208BFA5003F992A6A2A2E2BC3D83B988C5CFCA9C7CBBC004DA555145E5250D29985A2DB5A8C0A5553A547EF3B559C1E5CB97F389B8ED6118456675A8AD9894917CB9F7C489135F2724242CE36466635DB3A1B00445797850AB2D501A18E9E146F5C0852A67F0D920485F83270AB8F83F8DCD54F34573460814D102A73A3BEBA8B6B70F4B977CCE3D8DE03A7656DC44AF4C18C787B8CD2660F6106075C842E8CF96C8A58A7D517FEFB9E0CECECE0C4F4F4F563B3C4039FAF7ED1D28D9DB8B53E1D1E7F58D18C00A2AF8604AB0ECF476EC444EE57C8E10B456FD7D61A9DDFDEE61F276264EA6C66D2F353535B5060505410BBE4A226E414177123D6AE42A728DC49A023657E7E4E47CC976209052026B7E5CABC81E0D09427B1263CD6638403DCCE21F72A816E14212A807E85CFD625E81439B17C0E4AD2F284137545DF65BD55F7F7D9570269C448D185B6ED9C3A1B4250CEB3EBEF7DD775F7C3A26B1582C788A1E944B7C692559F99E317E54D9219F79AF10F4F8BCBE09EDA9ACB2D9BE1CD63897878752DDC426609502EA032A02202458A4EA467918C4EFB0FD004DB4A08FEFDF93136EF5CF674B5AAD56979494F45651515121E14E5828692762F7361DCAB60B8A0BD1B594D82D2C2CDC3679F2E47B850614727B9FCFB31E7584D5FEB97EBEE8B1D020EA516667A219743083D63587B1BBD16C3BCB83CA21FE786A02B5B66B8B60E11E3A8A5E6C55A2DF4F8A62D58A80A673E7CE65CF9B376F1F11B73719E2D6AC0EE5DCD6061F63D6AE5D7BF7F6EDDBFFE9E2226C5634244FCDBE7885F5E7A13868B6AF0F9AE5EB8D12B10136DEDD9D6AE468297407B9C3B0210FACC18241C6D61E0555F2AF19533901734B1FE2DF0D64997F0CADE1D2D2D2DECBC8C8C826DCC9AAAD0DA7C653A8BFE567704949C9AEE8E8E8B9427369E2B9EFA8842A7B0D12983C58488703CE03221144698F031128D0F16FF254666F8DAE5CB9929F9A9AFA21E1CC4AC4B2F1141719A523B2BB6BC78E1D1FB2495872943CC4F6E7EA1A09274274271FEB33D8EF0C12BA7A1C0C273ECE7321AF59E71FD3EBAFBF7E9288D70E6210F59A0612CCAA210EF363207747F7FBEFBF9F7FE3C68D13425E1470946A98E5EA82088F77C266B267CE9CC9F9F6DB6F41CC2A09A0F486B216534FB8023A28C80077CEEAD5ABFFAAD168044B2FE0BA498E33082C6AA10BAAD46A75DF8B2FBE98418054122EED35E777F201A88116BB999999555F7DF5D5DF85BAB04A1B4B6C6ED83881C6C7CE2CA1F013A8CF3C933EF8E08353A5A5A50D044C2543DC1AD800CA35E4427329CC76C7E38F3FFE596565E5CFC3C2C262F9BEB002D5EDCCEF2793A2A5D828B937D01F734B7F9232844B6173BA77CB2BD18D4E6E0E3C705BAC424E459EEAB17B612BBC277484AAB8B8B8FA95575EB9407CCD36C2A56A6BA13E3E00351079DEA5D3E95A5F7EF9E53F1D3870E07D994CC66BB52E736B6570DA9F8B08472B23C26E4BEF0050C155F9745A125556F025CBCA69D878079A3232DD08F0470FD5D653CB5FCE5E8BEDEDEDD53CF3CC33FFC2F6100D661BE14E0D5BEEE42A72CD72E9D1A347F38F1C39F221AF569E115224FBF35D8183A01931EC75662D5707AAC0DE898DA6C0B5158C7803BB1D6FE1CF9AFA8410288060FAD7B3A699ED31D4A913AEFE067B0EDF5CBE7CB992F89A2DF670A72380EA698B17C4C38A152B3ECFC9C939CFD7C5DD50A9508756871EC25C74687A12ABAE5DB4087D7372B455BDFAEAC428B424C4BAEB01EDDFF626C5A10D26AD501D89EB5AA3B367CFE66DDCB8F11203CC7632B79CB7CBB2D7A2A04155132BACF5DE7BEFDDD6D0D050C1C705C25ED9503AB0157311D7701E54B83D69A1F325C47F9F62D9151360FCE5D8506AF7423AE2A4D1F3EF7A631BA471F1E2C5C789886D26A07692B9E504A6238032452FC5A58D8D8D752B57AE7C53A552399C500313FF6CA4DDFBB0534098B6FF06AEDD38693CE77381E88592066828D9CA3387B6B7B7772D59B2E4D3CECECE26026633833B755CC1E403507A690D94775B464646C1BA75EBDEECEBEB73A8498FA33B2DC0E42F3059838400BEB5566ED60816E73F4B9982C660B7852F3D8A8DA0BEE5CB977F7AEDDAB59B04C846134348EF6C4099A0F6D2A277DFBE7DDF637DF0B656AB1DD282CF3446972FD0832BEDEC26CDD4AB7FC39CFA63B7DAE1B1E11B5E8BA5D961ECC717E3974D04CC564610C12E30F90094061564510F1117CDDBB76FBFF8FAEBAF6F1B4A50612B48BAC20D5ACE85B058EAB245D02F02B8D551305F78E18523870E1DBA41C06C208FED640EB5F682C90BA0C6FEE51A53509BB66EDD7A76FDFAF57FC417A01E0A40C198BA8B74F95A1C1CC8DB791DD9C109C27AD8D73CB47FFFFE5CC295F516C0343A02C86D873DDF47030BE1E063403B5668D8BB00BB341B954A65BB7108E8F3BA46E3CCCC2C639F5E6F1C6A6A6D6DEDBCFFFEFB3FC273F21B7CC0F6D60BC81C059339E3B40BA1252C780334F6CC45535043C880E7DF7DF7DDAB6A6A6AAA9C3D8935EA5EE36F0B4A861CCCF2F2F286A4A4A4BFE0B958878FA7614EC8DC84F005268D05AF916D0C2A33E8D049147DFDA54B97F2A74D9BB6E9CA952B59CE14BBC1D89099E337B40D21CF9C39733D3939795F5E5E5E3911B1B5E4913682A8E001993BC75502DF176002AA8A06B5A9A9A922353575FBEEDDBBFF81F5AA538C25B06E1F18A276E7109B7DEBADB7BE9A3F7FFE671D1D1D7504C41A06982ABEC11404500BA0B6106BAE7AF5EAD5C7172F5EBCA5A2A2A21CDDA1545C5C5C8381DCB769D3A60BE4BA812BABC9F316A1C0A4741EC70D61CD2B624B27EF3F11DC34B0900849669039E807BEBF582C0EDCBB776F1A369A1E264D09473C81158BAFE9DC860D1BB20C06839280474780DA8888A5AD5903E8573E73EDB8EE1FCA195006A874063E0007391CB09401A11CFFC4C4C4C85DBB763D3677EEDC5922D1C86CF8073940274F9ECC5BB56AD599B2B2327047946820D0DE4A5EAB1023F3C048BB06230D501350C1D39711CBCE8B000BBB06F83DF8E08331AFBDF6DA432929294942A788F23881C6EFBEFBAE048FFBDCD9B367AB0807D2EB99F4AA09CD95B7564E8C8C491B91809A002B2666BA3B01D69B886100D7372D2D2D1A8BAC85B367CF4E964886E78E025AAD567FFEFCF9FCAD5BB75E3E7DFA7435E1BE0E022033DB0082ECF49AA6DE6866B24634A066B8D59500AB20C0FAD047424242E8FAF5EBE72C5AB468665050D0B0D804ADA1A1A12D3D3D3D6FDBB66DD74A4A4AE87DB13BD140FE0F9DA547D7A198E5CA3B0A500BDC2A6300EB45C0A50FC5534F3D15F3E4934F4E9F3973669CBFBFBFAF33416C6E6E56623FBAF4E0C183378E1D3B564980EA26A075308E4E34B8A0C82257DE91809A70AB8800EB460E39035C4F72C06B0FEC0E842F5DBA347EEAD4A9E3626262227C7C7C78DDD55CA95476151414D45CBB76ADFAE8D1A3A59999990D84D3D468A00A4C450E1AC46E62F0D0C9D0066B5C79C7026A055857022CAD67E50C90E568605337D7F8F878BF79F3E68D9D32654A707878B85F7070B02F0659AE50283CE472B9AB184AE564FD6DB5351A8D568FA9BBBBBB4FA552A93178DDF5F5F5CAEAEA6A656E6E6E23366CEA8A8A8A3AD140B7913E345039DDCD00AF9BA11F7BD1E0CE24AC80BCA301B502AC9488633706C0EE04500FF29C065FCA38CCF566A72F8A5ECDA03B71E9C9A125DCA54103DD4668AEEC21CFD50C4ED430BEC319C89F04A026C02206205286AEA501961130E983FE9F29A8E6765060024983A935E14CFAD03000A475A396714320A3039330EC00750231FBAB8B19869484019E84F1481F220698A6176464804A3706D131C0D23140A6DFA7C1B7D8AB7618F8C52302505370111ABC0589E92353D49A8A5B6441EC3239D660E6D1C8F8DE700E748C3840AD71306200283273039802CA7C34300046C395037F2A808ED228A0A3808ED20801F4FF0518001F15371947742D570000000049454E44AE426082)
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email], [Foto]) VALUES (17, 0, 0, N'Garcia', 1, N'Marcelo', N'81DC9BDB52D04DC20036DBD8313ED055', N'director', 3, N'C1E94C5242AFC0F5CFA9D40C910B939E', N'mural@scvsoft.com', NULL)
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email], [Foto]) VALUES (2025, 1, 0, N'Gonzales', 1, N'Facundo', N'81DC9BDB52D04DC20036DBD8313ED055', N'facu', 0, N'FD2C66071825DA728D6C1FAD8EE9AA64', N'mural@scvsoft.com', 0x89504E470D0A1A0A0000000D49484452000000300000003008060000005702F98700000624494441546843ED585B6C145518FE76B733BD2C945EA48456A9A506122072E9B680D45222981AE20D0C140D200F46490CC6F866A2BE9A68C2133E984834F0446A000BC6445002456E91502884A550566C29E552E976B7DBCEECECF89F33D7BD143BDD2DA4662799ECCECE9E73BEDB7FCE997161921FAE498E1FFF2F02738FB4A993C111FFEA7A53F83807B2041E937D59071E93D0A30E937520EB409A0A642394A6806937CF3A90B68469769075204D01D36E9E510766E48A9837750ABC1E0FEECB123A822184A24A32C8580C9024C045FBC7DC5CEB7E340AB07BA2386662192130778A171F55CFC2CAD262781828FD1852141CE8BD875D376FE181249BBFBBBBBB21ECD90395C00F6FDF0EA1B3139EF3E7E1EAEB0354156A713194F9F3A1D4D5FD2799B409AC9E5E82AFE7CF459EC70D8900B7F7DD4570780455C545984D273B7AE8FAFD0B57703D3CC4AF4D02A474B4BC1C4220905271B5AC0C72733354AF7762F642CF790BB0AFF6791450648E7405F0C5B113E81E0CF168B8E86CA87C065FAE6A4039C52A3014C19B672F20A2C44C0206AAE88C3248F3E641292A826B640462D74D887E3F772336670EE4F5EB2786C0871565A82F9A06FF837E7CFAFB714469400E9E3D9DB224D1F76A7261FFBAD75048F5F1556700DFDDEA892310AD28C7507D3D400E6AEDB4B642E775E49D39CB818F6CD9025454A424915684E43BBD88F6F7F331B581F917130473815D7F5CBB183B962C847F6010AF9F6B87BBA787D7003BC26B5F418C326FB6633FEA75E43D74186EEA5F5ABE0C6AC34ACA9E3B8984230239ADAD705187E641998FE6E521E25B6282E7A0791D5B446A28222DAF364121876A7E3E0AE9FE03AD88A906421B379880B5B6FA24409FB9A74E41B8EA87B47811A22FAC80A7B0303D02E2EEDDDA4C613B94E94F21BCAA310EB001DE70660EC5E89737D6F256B53FB622341886B8772F54221F6EDEA8F56603AEC59026A0D3A7215CBE0279C962483E1F3C530BE14A98621D3910EBE8402C38A00BAC29A50A0294D25233F3F6FC1B449AA898BF695C8120CDFDBE7D07E10E8591DBD202359F086CDA6412D02267911199031D9721D7D440AAF5C14511F2144EB3C8D25F9D11088721F7DD3133DEF074394AF3F2D1150CE2221572528E09909BCE1F5E6AC08A993370F8AF6EEC3879069EBBF7907FE81011C8C7D03B6FC7AB6F4C00F429FE7112C2A50EC8A4BE5C57CBFB778902DCF90566061C1160D39A74BB075068C5A4CEDEA5F9FFF3BA1AAEEC7BBFB5E11C01B3E7D84D8A7DB270013EA0FFC5A8EDFA5F8FE152FF4378288679AD3A81CD9B6D35C3B8582E886D6DC8B9780932A92F2F5DAA83265188B82B27875F3B23400D14525BA118B19CE610C06F57D5A3B1622664DA02B4DC08E0684F2F0668D5AD2A9C820DD5CFC24735C28E5D57FCD8D971957FE7040EFEA439B075AB358B69F9310989274E10818B5CFDE8D26516511AD74DF5C31A3A26A012D0288B919ED50252E233DF22BC35BB92C725F118A2FDCDCECB7E7C7FAD0BAA7E9B13D87F8013886CDB16E7804180D59270FC3872DADB097C1DE465CBE3EA8339E0A2FA734C80F5A20C0C20361CE10A18962F2829C6BAAA59585052042F757E9FB60F7F525DB404FE466F64D83638B5190C422065554124602C1A7A3F067F5D08CFF51B70DFBE8D58652594AA2ABD0FE383DA30022F37387FB5A8CA329487FFE8C56C9F392CFBCDC54D77CA1C5D5F23ACACC7C7C65A43ECBF738A710E180BE7B5A646E704B80B54072ADB2A9B809890A68449B1D06ED91739FDDA4ED05C0447016C6BA20F80711350A511C4688316AF9841422362ADCA89E412D57C04E014A00DA158FFE38A104747D3A212A29D278CB7F0563D181B392B36C980355C2962F108C0A6285AC75C3CFF9A71D480D15EA5F99F9D49B9356211179BCC0036C63622E45FF3E2F86AC0702116A11825E6585767CC0ADBDA9BC51DE744D28539E6B8A6514B050A1073813DC71AC56C8E953A36867256C1DB575F7BCF2940A75867D226C01EC2D9B41AB79B7498E3C45898D7290027524C9F002B63F636C156CC4681196A8F391663003C2104B80B3C46B6E9D336538CAAB0BD7612918DF13A230EF0B1188194B596B03F1A87CA8FE2923902EC819EC76862014F4C848C5EF5B71263743F237FCB9C031981E3BC93510938EFEAC9B7487E1A79F2981C2198F404FE059D90724FC8BEFE630000000049454E44AE426082)
INSERT [dbo].[Usuario] ([ID], [Activo], [Admin], [Apellido], [Idioma_ID], [Nombre], [Password], [UserName], [Intentos], [DigitoH], [Email], [Foto]) VALUES (3030, 1, 0, N'mera', 1, N'diego ', N'81DC9BDB52D04DC20036DBD8313ED055', N'gomera', 0, N'85C551DFBA712B4137F8930C1645BDE0', N'mural@scvsoft.com', NULL)
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
/****** Object:  Index [UQ_Usuario_UserName]    Script Date: 29/09/2015 18:36:14 ******/
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
