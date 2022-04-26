<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SmartUploader.ascx.cs" Inherits="UserControls.SmartUploader" %>

<style>
    .uploadError{
        font-weight: bold;
        color: red;
    }
</style>

<asp:Panel ID="panelSmartUploader" runat="server">

    <div>
        <asp:FileUpload ID="filePicker" runat="server" CssClass="filePicker" />
        <asp:Button ID="btnUpload" runat="server" Text="Upload File" OnClick="btnUpload_Click" />
    </div>
    <div>
        <asp:Label ID="lblUploadResult" runat="server" Text=""></asp:Label>
    </div>
    <div>
         <asp:Label ID="lblUploadError" runat="server" CssClass="uploadError" Text=""></asp:Label>
    </div>

</asp:Panel>

<script>

    const filePicker = document.querySelector(".filePicker");

    filePicker.accept = '<%= HtmlUploadFilter %>';

</script>