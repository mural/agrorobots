Public Class ElementoAcademico
    Implements IEquatable(Of ElementoAcademico)

    Public Property EstadoActual = ElementoAcademicoEnum.NoIniciada
    Enum ElementoAcademicoEnum
        NoIniciada
        SinContenido
        ConContenido
        ConContenidoRechazado
        Disponible
    End Enum

    Public Property CodigoAcademico As Integer '(int, not null)
    Public Property Comentario As String '(varchar(255), null)
    Public Property Contenido As String '(varchar(255), null)
    Public Property CriteriosAprobacion As String '(varchar(255), null)
    Public Property Descripcion As String '(varchar(255), null)
    Public Property Duracion As Integer '(int, null)
    Public Property FechaInicio As DateTime '(date, null)
    Public Property Nombre As String '(varchar(100), null)
    Public Property Temas As String '(varchar(255), null)
    Public Property Cupo As Integer '(int, null)
    Public Property Clases As Integer '(int, null)
    Public Property Precio As Decimal '(decimal(18,2), null)
    Public Property Imagen() As Byte()
    Public Property Estado As String
    Public Property Alumnos As List(Of Usuario)
    Public Property Profesor As Usuario

    Public Sub New()
        FechaInicio = Now
        Me.Alumnos = New List(Of Usuario)
    End Sub

    Public Function EstadoEnumATexto(ByVal elementoAcademicoEnum As ElementoAcademicoEnum) As String
        Select Case elementoAcademicoEnum
            Case elementoAcademicoEnum.NoIniciada
                Return "NO_INICIADA"
            Case elementoAcademicoEnum.SinContenido
                Return "SIN_CONTENIDO"
            Case elementoAcademicoEnum.ConContenido
                Return "CON_CONTENIDO"
            Case elementoAcademicoEnum.ConContenidoRechazado
                Return "CON_CONTENIDO_RECHAZADO"
            Case elementoAcademicoEnum.Disponible
                Return "DISPONIBLE"
        End Select
        Return ""
    End Function

    Public Function TextoAEstadoEnum(ByVal estado As String) As ElementoAcademicoEnum
        Select Case estado
            Case "NO_INICIADA"
                Return ElementoAcademicoEnum.NoIniciada
            Case "SIN_CONTENIDO"
                Return ElementoAcademicoEnum.SinContenido
            Case "CON_CONTENIDO"
                Return ElementoAcademicoEnum.ConContenido
            Case "CON_CONTENIDO_RECHAZADO"
                Return ElementoAcademicoEnum.ConContenidoRechazado
            Case "DISPONIBLE"
                Return ElementoAcademicoEnum.Disponible
            Case Else
                Return ElementoAcademicoEnum.NoIniciada
        End Select
    End Function

    Public Overloads Function Equals(other As ElementoAcademico) As Boolean Implements IEquatable(Of ElementoAcademico).Equals
        Return CodigoAcademico.Equals(other.CodigoAcademico)
    End Function
End Class
