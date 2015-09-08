<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Bitacora.aspx.vb" Inherits="Agorobots.Bitacora" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10103" runat="server" Text="titulo"></asp:Label>
    </h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="dvGrid">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1_" runat="server"
                    AutoGenerateColumns="False" HeaderStyle-CssClass="tablaDatosHeader"
                    CssClass="tablaDatos" AlternatingRowStyle-CssClass="tablaDatosAlternate"
                    AllowSorting="True" OnSorting="Sort"
                    AllowPaging="True" OnPageIndexChanging="OnPaging" PageSize="20">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="lblIdiomaID" runat="server"
                                    Text='<%# Eval("ID")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="usuario_17" runat="server" Text="titulo"></asp:Label>
                                <asp:DropDownList ID="comboUsuarios" runat="server"
                                    OnSelectedIndexChanged="UserFilter" AutoPostBack="true"
                                    AppendDataBoundItems="true">
                                    <asp:ListItem Text="-----" Value=""></asp:ListItem>
                                </asp:DropDownList>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblUsuario" runat="server"
                                    Text='<%# Eval("Usuario")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="tipo_162" runat="server" Text="titulo"></asp:Label>
                                <asp:DropDownList ID="comboTipos" runat="server"
                                    OnSelectedIndexChanged="TipoFilter" AutoPostBack="true"
                                    AppendDataBoundItems="true">
                                    <asp:ListItem Text="-----" Value=""></asp:ListItem>
                                </asp:DropDownList>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTipo" runat="server"
                                    Text='<%# Eval("Tipo")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Detalle_132">
                            <ItemTemplate>
                                <asp:Label ID="lblDetalle" runat="server"
                                    Text='<%# Eval("Detalle")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Fecha_133" SortExpression="lblFecha">
                            <ItemTemplate>
                                <asp:Label ID="lblFecha" runat="server"
                                    Text='<%# Eval("Fecha")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <PagerSettings Mode="NumericFirstLast" FirstPageText="<--" LastPageText="-->" />
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1_" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <br />
    <asp:Button ID="limpiar_36" runat="server" Text="limpiar" />
    <br />
    <br />
</asp:Content>
