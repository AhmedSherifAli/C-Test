<%@ Page Title="" Language="C#" MasterPageFile="~/Master-EN.Master" AutoEventWireup="true" CodeBehind="Normal User-EN.aspx.cs" Inherits="Aswan_Uni_Meetings.Normal_User_EN" Culture="en-US"%>

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
                <li class="hovered">
                    <a href="Normal User-EN">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title"> Meetings Details </span>
                    </a>
                </li>
                <li>
                    <a href="Normal User-Member-EN">
                        <span class="icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </span>
                        <span class="title"> Meeting Members </span>
                    </a>
                </li>
                <li>
                    <a href="Invitations-EN">
                        <span class="icon">
                            <ion-icon name="mail-unread-outline"></ion-icon>
                        </span>
                        <span class="title"> Invitations </span>
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
            <div class="topbar">
                <div class="detail">
                    <asp:Label ID="lblname" CssClass="name" runat="server" Text="Label"></asp:Label>
                    <%--<div class="notification">
                        <asp:Label ID="lblNotif" runat="server" Text="1"></asp:Label>
                        <asp:ImageButton ID="btnNotif" runat="server" ImageUrl="~/img/bell.jpg" ToolTip="دعوة إجتماع جديد" />
                    </div>--%>
                </div>

                <asp:DropDownList ID="DropList" CssClass="list" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropList_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <div class="card">
                <div class="meeting-input">

                    <div class="date">
                        <div class="input-date">
                            <asp:TextBox ID="txtDate" placeholder="Add Date" runat="server"></asp:TextBox>
                            <asp:ImageButton ID="Imagmeeting" runat="server" ImageUrl="~/img/date.png" OnClick="Imagmeeting_Click" CausesValidation="False" />
                        </div>

                        <asp:Calendar ID="Calmeeting" runat="server" OnSelectionChanged="Calmeeting_SelectionChanged" BackColor="White" BorderColor="Black" DayNameFormat="Full" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="220px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="400px" FirstDayOfWeek="Saturday" OnDayRender="Calmeeting_DayRender">
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="10pt" ForeColor="#333333" Height="10pt" />
                            <DayStyle Width="14%" Font-Bold="True"/>
                            <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                            <OtherMonthDayStyle ForeColor="#999999" BackColor="Black" />
                            <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                            <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                            <TodayDayStyle BackColor="#CCCC99"/>
                        </asp:Calendar>
                    </div>

                    <label for="ContentPlaceHolder1_upload" class="file-upload" id="upload-btn">
                        <ion-icon name="cloud-upload-outline"></ion-icon>
                        <span id="text"> Choose File </span>
                        <asp:FileUpload ID="upload" runat="server" />
                    </label>

                </div>
                <div class="buttons">
                    <div class="buttons-field">
                        <asp:Button ID="btnInsert" CssClass="btn" runat="server" Text="Add Meeting" OnClick="btnInsert_Click" />
                        <ion-icon name="enter-outline"></ion-icon>
                    </div>
                    <div class="buttons-field">

                        <%--<asp:Button ID="btnReg" CssClass="btn" runat="server" Text="إنشاء حساب" />--%>
                        <asp:Button ID="btnEdit" CssClass="btn" runat="server" Text="Edit Meeting" OnClick="btnEdit_Click" />
                        <ion-icon name="arrow-redo-circle-outline"></ion-icon>
                    </div>

                </div>
            </div>
            <div class="grid-con">
                <asp:GridView ID="GdDoc" runat="server" CssClass="grid" AutoGenerateColumns="False" OnSelectedIndexChanged="GdDoc_SelectedIndexChanged">
                    <Columns>

                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="">

                            <ItemTemplate>
                                <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Eval("DetailId") %>' CommandName="select" ForeColor="black" OnCommand="btnSelect_Command"> Select Row </asp:LinkButton>
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
