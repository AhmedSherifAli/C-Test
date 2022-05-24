<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reset Password.aspx.cs" Inherits="Login___Registration_Enhanced.Reset_Password" %>

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
            <h2> Enter the Reset Password </h2>
            <h3 class="hint"> * Password not less 8 character contains Capital or small Letters or Numbers * </h3>
            <div class="input-field">
                <i class="fas fa-lock"></i>
                <asp:TextBox ID="txtPass" CssClass="input" placeholder="Password" runat="server" TextMode="SingleLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="req-val" runat="server" ControlToValidate="txtPass" ErrorMessage="" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtPass" ValidationExpression="^([a-zA-Z0-9]+){8,32}$" runat="server" ErrorMessage="" SetFocusOnError="True">*</asp:RegularExpressionValidator> 
            </div>
            <div class="input-field">
                <i class="fas fa-lock"></i>
                <asp:TextBox ID="txtPassRepeat" CssClass="input" placeholder="Repeat Password" runat="server" TextMode="SingleLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="req-val" runat="server" ControlToValidate="txtPass" ErrorMessage="" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="reg-val" ControlToValidate="txtPass" ValidationExpression="^([a-zA-Z0-9]+){8,32}$" runat="server" ErrorMessage="" SetFocusOnError="True">*</asp:RegularExpressionValidator> 
            </div>
            <asp:Button ID="btnReset" class="btn solid" runat="server" Text="Reset" OnClick="btnReset_Click" />
            <asp:Label ID="LabelMes" runat="server" class="mes" Text=""></asp:Label>
        </div>

    </form>
</body>
</html>
