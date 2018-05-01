using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Interface.Clinical;
using Application.Presentation;
using Application.Common;



/// <summary>
/// Summary description for AuthenticationManager  - 
/// </summary>
public class AuthenticationManager
{
    #region "Constructor"
    public AuthenticationManager()
    {
    }
    #endregion

    #region "Application Parameters"
    //public static string AppVersion = "3.6.0";
    //public static string ReleaseDate = "14-May-2014";
    public static string AppVersion = "3.6.0 Patch1";
    public static string ReleaseDate = "20-Mar-2015";
    #endregion

    public Boolean HasFeatureRight(int FeatureId, DataTable theDT)
    {
        DataView theDV = new DataView(theDT);
        theDV.RowFilter = "FeatureId = " + FeatureId.ToString();
        if (theDV.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public Boolean HasFeatureRight(string FeatureName, int ModuleId, DataTable theDT)
    {
        DataView theDV = new DataView(theDT);
        theDV.RowFilter = "ListName = '" + FeatureName.ToString() + "' and ModuleId=" + ModuleId;
        if (theDV.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public Boolean HasFunctionRight(int FeatureId, int FunctionId, DataTable theDT)
    {
        DataView theDV = new DataView(theDT);
        theDV.RowFilter = "FeatureId = " + FeatureId.ToString() + " and FunctionId = " + FunctionId.ToString();
        if (theDV.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public Boolean HasFunctionRightwithModule(int FeatureId, int FunctionId,int ModuleId, DataTable theDT)
    {
        DataView theDV = new DataView(theDT);
        theDV.RowFilter = "FeatureId = " + FeatureId.ToString() + " and FunctionId = " + FunctionId.ToString() + " and ModuleId = " + ModuleId.ToString();
        if (theDV.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public Boolean HasFunctionRightwithModuleTabs(int FeatureId, int FunctionId, int ModuleId,int TabId, DataTable theDT)
    {
        DataView theDV = new DataView(theDT);
        theDV.RowFilter = "FeatureId = " + FeatureId.ToString() + " and FunctionId = " + FunctionId.ToString() + " and ModuleId = " + ModuleId.ToString() + " and TabId = " + ModuleId.ToString();
        if (theDV.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public Boolean HasFunctionRight(string FeatureName, int FunctionId, DataTable theDT)
    {
        DataView theDV = new DataView(theDT);
        theDV.RowFilter = "FeatureName = '" + FeatureName + "' and FunctionId = " + FunctionId.ToString();
        if (theDV.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    public Boolean HasModuleRight(int ModuleId, DataTable theDT)
    {
        DataView theDV = new DataView(theDT);
        theDV.RowFilter = "ModuleId = " + ModuleId.ToString();
        if (theDV.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public Boolean HasTabFunctionRight(int TabId, int FunctionId, DataTable theDT)
    {
        DataView theDV = new DataView(theDT);
        theDV.RowFilter = "TabId = " + TabId.ToString() + " and FunctionId = " + FunctionId.ToString();
        if (theDV.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public Boolean HasTabModuleFunctionRight(int TabId, int FunctionId,int ModuleId, DataTable theDT)
    {
        DataView theDV = new DataView(theDT);
        theDV.RowFilter = "TabId = " + TabId.ToString() + " and FunctionId = " + FunctionId.ToString() + " and ModuleId = " + ModuleId.ToString();
        if (theDV.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public Boolean HasFunctionRight(int FeatureId, int TabId, int FunctionId, DataTable theDT)
    {
        DataView theDV = new DataView(theDT);
        theDV.RowFilter = "FeatureId = " + FeatureId.ToString() + " and TabId= "+TabId.ToString()+" and FunctionId = " + FunctionId.ToString() ;
        if (theDV.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public void TabUserRights(Button save, Button print, int FeatureID, int TabID)
    {
        ICustomForm mgrUserValidate = (ICustomForm)ObjectFactory.CreateInstance("BusinessProcess.Clinical.BCustomForm, BusinessProcess.Clinical");
        IKNHStaticForms isTabSaved = (IKNHStaticForms)ObjectFactory.CreateInstance("BusinessProcess.Clinical.BKNHStaticForms, BusinessProcess.Clinical");

        //int iSavedUserID = mgrUserValidate.GetCustomFormSavedByUser(Convert.ToInt32(System.Web.HttpContext.Current.Session["PatientVisitId"]), TabID);

        //if user have view permission disable the buttons
        //AuthenticationManager Authentication = new AuthenticationManager();
        bool bCanView = !HasFunctionRight(FeatureID, TabID, FunctionAccess.View, (DataTable)System.Web.HttpContext.Current.Session["UserRight"]);

        //if user have view permission
        save.Enabled = bCanView;

        //first time  - new user form creation
        if (Convert.ToInt32(System.Web.HttpContext.Current.Session["PatientVisitId"]) == 0)
        {
            bool bCanAdd = HasFunctionRight(FeatureID, TabID, FunctionAccess.Add, (DataTable)System.Web.HttpContext.Current.Session["UserRight"]);
            save.Enabled = bCanAdd;

        }
        else if (Convert.ToInt32(System.Web.HttpContext.Current.Session["PatientVisitId"]) > 0)
        {
            DataSet tabSaved = isTabSaved.CheckIfTabSaved(TabID, Convert.ToInt32(System.Web.HttpContext.Current.Session["PatientVisitId"]));
            if (tabSaved.Tables[0].Rows.Count == 0)
            {
                bool bCanAdd = HasFunctionRight(FeatureID, TabID, FunctionAccess.Add, (DataTable)System.Web.HttpContext.Current.Session["UserRight"]);
                save.Enabled = bCanAdd;
            }
            else
            {
                bool bCanUpdate = HasFunctionRight(FeatureID, TabID, FunctionAccess.Update, (DataTable)System.Web.HttpContext.Current.Session["UserRight"]);
                //if (bCanUpdate == true)
                //{
                //    //if user is different from who already saved user.
                //    bCanUpdate = (iSavedUserID == Convert.ToInt32(System.Web.HttpContext.Current.Session["AppUserId"]));
                //}

                if (Convert.ToInt32(System.Web.HttpContext.Current.Session["AppUserID"]) == 1)
                    bCanUpdate = true;

                save.Enabled = bCanUpdate;
            }


        }

        print.Enabled = HasFunctionRight(FeatureID, TabID, FunctionAccess.Print, (DataTable)System.Web.HttpContext.Current.Session["UserRight"]);
    }
    public Boolean CheckDateConstriant(int FacilityId)
    {
        DataSet theDS = new DataSet();
        theDS.ReadXml(System.Web.HttpContext.Current.Server.MapPath("..\\XMLFiles\\ALLMasters.con"));
        if (theDS.Tables["Mst_Facility"] != null)
        {
            DataView theDV = new DataView(theDS.Tables["Mst_Facility"]);
            theDV.RowFilter = "FacilityID=" + FacilityId;
            if (theDV.Table != null)
            {
                IQCareUtils iQCareUtils = new IQCareUtils();
                DataTable theDt = (DataTable)iQCareUtils.CreateTableFromDataView(theDV);
                if (theDt.Rows.Count > 0)
                {
                    if (theDt.Rows[0]["DateConstraint"].ToString() == "1")
                    {
                        return true;
                    }
                    else
                        return false;
                }
            }
            
        }
        return false;
    }
}
