Imports EE
Imports MPP

Public Class FichaEncuestaBase_Business
    Inherits Business(Of FichaEncuestaBase)

    Sub New()
        Me.mapper = New FichaEncuestaBase_Mapper
    End Sub

End Class
