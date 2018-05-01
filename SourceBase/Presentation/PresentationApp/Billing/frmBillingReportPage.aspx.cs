﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Interface.Reports;
using Application.Presentation;

namespace IQCare.Web.Billing
{
    public partial class frmBillingReportPage : LogPage
    {
        /// <summary>
        /// The error flag
        /// </summary>
        bool isError = false;
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            string script = @"<script language=""JavaScript""> 
    cal = null;
    function calendarShown(sender, e) 
    { 
        sender._switchMode(""months"", true); 
        cal = sender;
         //Iterate every month Item and remove click event from it
       if (sender._monthsBody) 
       {
         for (var i = 0; i < sender._monthsBody.rows.length; i++) 
         {
             var row = sender._monthsBody.rows[i];
             for (var j = 0; j < row.cells.length; j++) 
             {
                 Sys.UI.DomEvent.addHandler(row.cells[j].firstChild,""click"",call);
             }
         }
     }
    }
    function call(eventElement)
        {
            var target = eventElement.target;
            switch (target.mode) {
            case ""month"":             
                cal._visibleDate = target.date;
                cal.set_selectedDate(target.date);
                cal._switchMonth(target.date);
                cal._blur.post(true);
                cal.raiseDateSelectionChanged();
                break;
            }
        }
</script>";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "calendarinMonths", script);
            if (!IsPostBack)
            {
                grdBillilingReports.DataSource = CustomConfig.ReportConfig.ReportConfigElements;
                grdBillilingReports.DataBind();
                loadReports();
                Session["CBillingReport"] = null;


            }
            Session["PatientId"] = null;

        }
        void showErrorMessage(ref Exception ex)
        {
            lblError.Text = "An error has occured within IQCARE during processing. Please contact the support team";
            this.isError = this.divError.Visible = true;
            //Application.Logger.EventLogger logger = new Application.Logger.EventLogger();
            //logger.LogError(ex);

        }
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.btnActionOK.Click += new EventHandler(btnActionOK_Click);

        }
        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_PreRender(object sender, EventArgs e)
        {

            //  ClientScript.RegisterStartupScript(this.GetType(), "calendarinMonths", script);
            divError.Visible = isError;

        }
        /// <summary>
        /// Handles the Click event of the btnActionOK control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        /// <exception cref="System.NotImplementedException"></exception>
        void btnActionOK_Click(object sender, EventArgs e)
        {
            if (textDateFrom.Text == "")
            {
                lblError.Text = "Start Date is required";
                this.isError = this.divError.Visible = true;
                this.isError = true;
            }
            if (isError) { parameterPopup.Hide(); return; }

            if (textDateTo.Text == "")
            {
                lblError.Text = "End Date is required";
                this.isError = this.divError.Visible = true;

            }
            if (isError) { parameterPopup.Hide(); return; }

            DateTime dateFrom = Convert.ToDateTime(textDateFrom.Text);
            DateTime dateTo = Convert.ToDateTime(textDateTo.Text);

            string reportCode = HReport_ID.Value;
            string reportName = HFileName.Value;

            //open the page here


            String theUrl = string.Format("{0}?RptCd={1}&RptNm={2}&sDt={3}&eDt={4}", "./frmBilling_Reports.aspx", reportCode, reportName, dateFrom, dateTo);

            Page.ClientScript.RegisterStartupScript(HttpContext.Current.GetType(), "onReportOpen", "openReportPage('" + theUrl + "');", true);
            // Response.Redirect(theUrl, false);

            //isError = true;
            //  lblError.Text = "To open the report viewer page";

        }



        /// <summary>
        /// Handles the RowCommand event of the grdBillilingReports control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="GridViewCommandEventArgs"/> instance containing the event data.</param>
        protected void grdBillilingReports_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Generate")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                GridViewRow row = (grdBillilingReports.Rows[index]);
                grdBillilingReports.SelectedIndex = index;

                HReport_ID.Value = grdBillilingReports.SelectedDataKey.Values[0].ToString();
                HFileName.Value = grdBillilingReports.SelectedDataKey.Values[1].ToString();
                textDateFrom.Text = textDateTo.Text = "";
                //int reportId = Convert.ToInt16(HReport_ID.Value);
                this.parameterPopup.Show();

            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            if (ddlReport.SelectedValue == "XX")
            {
                IQCareMsgBox.Show("BillingReport", this);
                return;
            }
            //string queryToExecute = ddlReport.SelectedValue;
            string queryToExecute;
            try
            {


                IReports theQBuilderReports = (IReports)ObjectFactory.CreateInstance("BusinessProcess.Reports.BReports, BusinessProcess.Reports");
                DataTable dtQuery = theQBuilderReports.GetQueryBuilderReportQuery(ddlReport.SelectedValue);
                if (dtQuery.Rows.Count == 0)
                {
                    base.Session.Remove("QBReport");
                    return;
                };
                DataRow dataRow = dtQuery.Rows[0];
                string tableName = dataRow["ReportName"].ToString().Trim().Replace(" ", string.Empty);
                queryToExecute = dataRow["ReportQuery"].ToString().Trim();
                Session["ReportName"] = dataRow["ReportName"].ToString().Trim();
                Session["ReportParameters"] = "";
                bool hasParameters = int.Parse(dataRow["HasParameters"].ToString()) > 0;

                if (hasParameters)
                {
                    DataTable dtParams = theQBuilderReports.GetQueryBuilderReportParameters(ddlReport.SelectedValue);
                    gridParameter.DataSource = dtParams;
                    gridParameter.DataBind();
                    queryString.Value = queryToExecute;
                    thetableName.Value = tableName;
                    parameterPopupCustomR.Show();
                    theQBuilderReports = null;
                    return;
                }

                GenerateReport(queryToExecute, tableName);
                theQBuilderReports = null;
                return;
            }
            catch (Exception ex)
            {
                showErrorMessage(ref ex);
            }


        }

        private void GenerateReport(string queryToExecute, string tableName)
        {
            IReports theQBuilderReports = (IReports)ObjectFactory.CreateInstance("BusinessProcess.Reports.BReports, BusinessProcess.Reports");

            DataTable theDT = theQBuilderReports.ReturnQueryResult(queryToExecute).Tables[0];
            theDT.TableName = tableName;

            if (theDT.Rows.Count == 0)
            {
                pnlNoData.Visible = true;
                btnExport.Visible = false;
                btnPrint.Visible = false;
            }
            else
            {
                pnlNoData.Visible = false;
                btnExport.Visible = true;
                btnPrint.Visible = true;
            }
            gridResult.DataSource = theDT;
            gridResult.DataBind();
            Session["CBillingReport"] = theDT;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {

            try
            {
                IQWebUtils Util = new IQWebUtils();
                Util.ExporttoExcel((DataTable)Session["CBillingReport"], Response);
            }
            catch (Exception ex)
            {

                showErrorMessage(ref ex);
            }
        }
        private void loadReports()
        {
            DataSet dataTest = new DataSet("QBReportList");
            dataTest.ReadXml(Server.MapPath("~\\XMLFiles\\QueryBuilderReports.con"));
            dataTest.AcceptChanges();
            var reportList = dataTest.Tables["QueryBuilderReports"].AsEnumerable()
                .Where(c => c["CategoryName"].ToString() == "Billing")
                 .Select(row =>
                     new
                     {
                         ReportID = row["ReportID"].ToString(),
                         Description = row["ReportDescription"].ToString()
                     }
                     ).Distinct().OrderBy(x => x.Description);//.ToList();
            ddlReport.Items.Clear();
            ddlReport.Items.Add(new ListItem("Select...", "XX"));
            foreach (var rep in reportList)
            {
                ddlReport.Items.Add(new ListItem(rep.Description, rep.ReportID));
            }
        }

        protected void btnActionOKCustomReport_Click(object sender, EventArgs e)
        {
            System.Text.StringBuilder sbParams = new System.Text.StringBuilder("<parameters>");
            String s = "";

            foreach (GridViewRow row in gridParameter.Rows)
            {
                sbParams.Append("<parameter>");
                TextBox t = row.FindControl("paramValue") as TextBox;
                string paramValue = t.Text.Trim();
                sbParams.Append("<value>" + paramValue + "</value>");
                string paramName = row.Cells[0].Text;
                sbParams.Append("<name>" + paramName + "</name>");
                string paramType = row.Cells[1].Text;
                sbParams.Append("<type>" + paramType + "</type>");
                sbParams.Append("</parameter>");
                s = String.Format("{0}{1}: {2}   ", s, paramName, paramValue);

                if (paramValue == string.Empty)
                {
                    lblErrorCR.Text = "From Date and To Date is required in [dd-MMM-yyyy] format";
                    this.isError = this.divErrorCR.Visible = true;
                    this.isError = true;
                }
                else
                {
                    try
                    {
                        DateTime dt = DateTime.Parse(paramValue);
                        paramValue = dt.ToString("dd-MMM-yyyy");
                    }
                    catch (Exception)
                    {

                        lblErrorCR.Text = "From Date and To Date should be in [dd-MMM-yyyy] format";
                        this.isError = this.divErrorCR.Visible = true;
                        this.isError = true;
                    }
                }
            }
            if (isError) { parameterPopupCustomR.Hide(); return; }

            Session["ReportParameters"] = s;
            sbParams.Append("</parameters>");
            IReports theQBuilderReports = (IReports)ObjectFactory.CreateInstance("BusinessProcess.Reports.BReports, BusinessProcess.Reports");

            DataTable theDT = theQBuilderReports.ReturnQueryResult(queryString.Value, sbParams.ToString()).Tables[0];
            theDT.TableName = thetableName.Value;

            if (theDT.Rows.Count == 0)
            {
                pnlNoData.Visible = true;
                btnExport.Visible = false;
                btnPrint.Visible = false;
            }
            else
            {
                pnlNoData.Visible = false;
                btnExport.Visible = true;
                btnPrint.Visible = true;
            }
            gridResult.DataSource = theDT;
            gridResult.DataBind();
            Session["CBillingReport"] = theDT;
            thetableName.Value = queryString.Value = "";
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            //  Response.Redirect("./frmCustomReportPrint.aspx", false);
        }

        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("../frmFacilityHome.aspx", false);
        }


    }
}