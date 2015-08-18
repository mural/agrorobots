Public Class Producto
    Implements IComparable

    Private _descripcion As String
    Public Property Descripcion() As String
        Get
            Return _descripcion
        End Get
        Set(ByVal value As String)
            _descripcion = value
        End Set
    End Property

    Private _valor As Integer
    Public Property Valor() As Integer
        Get
            Return _valor
        End Get
        Set(ByVal value As Integer)
            _valor = value
        End Set
    End Property

    Private _ID As Integer
    Public Property ID() As Integer
        Get
            Return _ID
        End Get
        Set(ByVal Value As Integer)
            _ID = Value
        End Set
    End Property

    Private _valorMin As Double
    Public Property ValorMin() As Double
        Get
            Return _valorMin
        End Get
        Set(ByVal value As Double)
            _valorMin = value
        End Set
    End Property

    Private _valorMax As Double
    Public Property ValorMax() As Double
        Get
            Return _valorMax
        End Get
        Set(ByVal value As Double)
            _valorMax = value
        End Set
    End Property

    Private _siguiente As String
    Public Property Siguiente() As String
        Get
            Return _siguiente
        End Get
        Set(ByVal value As String)
            _siguiente = value
        End Set
    End Property


    Public Sub New(ByVal _ID As Integer, ByVal vDescripcion As String, ByVal vValor As Integer)
        Me.ID = _ID
        Me.Descripcion = vDescripcion
        Me.Valor = vValor
    End Sub

    Public Function CompareTo(ByVal obj As Object) As Integer Implements System.IComparable.CompareTo
        Return String.Compare(obj.Valor.ToString, Valor.ToString)
    End Function
End Class
