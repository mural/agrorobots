Public Class Empleado
    Implements IComparable

    Private _ID As String
    Public Property ID() As String
        Get
            Return _ID
        End Get
        Set(ByVal value As String)
            _ID = value
        End Set
    End Property

    Private _sueldo As Double
    Public Property Sueldo() As Double
        Get
            Return _sueldo
        End Get
        Set(ByVal value As Double)
            _sueldo = value
        End Set
    End Property

    Private _fechaIngreso As Date
    Public Property FechaIngreso() As Date
        Get
            Return _fechaIngreso
        End Get
        Set(ByVal value As Date)
            _fechaIngreso = value
        End Set
    End Property

    Private _fechaAscenso As Date
    Public Property FechaAscenso() As Date
        Get
            Return _fechaAscenso
        End Get
        Set(ByVal value As Date)
            _fechaAscenso = value
        End Set
    End Property

    Private _cargo As Producto
    Public Property Cargo() As Producto
        Get
            Return _cargo
        End Get
        Set(ByVal value As Producto)
            _cargo = value
        End Set
    End Property

    Private _perfil As Perfil
    Public Property Perfil() As Perfil
        Get
            Return _perfil
        End Get
        Set(ByVal value As Perfil)
            _perfil = value
        End Set
    End Property

    Private _puntaje As Double
    Public Property Puntaje() As Double
        Get
            Return _puntaje
        End Get
        Set(ByVal value As Double)
            _puntaje = value
        End Set
    End Property

    Private _FuturoCargo As String
    Public Property FuturoCargo() As String
        Get
            Return _FuturoCargo
        End Get
        Set(ByVal value As String)
            _FuturoCargo = value
        End Set
    End Property

    Private _futuroSueldo As Double
    Public Property FuturoSueldo() As Double
        Get
            Return _futuroSueldo
        End Get
        Set(ByVal value As Double)
            _futuroSueldo = value
        End Set
    End Property

    Public Sub New(ByVal vID As Integer, ByVal vSueldo As Double, ByVal vFechaIngreso As Date, ByVal vFechaAscenso As Date, ByRef vPerfil As Perfil, ByRef vCargo As Producto)
        Me.ID = vID
        Me.Sueldo = vSueldo
        Me.FechaIngreso = vFechaIngreso
        Me.FechaAscenso = vFechaAscenso
        Me.Perfil = vPerfil
        Me.Cargo = vCargo
    End Sub

    Public Function CompareTo(ByVal obj As Object) As Integer Implements System.IComparable.CompareTo
        Return String.Compare(Puntaje.ToString, obj.Puntaje.ToString)
    End Function
End Class
