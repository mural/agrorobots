<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Institucional.aspx.vb" Inherits="Agorobots.Institucional" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadNavegacionContenido" runat="server">
    <link rel="stylesheet" href="/Styles/robots.css" />
    <script type="text/javascript">
        function matrix() {
            var c = document.getElementById("c");
            var ctx = c.getContext("2d");

            //chinese characters - taken from the unicode charset
            //var chinese = "&#30000;&#30001;&#30002;&#30003;&#30004;&#30005;&#30006;&#30007;&#30008;&#30009;&#30010;&#30011;&#30012;&#30013;&#30014;&#30015;&#30016;&#30017;&#30018;&#30019;&#30020;&#30021;&#30022;&#30023;&#30024;&#30025;&#30026;&#30027;&#30028;&#30029;&#30030;&#30031;&#30032;&#30033;";
            var chinese = "agrorobots";
            //converting the string into an array of single characters
            chinese = chinese.split("");

            var font_size = 16;
            var columns = c.width / font_size; //number of columns for the rain
            //an array of drops - one per column
            var drops = [];
            //x below is the x coordinate
            //1 = y co-ordinate of the drop(same for every drop initially)
            for (var x = 0; x < columns; x++)
                drops[x] = 1;

            //drawing the characters
            function draw() {
                //Black BG for the canvas
                //translucent BG to show trail
                ctx.fillStyle = "rgba(0, 0, 0, 0.05)";
                ctx.fillRect(0, 0, c.width, c.height);

                ctx.fillStyle = "#0F0"; //green text
                ctx.font = font_size + "px arial";
                //looping over drops
                for (var i = 0; i < drops.length; i++) {
                    //a random chinese character to print
                    var text = chinese[Math.floor(Math.random() * chinese.length)];
                    //x = i*font_size, y = value of drops[i]*font_size
                    ctx.fillText(text, i * font_size, drops[i] * font_size);

                    //sending the drop back to the top randomly after it has crossed the screen
                    //adding a randomness to the reset to make the drops scattered on the Y axis
                    if (drops[i] * font_size > c.height && Math.random() > 0.975)
                        drops[i] = 0;

                    //incrementing Y coordinate
                    drops[i]++;
                }
            }

            setInterval(draw, 93);
        }

        $(document).ready(function () {
            matrix();
        });
    </script>
</asp:Content>
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
            <div style="display: none">
                <% Response.Write("Cultura actual: " + System.Globalization.CultureInfo.CurrentCulture.DisplayName)%>
            </div>
            <h1>
                <asp:Label ID="instutucional_153" runat="server" Text="institucional"></asp:Label>
            </h1>
            <p>
                <img src="/Imagenes/logo.png" class="fl_left imagenSeparada" />
            </p>
            <asp:Label ID="sobreNosotrs_99003" runat="server" Text="sobre nosotros"></asp:Label>
            <br />
            <canvas id="c" width="960" height="150" />
        </div>
    </div>
</asp:Content>

