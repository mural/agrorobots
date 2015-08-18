Option Explicit On
Option Strict On

Imports MPP
Imports EE

Public Class Idioma_Control_Business
    Public Function GetIdiomsOfCtrlByForm(ByVal FormId As Integer, ByRef Idiom As Idioma) As List(Of Idioma_Control)
        Dim IdioCtrlData As New Idioma_Control_Data
        Return IdioCtrlData.GetIdiomsOfCtrlByForm(FormId, Idiom)
    End Function

    Public Function GetIdiomsByID(idioma As Idioma) As List(Of Idioma_Control)
        Dim IdioCtrlData As New Idioma_Control_Data
        Return IdioCtrlData.GetIdiomsByID(idioma)
    End Function

    Public Sub CrearTraduccion(IdiomaID As Integer, Traduccion As String, ControlID As Integer)
        Dim IdioCtrlData As New Idioma_Control_Data
        IdioCtrlData.CreateTraduccion(IdiomaID, Traduccion, ControlID)

    End Sub

    Public Sub UpdateIdiomaById(ID As String, Traduccion As String)
        Dim IdioCtrlData As New Idioma_Control_Data
        IdioCtrlData.UpdateIdiomaById(ID, Traduccion)
    End Sub

    Public Sub BorrarTraduccion(ID As Integer)
        Dim IdioCtrlData As New Idioma_Control_Data
        IdioCtrlData.DeleteTraduccion(ID)

    End Sub
End Class