Imports EE
Imports MPP
Imports EE.ElementoAcademico

Public Class ElementoAcademico_Business
    Inherits Business(Of ElementoAcademico)

    Sub New()
        Me.mapper = New ElementoAcademico_Mapper
    End Sub

    Public Shadows Function ListarPorEstado(ByVal estado As ElementoAcademicoEnum) As List(Of ElementoAcademico)
        Dim elementosAcademicos As New List(Of ElementoAcademico)
        For Each elementoAcademico In mapper.Listar()
            If elementoAcademico.EstadoActual = estado Then
                elementosAcademicos.Add(elementoAcademico)
            End If
        Next
        Return elementosAcademicos
    End Function

End Class
