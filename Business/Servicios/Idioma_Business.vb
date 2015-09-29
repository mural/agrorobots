Option Explicit On
Option Strict On

Imports MPP
Imports EE

Public Class Idioma_Business

    Public Function ObtenerIdiomas() As List(Of Idioma)
        Dim dataIdiom As New Idioma_Data
        Return dataIdiom.ObtenerIdiomas()
    End Function

    Public Function ObtenerIdiomaPorId(id As Integer) As Idioma
        Dim dataIdiom As New Idioma_Data
        Dim idiomas = dataIdiom.ObtenerIdiomas()
        For Each idioma In idiomas
            If id = idioma.ID Then
                Return idioma
            End If
        Next
        Return Nothing
    End Function

    Function ActualizarIdioma(ByVal idiomaID As Integer, ByVal descripcion As String, ByVal codigo As String) As Boolean
        Dim dataIdiom As New Idioma_Data

        Return dataIdiom.ActualizarIdioma(idiomaID, descripcion, codigo)
    End Function

    Function CrearIdioma(ByVal idiomaID As Integer, ByVal descripcion As String, ByVal codigo As String) As Boolean
        Dim dataIdiom As New Idioma_Data

        Return dataIdiom.CrearIdioma(idiomaID, descripcion, codigo)
    End Function

    Function BorrarIdioma(ByVal idiomaID As Integer) As Boolean
        Dim dataIdiom As New Idioma_Data

        Return dataIdiom.BorrarIdioma(idiomaID)
    End Function
End Class