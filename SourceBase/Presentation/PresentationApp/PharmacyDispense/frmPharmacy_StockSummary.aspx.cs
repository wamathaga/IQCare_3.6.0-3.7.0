using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Application.Presentation;
using Application.Common;
using Interface.SCM;
using AjaxControlToolkit;
using System.IO;
using System.Drawing;

namespace PresentationApp.PharmacyDispense
{
    public partial class frmPharmacy_StockSummary : System.Web.UI.Page
    {
        BindFunctions theBindManager = new BindFunctions();

        protected void Page_Load(object sender, EventArgs e)
        {
            (Master.FindControl("pnlExtruder") as Panel).Visible = false;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("lblformname") as Label).Text = "Stock Summary";
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("patientLevelMenu") as Menu).Visible = false;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("PharmacyDispensingMenu") as Menu).Visible = true;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("UserControl_Alerts1") as UserControl).Visible = false;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("PanelPatiInfo") as Panel).Visible = false;

            if (txtSearch.Text == "")
            {
                hdCustID.Value = "0";
            }

            if (!IsPostBack)
            {
                BindCombo();
                dtFrom.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                dtTo.Text = DateTime.Now.ToString("dd-MMM-yyyy");
            }
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

        public class Drugs
        {
            protected int _DrugId;
            public int DrugId
            {
                get { return _DrugId; }
                set { _DrugId = value; }
            }

            protected int _avlqty;
            public int AvlQty
            {
                get { return _avlqty; }
                set { _avlqty = value; }
            }

            protected string _drugName;
            public string DrugName
            {
                get { return _drugName; }
                set { _drugName = value; }
            }


        }

        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> SearchBorrower(string prefixText, int count)
        {
            DataSet theDS = (DataSet)HttpContext.Current.Session["theStocks"];
            List<string> Drugsdetail = new List<string>();

            var drugs = from DataRow tmp in theDS.Tables[0].AsEnumerable()
                        where tmp["DrugName"].ToString().ToLower().Contains(prefixText.ToLower())
                        select tmp; // new { drugName = tmp["DrugName"].ToString(), drugID = tmp["Drug_pk"].ToString() };

            foreach (DataRow c in drugs)
            {
                Drugsdetail.Add(AutoCompleteExtender.CreateAutoCompleteItem(c[2].ToString(), c[1].ToString()));
            }


            return Drugsdetail;
        }




        private DataSet GetItems(int StoreId, int ItemsId, DateTime FromDate, DateTime ToDate)
        {
            ISCMReport objOpenStock = (ISCMReport)ObjectFactory.CreateInstance("BusinessProcess.SCM.BSCMReport,BusinessProcess.SCM");
            return objOpenStock.GetStockSummary(StoreId, ItemsId, FromDate, ToDate);
        }

        protected void ddlStore_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToInt32(ddlStore.SelectedValue) != 0)
                {


                    Session["theStocks"] = GetItems(Convert.ToInt32(ddlStore.SelectedValue), Convert.ToInt32(hdCustID.Value), Convert.ToDateTime(dtFrom.Text), Convert.ToDateTime(dtTo.Text));

                    DataSet stockSummary = (DataSet)Session["theStocks"];

                    DataView theDV = new DataView(stockSummary.Tables[1]);
                    if (hdCustID.Value != "0")
                        theDV.RowFilter = "ItemId = " + hdCustID.Value;
                    //DataTable theDT = theDV.ToTable();

                    populateGrid(theDV.ToTable());
                    //grdStockSummary.DataSource = theDV.ToTable();
                    //grdStockSummary.DataBind();

                }
                else
                {
                    //txtItemName.Text = "";
                    grdStockSummary.Columns.Clear();
                    grdStockSummary.DataSource = null;
                }

            }
            catch (Exception err)
            {
                MsgBuilder theBuilder = new MsgBuilder();
                theBuilder.DataElements["MessageText"] = err.Message.ToString();
                IQCareMsgBox.Show("#C1", theBuilder, this);
                //IQCareWindowMsgBox.ShowWindowConfirm("#C1", theBuilder, this);
            }
        }

        protected void populateGrid(DataTable theDT)
        {
            grdStockSummary.DataSource = theDT;
            grdStockSummary.DataBind();
            Session["populateGrid"] = theDT;
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Session["theStocks"] = GetItems(Convert.ToInt32(ddlStore.SelectedValue), Convert.ToInt32(hdCustID.Value), Convert.ToDateTime(dtFrom.Text), Convert.ToDateTime(dtTo.Text));
            DataSet stockSummary = (DataSet)Session["theStocks"];
            DataView theDV = new DataView(stockSummary.Tables[1]);
            if (hdCustID.Value != "0")
                theDV.RowFilter = "ItemId = " + hdCustID.Value;
            //DataTable theDT = theDV.ToTable();

            populateGrid(theDV.ToTable());
            //grdStockSummary.DataSource = theDV.ToTable(); // stockSummary.Tables[1].Select("ItemId=" + hdCustID.Value);
            //grdStockSummary.DataBind();
        }

        protected void grdStockSummary_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
            int storeid = Convert.ToInt32(ddlStore.SelectedValue.ToString());
            int index = Convert.ToInt32(e.CommandArgument.ToString());
            grdStockSummary.SelectedIndex = index;
            int itemid =  Convert.ToInt32(grdStockSummary.SelectedDataKey["ItemId"].ToString());
            DateTime dateFrom = Convert.ToDateTime(Convert.ToDateTime(dtFrom.Text).ToString("yyyy-MM-dd"));
            DateTime dateTo = Convert.ToDateTime(Convert.ToDateTime(dtTo.Text).ToString("yyyy-MM-dd"));

            //Iframe1.Visible = true;
            //Iframe1.Attributes.Add("src","BinCard.aspx?storeid=" + storeid.ToString() + "&itemid=" + itemid.ToString() + "&dtFrom=" + dateFrom.ToString()
            //    + "&dtTo=" + dateTo.ToString());

            //Page.ClientScript.RegisterStartupScript(this.GetType(), "reloadIframe", "var iframe = document.getElementById('ctl00_IQCareContentPlaceHolder_Iframe1'); iframe.src = iframe.src;", true);

            //binCard_ModalPopupExtender.Show();

            IQCareUtils.Redirect("BinCard.aspx?storeid=" + storeid.ToString() + "&itemid=" + itemid.ToString() + "&dtFrom=" + dateFrom.ToString()
                + "&dtTo=" + dateTo.ToString(), "_blank", "toolbars=no,location=no,directories=no,dependent=yes,top=100,left=30,maximize=no,resize=no,width=1000,height=800,scrollbars=yes");
            //Response.Redirect("BinCard.aspx?storeid=" + storeid.ToString() + "&itemid=" + itemid.ToString() + "&dtFrom=" + dateFrom.ToString()
            //    + "&dtTo=" + dateTo.ToString() + "");

            
            
            
        }

        protected void btnExportToExcel_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=BIN_Card.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                //grdStockSummary.AllowPaging = false;
                populateGrid((DataTable)Session["populateGrid"]);

                grdStockSummary.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in grdStockSummary.HeaderRow.Cells)
                {
                    cell.BackColor = grdStockSummary.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in grdStockSummary.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            //cell.BackColor = grdStockSummary.AlternatingRowStyle.BackColor;
                            cell.BackColor = ColorTranslator.FromHtml("#CCCCFF");
                        }
                        else
                        {
                            cell.BackColor = grdStockSummary.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                grdStockSummary.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        



        
    }
}