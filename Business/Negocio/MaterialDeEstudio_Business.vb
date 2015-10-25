Imports EE
Imports MPP

Public Class MaterialDeEstudio_Business
    Inherits Business(Of MaterialDeEstudio)

    Sub New()
        Me.mapperGenerico = New MaterialDeEstudio_Mapper
    End Sub

    Function ListarPorElementoAcademico(codigoAcademico As Integer) As List(Of MaterialDeEstudio)
        Dim listaMateriales As New List(Of MaterialDeEstudio)
        For Each material In Listar()
            If material.IdElementoAcademico = codigoAcademico Then
                listaMateriales.Add(material)
            End If
        Next
        Return listaMateriales
    End Function

End Class
