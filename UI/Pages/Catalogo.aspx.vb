
Imports EE
Imports Business

Public Class Catalogo
    Inherits System.Web.UI.Page

    'Pagina que simula un carrito de compras

    Dim libs As New Producto_Business
    Dim libros As List(Of Producto) = libs.ObtenerProductos
    Dim comboI As String = "<SELECT NAME='cantidad"
    Dim comboF As String = "'> <OPTION VALUE='0'>0</OPTION><OPTION VALUE='1'>1</OPTION> <OPTION VALUE='2'>2</OPTION> <OPTION VALUE='3'>3</OPTION> </SELECT> "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load




        Dim tabla As String = "<table border=1 >"

        tabla += "<tr bgcolor=lightblue>"
        tabla += "<td colspan=2>"
        tabla += "<b><p style='font-family:Arial; font-size:x-large;'>Catalogo de Libros</p></b>"
        tabla += "</td>"
        tabla += "</tr>"

        tabla += "<tr>"
        tabla += "<td>"
        tabla += "<b>Descripcion</b>"
        tabla += "</td>"
        tabla += "<td>"
        tabla += "<b>Precio</b>"
        tabla += "</td>"
        tabla += "</tr>"

        Dim i = 1
        For Each libro As Producto In libros
            tabla += "<tr>"
            tabla += "<td>"
            tabla += libro.Descripcion
            tabla += "</td>"
            tabla += "<td>"
            tabla += "$" + libro.Valor.ToString
            tabla += "</td>"
            tabla += "</tr>"
            i += 1
        Next

        tabla += "</table>"

        ltlTabla.Text = tabla




    End Sub

End Class