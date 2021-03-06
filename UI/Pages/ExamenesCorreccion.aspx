﻿<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="ExamenesCorreccion.aspx.vb" Inherits="Agorobots.ExamenesCorreccion" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual_10125" runat="server" Text="Examenes"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10125" runat="server" Text="titulo"></asp:Label>
    </h2>
    <div id="dvGrid">
        <br />
        <br />
        <asp:Label ID="corregir_174" runat="server" Text="a rendir"></asp:Label>
        <br />
        <asp:GridView ID="GridView1_" runat="server"
            ShowHeaderWhenEmpty="True"
            AutoGenerateColumns="False"
            RowStyle-CssClass="light"
            AlternatingRowStyle-CssClass="dark"
            AllowPaging="true" ShowFooter="False"
            PageSize="10">
            <EmptyDataTemplate>
                <asp:Label ID="sindatos_3" Text="sin datos" runat="server"></asp:Label>
            </EmptyDataTemplate>
            <Columns>

                <asp:TemplateField HeaderText="fecha_133">
                    <ItemTemplate>
                        <asp:Label ID="lblFecha" runat="server"
                            Text='<%# Eval("Fecha")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="examen_147">
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkExamenCorregir" runat="server"
                            OnClick="CorregirExamen" CommandArgument='<%# Eval("ID")%>'
                            CssClass="tablaDatosAction" ImageUrl="/Imagenes/examen.jpg"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
        <br />
    </div>
</asp:Content>