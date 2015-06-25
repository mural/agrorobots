Option Explicit On
Option Strict On

Imports DAL
Imports DTO

Public Class Idioma_Control_Business
    Public Function GetIdiomsOfCtrlByForm(ByVal FormId As Integer, ByRef Idiom As Idioma) As List(Of Idioma_Control)
        Dim IdioCtrlData As New Idioma_Control_Data
        Return IdioCtrlData.GetIdiomsOfCtrlByForm(FormId, Idiom)
    End Function
End Class