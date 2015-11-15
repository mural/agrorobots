Imports EE
Imports MPP

Public Class ComprobanteNota_Business
    Inherits Business(Of ComprobanteNota)

    Dim ctateUsuarioBusiness As New CtaCteUsuario_Business

    Sub New()
        Me.mapperGenerico = New ComprobanteNota_Mapper
    End Sub

    Function ListarNotasDeCreditoNoSaldadasPorUsuario(idUsuario As Integer) As List(Of ComprobanteNota)
        Dim notasDeCredito As New List(Of ComprobanteNota)
        For Each notaDeCredito In Listar()
            Try
                If notaDeCredito.IdUsuario = idUsuario And notaDeCredito.Tipo = 2 And ctateUsuarioBusiness.ObtenerPorUsuarioYComprobante(idUsuario, notaDeCredito.ID).Estado.Equals("EMITIDA") Then
                    notasDeCredito.Add(notaDeCredito)
                End If
            Catch ex As Exception
                ex.ToString()
            End Try
        Next
        Return notasDeCredito
    End Function


End Class
