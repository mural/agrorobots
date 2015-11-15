Imports EE
Imports MPP

Public Class CtaCteUsuario_Business
    Inherits Business(Of CtaCteItemUsuario)

    Dim mapperPropio As New CtaCteUsuario_Mapper

    Sub New()
        Me.mapperGenerico = New CtaCteUsuario_Mapper
    End Sub

    Function ListarPorUsuario(idUsuario As Integer) As List(Of CtaCteItemUsuario)
        Return mapperPropio.ListarPorUsuario(idUsuario)
    End Function

    Function ObtenerPorUsuarioYComprobante(idUsuario As Integer, idComprobante As Integer) As CtaCteItemUsuario
        For Each ctacte In ListarPorUsuario(idUsuario)
            If ctacte.IdComprobante = idComprobante Then
                Return ctacte
            End If
        Next
        Return Nothing
    End Function

    Function ListarPorFacturasNoPagas() As List(Of CtaCteItemUsuario)
        Dim listaCtaCte As New List(Of CtaCteItemUsuario)
        For Each ctaCteItemUsuario In Listar()
            If ctaCteItemUsuario.Tipo = 1 And ctaCteItemUsuario.Estado = "NO_PAGO" Then
                listaCtaCte.Add(ctaCteItemUsuario)
            End If
        Next
        Return listaCtaCte
    End Function


End Class
