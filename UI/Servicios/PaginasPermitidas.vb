Public Class PaginasPermitidas
    Private Shared _paginasPermitidas As PaginasPermitidas
    Private Shared _listadoPaginas As New List(Of String)

    'SINGLETON
    Public Shared Function GetInstance() As PaginasPermitidas
        If IsNothing(_paginasPermitidas) Then
            _paginasPermitidas = New PaginasPermitidas
            _listadoPaginas.Add("Pantalla_Principal.aspx")
            _listadoPaginas.Add("CambioClave.aspx")
            _listadoPaginas.Add("CambioIdioma.aspx")
            _listadoPaginas.Add("SinPermisos.aspx")
        End If

        Return _paginasPermitidas
    End Function

    Public Function GetPaginasPermitidas() As List(Of String)
        Return _listadoPaginas
    End Function
End Class
