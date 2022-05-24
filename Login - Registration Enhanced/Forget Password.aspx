<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forget Password.aspx.cs" Inherits="Login___Registration_Enhanced.Forget_Password" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="CSS.css" />
    <link rel="stylesheet" href="Font Awesome/css/all.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="con-forget">
            <h2>Enter Your Email to Reset Password </h2>
            <div class="input-field">
                <i class="fas fa-lock"></i>
                <asp:TextBox ID="txtEmail" CssClass="input" placeholder="Email" runat="server" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="req-val" runat="server" ControlToValidate="txtEmail" ErrorMessage="" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" runat="server" ErrorMessage="" SetFocusOnError="True">*</asp:RegularExpressionValidator>
               
            </div>
             <asp:Button ID="btnReset" class="btn solid" runat="server" Text="Send" OnClick="btnReset_Click" />
                <br />
                <asp:Label ID="LabelMes" class="mes" runat="server" CssClass="mes" Text=""></asp:Label>
        </div>

    </form>
</body>
</html>
