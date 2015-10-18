Imports EE
Imports MPP

Public Class FichaEncuestaPregunta_Business
    Inherits Business(Of FichaEncuestaPregunta)

    Sub New()
        Me.mapperGenerico = New FichaEncuestaPregunta_Mapper
    End Sub

End Class
