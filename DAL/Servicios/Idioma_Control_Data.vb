Option Explicit On
Option Strict On
Imports System.Data.SqlClient
Imports DTO

Public Class Idioma_Control_Data

    Public Function GetIdiomsOfCtrlByForm(ByVal FormId As Integer, ByRef Idiom As Idioma) As List(Of Idioma_Control)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim params As New Parameters
        params.SetIntParameter("@FormId", FormId)
        params.SetIntParameter("@Idiom", Idiom.ID)
        Dim cmd As SqlCommand = Data.GetCommand("GetTranslationsByForm", con, params)

        Dim dt As DataTable

        Try
            dt = Data.GetDataSet(cmd, "Idioma_Control").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try


        Dim _lst As New List(Of Idioma_Control)
        For Each dr As DataRow In dt.Rows
            Dim IdiCtrl As New Idioma_Control(CInt(dr("Control_ID")), Idiom, dr("Traduccion").ToString)
            _lst.Add(IdiCtrl)
        Next

        Return _lst
    End Function
End Class ' Idioma_Control_Data