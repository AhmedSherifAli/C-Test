using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Login___Registration_Enhanced
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            show.Visible = false;
            user.Visible = false;
            if (Session["username"] != null)
            {
                show.Visible = true;
                btnlogout.Visible = true;
                hide.Visible = false;

                lblMes.Visible = true;
                lblMes.Text = Session["username"].ToString();
            }
            if (Session["Admin"] != null)
            {
                show.Visible = true;
                btnlogout.Visible = true;
                hide.Visible = false;
                user.Visible = true;
                lblMes.Visible = true;
                lblMes.Text = Session["Admin"].ToString();
            }
        }
        protected void btnlogout_Click(object sender, EventArgs e)
        {
            Session["username"] = null;
            Session["Admin"] = null;
            Response.Redirect("Default.aspx");
        }
    }
}