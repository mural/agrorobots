<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="Mensajes.aspx.vb" Inherits="Agorobots.Mensajes" %>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo" runat="server" Text="titulo"></asp:Label>
    </h2>
    <div id="envio">
        <asp:Label ID="lblEnviar_700" runat="server" Text="enviar mensaje"></asp:Label>
        <br />
        <asp:DropDownList ID="comboUsuarios" runat="server" AutoPostBack="True">
        </asp:DropDownList>
        <asp:TextBox ID="txtMensaje_701" runat="server"
            onkeypress="return alfanumerico1(event)"
            onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
        </asp:TextBox>
        *&nbsp;
    <asp:Button ID="btnEnviar_135" runat="server" Text="enviar" />
        <asp:RequiredFieldValidator ID="vldMensaje_701" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtMensaje_701" CssClass="formError" EnableClientScript="False"></asp:RequiredFieldValidator>
        <br />
        <br />
    </div>
    <asp:Label ID="lblMensajes" runat="server" CssClass="formError"></asp:Label>
    <br />
    <br />
    <div id="dvGrid">
        <asp:GridView ID="GridView1_" runat="server"
            AutoGenerateColumns="False"
            RowStyle-CssClass="light"
            AlternatingRowStyle-CssClass="dark"
            OnPageIndexChanging="OnPaging"
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
                        <asp:CheckBox ID="cbxLeidoReceptor" runat="server" Enabled="False"
                            Checked='<%# Eval("LeidoReceptor")%>'></asp:CheckBox>
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

