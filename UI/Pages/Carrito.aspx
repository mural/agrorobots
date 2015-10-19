<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Carrito.aspx.vb" Inherits="Agorobots.Carrito" %>


<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navCarrito_10112" runat="server" Text="carrito"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="carrito_10112" runat="server" Text="carrito"></asp:Label>
            </h1>
            <br />
            (validar materias q no se superpongan, DIAS de cursada con HORARIOS?)  
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
                    <asp:Label ID="carritoVacio_141" Text="el carrito esta vacio" runat="server"></asp:Label>
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
            <asp:Button ID="inscribirse_118" runat="server" Text="confirmar" CssClass="w3-btn w3-blue" />
        </div>
    </div>
</asp:Content>
