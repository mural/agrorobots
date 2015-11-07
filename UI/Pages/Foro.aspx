<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="Foro.aspx.vb" Inherits="Agorobots.Foro" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual_10128" runat="server" Text="foro "></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10128" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <div id="dvGrid">
        <asp:GridView ID="GridComentarios" runat="server"
            ShowHeader="False"
            RowStyle-CssClass="light"
            AlternatingRowStyle-CssClass="dark"
            AutoGenerateColumns="False"
            CssClass="tablaDatos">
            <EmptyDataTemplate>
                <asp:Label ID="sindatos_3" Text="sin datos" runat="server"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                        <asp:Label ID="lblComentario" runat="server" Text='<%# Eval("Comentario")%>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                        <asp:Label ID="lblApellido" runat="server" Text='<%# Eval("Usuario.Apellido")%>'>
                        </asp:Label>
                        <asp:Label ID="lblNombre" runat="server" Text='<%# Eval("Usuario.Nombre")%>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                        <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("Fecha")%>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:Panel ID="panelComentario" runat="server" Visible="True">
            <asp:TextBox ID="comentario" runat="server"></asp:TextBox>
            &nbsp;
                <asp:Button ID="Comentar_135" runat="server" Text="enviar" />
        </asp:Panel>
        <br />
    </div>
    <br />
</asp:Content>
