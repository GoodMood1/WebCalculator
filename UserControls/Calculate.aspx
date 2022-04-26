<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Calculate.aspx.cs" Inherits="UserControls.Calculate" %>

<%@ Register Src="~/Calculator.ascx" TagPrefix="myControls" TagName="Calculator" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="formCalculatorsTest" runat="server">
      <style>
          .calcControl{
              background-color:aqua;
          }
      </style>
        <div>
            <myControls:Calculator runat="server" ID="Calculator" CalcMode="Standard" />
        </div>
    </form>
</body>
</html>
