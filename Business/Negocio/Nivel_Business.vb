Option Explicit On
Option Strict On

Imports DAL
Imports DTO
Imports System.Transactions

Public Class Nivel_Business
    Public m_Nivel_Data As Nivel_Data

    Public Sub Modificar(ByVal obj As Nivel)
        Dim dataNivel As New Nivel_Data

        Using trx As New TransactionScope
            'dataNivel.Modificar(obj)
            trx.Complete()
        End Using
    End Sub

    Public Function ObtenerNiveles() As List(Of Nivel)
        Dim dataNivel As New Nivel_Data
        Return dataNivel.ObtenerNiveles
    End Function

    Public Function ObtenerNivelesDeCapacidades(ByRef nivelesStrategy As NivelesStrategy) As List(Of Nivel)
        Return nivelesStrategy.obtenerNiveles
    End Function

End Class