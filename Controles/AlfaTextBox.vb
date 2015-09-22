Imports System
Imports System.Collections.Generic
Imports System.ComponentModel
Imports System.Text
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls


<DefaultProperty("Text"), ToolboxData("<{0}:ServerControl1 runat=server></{0}:ServerControl1>")>
Public Class AlfaTextBox
    Inherits TextBox

    Protected Overrides Sub OnTextChanged(e As System.EventArgs)
        Text += "."
    End Sub

    Protected Overrides Sub RenderContents(ByVal output As HtmlTextWriter)
        output.Write(Text)
    End Sub

End Class
