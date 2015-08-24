<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AbmUsuarios.aspx.vb" Inherits="Agorobots.AbmUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblTitulo" runat="server" Text="titulo"></asp:Label></h2>
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
        <asp:GridView ID="GridView1_" runat="server" Width="550px"
            AutoGenerateColumns="False" Font-Names="Arial"
            Font-Size="11pt" HeaderStyle-CssClass="tablaDatosHeader"
            AlternatingRowStyle-CssClass="tablaDatosAlternate" OnPageIndexChanging="OnPaging"
            AllowPaging="True" PageSize="5">
            <AlternatingRowStyle CssClass="tablaDatosAlternate"></AlternatingRowStyle>
            <Columns>
                <asp:TemplateField ItemStyle-Width="30px" HeaderText="ID">
                    <ItemTemplate>
                        <asp:Label ID="lblID" runat="server"
                            Text='<%# Eval("ID")%>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="30px" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="40px" HeaderText="Activo">
                    <ItemTemplate>
                        <asp:Label ID="lblActivo" runat="server"
                            Text='<%# Eval("Activo")%>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="40px" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="150px" HeaderText="Admin">
                    <ItemTemplate>
                        <asp:Label ID="lblAdmin" runat="server"
                            Text='<%# Eval("Admin")%>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="150px" HeaderText="Idioma">
                    <ItemTemplate>
                        <asp:Label ID="lblIDIdioma" runat="server"
                            Text='<%# Eval("Idioma.ID")%>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="150px" HeaderText="Apellido_21">
                    <ItemTemplate>
                        <asp:Label ID="lblApellido" runat="server"
                            Text='<%# Eval("Apellido")%>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="150px" HeaderText="Nombre_22">
                    <ItemTemplate>
                        <asp:Label ID="lblNombre" runat="server"
                            Text='<%# Eval("Nombre")%>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="150px" HeaderText="UserName">
                    <ItemTemplate>
                        <asp:Label ID="lblUserName" runat="server"
                            Text='<%# Eval("UserName")%>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-Width="150px" HeaderText="Intentos">
                    <ItemTemplate>
                        <asp:Label ID="lblIntentos" runat="server"
                            Text='<%# Eval("Intentos")%>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" />
                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBorrar_13" runat="server"
                            CommandArgument='<%# Eval("ID")%>'
                            OnClientClick="return confirm('?')"
                            Text="borrar" OnClick="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkSeleccionar_801" runat="server" CausesValidation="False" 
                            CommandName="Select" Text="seleccionar"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <HeaderStyle CssClass="tablaDatosHeader"></HeaderStyle>
        </asp:GridView>
    </div>
</asp:Content>

