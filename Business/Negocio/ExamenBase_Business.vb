Imports EE
Imports MPP

Public Class ExamenBase_Business
    Inherits Business(Of ExamenBase)

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

End Class