<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="UserControls.Upload" %>

<%@ Register Src="~/SmartUploader.ascx" TagPrefix="uc" TagName="SmartUploader" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <uc:SmartUploader 
                runat="server" 
                id="SmartUploaderUserPic" 
                UploadFolder="MyFiles" 
                UploadFilter="Documents" 
                OnFileUploadError="SmartUploaderUserPic_FileUploadError" 
                OnFileUploaded="SmartUploaderUserPic_FileUploaded" 
                />
        </div>
    </form>
</body>
</html>
