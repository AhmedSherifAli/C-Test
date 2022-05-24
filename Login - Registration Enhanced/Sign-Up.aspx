<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sign-Up.aspx.cs" Inherits="Login___Registration_Enhanced.Sign_Up" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="CSS.css" />
    <link rel="stylesheet" href="Font Awesome/css/all.css" />

    <%-- Script to Show Password before Registeration --%>

    <script type="text/javascript">
        function myFunction() {
            var check = document.getElementById("box1");
            var textPass = document.getElementById("txtPass");
            var textRepeat = document.getElementById("txtPassRepeat");
            if (check.checked == true) {
                textPass.type = "text";
                textRepeat.type = "text";
            }
            else {
                textPass.type = "password";
                textRepeat.type = "password";
            }
        }
    </script>

    <%-- Script to Prevent Symbols and Numbers in User Name Text Box --%>

    <script>
        function valid() {
            var charCode = (event.which) ? event.which : event.keycode;
            if ((charCode >= 33 && charCode <= 64) || (charCode >= 91 && charCode <= 96) || (charCode >= 123 && charCode <= 126)) { return false; }
            else { return true; }
        }
    </script>

    <%-- Script to Prevent Symbols and Characters in National ID Text Box --%>

    <script>
        function valid_Number() {
            var charCode = (event.which) ? event.which : event.keycode;
            if ((charCode >= 32 && charCode <= 47) || (charCode >= 58 && charCode <= 126)) { return false; }
            else { return true; }
        }
    </script>

    
    <%-- Script to Prevent Symbols Password Text Box --%>

    <script>
        function valid_Pass() {
            var charCode = (event.which) ? event.which : event.keycode;
            if ((charCode >= 32 && charCode <= 47) || (charCode >= 58 && charCode <= 64) || (charCode >= 91 && charCode <= 96) || (charCode >= 123 && charCode <= 126)) { return false; }
            else { return true; }
        }
    </script>

</head>
<body>
    <div class="container">
        <form id="form1" runat="server">
            <div class="forms-container">
                <div class="signin-signup">
                   
                    <section class="sign-in-form">

                        <img class="image-logo-up" src="img/uni.jpg" />

                        <h2 class="title"> Important Notes For Registeration </h2>
                        <p class="notes">
                            1. User Name accpet Arabic and English
                            <br />
                            2. Enter Aswan College Email
                            <br />
                            3. Password Not Less 8 Characters , Can contain Capital and Small letters and Numbers
                            <br />
                            4. Choose the Correct Departement
                            <br />
                        </p>

                        <a class="link-reg" href="Sign-In"> Do You Have Account Click to Sign In ? </a>

                        <asp:Label ID="lblHint" class="mes" runat="server" Text=""></asp:Label>
                    </section>
                    
                    <section class="sign-up-form">

                        <h2 class="title"> Create Account </h2>

                        <div class="input-field">
                            <i class="fas fa-user"></i>
                            <asp:TextBox ID="txtUserName" CssClass="input" placeholder="Username" runat="server" onkeypress="return valid()"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" class="req-val" runat="server" ControlToValidate="txtUserName" ErrorMessage="Empty Name" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtUserName" ValidationExpression="^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z\s]{2,25}$" runat="server" ErrorMessage="Invalid Name" SetFocusOnError="True"></asp:RegularExpressionValidator>
                        </div>

                        <span class="tool-tip-name" data-tooltip="Name accpet Arabic and English">?</span>

                        <div class="input-field">
                            <i class="fas fa-envelope"></i>
                            <asp:TextBox ID="txtEmail" CssClass="input" placeholder="Email" runat="server" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="req-val" runat="server" ControlToValidate="txtEmail" ErrorMessage="Empty Email" SetFocusOnError="True"></asp:RequiredFieldValidator>

                            <%-- Regular Expression For Aswan University and Gmail  --%>

                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="^\w+([-+.'_]\w+)*@((\w+.aswu.edu.eg)|gmail.com)$" runat="server" ErrorMessage="Invalid Email" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" runat="server" ErrorMessage="Invalid Email" SetFocusOnError="True"></asp:RegularExpressionValidator>--%>
                        </div>

                        <div class="input-field">
                            <i class="fas fa-lock"></i>
                            <asp:TextBox ID="txtPass" CssClass="input" placeholder="Password" runat="server" TextMode="Password" onkeypress="return valid_Pass()"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" class="req-val" runat="server" ControlToValidate="txtPass" ErrorMessage="Empty Password" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" CssClass="reg-val" ControlToValidate="txtPass" ValidationExpression="^([a-zA-Z0-9]+){8,32}$" runat="server" ErrorMessage="Invalid Password" SetFocusOnError="True"></asp:RegularExpressionValidator>
                        </div>

                        <span class="tool-tip-password" data-tooltip="A-Z , a-z , 0-9 are allowed Not less 8 characters">?</span>

                        <div class="input-field">
                            <i class="fas fa-lock"></i>
                            <asp:TextBox ID="txtPassRepeat" CssClass="input" placeholder="Repeat Password" runat="server" TextMode="Password" onkeypress="return valid_Pass()"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" class="req-val" runat="server" ControlToValidate="txtPassRepeat" ErrorMessage="Empty Password" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" CssClass="reg-val" ControlToValidate="txtPassRepeat" ControlToCompare="txtPass" runat="server" ErrorMessage="Password not match"></asp:CompareValidator>
                        </div>

                        <div class="input-field">
                            <i class="fas fa-user"></i>
                            <asp:TextBox ID="txtID" CssClass="input" placeholder="الرقم القومى" runat="server" onkeypress="return valid_Number()"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" class="req-val" runat="server" ControlToValidate="txtID" ErrorMessage="Empty ID" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" CssClass="reg-val" ControlToValidate="txtID" ValidationExpression="^[0-9]{14}$" runat="server" ErrorMessage="Invalid ID" SetFocusOnError="True"></asp:RegularExpressionValidator>
                        </div>

                        <div class="input-field">
                            <asp:DropDownList ID="Droplist" CssClass="Drop" runat="server">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" class="req-val-Drop" runat="server" ControlToValidate="Droplist" InitialValue="-1" ErrorMessage="Select Department" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>



                        <div class="show">
                            <asp:CheckBox ID="box1" runat="server" onclick="myFunction()" />
                            <label for="box1">Show Password </label>
                        </div>

                        <asp:Button ID="btnSignUp" class="btn solid" runat="server" Text="Register" OnClick="btnSignUp_Click" />

                        <div>
                            <asp:Label ID="LabelMes" class="mes" runat="server" Text=""></asp:Label>
                        </div>

                        <%--<p class="social-text">Or Sign up with social platforms </p>
                            <div class="social-media">
                                <a href="#" class="social-icon">
                                    <i class="fab fa-facebook-f"></i>
                                </a>
                                <a href="#" class="social-icon">
                                    <i class="fab fa-twitter"></i>
                                </a>
                                <a href="#" class="social-icon">
                                    <i class="fab fa-google"></i>
                                </a>
                                <a href="#" class="social-icon">
                                    <i class="fab fa-linkedin-in"></i>
                                </a>
                            </div>--%>
                    </section>

                </div>
            </div>
        </form>

        <div class="panels-container">
            <div class="panel left-panel">
                <div class="content">
                    <h3>New here ? </h3>
                    <p></p>
                    <button class="btn transparent" id="sign-up-btn">Sign up</button>
                </div>
                <img src="img/SignUp.svg" class="image" alt="" />
            </div>
            <div class="panel right-panel">
                <div class="content">
                    <%--<h3>One of us ? </h3>--%>
                    <h3>Please Read Notes Befor Registeration </h3>
                    <br />
                    <button class="btn transparent" id="sign-in-btn">Return </button>

                </div>
                
            </div>
        </div>

        <%-- Script Make Animation --%>

        <script src="app.js"></script>

    </div>
</body>
</html>
