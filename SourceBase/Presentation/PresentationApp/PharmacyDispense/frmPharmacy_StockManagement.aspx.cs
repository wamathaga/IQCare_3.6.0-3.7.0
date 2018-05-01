using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Application.Common;
using Application.Presentation;
using AjaxControlToolkit;
using Interface.SCM;
using System.Text;

namespace PresentationApp.PharmacyDispense
{
    public partial class frmPharmacy_StockManagement : LogPage
    {
        BindFunctions theBindManager = new BindFunctions();
        IDrug stockMgtManager;
        DataSet dsOpenStock;
        static string tranactionType;
        StringBuilder batches = new StringBuilder();

        protected void Page_Load(object sender, EventArgs e)
        {
            stockMgtManager = (IDrug)ObjectFactory.CreateInstance("BusinessProcess.SCM.BDrug, BusinessProcess.SCM");
            (Master.FindControl("pnlExtruder") as Panel).Visible = false;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("lblformname") as Label).Text = "Stock Management";
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("patientLevelMenu") as Menu).Visible = false;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("PharmacyDispensingMenu") as Menu).Visible = true;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("UserControl_Alerts1") as UserControl).Visible = false;
            (Master.FindControl("levelTwoNavigationUserControl1").FindControl("PanelPatiInfo") as Panel).Visible = false;

            if (!IsPostBack)
            {
                BindCombo();

                addAttributes();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "showHide", "showHideTransactionType('" + ddlTransactionType.ClientID + "');", true);

            userRights();
        }

        private void userRights()
        {
            /***************** Check For User Rights ****************/
            AuthenticationManager Authentiaction = new AuthenticationManager();
            //btnPrint.Enabled = Authentiaction.HasFunctionRight(ApplicationAccess.AdultPharmacy, FunctionAccess.Print, (DataTable)Session["UserRight"]);


            if (Convert.ToInt32(Session["PatientVisitId"]) == 0)
            {
                btnSubmit.Enabled = Authentiaction.HasFunctionRight(ApplicationAccess.StockManagement, FunctionAccess.Add, (DataTable)Session["UserRight"]);

            }
            else if (Convert.ToInt32(Session["PatientVisitId"]) != 0)
            {
                if (Authentiaction.HasFunctionRight(ApplicationAccess.StockManagement, FunctionAccess.View, (DataTable)Session["UserRight"]) == false)
                {
                    if (Convert.ToInt32(Session["TechnicalAreaId"]) != 206)
                    {
                        string theUrl = "";
                        theUrl = string.Format("{0}", "../ClinicalForms/frmPatient_History.aspx");
                        Response.Redirect(theUrl);
                    }
                }

                btnSubmit.Enabled = Authentiaction.HasFunctionRight(ApplicationAccess.StockManagement, FunctionAccess.Update, (DataTable)Session["UserRight"]);

            }
        }

        private void addAttributes()
        {
            ddlTransactionType.Attributes.Add("OnChange", "showHideTransactionType('" + ddlTransactionType.ClientID + "');");
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
                theBindManager.BindCombo(ddlDestinationStore, theStoreDT, "Name", "Id");
                theBindManager.BindCombo(ddlSourceStore, theStoreDT, "Name", "Id");
            }
            catch (Exception err)
            {
                MsgBuilder theBuilder = new MsgBuilder();
                theBuilder.DataElements["MessageText"] = err.Message.ToString();
                IQCareMsgBox.Show("#C1", theBuilder, this);
            }

        }

        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> SearchDrugs(string prefixText, int count)
        {
            DataTable theDT = (DataTable)HttpContext.Current.Session["theStocks"];
            List<string> Drugsdetail = new List<string>();

            var drugs = from DataRow tmp in theDT.AsEnumerable()
                        where tmp["DrugName"].ToString().ToLower().Contains(prefixText.ToLower())
                        select tmp; // new { drugName = tmp["DrugName"].ToString(), drugID = tmp["Drug_pk"].ToString() };

            foreach (DataRow c in drugs)
            {
                if (tranactionType == "Opening Stock")
                {
                    Drugsdetail.Add(AutoCompleteExtender.CreateAutoCompleteItem(c["drugname"].ToString(), c["drug_pk"].ToString()));
                }
                else
                {
                    //StringBuilder test = new StringBuilder();
                    //test.Append(c["drugname"].ToString()).Append("\t").Append(c["BatchNo"].ToString()).Append("\t").Append(c["AvailQty"].ToString()).Append("\t").Append(c["ExpiryDate"].ToString());
                    //Drugsdetail.Add(AutoCompleteExtender.CreateAutoCompleteItem(test.ToString(), c["drug_pk"].ToString() + "," + c["BatchNo"].ToString()));
                    //Drugsdetail.Add(AutoCompleteExtender.CreateAutoCompleteItem(c["drugname"].ToString() + "  -------  " + c["BatchNo"].ToString() + "  -------  " + c["AvailQty"].ToString() + "  -------  " + c["ExpiryDate"].ToString(), c["drug_pk"].ToString() + "," + c["BatchNo"].ToString()));
                    Drugsdetail.Add(AutoCompleteExtender.CreateAutoCompleteItem(c["drugname"].ToString() , c["drug_pk"].ToString() + "," + c["BatchNo"].ToString()));
                }
            }


            return Drugsdetail;
        }

        protected void ddlSourceStore_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (Convert.ToInt32(ddlSourceStore.SelectedValue) != 0)
                {
                    if (ddlTransactionType.SelectedItem.Text == "Opening Stock")
                    {
                        Session["theStocks"] = GetItems_OpeningStock();
                        txtDrug.Enabled = true;
                    }
                    else
                    {
                        Session["theStocks"] = GetItems(Convert.ToInt32(ddlSourceStore.SelectedValue));
                        txtDrug.Enabled = true;
                    }
                }
                else
                {
                    //txtItemName.Text = "";
                    grdStockMngt.Columns.Clear();
                    grdStockMngt.DataSource = null;
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

        private DataTable GetItems(int StoreId)
        {
            ISCMReport objOpenStock = (ISCMReport)ObjectFactory.CreateInstance("BusinessProcess.SCM.BSCMReport,BusinessProcess.SCM");
            return objOpenStock.GetStocksPerStore(StoreId);


        }

        private DataTable GetItems_OpeningStock()
        {
            //IMasterList objOpenStock = (IMasterList)ObjectFactory.CreateInstance("BusinessProcess.SCM.BMasterList,BusinessProcess.SCM");
            IPurchase objOpenStock = (IPurchase)ObjectFactory.CreateInstance("BusinessProcess.SCM.BPurchase,BusinessProcess.SCM");
            dsOpenStock = objOpenStock.GetOpenStockWeb();

            DataView theDV = new DataView(dsOpenStock.Tables[0]);
            theDV.RowFilter = "StoreID='" + Convert.ToInt32(ddlSourceStore.SelectedValue.ToString()) + "'";
            //DataTable theDT = theDV.ToTable();

            //Session["ExistingBatches"] = dsOpenStock.Tables[1];

            DataTable batcheDT = dsOpenStock.Tables[1];
            if (batcheDT.Rows.Count > 0)
            {
                for (int i = 0; i < batcheDT.Rows.Count; i++)
                {
                    batches.Append(batcheDT.Rows[i]["Name"].ToString().ToLower());
                    batches.Append(",");
                }
                ViewState["batches"] = batches;
            }

            DataView theDVOS = new DataView(dsOpenStock.Tables[2]);
            theDVOS.RowFilter = "StoreID='" + Convert.ToInt32(ddlSourceStore.SelectedValue.ToString()) + "'";
            ViewState["ExistingOpeningStocks"] = theDVOS.ToTable();

            return theDV.ToTable();
        }


        protected void grdStockMngt_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //string item = e.Row.Cells[0].Text;
                
                //TextBox txtQuantity = (TextBox)e.Row.FindControl("txtQuantity");
                //txtQuantity.Attributes.Add("onkeyup", "chkNumeric('" + txtQuantity.ClientID + "')");

                DataRowView row = (e.Row.DataItem as DataRowView);
                foreach (ImageButton button in e.Row.Cells[7].Controls.OfType<ImageButton>())
                {
                    if (button.CommandName == "Delete")
                    {
                        button.Attributes["onclick"] = "if(!confirm('Do you want to delete " + row["DrugName"].ToString() + "?')) { return false; };";
                    }
                }
                foreach (TextBox txt in e.Row.Cells[2].Controls.OfType<TextBox>())
                {
                    TextBox txtBatchNo = (TextBox)e.Row.FindControl("txtBatchNo");

                    txt.Attributes["onBlur"] = "DuplicateBatchNo(this.value,'" + ViewState["batches"] + "','" + txtBatchNo.ClientID + "');";
                    
                }
                RangeValidator rng = e.Row.FindControl("qtyRangeValidator") as RangeValidator;
                if (rng != null)
                {
                    if (ddlTransactionType.SelectedItem.Text == "Receive")
                    {
                        rng.MaximumValue = row["AvailQty"].ToString();
                        rng.Enabled = true;
                    }
                }
            }

            if (ddlTransactionType.SelectedItem.Text == "Opening Stock")
            {
                e.Row.Cells[4].Visible = false;
                e.Row.Cells[6].Visible = false;

                RequiredFieldValidator batchNoRequired = e.Row.FindControl("BatchNoRequiredFieldValidator") as RequiredFieldValidator;
                if (batchNoRequired != null)
                {
                    batchNoRequired.Enabled = true;
                }  
            }

            
        }
        private Boolean FieldValidation()
        {
            if (ddlTransactionType.SelectedValue == "0")
            {
                MsgBuilder theBuilder = new MsgBuilder();
                EventArgs e = new EventArgs();
                theBuilder.DataElements["Control"] = "Transaction Type";
                IQCareMsgBox.Show("BlankDropDown", theBuilder, this);
                ddlTransactionType.Focus();
                return false;
            }
            else if (txtTransactionDate.Text == "")
            {
                MsgBuilder theBuilder = new MsgBuilder();
                EventArgs e = new EventArgs();
                theBuilder.DataElements["Control"] = "Transaction Date";
                IQCareMsgBox.Show("BlankTextBox", theBuilder, this);
                txtTransactionDate.Focus();
                return false;
            }
            else if (ddlSourceStore.SelectedValue == "0")
            {
                MsgBuilder theBuilder = new MsgBuilder();
                EventArgs e = new EventArgs();
                theBuilder.DataElements["Control"] = "Source Store";
                IQCareMsgBox.Show("BlankDropDown", theBuilder, this);
                ddlSourceStore.Focus();
                return false;
            }
            else if (ddlDestinationStore.SelectedValue == "0" && ddlTransactionType.SelectedItem.Text == "Receive")
            {
                MsgBuilder theBuilder = new MsgBuilder();
                EventArgs e = new EventArgs();
                theBuilder.DataElements["Control"] = "Destination Store";
                IQCareMsgBox.Show("BlankDropDown", theBuilder, this);
                ddlDestinationStore.Focus();
                return false;
            }
            IQCareMsgBox.HideMessage(this);
            return true;
        }
        protected string ShowTextBox()
        {
            if (ddlTransactionType.SelectedItem.Text == "Opening Stock")
            {
                return "";
            }
            return "none";
        }
        protected string ShowLabel()
        {
            if (ddlTransactionType.SelectedItem.Text == "Opening Stock")
            {
                return "none";
            }
            return "";
        }
        protected void txtDrug_TextChanged(object sender, EventArgs e)
        {
            DataView theDV = new DataView((DataTable)Session["theStocks"]);

            if (hdCustID.Value != "")
            {
                if (ddlTransactionType.SelectedItem.Text == "Opening Stock")
                {
                    string[] details = hdCustID.Value.Split(',');
                    theDV.RowFilter = "Drug_Pk = " + details[0].ToString();
                }
                else
                {

                    string[] details = hdCustID.Value.Split(',');
                    theDV.RowFilter = "Drug_Pk = " + details[0].ToString() + " and BatchNo = '" + details[1].ToString() + "'";
                }

                if(theDV.ToTable().Rows.Count > 0)
                    PopulateGrid(theDV.ToTable().Rows[0]);
            }

            txtDrug.Text = "";
        }

        private void PopulateGrid(DataRow SelectedDrug)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("Drug_pk", typeof(int)));
            dt.Columns.Add(new DataColumn("DrugName", typeof(string)));
            dt.Columns.Add(new DataColumn("BatchNo", typeof(string)));
            dt.Columns.Add(new DataColumn("ExpiryDate", typeof(string)));
            dt.Columns.Add(new DataColumn("Unit", typeof(string)));
            dt.Columns.Add(new DataColumn("AvailQty", typeof(int)));
            dt.Columns.Add(new DataColumn("Quantity", typeof(string)));
            dt.Columns.Add(new DataColumn("Comments", typeof(string)));
            dt.Columns.Add(new DataColumn("BatchID", typeof(int)));
            dt.Columns.Add(new DataColumn("PurchaseUnitPrice", typeof(double)));
            dt.Columns.Add(new DataColumn("QtyPerPurchaseUnit", typeof(int)));
            
            DataRow dr;
            
            //Add existing data to data table
            foreach (GridViewRow gvRow in grdStockMngt.Rows)
            {
                int DrugID = Convert.ToInt32(grdStockMngt.DataKeys[gvRow.RowIndex].Value);
                Label lblDrugName = (Label)gvRow.FindControl("lblDrugName");
                Label lblUnit = (Label)gvRow.FindControl("lblUnit");
                Label lblBatchNo = (Label)gvRow.FindControl("lblBatchNo");
                Label lblExpiryDate = (Label)gvRow.FindControl("lblExpiryDate");
                TextBox txtBatchNo = (TextBox)gvRow.FindControl("txtBatchNo");
                TextBox txtExpiryDate = (TextBox)gvRow.FindControl("txtExpiryDate");
                Label lblAvailQty = (Label)gvRow.FindControl("lblAvailQty");
                TextBox txtQty = (TextBox)gvRow.FindControl("txtQuantity");
                TextBox txtComments = (TextBox)gvRow.FindControl("txtComments");
                Label lblBatchID = (Label)gvRow.FindControl("lblBatchID");
                Label lblPurchaseUnitPrice = (Label)gvRow.FindControl("lblPurchaseUnitPrice");
                Label lblQtyPerPurchaseUnit = (Label)gvRow.FindControl("lblQtyPerPurchaseUnit");
                

                dr = dt.NewRow();
                dr["Drug_pk"] = DrugID;
                dr["DrugName"] = lblDrugName.Text;
                dr["Unit"] = lblUnit.Text;

                if (ddlTransactionType.SelectedItem.Text == "Opening Stock")
                {
                    dr["BatchNo"] = txtBatchNo.Text;
                    dr["ExpiryDate"] = txtExpiryDate.Text;
                }
                else
                {
                    dr["BatchNo"] = lblBatchNo.Text;
                    dr["ExpiryDate"] = lblExpiryDate.Text;
                }
                dr["AvailQty"] = lblAvailQty.Text;
                dr["Quantity"] = txtQty.Text;
                dr["Comments"] = txtComments.Text;
                dr["BatchID"] = lblBatchID.Text;
                dr["PurchaseUnitPrice"] = lblPurchaseUnitPrice.Text;
                dr["QtyPerPurchaseUnit"] = lblQtyPerPurchaseUnit.Text;
                dt.Rows.Add(dr);
            }

            //Add the new data to datatable
            int OpeningStockExists = 0;
            if (ddlTransactionType.SelectedItem.Text == "Opening Stock")
            {
                DataView theDV = new DataView((DataTable)ViewState["ExistingOpeningStocks"]);
                theDV.RowFilter = "ItemID = " + SelectedDrug["Drug_pk"].ToString();

                if (theDV.ToTable().Rows.Count > 0)
                {
                    OpeningStockExists = 1;
                }
            }

            if (OpeningStockExists == 0)
            {
                DataRow[] result;
                if (ddlTransactionType.SelectedItem.Text == "Opening Stock")
                {
                    result = dt.Select("Drug_pk = " + SelectedDrug["Drug_pk"].ToString());
                }
                else
                {
                    result = dt.Select("Drug_pk = " + SelectedDrug["Drug_pk"].ToString() + " and BatchID = " + SelectedDrug["BatchID"].ToString());
                }

                if (result.Length == 0)
                {
                    dr = dt.NewRow();
                    dr["Drug_pk"] = SelectedDrug["Drug_pk"].ToString();
                    dr["DrugName"] = SelectedDrug["DrugName"].ToString();
                    dr["BatchNo"] = SelectedDrug["BatchNo"].ToString();
                    dr["ExpiryDate"] = SelectedDrug["ExpiryDate"].ToString();
                    dr["Unit"] = SelectedDrug["Unit"].ToString();
                    dr["AvailQty"] = SelectedDrug["AvailQty"].ToString();
                    dr["BatchID"] = SelectedDrug["BatchID"].ToString();
                    dr["PurchaseUnitPrice"] = SelectedDrug["PurchaseUnitPrice"].ToString();
                    dr["QtyPerPurchaseUnit"] = SelectedDrug["QtyPerPurchaseUnit"].ToString();

                    dt.Rows.Add(dr);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "DuplicateRecord", "NotifyMessage('Record already added to grid.');", true);
                    //Page.ClientScript.RegisterStartupScript(this.GetType(), "DuplicateRecord", "alert('Record already added.');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "OpeningStockExist", "NotifyMessage('Opening stock for " + SelectedDrug["DrugName"].ToString() + " exists.');", true);
            }
            

            //Populate grid
            ViewState["dt"] = dt;
            populateGrid();
        }

        protected void grdStockMngt_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int index = Convert.ToInt32(e.RowIndex);
            DataTable dt = ViewState["dt"] as DataTable;
            dt.Rows[index].Delete();
            ViewState["dt"] = dt;

            populateGrid();

        }

        protected void populateGrid()
        {
            grdStockMngt.DataSource = ViewState["dt"] as DataTable;
            grdStockMngt.DataBind();
            //UpdatePanel2.Update();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (FieldValidation())
                {
                    if (ddlTransactionType.SelectedItem.Text == "Receive")
                    {
                        Boolean IsPOUpdated = false;

                        DataTable dtOrdermaster = CreateOrderMasterTable();
                        DataRow drOM = dtOrdermaster.NewRow();
                        //drOM["IsPO"] = Convert.ToInt32("10");
                        drOM["POID"] = Convert.ToInt32("10");
                        drOM["OrderDate"] = txtTransactionDate.Text;
                        //drOM["SupplierID"] = Convert.ToInt32("10");
                        drOM["SrcStore"] = ddlSourceStore.SelectedValue;
                        drOM["DestStore"] = ddlDestinationStore.SelectedValue;
                        drOM["UserID"] = Session["AppUserID"].ToString();
                        drOM["PreparedBy"] = Session["AppUserID"].ToString();
                        drOM["AthorizedBy"] = Session["AppUserID"].ToString();
                        drOM["LocationID"] = Session["AppLocationId"].ToString();
                        drOM["IsRejectedStatus"] = Convert.ToInt32("0");
                        dtOrdermaster.Rows.Add(drOM);


                        DataTable dtOrderItem = CreateOrderItemTable();
                        DataRow drOI;

                        foreach (GridViewRow gvRow in grdStockMngt.Rows)
                        {
                            int DrugID = Convert.ToInt32(grdStockMngt.DataKeys[gvRow.RowIndex].Value);
                            Label lblDrugName = (Label)gvRow.FindControl("lblDrugName");
                            //Label lblUnit = (Label)gvRow.FindControl("lblUnit");
                            Label lblBatchID = (Label)gvRow.FindControl("lblBatchID");
                            Label lblExpiryDate = (Label)gvRow.FindControl("lblExpiryDate");
                            Label lblAvailQty = (Label)gvRow.FindControl("lblAvailQty");
                            TextBox txtQty = (TextBox)gvRow.FindControl("txtQuantity");
                            //TextBox txtComments = (TextBox)gvRow.FindControl("txtComments");
                            Label lblPurchaseUnitPrice = (Label)gvRow.FindControl("lblPurchaseUnitPrice");
                            Label lblQtyPerPurchaseUnit = (Label)gvRow.FindControl("lblQtyPerPurchaseUnit");

                            drOI = dtOrderItem.NewRow();
                            drOI["ItemID"] = DrugID;
                            drOI["ItemName"] = lblDrugName.Text;
                            //drOI["PurchaseUnit"] = 1;// lblUnit.Text;
                            drOI["Quantity"] = txtQty.Text;
                            drOI["priceperunit"] = lblPurchaseUnitPrice.Text;
                            //drOI["totPrice"] = "200";
                            drOI["BatchID"] = lblBatchID.Text;
                            drOI["AvaliableQty"] = lblAvailQty.Text;
                            drOI["ExpiryDate"] = lblExpiryDate.Text;
                            drOI["UnitQuantity"] = lblQtyPerPurchaseUnit.Text;
                            dtOrderItem.Rows.Add(drOI);
                        }


                        //request
                        IPurchase objMasterlist = (IPurchase)ObjectFactory.CreateInstance("BusinessProcess.SCM.BPurchase,BusinessProcess.SCM");
                        int POID = objMasterlist.SavePurchaseOrderWeb(dtOrdermaster, dtOrderItem, IsPOUpdated);

                        //issue
                        //IPurchase objMasterlist = (IPurchase)ObjectFactory.CreateInstance("BusinessProcess.SCM.BPurchase,BusinessProcess.SCM");
                        DataTable dtGRNmaster = CreateGRNMasterTable();
                        DataRow theDRow = dtGRNmaster.NewRow();
                        theDRow["POID"] = POID;
                        theDRow["GRNId"] = 0;
                        theDRow["LocationID"] = Session["AppLocationId"].ToString();
                        theDRow["OrderDate"] = txtTransactionDate.Text;
                        theDRow["DestinStoreID"] = Convert.ToInt32(ddlDestinationStore.SelectedValue);
                        theDRow["SupplierID"] = 0;

                        theDRow["UserID"] = Session["AppUserID"].ToString();
                        theDRow["OrderNo"] = txtOrderNumber.Text;
                        theDRow["Freight"] = 0; // (Convert.ToString(txtFreight.Text) == "") ? 0 : Convert.ToDecimal(txtFreight.Text);
                        theDRow["Tax"] = 0; // (Convert.ToString(txtTax.Text) == "") ? 0 : Convert.ToDecimal(txtTax.Text);
                        dtGRNmaster.Rows.Add(theDRow);

                        DataTable dtGRNItem = CreateGRNItemTable();
                        DataRow drGRNI;

                        foreach (GridViewRow gvRow in grdStockMngt.Rows)
                        {
                            int DrugID = Convert.ToInt32(grdStockMngt.DataKeys[gvRow.RowIndex].Value);
                            Label lblDrugName = (Label)gvRow.FindControl("lblDrugName");
                            //Label lblUnit = (Label)gvRow.FindControl("lblUnit");
                            Label lblBatchID = (Label)gvRow.FindControl("lblBatchID");
                            Label lblExpiryDate = (Label)gvRow.FindControl("lblExpiryDate");
                            Label lblAvailQty = (Label)gvRow.FindControl("lblAvailQty");
                            TextBox txtQty = (TextBox)gvRow.FindControl("txtQuantity");
                            //TextBox txtComments = (TextBox)gvRow.FindControl("txtComments");
                            Label lblPurchaseUnitPrice = (Label)gvRow.FindControl("lblPurchaseUnitPrice");
                            Label lblQtyPerPurchaseUnit = (Label)gvRow.FindControl("lblQtyPerPurchaseUnit");
                            TextBox txtComments = (TextBox)gvRow.FindControl("txtComments");

                            drGRNI = dtGRNItem.NewRow();
                            drGRNI["ItemID"] = DrugID;
                            drGRNI["POId"] = POID;
                            //drGRNI["ItemName"] = lblDrugName.Text;
                            //drOI["PurchaseUnit"] = 1;// lblUnit.Text;
                            drGRNI["RecievedQuantity"] = txtQty.Text;
                            drGRNI["QtyPerPurchaseUnit"] = lblPurchaseUnitPrice.Text;
                            //drOI["totPrice"] = "200";
                            drGRNI["BatchID"] = lblBatchID.Text;
                            //drGRNI["AvaliableQty"] = lblAvailQty.Text;
                            drGRNI["ExpiryDate"] = lblExpiryDate.Text;
                            //drGRNI["UnitQuantity"] = lblQtyPerPurchaseUnit.Text;
                            drGRNI["SourceStoreID"] = ddlSourceStore.SelectedValue;
                            drGRNI["DestinStoreID"] = ddlDestinationStore.SelectedValue;
                            drGRNI["Comments"] = txtComments.Text;
                            dtGRNItem.Rows.Add(drGRNI);
                        }


                        int issue = objMasterlist.SaveGoodreceivedNotes_Web(dtGRNmaster, dtGRNItem, 2);
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertInterStoreTransfer", "alert('Saved Successfully.');", true);
                        IQCareMsgBox.NotifyAction("Saved successfully.", "Stock Management", false, this, "");
                        clearFields();
                        //btnSubmit.Enabled = false;
                    }
                    else if (ddlTransactionType.SelectedItem.Text == "Adjustment")
                    {
                        DataTable dtAdjustStocks = CreateAdjustStockTable();
                        DataRow drAS;

                        foreach (GridViewRow gvRow in grdStockMngt.Rows)
                        {
                            int DrugID = Convert.ToInt32(grdStockMngt.DataKeys[gvRow.RowIndex].Value);
                            Label lblDrugName = (Label)gvRow.FindControl("lblDrugName");
                            //Label lblUnit = (Label)gvRow.FindControl("lblUnit");
                            Label lblBatchID = (Label)gvRow.FindControl("lblBatchID");
                            Label lblExpiryDate = (Label)gvRow.FindControl("lblExpiryDate");
                            Label lblAvailQty = (Label)gvRow.FindControl("lblAvailQty");
                            TextBox txtQty = (TextBox)gvRow.FindControl("txtQuantity");
                            //TextBox txtComments = (TextBox)gvRow.FindControl("txtComments");
                            Label lblPurchaseUnitPrice = (Label)gvRow.FindControl("lblPurchaseUnitPrice");
                            Label lblQtyPerPurchaseUnit = (Label)gvRow.FindControl("lblQtyPerPurchaseUnit");
                            TextBox txtComments = (TextBox)gvRow.FindControl("txtComments");

                            drAS = dtAdjustStocks.NewRow();
                            drAS["ItemID"] = DrugID;
                            drAS["BatchID"] = lblBatchID.Text;
                            drAS["ExpiryDate"] = lblExpiryDate.Text;
                            drAS["StoreID"] = ddlSourceStore.SelectedValue;
                            drAS["AdjQty"] = txtQty.Text;
                            drAS["Comments"] = txtComments.Text;
                            dtAdjustStocks.Rows.Add(drAS);
                        }
                        IPurchase objStock = (IPurchase)ObjectFactory.CreateInstance("BusinessProcess.SCM.BPurchase,BusinessProcess.SCM");
                        int ret = objStock.SaveUpdateStockAdjustmentWeb(dtAdjustStocks, Convert.ToInt32(Session["AppLocationId"].ToString()), Convert.ToInt32(ddlSourceStore.SelectedValue), txtTransactionDate.Text, Convert.ToInt32(Session["AppUserID"].ToString()), Convert.ToInt32(Session["AppUserID"].ToString()), 1, Convert.ToInt32(Session["AppUserID"].ToString()));
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertAdjustment", "alert('Saved Successfully.');", true);
                        IQCareMsgBox.NotifyAction("Saved successfully.", "Stock Management", false, this, "");
                        //btnSubmit.Enabled = false;
                        clearFields();
                    }
                    else if (ddlTransactionType.SelectedItem.Text == "Opening Stock")
                    {
                        DataTable dtOpeningStocks = CreateOpeningStockTable();
                        DataRow drOS;

                        foreach (GridViewRow gvRow in grdStockMngt.Rows)
                        {
                            int DrugID = Convert.ToInt32(grdStockMngt.DataKeys[gvRow.RowIndex].Value);
                            //Label lblDrugName = (Label)gvRow.FindControl("lblDrugName");
                            //Label lblUnit = (Label)gvRow.FindControl("lblUnit");
                            TextBox txtBatchNo = (TextBox)gvRow.FindControl("txtBatchNo");
                            TextBox txtExpiryDate = (TextBox)gvRow.FindControl("txtExpiryDate");
                            //Label lblAvailQty = (Label)gvRow.FindControl("lblAvailQty");
                            TextBox txtQty = (TextBox)gvRow.FindControl("txtQuantity");
                            //TextBox txtComments = (TextBox)gvRow.FindControl("txtComments");
                            //Label lblPurchaseUnitPrice = (Label)gvRow.FindControl("lblPurchaseUnitPrice");
                            //Label lblQtyPerPurchaseUnit = (Label)gvRow.FindControl("lblQtyPerPurchaseUnit");
                            if (txtExpiryDate.Text != "")
                            {
                                TimeSpan difference = Convert.ToDateTime(txtExpiryDate.Text) - Convert.ToDateTime(Application["AppCurrentDate"]);
                                double days = difference.TotalDays;
                                if (days <= 0)
                                {
                                    MsgBuilder theBuilder = new MsgBuilder();
                                    theBuilder.DataElements["MessageText"] = "Expiry Date must be greater than todays date";
                                    IQCareMsgBox.Show("#C1", theBuilder, this);
                                    txtExpiryDate.Focus();
                                    return;
                                }
                            }
                            drOS = dtOpeningStocks.NewRow();
                            drOS["ItemID"] = DrugID;
                            drOS["BatchNo"] = txtBatchNo.Text;
                            drOS["ExpiryDate"] = Convert.ToDateTime(txtExpiryDate.Text).ToString("dd-MMM-yyyy");
                            drOS["StoreID"] = ddlSourceStore.SelectedValue;
                            drOS["Quantity"] = txtQty.Text;
                            //drOS["Comments"] = txtComments.Text;

                            dtOpeningStocks.Rows.Add(drOS);
                        }
                        IPurchase objStock = (IPurchase)ObjectFactory.CreateInstance("BusinessProcess.SCM.BPurchase,BusinessProcess.SCM");
                        int ret = objStock.SaveUpdateOpeningStockWeb(dtOpeningStocks, Convert.ToInt32(Session["AppUserID"].ToString()), txtTransactionDate.Text);
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertOpeningStock", "alert('Saved Successfully.');", true);
                        IQCareMsgBox.NotifyAction("Saved successfully.", "Stock Management", false, this, "");
                        //btnSubmit.Enabled = false;
                        clearFields();
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }

        protected void clearFields()
        {
            grdStockMngt.DataSource = "";
            grdStockMngt.DataBind();
            ddlTransactionType.SelectedValue = "0";
            ddlSourceStore.SelectedValue = "0";
            ddlDestinationStore.SelectedValue = "0";
            txtTransactionDate.Text = "";
            txtOrderNumber.Text = "";
        }

        private DataTable CreateOrderMasterTable()
        {
            DataTable dtOrdermaster = new DataTable();
            dtOrdermaster.Columns.Add("IsPO", typeof(int));
            dtOrdermaster.Columns.Add("POID", typeof(int));
            dtOrdermaster.Columns.Add("OrderDate", typeof(string));
            dtOrdermaster.Columns.Add("SupplierID", typeof(int));
            dtOrdermaster.Columns.Add("SrcStore", typeof(int));
            dtOrdermaster.Columns.Add("DestStore", typeof(int));
            dtOrdermaster.Columns.Add("UserID", typeof(int));
            dtOrdermaster.Columns.Add("PreparedBy", typeof(int));
            dtOrdermaster.Columns.Add("AthorizedBy", typeof(int));
            dtOrdermaster.Columns.Add("LocationID", typeof(int));
            dtOrdermaster.Columns.Add("IsRejectedStatus", typeof(int));
            return dtOrdermaster;
        }
        private DataTable CreateOrderItemTable()
        {
            DataTable dtOrderItem = new DataTable();
            dtOrderItem.Columns.Add("ItemID", typeof(int));
            dtOrderItem.Columns.Add("ItemName", typeof(String));
            dtOrderItem.Columns.Add("PurchaseUnit", typeof(int));
            dtOrderItem.Columns.Add("Quantity", typeof(int));
            dtOrderItem.Columns.Add("priceperunit", typeof(decimal));
            dtOrderItem.Columns.Add("totPrice", typeof(int));
            dtOrderItem.Columns.Add("BatchID", typeof(int));
            dtOrderItem.Columns.Add("AvaliableQty", typeof(int));
            dtOrderItem.Columns.Add("ExpiryDate", typeof(string));
            dtOrderItem.Columns.Add("UnitQuantity", typeof(int));
            //dtOrderItem.Columns.Add("Delete", typeof(String));
            // dtOrderItem.Columns.Add("IsFunded", typeof(int));
            return dtOrderItem;
        }

        private DataTable CreateGRNMasterTable()
        {

            DataTable dtGRNmaster = new DataTable();
            dtGRNmaster.Columns.Add("POID", typeof(int));
            dtGRNmaster.Columns.Add("GRNId", typeof(int));
            dtGRNmaster.Columns.Add("LocationID", typeof(int));
            dtGRNmaster.Columns.Add("OrderDate", typeof(string));
            dtGRNmaster.Columns.Add("SupplierID", typeof(int));
            dtGRNmaster.Columns.Add("SourceStoreID", typeof(int));
            dtGRNmaster.Columns.Add("DestinStoreID", typeof(int));
            dtGRNmaster.Columns.Add("UserID", typeof(int));
            dtGRNmaster.Columns.Add("RecievedDate", typeof(string));
            dtGRNmaster.Columns.Add("OrderNo", typeof(String));
            dtGRNmaster.Columns.Add("Freight", typeof(decimal));
            dtGRNmaster.Columns.Add("Tax", typeof(decimal));
            return dtGRNmaster;
        }

        private DataTable CreateGRNItemTable()
        {
            DataTable dtGRNItem = new DataTable();
            dtGRNItem.Columns.Add("AutoID", typeof(int));
            dtGRNItem.Columns.Add("GRNId", typeof(int));
            dtGRNItem.Columns.Add("ItemID", typeof(int));
            dtGRNItem.Columns.Add("BatchID", typeof(int));
            dtGRNItem.Columns.Add("BatchName", typeof(String));
            dtGRNItem.Columns.Add("RecievedQuantity", typeof(int));
            dtGRNItem.Columns.Add("QtyPerPurchaseUnit", typeof(int));
            dtGRNItem.Columns.Add("FreeRecievedQuantity", typeof(int));
            dtGRNItem.Columns.Add("ItemPurchasePrice", typeof(decimal));
            dtGRNItem.Columns.Add("TotPurchasePrice", typeof(decimal));
            dtGRNItem.Columns.Add("MasterPurchaseprice", typeof(decimal));
            dtGRNItem.Columns.Add("Margin", typeof(decimal));
            dtGRNItem.Columns.Add("SellingPrice", typeof(decimal));
            dtGRNItem.Columns.Add("SellingPricePerDispense", typeof(decimal));
            dtGRNItem.Columns.Add("ExpiryDate", typeof(string));
            dtGRNItem.Columns.Add("UserID", typeof(int));
            dtGRNItem.Columns.Add("POId", typeof(int));
            dtGRNItem.Columns.Add("SourceStoreID", typeof(int));
            dtGRNItem.Columns.Add("DestinStoreID", typeof(int));
            dtGRNItem.Columns.Add("Comments", typeof(string));
            if (GblIQCare.ModePurchaseOrder == 2)
            {
                dtGRNItem.Columns.Add("ISTItemID", typeof(String));
            }
            return dtGRNItem;
        }

        private DataTable CreateAdjustStockTable()
        {
            DataTable dtAdjStock = new DataTable();
            dtAdjStock.Columns.Add("ItemID", typeof(int));
            dtAdjStock.Columns.Add("BatchID", typeof(int));
            dtAdjStock.Columns.Add("ExpiryDate", typeof(string));
            dtAdjStock.Columns.Add("StoreID", typeof(int));
            dtAdjStock.Columns.Add("AdjQty", typeof(int));
            dtAdjStock.Columns.Add("Comments", typeof(string));
            return dtAdjStock;
        }

        private DataTable CreateOpeningStockTable()
        {
            DataTable dtOS = new DataTable();
            dtOS.Columns.Add("ItemID", typeof(int));
            dtOS.Columns.Add("BatchNo", typeof(string));
            dtOS.Columns.Add("ExpiryDate", typeof(string));
            dtOS.Columns.Add("StoreID", typeof(int));
            dtOS.Columns.Add("Quantity", typeof(int));
            dtOS.Columns.Add("Comments", typeof(string));
            return dtOS;
        }

        protected void ddlTransactionType_SelectedIndexChanged(object sender, EventArgs e)
        {
            tranactionType = ddlTransactionType.SelectedItem.Text;
            grdStockMngt.DataSource = "";
            grdStockMngt.DataBind();
            ddlSourceStore.SelectedIndex = 0;
            
            //if (ddlTransactionType.SelectedItem.Text != "Receive")
            //{
            //    destinationStoreRequiredValidator.Enabled = false;
            //}
            //else
            //{
            //    destinationStoreRequiredValidator.Enabled = true;
            //}
        }

        protected void grnDetails()
        {
            IPurchase objPODetails = (IPurchase)ObjectFactory.CreateInstance("BusinessProcess.SCM.BPurchase,BusinessProcess.SCM");
            DataTable theDTPODetails = objPODetails.GetPurchaseOrderDetailsForGRN(Convert.ToInt32(Session["AppUserID"].ToString()), Convert.ToInt32(ddlDestinationStore.SelectedValue), Convert.ToInt32(Session["AppLocationId"].ToString()));


        }
    }
}