Imports EE

Public Class CtaCteUsuario_Mapper
    Inherits Mapper(Of CtaCteItemUsuario)

    Dim comprobante_Mapper As New Comprobante_Mapper
    Dim comprobanteDetalleMapper As New ComprobanteDetalle_Mapper

    Dim usuarioMapper As New Usuario_Data
    Public Property IdComprobante As Integer

    Dim comprobanteNota_Mapper As New ComprobanteNota_Mapper
    Dim comprobanteNotaDetalleMapper As New ComprobanteNotaDetalle_Mapper

    Public Sub New()
    End Sub

    Public Overrides Function Insertar(ByRef obj As CtaCteItemUsuario) As Boolean
        Preparar()

        Dim resultado As Boolean
        If obj.Tipo = 1 Then
            comprobante_Mapper.Transaccion = AccionTransaccion.Iniciar
            resultado = comprobante_Mapper.Actualizar(obj.Comprobante, True) 'Comprobante
        Else
            comprobanteNota_Mapper.Transaccion = AccionTransaccion.Iniciar
            resultado = comprobanteNota_Mapper.Actualizar(obj.Comprobante, True) 'Comprobante Nota
        End If
        IdComprobante = oDatos.RespuestaEscritura

        If resultado Then 'si salio bien la escritura anterior
            If obj.Tipo = 1 Then
                comprobanteDetalleMapper.Transaccion = AccionTransaccion.Continuar
                For Each itemDetalle As ComprobanteDetalle In obj.Comprobante.Items
                    itemDetalle.IdComprobante = IdComprobante
                    resultado = comprobanteDetalleMapper.Insertar(itemDetalle)
                Next
            Else
                comprobanteNotaDetalleMapper.Transaccion = AccionTransaccion.Continuar
                For Each itemDetalle As ComprobanteNotaDetalle In obj.Comprobante.Items
                    itemDetalle.IdComprobanteNota = IdComprobante
                    resultado = comprobanteNotaDetalleMapper.Insertar(itemDetalle)
                Next
            End If
        End If

        Me.Transaccion = AccionTransaccion.Cerrar
        If resultado Then 'si salio bien la escritura anterior
            obj.IdComprobante = IdComprobante
            resultado = Actualizar(obj, True)
        End If
        Return resultado
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As CtaCteItemUsuario, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdUsuario", obj.IdUsuario)
        hdatos.Add("@IdComprobante", obj.IdComprobante)
        hdatos.Add("@Tipo", obj.Tipo)
        hdatos.Add("@Estado", obj.Estado)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As CtaCteItemUsuario, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "CtaCteUsuarioActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As CtaCteItemUsuario, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.IdUsuario = CInt(Item("IdUsuario"))
        objNuevo.IdComprobante = CInt(Item("IdComprobante"))
        objNuevo.Tipo = CStr(Item("Tipo"))
        objNuevo.Estado = CStr(Item("Estado"))
    End Sub

    Public Overrides Function Obtener(ByVal idCtaCteUsuario As Integer) As CtaCteItemUsuario
        Dim ctacte = Obtener(idCtaCteUsuario, "CtaCteUsuarioObtener")
        Try
            ctacte.Comprobante = comprobante_Mapper.Obtener(ctacte.IdComprobante)
        Catch ex As Exception
        End Try
        If ctacte.Comprobante Is Nothing Then
            ctacte.Comprobante = comprobanteNota_Mapper.Obtener(ctacte.IdComprobante)
        End If
        Return ctacte
    End Function

    Public Overrides Function Listar() As List(Of CtaCteItemUsuario)
        Dim cuentas = Listar("CtaCteUsuarioListar")
        For Each cuenta In cuentas
            If cuenta.Tipo = 1 Then
                cuenta.Comprobante = comprobante_Mapper.Obtener(cuenta.IdComprobante)
            Else
                cuenta.Comprobante = comprobanteNota_Mapper.Obtener(cuenta.IdComprobante)
            End If
            cuenta.Usuario = usuarioMapper.ConsultarPorId(cuenta.IdUsuario)
        Next
        Return cuentas
    End Function

    Public Function ListarPorUsuario(ByVal idUsuario As String) As List(Of CtaCteItemUsuario)
        Dim cuentas = Listar("CtaCteUsuarioListarPorUsuario", "IdUsuario", idUsuario)
        For Each cuenta In cuentas
            If cuenta.Tipo = 1 Then
                cuenta.Comprobante = comprobante_Mapper.Obtener(cuenta.IdComprobante) 'Comprobante
            Else
                cuenta.Comprobante = comprobanteNota_Mapper.Obtener(cuenta.IdComprobante) 'Comprobante Nota
            End If
        Next
        Return cuentas
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "CtaCteUsuarioBorrar")
    End Function
End Class
