Imports EE
Imports MPP

Public Class ComprobanteNota_Business
    Inherits Business(Of ComprobanteNota)

    Sub New()
        Me.mapperGenerico = New ComprobanteNota_Mapper
    End Sub

    Function ListarNotasDeCreditoPorUsuario(idUsuario As Integer) As List(Of ComprobanteNota)
        Dim notasDeCredito As New List(Of ComprobanteNota)
        For Each notaDeCredito In Listar()
            If notaDeCredito.IdUsuario = idUsuario And notaDeCredito.Tipo = 2 Then
                notasDeCredito.Add(notaDeCredito)
            End If
        Next
        Return notasDeCredito
    End Function


End Class
