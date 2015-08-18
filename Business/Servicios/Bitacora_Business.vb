Option Explicit On
Option Strict On

Imports MPP
Imports EE

Public Class Bitacora_Business

    Public Shared LOG_IN_TYPE As String = "500"
    Public Shared LOG_IN_OK As String = "501"
    Public Shared LOG_IN_ERROR As String = "502"
    Public Shared LOG_OFF_TYPE As String = "503"
    Public Shared LOG_OFF_OK As String = "504"

    Public Shared BACKUP_TYPE As String = "510"
    Public Shared BACKUP_MSG As String = "511"
    Public Shared RESTORE_MSG As String = "512"

    Public Sub New()

    End Sub

    Private Shared _bit As Bitacora_Business

    Private bitacoraData As New Bitacora_Data

    Public Shared Sub Logear(ByVal tipo As String, ByVal desc As String, ByVal User As String)
        'Dim tipoT = IdiomManager.GetIdiomManager().GetTranslationById(CInt(tipo))
        'Dim descT = IdiomManager.GetIdiomManager().GetTranslationById(CInt(desc))

        Dim bitaData As New Bitacora_Data
        bitaData.Logear(tipo, desc, User)
    End Sub

    Public Shared Function GetBitacora() As Bitacora_Business
        If IsNothing(_bit) Then
            _bit = New Bitacora_Business
        End If

        Return _bit
    End Function

    Public Function GetItemsBitacora() As List(Of Bitacora)
        Dim bitacora = bitacoraData.GetItemsBitacora()
        'For Each bita In bitacora
        '    bita.Tipo = IdiomManager.GetIdiomManager().GetTranslationById(CInt(bita.Tipo))
        '    bita.Detalle = IdiomManager.GetIdiomManager().GetTranslationById(CInt(bita.Detalle))
        'Next
        Return bitacora
    End Function
End Class