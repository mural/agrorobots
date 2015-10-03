<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="Bitacora.aspx.vb" Inherits="Agorobots.Bitacora" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
    <script>
        $(function () {
            $("#datepicker").datepicker();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10103" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <asp:TextBox ID="DateDe" name="Datede" runat="server" ReadOnly="true" CssClass="hasDatepicker"></asp:TextBox>
    <input type="text" value="9/23/2009" style="width: 100px;" name="Date" id="Date1" class="hasDatepicker"/>
    <p>Date: <input type="text" id="datepicker"></p>
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="dvGrid">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1_" runat="server"
                    AutoGenerateColumns="False"
                    RowStyle-CssClass="light"
                    AlternatingRowStyle-CssClass="dark"
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
