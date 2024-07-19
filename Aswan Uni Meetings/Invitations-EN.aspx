<%@ Page Title="" Language="C#" MasterPageFile="~/Master-EN.Master" AutoEventWireup="true" CodeBehind="Invitations-EN.aspx.cs" Inherits="Aswan_Uni_Meetings.Invitations_EN" %>
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

        <div class="navigation-en">
            <ul>
                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="logo-medium"></ion-icon>
                        </span>
                        <span class="title"> Meetings </span>
                    </a>
                </li>
                <li>
                    <a href="Normal User-EN">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title"> Meetings Details </span>
                    </a>
                </li>
                <li class="">
                    <a href="Normal User-Member-EN">
                        <span class="icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </span>
                        <span class="title"> Meeting Members </span>
                    </a>
                </li>
                <li class="hovered">
                    <a href="Invitations-EN">
                        <span class="icon">
                            <ion-icon name="mail-unread-outline"></ion-icon>
                        </span>
                        <span class="title"> Invitations </span>
                    </a>
                </li>
                <li>
                    <a href="Default-EN">
                        <span class="icon">
                            <ion-icon name="log-out-outline"></ion-icon>
                        </span>
                        <asp:Button ID="btnlogout" runat="server" Text="Logout" BorderStyle="None" CausesValidation="False" OnClick="btnlogout_Click" />
                        <span class="title"></span>
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main -->
        <div class="main-en">
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
                    <span id="text"> Choose Invitiation File </span>
                    <asp:FileUpload ID="upload" runat="server" />
                </label>

                <div class="buttons-field">
                    <asp:Button ID="btnAddInv" CssClass="btn" runat="server" Text="Send Invitiation" CausesValidation="False" OnClick="btnAddInv_Click" />
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
