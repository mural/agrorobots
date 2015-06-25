Imports DTO
Imports Business

Public Class Carrito
    Inherits System.Web.UI.Page

    'Pagina que simula un carrito de compras

    Dim libs As New Producto_Business
    Dim libros As List(Of Producto) = libs.ObtenerProductos
    Dim comboI As String = "<SELECT NAME='cantidad"
    Dim comboF As String = "'> <OPTION VALUE='0'>0</OPTION><OPTION VALUE='1'>1</OPTION> <OPTION VALUE='2'>2</OPTION> <OPTION VALUE='3'>3</OPTION> </SELECT> "

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load




        Dim tabla As String = "<table border=1 >"

        tabla += "<tr bgcolor=lightblue>"
        tabla += "<td colspan=3>"
        tabla += "<b><p style='font-family:Arial; font-size:x-large;'>Carrito de Compras</p></b>"
        tabla += "</td>"
        tabla += "</tr>"

        tabla += "<tr>"
        tabla += "<td>"
        tabla += "<b>Descripcion</b>"
        tabla += "</td>"
        tabla += "<td>"
        tabla += "<b>Precio</b>"
        tabla += "</td>"
        tabla += "<td>"
        tabla += "<b>Seleccione Cantidad</b>"
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
            tabla += "<td>"
            tabla += comboI & i.ToString & comboF
            tabla += "</td>"
            tabla += "</tr>"
            i += 1
        Next

        tabla += "</table>"

        ltlTabla.Text = tabla

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        Dim compra As String = "Total: $"
        Dim cantidad1 As Integer = Decimal.Parse("0" & Request.Form("cantidad1"))
        Dim cantidad2 As Integer = Decimal.Parse("0" & Request.Form("cantidad2"))
        Dim cantidad3 As Integer = Decimal.Parse("0" & Request.Form("cantidad3"))
        If (cantidad1 = 0 And cantidad2 = 0 And cantidad3 = 0) Then

            Label2.Text = "Debe seleccionar la cantidad de al menos 1 libro."

        Else
            Dim total = cantidad1 * libros.Item(0).Valor + cantidad2 * libros.Item(1).Valor + cantidad3 * libros.Item(2).Valor

            compra += total.ToString
            Label2.Text = compra

        End If

        
        Label2.Visible = True
    End Sub
End Class