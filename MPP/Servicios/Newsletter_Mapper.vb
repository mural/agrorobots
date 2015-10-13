Imports EE

Public Class Newsletter_Mapper
    Inherits Mapper(Of Newsletter)

    Dim newsletterCategoriaTemaMapper As New Newsletter_CategoriaTema_Mapper

    Public Overrides Function Insertar(ByRef obj As Newsletter) As Boolean
        Preparar()

        Me.Transaccion = AccionTransaccion.Iniciar
        Dim resultado = Actualizar(obj, True)
        Dim idNewsletter = oDatos.RespuestaEscritura

        If resultado Then 'si salio bien la escritura anterior
            newsletterCategoriaTemaMapper.Transaccion = AccionTransaccion.Continuar
            For i = 0 To obj.Temas.Count - 1
                Dim tema As CategoriaTema = obj.Temas(i)
                If i = obj.Temas.Count - 1 Then
                    newsletterCategoriaTemaMapper.Transaccion = AccionTransaccion.Cerrar
                End If
                resultado = newsletterCategoriaTemaMapper.Insertar(New Newsletter_CategoriaTema With {.IDNewsletter = idNewsletter, .IDCategoria = tema.ID})
            Next
        End If

        Return resultado
    End Function

    Public Overloads Overrides Function Actualizar(ByRef obj As Newsletter, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "NewsletterActualizar") 'no se usa
    End Function

    Public Overloads Overrides Function Borrar(idNewsletter As Integer) As Boolean
        newsletterCategoriaTemaMapper.Transaccion = AccionTransaccion.Iniciar
        Dim resultado = newsletterCategoriaTemaMapper.Borrar(idNewsletter)

        Me.Transaccion = AccionTransaccion.Cerrar
        If resultado Then 'si salio bien la escritura anterior
            Return Borrar(idNewsletter, "NewsletterBorrar")
        Else
            Return resultado
        End If
    End Function

    Public Overrides Sub DSaEE(ByRef obj As Newsletter, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        obj.Email = CStr(Item("Email"))
        obj.Nombre = CStr(Item("Nombre"))
        obj.IDIdioma = CInt(Item("IDIdioma"))
    End Sub

    Public Overloads Overrides Function Listar() As List(Of Newsletter)
        Return Listar("NewsletterListar")
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As Newsletter, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@Email", obj.Email)
        hdatos.Add("@Nombre", obj.Nombre)
        hdatos.Add("@IDIdioma", obj.IDIdioma)
    End Sub

    Public Overloads Overrides Function Obtener(ByVal id As Integer) As Newsletter
        Return Obtener(0, "NewsletterObtener")
    End Function
End Class
