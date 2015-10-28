<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="EdicionExamen.aspx.vb" Inherits="Agorobots.EdicionExamen" %>

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
            <asp:Label ID="nav_10123" runat="server" Text="edicion material"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10114" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <br />
    <asp:Label ID="desc_12" runat="server" Text="descripcion"></asp:Label>
    <br />
    <br />
    <textarea id="areaContenido" class="editable" style="width: 100%" runat="server"></textarea>
    <br />
    <asp:DropDownList ID="comboTipos" runat="server">
        <asp:ListItem Value="PARCIAL">Parcial</asp:ListItem>
        <asp:ListItem Value="FINAL">Final</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    <asp:Label ID="preguntas_139" runat="server" Text="preguntas"></asp:Label>
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="divPreguntas">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridViewPreguntas" runat="server"
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

                        <asp:TemplateField ShowHeader="false">
                            <ItemTemplate>
                                <asp:Label ID="lblPregunta" runat="server"
                                    Text='<%# Eval("Pregunta")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPregunta" runat="server"
                                    Text='<%# Eval("Pregunta")%>' CausesValidation="False"
                                    onkeypress="return alfanumerico1(event)"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)"> </asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkBorrar" runat="server"
                                    CommandArgument='<%# Eval("ID")%>' OnClientClick="return confirm(mensajeBorrar)"
                                    Text="borrar" OnClick="BorrarPregunta"> <img src="/Imagenes/borrar.png" alt="x" /></asp:LinkButton>
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
                <asp:AsyncPostBackTrigger ControlID="GridViewPreguntas" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:TextBox ID="txtPregunta" runat="server" Enabled="false"
            onkeypress="return alfanumerico1(event)"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
        </asp:TextBox>

        <asp:Button ID="btnAdd_5" runat="server" Text="agregar" Enabled="false"
            OnClick="NuevaPregunta" />
        <br />
    </div>
    <br />
    <asp:Label ID="lblActivo_19" runat="server" Text="activo"></asp:Label>
    <asp:CheckBox ID="cbxActivo" runat="server" Checked="true"></asp:CheckBox>
    <br />
    <asp:Label ID="imagen_2" runat="server" Text="imagen"></asp:Label>&nbsp;<asp:FileUpload ID="imgUpload" runat="server" />
    <br />
    <br />
    <asp:Button ID="btnCrear_32" runat="server" Text="crear" />
    &nbsp;<asp:Button ID="btnActualizar_405" runat="server" EnableTheming="True" Text="actualizar" />
    <br />
    <br />
    <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
    <br />
    <br />
    <asp:TextBox ID="txtBusqueda" runat="server"
        onkeypress="return alfanumerico1(event)"
        onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
        onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)"> </asp:TextBox>
    <asp:Button ID="buscar_31" runat="server" Text="buscar" />
    <asp:Button ID="limpiar_36" runat="server" Text="limpiar" />
    <br />
    <div id="dvGrid">
        <asp:GridView ID="GridView1_" runat="server"
            ShowHeaderWhenEmpty="True"
            AutoGenerateColumns="False"
            RowStyle-CssClass="light"
            AlternatingRowStyle-CssClass="dark"
            AllowPaging="true" ShowFooter="False"
            OnPageIndexChanging="OnPaging"
            PageSize="5">
            <EmptyDataTemplate>
                <asp:Label ID="sindatos_3" Text="sin datos" runat="server"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField HeaderText="ID" Visible="False">
                    <ItemTemplate>
                        <asp:Label ID="lblID" runat="server"
                            Text='<%# Eval("ID")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="desc_12">
                    <ItemTemplate>
                        <asp:Label ID="lblDescripcion" runat="server"
                            Text='<%# Eval("Detalle")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Imagen_2">
                    <ItemTemplate>
                        <asp:Label ID="lblTipo" runat="server"
                            Text='<%# Eval("Tipo")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Activo_19">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbxActiva" runat="server" Enabled="False"
                            Checked='<%# Eval("Activo")%>'></asp:CheckBox>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBorrar" runat="server"
                            CommandArgument='<%# Eval("ID")%>' OnClientClick="return confirm(mensajeBorrar)"
                            Text="borrar" OnClick="Delete">
                            <img src="/Imagenes/borrar.png" alt="x" />
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkSeleccionar" runat="server" CausesValidation="False"
                            CommandName="Select" Text="seleccionar">
                            <img src="/Imagenes/ir.png" alt="->" />
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

            <PagerSettings Mode="NumericFirstLast" FirstPageText="<--" LastPageText="-->" />
        </asp:GridView>
        <br />
    </div>
</asp:Content>
