Imports EE
Imports MPP

Public Class Comentarios_Business
    Inherits Business(Of Comentario)

    Dim comentariosMapper As New Comentarios_Mapper

    Sub New()
        Me.mapperGenerico = New Comentarios_Mapper
    End Sub

    Function ListarPorElementoAcademico(codigoAcademico As Integer) As List(Of Comentario)
        Dim listaComentarios As New List(Of Comentario)
        For Each comentario In Listar()
            If comentario.IdElementoAcademico = codigoAcademico Then
                listaComentarios.Add(comentario)
            End If
        Next
        Return listaComentarios
    End Function

End Class