Imports EE
Imports MPP

Public Class CtaCteUsuario_Business
    Inherits Business(Of CtaCteItemUsuario)

    Sub New()
        Me.mapper = New CtaCteUsuario_Mapper
    End Sub


End Class
