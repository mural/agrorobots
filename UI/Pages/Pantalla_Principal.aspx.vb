Imports EE
Imports Business
Imports MigraDoc.DocumentObjectModel
Imports MigraDoc.DocumentObjectModel.Shapes
Imports MigraDoc.DocumentObjectModel.Tables
Imports MigraDoc.DocumentObjectModel.Color

Imports System.Xml.XPath
Imports MigraDoc.Rendering
Imports PdfSharp.Pdf

Public Class Pantalla_Principal
    Inherits PaginaAutorizada

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        userName.Text = usuario.Nombre + " " + usuario.Apellido

        inconsistencias.Text = ObtenerInconsistencias()
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub PopUpInconsistencias()
        If (Not Page.IsPostBack) Then
            If ObtenerInconsistencias() <> String.Empty Then
                Dim myBodyTag As HtmlGenericControl
                myBodyTag = Page.Master.FindControl("MasterPageBodyTag")
                myBodyTag.Attributes.Add("onload", "ObtenerIncosistencias();")

                Dim ClientScriptName As String = "Incosistencias"
                Dim PageType As Type = Me.GetType()

                ' Get a ClientScriptManager reference from the Page class.
                Dim csm As ClientScriptManager = Page.ClientScript

                ' Check to see if the client script is already registered.
                If (Not csm.IsClientScriptBlockRegistered(PageType, ClientScriptName)) Then
                    Dim ClientScriptText As New StringBuilder()
                    ClientScriptText.AppendLine("function ObtenerIncosistencias() {")
                    ClientScriptText.AppendLine(" alert('" & ObtenerInconsistencias() & "');")
                    ClientScriptText.AppendLine("}")
                    csm.RegisterClientScriptBlock(PageType, ClientScriptName, ClientScriptText.ToString(), True)
                End If
            End If
        End If
    End Sub

    Public Function ObtenerInconsistencias() As String
        If usuario.Admin = True Then
            'Inconsistencias.Visible = True
            'recalcular_710.Visible = True

            Dim dig As New Servicio_Digitos
            'Verifico si hubo un cambio por fuera del sistema
            Dim lst As List(Of String) = dig.VerificarDigitos()
            If lst.Count > 0 Then
                Dim errores As String = "Errores de datos: "
                For i = 0 To lst.Count - 1
                    'par son tabla
                    If (i Mod 2 = 0) Then
                        errores += "Tabla: "
                        errores += lst.Item(i)
                    Else 'impar son ID
                        errores += ", ID: "
                        errores += lst.Item(i)

                    End If
                Next
                Return errores
            End If
        End If
        Return String.Empty
    End Function


    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles recalcular_710.Click
        Dim servicio_DV As New Servicio_Digitos

        Dim usr As New Usuario_Business
        Dim users As List(Of Usuario) = usr.ObtenerUsuarios(False)
        For Each User As Usuario In users
            Try
                servicio_DV.CalcularDigitoH("ID=" & User.ID, "Usuario")
            Catch ex As Exception
            End Try
        Next

        Page_Load(sender, e)
    End Sub

    Protected Sub buscarsitio_104_Click(sender As Object, e As EventArgs) Handles buscarsitio_104.Click
        Try
            Dim resultados As New List(Of Patente)
            For Each patenteUsuario As Patente In usuario.GetOnlyPatentes
                Dim traducido = TraducirItem(patenteUsuario.Name)
                If traducido.ToLowerInvariant.Contains(txtBuscar.Text.ToLowerInvariant) Then
                    patenteUsuario.Display = traducido
                    resultados.Add(patenteUsuario)
                End If
            Next

            Me.GridView1_.DataSource = resultados
            Me.GridView1_.DataBind()
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub Selection(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkSelect As LinkButton = DirectCast(sender, LinkButton)

        Response.Redirect(lnkSelect.CommandArgument)

    End Sub

    Public Function TraducirItem(ByVal item As String) As String
        If item.Contains("_") Then
            Return idiomas.GetTranslationById(item.Split("_")(1))
        End If
        Return item
    End Function

    Protected Sub PDF_Click(sender As Object, e As EventArgs) Handles PDF.Click
        Dim filename = "factura.pdf"
        Dim virtualPath = "~/App_Data/" & filename

        CreateDocument()

        Dim pdfRenderer As New PdfDocumentRenderer(False, PdfFontEmbedding.Always)
        pdfRenderer.Document = document
        pdfRenderer.RenderDocument()
        pdfRenderer.PdfDocument.Save(Server.MapPath("~/App_Data/") + "factura.pdf")

        Try
            Response.ContentType = "application/pdf"
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename)
            Response.TransmitFile(Server.MapPath(virtualPath))
            Response.End()
        Catch

        End Try
    End Sub

    Dim document As New Document
    Public Function CreateDocument() As Document
        document.Info.Title = "Factura B"
        document.Info.Subject = "Factura de compra"
        document.Info.Author = "Agrorobots"
        DefineStyles()
        CreatePage()
        FillContent()
        Return document
    End Function


    Private Sub DefineStyles()
        ' Get the predefined style Normal.
        Dim style As Style = Me.document.Styles("Normal")
        ' Because all styles are derived from Normal, the next line changes the 
        ' font of the whole document. Or, more exactly, it changes the font of
        ' all styles and paragraphs that do not redefine the font.
        style.Font.Name = "Verdana"

        style = Me.document.Styles(StyleNames.Header)
        style.ParagraphFormat.AddTabStop("16cm", TabAlignment.Right)

        style = Me.document.Styles(StyleNames.Footer)
        style.ParagraphFormat.AddTabStop("8cm", TabAlignment.Center)

        ' Create a new style called Table based on style Normal
        style = Me.document.Styles.AddStyle("Table", "Normal")
        style.Font.Name = "Verdana"
        style.Font.Name = "Times New Roman"
        style.Font.Size = 9

        ' Create a new style called Reference based on style Normal
        style = Me.document.Styles.AddStyle("Reference", "Normal")
        style.ParagraphFormat.SpaceBefore = "5mm"
        style.ParagraphFormat.SpaceAfter = "5mm"
        style.ParagraphFormat.TabStops.AddTabStop("16cm", TabAlignment.Right)
    End Sub

    Dim image As MigraDoc.DocumentObjectModel.Shapes.Image
    Dim table As MigraDoc.DocumentObjectModel.Tables.Table
    Dim addressFrame As MigraDoc.DocumentObjectModel.Shapes.TextFrame
    Private Sub CreatePage()
        ' Each MigraDoc document needs at least one section.
        Dim section As Section = Me.document.AddSection()

        ' Put a logo in the header
        image = section.Headers.Primary.AddImage(Server.MapPath("~/App_Data/") + "logo.png")
        image.Height = "2.5cm"
        image.LockAspectRatio = True
        image.RelativeVertical = RelativeVertical.Line
        image.RelativeHorizontal = RelativeHorizontal.Margin
        image.Top = ShapePosition.Top
        image.Left = ShapePosition.Right
        image.WrapFormat.Style = WrapStyle.Through

        ' Create footer
        Dim paragraph As Paragraph = section.Footers.Primary.AddParagraph()
        paragraph.AddText("Agrorobots · Calle Falsa 123 · 1406 Buenos Aires · Argentina")
        paragraph.Format.Font.Size = 9
        paragraph.Format.Alignment = ParagraphAlignment.Center

        ' Create the text frame for the address
        Me.addressFrame = section.AddTextFrame()
        Me.addressFrame.Height = "3.0cm"
        Me.addressFrame.Width = "7.0cm"
        Me.addressFrame.Left = ShapePosition.Left
        Me.addressFrame.RelativeHorizontal = RelativeHorizontal.Margin
        Me.addressFrame.Top = "5.0cm"
        Me.addressFrame.RelativeVertical = RelativeVertical.Page

        ' Put sender in address frame
        paragraph = Me.addressFrame.AddParagraph("Agrorobots · Calle Falsa 123 · 1406 Buenos Aires")
        paragraph.Format.Font.Name = "Times New Roman"
        paragraph.Format.Font.Size = 7
        paragraph.Format.SpaceAfter = 3

        ' Add the print date field
        paragraph = section.AddParagraph()
        paragraph.Format.SpaceBefore = "8cm"
        paragraph.Style = "Reference"
        paragraph.AddFormattedText("FACTURA B", TextFormat.Bold)
        paragraph.AddTab()
        paragraph.AddText("Buenos Aires, ")
        paragraph.AddDateField("dd.MM.yyyy")

        ' Create the item table
        Me.table = section.AddTable()
        Me.table.Style = "Table"
        'Me.table.Borders.Color = TableBorder
        Me.table.Borders.Width = 0.25
        Me.table.Borders.Left.Width = 0.5
        Me.table.Borders.Right.Width = 0.5
        Me.table.Rows.LeftIndent = 0

        ' Before you can add a row, you must define the columns
        Dim column As Column = Me.table.AddColumn("1cm")
        column.Format.Alignment = ParagraphAlignment.Center

        column = Me.table.AddColumn("2.5cm")
        column.Format.Alignment = ParagraphAlignment.Right

        column = Me.table.AddColumn("3cm")
        column.Format.Alignment = ParagraphAlignment.Right

        column = Me.table.AddColumn("3.5cm")
        column.Format.Alignment = ParagraphAlignment.Right

        column = Me.table.AddColumn("2cm")
        column.Format.Alignment = ParagraphAlignment.Center

        column = Me.table.AddColumn("4cm")
        column.Format.Alignment = ParagraphAlignment.Right

        ' Create the header of the table
        Dim row As Row = table.AddRow()
        row.HeadingFormat = True
        row.Format.Alignment = ParagraphAlignment.Center
        row.Format.Font.Bold = True
        'row.Shading.Color = TableBlue
        row.Cells(0).AddParagraph("Item")
        row.Cells(0).Format.Font.Bold = False
        row.Cells(0).Format.Alignment = ParagraphAlignment.Left
        row.Cells(0).VerticalAlignment = VerticalAlignment.Bottom
        row.Cells(0).MergeDown = 1
        row.Cells(1).AddParagraph("Agrorobots E-Learning")
        row.Cells(1).Format.Alignment = ParagraphAlignment.Left
        row.Cells(1).MergeRight = 3
        row.Cells(5).AddParagraph("Detalle")
        row.Cells(5).Format.Alignment = ParagraphAlignment.Left
        row.Cells(5).VerticalAlignment = VerticalAlignment.Bottom
        row.Cells(5).MergeDown = 1

        row = table.AddRow()
        row.HeadingFormat = True
        row.Format.Alignment = ParagraphAlignment.Center
        row.Format.Font.Bold = True
        'row.Shading.Color = TableBlue
        row.Cells(1).AddParagraph("Cantidad")
        row.Cells(1).Format.Alignment = ParagraphAlignment.Left
        row.Cells(2).AddParagraph("Precio unitario")
        row.Cells(2).Format.Alignment = ParagraphAlignment.Left
        row.Cells(3).AddParagraph("Descuento (%)")
        row.Cells(3).Format.Alignment = ParagraphAlignment.Left
        row.Cells(4).AddParagraph("Impuesto")
        row.Cells(4).Format.Alignment = ParagraphAlignment.Left

        Me.table.SetEdge(0, 0, 6, 2, Edge.Box, BorderStyle.[Single], _
            0.75, Color.Empty)
    End Sub


    Dim navigator As XPathNavigator
    Private Sub FillContent()
        ' Fill address in address text frame
        'Dim item As XPathNavigator = SelectItem("/invoice/to")
        Dim paragraph As Paragraph = Me.addressFrame.AddParagraph()
        paragraph.AddText("")
        'paragraph.AddText(GetValue(item, "name/singleName"))
        'paragraph.AddLineBreak()
        'paragraph.AddText(GetValue(item, "address/line1"))
        'paragraph.AddLineBreak()
        'paragraph.AddText(GetValue(item, "address/postalCode") + " " + GetValue(item, "address/city"))

        ' Iterate the invoice items
        Dim totalExtendedPrice As Double = 0
        'Dim iter As XPathNodeIterator = Me.navigator.[Select]("/invoice/items/*")
        'While iter.MoveNext()
        '    item = iter.Current
        '    Dim quantity As Double = 4 'CDbl (item, "quantity")
        '    Dim price As Double = 200 'CDbl(item, "price")
        '    Dim discount As Double = 5 'CDbl(item, "discount")

        '    ' Each item fills two rows
        '    Dim row1 As Row = Me.table.AddRow()
        '    Dim row2 As Row = Me.table.AddRow()
        '    row1.TopPadding = 1.5
        '    'row1.Cells(0).Shading.Color = TableGray
        '    row1.Cells(0).VerticalAlignment = VerticalAlignment.Center
        '    row1.Cells(0).MergeDown = 1
        '    row1.Cells(1).Format.Alignment = ParagraphAlignment.Left
        '    row1.Cells(1).MergeRight = 3
        '    'row1.Cells(5).Shading.Color = TableGray
        '    'row1.Cells(5).MergeDown = 1

        '    'row1.Cells(0).AddParagraph(GetValue(item, "itemNumber"))
        '    'paragraph = row1.Cells(1).AddParagraph()
        '    'paragraph.AddFormattedText(GetValue(item, "title"), TextFormat.Bold)
        '    'paragraph.AddFormattedText(" by ", TextFormat.Italic)
        '    'paragraph.AddText(GetValue(item, "author"))
        '    'row2.Cells(1).AddParagraph(GetValue(item, "quantity"))
        '    'row2.Cells(2).AddParagraph(price.ToString("0.00") + " €")
        '    'row2.Cells(3).AddParagraph(discount.ToString("0.0"))
        '    'row2.Cells(4).AddParagraph()
        '    'row2.Cells(5).AddParagraph(price.ToString("0.00"))
        '    'Dim extendedPrice As Double = quantity * price
        '    'extendedPrice = extendedPrice * (100 - discount) / 100
        '    'row1.Cells(5).AddParagraph(extendedPrice.ToString("0.00") + " €")
        '    'row1.Cells(5).VerticalAlignment = VerticalAlignment.Bottom
        '    'totalExtendedPrice += extendedPrice

        '    Me.table.SetEdge(0, Me.table.Rows.Count - 2, 6, 2, Edge.Box, BorderStyle.[Single], _
        '        0.75)
        'End While

        ' Add an invisible row as a space line to the table
        Dim row As Row = Me.table.AddRow()
        row.Borders.Visible = False

        ' Add the total price row
        row = Me.table.AddRow()
        row.Cells(0).Borders.Visible = False
        row.Cells(0).AddParagraph("Subtotal")
        row.Cells(0).Format.Font.Bold = True
        row.Cells(0).Format.Alignment = ParagraphAlignment.Right
        row.Cells(0).MergeRight = 4
        row.Cells(5).AddParagraph("$ " + totalExtendedPrice.ToString("0.00"))

        ' Add the VAT row
        row = Me.table.AddRow()
        row.Cells(0).Borders.Visible = False
        row.Cells(0).AddParagraph("IVA (21%)")
        row.Cells(0).Format.Font.Bold = True
        row.Cells(0).Format.Alignment = ParagraphAlignment.Right
        row.Cells(0).MergeRight = 4
        row.Cells(5).AddParagraph("$ " + (0.19 * totalExtendedPrice).ToString("0.00"))

        ' Add the additional fee row
        row = Me.table.AddRow()
        row.Cells(0).Borders.Visible = False
        row.Cells(0).AddParagraph("Envio")
        row.Cells(5).AddParagraph("$ " + 0.ToString("0.00"))
        row.Cells(0).Format.Font.Bold = True
        row.Cells(0).Format.Alignment = ParagraphAlignment.Right
        row.Cells(0).MergeRight = 4

        ' Add the total due row
        row = Me.table.AddRow()
        row.Cells(0).AddParagraph("Total a pagar")
        row.Cells(0).Borders.Visible = False
        row.Cells(0).Format.Font.Bold = True
        row.Cells(0).Format.Alignment = ParagraphAlignment.Right
        row.Cells(0).MergeRight = 4
        totalExtendedPrice += 0.19 * totalExtendedPrice
        row.Cells(5).AddParagraph("$ " + totalExtendedPrice.ToString("0.00"))

        ' Set the borders of the specified cell range
        Me.table.SetEdge(5, Me.table.Rows.Count - 4, 1, 4, Edge.Box, BorderStyle.[Single], _
            0.75)

        ' Add the notes paragraph
        paragraph = Me.document.LastSection.AddParagraph()
        paragraph.Format.SpaceBefore = "1cm"
        paragraph.Format.Borders.Width = 0.75
        paragraph.Format.Borders.Distance = 3
        'paragraph.Format.Borders.Color = TableBorder
        'paragraph.Format.Shading.Color = TableGray
        'item = SelectItem("/invoice")
        'paragraph.AddText(GetValue(item, "notes"))
    End Sub



End Class