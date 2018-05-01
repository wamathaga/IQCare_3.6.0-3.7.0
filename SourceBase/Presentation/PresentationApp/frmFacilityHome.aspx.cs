using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Interface.Clinical;
using Application.Presentation;
using Application.Common;
using System.Drawing;

namespace IQCare.Web
{
    public partial class frmFacilityHome2 : System.Web.UI.Page
    {
        string ObjFactoryParameter = "BusinessProcess.Clinical.BPatientRegistration, BusinessProcess.Clinical";
        String[] aTileBackgroundColor = {"#5724A9","#A62241","#4765EB","#2C7F96","#CA4D2F","#2F3FB0","#890094","#479ADA","#1E8C00","#8824A9","#479ADA"};
        AuthenticationManager Authentication = new AuthenticationManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AppLocation"] == null || Session.Count == 0 || Session["AppUserID"].ToString() == "")
            {
                IQCareMsgBox.Show("SessionExpired", this);
                Response.Redirect("~/frmlogin.aspx",true);
            }
            (Master.FindControl("levelOneNavigationUserControl1").FindControl("lblheader") as Label).Text = "Facility Home";
            (Master.FindControl("levelOneNavigationUserControl1").FindControl("lblRoot") as Label).Visible = false;
            if(!IsPostBack)
                Init_page();
        }
        private void Init_page()
        {
            Session["PatientId"] = 0;
            
            createserviceButtons();
        }
        private Boolean setBillingRights()
        {
            btnBillSettings.Visible = false;
            Boolean hasRights = false;
            //check if billing is enabled
            if (Session["Billing"].ToString() != "1") return false;
            
            if (Authentication.HasFeatureRight(ApplicationAccess.Billing, (DataTable)Session["UserRight"]))
            {
                btnPatientBill.Visible = true;
                hasRights = true;
            }
            if (Authentication.HasFeatureRight(ApplicationAccess.BillingReports, (DataTable)Session["UserRight"]))
            {
                btnBillReports.Visible = true;
                hasRights = true;
            }
            if (Authentication.HasFeatureRight(ApplicationAccess.BillingReversal, (DataTable)Session["UserRight"]) )
            {
                btnBillReversal.Visible = true;
                hasRights = true;
            }

            if (Authentication.HasFeatureRight(ApplicationAccess.Consumables, (DataTable)Session["UserRight"]))
            {
                btnConsumables.Visible = true;
                hasRights = true;
            }
            if (Authentication.HasFeatureRight(ApplicationAccess.BillingConfiguration, (DataTable)Session["UserRight"]))
            {
                btnBillSettings.Visible = true;
                hasRights = true;
                btnPriceList.Visible = true;
            }
            return hasRights;

        }
        private void createserviceButtons()
        {
              IPatientRegistration ptnMgr = (IPatientRegistration)ObjectFactory.CreateInstance(ObjFactoryParameter);
               DataSet DSModules = new DataSet();
               DataTable theDT = new DataTable();
               DataTable theDTIdent = new DataTable();
               if (Convert.ToInt32(Session["AppUserId"]) > 1)
               {
                   DSModules = ptnMgr.GetModuleNames(Convert.ToInt32(Session["AppLocationId"]), Convert.ToInt32(Session["AppUserId"]));
                   theDT = DSModules.Tables[2];
                   theDTIdent = DSModules.Tables[3];
               }
               else
               {
                   DSModules = ptnMgr.GetModuleNames(Convert.ToInt32(Session["AppLocationId"]));
                   theDT = DSModules.Tables[0];
                   theDTIdent = DSModules.Tables[2];
               }
            //removing Workplan if KNH Static form service is not available
            Session["isKNHEnabled"] = false;
            DataTable dt = theDT;

            if (!object.Equals(theDT, null))
            {
                int tmp = dt.AsEnumerable().Where(p => p.Field<int>("moduleid") == Convert.ToInt32("204")).Select(p => p.Field<int>("moduleid")).FirstOrDefault();
                if(tmp>0)
                    Session["isKNHEnabled"] = true;
            }

            //first add the records button which is default present
            int i = 0;
            int cntr = 0;
            TableRow serviceRow = new TableRow();
            TableCell recordsCell = new TableCell();
            recordsCell.Attributes.Add("align", "center");
            recordsCell.Attributes.Add("width", "25%");
            recordsCell.Attributes.Add("height", "100px");

            Boolean Records = GetRecords("RECORDS", theDT);
            if (Records == true)
            {
                Button btnRecords = new Button();
                btnRecords.Text = "Records";
                btnRecords.BackColor = System.Drawing.ColorTranslator.FromHtml(aTileBackgroundColor[1].ToString());
                btnRecords.Attributes.Add("class", "tileButton");
                btnRecords.BorderStyle = BorderStyle.None;
                btnRecords.OnClientClick = String.Format("window.location = 'frmFindAddCustom.aspx?srvNm={0}&mod={1}'; return false;", "Records", 0);
                btnRecords.Height = Unit.Pixel(100);
                btnRecords.Width = Unit.Percentage(100);

                recordsCell.Controls.Add(btnRecords);
                serviceRow.Cells.Add(recordsCell);
               // mainTable.Controls.Add(serviceRow);
                DataRow[] toBeDeleted;
                toBeDeleted = theDT.Select("ModuleName = 'RECORDS'");
                if (toBeDeleted.Length > 0)
                {
                    foreach (DataRow dr in toBeDeleted)
                    {
                        theDT.Rows.Remove(dr);
                        theDT.AcceptChanges();
                    }
                }
                i = 1;
                cntr += 2;
            }

            //Now add billing button Naveen 04-Feb-2015
            if (setBillingRights())//returns true if user has at least some rights in billing and billing is enabled
            {

                TableCell billingCell = new TableCell();
                // recordsCell.CssClass = "border pad5 whitebg";
                billingCell.Attributes.Add("align", "center");
                billingCell.Attributes.Add("width", "25%");
                billingCell.Attributes.Add("height", "100");
                //align="center" width="25%" height =100
                Button btnBilling = new Button();
                btnBilling.BackColor = System.Drawing.ColorTranslator.FromHtml(aTileBackgroundColor[cntr].ToString());
                btnBilling.Attributes.Add("class", "tileButton");
                btnBilling.BorderStyle = BorderStyle.None;
                //btnBilling.ForeColor = Color.White;
                btnBilling.Text = "Billing";                
                btnBilling.OnClientClick = "'showPopup();'";
                btnBilling.Height = Unit.Pixel(100);
                btnBilling.Width = Unit.Percentage(100);
                //  btnBilling.Click += btnBilling_Click;
                billingCell.Controls.Add(btnBilling);
                btnBilling.ID = "btnBilling";
                billingOptionsPopup.TargetControlID = btnBilling.ID;
                serviceRow.Cells.Add(billingCell);                
               // mainTable.Controls.Add(serviceRow);
                i += 1;
                cntr += 1;
            }
            //Add the Wards button only if wards is enabled and user has rights to it
            if (Session["Wards"].ToString() == "1" && Authentication.HasFeatureRight(ApplicationAccess.Wards, (DataTable)Session["UserRight"])) 
            {
                TableCell wardCell = new TableCell();
                // recordsCell.CssClass = "border pad5 whitebg";
                wardCell.Attributes.Add("align", "center");
                wardCell.Attributes.Add("width", "25%");
                wardCell.Attributes.Add("height", "100");

                //align="center" width="25%" height =100
                Button btnWard = new Button();
                btnWard.BackColor = System.Drawing.ColorTranslator.FromHtml(aTileBackgroundColor[cntr].ToString());
                btnWard.Attributes.Add("class", "tileButton");
                btnWard.BorderStyle = BorderStyle.None;
               // btnWard.ForeColor = Color.White;
                btnWard.Text = "Wards";
                btnWard.Font.Bold = true;
                btnWard.Font.Size = 12;
                btnWard.OnClientClick = "javascript:window.location='./Admission/frmAdmissionHome.aspx?from=home';return false;";
                btnWard.Height = Unit.Pixel(100);
                btnWard.Width = Unit.Percentage(100);

                wardCell.Controls.Add(btnWard);
                btnWard.ID = "btnWard";

                serviceRow.Cells.Add(wardCell);
                i += 1;
                cntr += 1;
               
               // mainTable.Controls.Add(serviceRow);

            }
            mainTable.Controls.Add(serviceRow);
            DataView theDV;
            IQCareUtils utils = new IQCareUtils();
            foreach (DataRow dr in theDT.Rows)
            {
                
                if (Convert.ToInt32(dr["ModuleID"]) != 201)
                {
                    if (i % 4 == 0)
                        serviceRow = new TableRow();
                    
                    TableCell serviceCell = new TableCell();
                    serviceCell.Attributes.Add("align", "center");
                    serviceCell.Attributes.Add("width", "25%");
                    serviceCell.Attributes.Add("height", "100px");

                    Button btnService = new Button();
                    btnService.Text = dr[2].ToString();
                    btnService.Attributes.Add("data-moduleID", dr[1].ToString());
                    btnService.BackColor = System.Drawing.ColorTranslator.FromHtml(aTileBackgroundColor[cntr].ToString());
                    btnService.Attributes.Add("class", "tileButton");
                    btnService.BorderStyle = BorderStyle.None;
                    theDV = new DataView(theDTIdent);
                    theDV.RowFilter = "ModuleId=" + Convert.ToInt32(dr["ModuleID"]);
                    DataTable theIdenDT = utils.CreateTableFromDataView(theDV);
                    if (theIdenDT.Rows.Count == 0)
                    {
                        //btnService.OnClientClick = "alert('The Service Area doesn't have any Identifier. Please Add/Link atleast on Identifier with it.');"; 
                        btnService.OnClientClick = string.Format("alert('The Service Area doesn\\'t have any Identifier.\\n Please Add/Link atleast on Identifier with it from IQCare Management.');return false;");
                    }
                    else
                    {
                        if (Convert.ToInt32(dr["ModuleID"]) != 206)
                            btnService.OnClientClick = String.Format("window.location = 'frmFindAddCustom.aspx?srvNm={0}&mod={1}'; return false;", btnService.Text, dr[1]);
                        else
                            btnService.OnClientClick = String.Format("window.location = 'PharmacyDispense/frmPharmacyDispense_FindPatient.aspx'; return false;");
                    }
                    btnService.Height = Unit.Pixel(100);
                    //if (theDT.Rows.Count == 1)
                    //    btnService.Width = Unit.Percentage(70);
                    //else if (theDT.Rows.Count == 2)
                    //    btnService.Width = Unit.Percentage(90);
                    //else
                        btnService.Width = Unit.Percentage(100);
                        
                    serviceCell.Controls.Add(btnService);
                    serviceRow.Cells.Add(serviceCell);
                    if (i % 4 == 0)
                        mainTable.Controls.Add(serviceRow);
                        
                    i += 1;
                    cntr += 1;
                    //resetting color counter
                    if (cntr >= aTileBackgroundColor.Length)
                        cntr = 0;
                }
            }
           // ptnMgr = null;
        }

        protected Boolean GetRecords(string parameter, DataTable theDT)
        {
           
            String str = theDT.AsEnumerable().Where(p => p.Field<string>("ModuleName") == Convert.ToString(parameter)).Select(p => p.Field<string>("ModuleName")).FirstOrDefault();
            if (str != null)
            {return true;}
            return false;
        }

    }
}
