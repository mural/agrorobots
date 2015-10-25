Imports EE
Imports MPP

Public Class ExamenBase_Business
    Inherits Business(Of ExamenBase)

    Sub New()
        Me.mapperGenerico = New ExamenBase_Mapper
    End Sub

End Class