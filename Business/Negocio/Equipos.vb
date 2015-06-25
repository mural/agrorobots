Imports DTO

Public Class Equipos

    Public Shared Function formarEquipos(ByRef perfil As Perfil) As List(Of Empleado)
        Dim dinamEmpleados As New Empleado_Business

        Return dinamEmpleados.obtenerSegunPerfil(perfil)
    End Function

End Class
