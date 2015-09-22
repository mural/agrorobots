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

    Public Function GetIdiomsByIDWithOriginals(idioma As Idioma, Optional filtro As String = "") As List(Of Idioma_Control)
        Dim IdioCtrlData As New Idioma_Control_Data
        Dim traducciones = GetIdiomsByID(idioma)
        Dim originales = IdioCtrlData.GetIdiomsByID(New Idioma(1, "Español"))
        Dim i = 0
        'agrego a las traducciones los originales que esten de mas
        Dim traduccionAgregar As Idioma_Control
        For Each original As Idioma_Control In originales
            Dim encontrado = False
            For Each traduccion As Idioma_Control In traducciones
                If original.Control_ID = traduccion.Control_ID Then
                    encontrado = True
                    Exit For
                End If
            Next
            If Not encontrado Then
                CrearTraduccion(traducciones(0).Idioma.ID, "", original.Control_ID)
            End If
        Next

        If traducciones.Count <> originales.Count Then
            For Each traduccion As Idioma_Control In traducciones
                Dim encontrado = False
                For Each original As Idioma_Control In originales
                    If original.Control_ID = traduccion.Control_ID Then
                        encontrado = True
                        Exit For
                    End If
                Next
                If Not encontrado Then
                    CrearTraduccion(originales(0).Idioma.ID, "", traduccion.Control_ID)
                End If
            Next
        End If

        traducciones = GetIdiomsByID(idioma)
        originales = IdioCtrlData.GetIdiomsByID(New Idioma(1, "Español"))

        For Each traduccion As Idioma_Control In traducciones
            traduccion.Original = originales.Item(i).Traduccion
            i += 1
        Next

        If Not String.IsNullOrEmpty(filtro) Then
            Dim traduccionesFiltradas As New List(Of Idioma_Control)
            For Each traduccion As Idioma_Control In traducciones
                If traduccion.Traduccion.ToLowerInvariant.Contains(filtro.ToLowerInvariant) Then
                    traduccionesFiltradas.Add(traduccion)
                End If
            Next
            Return traduccionesFiltradas
        End If

        Return traducciones
    End Function

    Public Sub CrearTraduccion(IdiomaID As Integer, Traduccion As String, ControlID As Integer)
        Dim IdioCtrlData As New Idioma_Control_Data
        Dim traducciones = GetIdiomsByID(New Idioma(IdiomaID, ""))
        Dim encontrado = False
        For Each traduccionNueva As Idioma_Control In traducciones
            If traduccionNueva.Control_ID = ControlID Then
                encontrado = True
                Exit For
            End If
        Next
        If Not encontrado Then
            IdioCtrlData.CreateTraduccion(IdiomaID, Traduccion, ControlID)
        Else
            Throw New Exception("TraduccionExistente")
        End If

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