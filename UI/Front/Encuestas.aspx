<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Encuestas.aspx.vb" Inherits="Agorobots.Encuestas" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navEncuestas_52" runat="server" Text="encuestas"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="titleEncuestas_52" runat="server" Text="encuestas">
                </asp:Label>
            </h1>
            <asp:Panel ID="encuestaInicio" runat="server" Text="faq detalle"></asp:Panel>
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
            <asp:Panel ID="encuestaCierre" runat="server" Text="faq detalle"></asp:Panel>
            <br />
            <br />
            <asp:Label ID="lblMensajes" runat="server" CssClass="formError"></asp:Label>
            <br />
            <div class="clear"></div>
        </div>
    </div>
</asp:Content>
