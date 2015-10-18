Imports EE
Imports MPP

Public Class CategoriaTema_Business
    Inherits Business(Of CategoriaTema)

    Sub New()
        Me.mapperGenerico = New CategoriaTema_Mapper
    End Sub
End Class
