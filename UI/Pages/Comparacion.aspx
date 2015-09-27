<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="Comparacion.aspx.vb" Inherits="Agorobots.Comparacion" %>

<asp:Content ID="HeadContent" runat="server" ContentPlaceHolderID="HeadBaseContenido">
    <script type="text/javascript">

    </script>
</asp:Content>

<asp:Content ID="Navegacion" runat="server" ContentPlaceHolderID="DetalleNavegacionContenido">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navcomparacion_51" runat="server" Text="comparacion"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="BodyMenuContenido">
    <h2>
        <asp:Label ID="comparacion_51" runat="server" Text="Label"></asp:Label></h2>
    <asp:DropDownList ID="comboElemento1" runat="server"
        OnSelectedIndexChanged="Elemento1" AutoPostBack="true"
        AppendDataBoundItems="true">
        <asp:ListItem Text="-----" Value=""></asp:ListItem>
    </asp:DropDownList>
    <-->
    <asp:DropDownList ID="comboElemento2" runat="server"
        OnSelectedIndexChanged="Elemento2" AutoPostBack="true"
        AppendDataBoundItems="true">
        <asp:ListItem Text="-----" Value=""></asp:ListItem>
    </asp:DropDownList>
    <-->
    <asp:DropDownList ID="comboElemento3" runat="server"
        OnSelectedIndexChanged="Elemento3" AutoPostBack="true"
        AppendDataBoundItems="true">
        <asp:ListItem Text="-----" Value=""></asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    <asp:GridView ID="GridView1_" runat="server"
        AutoGenerateColumns="False"
        RowStyle-CssClass="light"
        AlternatingRowStyle-CssClass="dark"
        AllowSorting="True"
        OnSorting="Ordenar">
        <Columns>
            <asp:TemplateField HeaderText="nombre_22">
                <ItemTemplate>
                    <asp:Label ID="lblNombre" runat="server"
                        Text='<%# Eval("Nombre")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="contenido_705">
                <ItemTemplate>
                    <asp:Label ID="lblDuracion" runat="server"
                        Text='<%# Eval("Contenido")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="horas_42">
                <ItemTemplate>
                    <asp:Label ID="lblDuracion" runat="server"
                        Text='<%# Eval("Duracion")%>'></asp:Label>
                    hs
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="precio_41" SortExpression="precio">
                <ItemTemplate>
                    $
                    <asp:Label ID="lblPrecio" runat="server"
                        Text='<%# Eval("Precio")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle CssClass="tablaDatosHeader" />
    </asp:GridView>

</asp:Content>
