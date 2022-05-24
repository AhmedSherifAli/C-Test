<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master.Master" CodeBehind="Default.aspx.cs" Inherits="Login___Registration_Enhanced.Default" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" ID="Content1" runat="server">
    <section class="Dep">
            <div class="box">
                <div class="card front"> Network </div>
                <div class="card back"> 
                    <h2> Network Page </h2> 
                    <div>
                        <asp:LinkButton ID="LinkButton1" PostBackUrl="" runat="server"> Go </asp:LinkButton>
                    </div>
                    
                </div>
            </div>
            <div class="box">
                <div class="card front"> Mis </div>
                <div class="card back"> Mis Page </div>
            </div>
            <div class="box">
                <div class="card front"> E-Learning </div>
                <div class="card back"> E-Learning Page </div>
            </div>
            <div class="box">
                <div class="card front"> Portal </div>
                <div class="card back"> Portal Page </div>
            </div>
            <div class="box">
                <div class="card front"> Maintance </div>
                <div class="card back"> Maintance Page </div>
            </div>
        </section>
</asp:Content>
