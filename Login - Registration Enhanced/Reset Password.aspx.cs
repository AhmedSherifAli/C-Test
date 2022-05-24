using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Login___Registration_Enhanced
{
    public partial class Reset_Password : System.Web.UI.Page
    {
        string Uid, Guidvalue="";

        string ConnectionString = "con";
        

        ConnectDB connect = new ConnectDB();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            string strcon = ConfigurationManager.ConnectionStrings[ConnectionString].ConnectionString;
            using (SqlConnection con = new SqlConnection(strcon))
            {
                Guidvalue = Guid.Parse(Request.QueryString["Uid"]).ToString();
                //Guid guid = new Guid(Guidvalue); 
                if (Guidvalue != null)
                {
                    //string myGUID = Guid.Parse(Request.QueryString["Uid"]).ToString();
                    SqlCommand cmd = new SqlCommand("exec CheckReset_Record'" + Guidvalue + "'", con);
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(dt);
                    if (dt.Rows.Count != 0)
                    {
                        Uid = dt.Rows[0][1].ToString();
                    }
                    else
                    {
                        LabelMes.Text = "Your Password Reset Link is Expired or Invalid !";
                    }
                }
                else
                {
                    Response.Redirect("~/Forget Password.aspx");
                }
            }
           

            //SqlParameter[] param = new SqlParameter[1];
            //param[0] = new SqlParameter("@id", System.Data.SqlDbType.UniqueIdentifier);
            //param[0].Value = Guidvalue;
            
            //ds = connect.SelectDataOne("CheckReset_Record", param);
            
            if (!IsPostBack)
            {
                if (dt.Rows.Count != 0)
                {
                    txtPass.Visible = true;
                    txtPassRepeat.Visible = true;
                    btnReset.Visible = true;
                }
                else
                {
                    LabelMes.Text = "Your Password Reset Link is Expired or Invalid !";
                }
            }
        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Uid", System.Data.SqlDbType.VarChar,11);
            param[0].Value = Uid;
            param[1] = new SqlParameter("@UserPass", System.Data.SqlDbType.NVarChar, 30);
            param[1].Value = txtPass.Text.Trim();
            connect.ExecuteData("UpdateUserPass", param);
            txtPass.Text = "";
            txtPassRepeat.Text = "";
            Response.Redirect("Sign-In.aspx");
        }
    }
}