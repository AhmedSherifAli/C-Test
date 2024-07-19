using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aswan_Uni_Meetings
{
    public partial class Normal_User_Member : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMes.Text = "";
            ChBLang.Checked = false;

            if (!IsPostBack)
            {
                if (Session["User Name-AR"] != null)
                {
                    lblname.Text = "مرحبا / " + Session["User Name-AR"].ToString();

                    DropList.DataSource = Get_MeetingName(Session["Email"].ToString());
                    DropList.DataTextField = "MeetingName";
                    DropList.DataBind();

                    Get_User_RoleName(Session["Email"].ToString(), Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()), DropList.SelectedItem.Text);
                    ListItem Admin = new ListItem(ViewState["RoleName"].ToString());
                    DropType.Items.Add(Admin);
                    ListItem Member = new ListItem("عضو");
                    DropType.Items.Add(Member);

                    Session["MeetingName"]  = DropList.SelectedItem.Text;

                    GdDoc.DataSource = Get_StaffData_AR(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                    GdDoc.DataBind();
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
                ViewState["RoleName"] = dt.Rows[0]["MeetingRole"].ToString();
                ViewState["RoleName_EN"] = dt.Rows[0]["MeetingRole_EN"].ToString();
            }
            return dt;
        }

        private DataTable Get_StaffData_AR(string MeetingName, int DepartmentID, int FacultyID)
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
            dt = connect.SelectDataOne("Get_StaffData_AR", param);
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
            Response.Redirect("Normal User-Member-EN");
        }

        protected void DropList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropList.SelectedItem.Text != null)
            {
                if (DropList.SelectedItem.Text == "مجلس الجامعة" || DropList.SelectedItem.Text == "مجلس الدراسات العليا" || DropList.SelectedItem.Text == "مجلس العلاقات الثقافية" || DropList.SelectedItem.Text == "مجلس شئون البيئة" || DropList.SelectedItem.Text == "مجلس شئون التعليم والطلاب")
                {
                    GdDoc.DataSource = Get_StaffData_AR(DropList.SelectedItem.Text, 0, 0);
                    GdDoc.DataBind();
                }
                else if (DropList.SelectedItem.Text != "مجلس الجامعة" && DropList.SelectedItem.Text != "مجلس الدراسات العليا" && DropList.SelectedItem.Text != "مجلس العلاقات الثقافية" && DropList.SelectedItem.Text != "مجلس شئون البيئة" && DropList.SelectedItem.Text != "مجلس شئون التعليم والطلاب" && DropList.SelectedItem.Text != "مجلس قسم")
                {
                    GdDoc.DataSource = Get_StaffData_AR(DropList.SelectedItem.Text, 0, Convert.ToInt32(Session["User Faculty"].ToString()));
                    GdDoc.DataBind();
                }
                else
                {
                    GdDoc.DataSource = Get_StaffData_AR(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                    GdDoc.DataBind();
                }
                Session["MeetingName"] = DropList.SelectedItem.Text;
                ViewState["StaffID"] = null;
                GdDoc.SelectedRowStyle.BackColor = System.Drawing.Color.White;
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblMes.Text = "";

            if (txtSearch.Text.Trim() != string.Empty)
            {
                GetStaff_ByName(txtSearch.Text.Trim());

                if(Convert.ToInt32(ViewState["StaffFaculty"].ToString()) != 0)
                {
                    if (DropList.SelectedItem.Text == "مجلس الجامعة" || DropList.SelectedItem.Text == "مجلس الدراسات العليا" || DropList.SelectedItem.Text == "مجلس العلاقات الثقافية" || DropList.SelectedItem.Text == "مجلس شئون البيئة" || DropList.SelectedItem.Text == "مجلس شئون التعليم والطلاب")
                    {
                        GdStaff.DataSource = GetStaff_ByName(txtSearch.Text.Trim());
                        GdStaff.DataBind();
                    }
                    else if (DropList.SelectedItem.Text != "مجلس الجامعة" && DropList.SelectedItem.Text != "مجلس الدراسات العليا" && DropList.SelectedItem.Text != "مجلس العلاقات الثقافية" && DropList.SelectedItem.Text != "مجلس شئون البيئة" && DropList.SelectedItem.Text != "مجلس شئون التعليم والطلاب")
                    {
                        if (Convert.ToInt32(ViewState["StaffFaculty"].ToString()) == Convert.ToInt32(Session["User Faculty"].ToString()))
                        {
                            GdStaff.DataSource = GetStaff_ByName(txtSearch.Text.Trim());
                            GdStaff.DataBind();
                        }
                        else
                        {
                            lblMes.Text = "عضو هيئة التدريس لاينتمى للكلية";
                        }
                    }
                }
                else
                {
                    lblMes.Text = "هذا الشخص لايوجد له بيانات بالجامعة";
                }

            }
        }

        private DataTable GetStaff_ByName(string Name)
        {
            ConnectDB connect = new ConnectDB();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@StaffArName", System.Data.SqlDbType.NVarChar, 250);
            param[0].Value = Name;
            DataTable dt = new DataTable();
            dt = connect.SelectDataOne("GetStaff_ByName", param);
            if (dt.Rows.Count >= 1)
            {
                ViewState["StaffEmail"] = dt.Rows[0]["UniversityEmail"].ToString();
                ViewState["StaffFaculty"] = dt.Rows[0]["FacultyID"].ToString();
            }
            else
            {
                ViewState["StaffFaculty"] = 0;
            }
            return dt;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (ViewState["StaffEmail"] != null)
            {
                if (!CheckUserExists())
                {
                    if (txtSearch.Text.Trim() != string.Empty)
                    {

                        Get_User_RoleName(Session["Email"].ToString(), Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()), DropList.SelectedItem.Text);

                        Get_User_MeetingName_EN(Session["Email"].ToString(), Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()), DropList.SelectedItem.Text);

                        if(DropType.SelectedItem.Text == ViewState["RoleName"].ToString())
                        {
                            Insert_StaffData(txtSearch.Text.Trim(), Convert.ToInt32(Session["User Dep"].ToString()), ViewState["RoleName"].ToString(), ViewState["RoleName_EN"].ToString(), DropList.SelectedItem.Text, ViewState["MeetingName_EN"].ToString());
                        }
                        else
                        {
                            Insert_StaffData(txtSearch.Text.Trim(), Convert.ToInt32(Session["User Dep"].ToString()), DropType.SelectedItem.Text, "Member", DropList.SelectedItem.Text, ViewState["MeetingName_EN"].ToString());
                        }

                        GdDoc.DataSource = Get_StaffData_AR(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                        GdDoc.DataBind();

                        txtSearch.Text = "";

                        Response.Redirect("Normal User-Member");
                    }
                }
                else
                {
                    lblMes.Text = "هذا العضو موجود";
                }
            }
            else
            {
                lblMes.Text = "يجب ان تبحث أولا عن العضو أولا";
            }

        }

        private void Insert_StaffData(string StaffNationalID, int DepartmrntID, string MeetingRole, string MeetingRole_EN, string MeetingName, string MeetingName_EN)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@StaffNationalID", System.Data.SqlDbType.NVarChar, 50);
            param[0].Value = StaffNationalID;
            param[1] = new SqlParameter("@DepartmrntID", System.Data.SqlDbType.Int);
            param[1].Value = DepartmrntID;
            param[2] = new SqlParameter("@MeetingRole", System.Data.SqlDbType.NVarChar, 250);
            param[2].Value = MeetingRole;
            param[3] = new SqlParameter("@MeetingRole_EN", System.Data.SqlDbType.NVarChar, 250);
            param[3].Value = MeetingRole_EN;
            param[4] = new SqlParameter("@MeetingName", System.Data.SqlDbType.NVarChar, 250);
            param[4].Value = MeetingName;
            param[5] = new SqlParameter("@MeetingName_EN", System.Data.SqlDbType.NVarChar, 250);
            param[5].Value = MeetingName_EN;
            connect_DB.ExecuteData("Insert_StaffData", param);
        }

        bool CheckUserExists()
        {
            try
            {
                string Email = ViewState["StaffEmail"].ToString();
                ConnectDB connect = new ConnectDB();
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar, 50);
                param[0].Value = Email;
                DataTable dt = new DataTable();
                dt = connect.SelectDataOne("CheckUserMeeting", param);
                if (dt.Rows.Count >= 1)
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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (ViewState["StaffID"] != null)
            {
                DeleteStaffUser(ViewState["StaffID"].ToString(), DropList.SelectedItem.Text);

                GdDoc.DataSource = Get_StaffData_AR(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                GdDoc.DataBind();

                Response.Redirect("Normal User-Member");
            }
            else
            {
                lblMes.Text = "يجب ان تختار الصف من الجدول أولا";
            }
        }

        private void DeleteStaffUser(string StaffID, string MeetingName)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@StaffID", System.Data.SqlDbType.VarChar, 11);
            param[0].Value = StaffID;
            param[1] = new SqlParameter("@MeetingName", System.Data.SqlDbType.NVarChar, 250);
            param[1].Value = MeetingName;
            connect_DB.ExecuteData("DeleteStaffUser", param);
        }

        protected void GdDoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ViewState["StaffID"] != null)
            {
                // Add Color to Selected Row

                GdDoc.SelectedRowStyle.BackColor = System.Drawing.Color.SlateGray;
                GdDoc.RowStyle.ForeColor = System.Drawing.Color.Black;

                GdDoc.DataSource = Get_StaffData_AR(DropList.SelectedItem.Text, Convert.ToInt32(Session["User Dep"].ToString()), Convert.ToInt32(Session["User Faculty"].ToString()));
                GdDoc.DataBind();
                lblMes.Text = "";
            }
        }

        protected void btnSelect_Command(object sender, CommandEventArgs e)
        {
            lblMes.Text = "";

            if (e.CommandName == "select")
            {
                ViewState["StaffID"] = ((sender as LinkButton).CommandArgument).ToString();
            }  
        }

    }
}