<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Backup.aspx.vb" Inherits="Agorobots.Backup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="BackUp_10002" runat="server" Text="titulo"></asp:Label>
    </h2> 
    <p>
        <asp:Button ID="BackupBtn_10104" runat="server" Text="BackUp" />
        <asp:TextBox ID="BackupText" runat="server" ReadOnly="True" Width="600px" >C:\</asp:TextBox>
        <asp:Label ID="BackupLabel" runat="server" Text=""></asp:Label>
    </p>
    <h2>
        <asp:Label ID="Restore_33" runat="server" Text="titulo2"></asp:Label>
    </h2>
    <p>
        <asp:Button ID="RestoreBtn_33" runat="server" Text="Restore" />
        <asp:TextBox ID="RestoreText" runat="server" ReadOnly="True" Width="600px" Wrap="False">C:\agrorobots.bak</asp:TextBox>
        <asp:Label ID="RestoreLabel" runat="server" Text=""></asp:Label>
    </p>
</asp:Content>
