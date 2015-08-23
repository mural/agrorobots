<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AbmUsuarios.aspx.vb" Inherits="Agorobots.AbmUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>ABM USUARIOS</h2>
    <p>
        <asp:Label ID="lblApellido_21" runat="server" Text="apellido"></asp:Label>
        <asp:TextBox ID="txtApellido" runat="server" ViewStateMode="Enabled"></asp:TextBox>
        <br />
        <asp:Label ID="lblNombre_22" runat="server" Text="nombre"></asp:Label>
        <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblUsername_23" runat="server" Text="user"></asp:Label>
        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="vldUser" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtUsername" CssClass="formError" EnableClientScript="False"></asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="lblPassword_27" runat="server" Text="pass"></asp:Label>
        <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblConfirmPassword_28" runat="server" Text="confirm pass"></asp:Label>
        <asp:TextBox ID="txtConfirmPassword" runat="server"></asp:TextBox>
        <asp:CompareValidator ID="vldPassword" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="CompareValidator" CssClass="formError"></asp:CompareValidator>
        <br />
        <br />
        <asp:Button ID="btnCrear_32" runat="server" Text="crear" />
        <br />
        <asp:Label ID="lblMensajes" runat="server" Text=""></asp:Label>
    </p>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="dvGrid" style="padding: 10px; width: 550px">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" Width="550px"
                    AutoGenerateColumns="False" Font-Names="Arial"
                    Font-Size="11pt" AlternatingRowStyle-BackColor="#C2D69B"
                    HeaderStyle-BackColor="yellow" ShowFooter="True"
                    OnPageIndexChanging="OnPaging" OnRowEditing="Edit"
                    OnRowUpdating="Update" OnRowCancelingEdit="CancelEdit">
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

                        <asp:TemplateField ItemStyle-Width="150px" HeaderText="Nombre">
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
                                <asp:LinkButton ID="lnkRemove" runat="server"
                                    CommandArgument='<%# Eval("ID")%>'
                                    OnClientClick="return confirm('?')"
                                    Text="borrar" OnClick="Delete"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:CommandField ShowSelectButton="True" />
                    </Columns>
                    <AlternatingRowStyle BackColor="#C2D69B" />
                    <HeaderStyle BackColor="Yellow" />
                </asp:GridView>
                <br />
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1" />
                <asp:AsyncPostBackTrigger ControlID="txtApellido" />
            </Triggers>
        </asp:UpdatePanel>
    </div>

    <br />
</asp:Content>

