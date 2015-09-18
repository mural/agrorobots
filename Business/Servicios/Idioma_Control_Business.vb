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

    Public Function GetIdiomsByIDWithOriginals(idioma As Idioma) As List(Of Idioma_Control)
        Dim IdioCtrlData As New Idioma_Control_Data
        Dim traducciones = GetIdiomsByID(idioma)
        Dim originales = IdioCtrlData.GetIdiomsByID(New Idioma(1, "Español"))
        Dim i = 0     'Si se ingresa una traduccion de otro idioma antes que espanol esto falla, revisar
        For Each traduccion As Idioma_Control In traducciones
            traduccion.Original = originales.Item(i).Traduccion
            i += 1
        Next
        Return traducciones
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