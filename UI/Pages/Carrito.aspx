﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Carrito.aspx.vb" Inherits="Agorobots.Carrito" %>


<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navCarrito" runat="server" Text="carrito"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="carrito" runat="server" Text="carrito"></asp:Label>
            </h1>
            _detalle de todos los items... (dejo eliminar) 
            <br />
            si esta todo bien mando >>>> a INSCRIPCION (donde solo valida el pago)
            <br />
            <br />
            (validar materias q no se superpongan, DIAS de cursada con HORARIOS)  
            <br />
            <br />
            ver webcam max.
            <br />
            <br />
            <asp:GridView ID="GridView1_" runat="server"
                ShowHeader="False"
                RowStyle-CssClass="light"
                AlternatingRowStyle-CssClass="dark"
                AutoGenerateColumns="False"
                CssClass="">
                <EmptyDataTemplate>
                    <asp:Label ID="varrito_vacio" Text="el carrito esta vacio" runat="server"></asp:Label>
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="nombre" runat="server" Text='<%# Eval("Nombre")%>'>
                            </asp:Label>
                            &#x27a4;
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

                </Columns>
            </asp:GridView>
            k
        </div>
    </div>
</asp:Content>
