Option Explicit On
Option Strict On

Imports DAL
Imports DTO
Imports System.Transactions

Public Class Producto_Business

    'Obtengo todos los productos disponibles con su precio y descripcion
    Public Function ObtenerProductos() As List(Of Producto)
        Dim dataCargo As New Producto_Data
        'Lamo al objeto que recupera los productos de la base de datos
        Dim cargos = dataCargo.ObtenerProductos
        Return cargos
    End Function

    Public Function ArmarBandasSalariales(ByRef cargos As List(Of Producto)) As List(Of Producto)
        For Each cargo As Producto In cargos
            cargo.ValorMin = cargo.Valor - (cargo.Valor * 0.10000000000000001)
            cargo.ValorMax = cargo.Valor + (cargo.Valor * 0.10000000000000001)
        Next
        Return cargos
    End Function

    Function ObtenerFuturosCargos() As Object
        Dim cargos = ObtenerProductos()
        For i = cargos.Count To 0 Step -1
            Try
                cargos.Item(i).Siguiente = cargos.Item(i - 1).Descripcion
            Catch ex As Exception
            End Try
        Next

        Return cargos
    End Function

End Class