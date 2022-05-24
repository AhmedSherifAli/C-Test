using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Login___Registration_Enhanced
{
    public partial class Sign_In : System.Web.UI.Page
    {
        static int attempcount = 0;
        string UserName , Pass , Role , Status;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (CheckUserExistsbeforReg())
            {
                if (Status == "Active" && txtPass.Text.Trim() == Pass)
                {
                    if (Role == "User")
                    {
                        Session["username"] = UserName;
                        Response.Redirect("Default.aspx");
                    }
                    if (Role == "Admin")
                    {
                        Session["Admin"] = UserName;
                        Response.Redirect("Default.aspx");
                    }
                }
                else if (Status == "Suspend")
                {
                    LabelMes.Text = "Your Account is Suspend Please Contact with Administrator !";
                    lblHint.Text = "Your Account is Suspend Please Contact with Administrator !";
                }
                else if(Status == "Deleted")
                {
                    LabelMes.Text = "Your Account is Deleted Sorry for you !";
                    lblHint.Text = "Your Account is Deleted Sorry for you !";
                }
                else
                {
                    lblHint.Text = "An Error Happended Please Enter Sign In Button Again !";
                    LabelMes.Text = "Wrong Password - Relogin With Correct Password - No. of Attemps Remaining :" + (2 - attempcount);
                    attempcount = attempcount + 1;
                }
                if (attempcount == 3)
                {
                    lblHint.Text = "An Error Happended Please Enter Sign In Button Again !";
                    LabelMes.Text = "Your Account is Suspend Due to Three Invalid Attempts - Contact with Administrator !";
                    attempcount = 0;
                    Suspend_User(txtEmail.Text.Trim());
                }
            }
            else if(!CheckUserExistsbeforReg())
            {
                lblHint.Text = "An Error Happended Please Enter Sign In Button Again !";
                LabelMes.Text = "You Don't have Account in our Website !";
            }
        }
        
        bool CheckUserExistsbeforReg()
        {
            try
            {
                string Email = txtEmail.Text.Trim();
                ConnectDB connect = new ConnectDB();
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
                param[0].Value = Email;
                DataSet ds = new DataSet();
                ds = connect.SelectData("CheckUserExistsbeforReg", param);
                if (ds.Tables[0].Rows.Count >= 1)
                {
                    UserName = ds.Tables[0].Rows[0][1].ToString();
                    Pass = ds.Tables[0].Rows[0][3].ToString();
                    Role = ds.Tables[0].Rows[0][6].ToString();
                    Status = ds.Tables[0].Rows[0][7].ToString();
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

        private void Suspend_User(string Email)
        {
            ConnectDB connectDB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
            param[0].Value = Email;
            connectDB.ExecuteData("Suspend_User", param);
        }
    }
}