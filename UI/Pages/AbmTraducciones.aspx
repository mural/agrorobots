<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AbmTraducciones.aspx.vb" Inherits="Agorobots.AbmTraducciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>ABM TRADUCCIONES</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div id="dvGrid" style="padding: 10px; width: 550px">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" Width="550px"
                        AutoGenerateColumns="false" Font-Names="Arial"
                        Font-Size="11pt" AlternatingRowStyle-BackColor="#C2D69B"
                        HeaderStyle-BackColor="yellow" AllowPaging="true" ShowFooter="true"
                        OnPageIndexChanging="OnPaging" OnRowEditing="Edit"
                        OnRowUpdating="Update" OnRowCancelingEdit="CancelEdit"
                        PageSize="10">
                        <Columns>
                             <asp:TemplateField ItemStyle-Width="30px" HeaderText="ID">
                                <ItemTemplate>
                                    <asp:Label ID="lblID" runat="server"
                                        Text='<%# Eval("ID")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-Width="30px" HeaderText="Idioma ID">
                                <ItemTemplate>
                                    <asp:Label ID="lblIdiomaID" runat="server"
                                        Text='<%# Eval("Idioma.ID")%>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtIdiomaID" Width="40px"
                                        MaxLength="5" runat="server"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Traduccion">
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

                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Control ID">
                                <ItemTemplate>
                                    <asp:Label ID="lblControlName" runat="server"
                                        Text='<%# Eval("Control_ID")%>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtControl" runat="server"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkRemove" runat="server"
                                        CommandArgument='<%# Eval("ID")%>'
                                        OnClientClick="return confirm('Do you want to delete?')"
                                        Text="Delete" OnClick="Delete"></asp:LinkButton>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Button ID="btnAdd" runat="server" Text="Add"
                                        OnClick="AddNew" />
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:CommandField ShowEditButton="True" />
                        </Columns>
                        <AlternatingRowStyle BackColor="#C2D69B" />
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView1" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
</asp:Content>
