﻿<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="MisClases.aspx.vb" Inherits="Agorobots.MisClases" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual_10122" runat="server" Text="clases"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10122" runat="server" Text="titulo"></asp:Label>
    </h2>
    <div id="dvGrid">
        <br />
        <asp:GridView ID="GridView1_" runat="server"
            ShowHeaderWhenEmpty="True"
            AutoGenerateColumns="False"
            RowStyle-CssClass="light"
            AlternatingRowStyle-CssClass="dark"
            AllowPaging="true" ShowFooter="False"
            OnPageIndexChanging="OnPaging"
            PageSize="10">
            <EmptyDataTemplate>
                <asp:Label ID="sindatos_3" Text="sin datos" runat="server"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField HeaderText="nombre_11">
                    <ItemTemplate>
                        <asp:Label ID="lblNombre" runat="server"
                            Text='<%# Eval("Nombre")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="desc_12">
                    <ItemTemplate>
                        <asp:Label ID="lblDescripcion" runat="server"
                            Text='<%# Eval("Descripcion")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="material_145">
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkMaterial" runat="server"
                            OnClick="Material" CommandArgument='<%# Eval("CodigoAcademico")%>'
                            CssClass="tablaDatosAction" ImageUrl="/Imagenes/material.png"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="examen_172">
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkExamenEdicion" runat="server"
                            OnClick="ExamenEdicion" CommandArgument='<%# Eval("CodigoAcademico")%>'
                            CssClass="tablaDatosAction" ImageUrl="/Imagenes/examen.jpg"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="examen_173">
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkExamenCorregir" runat="server"
                            OnClick="ExamenCorregir" CommandArgument='<%# Eval("CodigoAcademico")%>'
                            CssClass="tablaDatosAction" ImageUrl="/Imagenes/examen.jpg"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="foro_148">
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkForo" runat="server"
                            OnClick="Foro" CommandArgument='<%# Eval("CodigoAcademico")%>'
                            CssClass="tablaDatosAction" ImageUrl="/Imagenes/foro.png"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="streaming_182">
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkStreaming" runat="server"
                            OnClick="Streaming" CommandArgument='<%# Eval("CodigoAcademico")%>'
                            CssClass="tablaDatosAction" ImageUrl="/Imagenes/streaming.jpg"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
    </div>
</asp:Content>
