Imports EE
Imports Business
Imports MigraDoc.DocumentObjectModel
Imports MigraDoc.DocumentObjectModel.Shapes
Imports MigraDoc.DocumentObjectModel.Tables
Imports MigraDoc.DocumentObjectModel.Color

Imports System.Xml.XPath
Imports MigraDoc.Rendering
Imports PdfSharp.Pdf

Public Class CuentaCorriente
    Inherits PaginaAutorizada

    Dim ctaCteUsuarioBusiness As New Business.CtaCteUsuario_Business
    Dim comprobanteBusiness As New Business.Comprobante_Business
    Dim comprobanteNotaBusiness As New Business.ComprobanteNota_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarMovimientos()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarMovimientos()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarMovimientos()
        Me.GridView1_.DataSource = ctaCteUsuarioBusiness.ListarPorUsuario(usuario.ID)
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarMovimientos()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Public Function ObtenerTipo(ByVal IDCtaCte As Integer) As String
        Dim ctacte = ctaCteUsuarioBusiness.Obtener(IDCtaCte)

        Dim comprobante As ComprobanteGenerico = Nothing
        If ctacte.Tipo = 1 Then
            Return "Factura"
        Else
            Return "Nota de Credito"
        End If
    End Function

    Public Function ObtenerDetalle(ByVal IDCtaCte As Integer) As String
        Dim ctacte = ctaCteUsuarioBusiness.Obtener(IDCtaCte)

        Dim comprobante As ComprobanteGenerico = Nothing
        If ctacte.Tipo = 1 Then
            comprobante = comprobanteBusiness.Obtener(ctacte.IdComprobante)
        Else
            comprobante = comprobanteNotaBusiness.Obtener(ctacte.IdComprobante)
        End If

        Dim detalle As String = ""
        For Each comprobanteItem In comprobante.Items
            detalle += comprobanteItem.Detalle + " "
        Next
        Return detalle
    End Function

    Public Function ObtenerMontoTotal(ByVal IDCtaCte As Integer) As String
        Dim ctacte = ctaCteUsuarioBusiness.Obtener(IDCtaCte)

        Dim comprobante As ComprobanteGenerico = Nothing
        If ctacte.Tipo = 1 Then
            comprobante = comprobanteBusiness.Obtener(ctacte.IdComprobante)
        Else
            comprobante = comprobanteNotaBusiness.Obtener(ctacte.IdComprobante)
        End If

        Return "$ " + CStr(comprobante.IVA + comprobante.Subtotal)
    End Function

    Protected Sub PDF(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Dim IDCtaCte = CInt(link.CommandArgument)
        Dim ctacte = ctaCteUsuarioBusiness.Obtener(IDCtaCte)

        Dim filename = "factura.pdf"

        Dim comprobante As ComprobanteGenerico = Nothing
        If ctacte.Tipo = 1 Then
            comprobante = comprobanteBusiness.Obtener(ctacte.IdComprobante)
        Else
            comprobante = comprobanteNotaBusiness.Obtener(ctacte.IdComprobante)
            filename = "nota.pdf"
        End If
        CreateDocument(comprobante)

        Dim pdfRenderer As New PdfDocumentRenderer(False, PdfFontEmbedding.Always)
        pdfRenderer.Document = document
        pdfRenderer.RenderDocument()
        pdfRenderer.PdfDocument.Save(Server.MapPath("~/App_Data/") + filename)

        Try
            Dim virtualPath = "~/App_Data/" & filename
            Response.ContentType = "application/pdf"
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename)
            Response.TransmitFile(Server.MapPath(virtualPath))
            Response.End()
        Catch

        End Try

    End Sub

    Dim document As New Document
    Public Function CreateDocument(ByVal paramComprobante As ComprobanteGenerico) As Document
        document.Info.Title = "Comprobante"
        document.Info.Subject = "Comprobante de transaccion"
        document.Info.Author = "Agrorobots"
        DefineStyles()
        CreatePage(paramComprobante)
        FillContent(paramComprobante)
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
    Private Sub CreatePage(ByVal paramComprobante As ComprobanteGenerico)
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
        paragraph.Format.Font.Size = 10
        paragraph = section.AddParagraph()

        paragraph = Me.addressFrame.AddParagraph("Calle Falsa 123 · 1406 Buenos Aires · Argentina")
        paragraph.Format.Font.Name = "Times New Roman"
        paragraph.Format.Font.Size = 10
        paragraph = section.AddParagraph()
        paragraph = Me.addressFrame.AddParagraph("www.agrorobots.com")
        paragraph.Format.Font.Name = "Times New Roman"
        paragraph.Format.Font.Size = 10

        paragraph = section.AddParagraph()
        paragraph.Format.SpaceBefore = "3.5cm"
        paragraph.Format.Font.Size = 9
        paragraph.AddFormattedText("Datos de Facturación:", TextFormat.Bold)
        paragraph.AddTab()
        paragraph = section.AddParagraph()
        paragraph.AddText("Número de Factura: " & paramComprobante.Numero)
        paragraph.Format.Font.Size = 9
        paragraph.AddTab()
        paragraph = section.AddParagraph()
        paragraph.AddText("Fecha de Emisión: " & paramComprobante.FechaEmision)
        paragraph.Format.Font.Size = 9
        paragraph.AddTab()
        If TypeOf paramComprobante Is Comprobante Then
            paragraph = section.AddParagraph()
            paragraph.AddText("Fecha de Vencimiento: " & DirectCast(paramComprobante, Comprobante).FechaVencimiento)
            paragraph.Format.Font.Size = 9
        End If

        paragraph = section.AddParagraph()
        paragraph.Format.SpaceBefore = "0.5cm"
        paragraph.AddFormattedText("Datos del Cliente: ", TextFormat.Bold)
        paragraph.Format.Font.Size = 9
        paragraph.AddTab()
        paragraph = section.AddParagraph()
        paragraph.AddText("Nombre: " & paramComprobante.Usuario.Nombre + paramComprobante.Usuario.Apellido)
        paragraph.Format.Font.Size = 9
        paragraph.AddTab()
        paragraph = section.AddParagraph()
        paragraph.AddText("Numero de Documento: " & paramComprobante.Usuario.Email) ''TODO !!!
        paragraph.Format.Font.Size = 9
        paragraph.AddTab()
        paragraph = section.AddParagraph()
        paragraph.AddText("Direccion:" & paramComprobante.Usuario.UserName) ''TODO !!!
        paragraph.Format.Font.Size = 9

        ' Add the print date field
        paragraph = section.AddParagraph()
        paragraph.Format.SpaceBefore = "1cm"
        paragraph.Style = "Reference"
        If TypeOf paramComprobante Is Comprobante Then
            paragraph.AddFormattedText("FACTURA B", TextFormat.Bold)
        Else
            paragraph.AddFormattedText("NOTA DE CREDITO", TextFormat.Bold)
        End If

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
        row.Cells(0).Format.Alignment = ParagraphAlignment.Center
        row.Cells(0).VerticalAlignment = VerticalAlignment.Center
        row.Cells(0).MergeDown = 1
        row.Cells(1).AddParagraph("Servicios Educativos - Agrorobots")
        row.Cells(1).Format.Alignment = ParagraphAlignment.Center
        row.Cells(1).MergeRight = 3
        row.Cells(5).AddParagraph("TOTAL")
        row.Cells(5).Format.Alignment = ParagraphAlignment.Center
        row.Cells(5).VerticalAlignment = VerticalAlignment.Center
        row.Cells(5).MergeDown = 1

        row = table.AddRow()
        row.HeadingFormat = True
        row.Format.Alignment = ParagraphAlignment.Center
        row.Format.Font.Bold = True
        'row.Shading.Color = TableBlue
        row.Cells(1).AddParagraph("Cantidad")
        row.Cells(1).Format.Alignment = ParagraphAlignment.Center
        row.Cells(2).AddParagraph("Precio unitario")
        row.Cells(2).Format.Alignment = ParagraphAlignment.Center
        row.Cells(3).AddParagraph("Detalle")
        row.Cells(3).Format.Alignment = ParagraphAlignment.Center
        row.Cells(4).AddParagraph("Codigo")
        row.Cells(4).Format.Alignment = ParagraphAlignment.Center

        Me.table.SetEdge(0, 0, 6, 2, Edge.Box, BorderStyle.[Single], _
            0.75, Color.Empty)
    End Sub


    Dim navigator As XPathNavigator
    Private Sub FillContent(ByVal paramComprobante As ComprobanteGenerico)
        ' Fill address in address text frame
        Dim paragraph As Paragraph = Me.addressFrame.AddParagraph()
        paragraph.AddText("")

        ' Iterate the invoice items
        Dim totalExtendedPrice As Double = 0

        Dim contador As Integer = 1
        For Each midetalle As ComprobanteDetalleGenerico In paramComprobante.Items
            Dim rowDetalle As Row = Me.table.AddRow
            rowDetalle.Cells(0).AddParagraph(contador)
            rowDetalle.Cells(1).AddParagraph(midetalle.Cantidad)
            rowDetalle.Cells(2).AddParagraph("$ " & midetalle.Subtotal)
            rowDetalle.Cells(3).AddParagraph(midetalle.Detalle)
            rowDetalle.Cells(4).AddParagraph(midetalle.CodigoProducto)
            rowDetalle.Cells(5).AddParagraph("$ " & (midetalle.Subtotal))
            contador += 1
        Next


        ' Add an invisible row as a space line to the table
        Dim row As Row = Me.table.AddRow()
        row.Borders.Visible = False

        ' Add the total price row
        row = Me.table.AddRow()
        row.Cells(0).Borders.Visible = False
        row.Cells(0).AddParagraph("SUBTOTAL")
        row.Cells(0).Format.Font.Bold = True
        row.Cells(0).Format.Alignment = ParagraphAlignment.Right
        row.Cells(0).MergeRight = 4
        row.Cells(5).AddParagraph("$ " & paramComprobante.Subtotal)

        ' Add the VAT row
        row = Me.table.AddRow()
        row.Cells(0).Borders.Visible = False
        row.Cells(0).AddParagraph("IVA (21%)")
        row.Cells(0).Format.Font.Bold = True
        row.Cells(0).Format.Alignment = ParagraphAlignment.Right
        row.Cells(0).MergeRight = 4
        row.Cells(5).AddParagraph("$ " & paramComprobante.IVA)

        ' Add the total due row
        row = Me.table.AddRow()
        row.Cells(0).AddParagraph("TOTAL")
        row.Cells(0).Borders.Visible = False
        row.Cells(0).Format.Font.Bold = True
        row.Cells(0).Format.Alignment = ParagraphAlignment.Right
        row.Cells(0).MergeRight = 4
        row.Cells(5).AddParagraph("$ " & (paramComprobante.Subtotal + paramComprobante.IVA))

        ' Set the borders of the specified cell range
        Me.table.SetEdge(5, Me.table.Rows.Count - 4, 1, 4, Edge.Box, BorderStyle.[Single], _
            0.75)

        ' Add the notes paragraph
        paragraph = Me.document.LastSection.AddParagraph()
        paragraph.Format.SpaceBefore = "1cm"
        paragraph.Format.Borders.Width = 0.75
        paragraph.Format.Borders.Distance = 3
    End Sub

End Class