<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Forget Password.aspx.cs" Inherits="Aswan_Uni_Meetings.Forget_Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%-- Script to Prevent Back Button in Browser --%>

    <script type="text/javascript">
        function preback() { (window.history.forward()); }
        setTimeout("preback()", 0);
        window.onunload = function () { (null); }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

        <label class="lang">
            <asp:CheckBox ID="ChBLang" runat="server" AutoPostBack="true" OnCheckedChanged="ChBLang_CheckedChanged" />
            <p>EN </p>
            <span>
                <i></i>
            </span>
            <p>AR </p>
        </label>

        <div class="card">
            <img src="img/graduate.png" />
            <div class="input-field">
                <ion-icon name="person"></ion-icon>
                <%--<i class="fas fa-user"></i>--%>
                <asp:TextBox ID="txtEmail" CssClass="input" placeholder="أدخل الأيميل" runat="server" TextMode="Email"></asp:TextBox>
                <%--<i class="fas fa-user"></i>--%>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="req-val" runat="server" ControlToValidate="txtEmail" ErrorMessage="أدخل الأيميل" SetFocusOnError="True"></asp:RequiredFieldValidator>

                <%-- Regular Expression For Aswan University  --%>

                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="^\w+([-+.']\w+)*@((\w+.aswu.edu.eg)|gmail.com|aswu.edu.eg)$" runat="server" ErrorMessage="ادخل إيميل الجامعى" SetFocusOnError="True"></asp:RegularExpressionValidator>
               
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" runat="server" ErrorMessage="Invalid Email" SetFocusOnError="True"></asp:RegularExpressionValidator>--%>
            
            </div>

            <asp:Button ID="btnSend" CssClass="btn" runat="server" Text=" أرسل الإيميل " OnClick="btnSend_Click" />

            <asp:Label ID="lblMes" CssClass="mes" runat="server" Text="" ForeColor="Red"> Hello </asp:Label>

        </div>

        <div class="buttons-field">
            <asp:Button ID="btnback" CssClass="btn btn-end" runat="server" Text="الرجوع لصفحة تسجيل الدخول" CausesValidation="False" OnClick="btnback_Click" />
            <ion-icon name="arrow-forward-outline" size="large"></ion-icon>
        </div>

    </div>
</asp:Content>
