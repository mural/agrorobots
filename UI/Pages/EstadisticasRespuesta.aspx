﻿<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="EstadisticasRespuesta.aspx.vb" Inherits="Agorobots.EstadisticasRespuesta" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual_10117" runat="server" Text="nav"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10117" runat="server" Text="titulo"></asp:Label>
    </h2>

    <br />
</asp:Content>
