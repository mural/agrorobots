<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Bitacora.aspx.vb" Inherits="Agorobots.Bitacora" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <h2>BITACORA</h2>
        <asp:ObjectDataSource ID="Bitacora" runat="server" 
            SelectMethod="GetItemsBitacora" TypeName="Business.Bitacora_Business">
        </asp:ObjectDataSource>
        <asp:ListView ID="ListView1" runat="server" DataSourceID="Bitacora">
            <AlternatingItemTemplate>
                <tr style="background-color:#FFF8DC;">
                    <td>
                        <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                    </td>
                    <td>
                        <asp:Label ID="UsuarioLabel" runat="server" Text='<%# Eval("Usuario") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TipoLabel" runat="server" Text='<%# Eval("Tipo") %>' />
                    </td>
                    <td>
                        <asp:Label ID="DetalleLabel" runat="server" Text='<%# Eval("Detalle") %>' />
                    </td>
                    <td>
                        <asp:Label ID="FechaLabel" runat="server" Text='<%# Eval("Fecha") %>' />
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <tr style="background-color:#008A8C;color: #FFFFFF;">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                            Text="Update" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                            Text="Cancel" />
                    </td>
                    <td>
                        <asp:TextBox ID="IdTextBox" runat="server" Text='<%# Bind("Id") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="UsuarioTextBox" runat="server" Text='<%# Bind("Usuario") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="TipoTextBox" runat="server" Text='<%# Bind("Tipo") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="DetalleTextBox" runat="server" Text='<%# Bind("Detalle") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="FechaTextBox" runat="server" Text='<%# Bind("Fecha") %>' />
                    </td>
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table id="Table1" runat="server" 
                    style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                    <tr>
                        <td>
                            No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                            Text="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                            Text="Clear" />
                    </td>
                    <td>
                        <asp:TextBox ID="IdTextBox" runat="server" Text='<%# Bind("Id") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="UsuarioTextBox" runat="server" Text='<%# Bind("Usuario") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="TipoTextBox" runat="server" Text='<%# Bind("Tipo") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="DetalleTextBox" runat="server" Text='<%# Bind("Detalle") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="FechaTextBox" runat="server" Text='<%# Bind("Fecha") %>' />
                    </td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="background-color:#DCDCDC;color: #000000;">
                    <td>
                        <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                    </td>
                    <td>
                        <asp:Label ID="UsuarioLabel" runat="server" Text='<%# Eval("Usuario") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TipoLabel" runat="server" Text='<%# Eval("Tipo") %>' />
                    </td>
                    <td>
                        <asp:Label ID="DetalleLabel" runat="server" Text='<%# Eval("Detalle") %>' />
                    </td>
                    <td>
                        <asp:Label ID="FechaLabel" runat="server" Text='<%# Eval("Fecha") %>' />
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table id="Table2" runat="server">
                    <tr id="Tr1" runat="server">
                        <td id="Td1" runat="server">
                            <table ID="itemPlaceholderContainer" runat="server" border="1" 
                                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <tr id="Tr2" runat="server" style="background-color:#DCDCDC;color: #000000;">
                                    <th id="Th1" runat="server">
                                        Id</th>
                                    <th id="Th2" runat="server">
                                        Usuario</th>
                                    <th id="Th3" runat="server">
                                        Tipo</th>
                                    <th id="Th4" runat="server">
                                        Detalle</th>
                                    <th id="Th5" runat="server">
                                        Fecha</th>
                                </tr>
                                <tr ID="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="Tr3" runat="server">
                        <td id="Td2" runat="server" 
                            style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                            <asp:DataPager ID="DataPager1" runat="server">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                        ShowLastPageButton="True" />
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">
                    <td>
                        <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                    </td>
                    <td>
                        <asp:Label ID="UsuarioLabel" runat="server" Text='<%# Eval("Usuario") %>' />
                    </td>
                    <td>
                        <asp:Label ID="TipoLabel" runat="server" Text='<%# Eval("Tipo") %>' />
                    </td>
                    <td>
                        <asp:Label ID="DetalleLabel" runat="server" Text='<%# Eval("Detalle") %>' />
                    </td>
                    <td>
                        <asp:Label ID="FechaLabel" runat="server" Text='<%# Eval("Fecha") %>' />
                    </td>
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>
</asp:Content>
