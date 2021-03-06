﻿Imports EE
Imports Business

Public Class Bitacora
    Inherits PaginaAutorizada

    Dim bitacora_Business As New Business.Bitacora_Business
    Dim filtro = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarBitacora()
        End If
    End Sub

    Private Sub CargarBitacora()
        Dim entradas = bitacora_Business.GetItemsBitacora(Session("filtroBitacoraUsuario"), Session("filtroBitacoraTipos"), Session("filtroBitacoraInicio"), Session("filtroBitacoraFin"))
        Me.GridView1_.DataSource = entradas
        Me.GridView1_.DataBind()

        If entradas.Count > 0 Then
            Dim comboUsuarios = DirectCast(Me.GridView1_.HeaderRow.FindControl("comboUsuarios"), DropDownList)
            Dim comboTipos = DirectCast(Me.GridView1_.HeaderRow.FindControl("comboTipos"), DropDownList)
            'cargar combo usuarios
            For Each entrada In bitacora_Business.GetItemsBitacora()
                If Not comboUsuarios.Items.Contains(New ListItem(entrada.Usuario)) Then
                    comboUsuarios.Items.Add(entrada.Usuario)
                End If
            Next
            'cargar combo tipos
            For Each entrada In bitacora_Business.GetItemsBitacora(Session("filtroBitacoraUsuario"))
                If Not comboTipos.Items.Contains(New ListItem(entrada.Tipo)) Then
                    comboTipos.Items.Add(entrada.Tipo)
                End If
            Next
            comboUsuarios.SelectedValue = Session("filtroBitacoraUsuario")
            comboTipos.SelectedValue = Session("filtroBitacoraTipos")
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarBitacora()
        TraducirLoopingControls(Me)
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarBitacora()

        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Protected Sub Sort(sender As Object, e As GridViewSortEventArgs)

        Dim items = bitacora_Business.GetItemsBitacora

        ' The DataView provides an easy way to sort. Simply set the
        ' Sort property with the name of the field to sort by.
        items.Sort()

        ' Re-bind the data source and specify that it should be sorted
        ' by the field specified in the SortExpression property.
        GridView1_.DataSource = items
        GridView1_.DataBind()

    End Sub

    Protected Sub UserFilter(ByVal sender As Object, ByVal e As EventArgs)
        Dim comboUsuarios As DropDownList = DirectCast(sender, DropDownList)
        Session("filtroBitacoraUsuario") = comboUsuarios.SelectedValue
        Session("filtroBitacoraTipos") = ""
    End Sub

    Protected Sub TipoFilter(ByVal sender As Object, ByVal e As EventArgs)
        Dim comboTipos As DropDownList = DirectCast(sender, DropDownList)
        Session("filtroBitacoraTipos") = comboTipos.SelectedValue
    End Sub

    Protected Sub limpiar_36_Click(sender As Object, e As EventArgs) Handles limpiar_36.Click
        Session("filtroBitacoraUsuario") = ""
        Session("filtroBitacoraTipos") = ""
        Session("filtroBitacoraInicio") = Nothing
        txtFechaInicio.Value = ""
        Session("filtroBitacoraFin") = Nothing
        txtFechaFin.Value = ""

        CargarBitacora()
    End Sub

    Protected Sub filtrarFechas_Click(sender As Object, e As EventArgs) Handles filtrarFechas.Click
        Try
            Dim FechaInicio = Date.ParseExact(txtFechaInicio.Value, "MM/dd/yyyy", Nothing)
            Session("filtroBitacoraInicio") = FechaInicio
        Catch ex As Exception
            Session("filtroBitacoraInicio") = Nothing
        End Try
        Try
            Dim FechaFin = Date.ParseExact(txtFechaFin.Value, "MM/dd/yyyy", Nothing)
            Session("filtroBitacoraFin") = FechaFin
        Catch ex As Exception
            Session("filtroBitacoraFin") = Nothing
        End Try
        
        CargarBitacora()
    End Sub
End Class