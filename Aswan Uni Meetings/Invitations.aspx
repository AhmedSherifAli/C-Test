<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Invitations.aspx.cs" Inherits="Aswan_Uni_Meetings.Invitations" %>
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
                <li>
                    <a href="Normal User">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title"> تفاصيل الأجتماع </span>
                    </a>
                </li>
                <li class="">
                    <a href="Normal User-Member">
                        <span class="icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </span>
                        <span class="title"> أعضاء الأجتماع </span>
                    </a>
                </li>
                <li class="hovered">
                    <a href="Invitations">
                        <span class="icon">
                            <ion-icon name="mail-unread-outline"></ion-icon>
                        </span>
                        <span class="title"> الدعوات </span>
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

                <asp:DropDownList ID="DropList" CssClass="list" runat="server" OnSelectedIndexChanged="DropList_SelectedIndexChanged"></asp:DropDownList>
            </div>

            <div class="card-inv">

                <label for="ContentPlaceHolder1_upload" class="file-upload" id="upload-btn">
                    <ion-icon name="cloud-upload-outline"></ion-icon>
                    <span id="text"> أختر ملف الدعوة </span>
                    <asp:FileUpload ID="upload" runat="server" />
                </label>

                <div class="buttons-field">
                    <asp:Button ID="btnAddInv" CssClass="btn" runat="server" Text="إرسل الدعوة" CausesValidation="False" OnClick="btnAddInv_Click" />
                    <ion-icon name="enter-outline"></ion-icon>
                </div>
            </div>

            <div class="error">
                <asp:Label ID="lblMesInv" runat="server" Text="Hello"></asp:Label>
            </div>

        </div>
        <script src="app.js"></script>

    </div>

</asp:Content>
