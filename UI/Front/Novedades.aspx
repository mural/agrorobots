<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Novedades.aspx.vb" Inherits="Agorobots.Novedades" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navNovedades_3004" runat="server" Text="novedades"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="novedades_3004" runat="server" Text="novedades"></asp:Label>
            </h1>

            <div id="pepe">
            </div>
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
            <%--            <div class="w3-card-4" style="width: 50%;">

                <header class="w3-container w3-blue">
                    <h2>Header</h2>
                </header>

                <div class="w3-container">
                    <p>
                        A car is a wheeled, self-powered motor vehicle used for transportation.
Most definitions of the term specify that cars are designed to run primarily on roads,
to have seating for one to eight people, to typically have for one to eight people,
to typically have four wheels. (Wikipedia)
                    </p>
                </div>
            </div>--%>
        </div>
    </div>
</asp:Content>
