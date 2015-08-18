Imports EE

Public Interface IPerfil_Business

    Function similitud(ByVal perfil As Perfil, ByVal perfilAComparar As Perfil) As Double

    Function promedioCapacidades(ByVal perfil As Perfil) As Double

    Function listarCapacidades(ByVal idPerfil As Integer) As List(Of Capacidad)

    Function listarCapacidadPorTipo(ByVal idPerfil As Integer, ByVal tipoCapacidad As String) As Capacidad

End Interface
