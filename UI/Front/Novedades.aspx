﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Novedades.aspx.vb" Inherits="Agorobots.Novedades" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadNavegacionContenido" runat="server">
    <script>
        $(function () {
            $("input.datepicker").datepicker();
        });
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navNovedades_3004" runat="server" Text="novedades"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="novedades_3004" runat="server" Text="novedades"></asp:Label>
            </h1>
            <p>
                <asp:DropDownList ID="comboTipos" runat="server" AutoPostBack="True"></asp:DropDownList>
            </p>
            <br />
            <asp:Label ID="fInicio_116" runat="server" Text="fecha inicio"></asp:Label>
            <br />
            <input type="text" id="txtFechaInicio" class="datepicker" runat="server" readonly="readonly">
            ->
            <input type="text" id="txtFechaFin" class="datepicker" runat="server" readonly="readonly">&nbsp;
            <asp:Button ID="filtrarFechas" runat="server" Text=">" />
            <br />
            <br />
            <asp:Button ID="limpiar_36" runat="server" Text="limpiar" />
            <br />
            <br />
            <asp:Literal ID="contenidoNovedades" runat="server"></asp:Literal>
        </div>
    </div>
</asp:Content>
