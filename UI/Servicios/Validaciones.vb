Imports Business.Idiomas

Public Class Validaciones

    Shared Function MinimaLongitud(ByRef args As ServerValidateEventArgs, ByRef customValidator As CustomValidator, cantidadMinima As Integer) As Boolean
        If args.Value.Length < cantidadMinima Then
            args.IsValid = False
            customValidator.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90042),
                                              IdiomManager.GetIdiomManager.GetTranslationById(customValidator.ID.Split("_")(1)),
                                              cantidadMinima)
        End If
        Return args.IsValid
    End Function

    'Validar siempre punto y coma(;) comilla simple(') guion doble(--) comentarios("/*)(*/")
End Class
