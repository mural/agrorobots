Namespace CustomMinValidator

    Public Class MinLengthValidator
        Inherits BaseValidator

        Private _minLength As String
        Public Property MinLength() As String
            Get
                Return _minLength
            End Get
            Set(ByVal value As String)
                _minLength = value
            End Set
        End Property

        Protected Overrides Function ControlPropertiesValid() As Boolean
            Return True
        End Function

        Protected Overrides Function EvaluateIsValid() As Boolean
            Dim _tb As TextBox = Me.FindControl(Me.ControlToValidate)
            Return _tb.Text.Trim().Length >= Me.MinLength
        End Function

        Protected Overrides Sub OnPreRender(e As EventArgs)
            MyBase.OnPreRender(e)
        End Sub

        Public Sub New()

        End Sub
    End Class
End Namespace