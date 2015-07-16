Imports System.Security.Cryptography
Imports System.Text

Public Class MyEncrypter

    Private Shared _encripter
    Private Sub New()

    End Sub
    Public Shared Function GetMyEncripter() As MyEncrypter
        If IsNothing(_encripter) Then
            _encripter = New MyEncrypter
        End If
        Return _encripter
    End Function

    Public Function GetHash(ByVal chain As String) As String
        Dim strBytes() As Byte = Encoding.ASCII.GetBytes(chain)

        Dim hash As HashAlgorithm = New MD5CryptoServiceProvider

        Return ArrayToString(hash.ComputeHash(strBytes))
    End Function

    Private Function ArrayToString(ByRef byteArray As Byte()) As String
        Dim sb As New StringBuilder(byteArray.Length)

        Dim i As Integer

        For i = 0 To byteArray.Length - 1
            sb.Append(byteArray(i).ToString("X2"))
        Next

        Return sb.ToString
    End Function
End Class
