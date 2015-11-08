<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.Master" CodeBehind="Carreras.aspx.vb" Inherits="Agorobots.Carreras" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navCatalogo_55" runat="server" Text="catalogo"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="BodyContenido" runat="server" ContentPlaceHolderID="BodyNavegacionContenido">
    <div class="wrapper col4">
        <div id="container">
            <h2>
                <asp:Label ID="listado_55" runat="server" Text="Label"></asp:Label>
            </h2>
            <br />
            <asp:GridView ID="GridView1_" runat="server"
                ShowHeader="False"
                RowStyle-CssClass="light"
                AlternatingRowStyle-CssClass="dark"
                AutoGenerateColumns="False"
                CssClass="tablaDatos">
                <Columns>
                    <asp:TemplateField ShowHeader="false">
                        <ItemTemplate>
                            <asp:Label ID="linkNombre" runat="server" Text='<%# Eval("Nombre")%>'>
                            </asp:Label>
                            &#x27a4;
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSeleccionar_801" runat="server" CausesValidation="False"
                                OnClick="Selection" CommandArgument='<%# Eval("CodigoAcademico")%>'
                                Text="seleccionar" CssClass="tablaDatosAction"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
        </div>
    </div>
</asp:Content>
