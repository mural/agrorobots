<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Backup.aspx.vb" Inherits="TP_LibreriaOnline.Backup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Backup</h2> 
    <p>
        <asp:Button ID="BackupBtn" runat="server" Text="Back Up" />
        <asp:TextBox ID="BackupText" runat="server">C:\</asp:TextBox>
        <asp:Label ID="BackupLabel" runat="server" Text=""></asp:Label>
    </p>
    <h2>Restore</h2>
    <p>
        <asp:Button ID="RestoreBtn" runat="server" Text="Restore" />
        <asp:TextBox ID="RestoreText" runat="server">C:\libreria.bak</asp:TextBox>
        <asp:Label ID="RestoreLabel" runat="server" Text=""></asp:Label>
    </p>
</asp:Content>
