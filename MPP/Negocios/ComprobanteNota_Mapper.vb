﻿Imports EE

Public Class ComprobanteNota_Mapper
    Inherits Mapper(Of ComprobanteNota)

    Dim usuarioMapper As New Usuario_Data
    Dim comprobanteNotaDetalleMapper As New ComprobanteNotaDetalle_Mapper

    Public Sub New()
    End Sub

    Public Overrides Sub OBJaHASH(ByRef obj As ComprobanteNota, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@Numero", obj.Numero)
        hdatos.Add("@Tipo", obj.Tipo)
        hdatos.Add("@IdUsuario", obj.IdUsuario)
        hdatos.Add("@FechaEmision", obj.FechaEmision)
        hdatos.Add("@Subtotal", obj.Subtotal)
        hdatos.Add("@IVA", obj.IVA)
        hdatos.Add("@Motivo", obj.Motivo)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As ComprobanteNota, Optional ByVal insertar As Boolean = False) As Boolean
        If Not insertar Then
            Me.Transaccion = AccionTransaccion.Unica
        End If
        For Each detalle As ComprobanteNotaDetalle In obj.Items
            Try
                'buscar si no existe 
                Dim existe = False
                For Each detalleDB In comprobanteNotaDetalleMapper.Listar
                    If detalleDB.IdComprobanteNota = detalle.IdComprobanteNota And detalleDB.CodigoProducto = detalle.CodigoProducto Then
                        existe = True
                    End If
                Next
                If Not existe Then
                    comprobanteNotaDetalleMapper.Insertar(detalle)
                End If
            Catch ex As Exception
                ex.ToString()
            End Try
        Next
        Return Actualizar(obj, "ComprobanteNotaActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As ComprobanteNota, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.Numero = CInt(Item("Numero"))
        objNuevo.Tipo = CInt(Item("Tipo"))
        objNuevo.IdUsuario = CInt(Item("IdUsuario"))
        objNuevo.FechaEmision = CDate(Item("FechaEmision"))
        objNuevo.Subtotal = CDec(Item("Subtotal"))
        objNuevo.IVA = CDec(Item("IVA"))
        objNuevo.Motivo = CStr(Item("Motivo"))
    End Sub

    Public Overrides Function Obtener(ByVal idComprobante As Integer) As ComprobanteNota
        Dim comprobanteNota As ComprobanteNota = Obtener(idComprobante, "ComprobanteNotaObtener")
        Try
            For Each comprobanteNotaDetalle In comprobanteNotaDetalleMapper.Listar
                If comprobanteNotaDetalle.IdComprobanteNota = idComprobante Then
                    comprobanteNota.Items.Add(comprobanteNotaDetalle)
                End If
            Next
            comprobanteNota.Usuario = usuarioMapper.ConsultarPorId(comprobanteNota.IdUsuario)
        Catch ex As Exception
            ex.ToString()
        End Try
        Return comprobanteNota
    End Function

    Public Overrides Function Listar() As List(Of ComprobanteNota)
        Return Listar("ComprobanteNotaListar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ComprobanteNotaBorrar")
    End Function
End Class
