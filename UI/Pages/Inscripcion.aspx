﻿<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="Inscripcion.aspx.vb" Inherits="Agorobots.Inscripcion" %>

<%@ Import Namespace="Agorobots" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
    <script type="text/javascript">
        function completarTarjeta() {
            var inputTipoTarjetaHiddenVar = document.getElementById("<%:inputTipoTarjetaHidden.ClientID%>");
            inputTipoTarjetaHiddenVar.value = card.cardType;
            var inputNumeroTarjetaHiddenVar = document.getElementById("<%:inputNumeroTarjetaHidden.ClientID%>");
            inputNumeroTarjetaHiddenVar.value = document.getElementById("inputNumeroTarjeta").value;
            var inputNombreTarjetaHiddenVar = document.getElementById("<%:inputNombreTarjetaHidden.ClientID%>");
            inputNombreTarjetaHiddenVar.value = document.getElementById("inputNombreTarjeta").value;
            var inputVtoTarjetaHiddenVar = document.getElementById("<%:inputVtoTarjetaHidden.ClientID%>");
            inputVtoTarjetaHiddenVar.value = document.getElementById("inputVtoTarjeta").value;
            var inputCodTarjetaHiddenVar = document.getElementById("<%:inputCodTarjetaHidden.ClientID%>");
            inputCodTarjetaHiddenVar.value = document.getElementById("inputCodTarjeta").value;
        }
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href='<%= PaginasConocidas.CATALOGO%>'>
            <asp:Label ID="navCatalogo_50" runat="server" Text="catalogo"></asp:Label>
        </a>
    </li>
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="nav_57" runat="server" Text="inscribir"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2></h2>
    <br />
    <div class='w3-card-4'>
        <header class='w3-container w3-blue'>
            <h2 class="w3-blue">
                <asp:Label ID="lblTitulo_124" runat="server" Text=""></asp:Label>
            </h2>
        </header>
        <div class='w3-container'>
            <img class="imagenMediana imagenMasSeparada fl_right w3-circle" src="/Imagenes/curso_generico.jpg" />
            <br />
            <asp:Label ID="nombre_11" runat="server" Text="nombre" CssClass="w3-text-blue w3-large"></asp:Label>
            <asp:GridView ID="GridView1_" runat="server"
                ShowHeader="False"
                RowStyle-CssClass="light"
                AlternatingRowStyle-CssClass="dark"
                AutoGenerateColumns="False"
                CssClass="">
                <EmptyDataTemplate>
                    <asp:Label ID="varrito_vacio" Text="el carrito esta vacio" runat="server"></asp:Label>
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="nombre" runat="server" Text='<%# Eval("Nombre")%>'>
                            </asp:Label>
                            &#x27a4;
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <br />
            <asp:Label ID="precio_41" runat="server" Text="precio" CssClass="w3-text-blue w3-large"></asp:Label>
            $&nbsp;<asp:Label ID="lblPrecio" runat="server" Text="precio"></asp:Label>
            <br />
            <br />
            <asp:Label ID="formadePago_121" runat="server" Text="forma de pago" CssClass="w3-text-blue w3-large"></asp:Label>
            &nbsp;
            <br />
            <asp:RadioButtonList ID="formaDePagoList" runat="server" AutoPostBack="True">
            </asp:RadioButtonList>
            <asp:Label ID="notaCredito_188" runat="server" Text="nota de credito"></asp:Label>
            <asp:DropDownList ID="comboNotasCredito" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            &nbsp;<asp:Label ID="notaCreditoEstado" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <asp:Panel ID="panelTarjeta" runat="server" Visible="True">
                <input type="hidden" id="inputTipoTarjetaHidden" runat="server" />
                <input type="hidden" id="inputNumeroTarjetaHidden" runat="server" />
                <input type="hidden" id="inputNombreTarjetaHidden" runat="server" />
                <input type="hidden" id="inputVtoTarjetaHidden" runat="server" />
                <input type="hidden" id="inputCodTarjetaHidden" runat="server" />
                <asp:Label ID="numeroTarjeta_126" runat="server" Text="numero" CssClass="w3-text-blue w3-large"></asp:Label>
                &nbsp;<input id="inputNumeroTarjeta" type="text" name="number" maxlength="22" value='<%= Inscripcion.NumeroTarjetaGuardada%>' />
                <br />
                <br />
                <asp:Label ID="nombreTarjeta_127" runat="server" Text="nombre" CssClass="w3-text-blue w3-large"></asp:Label>
                &nbsp;<input id="inputNombreTarjeta" type="text" name="name" maxlength="50" value='<%= Inscripcion.NombreTarjetaGuardada%>' />
                <br />
                <br />
                <asp:Label ID="fechaVtoTarjeta_128" runat="server" Text="fecha vto" CssClass="w3-text-blue w3-large"></asp:Label>
                &nbsp;<input id="inputVtoTarjeta" type="text" name="expiry" maxlength="10" value='<%= Inscripcion.FechaTarjetaGuardada%>' />
                <br />
                <br />
                <asp:Label ID="codigoTarjeta_129" runat="server" Text="cod." CssClass="w3-text-blue w3-large"></asp:Label>
                &nbsp;<input id="inputCodTarjeta" type="text" name="cvc" maxlength="4" />
                <br />
                <br />
                <asp:Label ID="guardarTarjeta_143" runat="server" Text="guardar tarjeta" CssClass="w3-text-blue w3-large"></asp:Label>
                &nbsp;<asp:CheckBox ID="cbxGuardarTarjeta" runat="server" Checked="true" />
                <br />
                <br />
                <div class="card-wrapper"></div>
            </asp:Panel>
            <br />
            <br />
            <asp:Button ID="inscribirse_118" runat="server" Text="confirmar" CssClass="w3-btn w3-blue" OnClientClick="completarTarjeta()" />
            <br />
            <br />
        </div>
    </div>
    <br />
    <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
    <br />
    <br />
    <!-- at the end of BODY -->
    <script src="/Scripts/card.js"></script>
    <script type="text/javascript">
        var card = new Card({
            form: 'form',
            container: '.card-wrapper',
            debug: true // optional - default false
        });

        document.getElementById("inputNumeroTarjeta").focus(); // importante para cargar el tipo de tarjeta
    </script>
</asp:Content>
