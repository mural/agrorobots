<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Carreras.aspx.vb" Inherits="Agorobots.Carreras" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .auto-style1 {
            width: 22px;
            height: 16px;
        }
    </style>
</asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
    -
    <asp:Label ID="titlelistadocarreras_50" runat="server" Text="Label"></asp:Label>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        <asp:Label ID="listadocarreras_50" runat="server" Text="Label"></asp:Label></h2>
    <div class="main">
        <asp:GridView ID="GridView1_" runat="server"
            ShowHeader="False"
            AlternatingRowStyle-CssClass="tablaDatosAlternate"
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
        <br />
        <br />
        <asp:HyperLink ID="comparar" runat="server" NavigateUrl="Comparacion.aspx">
            <asp:Label ID="comparacion_51" runat="server" Text="Label"></asp:Label>
        </asp:HyperLink>
        <br />
    </div>

</asp:Content>
