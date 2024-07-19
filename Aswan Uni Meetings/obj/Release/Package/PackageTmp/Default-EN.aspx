<%@ Page Title="" Language="C#" MasterPageFile="~/Master-EN.Master" AutoEventWireup="true" CodeBehind="Default-EN.aspx.cs" Inherits="Aswan_Uni_Meetings.Default_EN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="content">

        <label class="lang">
            <asp:CheckBox ID="ChBLang" runat="server" AutoPostBack="true" OnCheckedChanged="ChBLang_CheckedChanged" Checked="True" />
            <p>EN </p>
            <span>
                <i></i>
            </span>
            <p>AR </p>
        </label>

        <%-- <h1> نسخة تجريبية </h1>--%>
        <h1>Beta Version </h1>
        <%--<h1> تطبيق المجالس والجان الخاصة بجامعة أسوان </h1>--%>
        <h1>Academic Staff Meetings Aswan University </h1>

        <img src="img/Meetings.jpg" />

        <div class="buttons">
            <div class="buttons-field-en">
                <ion-icon name="home-outline"></ion-icon>
                <asp:Button ID="btnPortal" CssClass="btn" runat="server" Text="Aswan Portal" OnClick="btnPortal_Click" OnClientClick="target ='_self';" />
            </div>
            <div class="buttons-field-en">
                <ion-icon name="enter-outline"></ion-icon>
                <asp:Button ID="btnLog" CssClass="btn" runat="server" Text="Login Page" OnClick="btnLog_Click" OnClientClick="target ='_self';" />
            </div>
        </div>

    </main>
</asp:Content>
