<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Aswan_Uni_Meetings.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content">

        <label class="lang">
            <asp:CheckBox ID="ChBLang" runat="server" AutoPostBack="true" OnCheckedChanged="ChBLang_CheckedChanged" />
            <p>EN </p>
            <span>
                <i></i>
            </span>
            <p>AR </p>
        </label>

        <h1>نسخة تجريبية </h1>
        <h1>تطبيق المجالس والجان الخاصة بجامعة أسوان </h1>
        <%--<h1> Academic Staff Meetings Aswan University </h1>--%>

        <img src="img/Meetings.jpg" />

        <div class="buttons">
            <div class="buttons-field">
                <asp:Button ID="btnLog" CssClass="btn" runat="server" Text="صفحة تسجيل الدخول" OnClick="btnLog_Click" OnClientClick="target ='_self';" />
                <ion-icon name="enter-outline"></ion-icon>
            </div>
            <div class="buttons-field">
                <%--<asp:Button ID="btnReg" CssClass="btn" runat="server" Text="إنشاء حساب" />--%>
                <asp:Button ID="btnPortal" CssClass="btn" runat="server" Text="بوابة الخدمات الألكترونية" OnClick="btnPortal_Click" OnClientClick="target ='_self';" />
                <ion-icon name="home-outline"></ion-icon>
            </div>

        </div>
    </div>
</asp:Content>
