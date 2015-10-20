Imports EE
Imports MPP

Public Class Tarjeta_Business
    Inherits Business(Of Tarjeta)

    Dim encriptador As MyEncrypter = MyEncrypter.GetMyEncripter

    Sub New()
        Me.mapperGenerico = New Tarjeta_Mapper
    End Sub


    Public Function ObtenerTarjetaDeUsuario(ByVal idUsuario As Integer) As Tarjeta
        'ver si hay una tarjeta para el usuario
        For Each tarjeta In Listar()
            If tarjeta.IdUsuario = idUsuario Then
                tarjeta.Numero = encriptador.Desencriptar(tarjeta.Numero)
                Return tarjeta
            End If
        Next
        Return Nothing
    End Function

    Public Sub GuardarTarjeta(ByRef tarjetaAGuardar As Tarjeta)
        'ver que no exista
        Dim existe = False
        For Each tarjeta In Listar()
            If encriptador.Desencriptar(tarjeta.Numero).Equals(tarjetaAGuardar.Numero) Then
                existe = True
                Exit For
            End If
        Next
        'guardar
        If Not existe Then
            tarjetaAGuardar.Numero = encriptador.Encriptar(tarjetaAGuardar.Numero)
            Crear(tarjetaAGuardar)
        End If
    End Sub

    Public Sub BorrarPorUsuario(ByVal idUsuario As Integer)
        Borrar(ObtenerTarjetaDeUsuario(idUsuario).ID)
    End Sub


End Class
