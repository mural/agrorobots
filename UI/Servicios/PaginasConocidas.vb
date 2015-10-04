﻿Public Class PaginasConocidas

    Public Shared ReadOnly DIR_FRONT As String = "/Front/"
    Public Shared ReadOnly DIR_PAGES As String = "/Pages/"
    Public Shared ReadOnly ASPX As String = ".aspx"

    'Cuenta y acceso
    Public Shared ReadOnly HOME As String = DIR_FRONT + "Home" + ASPX
    Public Shared ReadOnly LOGIN As String = "/Pantalla_Login" + ASPX
    Public Shared ReadOnly REGISTRO As String = DIR_FRONT + "Registracion" + ASPX
    Public Shared ReadOnly RECUPERAR_CLAVE As String = DIR_FRONT + "RecuperarClave" + ASPX
    Public Shared ReadOnly TERMINOS As String = DIR_FRONT + "Terminos" + ASPX
    Public Shared ReadOnly POLITICAS As String = DIR_FRONT + "Politicas" + ASPX

    'Acceso comun
    Public Shared ReadOnly INSTITUCIONAL As String = DIR_FRONT + "Institucional" + ASPX
    Public Shared ReadOnly BUSQUEDA As String = DIR_FRONT + "Busqueda" + ASPX
    Public Shared ReadOnly CONTACTO As String = DIR_FRONT + "Contacto" + ASPX
    Public Shared ReadOnly NOVEDADES As String = DIR_FRONT + "Novedades" + ASPX
    Public Shared ReadOnly NEWSLETTER As String = DIR_FRONT + "Newsletter" + ASPX

    'Acceso usuario
    Public Shared ReadOnly CAMBIAR_CLAVE As String = DIR_PAGES + "CambioClave" + ASPX
    Public Shared ReadOnly MENSAJES As String = DIR_PAGES + "Mensajes" + ASPX



End Class
