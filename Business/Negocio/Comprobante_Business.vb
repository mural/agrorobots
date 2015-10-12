Imports EE
Imports MPP

Public Class Comprobante_Business
    Inherits Business(Of Comprobante)

    Sub New()
        Me.mapper = New Comprobante_Mapper
    End Sub


End Class
