<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="CuentaCorriente.aspx.vb" Inherits="Agorobots.CuentaCorriente" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual_10111" runat="server" Text="cta cte"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10111" runat="server" Text="titulo"></asp:Label>
    </h2>
    <div id="dvGrid">
        <br />
        <asp:GridView ID="GridView1_" runat="server"
            ShowHeaderWhenEmpty="True"
            AutoGenerateColumns="False"
            RowStyle-CssClass="light"
            AlternatingRowStyle-CssClass="dark"
            AllowPaging="true" ShowFooter="False"
            OnPageIndexChanging="OnPaging"
            PageSize="10">
            <EmptyDataTemplate>
                <asp:Label ID="sindatos_3" Text="sin datos" runat="server"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField HeaderText="estado_112">
                    <ItemTemplate>
                        <asp:Label ID="lblEstado" runat="server"
                            Text='<%# Eval("Estado")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="concepto_142">
                    <ItemTemplate>
                        <asp:Label ID="lblConcepto" runat="server"
                            Text='<%# Eval("Comprobante.Items(0).Detalle")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="monto_138">
                    <ItemTemplate>
                        <asp:Label ID="lblMonto" runat="server"
                            Text='<%# Eval("Comprobante.Subtotal")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="PDF">
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkPdf" runat="server"
                            OnClick="PDF" CommandArgument='<%# Eval("IdComprobante")%>'
                            CssClass="tablaDatosAction" ImageUrl="/Imagenes/pdf.png"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
    </div>
</asp:Content>
