<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="Bitacora.aspx.vb" Inherits="Agorobots.Bitacora" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
    <script>
        $(function () {
            $("input.datepicker").datepicker();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10103" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <asp:Label ID="fInicio_116" runat="server" Text="fecha inicio"></asp:Label>
    <br />
    <input type="text" id="txtFechaInicio" class="datepicker" runat="server" readonly="readonly">
    ->
    <input type="text" id="txtFechaFin" class="datepicker" runat="server" readonly="readonly">&nbsp;
    <asp:Button ID="filtrarFechas" runat="server" Text=">" CssClass="w3-btn w3-khaki"/>
    &nbsp;&nbsp;
    <asp:Button ID="limpiar_36" runat="server" CssClass="w3-btn w3-khaki" Text="limpiar" />
    <br />
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
                    <EmptyDataTemplate>
                        <asp:Label ID="sindatos_3" Text="sin datos" runat="server"></asp:Label>
                    </EmptyDataTemplate>
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
                                <asp:DropDownList ID="comboUsuarios" runat="server" CssClass="combosNegros"
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
                                <asp:DropDownList ID="comboTipos" runat="server" CssClass="combosNegros"
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
    <br />
    <br />
</asp:Content>
