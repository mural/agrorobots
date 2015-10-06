Imports EE
Imports MPP

Public Class FichaEncuesta_Business
    Inherits Business(Of FichaEncuesta)

    Sub New()
        Me.mapper = New FichaEncuesta_Mapper
    End Sub

End Class
