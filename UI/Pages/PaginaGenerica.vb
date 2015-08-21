Imports EE
Imports Business

Public MustInherit Class PaginaGenerica
    Inherits System.Web.UI.Page

    Protected Sub Inicio(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Traducir()
    End Sub

    Public Sub Traducir()
        LoopingControls(Me)
        TraducirCustomizado()
    End Sub

    Protected MustOverride Sub TraducirCustomizado()

    Public Sub LoopingControls(ByVal oControl As Control)
        Dim frmCtrl As Control
        Dim oArrayList = New ArrayList
        For Each frmCtrl In oControl.Controls
            Try
                If TypeOf frmCtrl Is Label Then
                    CType(frmCtrl, Label).Text = IdiomManager.GetIdiomManager.GetTranslationById(CType(frmCtrl, Label).ID.Split("_")(1))
                ElseIf TypeOf frmCtrl Is Button Then
                    CType(frmCtrl, Button).Text = IdiomManager.GetIdiomManager.GetTranslationById(CType(frmCtrl, Button).ID.Split("_")(1))
                End If
            Catch ex As Exception
            End Try
            If frmCtrl.HasControls Then
                LoopingControls(frmCtrl)
            End If
        Next
    End Sub

End Class
