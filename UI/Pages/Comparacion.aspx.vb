Imports Business
Imports EE

Public Class Comparacion
    Inherits PaginaGenerica

    Dim elementoAcademico_Business As New ElementoAcademico_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            CargarElementosAcademicos()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarElementosAcademicos()
        Try
            comboElemento1.Items.Clear()
            comboElemento1.Items.Add(New ListItem("-----", "-----"))
            For Each elementoCombo1 In elementoAcademico_Business.Listar
                comboElemento1.Items.Add(New ListItem(elementoCombo1.Nombre, elementoCombo1.CodigoAcademico))
            Next

        Catch e As Exception
        End Try
    End Sub

    Protected Sub Elemento1(ByVal sender As Object, ByVal e As EventArgs)
        LimpiarComparacion()

        comboElemento2.Items.Clear()
        comboElemento2.Items.Add(New ListItem("-----", "-----"))
        If Not comboElemento1.SelectedValue.Equals("-----") Then
            For Each elementoCombo2 In elementoAcademico_Business.Listar
                If Not CInt(comboElemento1.SelectedValue).Equals(elementoCombo2.CodigoAcademico) Then
                    comboElemento2.Items.Add(New ListItem(elementoCombo2.Nombre, elementoCombo2.CodigoAcademico))
                End If
            Next
        End If

        comboElemento3.Items.Clear()
        comboElemento3.Items.Add(New ListItem("-----", "-----"))
        CargarComparacion()
    End Sub

    Protected Sub Elemento2(ByVal sender As Object, ByVal e As EventArgs)
        comboElemento3.Items.Clear()
        comboElemento3.Items.Add(New ListItem("-----", "-----"))
        If Not comboElemento2.SelectedValue.Equals("-----") Then
            For Each elementoCombo3 In elementoAcademico_Business.Listar
                If Not CInt(comboElemento2.SelectedValue).Equals(elementoCombo3.CodigoAcademico) And
                    Not CInt(comboElemento1.SelectedValue).Equals(elementoCombo3.CodigoAcademico) Then
                    comboElemento3.Items.Add(New ListItem(elementoCombo3.Nombre, elementoCombo3.CodigoAcademico))
                End If
            Next
        End If

        CargarComparacion()
    End Sub

    Protected Sub Elemento3(ByVal sender As Object, ByVal e As EventArgs)
        CargarComparacion()
    End Sub

    Private Sub CargarComparacion(Optional ByVal precio As Boolean = False)
        LimpiarComparacion()

        If Not comboElemento1.SelectedValue.Equals("-----") Then
            Dim comparacion As New List(Of ElementoAcademico)
            comparacion.Add(elementoAcademico_Business.Obtener(comboElemento1.SelectedValue))

            If Not comboElemento2.SelectedValue.Equals("-----") Then
                comparacion.Add(elementoAcademico_Business.Obtener(comboElemento2.SelectedValue))
            End If
            If Not comboElemento3.SelectedValue.Equals("-----") Then
                comparacion.Add(elementoAcademico_Business.Obtener(comboElemento3.SelectedValue))
            End If

            If precio Then
                comparacion.Sort(New PrecioComparador)
            End If

            Me.GridView1_.DataSource = comparacion
            Me.GridView1_.DataBind()
        End If
    End Sub

    Private Sub LimpiarComparacion()
        Me.GridView1_.DataSource = Nothing
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub Ordenar(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
        Dim sortExpression = e.SortExpression

        If sortExpression.Equals("precio") Then
            CargarComparacion(True)
        End If

    End Sub

    Friend Class PrecioComparador
        Implements IComparer(Of ElementoAcademico)

        Public Function Compare(x As ElementoAcademico, y As ElementoAcademico) As Integer Implements IComparer(Of ElementoAcademico).Compare
            Return x.Precio.CompareTo(y.Precio)
        End Function

    End Class

End Class