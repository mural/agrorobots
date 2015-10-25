Imports EE
Imports MPP

Public Class ExamenRespuesta_Business
    Inherits Business(Of ExamenRespuesta)

    Sub New()
        Me.mapperGenerico = New ExamenRespuesta_Mapper
    End Sub

End Class
