Imports EE
Imports MPP

Public Class ElementoAcademico_Business
    Inherits Business(Of ElementoAcademico)

    Sub New()
        Me.mapper = New ElementoAcademico_Mapper
    End Sub

End Class
