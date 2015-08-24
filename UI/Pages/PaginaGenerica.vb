Imports EE
Imports Business

Public MustInherit Class PaginaGenerica
    Inherits System.Web.UI.Page

    Protected Sub Inicio(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        Traducir()
    End Sub

    Public Sub Traducir()
        Static start_time As DateTime
        Static stop_time As DateTime
        Dim elapsed_time As TimeSpan
        start_time = Now

        TraducirLoopingControls(Me)
        TraducirComponentesDinamicos()

        stop_time = Now
        elapsed_time = stop_time.Subtract(start_time)
    End Sub

    Protected MustOverride Sub TraducirComponentesDinamicos()

    Public Sub TraducirLoopingControls(ByVal oControl As Control)
        Dim frmCtrl As Control
        Dim oArrayList = New ArrayList
        For Each frmCtrl In oControl.Controls
            If Not String.IsNullOrEmpty(frmCtrl.ID) Then
                If frmCtrl.ID.Contains("_") Then
                    Try
                        If TypeOf frmCtrl Is Label Then
                            CType(frmCtrl, Label).Text = IdiomManager.GetIdiomManager.GetTranslationById(CType(frmCtrl, Label).ID.Split("_")(1))
                        ElseIf TypeOf frmCtrl Is Button Then
                            CType(frmCtrl, Button).Text = IdiomManager.GetIdiomManager.GetTranslationById(CType(frmCtrl, Button).ID.Split("_")(1))
                        ElseIf TypeOf frmCtrl Is LinkButton Then
                            CType(frmCtrl, LinkButton).Text = IdiomManager.GetIdiomManager.GetTranslationById(CType(frmCtrl, LinkButton).ID.Split("_")(1))
                        ElseIf TypeOf frmCtrl Is GridView Then
                            For Each header As DataControlField In DirectCast(frmCtrl, GridView).Columns
                                Try
                                    header.HeaderText = IdiomManager.GetIdiomManager.GetTranslationById(header.HeaderText.Split("_")(1))
                                Catch ex As Exception
                                End Try
                            Next
                        End If
                    Catch ex As Exception
                    End Try
                End If
            End If
            If frmCtrl.HasControls Then
                TraducirLoopingControls(frmCtrl)
            End If

        Next
    End Sub

End Class
