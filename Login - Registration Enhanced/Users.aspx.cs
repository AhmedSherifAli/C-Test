using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Login___Registration_Enhanced
{
    public partial class Users : System.Web.UI.Page
    {
        string Email , Email_after , User_Status, User_Role , User_Status_DB;
        protected void Page_Load(object sender, EventArgs e)
        {
            GdUsers.DataBind();
            GdUsers.Visible = false;

            if (Session["Admin"] != null)
            {
                GdUsers.DataBind();
                GdUsers.Visible = true;
            }
        }

        protected void Commandbutton_Click(object sender, CommandEventArgs e)
        {
            lblmes.Text = "";
            if (e.CommandName == "select")
            {
                Email = Convert.ToString((sender as LinkButton).CommandArgument);
                ViewState["UserEmail"] = Email;
            }
            else if (ViewState["UserEmail"] != null)
            {
                if (e.CommandName != "select")
                {
                    Email_after = Convert.ToString((sender as ImageButton).CommandArgument);
                    CheckUserExistsbeforReg();
                    ViewState["UserStatus"] = User_Status_DB;
                    User_Status = "";
                    if (ViewState["UserEmail"].ToString() == Email_after)
                    {
                        switch (e.CommandName)
                        {
                            case "Active":
                                User_Status = "Active";
                                change_User_Status(Email_after, User_Status);
                                lblmes.Text = "Successfully Active";
                                ViewState["UserStatus"] = User_Status;
                                break;
                            case "Suspend":
                                User_Status = "Suspend";
                                change_User_Status(Email_after, User_Status);
                                lblmes.Text = "Successfully Suspend";
                                ViewState["UserStatus"] = User_Status;
                                break;
                            case "Delete":
                                User_Status = "Deleted";
                                change_User_Status(Email_after, User_Status);
                                lblmes.Text = "Successfully Deleted";
                                ViewState["UserStatus"] = User_Status;
                                break;
                        }


                        if (User_Status_DB == "Active" || User_Status == "Active")
                        {
                            switch (e.CommandName)
                            {
                                case "Admin":
                                    User_Role = "Admin";
                                    change_User_Role(Email_after, User_Role);
                                    lblmes.Text = "Successfully became Admin";
                                    break;
                                case "User":
                                    User_Role = "User";
                                    change_User_Role(Email_after, User_Role);
                                    lblmes.Text = "Successfully became User";
                                    break;
                            }
                        }
                        else if (User_Status_DB.ToString() == User_Status.ToString())
                        {
                            lblmes.Text = "User Already " + User_Status;
                        }
                        else
                        {
                            if (e.CommandName == "Admin" && User_Status_DB == "Deleted")
                            {
                                lblmes.Text = "Deleted Users Can't be Admin !";
                            }
                            else if (e.CommandName == "Admin" && User_Status_DB == "Suspend")
                            {
                                lblmes.Text = "Suspend Users Can't be Admin !";
                            }
                        }
                    }
                    else
                    {
                        lblmes.Text = "You Select Wrong User";
                    }
                    GdUsers.DataBind();
                }
            }
            else if(Email==null)
            {
                lblmes.Text = "You must click Select Button First !";
            }
        }

        protected void GdUsers_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Email != null)
            {
                // Add Color to Selected Row

                GdUsers.SelectedRowStyle.BackColor = System.Drawing.Color.SlateGray;
                GdUsers.RowStyle.ForeColor = System.Drawing.Color.Black;
                lblmes.Text = "";

                // Load User Status from Grid View

                ViewState["UserStatus"] = GdUsers.SelectedRow.Cells[7].ToString();
            }
        }

        ConnectDB connectDB = new ConnectDB();

        private void change_User_Status (string Email , string AccountStatus)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
            param[0].Value = Email_after;
            param[1] = new SqlParameter("@AccountStatus", System.Data.SqlDbType.NVarChar, 30);
            param[1].Value = AccountStatus;
            connectDB.ExecuteData("Change_User_Status_ByAdmin", param);
        }

        private void change_User_Role (string Email, string UserRole)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
            param[0].Value = Email_after;
            param[1] = new SqlParameter("@UserRole", System.Data.SqlDbType.NVarChar, 30);
            param[1].Value = UserRole;
            connectDB.ExecuteData("Change_User_Role_ByAdmin", param);
        }

        bool CheckUserExistsbeforReg()
        {
            try
            {
                
                ConnectDB connect = new ConnectDB();
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
                param[0].Value = Email_after;
                DataSet ds = new DataSet();
                ds = connect.SelectData("CheckUserExistsbeforReg", param);
                if (ds.Tables[0].Rows.Count >= 1)
                {
                    
                    User_Status_DB = ds.Tables[0].Rows[0][7].ToString();
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
                return false;
            }
        }
    }
}