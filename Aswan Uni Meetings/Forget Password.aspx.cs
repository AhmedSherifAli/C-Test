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
    public partial class Forget_Password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMes.Text = "";
            ChBLang.Checked = false;
        }

        protected void ChBLang_CheckedChanged(object sender, EventArgs e)
        {
            Response.Redirect("Forget Password-EN");
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (CheckUserExists())
            {
                // Send Email to User For Reset Password

                string ToEmailAddress = txtEmail.Text.Trim();
                string UserName = ViewState["User Name-AR"].ToString();
                string EmailBody = "مرحبا / " + UserName + "<br/><br/> يرجى استخدام اللينك للوصول لصفحة تسجيل الدخول  <br/><br/> "
                 + "<br/><br/>" + "http://193.227.33.72/Login.aspx" +"<br/><br/>" + "وهذا الباسورد الخاص بيكم / " + ViewState["Pass"].ToString();

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
                    lblMes.Text = "تحقق من الإيميل الخاص بك";
                }
                catch
                {
                    lblMes.ForeColor = System.Drawing.Color.Red;
                    lblMes.Text = "لم يتم أرسال الإيميل";
                } 
            }
            else
            {
                lblMes.Text = "للأسف هذا الإيميل غير مسجل فى النظام";
            }
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login");
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

                    ViewState["User Name-AR"] = dt.Rows[0][1].ToString();
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