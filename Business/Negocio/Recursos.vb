Imports EE
Imports DAL

Public Class Recursos

    Private Const MIN_ANTIGUEDAD = 1

    Public Shared Function armarRankingEmpleados() As List(Of Empleado)
        Dim empleados As New Empleado_Business
        Dim lst As List(Of Empleado)
        lst = empleados.obtenerListado()
        lst.Sort()
        Return lst
    End Function

    Public Shared Function sugerirAscensos() As List(Of Empleado)
        Dim cargosBusiness As New Producto_Business()
        Dim cargos = cargosBusiness.ObtenerFuturosCargos()
        Dim ascensos As New List(Of Empleado)
        For Each empleado As Empleado In armarRankingEmpleados()
            If Now.Year - empleado.FechaAscenso.Year >= MIN_ANTIGUEDAD Then
                For Each cargo As Producto In cargos
                    If empleado.Cargo.Descripcion.CompareTo(cargo.Descripcion) = 0 Then
                        empleado.FuturoCargo = cargo.Siguiente
                    End If
                Next
                ascensos.Add(empleado)
            End If
        Next
        Return ascensos
    End Function

    Public Shared Function sugerirAumentos() As List(Of Empleado)
        Dim cargosBusiness As New Producto_Business()
        Dim cargos = cargosBusiness.ArmarBandasSalariales(cargosBusiness.ObtenerProductos())
        Dim aumentos As New List(Of Empleado)
        For Each empleado As Empleado In armarRankingEmpleados()
            If Now.Year - empleado.FechaAscenso.Year >= MIN_ANTIGUEDAD Then
                For Each cargo As Producto In cargos
                    If empleado.Cargo.Descripcion.CompareTo(cargo.Descripcion) = 0 Then
                        empleado.FuturoSueldo = cargo.Valor
                    End If
                Next
                aumentos.Add(empleado)
            End If
        Next
        Return aumentos
    End Function

End Class
