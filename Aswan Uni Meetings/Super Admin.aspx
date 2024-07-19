<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Super Admin.aspx.cs" Inherits="Aswan_Uni_Meetings.Super_Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%-- Script to Prevent Back Button in Browser --%>

    <script type="text/javascript">
        function preback() { (window.history.forward()); }
        setTimeout("preback()", 0);
        window.onunload = function () { (null); }
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
        function KeyPressOrder(fld, e) {

            var strCheck = '0123456789';
            var whichCode = e.which ? e.which : e.keyCode;

            if (whichCode == 13 || whichCode == 8 || whichCode == 9) return true;
            key = String.fromCharCode(whichCode);
            if (strCheck.indexOf(key) == -1) return false;

            return true;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-user">

        <div class="navigation">
            <ul>
                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="logo-medium"></ion-icon>
                        </span>
                        <span class="title">إجتمعات </span>
                    </a>
                </li>
                <li class="hovered">
                    <a href="Super Admin">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title">الرئيسية </span>
                    </a>
                </li>
                <%--<li>
                    <a href="Normal User">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title"> السكرتارية </span>
                    </a>
                </li>--%>
                <li>
                    <a href="Default">
                        <span class="icon">
                            <ion-icon name="log-out-outline"></ion-icon>
                        </span>
                        <asp:Button ID="btnlogout" runat="server" Text="تسجيل الخروج" BorderStyle="None" CausesValidation="False" OnClick="btnlogout_Click" />
                        <span class="title"></span>
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main -->
        <div class="main">
            <label class="lang">
                <asp:CheckBox ID="ChBLang" runat="server" AutoPostBack="true" OnCheckedChanged="ChBLang_CheckedChanged" />
                <p>EN </p>
                <span>
                    <i></i>
                </span>
                <p>AR </p>
            </label>
            <div class="topbar">
                <%--<div class="detail">
                    <asp:Label ID="lblname" CssClass="name" runat="server" Text="Label"></asp:Label>
                    <%--<div class="notification">
                        <asp:Label ID="lblNotif" runat="server" Text="1"></asp:Label>
                        <asp:ImageButton ID="btnNotif" runat="server" ImageUrl="~/img/bell.jpg" ToolTip="دعوة إجتماع جديد" />
                    </div>--%>
            </div>


            <div class="card">
                <div class="inputs">
                    <div class="input-field">
                        <ion-icon name="person"></ion-icon>
                        <asp:TextBox ID="txtName" CssClass="input" placeholder="أدخـل الأسم" runat="server" onkeypress="return valid()" onkeydown="return valid()"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="req-val" runat="server" ControlToValidate="txtName" ErrorMessage="أدخـل الأسم" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        <%-- Password At Least One Capital and Small Characters  , One Symbol , One Number  --%>

                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtName" ValidationExpression="[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z\s]{2,25}" runat="server" ErrorMessage="غير مطابق للكود المصرى" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    </div>
                    <div class="input-field">
                        <ion-icon name="mail-outline"></ion-icon>
                        <asp:TextBox ID="txtEmail" CssClass="input" placeholder="أدخـل الإيميل" runat="server" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="req-val" runat="server" ControlToValidate="txtEmail" ErrorMessage="أدخـل الإيميل" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        <%-- Password At Least One Capital and Small Characters  , One Symbol , One Number  --%>

                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="^\w+([-+.']\w+)*@((\w+.aswu.edu.eg)|gmail.com|aswu.edu.eg)$" runat="server" ErrorMessage="الإيميل غير مطابق" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    </div>
                    <div class="input-field">
                        <ion-icon name="person"></ion-icon>
                        <asp:TextBox ID="txtNationalID" CssClass="input" placeholder="أدخـل الرقم القومى" runat="server" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" CssClass="req-val" runat="server" ControlToValidate="txtNationalID" ErrorMessage="أدخـل الرقم القومى" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        <%-- Password At Least One Capital and Small Characters  , One Symbol , One Number  --%>

                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" CssClass="reg-val" ControlToValidate="txtNationalID" ValidationExpression="(2|3)[0-9][0-9](01|02|03|04|05|06|07|08|09|10|11|12)(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)(01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)\d\d\d\d\d" runat="server" ErrorMessage="غير مطابق للكود المصرى" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="lists">
                    <asp:DropDownList ID="DropFaculty" CssClass="list" runat="server"></asp:DropDownList>
                    <asp:DropDownList ID="DropDep" CssClass="list" runat="server"></asp:DropDownList>
                    <asp:DropDownList ID="DropRole_Ar" CssClass="list" runat="server"></asp:DropDownList>
                    <asp:DropDownList ID="DropRole_EN" CssClass="list" runat="server"></asp:DropDownList>
                    <asp:DropDownList ID="DropMeeting_AR" CssClass="list" runat="server"></asp:DropDownList>
                    <asp:DropDownList ID="DropMeeting_EN" CssClass="list" runat="server"></asp:DropDownList>
                </div>
                <div class="buttons">
                    <div class="buttons-field">
                        <asp:Button ID="btnAdd" CssClass="btn" runat="server" Text="إضافة" OnClick="btnAdd_Click" />
                        <ion-icon name="enter-outline"></ion-icon>
                    </div>
                    <div class="buttons-field">
                        <asp:Button ID="btnEdit" CssClass="btn" runat="server" Text="تـعديل" OnClick="btnEdit_Click" />
                        <ion-icon name="arrow-redo-circle-outline"></ion-icon>
                    </div>

                    <div class="buttons-field">
                        <asp:Button ID="btnDelete" CssClass="btn" runat="server" Text="حذف" CausesValidation="false" OnClick="btnDelete_Click" />
                        <ion-icon name="arrow-redo-circle-outline"></ion-icon>
                    </div>
                </div>
            </div>

            <div class="error">
                <asp:Label ID="lblMes" runat="server" Text="Hello"></asp:Label>
            </div>

            <div class="sort">
                <asp:DropDownList ID="DropFaculty_Sort" CssClass="list" runat="server" OnSelectedIndexChanged="DropFaculty_Sort_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
            </div>

            <div class="grid-con">
                <asp:GridView ID="GdPersons" CssClass="grid" runat="server" AutoGenerateColumns="False">
                    <Columns>

                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="">

                            <ItemTemplate>
                                <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Eval("StaffID") %>' CommandName="select" ForeColor="Black" OnCommand="btnSelect_Command"> أختر الصف </asp:LinkButton>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="الأسم">

                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("StaffArName") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="الأيميل">
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("PersonalEmail") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="الرقم القومى">
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("StaffNationalID") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="القسم">
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("DepartmentArName") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

        </div>

    </div>
    <script src="app.js"></script>
</asp:Content>
