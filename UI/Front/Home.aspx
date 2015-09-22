<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Home.aspx.vb" Inherits="Agorobots.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Agrorobots</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="stylesheet" href="~/Styles/layout.css" type="text/css" />
    <script type="text/javascript" src="<%=ResolveClientUrl("~/Scripts/jquery.min.js")%>"></script>
    <script type="text/javascript" src="<%=ResolveClientUrl("~/Scripts/jquery.slidepanel.setup.js")%>"></script>
    <script type="text/javascript" src="<%=ResolveClientUrl("~/Scripts/jquery.ui.min.js")%>"></script>
    <script type="text/javascript" src="<%=ResolveClientUrl("~/Scripts/jquery.tabs.setup.js")%>"></script>
    <script type="text/javascript">
        function activarClase(header) {
            document.getElementById("headerDefecto").className = ""
            header.className = "active";
        }
        function desactivarClase(header) {
            header.className = "";
            document.getElementById("headerDefecto").className = "active"
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper col0">
            <div id="topbar">
                <div id="slidepanel">
                    <div class="topbox">
                        <h2>Nullamlacus dui ipsum</h2>
                        <p>Nullamlacus dui ipsum conseque loborttis non euisque morbi penas dapibulum orna. Urnaultrices quis curabitur phasellentesque congue magnis vestibulum quismodo nulla et feugiat. Adipisciniapellentum leo ut consequam ris felit elit id nibh sociis malesuada.</p>
                        <p class="readmore"><a href="#">Continue Reading &raquo;</a></p>
                    </div>
                    <div class="topbox">
                        <h2>Teachers Login Here</h2>
                        <form action="#" method="post">
                            <fieldset>
                                <legend>Teachers Login Form</legend>
                                <label for="teachername">
                                    Username:
              <input type="text" name="teachername" id="teachername" value="" />
                                </label>
                                <label for="teacherpass">
                                    Password:
              <input type="password" name="teacherpass" id="teacherpass" value="" />
                                </label>
                                <label for="teacherremember">
                                    <input class="checkbox" type="checkbox" name="teacherremember" id="teacherremember" checked="checked" />
                                    Remember me</label>
                                <p>
                                    <input type="submit" name="teacherlogin" id="teacherlogin" value="Login" />
                                    &nbsp;
              <input type="reset" name="teacherreset" id="teacherreset" value="Reset" />
                                </p>
                            </fieldset>
                        </form>
                    </div>
                    <div class="topbox last">
                        <h2>Pupils Login Here</h2>
                        <form action="#" method="post">
                            <fieldset>
                                <legend>Pupils Login Form</legend>
                                <label for="pupilname">
                                    Username:
              <input type="text" name="pupilname" id="pupilname" value="" />
                                </label>
                                <label for="pupilpass">
                                    Password:
              <input type="password" name="pupilpass" id="pupilpass" value="" />
                                </label>
                                <label for="pupilremember">
                                    <input class="checkbox" type="checkbox" name="pupilremember" id="pupilremember" checked="checked" />
                                    Remember me</label>
                                <p>
                                    <input type="submit" name="pupillogin" id="pupillogin" value="Login" />
                                    &nbsp;
              <input type="reset" name="pupilreset" id="pupilreset" value="Reset" />
                                </p>
                            </fieldset>
                        </form>
                    </div>
                    <br class="clear" />
                </div>
                <div id="loginpanel">
                    <ul>
                        <%--<li class="left">Log In Here &raquo;</li>--%>
                        <%--<li class="right" id="toggle"><a id="slideit" href="#slidepanel">Administration</a><a id="closeit" style="display: none;" href="#slidepanel">Close Panel</a></li>--%>
                        <a href="../Pantalla_Login.aspx">Login</a>
                    </ul>
                </div>
                <br class="clear" />
            </div>
        </div>
        <!-- ####################################################################################################### -->
        <div class="wrapper col1">
            <div id="header">
                <div id="logo">
                    <h1><a href="Home.aspx">Agrorobots</a></h1>
                    <p>Plataforma de E-Learning</p>
                </div>
                <div class="fl_right">
                    <ul>
                        <li class="last"><a href="#">Busqueda</a></li>
                        <li><a href="#">Soporte</a></li>
                        <li><a href="#">Sobre nosotros</a></li>
                    </ul>
                    <p>Tel: 011 4444 5555 | Email: info@agrorobots.net</p>
                </div>
                <br class="clear" />
            </div>
        </div>
        <!-- ####################################################################################################### -->
        <div class="wrapper col2">
            <div id="topnav">
                <ul>
                    <li id="headerDefecto" class="active"><a href="Home.aspx">Home</a>
                        <ul>
                            <li><a href="#">Plataforma</a></li>
                            <li><a href="#">Experiencia</a></li>
                            <li><a href="#">Opiniones</a></li>
                            <li class="last"><a href="#">Demostracion</a></li>
                        </ul>
                    </li>
                    <li onmouseover="activarClase(this)" onmouseout="desactivarClase(this)">
                        <a href="Home.aspx">Cursos</a>
                        <ul>
                            <li><a href="#">Cultivos I</a></li>
                            <li><a href="#">Cultivos II</a></li>
                            <li class="last"><a href="#">Hidroponia</a></li>
                        </ul>
                    </li>
                    <li onmouseover="activarClase(this)" onmouseout="desactivarClase(this)">
                        <a href="Home.aspx">Asistencia</a>
                        <ul>
                            <li><a href="#">Inscripcion</a></li>
                            <li><a href="#">Empresas</a></li>
                            <li class="last"><a href="#">Forma de pago</a></li>
                        </ul>
                    </li>
                    <li class="last" onmouseover="activarClase(this)" onmouseout="desactivarClase(this)">
                        <a href="#">Servicios</a>
                        <ul>
                            <li><a href="#">Asesoria</a></li>
                            <li class="last"><a href="#">Ventas</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <!-- ####################################################################################################### -->
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
        <!-- ####################################################################################################### -->
        <div class="wrapper col5">
            <div id="footer">
                <div id="newsletter">
                    <h2>Este en contacto !</h2>
                    <p>Ingrese su Email para formar parte de nuestra lista de correos</p>
                    <form action="#" method="post">
                        <fieldset>
                            <legend>Newsletter</legend>
                            <input type="text" value="Ingrese su Email&hellip;" onfocus="this.value=(this.value=='Ingrese su Email&hellip;')? '' : this.value ;" />
                            <input type="submit" name="news_go" id="news_go" value="IR" />
                        </fieldset>
                    </form>
                    <p>Para desuscripción <a href="#">presione aca &raquo;</a></p>
                </div>
                <div class="footbox">
                    <h2>Inscripcion</h2>
                    <ul>
                        <li><a href="#">Inscribase</a></li>
                        <li><a href="#">Becas</a></li>
                        <li class="last"><a href="#">Contacte un representante</a></li>
                    </ul>
                </div>
                <div class="footbox">
                    <h2>Medio ambiente</h2>
                    <ul>
                        <li><a href="#">Vea como ayudar</a></li>
                        <li><a href="#">Estadisticas</a></li>
                        <li><a href="#">Programa verde</a></li>
                        <li class="last"><a href="#">Sitios afiliados</a></li>
                    </ul>
                </div>
                <div class="footbox">
                    <h2>Fromas de Pago</h2>
                    <ul>
                        <li><a href="#">Promociones</a></li>
                        <li><a href="#">Financiacion</a></li>
                        <li class="last"><a href="#">Consulte por cantidad</a></li>
                    </ul>
                </div>
                <br class="clear" />
            </div>
        </div>
        <!-- ####################################################################################################### -->
        <div class="wrapper col6">
            <div id="copyright">
                <p class="fl_left">Copyright &copy; 2015 - Todos los derechos reservados - <a href="#">agrorobots.net</a></p>
                <p class="fl_right"><a target="_blank" href="../Pantalla_Login.aspx" title="Agrorobots E-Learning">Agrorobots E-Learning</a></p>
                <br class="clear" />
            </div>
        </div>
    </form>
</body>
</html>
