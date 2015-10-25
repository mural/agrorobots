﻿<%@ Page Language="vb"  ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="EdicionMaterial.aspx.vb" Inherits="Agorobots.EdicionMaterial" %>

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
            <asp:Label ID="nav_10123" runat="server" Text="edicion material"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10123" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <asp:Label ID="detalle_132" runat="server" Text="detalle"></asp:Label>
    <br />
    <asp:TextBox ID="txtDetalle" runat="server"
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
    <br />
    <br />
    <br />
    <asp:Label ID="tipo_162" runat="server" Text="tipo"></asp:Label>
    <br />
    <asp:DropDownList ID="comboTipos" runat="server" AutoPostBack="False">
    </asp:DropDownList>
    <br />
    <br />
    <asp:Label ID="fLimite_165" runat="server" Text="fecha max vista"></asp:Label>
    <br />
    <input type="text" id="txtFechaMax" class="datepicker" runat="server" readonly="readonly" >
    <br />
    <br />
    <asp:Button ID="btnCrear_32" runat="server" Text="crear" />
    &nbsp;<asp:Button ID="btnActualizar_405" runat="server" EnableTheming="True" Text="actualizar" />
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
                            Text='<%# Eval("ID")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="tipo_162">
                    <ItemTemplate>
                        <asp:Label ID="lblNombre" runat="server"
                            Text='<%# RecortarTexto(Eval("Tipo"))%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="detalle_132">
                    <ItemTemplate>
                                <asp:Label ID="lblDetalle" runat="server"
                                    Text='<%# Eval("Detalle")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="fLimite_165">
                    <ItemTemplate>
                        <asp:Label ID="lblFecha" runat="server"
                            Text='<%# Eval("FechaMaxVisita")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBorrar" runat="server"
                            CommandArgument='<%# Eval("ID")%>' OnClientClick="return confirm(mensajeBorrar)"
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
