<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AbmPermisos.aspx.vb" Inherits="Agorobots.AbmPermisos" %>
<%@ MasterType VirtualPath="~/Site.Master" %>

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

                        <asp:TemplateField ItemStyle-Width="40px" HeaderText="Nombre">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server"
                                    Text='<%# Eval("Name")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="150px" HeaderText="Descripcion">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion" runat="server"
                                    Text='<%# Eval("Descripcion")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                        <asp:CommandField ShowSelectButton="True" />
                    </Columns>
                    <AlternatingRowStyle BackColor="#C2D69B" />
                    <HeaderStyle BackColor="Yellow" />
                </asp:GridView>
                <br />
    <asp:Label ID="lblFamiliaActual_403" runat="server" Text="Familia seleccionada: -"></asp:Label>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    
    <br />
    <div id="dvGrid2" style="padding: 10px; width: 550px">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView2" runat="server" Width="550px"
                    AutoGenerateColumns="False" Font-Names="Arial"
                    Font-Size="11pt" AlternatingRowStyle-BackColor="#C2D69B"
                    HeaderStyle-BackColor="yellow"
                    OnPageIndexChanging="OnPaging2" PageSize="15">
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="30px" HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="lblID" runat="server"
                                    Text='<%# Eval("ID")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="50px" HeaderText="Nombre">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server"
                                    Text='<%# Eval("Name")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="150px" HeaderText="Descripcion">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion" runat="server"
                                    Text='<%# Eval("Descripcion")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="40px" HeaderText="Control ID">
                            <ItemTemplate>
                                <asp:Label ID="lblControlID" runat="server"
                                    Text='<%# Eval("ControlID")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="200px" HeaderText="URL">
                            <ItemTemplate>
                                <asp:Label ID="lblURL" runat="server"
                                    Text='<%# Eval("URL")%>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Select">
                            <ItemTemplate>
                                <asp:CheckBox ID="cbItem" CssClass="gridCB" runat="server"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#C2D69B" />
                    <HeaderStyle BackColor="Yellow" />
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <asp:Button ID="btnActualizar_405" runat="server" Text="Actualizar" />
</asp:Content>
