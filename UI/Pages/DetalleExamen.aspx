<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="DetalleExamen.aspx.vb" Inherits="Agorobots.DetalleExamen" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual_147" runat="server" Text="clases"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_147" runat="server" Text="examen"></asp:Label></h2>
    <br />
    <div class='w3-card-4'>
        <header class='w3-container w3-blue'>
            <h2 class="w3-blue">
                <asp:Label ID="lblExamen_147" runat="server" Text="examen"></asp:Label>
            </h2>
        </header>
        <div class='w3-container'>
            <img class="imagenMediana imagenMasSeparada fl_right w3-circle" src="/Imagenes/curso_generico.jpg" />
            <br />
            <br />
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:Timer ID="TimerExamen" runat="server"></asp:Timer>
            <asp:UpdatePanel ID="PanelTiempo" runat="server">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="TimerExamen" EventName="Tick" />
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="lblTiempo" runat="server" Text="-" CssClass="formError"></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <asp:Panel ID="examenInicio" runat="server" Text="inicio"></asp:Panel>
            <br />
            <br />
            <asp:Panel ID="examenCierre" runat="server" Text="cierre"></asp:Panel>
            <br />
            <br />
        </div>
    </div>
    <br />
    <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
    <br />
</asp:Content>
