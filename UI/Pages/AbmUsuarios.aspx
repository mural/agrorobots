<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AbmUsuarios.aspx.vb" Inherits="Agorobots.AbmUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>ABM PERMISOS</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="dvGrid" style="padding: 10px; width: 550px">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" Width="550px"
                    AutoGenerateColumns="False" Font-Names="Arial"
                    Font-Size="11pt" AlternatingRowStyle-BackColor="#C2D69B"
                    HeaderStyle-BackColor="yellow"
                    OnPageIndexChanging="OnPaging">
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
                                <asp:Label ID="lblName" runat="server"
                                    Text='<%# Eval("Activo")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="150px" HeaderText="Admin">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion" runat="server"
                                    Text='<%# Eval("Admin")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="150px" HeaderText="Idioma">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion1" runat="server"
                                    Text='<%# Eval("Idioma.ID")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="150px" HeaderText="Apellido">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion1" runat="server"
                                    Text='<%# Eval("Apellido")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="150px" HeaderText="Nombre">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion1" runat="server"
                                    Text='<%# Eval("Nombre")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="150px" HeaderText="UserName">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion1" runat="server"
                                    Text='<%# Eval("UserName")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="150px" HeaderText="Intentos">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion1" runat="server"
                                    Text='<%# Eval("Intentos")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                    </Columns>
                    <AlternatingRowStyle BackColor="#C2D69B" />
                    <HeaderStyle BackColor="Yellow" />
                </asp:GridView>
                <br />
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    
    <br />
    </asp:Content>

