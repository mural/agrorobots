Imports EE
Imports MPP

Public Class Newsletter_Business
    Inherits Business(Of Newsletter)

    Sub New()
        Me.mapperGenerico = New Newsletter_Mapper
    End Sub

    Public Function Desuscribir(ByVal email As String) As Boolean
        Dim newsletterBorrar As Newsletter = Nothing
        For Each newsletter In mapperGenerico.Listar
            If newsletter.Email.Equals(email, StringComparison.InvariantCultureIgnoreCase) Then
                newsletterBorrar = newsletter
                Exit For
            End If
        Next
        If newsletterBorrar Is Nothing Then
            Throw New Exception("no existe email para el newsletter a desuscribir")
        End If
        Return mapperGenerico.Borrar(newsletterBorrar.ID)
    End Function
End Class
