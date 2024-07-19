using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aswan_Uni_Meetings
{
    public partial class Invitations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMesInv.Text = "";
            ChBLang.Checked = false;

            if (!IsPostBack)
            {
                if (Session["User Name-AR"] != null)
                {
                    lblname.Text = "مرحبا / " + Session["User Name-AR"].ToString();

                    DropList.DataSource = Get_MeetingName(Session["Email"].ToString());
                    DropList.DataTextField = "MeetingName";
                    DropList.DataBind();

                    Session["MeetingName"] = DropList.SelectedItem.Text; 
                }
                else
                {
                    Response.Redirect("Default");
                }
            }
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

        protected void btnlogout_Click(object sender, EventArgs e)
        {
            Session["User Name-AR"] = null;
            Session["User Name-EN"] = null;
            Session["User Faculty"] = null;
            Session["User Dep"] = null;
            Session["MeetingName"] = null;
            Response.Redirect("Default");
        }

        protected void ChBLang_CheckedChanged(object sender, EventArgs e)
        {
            Response.Redirect("Invitations-EN");
        }

        protected void DropList_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMesInv.Text = "";
        }

        protected void btnAddInv_Click(object sender, EventArgs e)
        {
            if (upload.HasFile)
            {
                lblMesInv.Text = "";

                DataTable dt = Get_Invitation_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));

                if (dt.Rows.Count > 0)
                {

                    int filesize = upload.PostedFile.ContentLength;
                    if (filesize < 20000000)
                    {
                        ViewState["Filename"] = Path.GetFileName(upload.FileName);
                        ViewState["FileExt"] = Path.GetExtension(upload.FileName);

                        if (ViewState["FileExt"].ToString() == ".docx" || ViewState["FileExt"].ToString() == ".doc" || ViewState["FileExt"].ToString() == ".pdf")
                        {
                            MemoryStream ms_update = new MemoryStream(upload.FileBytes);
                            BinaryReader br_update = new BinaryReader(ms_update);
                            byte[] bytes_update = ms_update.ToArray();
                            br_update.Close();
                            ms_update.Close();

                            Update_Invitation_File(Convert.ToInt32(ViewState["InvitationId"]), ViewState["Filename"].ToString()
                            , ViewState["FileExt"].ToString().ToLower(), bytes_update);

                            Update_NotDownloadFile_For_StaffUsers(Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()), DropList.SelectedItem.Text);

                            // Prevent Event Click Duplicated

                            Response.Redirect("Invitations");
                        }
                        else
                        {
                            lblMesInv.Text = "يجب أن تختار ملف نصى";
                        }
                    }
                    else
                    {
                        lblMesInv.Text = "مساحة الملف لا تكون أكبر من 20 ميجا";
                    }
                }
                else
                {
                    int filesize = upload.PostedFile.ContentLength;
                    if (filesize < 20000000)
                    {
                        ViewState["Filename"] = Path.GetFileName(upload.FileName);
                        ViewState["FileExt"] = Path.GetExtension(upload.FileName);

                        if (ViewState["FileExt"].ToString() == ".docx" || ViewState["FileExt"].ToString() == ".doc" || ViewState["FileExt"].ToString() == ".pdf")
                        {
                            MemoryStream ms = new MemoryStream(upload.FileBytes);
                            BinaryReader br = new BinaryReader(ms);
                            byte[] bytes = ms.ToArray();
                            br.Close();
                            ms.Close();

                            Get_User_MeetingName_EN(Session["Email"].ToString(), Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()), DropList.SelectedItem.Text);

                            Insert_InvitationDoc(DropList.SelectedItem.Text, ViewState["MeetingName_EN"].ToString(), Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString())
                                , ViewState["Filename"].ToString(), ViewState["FileExt"].ToString().ToLower(), bytes);

                            Update_NotDownloadFile_For_StaffUsers(Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()), DropList.SelectedItem.Text);

                            // Prevent Event Click Duplicated

                            Response.Redirect("Invitations");

                        }
                        else
                        {
                            lblMesInv.Text = "يجب أن تختار ملف نصى";
                        }

                    }
                    else
                    {
                        lblMesInv.Text = "مساحة الملف لا تكون أكبر من 20 ميجا";
                    }

                    //DataTable dt = Get_StaffData_AR(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                    //int count = dt.Rows.Count;
                    //string[] Staff_Email = new string[count];
                    //for (int i = 0; i < count; i++)
                    //{
                    //    Staff_Email[i] = dt.Rows[i]["UniversityEmail"].ToString();
                    //}

                    //for (int i = 0; i < Staff_Email.Length; i++)
                    //{
                    //    //To += s_name[i];
                    //    string ToEmail = Staff_Email[i];
                    //}
                }
            }
            else
            {
                lblMesInv.Text = "يجب اضافة ملف الدعوة أولا";
            }
        }

        private DataTable Get_User_MeetingName_EN(string Email, int DepartmentID, int FacultyID, string MeetingName)
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
            dt = connect.SelectDataOne("Get_User_MeetingName_EN", param);
            if (dt.Rows.Count > 0)
            {
                ViewState["MeetingName_EN"] = dt.Rows[0]["MeetingName_EN"].ToString();
            }
            return dt;
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
                ViewState["InvitationId"] = dt.Rows[0]["InvitationId"];
                byte[] bytes_DB = (byte[])dt.Rows[0]["Data"];
            }
            return dt;
        }

        private void Insert_InvitationDoc(string MeetingName, string MeetingName_EN, int DepartmentID, int FacultyID, string FileName, string File_Ext, byte[] Byte)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[7];
            param[0] = new SqlParameter("@MeetingName", System.Data.SqlDbType.NVarChar, 250);
            param[0].Value = MeetingName;
            param[1] = new SqlParameter("@MeetingName_EN", System.Data.SqlDbType.NVarChar, 250);
            param[1].Value = MeetingName_EN;
            param[2] = new SqlParameter("@DepartmentID", System.Data.SqlDbType.Int);
            param[2].Value = DepartmentID;
            param[3] = new SqlParameter("@FacultyID", System.Data.SqlDbType.Int);
            param[3].Value = FacultyID;
            param[4] = new SqlParameter("@FileName", System.Data.SqlDbType.NVarChar, 250);
            param[4].Value = FileName;
            param[5] = new SqlParameter("@File_Ext", System.Data.SqlDbType.NVarChar, 30);
            param[5].Value = File_Ext;
            param[6] = new SqlParameter("@Data", System.Data.SqlDbType.Binary);
            param[6].Value = Byte;
            connect_DB.ExecuteData("Insert_InvitationDoc", param);
        }

        private void Update_Invitation_File(int Id, string FileName, string File_Ext, byte[] Byte)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@InvitationId", System.Data.SqlDbType.Int);
            param[0].Value = Id;
            param[1] = new SqlParameter("@FileName", System.Data.SqlDbType.NVarChar, 250);
            param[1].Value = FileName;
            param[2] = new SqlParameter("@File_Ext", System.Data.SqlDbType.NVarChar, 30);
            param[2].Value = File_Ext;
            param[3] = new SqlParameter("@Data", System.Data.SqlDbType.Binary);
            param[3].Value = Byte;
            connect_DB.ExecuteData("Update_Invitation_File", param);
        }

        private void Update_NotDownloadFile_For_StaffUsers(int DepartmentID, int FacultyID, string MeetingName)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@DepartmentID", System.Data.SqlDbType.Int);
            param[0].Value = DepartmentID;
            param[1] = new SqlParameter("@FacultyID", System.Data.SqlDbType.Int);
            param[1].Value = FacultyID;
            param[2] = new SqlParameter("@MeetingName", System.Data.SqlDbType.NVarChar, 250);
            param[2].Value = MeetingName;
            connect_DB.ExecuteData("Update_NotDownloadFile_For_StaffUsers", param);
        }

    }
}