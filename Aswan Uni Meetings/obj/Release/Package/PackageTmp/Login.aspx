<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Aswan_Uni_Meetings.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<link rel="stylesheet" href="all.css" />--%>

    <%-- Script to Show and Hide Password --%>

    <script type="text/javascript">
        function myFunction() {
            var x = document.getElementById("ContentPlaceHolder1_txtPass");
            var y = document.getElementById("hide1");
            var z = document.getElementById("hide2");
            if (x.type == 'password') {
                x.type = "text";
                y.style.display = "inline-table";
                z.style.display = "none";
            }
            else {
                x.type = "password";
                x.textContent.substring(0, 7);
                y.style.display = "none";
                z.style.display = "inline-table";
            }

        }
    </script>

    <%-- Script to Prevent Symbols and Characters in National ID Text Box --%>

    <script>
        function KeyPressOrder(fld, e) {

            var strCheck = '0123456789';
            var whichCode = e.which ? e.which : e.keyCode;

            if (whichCode == 13 || whichCode == 8 || whichCode == 9) return true;
            key = String.fromCharCode(whichCode);
            if (strCheck.indexOf(key) == -1) return false;

            return true;
        }
    </script>

    <%-- Script to Prevent Back Button in Browser --%>

    <script type="text/javascript">
        function preback() { (window.history.forward()); }
        setTimeout("preback()", 0);
        window.onunload = function () { (null); }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<img class="wave" src="img/meetinglogin.svg" />--%>
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
                <asp:TextBox ID="txtEmail" CssClass="input" placeholder="الأيميل" runat="server" TextMode="Email"></asp:TextBox>
                <%--<i class="fas fa-user"></i>--%>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="req-val" runat="server" ControlToValidate="txtEmail" ErrorMessage="أدخل الأيميل" SetFocusOnError="True"></asp:RequiredFieldValidator>

                <%-- Regular Expression For Aswan University  --%>

                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="^\w+([-+.']\w+)*@((\w+.aswu.edu.eg)|gmail.com|aswu.edu.eg)$" runat="server" ErrorMessage="ادخل إيميل الجامعى" SetFocusOnError="True"></asp:RegularExpressionValidator>
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" runat="server" ErrorMessage="Invalid Email" SetFocusOnError="True"></asp:RegularExpressionValidator>--%>
            </div>

            <div class="input-field">
                <ion-icon name="lock-closed"></ion-icon>
                <%--<i class="fas fa-lock"></i>--%>
                <asp:TextBox ID="txtPass" CssClass="input" placeholder="الرقم القومى" runat="server" TextMode="Password" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
                <%--<i class="fas fa-lock"></i>--%>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" class="req-val" runat="server" ControlToValidate="txtPass" ErrorMessage="أدخل الرقم القومى" SetFocusOnError="True"></asp:RequiredFieldValidator>

                <%-- Password At Least One Capital and Small Characters  , One Symbol , One Number  --%>

                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="reg-val" ControlToValidate="txtPass" ValidationExpression="(2|3)[0-9][0-9](01|02|03|04|05|06|07|08|09|10|11|12)(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)(01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)\d\d\d\d\d" runat="server" ErrorMessage="غير مطابق للكود المصرى" SetFocusOnError="True"></asp:RegularExpressionValidator>

                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="reg-val" ControlToValidate="txtPass" ValidationExpression="^([a-zA-Z0-9]+){8,32}$" runat="server" ErrorMessage="Invalid Password" SetFocusOnError="True"></asp:RegularExpressionValidator>--%>

                <span class="eye" onclick="myFunction()">
                    <%--<i id="hide1" class="fas fa-eye"></i>
                    <i id="hide2" class="fas fa-eye-slash"></i>--%>
                    <ion-icon name="eye-sharp" id="hide1"></ion-icon>
                    <ion-icon name="eye-off-sharp" id="hide2"></ion-icon>
                </span>

            </div>

            <div class="check-forget">
                <asp:CheckBox ID="ChbRemeber" CssClass="check" Text="تذكرالحساب" runat="server" />
                <a class="link" href="Forget Password"> هل نسيت كلمة المرور ؟ </a>
            </div>


            <asp:Button ID="btnLog" CssClass="btn" runat="server" Text=" تسجيل الدخول" OnClick="btnLog_Click" />

            <asp:Label ID="lblMes" CssClass="mes" runat="server" Text="" ForeColor="Red"> Hello </asp:Label>

        </div>


        <%--<ion-icon name="arrow-back-outline" size="large"></ion-icon>--%>


        <div class="buttons-field">
            <asp:Button ID="btnhome" CssClass="btn btn-end" runat="server" Text="الرجوع للصفحة الرئيسية" CausesValidation="False" OnClick="btnhome_Click" />
            <ion-icon name="arrow-forward-outline" size="large"></ion-icon>
        </div>

    </div>
</asp:Content>




