Option Explicit On
Option Strict On
Imports DAL

'Servicio que usa digitos verificadores verticales y horizontales
'Para detectar cambios en las tablas de bbdd por fuera del sistema
Public Class Servicio_Digitos

    'Calcula el digito horizontal de un registro
    Public Sub CalcularDigitoH(ByVal id As String, ByVal table As String)
        Dim digito_data As New Servicio_Digitos_Data

        Dim dr As DataRow = digito_data.ObtenerFila(id, table)
        Dim str As String = ""

        For Each field As Object In dr.ItemArray
            If Not dr("DigitoH") Is field Then
                str = str + ToMyString(field)
            End If
        Next

        Dim encrypter As MyEncrypter = MyEncrypter.GetMyEncripter
        str = encrypter.GetHash(str)


        digito_data.GuardarDigitoH(id, table, str)
        Me.CalcularDigitoV(table)
    End Sub

    Private Function ToMyString(ByVal field As Object) As String
        If field.GetType Is GetType(Boolean) Then
            If CBool(field) Then
                Return "1"
            Else
                Return "0"
            End If
        ElseIf field.GetType Is GetType(DateTime) Then
            Return CDate(field).ToString("MM/dd/yyyy H:mm:ss")
        ElseIf field.GetType Is GetType(Decimal) Then
            Return CDec(field).ToString().Replace(".", ",")
        ElseIf field.GetType Is GetType(Double) Then
            Return CDbl(field).ToString().Replace(".", ",")
        Else
            Return field.ToString
        End If
    End Function

    'Calcula el digito vertical para una tabla
    Public Sub CalcularDigitoV(ByVal table As String)
        Dim digito_data As New Servicio_Digitos_Data
        Dim dt As DataTable = digito_data.ObtenerTabla(table)

        Dim str As String = ""

        For Each dr As DataRow In dt.Rows
            str += CStr(dr("DigitoH"))
        Next

        Dim encrypter As MyEncrypter = MyEncrypter.GetMyEncripter
        str = encrypter.GetHash(str)

        digito_data.GuardarDigitoV(table, str)
    End Sub

    'Devuelve una lista con TABLA(pares) y ID(impares) de cada registro afectado
    'por fuera del sistema usando la verificacion de digitos
    Public Function VerificarDigitos() As List(Of String)
        Dim digito_data As New Servicio_Digitos_Data
        Dim dTableDigitos As DataTable = digito_data.ObtenerDigitosV()
        Dim encrypter As MyEncrypter = MyEncrypter.GetMyEncripter
        Dim strCorruptedTables As New List(Of String)
        Dim strCorruptedRegs As New List(Of String)

        For Each dr As DataRow In dTableDigitos.Rows
            Dim dtCurrTable As DataTable = digito_data.ObtenerTabla(CStr(dr("Tabla")))

            Dim str As String = ""
            Dim ID As String = ""
            For Each drCurrRow As DataRow In dtCurrTable.Rows
                Dim strRowDH As String = ""
                For i = 0 To drCurrRow.Table.Columns.Count - 1
                    If Not drCurrRow("DigitoH") Is drCurrRow(i) Then
                        strRowDH += ToMyString(drCurrRow(i))
                        If (i = 0) Then
                            ID = ToMyString(drCurrRow(i))
                        End If
                    End If
                Next
                If Not encrypter.GetHash(strRowDH) = drCurrRow("DigitoH").ToString Then
                    'strCorruptedRegs.Add("Tabla: " + CStr(dr("Tabla")) + ", ID: " + ID)
                    strCorruptedRegs.Add(CStr(dr("Tabla")))
                    strCorruptedRegs.Add(ID)
                    str = "DH INCORRECTO"
                    'Exit For
                End If
                str += ToMyString(drCurrRow("DigitoH"))
            Next

            str = encrypter.GetHash(str)
            If Not (str = CStr(dr("DigitoV"))) Then
                strCorruptedTables.Add(CStr(dr("Tabla")))
            End If
        Next

        Return strCorruptedRegs
    End Function
End Class