<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AbmUsuarios.aspx.vb" Inherits="Agorobots.AbmUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var mensajeBorrar = '<%= mensajeBorrar %>';
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10107" runat="server" Text="titulo"></asp:Label>
    </h2>
    <p>
        <asp:Label ID="lblApellido_21" runat="server" Text="apellido"></asp:Label>
        <asp:TextBox ID="txtApellido" runat="server"
            onkeypress="return alfanumerico1(event)"
            onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
        </asp:TextBox>
        *<asp:RequiredFieldValidator ID="vldApellido_21" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtApellido" CssClass="formError" EnableClientScript="False"></asp:RequiredFieldValidator>
        &nbsp;
        <asp:CustomValidator ID="cvldApellido_21" runat="server" ControlToValidate="txtApellido" CssClass="formError" ErrorMessage="CustomValidator" EnableClientScript="False"></asp:CustomValidator>
        <br />
        <asp:Label ID="lblNombre_22" runat="server" Text="nombre"></asp:Label>
        <asp:TextBox ID="txtNombre" runat="server"
            onkeypress="return alfanumerico1(event)"
            onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
        </asp:TextBox>
        *<asp:RequiredFieldValidator ID="vldNombre_22" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtNombre" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="lblUsername_23" runat="server" Text="user"></asp:Label>
        <asp:TextBox ID="txtUsername" runat="server"
            onkeypress="return alfanumerico1(event)"
            onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
        </asp:TextBox>
        *<asp:RequiredFieldValidator ID="vldUser_23" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtUsername" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        &nbsp;<asp:CustomValidator ID="cvldUser_23" runat="server" ControlToValidate="txtUsername" CssClass="formError" ErrorMessage="CustomValidator" EnableClientScript="False"></asp:CustomValidator>
        <br />
        <asp:Label ID="lblActivo_19" runat="server" Text="activo"></asp:Label>
        <asp:CheckBox ID="cbxActivo" runat="server" Checked="true"></asp:CheckBox>
        <asp:Label ID="lblAdmin_20" runat="server" Text="admin"></asp:Label>
        <asp:CheckBox ID="cbxAdmin" runat="server" Checked="false"></asp:CheckBox>
        <br />
        <asp:Label ID="lblFamilia_9" runat="server" Text="familia"></asp:Label>
        <br />
        <asp:ListBox ID="lstbFamilia" runat="server" Rows="5" SelectionMode="Multiple"></asp:ListBox>
        <br />
        <asp:Label ID="lblPassword_27" runat="server" Text="pass"></asp:Label>
        <asp:TextBox ID="txtPassword" runat="server"
            onkeypress="return alfanumerico1(event)"
            onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
        </asp:TextBox>
        *<asp:RequiredFieldValidator ID="vldPassword_27" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtPassword" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        &nbsp;<asp:CustomValidator ID="cvldPass_27" runat="server" ControlToValidate="txtPassword" CssClass="formError" ErrorMessage="CustomValidator" EnableClientScript="False"></asp:CustomValidator>
        <br />
        <asp:Label ID="lblConfirmPassword_28" runat="server" Text="confirm pass"></asp:Label>
        <asp:TextBox ID="txtConfirmPassword" runat="server"
            onkeypress="return alfanumerico1(event)"
            onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
        </asp:TextBox>
        *<asp:RequiredFieldValidator ID="vldConfirmPassword_28" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtConfirmPassword" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        &nbsp;<asp:CompareValidator ID="vldPasswordMatch" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="CompareValidator" CssClass="formError" EnableClientScript="False"></asp:CompareValidator>
        <br />
        <br />
        <asp:Button ID="btnCrear_32" runat="server" Text="crear" />
        &nbsp;<asp:Button ID="btnActualizar_405" runat="server" Text="actualizar" EnableTheming="True" />
        &nbsp;<asp:Button ID="btnLimpiar_36" runat="server" Text="limpiar" />&nbsp;<asp:Label ID="lblMensajes" runat="server" CssClass="formError"></asp:Label>
        <br />
        <asp:Label ID="notePass_90037" runat="server" Text="*pass ignorado en update"></asp:Label>
    </p>
    <div id="dvGrid">
        <asp:GridView ID="GridView1_" runat="server"
            AutoGenerateColumns="False"
            HeaderStyle-CssClass="tablaDatosHeader" CssClass="tablaDatos"
            AlternatingRowStyle-CssClass="tablaDatosAlternate" OnPageIndexChanging="OnPaging"
            AllowPaging="True" PageSize="5">
            <Columns>
                <asp:TemplateField HeaderText="ID">
                    <ItemTemplate>
                        <asp:Label ID="lblID" runat="server"
                            Text='<%# Eval("ID")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Activo_19">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbxActiovo" runat="server" Enabled="False"
                            Checked='<%# Eval("Activo")%>'></asp:CheckBox>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Idioma_30">
                    <ItemTemplate>
                        <asp:Label ID="lblIDIdioma" runat="server"
                            Text='<%# Eval("Idioma.Descripcion")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Apellido_21">
                    <ItemTemplate>
                        <asp:Label ID="lblApellido" runat="server"
                            Text='<%# Eval("Apellido")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Nombre_22">
                    <ItemTemplate>
                        <asp:Label ID="lblNombre" runat="server"
                            Text='<%# Eval("Nombre")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="UserName_17">
                    <ItemTemplate>
                        <asp:Label ID="lblUserName" runat="server"
                            Text='<%# Eval("UserName")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Intentos_18">
                    <ItemTemplate>
                        <asp:Label ID="lblIntentos" runat="server"
                            Text='<%# Eval("Intentos")%>'></asp:Label>
                        /
                        <asp:Label ID="max" runat="server"
                            Text='<%# usuario_Business.MAX_TRIES%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Email_109">
                    <ItemTemplate>
                        <asp:Label ID="lblFamilia" runat="server"
                            Text='<%# Eval("Email")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBorrar_13" runat="server"
                            CommandArgument='<%# Eval("ID")%>'
                            OnClientClick="return confirm(mensajeBorrar)"
                            Text="borrar" OnClick="Delete" CssClass="tablaDatosAction"></asp:LinkButton>
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
</asp:Content>

