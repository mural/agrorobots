Imports EE
Imports MPP

Public Class Foro_Business
    Inherits Business(Of Foro)

    Sub New()
        Me.mapperGenerico = New Foro_Mapper
    End Sub

    Function ListarPorElementoAcademico(codigoAcademico As Integer) As List(Of Foro)
        Dim listaItemForo As New List(Of Foro)
        For Each itemForo In Listar()
            If itemForo.IdElementoAcademico = codigoAcademico Then
                listaItemForo.Add(itemForo)
            End If
        Next
        Return listaItemForo
    End Function

End Class
