Imports EE
Imports MPP

Public Class Novedades_Business
    Inherits Business(Of Novedades)

    Sub New()
        Me.mapper = New Novedades_Mapper
    End Sub

End Class
