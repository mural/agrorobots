Imports EE
Imports MPP

Public Class MaterialDeEstudio_Business
    Inherits Business(Of MaterialDeEstudio)

    Sub New()
        Me.mapperGenerico = New MaterialDeEstudio_Mapper
    End Sub

End Class
