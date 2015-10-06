Imports EE
Imports MPP

Public Class FichaEncuestaPregunta_Business
    Inherits Business(Of FichaEncuestaPregunta)

    Sub New()
        Me.mapper = New FichaEncuestaPregunta_Mapper
    End Sub

End Class
