<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="AbmNovedades.aspx.vb" Inherits="Agorobots.AbmNovedades" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
    <script>
        tinymce.init({
            plugins: "code, link",
            menubar: false,
            toolbar: "cut copy paste | searchreplace | bullist numlist | bold italic underline strikethrough link | code",
            selector: 'textarea'
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
            <asp:Label ID="navNovedades_3004" runat="server" Text="novedades"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_3004" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <asp:DropDownList ID="comboTipos" runat="server" AutoPostBack="False"></asp:DropDownList>
    <br />
    <textarea id="areaHTML" style="width: 100%" runat="server"></textarea>
    <br />
    <asp:Label ID="imagen_2" runat="server" Text="imagen"></asp:Label>&nbsp;<asp:FileUpload ID="imgUpload" runat="server" />
    <br />
    <br />
    <asp:Label ID="fInicio_116" runat="server" Text="fecha inicio"></asp:Label>
    <br />
    <input type="text" id="txtFechaInicio" class="datepicker" runat="server" readonly="readonly">
    <br />
    <asp:Label ID="fFin_128" runat="server" Text="fecha expiracion"></asp:Label>
    <br />
    <input type="text" id="txtFechaFin" class="datepicker" runat="server" readonly="readonly">
    <br />
    <br />
    <asp:Button ID="btnCrear_32" runat="server" Text="crear" CssClass="w3-btn w3-khaki"/>
    &nbsp;<asp:Button ID="btnActualizar_405" runat="server" EnableTheming="True" Text="actualizar" CssClass="w3-btn w3-khaki" />
    <br />
    <br />
    <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
    <br />
    <br />
    <br />
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

                <asp:TemplateField HeaderText="texto_46">
                    <ItemTemplate>
                        <asp:Label ID="lblTexto" runat="server"
                            Text='<%# RecortarTexto(Eval("Texto"))%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha_133">
                    <ItemTemplate>
                        <asp:Label ID="lblFecha" runat="server"
                            Text='<%# Eval("Fecha")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Foto_47">
                    <ItemTemplate>
                        <asp:Image ID="imgFoto" runat="server" CssClass="imagenesTabla"
                            ImageUrl='<%# ObtenerImagen(Eval("Foto"))%>'></asp:Image>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Tema_48">
                    <ItemTemplate>
                        <asp:Label ID="lblIdTema" runat="server"
                            Text='<%# ObtenerTema(Eval("IDCategoriaTema"))%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkRemove" runat="server"
                            CommandArgument='<%# Eval("ID")%>' OnClientClick="return confirm(mensajeBorrar)"
                            Text="borrar" OnClick="Delete"> <img src="/Imagenes/borrar.png" alt="x" /></asp:LinkButton>
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
