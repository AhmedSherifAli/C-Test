using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aswan_Uni_Meetings
{
    public partial class Normal_User_EN : System.Web.UI.Page
    {
        string MeetingDate_DB;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMes.Text = "";
            ChBLang.Checked = true;

            if (!IsPostBack)
            {
                if (Session["User Name-AR"] != null)
                {
                    lblname.Text = "Welcome \\ " + Session["User Name-EN"].ToString();

                    Calmeeting.Visible = false;

                    DropList.DataSource = Get_MeetingName(Session["Email"].ToString());
                    DropList.DataTextField = "MeetingName_EN";
                    DropList.DataBind();

                    Session["MeetingName"] = DropList.SelectedItem.Text;

                    GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                    GdDoc.DataBind();
                }
                else
                {
                    Response.Redirect("Default-EN");
                }
                
            }
        }

        protected void DropList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(DropList.SelectedItem.Text != null)
            {
                if (DropList.SelectedItem.Text == "University Council" || DropList.SelectedItem.Text == "Graduate Studies Council" || DropList.SelectedItem.Text == "Cultural Relations Council" || DropList.SelectedItem.Text == "Environmental Affairs Council" || DropList.SelectedItem.Text == "Education and Student Affairs Council")
                {
                    GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, 0, 0);
                    GdDoc.DataBind();
                }
                else if (DropList.SelectedItem.Text != "University Council" && DropList.SelectedItem.Text != "Graduate Studies Council" && DropList.SelectedItem.Text != "Cultural Relations Council" && DropList.SelectedItem.Text != "Environmental Affairs Council" && DropList.SelectedItem.Text != "Education and Student Affairs Council" && DropList.SelectedItem.Text != "Department Council")
                {
                    GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, 0, Convert.ToInt32(Session["User Faculty"].ToString()));
                    GdDoc.DataBind();
                }
                else
                {
                    GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                    GdDoc.DataBind();
                }
                txtDate.Text = "";
                ViewState["DocID"] = null;
                GdDoc.SelectedRowStyle.BackColor = System.Drawing.Color.White;
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
                byte[] bytes_DB = (byte[])dt.Rows[0]["Data"];
            }
            return dt;
        }

        protected void btnlogout_Click(object sender, EventArgs e)
        {
            Session["User Name-AR"] = null;
            Session["User Name-EN"] = null;
            Session["User Faculty"] = null;
            Session["User Dep"] = null;
            Session["MeetingName"] = null;
            Response.Redirect("Default-EN");
        }

        protected void ChBLang_CheckedChanged(object sender, EventArgs e)
        {
            Response.Redirect("Normal User");
        }

        protected void Imagmeeting_Click(object sender, ImageClickEventArgs e)
        {
            Calmeeting.Visible = true;
        }

        protected void Calmeeting_SelectionChanged(object sender, EventArgs e)
        {
            DateTime date = DateTime.Now;
            txtDate.Text = Calmeeting.SelectedDate.ToString("dd/MM/yyyy");
            Calmeeting.Visible = false;
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            if (txtDate.Text.Trim() != string.Empty && upload.FileName != string.Empty)
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

                        Get_User_MeetingName_AR(Session["Email"].ToString(), Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()), DropList.SelectedItem.Text);

                        Insert_Doc(ViewState["MeetingName_AR"].ToString(), DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString())
                            , txtDate.Text.Trim(), ViewState["Filename"].ToString(), ViewState["FileExt"].ToString().ToLower(), bytes);

                        GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                        GdDoc.DataBind();

                        txtDate.Text = "";
                        Calmeeting.SelectedDate = Convert.ToDateTime("01/01/0001");
                        lblMes.Text = "";

                        // Prevent Event Click Duplicated

                        Response.Redirect("Normal User-EN");
                    }
                    else
                    {
                        lblMes.Text = "You must Select Text File !";
                    }
                }
                else
                {
                    lblMes.Text = "Size of File Exceed the Maximum Size (20 MB) !";
                }
            }
            else if (txtDate.Text.Trim() == string.Empty && upload.FileName != string.Empty)
            {
                lblMes.Text = "You must Enter Meeting Date !";
            }
            else if (upload.FileName == string.Empty && txtDate.Text.Trim() != string.Empty)
            {
                lblMes.Text = "You must Select Meeting File !";
            }
            else
            {
                lblMes.Text = "You must Enter Meeting Date and Meeting File !";
            }
            
        }
        private void Insert_Doc(string MeetingName, string MeetingName_EN, int DepartmentID, int FacultyID, string MeetingDate, string FileName, string File_Ext, byte[] Byte)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[8];
            param[0] = new SqlParameter("@MeetingName", System.Data.SqlDbType.NVarChar, 250);
            param[0].Value = MeetingName;
            param[1] = new SqlParameter("@MeetingName_EN", System.Data.SqlDbType.NVarChar, 250);
            param[1].Value = MeetingName_EN;
            param[2] = new SqlParameter("@DepartmentID", System.Data.SqlDbType.Int);
            param[2].Value = DepartmentID;
            param[3] = new SqlParameter("@FacultyID", System.Data.SqlDbType.Int);
            param[3].Value = FacultyID;
            param[4] = new SqlParameter("@MeetingDate", System.Data.SqlDbType.NVarChar, 100);
            param[4].Value = MeetingDate;
            param[5] = new SqlParameter("@FileName", System.Data.SqlDbType.NVarChar, 250);
            param[5].Value = FileName;
            param[6] = new SqlParameter("@File_Ext", System.Data.SqlDbType.NVarChar, 30);
            param[6].Value = File_Ext;
            param[7] = new SqlParameter("@Data", System.Data.SqlDbType.Binary);
            param[7].Value = Byte;
            connect_DB.ExecuteData("Insert_MeetingDoc", param);
        }

        private DataTable Get_User_MeetingName_AR(string Email, int DepartmentID, int FacultyID, string MeetingName)
        {
            ConnectDB connect = new ConnectDB();
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@Email", System.Data.SqlDbType.NVarChar, 100);
            param[0].Value = Email;
            param[1] = new SqlParameter("@DepartmentID", System.Data.SqlDbType.Int);
            param[1].Value = DepartmentID;
            param[2] = new SqlParameter("@FacultyID", System.Data.SqlDbType.Int);
            param[2].Value = FacultyID;
            param[3] = new SqlParameter("@MeetingName_EN", System.Data.SqlDbType.NVarChar, 250);
            param[3].Value = MeetingName;
            DataTable dt = new DataTable();
            dt = connect.SelectDataOne("Get_User_MeetingName_AR", param);
            if (dt.Rows.Count > 0)
            {
                ViewState["MeetingName_AR"] = dt.Rows[0]["MeetingName"].ToString();
            }
            return dt;
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (ViewState["DocID"] != null)
            {
                lblMes.Text = "";

                if (txtDate.Text.Trim() == string.Empty && upload.FileName != string.Empty)
                {

                    Get_MeetingDate_ById(Convert.ToInt32(ViewState["DocID"]));

                    // change Culture of Page during Edit Meeting Date 

                    System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("ar-EG");

                    // Compare to Stored Date in DB and input Date 

                    DateTime date_DB = DateTime.Parse(MeetingDate_DB + " 12:00:00");
                    DateTime date_Now = DateTime.Now;

                    if (date_DB > date_Now)
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

                                Update_Doc_File(Convert.ToInt32(ViewState["DocID"]), ViewState["Filename"].ToString()
                                , ViewState["FileExt"].ToString().ToLower(), bytes_update);

                                GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                                GdDoc.DataBind();

                                // Prevent Event Click Duplicated

                                Response.Redirect("Normal User-EN");
                            }
                            else
                            {
                                lblMes.Text = "You must Text File !";
                            }
                        }
                        else
                        {
                            lblMes.Text = "Size of File Exceed the Maximum Size (20 MB) !";
                        }
                    }
                    else
                    {
                        lblMes.Text = "You can't change File of Finished Meeting !";
                    }

                    
                }
                else if (txtDate.Text.Trim() != string.Empty && upload.FileName == string.Empty)
                {
                    Get_MeetingDate_ById(Convert.ToInt32(ViewState["DocID"]));

                   // change Culture of Page during Edit Meeting Date 

                    System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("ar-EG");

                    // Compare to Stored Date in DB and input Date 

                    DateTime date_DB = DateTime.Parse(MeetingDate_DB + " 12:00:00");
                    DateTime date_Now = DateTime.Now;

                    if (date_DB > date_Now)
                    {
                        Update_Doc_Date(Convert.ToInt32(ViewState["DocID"]), txtDate.Text.Trim());

                        GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                        GdDoc.DataBind();

                        txtDate.Text = "";
                        Calmeeting.SelectedDate = Convert.ToDateTime("01/01/0001");

                        // Prevent Event Click Duplicated

                        Response.Redirect("Normal User-EN");
                    }
                    else
                    {
                        lblMes.Text = "You can't change Date of Finished Meeting !";
                    }
                }
                else if (txtDate.Text.Trim() != string.Empty && upload.FileName != string.Empty)
                {
                    Get_MeetingDate_ById(Convert.ToInt32(ViewState["DocID"]));

                    // change Culture of Page during Edit Meeting Date 

                    System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("ar-EG");

                    // Compare to Stored Date in DB and input Date 

                    DateTime date_DB = DateTime.Parse(MeetingDate_DB + " 12:00:00");
                    DateTime date_Now = DateTime.Now;

                    if (date_DB > date_Now)
                    {
                        Update_Doc_Date(Convert.ToInt32(ViewState["DocID"]), txtDate.Text.Trim());

                        GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                        GdDoc.DataBind();

                        txtDate.Text = "";
                        Calmeeting.SelectedDate = Convert.ToDateTime("01/01/0001");

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

                                Update_Doc_File(Convert.ToInt32(ViewState["DocID"]), ViewState["Filename"].ToString()
                                , ViewState["FileExt"].ToString().ToLower(), bytes_update);

                                GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                                GdDoc.DataBind();

                                // Prevent Event Click Duplicated

                                Response.Redirect("Normal User-EN");
                            }
                            else
                            {
                                lblMes.Text = "You must Text File !";
                            }
                        }
                        else
                        {
                            lblMes.Text = "Size of File Exceed the Maximum Size (20 MB) !";
                        }
                    }
                    else
                    {
                        lblMes.Text = "You can't Edit Details of Finished Meeting !";
                    }
                }
                else if (upload.FileName == string.Empty && txtDate.Text.Trim() == string.Empty)
                {
                    lblMes.Text = "You must Enter Meeting Date or Meeting File !";
                }
            }
            else
            {
                lblMes.Text = "You must Select The Row befor Edit Meeting Details !";
            }
        }

        private void Update_Doc_Date(int Id, string MeetingDate)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@DetailId", System.Data.SqlDbType.Int);
            param[0].Value = Id;
            param[1] = new SqlParameter("@MeetingDate", System.Data.SqlDbType.NVarChar, 100);
            param[1].Value = MeetingDate;
            connect_DB.ExecuteData("Update_Doc_Date", param);
        }

        private void Update_Doc_File(int Id, string FileName, string File_Ext, byte[] Byte)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@DetailId", System.Data.SqlDbType.Int);
            param[0].Value = Id;
            param[1] = new SqlParameter("@FileName", System.Data.SqlDbType.NVarChar, 250);
            param[1].Value = FileName;
            param[2] = new SqlParameter("@File_Ext", System.Data.SqlDbType.NVarChar, 30);
            param[2].Value = File_Ext;
            param[3] = new SqlParameter("@Data", System.Data.SqlDbType.Binary);
            param[3].Value = Byte;
            connect_DB.ExecuteData("Update_Doc_File", param);
        }

        private DataTable Get_MeetingDate_ById(int Id)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@DetailId", System.Data.SqlDbType.Int);
            param[0].Value = Id;
            DataTable dt = new DataTable();
            dt = connect_DB.SelectDataOne("Get_MeetingDate_ById", param);
            if (dt.Rows.Count > 0)
            {
                MeetingDate_DB = dt.Rows[0]["MeetingDate"].ToString();
            }
            return dt;
        }

        protected void btnSelect_Command(object sender, CommandEventArgs e)
        {
            lblMes.Text = "";

            if (e.CommandName == "select")
            {
                ViewState["DocID"] = Convert.ToInt32((sender as LinkButton).CommandArgument);

                //GdDoc.DataSource = Get_Doc(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                //GdDoc.DataBind();

            }
            //else if (e.CommandName == "download")
            //{
            //    id = Convert.ToInt32((sender as LinkButton).CommandArgument);
            //    if (Convert.ToInt32(ViewState["DocID"]) == id)
            //    {
            //        Get_Doc_Data(Convert.ToInt32(ViewState["DocID"]));
            //        bytes = bytes_DB;
            //        Response.Buffer = true;
            //        Response.Charset = "";
            //        Response.Clear();
            //        Response.Cache.SetCacheability(HttpCacheability.NoCache);

            //        if (fileExt == "docx")
            //        {
            //            Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            //            //Response.ContentType = "application/vnd.msword";
            //            //Response.ContentType = "application/app.ms-word";
            //            //Response.ContentType = "application/octet-stream";
            //        }
            //        else if (fileExt == "pdf")
            //        {
            //            Response.ContentType = "application/pdf";
            //        }

            //        // Download Line
            //        Response.AddHeader("content-disposition", "attachment; filename=" + filename);

            //        Response.BinaryWrite(bytes);
            //        Response.Flush();
            //        Response.End();
            //    }
            //    else if (ViewState["DocID"] == null)
            //    {
            //        lblmes.Text = "You must click Select Button First !";
            //    }
            //    else
            //    {
            //        lblmes.Text = "You click Wrong Row !";
            //    }
            //}
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

        protected void Calmeeting_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.Date.CompareTo(DateTime.Today) < 0)
            {
                e.Day.IsSelectable = false;
            }
        }
    }
}