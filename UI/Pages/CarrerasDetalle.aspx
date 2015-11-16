<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.Master" CodeBehind="CarrerasDetalle.aspx.vb" Inherits="Agorobots.CarrerasDetalle" %>

<%@ Import Namespace="Agorobots" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href='<%= PaginasConocidas.CATALOGO%>'>
            <asp:Label ID="navCatalogo_50" runat="server" Text="catalogo"></asp:Label>
        </a>
    </li>
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual" runat="server" Text="..."></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="BodyNavegacionContenido">
    <div class="wrapper col4">
        <div id="container">
            <h2></h2>
            <div class='w3-card-4'>
                <header class='w3-container w3-blue'>
                    <h2 class="w3-blue">
                        <asp:Label ID="lblTitulo" runat="server" Text=""></asp:Label>
                    </h2>
                </header>
                <div class='w3-container'>
                    <img class="imagenMediana imagenMasSeparada fl_right w3-circle" src="/Imagenes/curso_generico.jpg" />
                    <br />
                    <asp:Label ID="contenido_705" runat="server" Text="contenido" CssClass="w3-text-blue w3-large"></asp:Label>
                    <asp:Label ID="lblDescripcion" runat="server" Text="contenido"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="duracion_113" runat="server" Text="duracion" CssClass="w3-text-blue w3-large"></asp:Label>
                    <asp:Label ID="lblDuracion" runat="server" Text="duracion"></asp:Label>&nbsp;hs
                    <br />
                    <br />
                    <asp:Label ID="clases_114" runat="server" Text="clases" CssClass="w3-text-blue w3-large"></asp:Label>
                    <asp:Label ID="lblClases" runat="server" Text="clases"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="precio_41" runat="server" Text="precio" CssClass="w3-text-blue w3-large"></asp:Label>
                    $&nbsp;<asp:Label ID="lblPrecio" runat="server" Text="precio"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="cupo_115" runat="server" Text="cupo" CssClass="w3-text-blue w3-large"></asp:Label>
                    <asp:Label ID="lblCupo" runat="server" Text="cupo"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="fechainicio_116" runat="server" Text="fecha inicio" CssClass="w3-text-blue w3-large"></asp:Label>
                    <asp:Label ID="lblFechaInicio" runat="server" Text="fecha inicio"></asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="inscribirse_118" runat="server" Text="Inscribirse" CssClass="w3-btn w3-blue" />
                    <br />
                    <br />
    <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
                    <br />
                </div>
            </div>
            <br />
            <br />
            <h6>
                <asp:Label ID="comentarios_175" runat="server" Text="comentarios"></asp:Label>
            </h6>
            <br />
            <asp:GridView ID="GridComentarios" runat="server"
                ShowHeader="False"
                RowStyle-CssClass="light"
                AlternatingRowStyle-CssClass="dark"
                AutoGenerateColumns="False"
                CssClass="tablaDatos">
                <EmptyDataTemplate>
                    <asp:Label ID="sindatos_3" Text="sin datos" runat="server"></asp:Label>
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField ShowHeader="false">
                        <ItemTemplate>
                            <asp:Label ID="lblComentario" runat="server" Text='<%# Eval("Comentario")%>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ShowHeader="false">
                        <ItemTemplate>
                            <asp:Label ID="lblApellido" runat="server" Text='<%# Eval("Usuario.Apellido")%>'>
                            </asp:Label>
                            <asp:Label ID="lblNombre" runat="server" Text='<%# Eval("Usuario.Nombre")%>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ShowHeader="false">
                        <ItemTemplate>
                            <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("Fecha")%>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:Panel ID="panelComentario" runat="server" Visible="False">
                <asp:TextBox ID="comentario" runat="server" MaxLength="50" CssClass="entradaTexto"></asp:TextBox>
                &nbsp;
                <asp:Button ID="Comentar_135" runat="server" Text="enviar" CssClass="w3-btn w3-khaki"/>
            </asp:Panel>
            <br />

        </div>
    </div>

</asp:Content>
