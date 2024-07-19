<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Normal User-Member.aspx.cs" Inherits="Aswan_Uni_Meetings.Normal_User_Member" %>

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
                <li>
                    <a href="Normal User">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title">تفاصيل الأجتماع </span>
                    </a>
                </li>
                <li class="hovered">
                    <a href="Normal User-Member">
                        <span class="icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </span>
                        <span class="title">أعضاء الأجتماع </span>
                    </a>
                </li>
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
                <div class="detail">
                    <asp:Label ID="lblname" CssClass="name" runat="server" Text="Label"></asp:Label>
                </div>

                <asp:DropDownList ID="DropList" CssClass="list" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropList_SelectedIndexChanged"></asp:DropDownList>
            </div>

            <div class="card-inv">

                <label for="ContentPlaceHolder1_upload" class="file-upload" id="upload-btn">
                    <ion-icon name="cloud-upload-outline"></ion-icon>
                    <span id="text"> أختر الملف </span>
                    <asp:FileUpload ID="upload" runat="server" />
                </label>

                <div class="buttons-field">
                    <asp:Button ID="btnAddInv" CssClass="btn" runat="server" Text="إضافة الدعوة" CausesValidation="False" OnClick="btnAddInv_Click" />
                    <ion-icon name="enter-outline"></ion-icon>
                </div>
            </div>

            <div class="error">
                <asp:Label ID="lblMesInv" runat="server" Text="Hello"></asp:Label>
            </div>

            <div class="card">
                <div class="name">
                    <div class="input-field">
                        <ion-icon name="person"></ion-icon>
                        <asp:TextBox ID="txtSearch" CssClass="input" placeholder="أدخـل الرقم القومى" runat="server" onkeypress="return(KeyPressOrder(this,event))" onkeydown="(KeyPressOrder(this,event))"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="req-val" runat="server" ControlToValidate="txtSearch" ErrorMessage="أدخـل الرقم القومى" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        <%-- Password At Least One Capital and Small Characters  , One Symbol , One Number  --%>

                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="reg-val" ControlToValidate="txtSearch" ValidationExpression="(2|3)[0-9][0-9](01|02|03|04|05|06|07|08|09|10|11|12)(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)(01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)\d\d\d\d\d" runat="server" ErrorMessage="غير مطابق للكود المصرى" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="type">
                     <asp:DropDownList ID="DropType" CssClass="list" runat="server"></asp:DropDownList>
                </div>
                <div class="buttons">
                    <div class="buttons-field">
                        <asp:Button ID="btnSearch" CssClass="btn" runat="server" Text="بحث" OnClick="btnSearch_Click" />
                        <ion-icon name="search-circle-outline"></ion-icon>
                    </div>
                    <div class="buttons-field">
                        <asp:Button ID="btnAdd" CssClass="btn" runat="server" Text="إضافة عضو" CausesValidation="False" OnClick="btnAdd_Click" />
                        <ion-icon name="add-circle-outline"></ion-icon>
                    </div>
                    <div class="buttons-field">
                        <asp:Button ID="btnDelete" CssClass="btn" runat="server" Text="حذف عضو" CausesValidation="False" OnClick="btnDelete_Click" />
                        <ion-icon name="close-circle-outline"></ion-icon>
                    </div>
                </div>

                <div class="grid-con">
                    <asp:GridView ID="GdStaff" CssClass="grid" runat="server" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="الأسم">

                                <ItemTemplate>
                                    <asp:Label Text='<%# Eval("StaffArName") %>' runat="server"></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle CssClass="head"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="الإيميل">
                                <ItemTemplate>
                                    <asp:Label Text='<%# Eval("UniversityEmail") %>' runat="server"></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle CssClass="head"></HeaderStyle>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                </div>

            </div>
            <div class="grid-con">
                <asp:GridView ID="GdDoc" CssClass="grid" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="GdDoc_SelectedIndexChanged">
                    <Columns>

                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="">

                            <ItemTemplate>
                                <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Eval("StaffID") %>' CommandName="select" ForeColor="Black" OnCommand="btnSelect_Command" CausesValidation="False"> أختر الصف </asp:LinkButton>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="الأسم">

                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("StaffArName") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="الإيميل">
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("UniversityEmail") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="عضوية الأجتماع">
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("MeetingRole") %>' runat="server"></asp:Label>
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
        <script src="app.js"></script>

    </div>
</asp:Content>
