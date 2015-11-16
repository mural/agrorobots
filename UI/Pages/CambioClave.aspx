<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="CambioClave.aspx.vb" Inherits="Agorobots.CambioClave" %>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_3008" runat="server" Text="titulo"></asp:Label>
    </h2>
    <p>
        &nbsp;</p>
    <p>
        <asp:Label ID="lblPassword_26" runat="server" Text="pass actual"></asp:Label>
        <asp:TextBox ID="txtPasswordActual" runat="server" MaxLength="15"
            onkeypress="return alfanumerico1(event)"
            onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
        </asp:TextBox>
        <asp:RequiredFieldValidator ID="vldPasswordActualRequerido" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtPasswordActual" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        &nbsp;<asp:CustomValidator ID="vldPasswordActualCustom" runat="server" ControlToValidate="txtPasswordActual" CssClass="formError" Display="Dynamic" EnableClientScript="False" ErrorMessage="CustomValidator"></asp:CustomValidator>
    </p>
    <p>
        <br />
        <asp:Label ID="lblPassword_27" runat="server" Text="pass"></asp:Label>
        <asp:TextBox ID="txtPassword" runat="server" MaxLength="10"
            onkeypress="return alfanumerico1(event)"
            onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
        </asp:TextBox>
        <asp:RequiredFieldValidator ID="vldPassword" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtPassword" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        &nbsp;<asp:CustomValidator ID="vldPasswordCustom" runat="server" ControlToValidate="txtPassword" CssClass="formError" Display="Dynamic" EnableClientScript="False" ErrorMessage="CustomValidator"></asp:CustomValidator>
    </p>
    <p>
        <br />
        <asp:Label ID="lblConfirmPassword_28" runat="server" Text="confirm pass"></asp:Label>
        <asp:TextBox ID="txtConfirmPassword" runat="server" MaxLength="10"
            onkeypress="return alfanumerico1(event)"
            onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
        </asp:TextBox>
        <asp:RequiredFieldValidator ID="vldConfirmPassword" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtConfirmPassword" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
        &nbsp;<asp:CompareValidator ID="vldPasswordMatch" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="CompareValidator" CssClass="formError" EnableClientScript="False"></asp:CompareValidator>
    </p>
    <p>
        <br />
        <br />
        &nbsp;<asp:Button ID="btnActualizar_405" runat="server" Text="actualizar" EnableTheming="True" CssClass="w3-btn w3-khaki"/>
        &nbsp;<asp:Label ID="lblMensajes" runat="server" CssClass="formError"></asp:Label>
        <br />
    </p>
</asp:Content>

