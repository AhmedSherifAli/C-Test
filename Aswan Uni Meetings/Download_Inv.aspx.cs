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
    public partial class Download_Inv : System.Web.UI.Page
    {
        byte[] bytes_DB;
        string fileExt, filename;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["MeetingName"] != null)
            {
                Get_Invitation_Doc(Session["MeetingName"].ToString(), Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));

                Response.Buffer = true;
                Response.Charset = "";
                Response.Clear();
                Response.Cache.SetCacheability(HttpCacheability.NoCache);

                if (fileExt == ".docx")
                {
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                    //Response.ContentType = "application/vnd.msword";
                    //Response.ContentType = "application/app.ms-word";
                    //Response.ContentType = "application/octet-stream";
                }
                else if (fileExt == ".doc")
                {
                    Response.ContentType = "application/msword";
                }
                else if (fileExt == ".pdf")
                {
                    Response.ContentType = "application/pdf";
                }

                // Download Line
                Response.AddHeader("content-disposition", "attachment; filename=" + filename);

                Response.BinaryWrite(bytes_DB);
                Response.Flush();
                Response.End();
            }
            else
            {
                Response.Redirect("Default");
            }
            
        }
        private DataTable Get_Invitation_Doc(string MeetingName, int DepartmentID, int FacultyID)
        {
            ConnectDB connect = new ConnectDB();
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@MeetingName", System.Data.SqlDbType.NVarChar, 250);
            param[0].Value = MeetingName;
            param[1] = new SqlParameter("@DepartmentID", System.Data.SqlDbType.Int);
            param[1].Value = DepartmentID;
            param[2] = new SqlParameter("@FacultyID", System.Data.SqlDbType.Int);
            param[2].Value = FacultyID;
            DataTable dt = new DataTable();
            dt = connect.SelectDataOne("Get_Invitation_Doc", param);
            if (dt.Rows.Count > 0)
            {
                filename = dt.Rows[0]["File_Name"].ToString();
                fileExt = dt.Rows[0]["File_Ext"].ToString();
                ViewState["InvitationId"] = dt.Rows[0]["InvitationId"];
                bytes_DB = (byte[])dt.Rows[0]["Data"];
            }
            return dt;
        }
    }
}