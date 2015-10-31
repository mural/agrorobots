Imports EE
Imports MPP

Public Class ExamenRespuesta_Business
    Inherits Business(Of ExamenRespuesta)

    Sub New()
        Me.mapperGenerico = New ExamenRespuesta_Mapper
    End Sub

    Public Function ObtenerPorPregunta(idPregunta As Integer) As String
        For Each respuesta In mapperGenerico.Listar()
            If respuesta.IdPregunta = idPregunta Then
                Return respuesta.Respuesta
            End If
        Next
        Return ""
    End Function

End Class
