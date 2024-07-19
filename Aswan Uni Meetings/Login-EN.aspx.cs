using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aswan_Uni_Meetings
{
    public partial class Login_EN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMes.Text = "";
            ChBLang.Checked = true;

            // Get Personal Login Data from Cookies 

            HttpCookie cookie = Request.Cookies["User Info"];
            if (cookie != null)
            {
                txtEmail.Text = cookie["Email"].ToString();
                txtPass.Attributes["value"] = cookie["National ID"].ToString();

                // Empty and Reset before login 

                HttpCookie cookieupdate = new HttpCookie("User Info");
                cookieupdate.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookieupdate);
            }
        }

        protected void ChBLang_CheckedChanged(object sender, EventArgs e)
        {
            Response.Redirect("Login");
        }

        protected void btnhome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default-EN");
        }

        protected void btnLog_Click(object sender, EventArgs e)
        {

            if (CheckUserExists())
            {
                if (txtPass.Text.Trim() == ViewState["Pass"].ToString())
                {
                    //lblMes.Text = "Welcome : " + UserNameAR;

                    Session["Email"] = txtEmail.Text.Trim();

                    // Check if Remeber Me Checked

                    if (ChbRemeber.Checked)
                    {
                        HttpCookie cookie = new HttpCookie("User Info");
                        cookie["Email"] = txtEmail.Text;
                        cookie["National ID"] = txtPass.Text;
                        cookie.Expires = DateTime.Now.AddMonths(3);
                        //cookie.Expires = DateTime.Now.AddDays(2147483647);
                        Response.Cookies.Add(cookie);
                    }
                    if (ViewState["Role"].ToString() == "Staff")
                    {
                        if (CheckStaffExists())
                        {
                            Response.Redirect("Staff User-EN");
                        }
                    }
                    else if (ViewState["Role"].ToString() == "Not Staff")
                    {
                        Response.Redirect("Normal User-EN");
                    }
                }
                else
                {
                    lblMes.Text = "Please Enter Right National ID";
                }
            }
            else
            {
                lblMes.Text = "You Don't have Account in Our System";
            }

        }

        bool CheckStaffExists()
        {
            try
            {
                string Email = txtEmail.Text.Trim();
                ConnectDB connect = new ConnectDB();
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
                param[0].Value = Email;
                DataTable dt = new DataTable();
                dt = connect.SelectDataOne("CheckStaffExists", param);
                if (dt.Rows.Count >= 1)
                {
                    Session["Staff Name-AR"] = dt.Rows[0][3].ToString();
                    Session["Staff Name-EN"] = dt.Rows[0][4].ToString();
                    Session["Staff Faculty"] = dt.Rows[0]["FacultyID"].ToString();
                    Session["Staff Dep"] = dt.Rows[0]["DepartmrntID"].ToString();

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

        bool CheckUserExists()
        {
            try
            {
                string Email = txtEmail.Text.Trim();
                ConnectDB connect = new ConnectDB();
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
                param[0].Value = Email;
                DataTable dt = new DataTable();
                dt = connect.SelectDataOne("CheckUserMeeting", param);
                if (dt.Rows.Count >= 1)
                {
                    Session["User Name-AR"] = dt.Rows[0][1].ToString();
                    Session["User Name-EN"] = dt.Rows[0][2].ToString();
                    ViewState["Pass"] = dt.Rows[0][5].ToString();
                    Session["User Faculty"] = dt.Rows[0][6].ToString();
                    Session["User Dep"] = dt.Rows[0][7].ToString();
                    ViewState["Role"] = dt.Rows[0]["Is_staff"].ToString();

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