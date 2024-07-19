<%@ Page Title="" Language="C#" MasterPageFile="~/Master-EN.Master" AutoEventWireup="true" CodeBehind="Normal User-Member-EN.aspx.cs" Inherits="Aswan_Uni_Meetings.Normal_User_Member_EN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                <li>
                    <a href="Normal User-EN">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title">Meeting Details </span>
                    </a>
                </li>
                <li class="hovered">
                    <a href="Normal User-Member-EN">
                        <span class="icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </span>
                        <span class="title">Meeting Members </span>
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

                <asp:DropDownList ID="DropList" CssClass="list" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropList_SelectedIndexChanged"></asp:DropDownList>
            </div>

            <div class="card-inv">

                <label for="ContentPlaceHolder1_upload" class="file-upload" id="upload-btn">
                    <span id="text">Choose File </span>
                    <ion-icon name="cloud-upload-outline"></ion-icon>
                    <asp:FileUpload ID="upload" runat="server" />
                </label>

                <div class="buttons-field">
                    <asp:Button ID="btnAddInv" CssClass="btn" runat="server" Text="Add File" CausesValidation="False" OnClick="btnAddInv_Click" />
                    <ion-icon name="enter-outline"></ion-icon>
                </div>
            </div>

            <div class="error">
                <asp:Label ID="lblMesInv" runat="server" Text="Hello"></asp:Label>
            </div>

            <div class="card">
                <div class="name">
                    <div class="input-field-en">
                        <ion-icon name="person"></ion-icon>
                        <asp:TextBox ID="txtSearch" CssClass="input" placeholder="Enter National ID" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="req-val" runat="server" ControlToValidate="txtSearch" ErrorMessage="Enter Name" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="type">
                     <asp:DropDownList ID="DropType" CssClass="list" runat="server"></asp:DropDownList>
                </div>
                <div class="buttons">
                    <div class="buttons-field">
                        <asp:Button ID="btnSearch" CssClass="btn" runat="server" Text="Search" OnClick="btnSearch_Click" />
                        <ion-icon name="search-circle-outline"></ion-icon>
                    </div>
                    <div class="buttons-field">
                        <asp:Button ID="btnAdd" CssClass="btn" runat="server" Text="Add Member" CausesValidation="False" OnClick="btnAdd_Click" />
                        <ion-icon name="add-circle-outline"></ion-icon>
                    </div>
                    <div class="buttons-field">
                        <asp:Button ID="btnDelete" CssClass="btn" runat="server" Text="Delete Member" CausesValidation="False" OnClick="btnDelete_Click" />
                        <ion-icon name="close-circle-outline"></ion-icon>
                    </div>
                </div>

                <div class="grid-con">
                    <asp:GridView ID="GdStaff" CssClass="grid" runat="server" AutoGenerateColumns="False">
                        <Columns>

                            <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="">

                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Eval("StaffID") %>' CommandName="select" ForeColor="Black" OnCommand="btnSelect_Command"> Select Row </asp:LinkButton>
                                </ItemTemplate>

                                <HeaderStyle CssClass="head"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Name">

                                <ItemTemplate>
                                    <asp:Label Text='<%# Eval("StaffEnName") %>' runat="server"></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle CssClass="head"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Email">
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
                                <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Eval("StaffID") %>' CommandName="select" ForeColor="Black" OnCommand="btnSelect_Command"> Select Row </asp:LinkButton>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Name">

                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("StaffEnName") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Email">
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("UniversityEmail") %>' runat="server"></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle CssClass="head"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Member Role">
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("MeetingRole_EN") %>' runat="server"></asp:Label>
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
