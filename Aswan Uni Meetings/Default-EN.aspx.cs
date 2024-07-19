using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aswan_Uni_Meetings
{
    public partial class Default_EN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ChBLang.Checked = true;
        }

        protected void btnLog_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login-EN");
        }

        protected void btnPortal_Click(object sender, EventArgs e)
        {
            Response.Redirect("http://193.227.33.15");
        }

        protected void ChBLang_CheckedChanged(object sender, EventArgs e)
        {
            Response.Redirect("Default");
        }
    }
}