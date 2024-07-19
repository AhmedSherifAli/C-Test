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
    public partial class Staff_User : System.Web.UI.Page
    {
        byte[] bytes_DB;
        string fileExt, filename;
        int tick;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMes.Text = "";
            ChBLang.Checked = false;
            Timer1.Enabled = false;

            if (!IsPostBack)
            {
                if (Session["Staff Name-AR"] != null)
                {
                    lblname.Text = "مرحبا / " + Session["Staff Name-AR"].ToString();

                    DropList.DataSource = Get_MeetingName(Session["Email"].ToString());
                    DropList.DataTextField = "MeetingName";
                    DropList.DataBind();

                    GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                    GdDoc.DataBind();

                    GdDoc.SelectedRowStyle.BackColor = System.Drawing.Color.White;

                }
                else
                {
                    Response.Redirect("Default");
                }
            }

            Get_User_RoleName(Session["Email"].ToString(), Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()), DropList.SelectedItem.Text);

            if (Convert.ToInt32(ViewState["Download"].ToString()) == 0)
            {
                lblNotif.Visible = true;
                lbltip.Visible = true;
                btnNotif.Visible = true;
            }
            else
            {
                if (Convert.ToInt32(Session["DocID"]) == 1)
                {
                    Get_Invitation_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));

                    Download();

                    tick = 0;

                    Session["DocID"] = tick;

                }
            }
        }

        private void Download()
        {
            Response.Buffer = true;
            Response.Charset = "";
            Response.Clear();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            if (fileExt == ".docx")
            {
                Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
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
            //Response.End();
        }

        protected void DropList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropList.SelectedItem.Text != null)
            {
                if (DropList.SelectedItem.Text == "مجلس الجامعة" || DropList.SelectedItem.Text == "مجلس الدراسات العليا" || DropList.SelectedItem.Text == "مجلس العلاقات الثقافية" || DropList.SelectedItem.Text == "مجلس شئون البيئة" || DropList.SelectedItem.Text == "مجلس شئون التعليم والطلاب")
                {
                    GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, 0, 0);
                    GdDoc.DataBind();
                }
                else if (DropList.SelectedItem.Text != "مجلس الجامعة" && DropList.SelectedItem.Text != "مجلس الدراسات العليا" && DropList.SelectedItem.Text != "مجلس العلاقات الثقافية" && DropList.SelectedItem.Text != "مجلس شئون البيئة" && DropList.SelectedItem.Text != "مجلس شئون التعليم والطلاب" && DropList.SelectedItem.Text != "مجلس قسم")
                {
                    GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, 0, Convert.ToInt32(Session["User Faculty"].ToString()));
                    GdDoc.DataBind();
                }
                else
                {
                    GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                    GdDoc.DataBind();
                }
                ViewState["DocID"] = null;
                GdDoc.SelectedRowStyle.BackColor = System.Drawing.Color.White;

                Get_User_RoleName(Session["Email"].ToString(), Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()), DropList.SelectedItem.Text);

                if (Convert.ToInt32(ViewState["Download"].ToString()) == 1)
                {
                    lblNotif.Visible = false;
                    lbltip.Visible = false;
                    btnNotif.Visible = false;
                }
            }

        }

        private DataTable Get_Doc(string MeetingName, int DepartmentID, int FacultyID)
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
            dt = connect.SelectDataOne("Get_Doc", param);
            if (dt.Rows.Count > 0)
            {
                filename = dt.Rows[0]["File_Name"].ToString();
                fileExt = dt.Rows[0]["File_Ext"].ToString();
                bytes_DB = (byte[])dt.Rows[0]["Data"];
            }
            return dt;

        }

        private DataTable Get_MeetingName(string Email)
        {
            ConnectDB connect = new ConnectDB();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
            param[0].Value = Email;
            DataTable dt = new DataTable();
            dt = connect.SelectDataOne("Get_MeetingName", param);
            return dt;
        }

        private DataTable Get_User_RoleName(string Email, int DepartmentID, int FacultyID, string MeetingName)
        {
            ConnectDB connect = new ConnectDB();
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@Email", System.Data.SqlDbType.NVarChar, 100);
            param[0].Value = Email;
            param[1] = new SqlParameter("@DepartmentID", System.Data.SqlDbType.Int);
            param[1].Value = DepartmentID;
            param[2] = new SqlParameter("@FacultyID", System.Data.SqlDbType.Int);
            param[2].Value = FacultyID;
            param[3] = new SqlParameter("@MeetingName", System.Data.SqlDbType.NVarChar, 250);
            param[3].Value = MeetingName;
            DataTable dt = new DataTable();
            dt = connect.SelectDataOne("Get_User_RoleName", param);
            if (dt.Rows.Count > 0)
            {
                ViewState["Download"] = dt.Rows[0]["Is_Download"].ToString();
            }
            return dt;
        }

        protected void btnlogout_Click(object sender, EventArgs e)
        {
            Session["Staff Name-AR"] = null;
            Session["Staff Name-EN"] = null;
            Session["Staff Faculty"] = null;
            Session["Staff Dep"] = null;
            Response.Redirect("Default");
        }

        protected void ChBLang_CheckedChanged(object sender, EventArgs e)
        {
            Response.Redirect("Staff User-EN");
        }

        protected void GdDoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Convert.ToInt32(ViewState["DocID"]) != 0)
            {
                // Add Color to Selected Row

                GdDoc.SelectedRowStyle.BackColor = System.Drawing.Color.SlateGray;
                GdDoc.RowStyle.ForeColor = System.Drawing.Color.Black;

                GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                GdDoc.DataBind();
                lblMes.Text = "";
            }
        }

        protected void btnNotif_Click(object sender, ImageClickEventArgs e)
        {
            tick = 1;

            Session["DocID"] = tick;

            Get_User_RoleName(Session["Email"].ToString(), Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()), DropList.SelectedItem.Text);

            if (Convert.ToInt32(ViewState["Download"].ToString()) == 0)
            {

                Update_DownloadFile_For_StaffUsers(Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()), DropList.SelectedItem.Text);

                lblNotif.Visible = false;
                lbltip.Visible = false;
                btnNotif.Visible = false;

            }
            else
            {
                Response.Redirect("Staff User");
            }
        }

        protected void btnSelect_Command(object sender, CommandEventArgs e)
        {
            lblMes.Text = "";

            if (e.CommandName == "select")
            {
                ViewState["DocID"] = Convert.ToInt32((sender as LinkButton).CommandArgument);
            }
            else if (e.CommandName == "download")
            {
                int id = Convert.ToInt32((sender as LinkButton).CommandArgument);

                if (Convert.ToInt32(ViewState["DocID"]) == id)
                {
                    Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));

                    Download();

                    GdDoc.SelectedRowStyle.BackColor = System.Drawing.Color.White;

                    //Response.Redirect("Staff User");

                    Response.End();
                }
                else if (ViewState["DocID"] == null)
                {
                    lblMes.Text = "يجب أن تختار الصف قبل التنزيل";
                }
                else
                {
                    lblMes.Text = "لم تضغط على الصف المختار";
                }
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
                bytes_DB = (byte[])dt.Rows[0]["Data"];
            }
            return dt;

        }

        private void Update_DownloadFile_For_StaffUsers(int DepartmentID, int FacultyID, string MeetingName)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@DepartmentID", System.Data.SqlDbType.Int);
            param[0].Value = DepartmentID;
            param[1] = new SqlParameter("@FacultyID", System.Data.SqlDbType.Int);
            param[1].Value = FacultyID;
            param[2] = new SqlParameter("@MeetingName", System.Data.SqlDbType.NVarChar, 250);
            param[2].Value = MeetingName;
            connect_DB.ExecuteData("Update_DownloadFile_For_StaffUsers", param);
        }
    }
}