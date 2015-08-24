<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="CambioIdioma.aspx.vb" Inherits="Agorobots.CambioIdioma" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10006" runat="server" Text="titulo"></asp:Label>
    </h2>
    <div id="dvGrid">
        <asp:GridView ID="GridView1_" runat="server"
            AutoGenerateColumns="False" HeaderStyle-CssClass="tablaDatosHeader"
            AlternatingRowStyle-CssClass="tablaDatosAlternate" CssClass ="tablaDatos"
            AllowPaging="True" PageSize="10">
            <AlternatingRowStyle CssClass="tablaDatosAlternate"></AlternatingRowStyle>
            <Columns>
                <asp:TemplateField HeaderText="ID">
                    <ItemTemplate>
                        <asp:Label ID="lblID" runat="server"
                            Text='<%# Eval("ID")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Descripcion_12">
                    <ItemTemplate>
                        <asp:Label ID="lblDescripcion" runat="server"
                            Text='<%# Eval("Descripcion")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkSeleccionar_801" runat="server" CausesValidation="False"
                            CommandName="Select" Text="seleccionar" CssClass="tablaDatosAction"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

        </asp:GridView>
    </div>
</asp:Content>

