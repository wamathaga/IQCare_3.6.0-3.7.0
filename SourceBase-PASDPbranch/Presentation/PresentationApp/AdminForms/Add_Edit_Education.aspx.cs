using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Application.Common;
using Application.Presentation;
using Interface.Administration;

public partial class Add_Edit_Education : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //(Master.FindControl("lblheader") as Label).Text = "Customise List";
        //(Master.FindControl("lblMark") as Label).Visible = false;
        (Master.FindControl("levelOneNavigationUserControl1").FindControl("lblheader") as Label).Text = "Customise List";
        (Master.FindControl("levelOneNavigationUserControl1").FindControl("lblRoot") as Label).Visible = false;
        lblH3.Text = Request.QueryString["name"];
        
        if (lblH3.Text == "Add")
        {
            
           txtEducationName.ReadOnly = true;
        }
        else if (lblH3.Text == "Edit")
        {
            txtEducationName.Text = "Primary";
            ddEducation.SelectedItem.Text = "Active";
        }
        else
            lblH3.Text = "Add/Edit Education";
    }
}
