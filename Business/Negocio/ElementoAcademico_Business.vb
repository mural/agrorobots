﻿Imports EE
Imports MPP
Imports EE.ElementoAcademico

Public Class ElementoAcademico_Business
    Inherits Business(Of ElementoAcademico)

    Dim usuarioMapper As New Usuario_Data
    Dim alumnoElementoAcademicoMapper As New AlumnoElementoAcademico_Mapper
    Dim profesorElementoAcademicoMapper As New ProfesorElementoAcademico_Mapper

    Sub New()
        Me.mapperGenerico = New ElementoAcademico_Mapper
    End Sub

    Public Overrides Function Listar() As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each elementoAcademico In mapperGenerico.Listar()
            Dim profesorElementoAcademico = ObtenerProfesorElementoAcademico(elementoAcademico.CodigoAcademico)
            If Not profesorElementoAcademico Is Nothing Then
                elementoAcademico.Profesor = usuarioMapper.ConsultarPorId(profesorElementoAcademico.IdProfesor)
            End If
            elementosAcademicos.Add(elementoAcademico)
        Next
        Return elementosAcademicos
    End Function

    Public Shadows Function ListarPorEstado(ByVal estado As ElementoAcademicoEnum, Optional ByVal incluirRechazados As Boolean = False) As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each elementoAcademico In Listar()
            If elementoAcademico.EstadoActual = estado Then
                elementosAcademicos.Add(elementoAcademico)
            End If
            If incluirRechazados And elementoAcademico.EstadoActual = ElementoAcademicoEnum.ConContenidoRechazado Then
                elementosAcademicos.Add(elementoAcademico)
            End If
        Next
        Return elementosAcademicos
    End Function

    Public Shadows Function ListarPorEstadoAsignadosProfesor(ByVal idProfesor As ElementoAcademicoEnum) As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each elementoAcademico In ListarPorEstado(ElementoAcademicoEnum.SinContenido, True)
            If Not elementoAcademico.Profesor Is Nothing Then
                If elementoAcademico.Profesor.ID = idProfesor Then
                    elementosAcademicos.Add(elementoAcademico)
                End If
            End If
        Next
        Return elementosAcademicos
    End Function

    Public Sub Inscribir(idUsuario As Integer, idElementoAcademico As String)
        Dim alumnoElementoAcademico = New AlumnoElementoAcademico
        alumnoElementoAcademico.ID = 0
        alumnoElementoAcademico.IdAlumno = idUsuario
        alumnoElementoAcademico.IdElementoAcademico = idElementoAcademico
        alumnoElementoAcademicoMapper.Insertar(alumnoElementoAcademico)
    End Sub

    Public Function ObtenerPorAlumno(ByVal idUsuario As Integer) As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each alumnoElementoAcademico In alumnoElementoAcademicoMapper.Listar()
            If alumnoElementoAcademico.IdAlumno = idUsuario Then
                elementosAcademicos.Add(Obtener(alumnoElementoAcademico.IdElementoAcademico))
            End If
        Next
        Return elementosAcademicos
    End Function

    Public Function ObtenerPorProfesor(ByVal idUsuario As Integer) As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each profesorElementoAcademico In profesorElementoAcademicoMapper.Listar()
            If profesorElementoAcademico.IdProfesor = idUsuario Then
                elementosAcademicos.Add(Obtener(profesorElementoAcademico.IdElementoAcademico))
            End If
        Next
        Return elementosAcademicos
    End Function

    Public Function ObtenerProfesorElementoAcademico(ByVal codigoAcademico As Integer) As ProfesorElementoAcademico
        For Each profesorElementoAcademico In profesorElementoAcademicoMapper.Listar()
            If profesorElementoAcademico.IdElementoAcademico = codigoAcademico Then
                Return profesorElementoAcademico
            End If
        Next
        Return Nothing
    End Function

    Public Function ActualizarConProfesor(elementoAcademico As ElementoAcademico) As Boolean
        Dim profesorElementoAcademico = ObtenerProfesorElementoAcademico(elementoAcademico.CodigoAcademico)
        If profesorElementoAcademico Is Nothing Then
            CrearProfesorElementoAcademico(elementoAcademico)
        Else
            If elementoAcademico.Profesor Is Nothing Then
                profesorElementoAcademico.IdProfesor = 0
            Else
                profesorElementoAcademico.IdProfesor = elementoAcademico.Profesor.ID
            End If
            profesorElementoAcademico.IdElementoAcademico = elementoAcademico.CodigoAcademico
            profesorElementoAcademicoMapper.Actualizar(profesorElementoAcademico)
        End If
        Return Me.Actualizar(elementoAcademico)
    End Function

    Public Function CrearConProfesor(elementoAcademico As ElementoAcademico) As Boolean
        CrearProfesorElementoAcademico(elementoAcademico)
        Return Me.Crear(elementoAcademico)
    End Function

    Private Sub CrearProfesorElementoAcademico(elementoAcademico As ElementoAcademico)
        Dim profesor As New ProfesorElementoAcademico
        profesor.ID = 0
        profesor.IdElementoAcademico = elementoAcademico.CodigoAcademico
        profesor.IdProfesor = elementoAcademico.Profesor.ID
        profesorElementoAcademicoMapper.Insertar(profesor)
    End Sub

End Class
