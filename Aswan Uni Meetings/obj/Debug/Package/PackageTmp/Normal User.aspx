<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Normal User.aspx.cs" Inherits="Aswan_Uni_Meetings.Normal_User" %>

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
                    <a href="Normal User">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title"> تفاصيل الأجتماع </span>
                    </a>
                </li>
                <li>
                    <a href="Normal User-Member">
                        <span class="icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </span>
                        <span class="title"> أعضاء الأجتماع </span>
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
                            <asp:TextBox ID="txtDate" placeholder="أدخـل التاريخ" runat="server"></asp:TextBox>
                            <asp:ImageButton ID="Imagmeeting" runat="server" ImageUrl="~/img/date.png" OnClick="Imagmeeting_Click" CausesValidation="False" />
                        </div>

                        <asp:Calendar ID="Calmeeting" runat="server" OnSelectionChanged="Calmeeting_SelectionChanged" BackColor="White" BorderColor="Black" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="220px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="400px" OnDayRender="Calmeeting_DayRender">
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="10pt" ForeColor="#333333" Height="10pt" />
                            <DayStyle Width="14%" Font-Bold="True" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                            <OtherMonthDayStyle ForeColor="#999999" BackColor="Black" />
                            <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                            <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                            <TodayDayStyle BackColor="#CCCC99" />
                        </asp:Calendar>
                    </div>

                    <label for="ContentPlaceHolder1_upload" class="file-upload" id="upload-btn">
                        <ion-icon name="cloud-upload-outline"></ion-icon>
                        <span id="text"> أختر الملف </span>
                        <asp:FileUpload ID="upload" runat="server" />
                    </label>

                </div>
                <div class="buttons">
                    <div class="buttons-field">
                        <asp:Button ID="btnInsert" CssClass="btn" runat="server" Text="إضافة إجتماع" OnClick="btnInsert_Click" />
                        <ion-icon name="enter-outline"></ion-icon>
                    </div>
                    <div class="buttons-field">

                        <%--<asp:Button ID="btnReg" CssClass="btn" runat="server" Text="إنشاء حساب" />--%>
                        <asp:Button ID="btnEdit" CssClass="btn" runat="server" Text="تـعديل إجتماع" OnClick="btnEdit_Click" />
                        <ion-icon name="arrow-redo-circle-outline"></ion-icon>
                    </div>

                    <!-- Cards -->


                    <!-- Order Details List -->


                </div>
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
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="محضر الأجتماع">
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("File_Name") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <%--<asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkDownload" runat="server" CommandName="download" CommandArgument='<%# Eval("DetailId") %>'> تحميل الملف </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
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
