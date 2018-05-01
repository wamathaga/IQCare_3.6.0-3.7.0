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
using System.Collections.Specialized;

using Application.Common;
using Application.Presentation;
using Interface.Security;
using System.Threading;

public partial class frmLogin : BasePage
{
    /////////////////////////////////////////////////////////////////////
    // Code Written By   : Sanjay Rana
    // Written Date      : 03rd Aug 2006
    // Modification Date : 13th May 2008
    // Description       : Login Form
    //
    /// /////////////////////////////////////////////////////////////////

    #region "User Functions"
    private void Init_Form()
    {
        
        //Response.Write("SessionCount -" + Session.Count.ToString());
        Session.Timeout = Convert.ToInt32(((NameValueCollection)ConfigurationSettings.GetConfig("appSettings"))["SessionTimeOut"]);
        Session.Add("AppUserId", "");
        Session.Add("AppUserName", "");
        Session.Add("EnrollFlag", "");
        Session.Add("IdentifierFlag", "");
        Session.Add("AppLocationId", "");
        Session.Add("AppLocation", "");
        Session.Add("AppCountryId", "");
        Session.Add("AppPosID", "");
        Session.Add("AppSatelliteId", "");
        Session.Add("GracePeriod", "");
        Session.Add("AppDateFormat", "");
        Session.Add("UserRight", "");
        Session.Add("BackupDrive", "");
        Session.Add("SystemId", "1");
        Session.Add("ModuleId", "");
        Application.Add("AppCurrentDate", "");
        Session.Add("Program", "");
        Session.Add("AppCurrency", "");
        Session.Add("AppUserEmployeeId", "");
        Session.Add("CustomfrmDrug", "");
        Session.Add("CustomfrmLab", "");
        Session.Add("AppUserCustomList", "");
        Session.Add("SCMModule", null);
        
        ////////////////////////////////////////
        
        lblDate.Text = "";
        lblUserName.Text = "";
        lblLocation.Text = "";
        txtuname.Text = "";
        txtpassword.Text = "";
        imgLogin.ImageUrl = "";
        chkPref.Checked = true;
        BindCombo();
        GetApplicationParameters();
        //lblLocation.Text = Session["AppLocation"].ToString();

        txtuname.Focus();


        lblversion.Text = AuthenticationManager.AppVersion;
        lblrelDate.Text = AuthenticationManager.ReleaseDate;

    }

    private void BindCombo()
    {
        IUser UserManager = (IUser)ObjectFactory.CreateInstance("BusinessProcess.Security.BUser,BusinessProcess.Security");
        DataTable theDT = UserManager.GetFacilityList();
        BindFunctions theBind = new BindFunctions();
        
        if (chkPref.Checked == true)
        {          
            DataView theDV = new DataView(theDT);
            theDV.RowFilter = "Preferred = 1";
            theDT = theDV.ToTable();            

        }
        if (ViewState["pwd"] != null) 
        { 
            txtpassword.Attributes["value"] = ViewState["pwd"].ToString(); 
        }

        ViewState["pwd"] = null;
        if (theDT.Rows.Count == 1)
        {
            ddLocation.DataSource = theDT;
            ddLocation.DataTextField = "FacilityName";
            ddLocation.DataValueField = "FacilityId";
            ddLocation.DataBind();

        }
        else
        {
            theBind.BindCombo(ddLocation, theDT, "FacilityName", "FacilityId");
        }
    }

    private void GetApplicationParameters()
    {
        IUser ApplicationManager;
        ApplicationManager = (IUser)ObjectFactory.CreateInstance("BusinessProcess.Security.BUser, BusinessProcess.Security");
        DataSet theDS = ApplicationManager.GetFacilitySettings(1);
        DataTable theDT = theDS.Tables[0];

        if (theDT.Rows.Count < 1)
        {
            string theUrl = string.Format("{0}", "./AdminForms/frmAdmin_FacilityList.aspx?BS=true");
            Response.Redirect(theUrl);
        }
        if (!string.IsNullOrEmpty(theDT.Rows[0]["Image"].ToString()))
        {
            imgLogin.ImageUrl = string.Format("images/{0}", theDT.Rows[0]["Image"].ToString());
        }
        else
        {
            imgLogin.ImageUrl = "~/Images/Login.jpg";
        }
        Session["SystemId"] = Convert.ToInt32(theDT.Rows[0]["SystemId"]);
        #region "Version Control"

        if (theDS.Tables[1].Rows[0]["AppVer"].ToString() != AuthenticationManager.AppVersion || ((DateTime)theDS.Tables[1].Rows[0]["RelDate"]).ToString("dd-MMM-yyyy") != AuthenticationManager.ReleaseDate)
        {
            string script = "<script language = 'javascript' defer ='defer' id = 'confirm'>\n";
            script += "var ans=true;\n";
            script += "alert('You are using a Wrong Version of Application. Please contact Support staff.');\n";
            script += "if (ans==true)\n";
            script += "{\n";
            script += "window.close() - y;\n";
            script += "}\n";
            script += "</script>\n";
            RegisterStartupScript("confirm", script);
            btnLogin.Enabled = false;
        }
        #endregion

        ApplicationManager = null;
        IIQCareSystem DateManager;
        DateManager = (IIQCareSystem)ObjectFactory.CreateInstance("BusinessProcess.Security.BIQCareSystem, BusinessProcess.Security");
        DateTime theDTime = DateManager.SystemDate();

        ViewState["theCurrentDate"] = theDTime;
        lblDate.Text = theDTime.ToString("dd-MMM-yyyy");
        Application["AppCurrentDate"] = theDTime.ToString("dd-MMM-yyyy");
        Session["AppCurrentDateClass"] = theDTime.ToString("dd-MMM-yyyy");
    }

    [Ajax.AjaxMethod(Ajax.HttpSessionStateRequirement.ReadWrite)]
    public void ChangePassword(int chngpwdflag) //1 for mandatory change 0 for optional
    {
        string theUrl = string.Format("{0}", "./AdminForms/frmAdmin_ChangePassword.aspx");
        Response.Redirect(theUrl);

    }

    private bool ValidateLogin()
    {
        if (txtuname.Text.Trim() == "")
        {
            IQCareMsgBox.Show("BlankUserName", this);
            return false;
        }
        if (txtpassword.Text.Trim() == "")
        {
            IQCareMsgBox.Show("BlankPassword", this);
            return false;
        }
        if (Convert.ToInt32(ddLocation.SelectedValue) < 1)
        {
            IQCareMsgBox.Show("BlankLocation", this);
            return false;
        }
        return true;
    }

    #region Generate Cache old code
    //private void GenerateCache()
    //{
    //    IIQCareSystem DateManager;
    //    DateManager = (IIQCareSystem)ObjectFactory.CreateInstance("BusinessProcess.Security.BIQCareSystem, BusinessProcess.Security");
    //    DateTime theDTime = DateManager.SystemDate();

    //    System.IO.FileInfo theFileInfo1 = new System.IO.FileInfo(Server.MapPath(".\\XMLFiles\\AllMasters.con").ToString());
    //    System.IO.FileInfo theFileInfo2 = new System.IO.FileInfo(Server.MapPath(".\\XMLFiles\\DrugMasters.con").ToString());
    //    System.IO.FileInfo theFileInfo3 = new System.IO.FileInfo(Server.MapPath(".\\XMLFiles\\LabMasters.con").ToString());
    //    System.IO.FileInfo theFileInfo4 = new System.IO.FileInfo(Server.MapPath(".\\XMLFiles\\Frequency.xml").ToString());

    //    if (theFileInfo1.LastWriteTime.Date != theDTime.Date || theFileInfo2.LastWriteTime.Date != theDTime.Date || theFileInfo3.LastWriteTime.Date != theDTime.Date || theFileInfo4.LastWriteTime.Date != theDTime.Date)
    //    {
    //        theFileInfo1.Delete();
    //        theFileInfo2.Delete();
    //        theFileInfo3.Delete();
    //        theFileInfo4.Delete();
    //        IIQCareSystem theCacheManager = (IIQCareSystem)ObjectFactory.CreateInstance("BusinessProcess.Security.BIQCareSystem,BusinessProcess.Security");
    //        DataSet theMainDS = theCacheManager.GetSystemCache();
    //        DataSet WriteXMLDS = new DataSet();

    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Provider"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Ward"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Division"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_District"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Reason"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Education"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Designation"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Employee"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Occupation"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Province"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Village"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Code"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_HIVAIDSCareTypes"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_ARTSponsor"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_HivDisease"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Assessment"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Symptom"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Decode"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Feature"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Function"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_HivDisclosure"].Copy());
    //        //WriteXMLDS.Tables.Add(theMainDS.Tables["mst_Satellite"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_LPTF"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_StoppedReason"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["mst_facility"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_HIVCareStatus"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_RelationshipType"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_TBStatus"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_ARVStatus"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_LostFollowreason"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Regimen"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_CouncellingType"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_CouncellingTopic"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_ReferredFrom"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_pmtctDeCode"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Module"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_ModDecode"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_ARVSideEffects"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_ModCode"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Country"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Town"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["VWDiseaseSymptom"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["VW_ICDList"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["mst_RegimenLine"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["mst_Store"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["mst_BlueCode"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["mst_BlueDecode"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_FormBuilderTab"].Copy());
    //        WriteXMLDS.WriteXml(Server.MapPath(".\\XMLFiles\\").ToString() + "AllMasters.con", XmlWriteMode.WriteSchema);

    //        WriteXMLDS.Tables.Clear();
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Strength"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_FrequencyUnits"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Drug"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Generic"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_DrugType"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Frequency"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_DrugSchedule"].Copy());
    //        WriteXMLDS.WriteXml(Server.MapPath(".\\XMLFiles\\").ToString() + "DrugMasters.con", XmlWriteMode.WriteSchema);

    //        WriteXMLDS.Tables.Clear();
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_LabTest"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Lnk_TestParameter"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Lnk_LabValue"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Lnk_ParameterResult"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["LabTestOrder"].Copy());
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["mst_PatientLabPeriod"].Copy());
    //        WriteXMLDS.WriteXml(Server.MapPath(".\\XMLFiles\\").ToString() + "LabMasters.con", XmlWriteMode.WriteSchema);

    //        WriteXMLDS.Tables.Clear();
    //        WriteXMLDS.Tables.Add(theMainDS.Tables["Mst_Frequency"].Copy());
    //        WriteXMLDS.WriteXml(Server.MapPath(".\\XMLFiles\\").ToString() + "Frequency.xml", XmlWriteMode.WriteSchema);
    //    }
    //}
    #endregion

    private void UpdateAppointment()
    {
        //*******Update appointment status priviously missed, missed, careended and met from pending*******//                
        IUser LoginManager;
        LoginManager = (IUser)ObjectFactory.CreateInstance("BusinessProcess.Security.BUser, BusinessProcess.Security");
        int theAffectedRows = LoginManager.UpdateAppointmentStatus(Convert.ToString(Application["AppCurrentDate"]), Convert.ToInt16(Session["AppLocationId"]));
    }

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
       
        try
        {
            Ajax.Utility.RegisterTypeForAjax(typeof(frmLogin));
            if (Page.IsPostBack != true)
            {
                Thread theThread = new Thread(new ParameterizedThreadStart(IQCareUtils.GenerateCache));
                theThread.Start(false);
                Init_Form();
            }

        }
        catch (Exception err)
        {
            MsgBuilder theBuilder = new MsgBuilder();
            theBuilder.DataElements["MessageText"] = err.Message.ToString();
            IQCareMsgBox.Show("#C1", theBuilder, this);
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (!ValidateLogin())
        {
            Init_Form();
            return;
        }

        IUser LoginManager;
        try
        {
            LoginManager = (IUser)ObjectFactory.CreateInstance("BusinessProcess.Security.BUser, BusinessProcess.Security");
            if(object.Equals(Session["SystemId"],null))
                    Session["SystemId"] = "1";

            DataSet theDS = LoginManager.GetUserCredentials(txtuname.Text.Trim(), Convert.ToInt32(ddLocation.SelectedValue), Convert.ToInt32(Session["SystemId"]));
            if (theDS.Tables.Count > 0)
            {
                int FacilityExist = 1;
                if (theDS.Tables[5].Rows.Count > 0)
                {
                    DataView theDV = new DataView();
                    FacilityExist = 0;
                    foreach (DataRow theDR in theDS.Tables[5].Rows)
                    {
                        if (Convert.ToInt32(theDR["GroupId"]) > 1)
                        {
                            theDV = new DataView(theDS.Tables[1]);
                            theDV.RowFilter = "FacilityID= " + ddLocation.SelectedValue + "";
                            if (theDV.ToTable().Rows.Count > 0)
                            {
                                FacilityExist = 1;
                            }
                        }
                        else if (Convert.ToInt32(theDR["GroupId"]) == 1)
                        {
                            FacilityExist = 1;
                        }
                    }
                }
                if (FacilityExist == 0)
                {
                    IQCareMsgBox.Show("AccessDenied", this);
                    return;
                }
                Utility theUtil = new Utility();
                if (theDS.Tables[0].Rows.Count > 0)
                {
                    //if (theUtil.Decrypt(Convert.ToString(theDS.Tables[0].Rows[0]["Password"])) != txtpassword.Text.Trim())
                    if (Convert.ToString(theDS.Tables[0].Rows[0]["Password"]) != theUtil.Encrypt(txtpassword.Text.Trim().ToString()))
                    {
                        if ((Request.Browser.Cookies))
                        {
                            HttpCookie theCookie = Request.Cookies[txtuname.Text];
                            if (theCookie == null)
                            {
                                HttpCookie theNCookie = new HttpCookie(txtuname.Text);
                                theNCookie.Value = txtuname.Text + ",1";
                                DateTime theNewDTTime = Convert.ToDateTime(ViewState["theCurrentDate"]).AddMinutes(5);
                                theNCookie.Expires = theNewDTTime;
                                Response.Cookies.Add(theNCookie);
                            }

                            else
                            {
                                string[] theVal = (theCookie.Value.ToString()).Split(',');
                                if (Convert.ToInt32(theVal[1]) >= 3 && theCookie.Name == txtuname.Text)
                                {
                                    MsgBuilder theBuilder = new MsgBuilder();
                                    theBuilder.DataElements["MessageText"] = "User Account Locked. Try again after 5 Mins.";
                                    IQCareMsgBox.Show("#C1", theBuilder, this);
                                    return;
                                }
                                else
                                {
                                    theVal[1] = (Convert.ToInt32(theVal[1]) + 1).ToString();
                                    theCookie.Value = txtuname.Text + "," + theVal[1];
                                    DateTime theAddNewDTTime = Convert.ToDateTime(ViewState["theCurrentDate"]).AddMinutes(5);
                                    theCookie.Expires = theAddNewDTTime;
                                    Response.Cookies.Add(theCookie);
                                }
                            }
                        }
                        IQCareMsgBox.Show("PasswordNotMatch", this);
                        Init_Form();
                        return;
                    }
                    else
                    {
                        HttpCookie theCookie = Request.Cookies[txtuname.Text];
                        if (theCookie != null)
                        {
                            string[] theVal = (theCookie.Value.ToString()).Split(',');
                            if (Convert.ToInt32(theVal[1]) >= 3)
                            {
                                MsgBuilder theBuilder = new MsgBuilder();
                                theBuilder.DataElements["MessageText"] = "User Account Locked. Try again after 5 Mins.";
                                IQCareMsgBox.Show("#C1", theBuilder, this);
                                return;
                            }
                        }
                    }
                }

                else
                {
                    IQCareMsgBox.Show("InvalidLogin", this);
                    Init_Form();
                    return;
                }

                Session["AppUserId"] = Convert.ToString(theDS.Tables[0].Rows[0]["UserId"]);
                Session["AppUserName"] = Convert.ToString(theDS.Tables[0].Rows[0]["UserFirstName"]) + " " + Convert.ToString(theDS.Tables[0].Rows[0]["UserLastName"]);
                Session["EnrollFlag"] = theDS.Tables[1].Rows[0]["EnrollmentFlag"].ToString();
                Session["CareEndFlag"] = theDS.Tables[1].Rows[0]["CareEndFlag"].ToString();
                Session["IdentifierFlag"] = theDS.Tables[1].Rows[0]["IdentifierFlag"].ToString();
                Session["UserRight"] = theDS.Tables[1];
                Session["UserFeatures"] = theDS.Tables[6];
                Session["AppUserCustomList"] = theDS.Tables[7];
                DataTable theDT = theDS.Tables[2];
                Session["AppLocationId"] = theDT.Rows[0]["FacilityID"].ToString();
                Session["AppLocation"] = theDT.Rows[0]["FacilityName"].ToString();
                Session["AppCountryId"] = theDT.Rows[0]["CountryID"].ToString();
                Session["AppPosID"] = theDT.Rows[0]["PosID"].ToString();
                Session["AppSatelliteId"] = theDT.Rows[0]["SatelliteID"].ToString();
                Session["GracePeriod"] = theDT.Rows[0]["AppGracePeriod"].ToString();
                Session["AppDateFormat"] = theDT.Rows[0]["DateFormat"].ToString();
                Session["BackupDrive"] = theDT.Rows[0]["BackupDrive"].ToString();
                Session["SystemId"] = theDT.Rows[0]["SystemId"].ToString();
                Session["AppCurrency"] = theDT.Rows[0]["Currency"].ToString();
                Session["AppUserEmployeeId"] = theDS.Tables[0].Rows[0]["EmployeeId"].ToString();
                
                //Session["AppSystemId"] = theDT.Rows[0]["SystemId"].ToString();

                #region "ModuleId"
                Session["AppModule"] = theDS.Tables[3];
                DataView theSCMDV = new DataView(theDS.Tables[3]);
                theSCMDV.RowFilter = "ModuleId=201";
                if (theSCMDV.Count > 0)
                    Session["SCMModule"] = theSCMDV[0]["ModuleName"];
                #endregion
                IQWebUtils theIQUtils = new IQWebUtils();
                //theIQUtils.CreateSessionObject(Session.SessionID); 
                Session["Paperless"] = theDT.Rows[0]["Paperless"].ToString();
                Session["Program"] = "";
                LoginManager = null;

                /*
                 * Commented by Gaurav & Suggested by Joseph 
                 * Purpose: Everytime not to update appoinments
                 * Date: 23 Sept 2014
                 */
                /////////////// Appointment Updates//////////////////
                //UpdateAppointment();
                /////////////////////////////////////////////////////

                if (Convert.ToString(theDS.Tables[0].Rows[0]["forcelogin"]) == "0")
                {
                    string theUrl = string.Format("{0}", "./AdminForms/frmAdmin_ChangePassword.aspx");
                    String msgString = "First time login: please change your password.\\n";
                    string script = "<script language = 'javascript' defer ='defer' id = 'changePwd'>\n";
                    script += "alert('" + msgString + "');\n";
                    string url = Request.RawUrl.ToString();
                    Application["PrvFrm"] = url;
                    Session["MandatoryChange"] = "1";
                    script += "window.location.href='" + theUrl + "'\n";
                    script += "</script>\n";
                    RegisterStartupScript("changePwd", script);
                }
                else if (theDS.Tables[3].Rows[0]["ExpPwdFlag"] != null && Convert.ToString(theDS.Tables[3].Rows[0]["ExpPwdFlag"]) != "")
                {
                    if (Convert.ToInt32(theDS.Tables[0].Rows[0]["UserId"]) != 1)
                    {
                        if (Convert.ToInt32(theDS.Tables[3].Rows[0]["ExpPwdFlag"]) == 1)
                        {
                            //DateTime lastcontDate = Convert.ToDateTime(theDS.Tables[0].Rows[0]["PwdDate"]).AddDays(Convert.ToInt32(theDS.Tables[3].Rows[0]["ExpPwdDays"]));
                            //lastcontDate.AddDays(90);
                            DateTime lastcontDate = Convert.ToDateTime(theDS.Tables[0].Rows[0]["PwdDate"]);
                            TimeSpan t = Convert.ToDateTime(theDS.Tables[4].Rows[0]["CurrentDate"]) - lastcontDate;
                            double NrOfDaysdiffernce = t.TotalDays;
                            //int result = Convert.ToInt32(theDS.Tables[3].Rows[0]["ExpPwdDays"]) - Convert.ToInt32(NrOfDays);
                            string msgString;
                            string theUrl = string.Format("{0}", "./AdminForms/frmAdmin_ChangePassword.aspx");
                            if (NrOfDaysdiffernce > Convert.ToInt32(theDS.Tables[3].Rows[0]["ExpPwdDays"]))
                            {
                                msgString = "Your Password has expired. Please Change it now.\\n";
                                string script = "<script language = 'javascript' defer ='defer' id = 'changePwdfunction2'>\n";
                                script += "alert('" + msgString + "');\n";
                                string url = Request.RawUrl.ToString();
                                Application["PrvFrm"] = url;
                                Session["MandatoryChange"] = "1";
                                script += "window.location.href='" + theUrl + "'\n";
                                script += "</script>\n";
                                RegisterStartupScript("changePwdfunction2", script);
                                //ClientScript.RegisterClientScriptBlock(this.GetType(), "changePwdfunction2", script,true);


                            }

                            else
                            {
                                // adding the false parameter value to continue the execution of current page....
                                Response.Redirect("frmFacilityHome.aspx", false);
                                // Response.Redirect("frmFindAddPatient.aspx");
                            }
                        }
                        else
                        {
                            // adding the false parameter value to continue the execution of current page....
                            Response.Redirect("frmFacilityHome.aspx", false);
                            // Response.Redirect("frmFindAddPatient.aspx");
                        }
                    }
                    else
                    {
                        // adding the false parameter value to continue the execution of current page....
                        Response.Redirect("frmFacilityHome.aspx", false);
                        // Response.Redirect("frmFindAddPatient.aspx");
                    }

                }
                else
                {
                    // adding the false parameter value to continue the execution of current page....
                    Response.Redirect("frmFacilityHome.aspx", false);
                    //Response.Redirect("frmFindAddPatient.aspx");
                }

                //Response.Redirect("frmFacilityHomenew.aspx");
            }
            else
            {
                IQCareMsgBox.Show("InvalidLogin", this);
                return;
            }
        }
        catch (Exception err)
        {
            MsgBuilder theBuilder = new MsgBuilder();
            theBuilder.DataElements["MessageText"] = err.Message.ToString();
            IQCareMsgBox.Show("#C1", theBuilder, this);
        }
        finally
        {
            LoginManager = null;
        }
    }
    protected void chkPref_CheckedChanged(object sender, EventArgs e)
    {
        ViewState["pwd"] = txtpassword.Text;
        BindCombo();
    }
    [Ajax.AjaxMethod(Ajax.HttpSessionStateRequirement.ReadWrite)]
    public string CallHelp()
    {

        string theHlpFileNm = Server.MapPath(".//IQCareHelp//IQCareARUserManualSep2010.chm");
        System.Windows.Forms.Control theParent = new System.Windows.Forms.Control();
        System.Windows.Forms.Help.ShowHelp(theParent, theHlpFileNm);
        return theHlpFileNm;
    }
    protected string lnkBtnHelp_Click(object sender, EventArgs e)
    {
        string theHlpFileNm = Server.MapPath(".//IQCareHelp//IQCareARUserManualSep2010.chm");
        //System.Windows.Forms.Control theParent = new System.Windows.Forms.Control();
        //System.Windows.Forms.Help.ShowHelp(theParent, theHlpFileNm);
        return theHlpFileNm;
        //IQWebUtils theUtils = new IQWebUtils();
        //theUtils.ShowFile(theHlpFileNm, Response); 
    }
}
