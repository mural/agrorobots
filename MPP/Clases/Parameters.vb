Imports System.Data
Imports System.Data.SqlClient

Public Class Parameters

    Private _commandParameters As New List(Of SqlParameter)

    Public Function GetSQLParameter() As List(Of SqlParameter)
        Return _commandParameters
    End Function

    Private Function SetParameter(ByRef parameterName As String, ByVal parameterType As SqlDbType) As SqlParameter
        Dim _parameter As New SqlParameter
        _parameter.ParameterName = parameterName
        _parameter.SqlDbType = parameterType
        Return _parameter
    End Function

    Public Sub SetIntParameter(ByRef parameterName As String, ByRef parameterValue As Integer)
        Dim objParameter As SqlParameter = Me.SetParameter(parameterName, SqlDbType.Int)
        objParameter.Value = parameterValue
        _commandParameters.Add(objParameter)
    End Sub

    Public Sub SetStringParameter(ByRef parameterName As String, ByRef parameterValue As String)
        Dim objParameter As SqlParameter = Me.SetParameter(parameterName, SqlDbType.VarChar)
        objParameter.Value = parameterValue
        _commandParameters.Add(objParameter)
    End Sub

    Public Sub SetBooleanParameter(ByRef parameterName As String, ByRef parameterValue As Boolean)
        Dim objParameter As SqlParameter = Me.SetParameter(parameterName, SqlDbType.Bit)
        objParameter.Value = parameterValue
        _commandParameters.Add(objParameter)
    End Sub

    Public Sub SetDateParameter(ByRef parameterName As String, ByRef parameterValue As Date)
        Dim objParameter As SqlParameter = Me.SetParameter(parameterName, SqlDbType.Date)
        objParameter.Value = parameterValue
        _commandParameters.Add(objParameter)
    End Sub

    Public Sub SetImageParameter(ByRef parameterName As String, ByRef parameterValue As Byte())
        Dim objParameter As SqlParameter = Me.SetParameter(parameterName, SqlDbType.Image)
        objParameter.Value = parameterValue
        _commandParameters.Add(objParameter)
    End Sub
End Class
