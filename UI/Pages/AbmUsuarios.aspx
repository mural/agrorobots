<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AbmUsuarios.aspx.vb" Inherits="Agorobots.AbmUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var mensajeBorrar = '<%= MensajeBorrar %>';
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10107" runat="server" Text="titulo"></asp:Label>
    </h2>
    <p>
        <asp:Label ID="lblApellido_21" runat="server" Text="apellido"></asp:Label>
        <asp:TextBox ID="txtApellido" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="vldApellido" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtApellido" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="lblNombre_22" runat="server" Text="nombre"></asp:Label>
        <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="vldNombre" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtNombre" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="lblUsername_23" runat="server" Text="user"></asp:Label>
        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="vldUser" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtUsername" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="lblPassword_27" runat="server" Text="pass"></asp:Label>
        <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="vldPassword" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtPassword" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="lblConfirmPassword_28" runat="server" Text="confirm pass"></asp:Label>
        <asp:TextBox ID="txtConfirmPassword" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="vldConfirmPassword" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtConfirmPassword" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        &nbsp;<asp:CompareValidator ID="vldPasswordMatch" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="CompareValidator" CssClass="formError" EnableClientScript="False"></asp:CompareValidator>
        <br />
        <br />
        <asp:Button ID="btnCrear_32" runat="server" Text="crear" />
        &nbsp;<asp:Button ID="btnActualizar_405" runat="server" Text="actualizar" EnableTheming="True" />
        &nbsp;<asp:Button ID="btnLimpiar_36" runat="server" Text="limpiar" />&nbsp;<asp:Label ID="lblMensajes" runat="server" CssClass="formError"></asp:Label>
        <br />
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
                        <asp:Label ID="lblActivo" runat="server"
                            Text='<%# Eval("Activo")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Admin_20">
                    <ItemTemplate>
                        <asp:Label ID="lblAdmin" runat="server"
                            Text='<%# Eval("Admin")%>'></asp:Label>
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
</asp:Content>

