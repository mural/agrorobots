Imports EE
Imports MPP

Public Class CtaCteUsuario_Business
    Inherits Business(Of CtaCteItemUsuario)

    Dim mapperPropio As New CtaCteUsuario_Mapper

    Sub New()
        Me.mapperGenerico = New CtaCteUsuario_Mapper
    End Sub

    Function ListarPorUsuario(idUsuario As Integer) As Object
        Return mapperPropio.ListarPorUsuario(idUsuario)
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
