Imports EE
Imports MPP

Public Class ExamenBase_Business
    Inherits Business(Of ExamenBase)

    Dim examenBusiness As New Examen_Business

    Sub New()
        Me.mapperGenerico = New ExamenBase_Mapper
    End Sub

    Function ListarPorElementoAcademico(codigoAcademico As Integer, filtrarActivos As Boolean) As List(Of ExamenBase)
        Dim listaExamenes As New List(Of ExamenBase)
        For Each examen In Listar()
            If examen.IdElementoAcademico = codigoAcademico Then
                If filtrarActivos Then
                    If examen.Activo Then
                        listaExamenes.Add(examen)
                    End If
                Else
                    listaExamenes.Add(examen)
                End If
            End If
        Next
        Return listaExamenes
    End Function

    Function ListarPorElementoAcademicoNoRendidos(codigoAcademico As Integer, idAlumno As Integer) As List(Of ExamenBase)
        Dim listaExamenes As New List(Of ExamenBase)
        For Each examenBase In ListarPorElementoAcademico(codigoAcademico, True)
            Dim rendido = False
            For Each examenRendido In examenBusiness.ListarPorElementoAcademicoYAlumno(codigoAcademico, idAlumno)
                If examenRendido.IdExamenBase = examenBase.ID Then
                    rendido = True
                    Exit For
                End If
            Next
            If Not rendido Then
                listaExamenes.Add(examenBase)
            End If
        Next
        Return listaExamenes
    End Function

End Class