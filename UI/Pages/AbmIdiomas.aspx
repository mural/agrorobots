﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="AbmIdiomas.aspx.vb" Inherits="Agorobots.AbmIdiomas" %>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_10101" runat="server" Text="titulo"></asp:Label>
    </h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="dvGrid">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
                <br />

                <asp:GridView ID="GridView1_" runat="server"
                    AutoGenerateColumns="False"
                    RowStyle-CssClass="light"
                    AlternatingRowStyle-CssClass="dark"
                    AllowPaging="True" ShowFooter="True"
                    OnPageIndexChanging="OnPaging" OnRowEditing="Edit"
                    OnRowUpdating="Update" OnRowCancelingEdit="CancelEdit">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="lblIdiomaID" runat="server"
                                    Text='<%# Eval("ID")%>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtIdiomaID"
                                    MaxLength="5" runat="server" CssClass="txtChico"
                                    onkeypress="return alfanumerico1(event)"
                                    onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
                                </asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Descripcion_12">
                            <ItemTemplate>
                                <asp:Label ID="lblDescripcion" runat="server"
                                    Text='<%# Eval("Descripcion")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescripcion" runat="server" MaxLength="254"
                                    Text='<%# Eval("Descripcion")%>'
                                    onkeypress="return alfanumerico1(event)"
                                    onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
                                </asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtDescripcion" runat="server" MaxLength="50"
                                    onkeypress="return alfanumerico1(event)"
                                    onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
                                </asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Codigo_1">
                            <ItemTemplate>
                                <asp:Label ID="lblCodigo" runat="server"
                                    Text='<%# Eval("Codigo")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCodigo" runat="server" MaxLength="10"
                                    Text='<%# Eval("Codigo")%>'
                                    onkeypress="return alfanumerico1(event)"
                                    onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
                                </asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtCodigo" runat="server" MaxLength="10"
                                    onkeypress="return alfanumerico1(event)"
                                    onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
                                </asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkRemove" runat="server" CommandArgument='<%# Eval("ID")%>'
                                    OnClientClick="return confirm(mensajeBorrar)"
                                    Text="borrar" OnClick="Delete">
                                    <img src="/Imagenes/borrar.png" alt="x" />
                                </asp:LinkButton>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Button ID="btnAdd_5" runat="server" Text="agregar"
                                    OnClick="AddNew" CssClass="w3-btn w3-khaki"/>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="actualizar_405" runat="server" CausesValidation="True"
                                    CssClass="tablaDatosAction" CommandName="Update" Text="actualizar"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="cancelar_14" runat="server" CausesValidation="False"
                                    CssClass="tablaDatosAction" CommandName="Cancel" Text="cancelar"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="editar_7" runat="server" CausesValidation="False"
                                    CssClass="tablaDatosAction" CommandName="Edit" Text="editar"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <HeaderStyle CssClass="tablaDatosHeader" />
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1_" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
