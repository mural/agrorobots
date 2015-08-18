Imports EE

Public Class Perfil_Business
    Implements IPerfil_Business

    Public Function similitud(ByVal perfil As Perfil, ByVal perfilAComparar As Perfil) As Double Implements IPerfil_Business.similitud
        Dim promedio1 = promedioCapacidades(perfil)
        Dim promedio2 = promedioCapacidades(perfilAComparar)

        Dim max = Math.Max(promedio1, promedio2)
        If max = promedio1 Then
            Return promedio2 / promedio1
        Else
            Return promedio1 / promedio2
        End If

    End Function

    Public Function listarCapacidades(ByVal idPerfil As Integer) As System.Collections.Generic.List(Of Capacidad) Implements IPerfil_Business.listarCapacidades
        Dim capacidadBusiness As New Capacidad_Business
        Return capacidadBusiness.ObtenerCapacidadesPorPerfil(idPerfil)
    End Function

    Public Function listarCapacidadPorTipo(ByVal idPerfil As Integer, ByVal tipoCapacidad As String) As Capacidad Implements IPerfil_Business.listarCapacidadPorTipo
        Dim capacidadBusiness As New Capacidad_Business
        Return capacidadBusiness.ObtenerCapacidadPorPerfilYTipo(idPerfil, tipoCapacidad)
    End Function

    Public Function promedioCapacidades(ByVal perfil As Perfil) As Double Implements IPerfil_Business.promedioCapacidades
        Dim sumaNiveles As Integer
        For Each capacidad As Capacidad In perfil.Capacidades
            sumaNiveles += capacidad.Nivel
        Next
        Return sumaNiveles / perfil.Capacidades.Count
    End Function

End Class
