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

    Shared Function EsSoloLetras(ByVal strInputText As String) As Boolean
        If String.IsNullOrEmpty(strInputText) Then
            Return False
        End If

        Dim IsAlpha As Boolean = False
        If System.Text.RegularExpressions.Regex.IsMatch(strInputText, "^[a-zA-Z]+$") Then
            IsAlpha = True
        Else
            IsAlpha = False
        End If
        Return IsAlpha
    End Function

    Shared Function EsSoloNumeros(ByVal strInputText As String) As Boolean
        If String.IsNullOrEmpty(strInputText) Then
            Return False
        End If

        Dim IsAlpha As Boolean = False
        If System.Text.RegularExpressions.Regex.IsMatch(strInputText, "^[0-9]+$") Then
            IsAlpha = True
        Else
            IsAlpha = False
        End If
        Return IsAlpha
    End Function

    Shared Function EsAlfanumerico(ByVal strInputText As String) As Boolean
        If String.IsNullOrEmpty(strInputText) Then
            Return False
        End If

        Dim IsAlpha As Boolean = False
        If System.Text.RegularExpressions.Regex.IsMatch(strInputText, "^[a-zA-Z0-9]+$") Then
            IsAlpha = True
        Else
            IsAlpha = False
        End If
        Return IsAlpha
    End Function
End Class
