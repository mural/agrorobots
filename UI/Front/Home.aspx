<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Base.Master" CodeBehind="Home.aspx.vb" Inherits="Agorobots.Home" %>

<%@ Import Namespace="Agorobots" %>

<asp:Content ID="BodyHome" ContentPlaceHolderID="BodyBaseContenido" runat="server">
    <div class="wrapper col3">
        <div id="featured_slide">
            <div id="featured_wrap">
                <ul id="featured_tabs">
                    <li>
                        <a href="#fc1">
                            <asp:Literal ID="introCultivos_83" runat="server" Text="intro a cultivos" />
                            <br />
                            <span>
                                <asp:Literal ID="preparacion_84" runat="server" Text="preparacion" />
                            </span>
                        </a>
                    </li>
                    <li>
                        <a href="#fc2">
                            <asp:Literal ID="cultivos_85" runat="server" Text="cultivos 2" />
                            <br />
                            <span>
                                <asp:Literal ID="cultivosAvanzados_86" runat="server" Text="cultivos avanzados" />
                            </span>
                        </a>
                    </li>
                    <li>
                        <a href="#fc3">
                            <asp:Literal ID="introHidroponia_87" runat="server" Text="intro a hidroponia" />
                            <br />
                            <span>
                                <asp:Literal ID="cuidado_88" runat="server" Text="cuidado" />
                            </span>
                        </a>
                    </li>
                    <li class="last">
                        <a href="#fc4">
                            <asp:Literal ID="granEscala_89" runat="server" Text="gran escala" />
                            <br />
                            <span>
                                <asp:Literal ID="prepEstrategia_90" runat="server" Text="preparacion y estrategia" />
                            </span>
                        </a>
                    </li>
                </ul>
                <div id="featured_content">
                    <div class="featured_box" id="fc1">
                        <img src="../Imagenes/1.jpg" alt="" />
                        <div class="floater">
                            <a href="#">
                                <a href='<%= PaginasConocidas.CATALOGO %>'>
                                    <asp:Label ID="masinfo0_82" runat="server" Text="mas info" />
                                </a>
                                &raquo;
                            </a>
                        </div>
                    </div>
                    <div class="featured_box" id="fc2">
                        <img src="../Imagenes/2.png" alt="" />
                        <div class="floater">
                            <a href="#">
                                <asp:Label ID="masinfo1_82" runat="server" Text="mas info" />
                                &raquo;</a>
                        </div>
                    </div>
                    <div class="featured_box" id="fc3">
                        <img src="../Imagenes/3.jpg" alt="" />
                        <div class="floater">
                            <a href="#">
                                <asp:Label ID="masinfo2_82" runat="server" Text="mas info" />
                                &raquo;</a>
                        </div>
                    </div>
                    <div class="featured_box" id="fc4">
                        <img src="../Imagenes/4.png" alt="" />
                        <div class="floater">
                            <a href="#">
                                <asp:Label ID="masinfo3_82" runat="server" Text="mas info" />
                                &raquo;</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ####################################################################################################### -->
    <div class="wrapper col4">
        <div id="container">
            <div id="hpage">
                <ul>
                    <li>
                        <h2>
                            <asp:Literal ID="etapas_91" runat="server" Text="etapas de la hidroponia" />
                        </h2>
                        <div class="imgholder">
                            <a href="#">
                                <img src="../Imagenes/home_1_200x140.jpg" alt="" /></a>
                        </div>
                        <p>
                            <asp:Label ID="etapasDetalle_95" runat="server" Text="Aprenda las distintas etapas de un cultivo" />
                        </p>
                        <p class="readmore">
                            <a href="#">
                                <asp:Label ID="masinfo4_82" runat="server" Text="mas info" />
                                &raquo;
                            </a>
                        </p>
                    </li>
                    <li>
                        <h2>
                            <asp:Literal ID="aprenda_92" runat="server" Text="aprenda desde su casa" />
                        </h2>
                        <div class="imgholder">
                            <a href="#">
                                <img src="../Imagenes/home_2_200x140.png" alt="" /></a>
                        </div>
                        <p>
                            <asp:Label ID="aprendaDetalle_96" runat="server" Text="Los cursos que ofrecemos son en modalidad online" />
                        </p>
                        <p class="readmore">
                            <a href="#">
                                <asp:Label ID="masinfo5_82" runat="server" Text="mas info" />
                                &raquo;
                            </a>
                        </p>
                    </li>
                    <li>
                        <h2>
                            <asp:Literal ID="tituloEncuesta" runat="server" Text="encuesta" />
                        </h2>
                        <asp:Panel ID="encuestaInicio" runat="server" Text="inicio"></asp:Panel>
                        <asp:Chart ID="Resultado" runat="server" EnableTheming="true"
                            BorderDashStyle="Solid" BackSecondaryColor="White"
                            BackGradientStyle="TopBottom" BorderWidth="2px" BackColor="211, 223, 240"
                            BorderColor="#1A3B69" Width="240px">
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
                        <asp:Panel ID="encuestaCierre" runat="server" Text="cierre"></asp:Panel>
                    </li>
                    <li class="last">
                        <h2>
                            <asp:Literal ID="ventajas_94" runat="server" Text="ventajas de la hidroponia" />
                        </h2>
                        <div class="imgholder">
                            <a href="#">
                                <img src="../Imagenes/home_4_200x140.jpg" alt="" /></a>
                        </div>
                        <p>
                            <asp:Label ID="ventajasDetalle_98" runat="server" Text="Descubra las ventajas de los cultivos hidroponicos en detalle" />
                        </p>
                        <p class="readmore">
                            <a href="#">
                                <asp:Label ID="masinfo7_82" runat="server" Text="mas info" />
                                &raquo;
                            </a>
                        </p>
                    </li>
                </ul>
                <br class="clear" />
            </div>
        </div>
    </div>
</asp:Content>
