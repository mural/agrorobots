<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AbmTraducciones.aspx.vb" Inherits="Agorobots.AbmTraducciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var mensajeBorrar = '<%= MensajeBorrar %>';
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10102" runat="server" Text="titulo"></asp:Label>
    </h2>
    <div id="dvGrid2">
        <asp:GridView ID="GridView2_" runat="server"
            AutoGenerateColumns="false" HeaderStyle-CssClass="tablaDatosHeader"
            CssClass="tablaDatos"
            AlternatingRowStyle-CssClass="tablaDatosAlternate"
            PageSize="10">
            <Columns>
                <asp:TemplateField HeaderText="ID">
                    <ItemTemplate>
                        <asp:Label ID="lblIdiomaID" runat="server"
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
    <br />
    <br />
    </asp:Label><asp:TextBox ID="txtBusqueda" runat="server"></asp:TextBox><asp:Button ID="buscar_31" runat="server" Text="buscar" />
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="dvGrid">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
                <br />

                <asp:GridView ID="GridView1_" runat="server"
                    AutoGenerateColumns="false" HeaderStyle-CssClass="tablaDatosHeader"
                    CssClass="tablaDatos"
                    AlternatingRowStyle-CssClass="tablaDatosAlternate"
                    AllowPaging="true" ShowFooter="true"
                    OnPageIndexChanging="OnPaging" OnRowEditing="Edit"
                    OnRowUpdating="Update" OnRowCancelingEdit="CancelEdit"
                    PageSize="15">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="lblID" runat="server"
                                    Text='<%# Eval("ID")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="IdiomaID_804">
                            <ItemTemplate>
                                <asp:Label ID="lblIdiomaID" runat="server"
                                    Text='<%# Eval("Idioma.Descripcion")%>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtIdiomaID" Enabled="false" Visible="False"
                                    MaxLength="5" runat="server"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Traduccion_803">
                            <ItemTemplate>
                                <asp:Label ID="lblTraduccionName" runat="server"
                                    Text='<%# Eval("Traduccion")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTraduccionName" runat="server"
                                    Text='<%# Eval("Traduccion")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtTraduccion" runat="server"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Control ID">
                            <ItemTemplate>
                                <asp:Label ID="lblControlName" runat="server"
                                    Text='<%# Eval("Control_ID")%>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtControl" runat="server"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Original">
                            <ItemTemplate>
                                <asp:Label ID="lblOriginalName" runat="server"
                                    Text='<%# Eval("Original")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkRemove_13" runat="server"
                                    CommandArgument='<%# Eval("ID")%>'
                                    OnClientClick="return confirm(mensajeBorrar)"
                                    Text="Delete" OnClick="Delete"></asp:LinkButton>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Button ID="btnAdd_5" runat="server" Text="agregar"
                                    OnClick="AddNew" />
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="actualizar_405" runat="server" CausesValidation="True"
                                    CssClass="tablaDatosAction" CommandName="Update" Text="actualizar"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="cancelar_14" runat="server" CausesValidation="False"
                                    CssClass="tablaDatosAction" CommandName="Cancel" Text="cancelar"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="editar_7" runat="server" CausesValidation="False"
                                    CssClass="tablaDatosAction" CommandName="Edit" Text="editar"></asp:LinkButton>
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
        <br />
    </div>
</asp:Content>
