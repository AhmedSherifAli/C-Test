<%@ Page Title="" Language="C#" MasterPageFile="~/Master-EN.Master" AutoEventWireup="true" CodeBehind="Staff User-EN.aspx.cs" Inherits="Aswan_Uni_Meetings.Staff_User_EN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%-- Script to Prevent Back Button in Browser --%>

    <script type="text/javascript">
        function preback() { (window.history.forward()); }
        setTimeout("preback()", 0);
        window.onunload = function () { (null); }
    </script>

    <script type="text/javascript">
        function Navigate() {
            javascript: window.open("http://localhost:53620/Staff%20User-EN.aspx", "_self");
        }

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
                        <span class="title">Meetings </span>
                    </a>
                </li>
                <li class="hovered">
                    <a href="Staff User-EN">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title">Home </span>
                    </a>
                </li>
                <li>
                    <a>
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
                <asp:CheckBox ID="ChBLang" runat="server" AutoPostBack="true" Checked="true" OnCheckedChanged="ChBLang_CheckedChanged" />
                <p>EN </p>
                <span>
                    <i></i>
                </span>
                <p>AR </p>
            </label>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


            <div class="topbar">
                <div class="detail">
                    <asp:Label ID="lblname" CssClass="name" runat="server" Text="Label"></asp:Label>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:Timer ID="Timer1" runat="server" Interval="2000"></asp:Timer>
                            <div class="notification">
                                <asp:Label ID="lblNotif" CssClass="notfi" runat="server" Text="1" Visible="false"></asp:Label>
                                <asp:ImageButton ID="btnNotif" runat="server" ImageUrl="~/img/bell.jpg" Visible="false" OnClick="btnNotif_Click" OnClientClick="Navigate()" />
                                <asp:Label ID="lbltip" class="tool-tip-name" runat="server" data-tooltip="New Meeting Invitation" Visible="false"></asp:Label>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>

                <asp:DropDownList ID="DropList" CssClass="list" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropList_SelectedIndexChanged"></asp:DropDownList>
            </div>

            <div class="grid-con">
                <asp:GridView ID="GdDoc" CssClass="grid" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="GdDoc_SelectedIndexChanged">
                    <Columns>

                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="">

                            <ItemTemplate>
                                <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Eval("DetailId") %>' CommandName="select" ForeColor="Black" OnCommand="btnSelect_Command"> Select Row </asp:LinkButton>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Meeting Date">

                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("MeetingDate") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Meeting File">
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("File_Name") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkDownload" runat="server" CommandName="download" CommandArgument='<%# Eval("DetailId") %>' OnCommand="btnSelect_Command">Download Meeting File</asp:LinkButton>
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
