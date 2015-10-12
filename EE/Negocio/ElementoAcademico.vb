Public Class ElementoAcademico

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

    Public Sub New()
        FechaInicio = Now
    End Sub

    Public Function EstadoEnumATexto(ByVal elementoAcademicoEnum As ElementoAcademicoEnum) As String
        Select Case elementoAcademicoEnum
            Case elementoAcademicoEnum.NoIniciada
                Return "NoIniciada"
            Case elementoAcademicoEnum.SinContenido
                Return "SinContenido"
            Case elementoAcademicoEnum.ConContenido
                Return "ConContenido"
            Case elementoAcademicoEnum.ConContenidoRechazado
                Return "ConContenidoRechazado"
            Case elementoAcademicoEnum.Disponible
                Return "Disponible"
        End Select
        Return ""
    End Function

    Public Function TextoAEstadoEnum(ByVal estado As String) As ElementoAcademicoEnum
        Select Case estado
            Case "NoIniciada"
                Return ElementoAcademicoEnum.NoIniciada
            Case "SinContenido"
                Return ElementoAcademicoEnum.SinContenido
            Case "ConContenido"
                Return ElementoAcademicoEnum.ConContenido
            Case "ConContenidoRechazado"
                Return ElementoAcademicoEnum.ConContenidoRechazado
            Case "Disponible"
                Return ElementoAcademicoEnum.Disponible
            Case Else
                Return ElementoAcademicoEnum.NoIniciada
        End Select
    End Function
End Class
