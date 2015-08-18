<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AbmIdiomas.aspx.vb" Inherits="Agorobots.AbmIdiomas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>ABM IDIOMAS</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div id="dvGrid" style="padding: 10px; width: 550px">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" Width="550px"
                        AutoGenerateColumns="false" Font-Names="Arial"
                        Font-Size="11pt" AlternatingRowStyle-BackColor="#C2D69B"
                        HeaderStyle-BackColor="yellow" AllowPaging="true" ShowFooter="true"
                        OnPageIndexChanging="OnPaging" OnRowEditing="EditCustomer"
                        OnRowUpdating="UpdateCustomer" OnRowCancelingEdit="CancelEdit"
                        PageSize="10">
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="30px" HeaderText="CustomerID">
                                <ItemTemplate>
                                    <asp:Label ID="lblCustomerID" runat="server"
                                        Text='<%# Eval("ID")%>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtCustomerID" Width="40px"
                                        MaxLength="5" runat="server"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblContactName" runat="server"
                                        Text='<%# Eval("Descripcion")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtContactName" runat="server"
                                        Text='<%# Eval("Descripcion")%>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtContactName" runat="server"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkRemove" runat="server"
                                        CommandArgument='<%# Eval("ID")%>'
                                        OnClientClick="return confirm('Do you want to delete?')"
                                        Text="Delete" OnClick="DeleteCustomer"></asp:LinkButton>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Button ID="btnAdd" runat="server" Text="Add"
                                        OnClick="AddNewCustomer" />
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
