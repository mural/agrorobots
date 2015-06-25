Public Class Candidato

    Private _ID As String
    Public Property ID() As String
        Get
            Return _ID
        End Get
        Set(ByVal value As String)
            _ID = value
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

    Public Sub New(ByVal vID As Integer, ByVal vPerfil As Perfil)
        Me.ID = vID
        Me.Perfil = vPerfil
    End Sub

End Class
