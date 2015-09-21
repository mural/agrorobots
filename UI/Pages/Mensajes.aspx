﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Mensajes.aspx.vb" Inherits="Agorobots.Mensajes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblTitulo" runat="server" Text="titulo"></asp:Label>
    </h2>
    <div id="envio">
        <asp:Label ID="lblEnviar_700" runat="server" Text="enviar mensaje"></asp:Label>
        <br />
        <asp:DropDownList ID="comboUsuarios" runat="server" AutoPostBack="True">
        </asp:DropDownList>
        <asp:TextBox ID="txtMensaje_701" runat="server"></asp:TextBox>
        *&nbsp;
    <asp:Button ID="btnEnviar_135" runat="server" Text="enviar" />
        <asp:RequiredFieldValidator ID="vldMensaje_0" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtMensaje_701" CssClass="formError" EnableClientScript="False"></asp:RequiredFieldValidator>
        <br />
        <br />
    </div>
    <asp:Label ID="lblMensajes" runat="server" CssClass="formError"></asp:Label>
        <br />
    <br />
    <div id="dvGrid">
        <asp:GridView ID="GridView1_" runat="server"
            AutoGenerateColumns="False"
            HeaderStyle-CssClass="tablaDatosHeader" CssClass="tablaDatos"
            AlternatingRowStyle-CssClass="tablaDatosAlternate" OnPageIndexChanging="OnPaging"
            AllowPaging="True" PageSize="5">
            <Columns>
                <asp:TemplateField HeaderText="Contenido_705">
                    <ItemTemplate>
                        <asp:Label ID="lblContenido" runat="server"
                            Text='<%# Eval("Contenido")%>' CssClass="mensaje"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Emisor_706">
                    <ItemTemplate>
                        <asp:Label ID="lblEmisor" runat="server"
                            Text='<%# Eval("NombreEmisor")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="EmailEmisor_707">
                    <ItemTemplate>
                        <asp:Label ID="lblIDIdioma" runat="server"
                            Text='<%# Eval("EmailEmisor")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Leido_708">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbxActiovo" runat="server" Enabled="False"
                            Checked='<%# Eval("Leido")%>'></asp:CheckBox>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha_133">
                    <ItemTemplate>
                        <asp:Label ID="lblFamilia" runat="server"
                            Text='<%# Eval("Fecha")%>'></asp:Label>
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
