Option Explicit On
Option Strict On
Imports System.Data.SqlClient
Imports EE

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
            Dim IdiCtrl As New Idioma_Control(CInt(dr("ID")), CInt(dr("Control_ID")), Idiom, dr("Traduccion").ToString)
            _lst.Add(IdiCtrl)
        Next

        Return _lst
    End Function

    Function GetIdiomsByID(idioma As Idioma) As List(Of Idioma_Control)
        Dim oDatos As New DAL.Datos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        hdatos.Add("@Idiom", idioma.ID)

        DS = oDatos.Leer("GetTranslationsByIdiom", hdatos)

        Dim _lst As New List(Of Idioma_Control)
        If DS.Tables(0).Rows.Count > 0 Then
            For Each Item As DataRow In DS.Tables(0).Rows
                Dim IdiCtrl As New Idioma_Control(CInt(Item("ID")), CInt(Item("Control_ID")), idioma, Item("Traduccion").ToString)
                _lst.Add(IdiCtrl)
            Next
        End If

        Return _lst
    End Function

    Sub UpdateIdiomaById(ID As String, Traduccion As String)
        Dim oDatos As New DAL.Datos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        hdatos.Add("@ID", ID)
        hdatos.Add("@Traduccion", Traduccion)

        oDatos.Escribir("UpdateTraduccionByID", hdatos)
    End Sub

End Class ' Idioma_Control_Data