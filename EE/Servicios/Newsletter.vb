Public Class Newsletter

    Public Property ID As Integer '(int, not null)
    Public Property Email As String '(varchar(50), null)
    Public Property Nombre As String '(varchar(50), null)
    Public Property IDIdioma As Integer '(int, null)
    Public Property Temas As List(Of CategoriaTema)

    Public Sub New()
        Me.Temas = New List(Of CategoriaTema)
    End Sub
End Class