<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="Pantalla_Principal.aspx.vb"  Inherits="Agorobots.Pantalla_Principal" %>

<%@ Register Assembly="Controles" Namespace="Controles" TagPrefix="uc" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="BodyMenuContenido">
    <h2>
        <asp:Label ID="welcome_40" runat="server" Text=""></asp:Label>
        &nbsp;
        <asp:Label ID="userName" runat="server" Text=""></asp:Label>
    </h2>
    <br />
    <asp:TextBox ID="txtBuscar" runat="server" 
        onkeypress="return alfanumerico1(event)"
        onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
        onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
    </asp:TextBox>
    <asp:Button ID="buscarsitio_104" runat="server" Text="buscar"></asp:Button>
    <br />
    <br />
    <asp:GridView ID="GridView1_" runat="server"
        ShowHeader="False"
        AlternatingRowStyle-CssClass="tablaDatosAlternate"
        AutoGenerateColumns="False"
        CssClass="tablaDatos">
        <EmptyDataTemplate>
            <asp:Label ID="sindatos_3" Text="sin datos" runat="server"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                    <asp:Label ID="linkNombre" runat="server" Text='<%# Eval("Display")%>'>
                    </asp:Label>
                    &#x27a4;
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkSeleccionar_801" runat="server" CausesValidation="False"
                        OnClick="Selection" CommandArgument='<%# Eval("URL")%>'
                        Text="seleccionar" CssClass="tablaDatosAction"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <br />
    <asp:Label ID="inconsistencias" runat="server" Text="Label"></asp:Label>
    <br />
    <asp:Button ID="recalcular_710" runat="server" Text="Recalcular Digitos"
        Visible="False" />
    <br />

</asp:Content>
