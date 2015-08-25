USE [agrorobots]
GO
/****** Object:  StoredProcedure [dbo].[AsignarCompAFam]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[AssignPermissionToUser]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[CleanFamily]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[CreateBackUp]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[CreateEvaluacion]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateEvaluacion]
(
 @id_empleado as int,
 @fecha as date,
 @completada as bit,
 @objetivos as bit,
 @id_evaluador as int,
 @nombre_evaluado as varchar(50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Empleado_Evaluacion]
           ([ID_Empleado]
           ,[Fecha]
           ,[Completada]
           ,[Objetivos]
           ,[ID_Evaluador]
           ,[NombreEvaluado])
     VALUES
           (@id_empleado
           ,@fecha
           ,@completada
           ,@objetivos
           ,@id_evaluador
           ,@nombre_evaluado)
END


GO
/****** Object:  StoredProcedure [dbo].[CreateIdioma]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[CreateObjetivo]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateObjetivo]
(
 @id_empleado as int,
 @descripcion as varchar(50),
 @cumplido as bit,
 @fecha as date,
 @motivo as varchar(50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Empleado_Objetivos]
           ([ID_Empleado]
           ,[Descripcion]
           ,[Cumplido]
           ,[Fecha]
           ,[Motivo])
     VALUES
           (@id_empleado
           ,@descripcion
           ,@cumplido
           ,@fecha
           ,@motivo)
END


GO
/****** Object:  StoredProcedure [dbo].[CreateTraduccion]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteComponente]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteIdioma]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteObjetivo]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteObjetivo]
(
 @id as int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [Empleado_Objetivos]
      WHERE ID_Objetivo = @id
END


GO
/****** Object:  StoredProcedure [dbo].[DeleteTraduccion]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[GetAllCandidatos]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllCandidatos]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1000 c.[ID]
      ,[ID_Perfil]
      ,[Nombre]
      ,[Apellido]
      ,[Email]
  FROM [Candidatos] c
  INNER JOIN [Perfiles] p
  ON c.ID_PERFIL = p.ID
END


GO
/****** Object:  StoredProcedure [dbo].[GetAllCapacidades]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Agustin Sgarlata
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllCapacidades]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT c.ID, c.Descripcion
	FROM Capacidades c
END


GO
/****** Object:  StoredProcedure [dbo].[GetAllCargos]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllCargos] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1000 [ID_Cargo]
      ,[Descripcion]
      ,[Valor]
  FROM [agrorobots].[Cargos]
END


GO
/****** Object:  StoredProcedure [dbo].[GetAllComponents]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetAllComponents]
as
select c.ID, c.Nombre, c.Descripcion, c.Control_ID, c.URL from componente c


GO
/****** Object:  StoredProcedure [dbo].[GetAllDigits]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[GetAllDigits]
as
select Tabla, DigitoV from DigitoV




GO
/****** Object:  StoredProcedure [dbo].[GetAllEmpleados]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllEmpleados]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT TOP 1000 e.[ID]
      ,[sueldo]
      ,[fecha_ingreso]
      ,[fecha_ascenso]
      ,[ID_Perfil]
      ,[Nombre]
      ,[Apellido]
      ,[Email]
      ,[Descripcion]
      ,[Valor]
      ,[ID_Equipo]
  FROM [Empleados] e
  INNER JOIN [Perfiles] p ON e.ID_Perfil = p.ID 
  INNER JOIN [Cargos] c ON p.ID = c.ID_Cargo
END


GO
/****** Object:  StoredProcedure [dbo].[GetAllEvaluaciones]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllEvaluaciones]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		SELECT TOP 1000 [ID_Evaluacion]
      ,[Fecha]
      ,[Completada]
      ,[Objetivos]
      ,[ID_Evaluador]
      ,[NombreEvaluado] 
      ,[ID_Empleado] as ID_Evaluado
  FROM [Empleado_Evaluacion]
END


GO
/****** Object:  StoredProcedure [dbo].[GetAllFamilies]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetAllFamilies]
as
select ID, Nombre, Descripcion from componente 
where Control_ID is null


GO
/****** Object:  StoredProcedure [dbo].[GetAllIdioms]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[GetAllIdioms]
as
select i.ID, i.Nombre from idioma i
order by Nombre


GO
/****** Object:  StoredProcedure [dbo].[GetAllNiveles]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllNiveles]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT n.ID, n.Nombre
	FROM Niveles n
END


GO
/****** Object:  StoredProcedure [dbo].[GetAllProductos]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllProductos] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1000 [ID]
      ,[Descripcion]
      ,[Valor]
  FROM [agrorobots].[Productos]
END


GO
/****** Object:  StoredProcedure [dbo].[GetAllProvincias]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetAllProvincias]
as
select ID, Nombre from provincia 
where Baja_Activo=1
order by Nombre


GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetAllUsers]
as
select ID, Apellido, Nombre, UserName, Activo, Admin, Idioma_Id, Password, Intentos from usuario
order by UserName



GO
/****** Object:  StoredProcedure [dbo].[GetCapacidadesPorPerfil]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[GetComponentsByFamily]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[GetComponentsByUsu]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[GetEvaluacionEmpleado]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEvaluacionEmpleado]
(
 @id_empleado as int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1000 [ID_Evaluacion]
      ,[Fecha]
      ,[Completada]
      ,[Objetivos]
      ,[ID_Evaluador]
      ,[NombreEvaluado] 
      ,[ID_Empleado] as ID_Evaluado
  FROM [Empleado_Evaluacion]
  WHERE ID_Empleado = @id_empleado
END


GO
/****** Object:  StoredProcedure [dbo].[GetEvaluacionPorEvaluador]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEvaluacionPorEvaluador]
(
 @id_evaluador as int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		SELECT TOP 1000 [ID_Evaluacion]
      ,[Fecha]
      ,[Completada]
      ,[Objetivos]
      ,[NombreEvaluado]
      ,[ID_Empleado] as ID_Evaluado
  FROM [Empleado_Evaluacion]
  WHERE ID_Evaluador = @id_evaluador
END


GO
/****** Object:  StoredProcedure [dbo].[GetItemsBitacora]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetItemsBitacora]
as
select * from bitacora
order by FechaHora desc


GO
/****** Object:  StoredProcedure [dbo].[GetNivelesDeCapacidades]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetNivelesDeCapacidades]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1000 
      [Descripcion]
      ,CAST( AVG (CAST(nivel as decimal(5,2))) as decimal(5,2)) as Promedio
  FROM [Capacidad_Perfil] cp
  INNER JOIN [Capacidades] c ON cp.ID_Capacidad = c.ID
  GROUP BY [Descripcion]
END


GO
/****** Object:  StoredProcedure [dbo].[GetObjetivosPorEmpleado]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetObjetivosPorEmpleado]
(
  @id_empleado as int	
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1000 [ID_Empleado]
      ,[ID_Objetivo]
      ,[Descripcion]
      ,[Cumplido]
      ,[Fecha]
      ,[Motivo]
  FROM [Empleado_Objetivos]
  WHERE ID_Empleado = @id_empleado 
END


GO
/****** Object:  StoredProcedure [dbo].[GetRow4DH]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTable4DV]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTranslationsByForm]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTranslationsByIdiom]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserByUserName]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[LogInBitagora]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[NewFamilia]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[NewUser]    Script Date: 25/08/2015 18:33:51 ******/
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
@UserName varchar(50)
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
Intentos
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
0
);

SELECT @@IDENTITY AS 'Identity';


GO
/****** Object:  StoredProcedure [dbo].[RemoveAllComponentesFromUsu]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[SetDHToRow]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[SetDVbyTable]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateEvaluacion]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEvaluacion]
(
 @id as int, 
 @fecha as date, 
 @completada as bit, 
 @objetivos as bit
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Empleado_Evaluacion]
   SET [Fecha] = @fecha
      ,[Completada] = @completada
      ,[Objetivos] = @objetivos
 WHERE ID_Evaluacion = @id
END


GO
/****** Object:  StoredProcedure [dbo].[UpdateFamilia]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateIdioma]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateObjetivo]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateObjetivo]
(
 @id as int,
 @descripcion as varchar(50),
 @cumplido as bit,
 @fecha as date,
 @motivo as varchar(50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Empleado_Objetivos]
   SET [Descripcion] = @descripcion
      ,[Cumplido] = @cumplido
      ,[Fecha] = @fecha
      ,[Motivo] = @motivo
 WHERE ID_Objetivo = @id
END


GO
/****** Object:  StoredProcedure [dbo].[UpdateTraduccionByID]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateUserByUsuOrId]    Script Date: 25/08/2015 18:33:51 ******/
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
@Intentos int
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
Intentos = @Intentos
where
ID = @ID


GO
/****** Object:  StoredProcedure [dbo].[UpdateUserPassword]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  Table [dbo].[Candidatos]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Candidatos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_Perfil] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Capacidad_Perfil]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Capacidad_Perfil](
	[ID_Perfil] [int] NOT NULL,
	[ID_Capacidad] [int] NOT NULL,
	[nivel] [int] NULL,
 CONSTRAINT [PK_Capacidad_Perfil_1] PRIMARY KEY CLUSTERED 
(
	[ID_Perfil] ASC,
	[ID_Capacidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Capacidades]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Capacidades](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Componente]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  Table [dbo].[Componente_Parent]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  Table [dbo].[Control]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  Table [dbo].[DigitoV]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  Table [dbo].[Empleado_Evaluacion]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado_Evaluacion](
	[ID_Empleado] [int] NOT NULL,
	[ID_Evaluacion] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NULL,
	[Completada] [bit] NULL,
	[Objetivos] [bit] NULL,
	[ID_Evaluador] [int] NULL,
	[NombreEvaluado] [varchar](50) NULL,
 CONSTRAINT [PK_Empleado_Evaluacion] PRIMARY KEY CLUSTERED 
(
	[ID_Evaluacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empleado_Objetivos]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado_Objetivos](
	[ID_Empleado] [int] NOT NULL,
	[ID_Objetivo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Cumplido] [bit] NULL,
	[Fecha] [date] NULL,
	[Motivo] [varchar](50) NULL,
 CONSTRAINT [PK_Empleado_Objetivos] PRIMARY KEY CLUSTERED 
(
	[ID_Objetivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[ID] [int] NOT NULL,
	[sueldo] [float] NULL,
	[fecha_ingreso] [date] NULL,
	[ID_Perfil] [int] NOT NULL,
	[ID_Equipo] [int] NULL,
	[fecha_ascenso] [date] NULL,
 CONSTRAINT [PK_Empleados] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Equipos]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipos](
	[ID_Equipo] [int] IDENTITY(1,1) NOT NULL,
	[ID_Proyecto] [int] NULL,
 CONSTRAINT [PK_Equipos] PRIMARY KEY CLUSTERED 
(
	[ID_Equipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Formulario]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  Table [dbo].[Idioma]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  Table [dbo].[Idioma_Control]    Script Date: 25/08/2015 18:33:51 ******/
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
/****** Object:  Table [dbo].[Niveles]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Niveles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ObraSocial] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Perfiles]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Perfiles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[ID_Cargo] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 25/08/2015 18:33:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Productos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Valor] [numeric](18, 0) NULL,
	[DigitoH] [varchar](1050) NULL,
 CONSTRAINT [PK_Cargos] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 25/08/2015 18:33:51 ******/
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
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Usuario_UserName] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario_Componente]    Script Date: 25/08/2015 18:33:51 ******/
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
