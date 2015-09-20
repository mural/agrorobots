Public Class Mapper
    Protected oDatos As New DAL.Datos
    Protected hdatos As New Hashtable
    Protected DS As New DataSet

    Protected Sub Preparar()
        oDatos = New DAL.Datos
        hdatos = New Hashtable
        DS = New DataSet
    End Sub
End Class
