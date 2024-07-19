using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aswan_Uni_Meetings
{
    public partial class Forget_Password_EN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMes.Text = "";
            ChBLang.Checked = true;
        }

        protected void ChBLang_CheckedChanged(object sender, EventArgs e)
        {
            Response.Redirect("Forget Password");
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login-EN");
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (CheckUserExists())
            {
                // Send Email to User For Reset Password

                string ToEmailAddress = txtEmail.Text.Trim();
                string UserName = ViewState["User Name-EN"].ToString();
                string EmailBody = "Welcome \\ " + UserName + "<br/><br/> Please Use link below to return to Login Page <br/><br/> "
                     + "<br/><br/>" + "http://193.227.33.72/Login-EN.aspx" + "<br/><br/>" + "Your Password is :" + ViewState["Pass"].ToString();

                MailMessage PassRecMail = new MailMessage("Meetingapp@aswu.edu.eg", ToEmailAddress);
                //MailMessage PassRecMail = new MailMessage("meetingappuni@gmail.com", ToEmailAddress);
                PassRecMail.Body = EmailBody;
                PassRecMail.IsBodyHtml = true;
                PassRecMail.Subject = "إسترجاع كلمة المرور";
                PassRecMail.Priority = MailPriority.Normal;

                SmtpClient STMP = new SmtpClient("smtp.office365.com", 587);
                //SmtpClient STMP = new SmtpClient("smtp.gmail.com", 587);
                STMP.DeliveryMethod = SmtpDeliveryMethod.Network;
                //STMP.UseDefaultCredentials = false;
                STMP.EnableSsl = true;
                STMP.Credentials = new NetworkCredential("Meetingapp@aswu.edu.eg", "(as1+me2)");
                //STMP.Credentials = new NetworkCredential("meetingappuni@gmail.com", "(meeting+app)");
                try
                {
                    STMP.Send(PassRecMail);
                    lblMes.ForeColor = System.Drawing.Color.Green;
                    lblMes.Text = "Check your Email";
                }
                catch
                {
                    lblMes.ForeColor = System.Drawing.Color.Red;
                    lblMes.Text = "Message Don't Send !";
                }
            }
            else
            {
                lblMes.ForeColor = System.Drawing.Color.Red;
                lblMes.Text = "You Don't have Account in Our System";
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
                    ViewState["User Name-EN"] = dt.Rows[0][2].ToString();
                    ViewState["Pass"] = dt.Rows[0][5].ToString();

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