Imports EE
Imports MPP

Public Class Tarjeta_Business
    Inherits Business(Of Tarjeta)

    Sub New()
        Me.mapperGenerico = New Tarjeta_Mapper
    End Sub

    Sub GuardarTarjeta(ByRef tarjetaAGuardar As Tarjeta)
        'ver que no exista
        Dim existe = False
        For Each tarjeta In Listar()
            If tarjeta.Numero.Equals(tarjetaAGuardar.Numero) Then
                existe = True
                Exit For
            End If
        Next
        'guardar
        If Not existe Then
            Crear(tarjetaAGuardar)
        End If
    End Sub


End Class
