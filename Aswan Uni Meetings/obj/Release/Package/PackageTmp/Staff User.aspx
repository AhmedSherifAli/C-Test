<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Staff User.aspx.cs" Inherits="Aswan_Uni_Meetings.Staff_User" %>
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
                        <span class="title"> إجتمعات </span>
                    </a>
                </li>
                <li class="hovered">
                    <a href="Staff User">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title">الرئيسية </span>
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
            <%--<div class="buttons-field">
                <asp:Button ID="btnlogout" CssClass="btn" runat="server" Text="تسجيل الخروج" />
                <ion-icon name="log-out-outline"></ion-icon>
            </div>--%>
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
                <%--<div class="toggle">
                    <ion-icon name="menu"></ion-icon>
                </div>--%>
                <asp:Label ID="lblname" CssClass="name" runat="server" Text="Label"></asp:Label>
                <asp:DropDownList ID="DropList" CssClass="list" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropList_SelectedIndexChanged"></asp:DropDownList>
            </div>
            
            <div class="grid-con">
                 <asp:GridView ID="GdDoc" CssClass="grid" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="GdDoc_SelectedIndexChanged">
                <Columns>

                    <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="">

                        <ItemTemplate>
                            <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Eval("DetailId") %>' CommandName="select" ForeColor="Black" OnCommand="btnSelect_Command"> أختر الصف </asp:LinkButton>
                        </ItemTemplate>

                        <HeaderStyle CssClass="head"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="تاريخ الأجتماع">

                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("MeetingDate") %>' runat="server"></asp:Label>
                        </ItemTemplate>

                        <HeaderStyle CssClass="head"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="الملف">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("File_Name") %>' runat="server"></asp:Label>
                        </ItemTemplate>

                        <HeaderStyle CssClass="head"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkDownload" runat="server" CommandName="download" CommandArgument='<%# Eval("DetailId") %>' OnCommand="btnSelect_Command"> تحميل الملف </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
            <div class="error">
                <asp:Label ID="lblMes" runat="server" Text="Hello"></asp:Label>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:con %>" SelectCommand="SELECT [id], [File name] FROM [Docment]"></asp:SqlDataSource>
        </div>

    </div>
    <script src="app.js"></script>
</asp:Content>
