Imports EE
Imports MPP
Imports EE.ElementoAcademico

Public Class ElementoAcademico_Business
    Inherits Business(Of ElementoAcademico)

    Dim alumnoElementoAcademicoMapper As New AlumnoElementoAcademico_Mapper

    Sub New()
        Me.mapperGenerico = New ElementoAcademico_Mapper
    End Sub

    Public Shadows Function ListarPorEstado(ByVal estado As ElementoAcademicoEnum, Optional ByVal incluirRechazados As Boolean = False) As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each elementoAcademico In mapperGenerico.Listar()
            If elementoAcademico.EstadoActual = estado Then
                elementosAcademicos.Add(elementoAcademico)
            End If
            If incluirRechazados And elementoAcademico.EstadoActual = ElementoAcademicoEnum.ConContenidoRechazado Then
                elementosAcademicos.Add(elementoAcademico)
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

    Public Function ObtenerPorUsuario(ByVal idUsuario As Integer) As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each alumnoElementoAcademico In alumnoElementoAcademicoMapper.Listar()
            If alumnoElementoAcademico.IdAlumno = idUsuario Then
                elementosAcademicos.Add(Obtener(alumnoElementoAcademico.IdElementoAcademico))
            End If
        Next
        Return elementosAcademicos
    End Function

End Class
