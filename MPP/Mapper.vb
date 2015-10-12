Public MustInherit Class Mapper(Of EE As New)
    Implements IMapper(Of EE)


    Public Property Transaccion = AccionTransaccion.Unica
    Enum AccionTransaccion
        Unica
        Iniciar
        Continuar
        Cerrar
    End Enum

    Protected Property CampoClave = "ID"
    Protected oDatos As DAL.Datos
    Protected hdatos As New Hashtable
    Protected DS As New DataSet

    Public Sub Preparar()
        oDatos = DAL.Datos.InstanciaDatos()
        hdatos = New Hashtable
        DS = New DataSet
    End Sub

    Public Overridable Function Insertar(ByRef obj As EE) As Boolean Implements IMapper(Of EE).Insertar
        Return Actualizar(obj, True)
    End Function

    MustOverride Sub OBJaHASH(ByRef obj As EE, ByRef Item As Hashtable)

    Protected Overridable Function Actualizar(ByRef obj As EE, ByVal nombreProcedimiento As String, Optional ByVal insertar As Boolean = False) As Boolean
        Preparar()

        OBJaHASH(obj, hdatos)
        If insertar Then
            hdatos.Add("@" + CampoClave, 0) 'sobrescribo el ID a 0
        End If

        Return EscribirConTransaccion(nombreProcedimiento, hdatos)
    End Function

    MustOverride Function Actualizar(ByRef obj As EE, Optional ByVal insertar As Boolean = False) As Boolean Implements IMapper(Of EE).Actualizar

    MustOverride Sub DSaEE(ByRef obj As EE, ByRef Item As DataRow)

    Protected Overridable Function Obtener(ByVal id As Integer, ByVal nombreProcedimiento As String, Optional ByVal campoObtener As String = "") As EE
        Preparar()

        If Not String.IsNullOrEmpty(campoObtener) Then
            hdatos.Add("@" + campoObtener, id)
        Else
            hdatos.Add("@" + CampoClave, id)
        End If

        DS = oDatos.Leer(nombreProcedimiento, hdatos)
        Dim objNuevo = Nothing

        If DS.Tables(0).Rows.Count > 0 Then
            objNuevo = New EE
            For Each Item As DataRow In DS.Tables(0).Rows
                DSaEE(objNuevo, Item)
            Next
        End If
        Return objNuevo
    End Function

    MustOverride Function Obtener(ByVal id As Integer) As EE Implements IMapper(Of EE).Obtener

    Protected Overridable Function Listar(ByVal nombreProcedimiento As String) As List(Of EE)
        Preparar()

        DS = oDatos.Leer(nombreProcedimiento, hdatos)
        Dim listado As New List(Of EE)

        If DS.Tables(0).Rows.Count > 0 Then
            For Each Item As DataRow In DS.Tables(0).Rows
                Dim objNuevo As New EE

                DSaEE(objNuevo, Item)
                listado.Add(objNuevo)
            Next
        End If
        Return listado
    End Function

    MustOverride Function Listar() As List(Of EE) Implements IMapper(Of EE).Listar

    Protected Overridable Function Borrar(ByVal id As Integer, ByVal nombreProcedimiento As String, Optional ByVal campoBorrar As String = "") As Boolean
        Preparar()

        If Not String.IsNullOrEmpty(campoBorrar) Then
            hdatos.Add("@" + campoBorrar, id)
        Else
            hdatos.Add("@" + CampoClave, id)
        End If

        Return EscribirConTransaccion(nombreProcedimiento, hdatos)
    End Function

    MustOverride Function Borrar(id As Integer) As Boolean Implements IMapper(Of EE).Borrar


    Protected Function EscribirConTransaccion(ByRef nombreProcedimiento As String, ByRef hdatos As Hashtable)
        Dim resultado = False
        If Transaccion = AccionTransaccion.Unica Then
            resultado = oDatos.Escribir(nombreProcedimiento, hdatos)
        ElseIf Transaccion = AccionTransaccion.Iniciar Then
            resultado = oDatos.EscribirIniciandoTransaccion(nombreProcedimiento, hdatos)
        ElseIf Transaccion = AccionTransaccion.Continuar Then
            resultado = oDatos.EscribirContinuandoTransaccion(nombreProcedimiento, hdatos)
        ElseIf Transaccion = AccionTransaccion.Cerrar Then
            resultado = oDatos.EscribirCerrandoTransaccion(nombreProcedimiento, hdatos)
        End If
        Return resultado
    End Function

    Public Shared Function DbStringOrNull(ByRef Item As Object) As String
        Dim stringDb As String = Nothing
        If Not Item Is DBNull.Value Then
            stringDb = CStr(Item)
        End If
        Return stringDb
    End Function

    Public Shared Function DbImageOrNull(ByRef Item As Object) As Byte()
        Dim imageDb As Byte() = Nothing
        If Not Item Is DBNull.Value Then
            imageDb = CType(Item, Byte())
        End If
        Return imageDb
    End Function
End Class
