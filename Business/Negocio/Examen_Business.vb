Imports EE
Imports MPP

Public Class Examen_Business
    Inherits Business(Of Examen)

    Sub New()
        Me.mapperGenerico = New Examen_Mapper
    End Sub

End Class