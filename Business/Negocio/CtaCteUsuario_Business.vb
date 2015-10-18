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


End Class
