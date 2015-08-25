<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AbmPermisos.aspx.vb" Inherits="Agorobots.AbmPermisos" %>

<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>ABM PERMISOS</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="dvGrid">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1_" runat="server"
                    AutoGenerateColumns="False" HeaderStyle-CssClass="tablaDatosHeader"
                    CssClass="tablaDatos"
                    AlternatingRowStyle-CssClass="tablaDatosAlternate"
                    OnPageIndexChanging="OnPaging">
                    <AlternatingRowStyle CssClass="tablaDatosAlternate" />
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="lblID" runat="server"
                                    Text='<%# Eval("ID")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Nombre_11">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server"
                                    Text='<%# Eval("Name")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Descripcion_12">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion" runat="server"
                                    Text='<%# Eval("Descripcion")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="selec_801" runat="server" CausesValidation="False"
                                    CssClass="tablaDatosAction" CommandName="Select" Text="Select"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="tablaDatosHeader" />
                </asp:GridView>
                <br />
                <asp:Label ID="lblFamiliaActual_403" runat="server"
                    Text="Familia seleccionada: -"></asp:Label>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1_" />
            </Triggers>
        </asp:UpdatePanel>
    </div>

    <br />
    <div id="dvGrid2">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView2_" runat="server"
                    AutoGenerateColumns="False" HeaderStyle-CssClass="tablaDatosHeader"
                    CssClass="tablaDatos"
                    AlternatingRowStyle-CssClass="tablaDatosAlternate"
                    OnPageIndexChanging="OnPaging2" PageSize="25">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="lblID" runat="server"
                                    Text='<%# Eval("ID")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Nombre_11">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server"
                                    Text='<%# Eval("Name")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Descripcion_12">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion" runat="server"
                                    Text='<%# Eval("Descripcion")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ControlID_805">
                            <ItemTemplate>
                                <asp:Label ID="lblControlID" runat="server"
                                    Text='<%# Eval("ControlID")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="URL">
                            <ItemTemplate>
                                <asp:Label ID="lblURL" runat="server"
                                    Text='<%# Eval("URL")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Select_801">
                            <ItemTemplate>
                                <asp:CheckBox ID="cbItem" CssClass="gridCB" runat="server"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1_" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <br />
    <asp:Button ID="btnActualizar_405" runat="server" Text="Actualizar" />
    <br />
    <br />
</asp:Content>
