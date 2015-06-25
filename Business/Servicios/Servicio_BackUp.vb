Option Explicit On
Option Strict On

Imports DAL

Public Class Servicio_BackUp
    Public m_Servicio_BackUp_Data As New Servicio_BackUp_Data

    Public Sub CrearBackUp(ByVal pathDestino As String)
        m_Servicio_BackUp_Data.CrearBackUp(pathDestino)
    End Sub

    Public Sub RestoreBackUp(ByVal pathSource As String)
        m_Servicio_BackUp_Data.RestoreBackUp(pathSource)
    End Sub
End Class