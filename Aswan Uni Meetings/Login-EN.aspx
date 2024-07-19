<%@ Page Title="" Language="C#" MasterPageFile="~/Master-EN.Master" AutoEventWireup="true" CodeBehind="Login-EN.aspx.cs" Inherits="Aswan_Uni_Meetings.Login_EN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <%-- Script to Prevent Back Button in Browser --%>

    <script type="text/javascript">
        function preback() { (window.history.forward()); }
        setTimeout("preback()", 0);
        window.onunload = function () { (null); }
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

    <%-- Script to Show Password --%>

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
                y.style.display = "none";
                z.style.display = "inline-table";
            }

        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <label class="lang">
            <asp:CheckBox ID="ChBLang" runat="server" AutoPostBack="true" OnCheckedChanged="ChBLang_CheckedChanged" Checked="True" />
            <p>EN </p>
            <span>
                <i></i>
            </span>
            <p>AR </p>
        </label>

        <div class="card">
            <img src="img/graduate.png" />
            <div class="input-field-en">
                <ion-icon name="person"></ion-icon>
                <%--<i class="fas fa-user"></i>--%>
                <asp:TextBox ID="txtEmail" CssClass="input" placeholder="Email" runat="server" TextMode="Email"></asp:TextBox>
                <%--<i class="fas fa-user"></i>--%>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="req-val-en" runat="server" ControlToValidate="txtEmail" ErrorMessage="Enter Email" SetFocusOnError="True"></asp:RequiredFieldValidator>

                <%-- Regular Expression For Aswan University  --%>

                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val-en" ControlToValidate="txtEmail" ValidationExpression="^\w+([-+.']\w+)*@((\w+.aswu.edu.eg)|gmail.com|aswu.edu.eg)$" runat="server" ErrorMessage="Invalid Email" SetFocusOnError="True"></asp:RegularExpressionValidator>
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" runat="server" ErrorMessage="Invalid Email" SetFocusOnError="True"></asp:RegularExpressionValidator>--%>
            </div>

            <div class="input-field-en">
                <ion-icon name="lock-closed"></ion-icon>
                <%--<i class="fas fa-lock"></i>--%>
                <asp:TextBox ID="txtPass" CssClass="input" placeholder="National ID" runat="server" TextMode="Password" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
                <%--<i class="fas fa-lock"></i>--%>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" class="req-val-en" runat="server" ControlToValidate="txtPass" ErrorMessage="Enter National ID" SetFocusOnError="True"></asp:RequiredFieldValidator>

                <%-- Password At Least One Capital and Small Characters  , One Symbol , One Number  --%>

                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="reg-val-en" ControlToValidate="txtPass" ValidationExpression="(2|3)[0-9][0-9](01|02|03|04|05|06|07|08|09|10|11|12)(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)(01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)\d\d\d\d\d" runat="server" ErrorMessage="Not Valid" SetFocusOnError="True"></asp:RegularExpressionValidator>

                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="reg-val" ControlToValidate="txtPass" ValidationExpression="^([a-zA-Z0-9]+){8,32}$" runat="server" ErrorMessage="Invalid Password" SetFocusOnError="True"></asp:RegularExpressionValidator>--%>

                <span class="eye-en" onclick="myFunction()">
                    <%--<i id="hide1" class="fas fa-eye"></i>--%>
                    <ion-icon id="hide1" name="eye-sharp"></ion-icon>
                    <%--<i id="hide2" class="fas fa-eye-slash"></i>--%>
                    <ion-icon id="hide2" name="eye-off-sharp"></ion-icon>
                </span>



            </div>

            <div class="check-forget">
                <asp:CheckBox ID="ChbRemeber" CssClass="check-en" Text="Remeber Me" runat="server" />
                <a class="link" href="Forget Password-EN">Forget Password ? </a>
            </div>


            <asp:Button ID="btnLog" CssClass="btn" runat="server" Text=" Login" OnClick="btnLog_Click" />

            <asp:Label ID="lblMes" CssClass="mes" runat="server" Text="" ForeColor="Red"> Hello </asp:Label>
        </div>

        <div class="buttons-field-en">
            <ion-icon name="arrow-back-outline" size="large"></ion-icon>
            <asp:Button ID="btnhome" CssClass="btn btn-end-en" runat="server" Text="Back To Home" CausesValidation="False" OnClick="btnhome_Click" />
        </div>

    </div>

</asp:Content>
