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
    public partial class Sign_Up : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Droplist.DataSource = GetDep();
                Droplist.DataTextField = "DepName";
                Droplist.DataValueField = "DepId";
                Droplist.DataBind();
                ListItem liContinent = new ListItem("Select Department", "-1");
                Droplist.Items.Insert(0, liContinent);
                
            }
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            if (CheckUserExistsbeforReg())
            {
                LabelMes.Text = "You have Account in Our Website Please Enter Different Email !";
                lblHint.Text = "You have Account in Our Website Please Enter Sign Up Button Again !";
                txtUserName.Focus();
            }
            else
            {
                InsertUser(txtUserName.Text.Trim(), txtEmail.Text.Trim(), txtPass.Text.Trim(), txtID.Text, Droplist.SelectedItem.Text, "User", "Active");
                Response.Redirect("Default.aspx");
            }
        }

        private DataSet GetDep()
        {
            ConnectDB connect = new ConnectDB();
            DataSet ds = new DataSet();
            ds = connect.SelectData("GetDep", null);
            return ds;
        }

        private void InsertUser (string Name, string Email, string Pass , string National_ID, string Dep , string Role , string Status)
        {
            try
            {
                ConnectDB connect_DB = new ConnectDB();
                SqlParameter[] param = new SqlParameter[7];
                param[0] = new SqlParameter("@UserName", System.Data.SqlDbType.NVarChar, 30);
                param[0].Value = Name;
                param[1] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
                param[1].Value = Email;
                param[2] = new SqlParameter("@UserPass", System.Data.SqlDbType.NVarChar, 30);
                param[2].Value = Pass;
                param[3] = new SqlParameter("@National_ID", System.Data.SqlDbType.VarChar, 50);
                param[3].Value = National_ID;
                param[4] = new SqlParameter("@UserDep", System.Data.SqlDbType.NVarChar, 50);
                param[4].Value = Dep;
                param[5] = new SqlParameter("@UserRole", System.Data.SqlDbType.NVarChar, 30);
                param[5].Value = Role;
                param[6] = new SqlParameter("@AccountStatus", System.Data.SqlDbType.NVarChar, 30);
                param[6].Value = Status;
                connect_DB.ExecuteData("Insert_User", param);
            }
            catch
            {

            }
            //ConnectDB connect_DB = new ConnectDB();
            //SqlParameter[] param = new SqlParameter[7];
            //param[0] = new SqlParameter("@UserName", System.Data.SqlDbType.NVarChar, 30);
            //param[0].Value = Name;
            //param[1] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
            //param[1].Value = Email;
            //param[2] = new SqlParameter("@UserPass", System.Data.SqlDbType.NVarChar, 30);
            //param[2].Value = Pass;
            //param[3] = new SqlParameter("@National_ID", System.Data.SqlDbType.VarChar, 50);
            //param[3].Value = National_ID;
            //param[4] = new SqlParameter("@UserDep", System.Data.SqlDbType.NVarChar, 50);
            //param[4].Value = Dep;
            //param[5] = new SqlParameter("@UserRole", System.Data.SqlDbType.NVarChar, 30);
            //param[5].Value = Role;
            //param[6] = new SqlParameter("@AccountStatus", System.Data.SqlDbType.NVarChar, 30);
            //param[6].Value = Status;
            //connect_DB.ExecuteData("Insert_User", param);
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