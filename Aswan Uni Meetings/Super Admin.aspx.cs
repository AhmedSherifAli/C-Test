using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aswan_Uni_Meetings
{
    public partial class Super_Admin : System.Web.UI.Page
    {
        DataSet ds;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Select_Data();

                DropDep.DataSource = ds.Tables["Table"];
                DropDep.DataTextField = "DepartmentArName";
                DropDep.DataValueField = "DepartmentID";
                DropDep.DataBind();

                DropFaculty.DataSource = ds.Tables["Table1"];
                DropFaculty.DataTextField = "FacultyArName";
                DropFaculty.DataValueField = "FacultyID";
                DropFaculty.DataBind();

                DropFaculty_Sort.DataSource = ds.Tables["Table1"];
                DropFaculty_Sort.DataTextField = "FacultyArName";
                DropFaculty_Sort.DataValueField = "FacultyID";
                DropFaculty_Sort.DataBind();

                DropRole_Ar.DataSource = ds.Tables["Table2"];
                DropRole_Ar.DataTextField = "RoleName";
                DropRole_Ar.DataBind();

                DropRole_EN.DataSource = ds.Tables["Table3"];
                DropRole_EN.DataTextField = "RoleName_EN";
                DropRole_EN.DataBind();

                DropMeeting_AR.DataSource = ds.Tables["Table4"];
                DropMeeting_AR.DataTextField = "MeetingName";
                DropMeeting_AR.DataBind();

                DropMeeting_EN.DataSource = ds.Tables["Table5"];
                DropMeeting_EN.DataTextField = "MeetingName_EN";
                DropMeeting_EN.DataBind();

                GdPersons.DataSource = Get_Normal_Users_By_Faculty(int.Parse(DropFaculty_Sort.SelectedItem.Value));
                GdPersons.DataBind();

                if (Session["Email"] != null)
                {
                    Select_Data();

                    DropDep.DataSource = ds.Tables["Table"];
                    DropDep.DataTextField = "DepartmentArName";
                    DropDep.DataValueField = "DepartmentID";
                    DropDep.DataBind();

                    DropFaculty.DataSource = ds.Tables["Table1"];
                    DropFaculty.DataTextField = "FacultyArName";
                    DropFaculty.DataValueField = "FacultyID";
                    DropFaculty.DataBind();

                    DropFaculty_Sort.DataSource = ds.Tables["Table1"];
                    DropFaculty_Sort.DataTextField = "FacultyArName";
                    DropFaculty_Sort.DataValueField = "FacultyID";
                    DropFaculty_Sort.DataBind();

                    DropRole_Ar.DataSource = ds.Tables["Table2"];
                    DropRole_Ar.DataTextField = "RoleName";
                    DropRole_Ar.DataBind();

                    DropRole_EN.DataSource = ds.Tables["Table3"];
                    DropRole_EN.DataTextField = "RoleName_EN";
                    DropRole_EN.DataBind();

                    DropMeeting_AR.DataSource = ds.Tables["Table4"];
                    DropMeeting_AR.DataTextField = "MeetingName";
                    DropMeeting_AR.DataBind();

                    DropMeeting_EN.DataSource = ds.Tables["Table5"];
                    DropMeeting_EN.DataTextField = "MeetingName_EN";
                    DropMeeting_EN.DataBind();
                }  
            }
        }

        private DataSet Select_Data()
        {
            ConnectDB connect = new ConnectDB();
            ds = new DataSet();
            ds = connect.SelectData("Select_Data", null);
            return ds;
        }

        private DataTable Get_Normal_Users_By_Faculty(int FacultyID)
        {
            ConnectDB connect = new ConnectDB();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@FacultyID", System.Data.SqlDbType.Int);
            param[0].Value = FacultyID;
            dt = new DataTable();
            dt = connect.SelectDataOne("Get_Normal_Users_By_Faculty", param);
            return dt;
        }

        protected void btnlogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default");
        }

        protected void ChBLang_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!CheckUserExists())
            {
                if (txtName.Text.Trim() != string.Empty && txtEmail.Text.Trim() != string.Empty && txtNationalID.Text.Trim() != string.Empty)
                {
                    Insert_NormalUser(txtName.Text.Trim(), txtEmail.Text.Trim(), txtNationalID.Text.Trim(), int.Parse(DropFaculty.SelectedItem.Value), int.Parse(DropDep.SelectedItem.Value),
                    DropRole_Ar.SelectedItem.Text, DropRole_EN.SelectedItem.Text, DropMeeting_AR.SelectedItem.Text, DropMeeting_EN.SelectedItem.Text);
                }

                txtName.Text = "";
                txtEmail.Text = "";
                txtNationalID.Text = "";
                lblMes.Text = "";
            }
            else
            {
                lblMes.Text = "هذا الشخص موجود";
            }
            
        }

        bool CheckUserExists()
        {
            try
            {
                string Email = txtEmail.Text.Trim();
                ConnectDB connect = new ConnectDB();
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Email", System.Data.SqlDbType.NVarChar, 50);
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

        private void Insert_NormalUser(string UserName, string Email, string NationalID , int FacultyID, int DepartmentID , string MeetingRole, string MeetingRole_EN, string MeetingName, string MeetingName_EN)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[9];
            param[0] = new SqlParameter("@UserName", System.Data.SqlDbType.NVarChar, 255);
            param[0].Value = UserName;
            param[1] = new SqlParameter("@Email", System.Data.SqlDbType.NVarChar, 250);
            param[1].Value = Email;
            param[2] = new SqlParameter("@NationalID", System.Data.SqlDbType.NVarChar, 50);
            param[2].Value = NationalID;
            param[3] = new SqlParameter("@FacultyID", System.Data.SqlDbType.Int);
            param[3].Value = FacultyID;
            param[4] = new SqlParameter("@DepartmentID", System.Data.SqlDbType.Int);
            param[4].Value = DepartmentID;
            param[5] = new SqlParameter("@MeetingRole", System.Data.SqlDbType.NVarChar, 250);
            param[5].Value = MeetingRole;
            param[6] = new SqlParameter("@MeetingRole_EN", System.Data.SqlDbType.NVarChar , 250);
            param[6].Value = MeetingRole_EN;
            param[7] = new SqlParameter("@MeetingName", System.Data.SqlDbType.NVarChar , 250);
            param[7].Value = MeetingName;
            param[8] = new SqlParameter("@MeetingName_EN", System.Data.SqlDbType.NVarChar , 250);
            param[8].Value = MeetingName_EN;
            connect_DB.ExecuteData("Insert_NormalUser", param);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if(ViewState["User"] != null)
            {
                if (txtName.Text.Trim() != string.Empty && txtEmail.Text.Trim() != string.Empty && txtNationalID.Text.Trim() != string.Empty)
                {
                    Update_User(txtName.Text.Trim(), txtEmail.Text.Trim(), txtNationalID.Text.Trim(), int.Parse(DropFaculty.SelectedItem.Value), int.Parse(DropDep.SelectedItem.Value),
                    DropRole_Ar.SelectedItem.Text, DropRole_EN.SelectedItem.Text, DropMeeting_AR.SelectedItem.Text, DropMeeting_EN.SelectedItem.Text);

                    GdPersons.DataSource = Get_Normal_Users_By_Faculty(int.Parse(DropFaculty_Sort.SelectedItem.Value));
                    GdPersons.DataBind();

                    txtName.Text = "";
                    txtEmail.Text = "";
                    txtNationalID.Text = "";
                    lblMes.Text = "";
                } 
            }
        }

        private void Update_User(string UserName, string Email, string NationalID, int FacultyID, int DepartmentID, string MeetingRole, string MeetingRole_EN, string MeetingName, string MeetingName_EN)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[9];
            param[0] = new SqlParameter("@UserName", System.Data.SqlDbType.NVarChar, 255);
            param[0].Value = UserName;
            param[1] = new SqlParameter("@Email", System.Data.SqlDbType.NVarChar, 250);
            param[1].Value = Email;
            param[2] = new SqlParameter("@NationalID", System.Data.SqlDbType.NVarChar, 50);
            param[2].Value = NationalID;
            param[3] = new SqlParameter("@FacultyID", System.Data.SqlDbType.Int);
            param[3].Value = FacultyID;
            param[4] = new SqlParameter("@DepartmentID", System.Data.SqlDbType.Int);
            param[4].Value = DepartmentID;
            param[5] = new SqlParameter("@MeetingRole", System.Data.SqlDbType.NVarChar, 250);
            param[5].Value = MeetingRole;
            param[6] = new SqlParameter("@MeetingRole_EN", System.Data.SqlDbType.NVarChar, 250);
            param[6].Value = MeetingRole_EN;
            param[7] = new SqlParameter("@MeetingName", System.Data.SqlDbType.NVarChar, 250);
            param[7].Value = MeetingName;
            param[8] = new SqlParameter("@MeetingName_EN", System.Data.SqlDbType.NVarChar, 250);
            param[8].Value = MeetingName_EN;
            connect_DB.ExecuteData("Update_User", param);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (ViewState["User"] != null)
            {
                DeleteUser(ViewState["User"].ToString());

                GdPersons.DataSource = Get_Normal_Users_By_Faculty(int.Parse(DropFaculty_Sort.SelectedItem.Value));
                GdPersons.DataBind();
            }
        }

        private void DeleteUser(string StaffID)
        {
            ConnectDB connect_DB = new ConnectDB();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@StaffID", System.Data.SqlDbType.VarChar, 11);
            param[0].Value = StaffID;
            connect_DB.ExecuteData("DeleteUser", param);
        }

        protected void btnSelect_Command(object sender, CommandEventArgs e)
        {
            lblMes.Text = "";

            if (e.CommandName == "select")
            {
                ViewState["User"] = Convert.ToInt32((sender as LinkButton).CommandArgument);
            }
        }

        protected void DropFaculty_Sort_SelectedIndexChanged(object sender, EventArgs e)
        {
            GdPersons.DataSource = Get_Normal_Users_By_Faculty(int.Parse(DropFaculty_Sort.SelectedItem.Value));
            GdPersons.DataBind();
        }

       
    }
}