using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Text;
using Interface.Clinical;
using Application.Presentation;
using System.Data;

namespace PresentationApp.ClinicalForms.UserControl
{
    public partial class UserControl_Alerts : System.Web.UI.UserControl
    {
        StringBuilder allergies = new StringBuilder();
        StringBuilder chronic = new StringBuilder();
        IKNHStaticForms AlertManager;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Visible == true)
            {
                if (!object.Equals(Session["PatientId"], null))
                {
                    if (Convert.ToInt32(Session["PatientId"]) > 0)
                    {
                        AlertManager = (IKNHStaticForms)ObjectFactory.CreateInstance("BusinessProcess.Clinical.BKNHStaticForms, BusinessProcess.Clinical");
                        DataSet theDSAlerts = AlertManager.GetAlerts(Convert.ToInt32(Session["PatientId"]));

                        //allergies
                        DataTable allergyDT = theDSAlerts.Tables[0];
                        if (allergyDT.Rows.Count > 0)
                        {
                            for (int i = 0; i < allergyDT.Rows.Count; i++)
                            {
                                allergies.Append(allergyDT.Rows[i]["AllergyTypeDesc"].ToString() + " - " + allergyDT.Rows[i]["AllergenDesc"].ToString() + " - " + allergyDT.Rows[i]["DateAllergy"].ToString());
                                allergies.Append(",");
                            }
                        }
                        Page.ClientScript.RegisterStartupScript(HttpContext.Current.GetType(), "Allergies", "myAllergies('" + allergies + "');", true);

                        //chronic conditions
                        DataTable chronicDT = theDSAlerts.Tables[1];
                        if (chronicDT.Rows.Count > 0)
                        {
                            for (int i = 0; i < chronicDT.Rows.Count; i++)
                            {
                                chronic.Append(chronicDT.Rows[i]["Name"].ToString());
                                chronic.Append(",");
                            }
                        }
                        Page.ClientScript.RegisterStartupScript(HttpContext.Current.GetType(), "Chroniccondition", "myChronic('" + chronic + "');", true);

                        string url = Request.Url.ToString();
                        string lastPart = url.Split('/').Last();

                        if (lastPart == "frm_Laboratory.aspx")
                        {
                            //CD4 Due date
                            DataTable CD4DT = theDSAlerts.Tables[2];
                            if (CD4DT.Rows.Count > 0)
                            {
                                TimeSpan timespanCD4 = ((DateTime)CD4DT.Rows[0]["CD4DueDate"]) - DateTime.Now;
                                if (timespanCD4.Days < 60)
                                    Page.ClientScript.RegisterStartupScript(HttpContext.Current.GetType(), "CD4DueDate", "CD4DueDate('" + ((DateTime)CD4DT.Rows[0]["CD4DueDate"]).ToString(Session["AppDateFormat"].ToString()) + "');", true);
                            }

                            //Viral Load Due date
                            DataTable ViralDT = theDSAlerts.Tables[3];
                            if (ViralDT.Rows.Count > 0)
                            {
                                if (!object.Equals(ViralDT.Rows[0]["ViralLoadDueDate"], null))
                                {
                                    TimeSpan timespanVL = ((DateTime)ViralDT.Rows[0]["ViralLoadDueDate"]) - DateTime.Now;
                                    if (timespanVL.Days < 60)
                                        Page.ClientScript.RegisterStartupScript(HttpContext.Current.GetType(), "ViralDueDate", "ViralLoadDueDate('" + ((DateTime)ViralDT.Rows[0]["ViralLoadDueDate"]).ToString(Session["AppDateFormat"].ToString()) + "');", true);
                                }
                            }
                        }


                    }
                }
            }
        }



         
    }
}