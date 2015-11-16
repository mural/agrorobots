<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="DetalleExamen.aspx.vb" Inherits="Agorobots.DetalleExamen" %>

<%@ Import Namespace="Agorobots" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
    <        <script type ="text/javascript" >
            function startTimer(duration, display) {
                var timer = duration, minutes, seconds;
                setInterval(function () {
                    minutes = parseInt(timer / 60, 10)
                    seconds = parseInt(timer % 60, 10);

                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;

                    display.textContent = minutes + ":" + seconds;

                    if (minutes == 0 && seconds == 0) {
                        document.getElementById("<%:submit.ClientID%>").click();
                }

                if (--timer < 0) {
                    timer = duration;
                }
            }, 1000);
        }

        window.onload = function () {
            var minutes = <%= DetalleExamen.TiempoSegundos%>;
            display = document.querySelector('#time');
            startTimer(minutes, display);
        };
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual_147" runat="server" Text="clases"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_147" runat="server" Text="examen"></asp:Label></h2>
    <br />
    <div class='w3-card-4'>
        <header class='w3-container w3-blue'>
            <h2 class="w3-blue">
                <asp:Label ID="lblExamen_147" runat="server" Text="examen"></asp:Label>
            </h2>
        </header>
        <div class='w3-container'>
            <img class="imagenMediana imagenMasSeparada fl_right w3-circle" src="/Imagenes/curso_generico.jpg" />
            <br />
            <br />
            <div><span id="time">--:--</span></div>
            <br />
            <asp:Panel ID="examenInicio" runat="server" Text="inicio"></asp:Panel>
            <br />
            <br />
            <asp:Panel ID="examenCierre" runat="server" Text="cierre"></asp:Panel>
            <br />
            <br />
            <%--<asp:Button ID="enviar_135" runat="server" Text="enviar" CssClass="w3-btn w3-khaki" />--%>
        </div>
    </div>
    <br />
    <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
    <br />
</asp:Content>
