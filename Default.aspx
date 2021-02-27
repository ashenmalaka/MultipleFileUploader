<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MultipleFileUploader._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Upload Files</h1>
        <p class="lead">Upload any of your files...!!!</p>
        <asp:Button runat="server" Cssclass="btn btn-primary btn-lg" Text="Upload &raquo;" OnClientClick="window.open('Upload.aspx', 'Upload');" />
    </div>

</asp:Content>
