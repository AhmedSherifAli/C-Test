<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sign-In.aspx.cs" Inherits="Login___Registration_Enhanced.Sign_In" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="CSS.css" />
    <link rel="stylesheet" href="Font Awesome/css/all.css" />
    
    <%-- Script For Show Password With Eye --%>
    
    <script type="text/javascript">
        function myFunction() {
            var x = document.getElementById("txtPass");
            var y = document.getElementById("hide1");
            var z = document.getElementById("hide2");
            if (x.type == 'password') {
                x.type = "text";
                y.style.display = "block";
                z.style.display = "none";
            }
            else {
                x.type = "password";
                y.style.display = "none";
                z.style.display = "block";
            }

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
                        
                        <img class="image-logo-in" src="img/uni.jpg" />

                        <h2 class="title"> Important Notes For Login </h2>
                        <p class="notes">
                            1. Don't Enter Wrong Password more Than 3 Times or Your Account will Suspend
                            <br />
                            2. If Your Acoount Suspended Please contact with administrator
                            <br />
                        </p>

                        <a class="link-reg" href="Sign-Up"> Don't have Account Click to Sign Up ? </a>

                        <asp:Label ID="lblHint" class="mes" runat="server" Text=""></asp:Label>
                    </section>

                    <section class="sign-up-form">

                        <h2 class="title"> Sign in </h2>
                        <div class="input-field">
                            <i class="fas fa-user"></i>
                            <asp:TextBox ID="txtEmail" CssClass="input" placeholder="Email" runat="server" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="req-val" runat="server" ControlToValidate="txtEmail" ErrorMessage="Empty Email" SetFocusOnError="True"></asp:RequiredFieldValidator>

                            <%-- Regular Expression For Aswan University  --%>

                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="^\w+([-+.']\w+)*@((\w+.aswu.edu.eg)|gmail.com)$" runat="server" ErrorMessage="Invalid Email" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" runat="server" ErrorMessage="Invalid Email" SetFocusOnError="True"></asp:RegularExpressionValidator>--%>
                        </div>

                        <div class="input-field">
                            <i class="fas fa-lock"></i>
                            <asp:TextBox ID="txtPass" CssClass="input" placeholder="Password" runat="server" TextMode="Password" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" class="req-val" runat="server" ControlToValidate="txtPass" ErrorMessage="Empty Password" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            
                            <%-- Password At Least One Capital and Small Characters  , One Symbol , One Number  --%>

                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="reg-val" ControlToValidate="txtPass" ValidationExpression="^(?=(.*\d){1})(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z\d]).{8,15}$" runat="server" ErrorMessage="Invalid Password" SetFocusOnError="True" Enabled="True"></asp:RegularExpressionValidator>

                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="reg-val" ControlToValidate="txtPass" ValidationExpression="^([a-zA-Z0-9]+){8,32}$" runat="server" ErrorMessage="Invalid Password" SetFocusOnError="True"></asp:RegularExpressionValidator>--%>
                            
                            <span class="eye" onclick="myFunction()">
                                <i id="hide1" class="fas fa-eye"></i>
                                <i id="hide2" class="fas fa-eye-slash"></i>
                            </span>
                        </div>
                      

                        <asp:Button ID="btnLogin" class="btn solid" runat="server" Text="Login" OnClick="btnLogin_Click" />

                        <a class="link" href="Forget Password.aspx"> Forget Password ? </a>

                        <asp:Label ID="LabelMes" class="mes" runat="server" Text=""></asp:Label>
                        <%--<p class="social-text">Or Sign in with social platforms </p>
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
                    <h3>Welcome Back </h3>
                    <p></p>
                    <button class="btn transparent" id="sign-up-btn">Sign in </button>
                </div>
                <img src="img/SignIn.svg" class="image" alt="" />
            </div>
            <div class="panel right-panel">
                <div class="content">
                    <h3>Please Read Notes Befor Login </h3>
                    <br />
                    <button class="btn transparent" id="sign-in-btn">Return </button>
                </div>
            </div>
        </div>

        <script src="app.js"></script>

    </div>
</body>
</html>
