<%@ Page Language="C#" EnableEventValidation="false"  AutoEventWireup="true" MasterPageFile="~/Master.Master" CodeBehind="Users.aspx.cs" Inherits="Login___Registration_Enhanced.Users" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" ID="Content1" runat="server">
    <div class="grid-con">
            <asp:GridView ID="GdUsers" runat="server" CssClass="grid" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" ShowHeaderWhenEmpty="True" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GdUsers_SelectedIndexChanged">

                <Columns>
                    <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Select User">

                        <ItemTemplate>
                            <asp:LinkButton ID="btnSelect" runat="server" CommandArgument='<%# Eval("Email") %>' CommandName="select" OnCommand="Commandbutton_Click" ForeColor="black">Select</asp:LinkButton>
                        </ItemTemplate>

                        <HeaderStyle CssClass="head"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="ID">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("UserID") %>' runat="server"></asp:Label>
                        </ItemTemplate>

                        <HeaderStyle CssClass="head"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="UserName">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("UserName") %>' runat="server"></asp:Label>
                        </ItemTemplate>

                        <HeaderStyle CssClass="head"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="UserDep">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("UserDep") %>' runat="server"></asp:Label>
                        </ItemTemplate>

                        <HeaderStyle CssClass="head"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Role">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("UserRole") %>' runat="server"></asp:Label>
                        </ItemTemplate>

                        <HeaderStyle CssClass="head"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("AccountStatus") %>' runat="server"></asp:Label>
                        </ItemTemplate>

                        <HeaderStyle CssClass="head"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Change User Status">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnActive" runat="server" CssClass="btn-users" ToolTip="Activate" ImageUrl="~/img/active.JPG" CommandName="Active" OnCommand="Commandbutton_Click" CommandArgument='<%# Eval("Email") %>' />
                            <asp:ImageButton ID="btnSuspend" runat="server" CssClass="btn-users" ToolTip="Suspend" ImageUrl="~/img/suspend.JPG" CommandName="Suspend" OnCommand="Commandbutton_Click" CommandArgument='<%# Eval("Email") %>' />
                            <asp:ImageButton ID="btnDelete" runat="server" CssClass="btn-users" ToolTip="Delete" ImageUrl="~/img/Delete.JPG" CommandName="Delete" OnCommand="Commandbutton_Click" CommandArgument='<%# Eval("Email") %>' />
                        </ItemTemplate>

                        <HeaderStyle CssClass="head"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="head" HeaderText="Change User Role">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnAdmin" runat="server" CssClass="btn-users" ToolTip="Admin" ImageUrl="~/img/admin.JPG" CommandName="Admin" OnCommand="Commandbutton_Click" CommandArgument='<%# Eval("Email") %>' />
                            <asp:ImageButton ID="btnUser" runat="server" CssClass="btn-users" ToolTip="Normal User" ImageUrl="~/img/user.JPG" CommandName="User" OnCommand="Commandbutton_Click" CommandArgument='<%# Eval("Email") %>' />
                        </ItemTemplate>

                        <HeaderStyle CssClass="head"></HeaderStyle>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>


            <asp:Label ID="lblmes" CssClass="Mes" runat="server" ForeColor="Red"></asp:Label>
            
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:con %>" SelectCommand="SELECT [UserId], [UserName], [Email], [UserDep], [UserRole], [AccountStatus] FROM [UsersProfile]"></asp:SqlDataSource>
        </div>
</asp:Content>




