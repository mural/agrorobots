<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Base.Master" CodeBehind="Home.aspx.vb" Inherits="Agorobots.Home" %>

<asp:Content ID="BodyHome" ContentPlaceHolderID="BodyBaseContenido" runat="server">
    <div class="wrapper col3">
        <div id="featured_slide">
            <div id="featured_wrap">
                <ul id="featured_tabs">
                    <li><a href="#fc1">Introduccion a los cultivos<br />
                        <span>Preparacion de cultivos y mantenimiento.</span></a></li>
                    <li><a href="#fc2">Cultivos II<br />
                        <span>Cultivos avanzados, tecnicas automatizadas.</span></a></li>
                    <li><a href="#fc3">Introduccion a la hidroponia<br />
                        <span>Cuidado de cultivos hidroponicos.</span></a></li>
                    <li class="last"><a href="#fc4">Trabajo en gran escala<br />
                        <span>Preparacion y estrategia de grandes cultivos.</span></a></li>
                </ul>
                <div id="featured_content">
                    <div class="featured_box" id="fc1">
                        <img src="../Imagenes/1.jpg" alt="" />
                        <div class="floater"><a href="#">Mas informacion &raquo;</a></div>
                    </div>
                    <div class="featured_box" id="fc2">
                        <img src="../Imagenes/2.png" alt="" />
                        <div class="floater"><a href="#">Mas informacion &raquo;</a></div>
                    </div>
                    <div class="featured_box" id="fc3">
                        <img src="../Imagenes/3.jpg" alt="" />
                        <div class="floater"><a href="#">Mas informacion &raquo;</a></div>
                    </div>
                    <div class="featured_box" id="fc4">
                        <img src="../Imagenes/4.png" alt="" />
                        <div class="floater"><a href="#">Mas informacion &raquo;</a></div>
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
                        <h2>Etapas de la hidroponia</h2>
                        <div class="imgholder">
                            <a href="#">
                                <img src="../Imagenes/home_1_200x140.jpg" alt="" /></a>
                        </div>
                        <p>
                            Aprenda las distintas etapas de un cultivo, los cuidados segun cada una de ellas, las adaptaciones
                                que puede realizar para maximizar su color, sabor y aroma.
                        </p>
                        <p class="readmore"><a href="#">Mas información &raquo;</a></p>
                    </li>
                    <li>
                        <h2>Aprenda desde su casa</h2>
                        <div class="imgholder">
                            <a href="#">
                                <img src="../Imagenes/home_2_200x140.png" alt="" /></a>
                        </div>
                        <p>
                            Los cursos que ofrecemos son en modalidad online, a traves de nuestra plataforma de E-Learning.
                                Usted podria realizarlos desde cualquier ubicacion en la que disponga de acceso a internet, como
                                la comodidad de su casa.
                        </p>
                        <p class="readmore"><a href="#">Mas información &raquo;</a></p>
                    </li>
                    <li>
                        <h2>Cree su negocio</h2>
                        <div class="imgholder">
                            <a href="#">
                                <img src="../Imagenes/home_3_200x140.jpg" alt="" /></a>
                        </div>
                        <p>
                            Desde nuestro establecimiento fomentamos este tipo de desarrollo sustentable de cultivos, y 
                                ofrecemos ayuda para crear su propio negocio.
                        </p>
                        <p class="readmore"><a href="#">Mas información &raquo;</a></p>
                    </li>
                    <li class="last">
                        <h2>Ventajas de la hidroponia</h2>
                        <div class="imgholder">
                            <a href="#">
                                <img src="../Imagenes/home_4_200x140.jpg" alt="" /></a>
                        </div>
                        <p>
                            Descubra las ventajas de los cultivos hidroponicos en detalle. Estos no tienen uso de pesticidas
                                daninos para su salud o la de sus hijos. No dañan el medio ambiente y son mas saludables.
                        </p>
                        <p class="readmore"><a href="#">Mas información &raquo;</a></p>
                    </li>
                </ul>
                <br class="clear" />
            </div>
        </div>
    </div>
</asp:Content>
