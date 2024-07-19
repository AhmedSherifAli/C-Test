<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Super Admin.aspx.cs" Inherits="Aswan_Uni_Meetings.Super_Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%-- Script to Prevent Back Button in Browser --%>

    <script type="text/javascript">
        function preback() { (window.history.forward()); }
        setTimeout("preback()", 0);
        window.onunload = function () { (null); }
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
            <%--<label class="lang">
                <asp:CheckBox ID="ChBLang" runat="server" AutoPostBack="true" OnCheckedChanged="ChBLang_CheckedChanged" />
                <p>EN </p>
                <span>
                    <i></i>
                </span>
                <p>AR </p>
            </label>--%>
            <div class="topbar">
                <%--<div class="detail">
                    <asp:Label ID="lblname" CssClass="name" runat="server" Text="Label"></asp:Label>
                    <%--<div class="notification">
                        <asp:Label ID="lblNotif" runat="server" Text="1"></asp:Label>
                        <asp:ImageButton ID="btnNotif" runat="server" ImageUrl="~/img/bell.jpg" ToolTip="دعوة إجتماع جديد" />
                    </div>--%>

                <asp:DropDownList ID="DropList" CssClass="list" runat="server" AutoPostBack="True"></asp:DropDownList>
            </div>


            <div class="card">
                <div class="inputs">
                    <div class="input-field">
                        <ion-icon name="person"></ion-icon>
                        <asp:TextBox ID="txtName" CssClass="input" placeholder="أدخـل الأسم" runat="server" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="req-val" runat="server" ControlToValidate="txtName" ErrorMessage="أدخـل الرقم القومى" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        <%-- Password At Least One Capital and Small Characters  , One Symbol , One Number  --%>

                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtName" ValidationExpression="(2|3)[0-9][0-9](01|02|03|04|05|06|07|08|09|10|11|12)(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)(01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)\d\d\d\d\d" runat="server" ErrorMessage="غير مطابق للكود المصرى" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    </div>
                    <div class="input-field">
                        <ion-icon name="mail-outline"></ion-icon>
                        <asp:TextBox ID="txtEmail" CssClass="input" placeholder="أدخـل الإيميل" runat="server" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="req-val" runat="server" ControlToValidate="txtEmail" ErrorMessage="أدخـل الرقم القومى" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        <%-- Password At Least One Capital and Small Characters  , One Symbol , One Number  --%>

                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="reg-val" ControlToValidate="txtEmail" ValidationExpression="(2|3)[0-9][0-9](01|02|03|04|05|06|07|08|09|10|11|12)(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)(01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)\d\d\d\d\d" runat="server" ErrorMessage="غير مطابق للكود المصرى" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    </div>
                    <div class="input-field">
                        <ion-icon name="person"></ion-icon>
                        <asp:TextBox ID="txtNationalID" CssClass="input" placeholder="أدخـل الرقم القومى" runat="server" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" CssClass="req-val" runat="server" ControlToValidate="txtNationalID" ErrorMessage="أدخـل الرقم القومى" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        <%-- Password At Least One Capital and Small Characters  , One Symbol , One Number  --%>

                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" CssClass="reg-val" ControlToValidate="txtNationalID" ValidationExpression="(2|3)[0-9][0-9](01|02|03|04|05|06|07|08|09|10|11|12)(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)(01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)\d\d\d\d\d" runat="server" ErrorMessage="غير مطابق للكود المصرى" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="buttons">
                    <div class="buttons-field">
                        <asp:Button ID="btnInsert" CssClass="btn" runat="server" Text="إضافة" />
                        <ion-icon name="enter-outline"></ion-icon>
                    </div>
                    <div class="buttons-field">

                        <%--<asp:Button ID="btnReg" CssClass="btn" runat="server" Text="إنشاء حساب" />--%>
                        <asp:Button ID="btnEdit" CssClass="btn" runat="server" Text="تـعديل" />
                        <ion-icon name="arrow-redo-circle-outline"></ion-icon>
                    </div>

                    <div class="buttons-field">

                        <%--<asp:Button ID="btnReg" CssClass="btn" runat="server" Text="إنشاء حساب" />--%>
                        <asp:Button ID="btnDelete" CssClass="btn" runat="server" Text="حذف" />
                        <ion-icon name="arrow-redo-circle-outline"></ion-icon>
                    </div>
                </div>
            </div>
            <div class="grid-con">
                <asp:GridView ID="GdPersons" CssClass="grid" runat="server" AutoGenerateColumns="False">
                    <Columns>

                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="">

                            <ItemTemplate>
                                <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="select" ForeColor="Black"> أختر الصف </asp:LinkButton>
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
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="الكلية">
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("FacultyID") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="القسم">
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("DepartmrntID") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <div class="error">
                <asp:Label ID="lblMes" runat="server" Text="Hello"></asp:Label>
            </div>


        </div>

    </div>
    <script src="app.js"></script>
</asp:Content>
