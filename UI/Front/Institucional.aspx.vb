Imports System.Data.SqlClient

Public Class Institucional
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim connection As SqlConnection = Nothing
        Try
            Dim img As FileUpload = CType(imgUpload, FileUpload)
            Dim imgByte As Byte() = Nothing
            If img.HasFile AndAlso Not img.PostedFile Is Nothing Then
                'To create a PostedFile
                Dim File As HttpPostedFile = imgUpload.PostedFile
                'Create byte Array with file len
                imgByte = New Byte(File.ContentLength - 1) {}
                'force the control to load data in array
                File.InputStream.Read(imgByte, 0, File.ContentLength)
            End If
            ' Insert the employee name and image into db
            Dim conn As String = ConfigurationManager.ConnectionStrings("EmployeeConnString").ConnectionString
            connection = New SqlConnection(conn)

            connection.Open()
            Dim sql As String = "INSERT INTO EmpDetails(empname,empimg) VALUES(@enm, @eimg) SELECT @@IDENTITY"
            Dim cmd As SqlCommand = New SqlCommand(sql, connection)
            'cmd.Parameters.AddWithValue("@enm", txtEName.Text.Trim())
            cmd.Parameters.AddWithValue("@eimg", imgByte)
            Dim id As Integer = Convert.ToInt32(cmd.ExecuteScalar())
            lblResult.Text = String.Format("Employee ID is {0}", id)
        Catch
            lblResult.Text = "There was an error"
        Finally
            connection.Close()
        End Try
    End Sub

End Class