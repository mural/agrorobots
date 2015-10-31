Imports EE
Imports MPP

Public Class Examen_Business
    Inherits Business(Of Examen)

    Dim examenBaseMapper As New ExamenBase_Mapper

    Sub New()
        Me.mapperGenerico = New Examen_Mapper
    End Sub

    Function ListarPorElementoAcademico(codigoAcademico As Integer, filtrarPorNoCorregios As Boolean) As List(Of Examen)
        Dim listaExamenes As New List(Of Examen)
        For Each examen In Listar()
            If examenBaseMapper.Obtener(examen.IdExamenBase).IdElementoAcademico = codigoAcademico Then
                If filtrarPorNoCorregios Then
                    If examen.Nota < 0 Then
                        listaExamenes.Add(examen)
                    End If
                Else
                    listaExamenes.Add(examen)
                End If
            End If
        Next
        Return listaExamenes
    End Function

    Function ListarPorElementoAcademicoYAlumno(codigoAcademico As Integer, idAlumno As Integer) As List(Of Examen)
        Dim listaExamenes As New List(Of Examen)
        For Each examen In Listar()
            If examenBaseMapper.Obtener(examen.IdExamenBase).IdElementoAcademico = codigoAcademico And examen.IdAlumno = idAlumno Then
                listaExamenes.Add(examen)
            End If
        Next
        Return listaExamenes
    End Function

End Class