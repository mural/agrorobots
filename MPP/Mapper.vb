Public MustInherit Class Mapper(Of EE As New)
    Implements IMapper(Of EE)

    Protected Property CampoClave = "ID"
    Protected oDatos As New DAL.Datos
    Protected hdatos As New Hashtable
    Protected DS As New DataSet

    Public Sub Preparar()
        oDatos = New DAL.Datos
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

        Return oDatos.Escribir(nombreProcedimiento, hdatos)
    End Function

    MustOverride Function Actualizar(ByRef obj As EE, Optional ByVal insertar As Boolean = False) As Boolean Implements IMapper(Of EE).Actualizar

    MustOverride Sub DSaEE(ByRef obj As EE, ByRef Item As DataRow)

    Protected Overridable Function Obtener(ByVal idMensaje As Integer, ByVal nombreProcedimiento As String) As EE
        Preparar()

        hdatos.Add("@" + CampoClave, idMensaje)

        DS = oDatos.Leer(nombreProcedimiento, hdatos)
        Dim objNuevo As New EE

        If DS.Tables(0).Rows.Count > 0 Then
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

    Protected Overridable Function Borrar(ByVal id As Integer, ByVal nombreProcedimiento As String) As Boolean
        Preparar()

        hdatos.Add("@" + CampoClave, id)

        Return oDatos.Escribir(nombreProcedimiento, hdatos)
    End Function

    MustOverride Function Borrar(id As Integer) As Boolean Implements IMapper(Of EE).Borrar


End Class
