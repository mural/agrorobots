<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="AbmComprobantes.aspx.vb" Inherits="Agorobots.AbmComprobantes" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
    <script>
        tinymce.init({
            plugins: "code",
            menubar: false,
            toolbar: "cut copy paste | searchreplace | bullist numlist | bold italic underline strikethrough | code",
            selector: 'textarea.editable'
        });
    </script>
    <script>
        $(function () {
            $("input.datepicker").datepicker();
        });
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual_10129" runat="server" Text="nav"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10129" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <br />
    <asp:Label ID="tipo_162" runat="server" Text="descripcion"></asp:Label>
    <asp:DropDownList ID="comboTipos" runat="server" AutoPostBack="True">
    </asp:DropDownList>
    <br />
    <br />
    <asp:Label ID="user_17" runat="server" Text="usuario"></asp:Label>
    <asp:DropDownList ID="comboUsuarios" runat="server" AutoPostBack="True">
    </asp:DropDownList>
    <br />
    <br />
    <asp:Label ID="desc_185" runat="server" Text="motivo"></asp:Label>
    <br />
    <textarea id="areaContenido" class="editable" style="width: 100%" runat="server"></textarea>
    <br />
    <br />
    <asp:Label ID="items_187" runat="server" Text="items"></asp:Label>
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="divItems">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridViewItems" runat="server"
                    ShowHeaderWhenEmpty="False"
                    AutoGenerateColumns="False"
                    RowStyle-CssClass="light"
                    AlternatingRowStyle-CssClass="dark"
                    AllowPaging="true" ShowFooter="False"
                    OnRowEditing="Edit"
                    OnRowUpdating="Update" OnRowCancelingEdit="CancelEdit"
                    PageSize="10">
                    <Columns>
                        <asp:TemplateField HeaderText="ID" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblID" runat="server"
                                    Text='<%# Eval("ID")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:Label ID="lblDetalle" runat="server"
                                    Text='<%# Eval("Detalle")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDetalle" runat="server"
                                    Text='<%# Eval("Detalle")%>' CausesValidation="False"
                                    onkeypress="return alfanumerico1(event)"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)"> </asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="$">
                            <ItemTemplate>
                                <asp:Label ID="lblPrecioUnitario" runat="server"
                                    Text='<%# Eval("PrecioUnitario")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPrecioUnitario" runat="server"
                                    Text='<%# Eval("PrecioUnitario")%>' CausesValidation="False"
                                    onkeypress="return alfanumerico1(event)"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)"> </asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkBorrar" runat="server"
                                    CommandArgument='<%# Eval("ID")%>' OnClientClick="return confirm(mensajeBorrar)"
                                    Text="borrar" OnClick="BorrarItem"> <img src="/Imagenes/borrar.png" alt="x" /></asp:LinkButton>
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
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridViewItems" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:TextBox ID="txtDetalleItem" runat="server" MaxLength="30" CssClass="entradaTexto"
            onkeypress="return alfanumerico1(event)"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
        </asp:TextBox>

        <asp:Button ID="btnAdd_5" runat="server" Text="agregar" OnClick="NuevoItem" CssClass="w3-btn w3-khaki"/>
        <br />
    </div>
    <br />
    &nbsp;
    <asp:Button ID="btnCrear_32" runat="server" Text="crear" CssClass="w3-btn w3-khaki"/>
    &nbsp;
    <br />
    <br />
    <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
    <br />
    <br />
    <div id="dvGrid">
        <br />
        <asp:GridView ID="GridView1_" runat="server"
            ShowHeaderWhenEmpty="True"
            AutoGenerateColumns="False"
            RowStyle-CssClass="light"
            AlternatingRowStyle-CssClass="dark"
            AllowPaging="true" ShowFooter="False"
            OnPageIndexChanging="OnPaging"
            PageSize="20">
            <EmptyDataTemplate>
                <asp:Label ID="sindatos_3" Text="sin datos" runat="server"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField HeaderText="tipo_162">
                    <ItemTemplate>
                        <asp:Label ID="lblTipo" runat="server"
                            Text='<%# ObtenerTipo(Eval("ID"))%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="estado_112">
                    <ItemTemplate>
                        <asp:Label ID="lblEstado" runat="server"
                            Text='<%# Eval("Estado")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="concepto_142">
                    <ItemTemplate>
                        <asp:Label ID="lblConcepto" runat="server"
                            Text='<%# ObtenerDetalle(Eval("ID"))%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="monto_138">
                    <ItemTemplate>
                        <asp:Label ID="lblMonto" runat="server"
                            Text='<%# ObtenerMontoTotal(Eval("ID"))%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="PDF">
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkPdf" runat="server"
                            OnClick="PDF" CommandArgument='<%# Eval("ID")%>'
                            CssClass="tablaDatosAction" ImageUrl="/Imagenes/pdf.png"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
    </div>
</asp:Content>
