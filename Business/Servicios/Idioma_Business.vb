Option Explicit On
Option Strict On

Imports DAL
Imports DTO

Public Class Idioma_Business
    Public Function ObtenerIdiomas() As List(Of Idioma) 
        Dim dataIdiom As New Idioma_Data
        Return dataIdiom.ObtenerIdiomas()
    End Function
End Class