Imports EE
Imports MPP

Public Class FichaEncuestaRespuesta_Business
    Inherits Business(Of FichaEncuestaRespuesta)

    Sub New()
        Me.mapperGenerico = New FichaEncuestaRespuesta_Mapper
    End Sub

End Class
