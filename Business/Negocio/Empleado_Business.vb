Imports DAL
Imports System.Transactions
Imports DTO

Public Class Empleado_Business

    Public Function obtenerListado() As List(Of Empleado)

        Dim dataEmpleados As New Empleado_Data
        Dim empleados = dataEmpleados.ObtenerEmpleados()
        Dim perfiles As New Perfil_Business
        Dim capacidadBusiness As New Capacidad_Business

        For Each empleado As Empleado In empleados
            Dim capacidades = capacidadBusiness.ObtenerCapacidadesPorPerfil(empleado.Perfil.ID)
            empleado.Perfil.Capacidades = capacidades
            empleado.Cargo.Descripcion = IdiomManager.GetIdiomManager().GetTranslationById(CInt(empleado.Cargo.Descripcion))
            Dim objetivos = Evaluaciones.traerObjetivos(empleado.ID)
            Dim cumplidos As Integer
            For Each objetivo As Objetivo In objetivos
                If objetivo.Cumplido Then
                    cumplidos += 1
                End If
            Next
            Dim promedioCapacidades = perfiles.promedioCapacidades(empleado.Perfil)
            Dim promedioObjetivos = cumplidos / objetivos.Count
            empleado.Puntaje = promedioCapacidades * promedioObjetivos
        Next

        Return empleados
    End Function

    Public Function obtenerSegunPerfil(ByRef perfil As DTO.Perfil) As List(Of Empleado)

        Dim dataEmpleado As New Empleado_Data
        Dim empleados = dataEmpleado.ObtenerEmpleados
        Dim perfiles As New Perfil_Business
        Dim capacidades As New Capacidad_Business
        Dim empleadosFiltrados As New List(Of Empleado)

        For Each empleado As Empleado In empleados
            Dim capacidad = capacidades.ObtenerCapacidadPorPerfilYTipo(empleado.Perfil.ID, perfil.Capacidades.Item(0).Descripcion)
            Dim capacidadLista = New List(Of Capacidad)
            capacidadLista.Add(capacidad)
            empleado.Perfil.Capacidades = capacidadLista
            If perfiles.similitud(perfil, empleado.Perfil) > 0.75 Then
                empleadosFiltrados.Add(empleado)
            End If
        Next

        Return empleadosFiltrados
    End Function

End Class
