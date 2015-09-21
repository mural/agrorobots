<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Comparacion.aspx.vb" Inherits="Agorobots.Comparacion" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Comparacion</title>
</asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
    - Comparacion
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Comparacion</h2>
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
        HeaderStyle-CssClass="tablaDatosHeader"
        CssClass="tablaDatos"
        AlternatingRowStyle-CssClass="tablaDatosAlternate"
        AllowSorting="True" 
        OnSorting="Ordenar" >
        <Columns>
            <asp:TemplateField HeaderText="nombre_22">
                <ItemTemplate>
                    <asp:Label ID="lblNombre" runat="server"
                        Text='<%# Eval("Nombre")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="precio_41" SortExpression="precio">
                <ItemTemplate>
                    $ <asp:Label ID="lblPrecio" runat="server"
                        Text='<%# Eval("Precio")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
        <HeaderStyle CssClass="tablaDatosHeader" />
    </asp:GridView>

</asp:Content>
