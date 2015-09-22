<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Backup.aspx.vb" Inherits="Agorobots.Backup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="BackUp_10002" runat="server" Text="titulo"></asp:Label>
    </h2>
    <p>
        <asp:Button ID="BackupBtn_10104" runat="server" Text="BackUp" />
        <asp:TextBox ID="BackupText" runat="server" ReadOnly="True" Width="600px">C:\</asp:TextBox>
    </p>
    <p>
        <asp:Label ID="BackupLabel" runat="server" Text=""></asp:Label>
        &nbsp;<asp:ImageButton ID="descargaBackup" runat="server" ImageUrl="~/Imagenes/icono-descargar.png" />
    </p>
    <h2>
        <asp:Label ID="Restore_33" runat="server" Text="titulo2"></asp:Label>
    </h2>
    <p>
        <asp:Button ID="RestoreBtn_33" runat="server" Text="Restore" />
        <asp:TextBox ID="RestoreText" runat="server" Width="600px" Wrap="False"
            onkeypress="return alfanumerico1(event)"
            onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
            onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">C:\agrorobots.bak</asp:TextBox>
        <br />
        <asp:FileUpload ID="subirBackup" runat="server" Visible="False" Width="500px" />
    </p>
    <p>
        <asp:Label ID="RestoreLabel" runat="server" Text=""></asp:Label>
    </p>
</asp:Content>
