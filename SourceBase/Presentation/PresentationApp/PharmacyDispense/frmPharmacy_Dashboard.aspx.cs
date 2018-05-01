using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Interface.SCM;
using Application.Presentation;
using Application.Common;

namespace PresentationApp.PharmacyDispense
{
    public partial class frmPharmacy_Dashboard : System.Web.UI.Page
    {
        BindFunctions theBindManager = new BindFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            
            (Master.FindControl("pnlExtruder") as Panel).Visible = false;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("lblformname") as Label).Text = "Pharmacy Dashboard";
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("patientLevelMenu") as Menu).Visible = false;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("PharmacyDispensingMenu") as Menu).Visible = true;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("UserControl_Alerts1") as UserControl).Visible = false;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("PanelPatiInfo") as Panel).Visible = false;
            if (!IsPostBack)
            {
                BindCombo();
            }

            ISCMReport objPODetails = (ISCMReport)ObjectFactory.CreateInstance("BusinessProcess.SCM.BSCMReport, BusinessProcess.SCM");
            DataSet theDTPODetails = objPODetails.PharmacyDashBoard(Convert.ToInt32(ddlStore.SelectedValue));

            RadHtmlChart1.DataSource = theDTPODetails.Tables[0];
            RadHtmlChart1.DataBind();

            RadHtmlChart2.DataSource = theDTPODetails.Tables[1];
            RadHtmlChart2.DataBind();

            grdDrugsRunningOut.DataSource = theDTPODetails.Tables[2];
            grdDrugsRunningOut.DataBind();
            
        }

        private void BindCombo()
        {
            try
            {
                DataSet XMLDS = new DataSet();
                XMLDS.ReadXml(MapPath("..\\XMLFiles\\AllMasters.con"));

                DataView theDV = new DataView(XMLDS.Tables["Mst_Store"]);
                theDV.RowFilter = "(DeleteFlag =0 or DeleteFlag is null)";
                theDV.Sort = "Name ASC";
                DataTable theStoreDT = theDV.ToTable();
                theBindManager.BindCombo(ddlStore, theStoreDT, "Name", "Id");
            }
            catch (Exception err)
            {
                MsgBuilder theBuilder = new MsgBuilder();
                theBuilder.DataElements["MessageText"] = err.Message.ToString();
                IQCareMsgBox.Show("#C1", theBuilder, this);
            }

        }

    }
}