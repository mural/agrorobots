<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="ContenidoElementoAcademico.aspx.vb" Inherits="Agorobots.ContenidoElementoAcademico" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
    <script>
        tinymce.init({
            plugins: "code",
            menubar: false,
            toolbar: "cut copy paste | searchreplace | bullist numlist | bold italic underline strikethrough | code",
            selector: 'textarea.editable'
        });
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="nav_10110" runat="server" Text="novedades"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10110" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <asp:Label ID="nombre_11" runat="server" Text="nombre"></asp:Label>
    <br />
    <asp:TextBox ID="txtNombre" runat="server" Enabled="false">
    </asp:TextBox>
    <br />
    <br />
    <asp:Label ID="contenido_705" runat="server" Text="-"></asp:Label>
    <br />
    <asp:Label ID="lblContenido" runat="server" Text="contenido detalle"></asp:Label>
    <br />
    <br />
    <asp:Label ID="temas_119" runat="server" Text="temas"></asp:Label>
    <br />
    <textarea id="areaTemas" class="editable" style="width: 100%" runat="server"></textarea>
    <br />
    <asp:Label ID="criterios_120" runat="server" Text="criterios"></asp:Label>
    <br />
    <textarea id="areaCriterios" class="editable" style="width: 100%" runat="server"></textarea>
    <br />
    <asp:Label ID="duracion_113" runat="server" Text="duracion"></asp:Label>
    <br />
    <asp:DropDownList ID="comboDuracion" runat="server">
        <asp:ListItem Selected="True">20</asp:ListItem>
        <asp:ListItem>30</asp:ListItem>
        <asp:ListItem>40</asp:ListItem>
        <asp:ListItem>50</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    <asp:Button ID="btnEnviar_135" runat="server" EnableTheming="True" Text="enviar" />
    <br />
    <br />
    <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
    <br />
    <br />
    <asp:TextBox ID="txtBusqueda" runat="server"
        onkeypress="return alfanumerico1(event)"
        onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
        onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)"> </asp:TextBox>
    <asp:Button ID="buscar_31" runat="server" Text="buscar" />
    <asp:Button ID="limpiar_36" runat="server" Text="limpiar" />
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="dvGrid">
        <asp:GridView ID="GridView1_" runat="server"
            ShowHeaderWhenEmpty="True"
            AutoGenerateColumns="False"
            RowStyle-CssClass="light"
            AlternatingRowStyle-CssClass="dark"
            AllowPaging="true" ShowFooter="False"
            OnPageIndexChanging="OnPaging"
            PageSize="5">
            <EmptyDataTemplate>
                <asp:Label ID="sindatos_3" Text="sin datos" runat="server"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField HeaderText="ID" Visible="False">
                    <ItemTemplate>
                        <asp:Label ID="lblID" runat="server"
                            Text='<%# Eval("CodigoAcademico")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="nombre_11">
                    <ItemTemplate>
                        <asp:Label ID="lblNombre" runat="server"
                            Text='<%# RecortarTexto(Eval("Nombre"))%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="contenido_705">
                    <ItemTemplate>
                        <asp:Label ID="lblContenido" runat="server"
                            Text='<%# Eval("Contenido")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="estado_112">
                    <ItemTemplate>
                        <asp:Label ID="lblEstado" runat="server"
                            Text='<%# Eval("Estado")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Imagen_2">
                    <ItemTemplate>
                        <asp:Image ID="imgImagen" runat="server" CssClass="imagenesTabla"
                            ImageUrl='<%# ObtenerImagen(Eval("Imagen"))%>'></asp:Image>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBorrar" runat="server"
                            CommandArgument='<%# Eval("CodigoAcademico")%>' OnClientClick="return confirm(mensajeBorrar)"
                            Text="borrar" OnClick="Delete">
                            <img src="/Imagenes/borrar.png" alt="x" />
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkSeleccionar" runat="server" CausesValidation="False"
                            CommandName="Select" Text="seleccionar">
                            <img src="/Imagenes/ir.png" alt="->" />
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

            <PagerSettings Mode="NumericFirstLast" FirstPageText="<--" LastPageText="-->" />
        </asp:GridView>
        <br />
    </div>
</asp:Content>

