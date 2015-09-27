<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Institucional.aspx.vb" Inherits="Agorobots.Institucional" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navinstutucional_153" runat="server" Text="institucional"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="instutucional_153" runat="server" Text="institucional"></asp:Label>
            </h1>
            <asp:Label ID="lblImage" runat="server" Text="Employee Image"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:FileUpload ID="imgUpload" runat="server" />
            <br />
            <br />
            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click"
                Text="Submit" />
            <br />
            <asp:Label ID="lblResult" runat="server" ForeColor="#0066FF"></asp:Label>
            <br />
            <hr />

            <asp:Image ID="Image1" Style="width: 200px" runat="server" />
        </div>
    </div>
</asp:Content>

