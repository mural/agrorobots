<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="MiError.aspx.vb" Inherits="Agorobots.MiError" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navError_10001" runat="server" Text="error"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="title_10001" runat="server" Text="error">
                </asp:Label>
            </h1>
            <br/>
            <p>
                <asp:Label ID="error_90040" runat="server" Text="Se produjo un error."></asp:Label>
            </p>
            <br/>
            <br/>
        </div>
    </div>
</asp:Content>