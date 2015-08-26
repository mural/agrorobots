Imports EE

Namespace Idiomas

    Public Class IdiomManager
        Private Shared _idmManager As IdiomManager
        Private _lstIdiomaControl As New List(Of Idioma_Control)
        Private _lstFormsLoaded As New List(Of Integer)
        Private _idiom As Idioma

        'SINGLETON
        Public Shared Function GetIdiomManager() As IdiomManager
            If IsNothing(_idmManager) Then
                _idmManager = New IdiomManager
            End If

            Return _idmManager
        End Function

        Public Shared Sub KillIdiomManager()
            _idmManager = Nothing
        End Sub

        Private Sub New()
            Me._lstIdiomaControl.Add(New Idioma_Control(1, 0, New Idioma(1, "Español"), "Error al inicializar el sistema, Consulte al Administrador."))
            Me._lstIdiomaControl.Add(New Idioma_Control(2, -1, New Idioma(1, "Español"), "El usuario o la contraseña no son correctos."))
        End Sub

        Public Sub SetIdiom(ByRef idiom As Idioma)
            _idiom = idiom
            _lstFormsLoaded.Clear()
            _lstIdiomaControl.Clear()
        End Sub

        Public Sub CargarTraduccionesByFormId(ByVal FormId As Integer)
            If _lstFormsLoaded.Contains(FormId) Then
                Exit Sub
            End If

            Me._lstFormsLoaded.Add(FormId)

            Dim IdiCtrolDinam As New Idioma_Control_Business

            Me._lstIdiomaControl.AddRange(IdiCtrolDinam.GetIdiomsOfCtrlByForm(FormId, Me._idiom))

        End Sub

        Public Function GetTranslations() As List(Of Idioma_Control)
            Return Me._lstIdiomaControl
        End Function

        Public Function GetTranslationById(ByVal id As Integer) As String
            Dim str As String = ""
            For Each o As Idioma_Control In Me._lstIdiomaControl
                If id = o.Control_ID Then
                    str = o.Traduccion
                    Exit For
                End If
            Next
            If str = "" Then
                str = "<sin traducir>"
            End If
            Return str
        End Function

        Sub CargarTraduccionesByUsuario(idioma As Idioma)
            Dim IdiCtrolDinam As New Idioma_Control_Business

            Me._lstIdiomaControl.AddRange(IdiCtrolDinam.GetIdiomsByID(idioma))
        End Sub

    End Class

End Namespace
