﻿<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="AbmElementoAcademico.aspx.vb" Inherits="Agorobots.AbmElementoAcademico" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
    <script>
        tinymce.init({
            plugins: "code",
            menubar: false,
            toolbar: "cut copy paste | searchreplace | bullist numlist | bold italic underline strikethrough | code",
            selector: 'textarea.editable'
        });
    </script>
    <script>
        $(function () {
            $("input.datepicker").datepicker();
        });
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="nav_10109" runat="server" Text="novedades"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10109" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <asp:Label ID="nombre_11" runat="server" Text="nombre"></asp:Label>
    <br />
    <asp:TextBox ID="txtNombre" runat="server" MaxLength="50" CssClass="entradaTexto"
        onkeypress="return alfanumerico1(event)"
        onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
        onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
    </asp:TextBox>
    <br />
    <br />
    <asp:Label ID="contenido_705" runat="server" Text="contenido"></asp:Label>
    <br />
    <textarea id="areaContenido" class="editable" style="width: 100%" runat="server"></textarea>
    <br />
    <asp:Label ID="imagen_2" runat="server" Text="imagen"></asp:Label>&nbsp;<asp:FileUpload ID="imgUpload" runat="server" />
    <asp:RegularExpressionValidator ID="RegularExpressionValidator2_90048" runat="server" ErrorMessage="*" ControlToValidate="imgUpload" ValidationExpression="(.*).(.jpg|.JPG|.png|.PNG|.gif|.GIF)$" EnableClientScript="false" Display="Dynamic" CssClass="formError"></asp:RegularExpressionValidator>
    <asp:CustomValidator ID="validadorSize_90048" runat="server" ErrorMessage="*" EnableClientScript="false" Display="Dynamic" CssClass="formError" ControlToValidate="imgUpload" OnServerValidate="validadorSize_ServerValidate"></asp:CustomValidator>
    <br />
    <br />
    <asp:DropDownList ID="comboEstados" runat="server" AutoPostBack="False">
    </asp:DropDownList>
    <br />
    <br />
    <asp:Label ID="profesor_144" runat="server" Text="prof."></asp:Label>
    <br />
    <asp:DropDownList ID="comboProfesores" runat="server" AutoPostBack="False" Enabled="false">
    </asp:DropDownList>
    <br />
    <br />
    <asp:Label ID="fInicio_116" runat="server" Text="fecha inicio"></asp:Label>
    <br />
    <input type="text" id="txtFechaInicio" class="datepicker" runat="server" readonly="readonly">
    <br />
    <br />
    <asp:Button ID="btnCrear_32" runat="server" Text="crear" CssClass="w3-btn w3-khaki"/>
    &nbsp;<asp:Button ID="btnActualizar_405" runat="server" EnableTheming="True" Text="actualizar" CssClass="w3-btn w3-khaki"/>
    <br />
    <br />
    <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
    <br />
    <br />
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
                    <EditItemTemplate>
                        <asp:TextBox ID="txtTexto" runat="server"
                            Text='<%# Eval("Nombre")%>' CausesValidation="False"
                            onkeypress="return alfanumerico1(event)"
                            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)"> </asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="precio_41">
                    <ItemTemplate>
                        $
                                <asp:Label ID="lblPrecio" runat="server"
                                    Text='<%# Eval("Precio")%>'></asp:Label>
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
