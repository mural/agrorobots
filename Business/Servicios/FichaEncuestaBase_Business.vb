Imports EE
Imports MPP

Public Class FichaEncuestaBase_Business
    Inherits Business(Of FichaEncuestaBase)

    Sub New()
        Me.mapperGenerico = New FichaEncuestaBase_Mapper
    End Sub

End Class
