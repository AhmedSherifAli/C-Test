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

namespace Login___Registration_Enhanced
{
    public partial class Forget_Password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
           
            if (CheckUserExistsbeforReg())
            {
                // Insert Record in Reset Table

                string myGUID = Guid.NewGuid().ToString();
                string Uid = ds.Tables[0].Rows[0][0].ToString();
                Reset_Insert(myGUID, Uid);

                // Send Email to User For Reset Password

                string ToEmailAddress = ds.Tables[0].Rows[0][2].ToString();
                string UserName = ds.Tables[0].Rows[0][1].ToString();
                string EmailBody = "Hi" + UserName + ",<br/><br/> Click the link below to reset Your Password <br/><br/> " +
                   "http://localhost:62145/Reset%20Password.aspx?Uid=" + myGUID;
                MailMessage PassRecMail = new MailMessage("ahmedsherif91101@gmail.com", ToEmailAddress);
                PassRecMail.Body = EmailBody;
                PassRecMail.IsBodyHtml = true;
                PassRecMail.Subject = "استرجاع كلمة المرور";
                PassRecMail.Priority = MailPriority.Normal;
                SmtpClient STMP = new SmtpClient("smtp.gmail.com", 587);
                STMP.DeliveryMethod = SmtpDeliveryMethod.Network;
                STMP.Credentials = new NetworkCredential()
                {
                    UserName = "ahmedsherif91101@gmail.com",
                    Password = "(fa1+me2-ba3+ah4)"

                };
                STMP.EnableSsl = true;
                STMP.Send(PassRecMail);
                LabelMes.Text = "Check your Email !";
            }

        }

        ConnectDB connect = new ConnectDB();
        DataSet ds = new DataSet();

        bool CheckUserExistsbeforReg()
        {
            try
            {
                string Email = txtEmail.Text.Trim();
                
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
                param[0].Value = Email;
                
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
        private void Reset_Insert(string @myGUID, string @Uid)
        {
            SqlParameter[] paramreset = new SqlParameter[2];
            paramreset[0] = new SqlParameter("@myGUID", System.Data.SqlDbType.VarChar, 50);
            paramreset[0].Value = myGUID;
            paramreset[1] = new SqlParameter("@Uid", System.Data.SqlDbType.VarChar, 11);
            paramreset[1].Value = Uid;
            connect.ExecuteData("Reset_Insert", paramreset);
        }
    }
}