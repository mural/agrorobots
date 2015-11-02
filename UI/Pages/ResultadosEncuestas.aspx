<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="ResultadosEncuestas.aspx.vb" Inherits="Agorobots.ResultadosEncuestas" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual_10115" runat="server" Text="nav"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10115" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <asp:Panel ID="encuestasPanel" runat="server" Text="inicio"></asp:Panel>
    <asp:Chart ID="Resultado" runat="server" EnableTheming="true"
        BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2px" BackColor="211, 223, 240"
        BorderColor="#1A3B69">
        <Series>
            <asp:Series Name="Categories" ChartType="Bar" ChartArea="MainChartArea"
                BorderWidth="2" Color="YellowGreen">
            </asp:Series>
        </Series>

        <ChartAreas>
            <asp:ChartArea Name="MainChartArea" Area3DStyle-Enable3D="true"
                BorderColor="64, 64, 64, 64"
                BorderDashStyle="Solid" BackSecondaryColor="White"
                BackColor="64, 165, 191, 228"
                ShadowColor="Transparent" BackGradientStyle="TopBottom">
                <Area3DStyle Rotation="10" Perspective="10" Inclination="15"
                    IsRightAngleAxes="False" WallWidth="0" IsClustered="False"></Area3DStyle>
                <AxisY LineColor="64, 64, 64, 64">
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisY>
                <AxisX LineColor="64, 64, 64, 64">
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
    <br />
    <br />
    <asp:Label ID="lblMensajes" runat="server" CssClass="formError"></asp:Label>
    <br />
    <div class="clear"></div>
    <br />
</asp:Content>
