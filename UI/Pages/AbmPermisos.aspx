<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="AbmPermisos.aspx.vb" Inherits="Agorobots.AbmPermisos" %>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10106" runat="server" Text="titulo"></asp:Label>
    </h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="dvGrid">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
                <br />

                <asp:GridView ID="GridView1_" runat="server"
                    AutoGenerateColumns="False" ShowFooter="True"
                    HeaderStyle-CssClass="tablaDatosHeader" CssClass="tablaDatos"
                    AlternatingRowStyle-CssClass="tablaDatosAlternate"
                    OnRowEditing="Edit"
                    OnRowUpdating="Update" OnRowCancelingEdit="CancelEdit">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="lblID" runat="server"
                                    Text='<%# Eval("ID")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Nombre_11">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server"
                                    Text='<%# Eval("Name")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName" runat="server"
                                    Text='<%# Eval("Name")%>'
                                    onkeypress="return alfanumerico1(event)"
                                    onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
                                </asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtName"
                                    MaxLength="15" runat="server"
                                    onkeypress="return alfanumerico1(event)"
                                    onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
                                </asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Descripcion_12">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion" runat="server"
                                    Text='<%# Eval("Descripcion")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescripcion" runat="server"
                                    Text='<%# Eval("Descripcion")%>'
                                    onkeypress="return alfanumerico1(event)"
                                    onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
                                </asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtDescripcion"
                                    MaxLength="35" runat="server"
                                    onkeypress="return alfanumerico1(event)"
                                    onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
                                </asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="selec_801" runat="server" CausesValidation="False"
                                    CssClass="tablaDatosAction" CommandName="Select" Text="Select"></asp:LinkButton>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Button ID="btnAdd_5" runat="server" Text="agregar"
                                    OnClick="AddNew" />
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkRemove_13" runat="server"
                                    CommandArgument='<%# Eval("ID")%>'
                                    OnClientClick="return confirm(mensajeBorrar)"
                                    Text="borrar" OnClick="Delete"></asp:LinkButton>
                            </ItemTemplate>
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
                    <HeaderStyle CssClass="tablaDatosHeader" />
                </asp:GridView>
                <br />
                <asp:Label ID="lblFamiliaActual_403" runat="server"
                    Text="Familia seleccionada: -"></asp:Label>
                <asp:Label ID="lblFamiliaSeleccionada" runat="server"
                    Text="Familia seleccionada: -"></asp:Label>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1_" />
            </Triggers>
        </asp:UpdatePanel>
    </div>

    <br />
    <div id="dvGrid2">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView2_" runat="server"
                    AutoGenerateColumns="False" HeaderStyle-CssClass="tablaDatosHeader"
                    CssClass="tablaDatos"
                    AlternatingRowStyle-CssClass="tablaDatosAlternate">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="lblID" runat="server"
                                    Text='<%# Eval("ID")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Nombre_11">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server"
                                    Text='<%# Eval("Name")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Descripcion_12">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion" runat="server"
                                    Text='<%# Eval("Descripcion")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ControlID_805">
                            <ItemTemplate>
                                <asp:Label ID="lblControlID" runat="server"
                                    Text='<%# Eval("ControlID")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="URL">
                            <ItemTemplate>
                                <asp:Label ID="lblURL" runat="server"
                                    Text='<%# Eval("URL")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Select_801">
                            <ItemTemplate>
                                <asp:CheckBox ID="cbItem" CssClass="gridCB" runat="server"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1_" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <br />
    <asp:Button ID="btnActualizar_405" runat="server" Text="Actualizar" />
    <br />
    <br />
</asp:Content>
