using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using Interface.Laboratory;
using DataAccess.Base;
using DataAccess.Entity;
using DataAccess.Common;
using Application.Common;
using System.Collections.Generic;

namespace BusinessProcess.Laboratory
{
    public class BLabFunctions : ProcessBase,ILabFunctions 
    {
        #region "Constructor"
        public BLabFunctions()
        {
        }
        #endregion

        
        public DataTable SaveNewLabOrder(Hashtable ht, DataTable dt, string strCustomField, string paperless, DataTable theCustomFieldData)
        {
            try
            {
                int LabID = 0;
                int theRowAffected = 0;
                DataTable dtresult;
                this.Connection = DataMgr.GetConnection();
                this.Transaction = DataMgr.BeginTransaction(this.Connection);

                ClsObject LabManager = new ClsObject();
                LabManager.Connection = this.Connection;
                LabManager.Transaction = this.Transaction;

                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@PatientID", SqlDbType.VarChar, ht["PatientID"].ToString());
                ClsUtility.AddParameters("@LocationID", SqlDbType.VarChar, ht["LocationID"].ToString());
                ClsUtility.AddParameters("@OrderedByName", SqlDbType.Int, ht["OrderedByName"].ToString());
                ClsUtility.AddParameters("@OrderedByDate", SqlDbType.VarChar, ht["OrderedByDate"].ToString());
                ClsUtility.AddParameters("@ReportedByName", SqlDbType.Int, ht["ReportedByName"].ToString());
                ClsUtility.AddParameters("@ReportedByDate", SqlDbType.VarChar, ht["ReportedByDate"].ToString());
                ClsUtility.AddParameters("@CheckedByName", SqlDbType.Int, ht["CheckedByName"].ToString());
                ClsUtility.AddParameters("@CheckedByDate", SqlDbType.VarChar, ht["CheckedByDate"].ToString());
                ClsUtility.AddParameters("@PreClinicLabDate", SqlDbType.VarChar, ht["PreClinicLabDate"].ToString());
                ClsUtility.AddParameters("@UserId", SqlDbType.Int, ht["UserId"].ToString());
                ClsUtility.AddParameters("@Transaction", SqlDbType.Int, ht["Transaction"].ToString());
                ClsUtility.AddParameters("@Orderid", SqlDbType.Int, ht["OrderId"].ToString());
                ClsUtility.AddParameters("@LabPeriod", SqlDbType.Int, ht["LabPeriod"].ToString());
                ClsUtility.AddParameters("@LabNumber", SqlDbType.Int, ht["LabNumber"].ToString());
                dtresult = (DataTable)LabManager.ReturnObject(ClsUtility.theParams, "Pr_Laboratory_SaveLabOrder_Constella", ClsUtility.ObjectEnum.DataTable);

                if (dtresult != null && dtresult.Rows.Count > 0)
                {
                    LabID = Convert.ToInt32(dtresult.Rows[0][0].ToString());
                    if (LabID == 0)
                    {
                        MsgBuilder theMsg = new MsgBuilder();
                        theMsg.DataElements["MessageText"] = "Error in Saving Lab Order Records. Try Again..";
                        AppException.Create("#C1", theMsg);
                        return dtresult;

                    }
                }

                if (paperless == "1")
                {
                    if (Convert.ToInt32(ht["Transaction"]) == 2)
                    {
                        string theSQL = string.Format("update dtl_PatientLabResults set TestResultID = NULL, TestResults = NULL, TestResults1 = NULL where LabId = {0}", Convert.ToInt32(ht["OrderId"]));
                        ClsUtility.Init_Hashtable();
                        int Rows = (int)LabManager.ReturnObject(ClsUtility.theParams, theSQL, ClsUtility.ObjectEnum.ExecuteNonQuery);
                    }

                    DataTable dtres;
                    if (Convert.ToInt32(ht["Transaction"]) == 2)
                    {
                        int DeleteParameterFlag = 0;
                        //string theSQL = string.Format("update dtl_PatientLabResults set TestResultID = NULL where ParameterID={0} and LabID={1}", "100", Convert.ToInt32(ht["OrderId"]));
                        //int Rows = (int)LabManager.ReturnObject(ClsUtility.theParams, theSQL, ClsUtility.ObjectEnum.ExecuteNonQuery);
                     
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            ClsUtility.Init_Hashtable();
                            ClsUtility.AddParameters("@LabID", SqlDbType.VarChar, ht["OrderId"].ToString());
                            ClsUtility.AddParameters("@LocationID", SqlDbType.VarChar, ht["LocationID"].ToString());
                            ClsUtility.AddParameters("@ParameterID", SqlDbType.VarChar, dt.Rows[i]["LabParameterId"].ToString());
                            ClsUtility.AddParameters("@TestResults", SqlDbType.VarChar, dt.Rows[i]["LabResult"].ToString());
                            ClsUtility.AddParameters("@TestResults1", SqlDbType.VarChar, dt.Rows[i]["LabResult1"].ToString());
                            ClsUtility.AddParameters("@TestResultId", SqlDbType.Int, dt.Rows[i]["LabResultId"].ToString());
                            ClsUtility.AddParameters("@Financed", SqlDbType.VarChar, dt.Rows[i]["Financed"].ToString());
                            ClsUtility.AddParameters("@UnitId", SqlDbType.VarChar, dt.Rows[i]["UnitId"].ToString());
                            ClsUtility.AddParameters("@UserId", SqlDbType.Int, ht["UserId"].ToString());
                            if (dt.Rows[i]["LabParameterId"].ToString() == "100")
                            {
                                if (DeleteParameterFlag == 0)
                                {

                                    string theSQL = string.Format("delete from dtl_PatientLabResults where ParameterID = {0} and LabID={1}", "100", Convert.ToInt32(ht["OrderId"]));
                                    int Rows = (int)LabManager.ReturnObject(ClsUtility.theParams, theSQL, ClsUtility.ObjectEnum.ExecuteNonQuery);
                                    dtres = (DataTable)LabManager.ReturnObject(ClsUtility.theParams, "pr_Lab_UpdateResults_Constella", ClsUtility.ObjectEnum.DataTable);
                                    DeleteParameterFlag = 1;
                                }
                                else
                                {
                                    dtres = (DataTable)LabManager.ReturnObject(ClsUtility.theParams, "pr_Lab_UpdateResults_Constella", ClsUtility.ObjectEnum.DataTable);
                                }

                            }
                            else
                            {
                                dtres = (DataTable)LabManager.ReturnObject(ClsUtility.theParams, "pr_Lab_UpdateResults_Constella", ClsUtility.ObjectEnum.DataTable);
                            }

                        }
                    }
                    else 
                    {

                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            ClsUtility.Init_Hashtable();
                            ClsUtility.AddParameters("@LabID", SqlDbType.VarChar, dtresult.Rows[0][0].ToString());
                            ClsUtility.AddParameters("@LabTestID", SqlDbType.VarChar, dt.Rows[i]["LabTestId"].ToString());
                            ClsUtility.AddParameters("@LocationID", SqlDbType.VarChar, ht["LocationID"].ToString());
                            ClsUtility.AddParameters("@ParameterID", SqlDbType.VarChar, dt.Rows[i]["LabParameterId"].ToString());
                            ClsUtility.AddParameters("@TestResults", SqlDbType.VarChar, dt.Rows[i]["LabResult"].ToString());
                            ClsUtility.AddParameters("@TestResults1", SqlDbType.VarChar, dt.Rows[i]["LabResult1"].ToString());
                            ClsUtility.AddParameters("@TestResultId", SqlDbType.Int, dt.Rows[i]["LabResultId"].ToString());
                            ClsUtility.AddParameters("@Financed", SqlDbType.VarChar, dt.Rows[i]["Financed"].ToString());
                            ClsUtility.AddParameters("@UnitId", SqlDbType.VarChar, dt.Rows[i]["UnitId"].ToString());
                            ClsUtility.AddParameters("@UserId", SqlDbType.Int, ht["UserId"].ToString());
                            dtres = (DataTable)LabManager.ReturnObject(ClsUtility.theParams, "pr_Lab_AddResults_Constella", ClsUtility.ObjectEnum.DataTable);

                        }
                    
                    
                    }

                }
                else
                {
                    if (Convert.ToInt32(ht["Transaction"]) == 2)
                    {
                        string theSQL = "delete from dtl_PatientLabResults where LabId ="+ Convert.ToInt32(ht["OrderId"]);
                        theSQL += "delete from Dtl_PatientBillTransaction where LabId =" + Convert.ToInt32(ht["OrderId"]) + " and ptn_pk=" + ht["PatientID"].ToString();
                        ClsUtility.Init_Hashtable();
                        int Rows = (int)LabManager.ReturnObject(ClsUtility.theParams, theSQL, ClsUtility.ObjectEnum.ExecuteNonQuery);
                    }

                    DataTable dtres;
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        ClsUtility.Init_Hashtable();
                        if (Convert.ToInt32(ht["Transaction"]) == 1)
                        {
                            ClsUtility.AddParameters("@LabID", SqlDbType.VarChar, dtresult.Rows[0][0].ToString());
                        }
                        else
                        {
                            ClsUtility.AddParameters("@LabID", SqlDbType.VarChar, ht["OrderId"].ToString());
                        }
                        ClsUtility.AddParameters("@LabTestID", SqlDbType.VarChar, dt.Rows[i]["LabTestId"].ToString());
                        ClsUtility.AddParameters("@LocationID", SqlDbType.VarChar, ht["LocationID"].ToString());
                        ClsUtility.AddParameters("@ParameterID", SqlDbType.VarChar, dt.Rows[i]["LabParameterId"].ToString());
                        ClsUtility.AddParameters("@TestResults", SqlDbType.VarChar, dt.Rows[i]["LabResult"].ToString());
                        ClsUtility.AddParameters("@TestResults1", SqlDbType.VarChar, dt.Rows[i]["LabResult1"].ToString());
                        ClsUtility.AddParameters("@TestResultId", SqlDbType.Int, dt.Rows[i]["LabResultId"].ToString());
                        ClsUtility.AddParameters("@Financed", SqlDbType.VarChar, dt.Rows[i]["Financed"].ToString());
                        ClsUtility.AddParameters("@UnitId", SqlDbType.VarChar, dt.Rows[i]["UnitId"].ToString());
                        ClsUtility.AddParameters("@UserId", SqlDbType.Int, ht["UserId"].ToString());
                        dtres = (DataTable)LabManager.ReturnObject(ClsUtility.theParams, "pr_Lab_AddResults_Constella", ClsUtility.ObjectEnum.DataTable);

                    }
                }
                //// Custom Fields //////////////
                ////////////PreSet Values Used/////////////////
                /// #99# --- Ptn_Pk
                /// #88# --- LocationId
                /// #77# --- Visit_Pk
                /// #66# --- Visit_Date
                /// #55# --- Ptn_Pharmacy_Pk
                /// #44# --- OrderedByDate
                /// #33# --- LabId
                /// #22# --- TrackingId
                /// #11# --- CareEndedId
                /// #00# --- HomeVisitId
                ///////////////////////////////////////////////

                //ClsObject theCustomManager = new ClsObject();
                for (Int32 i = 0; i < theCustomFieldData.Rows.Count; i++)
                {
                    ClsUtility.Init_Hashtable();
                    string theQuery = theCustomFieldData.Rows[i]["Query"].ToString();
                    //theQuery = theQuery.Replace("#99#", dtresult.Rows[0][0].ToString());
                    theQuery = theQuery.Replace("#99#", ht["PatientID"].ToString());
                    theQuery = theQuery.Replace("#88#", dtresult.Rows[0][1].ToString());
                    //theQuery = theQuery.Replace("#88#", ht["LocationID"].ToString());
                    theQuery = theQuery.Replace("#33#", dtresult.Rows[0][0].ToString());
                    //theQuery = theQuery.Replace("#33#", ht["OrderID"].ToString());
                    theQuery = theQuery.Replace("#44#", "'" + ht["OrderedByDate"].ToString() + "'");
                    ClsUtility.AddParameters("@QryString", SqlDbType.VarChar, theQuery);
                    int RowsAffected = (Int32)LabManager.ReturnObject(ClsUtility.theParams, "pr_General_Dynamic_Insert", ClsUtility.ObjectEnum.ExecuteNonQuery);
                }
                ////////////////////////////////

                DataMgr.CommitTransaction(this.Transaction);
                DataMgr.ReleaseConnection(this.Connection);
                return dtresult;
            }
            catch
            {
                DataMgr.RollBackTransation(this.Transaction);
                throw;
            }
            finally
            {
                if (this.Connection != null)
                    DataMgr.ReleaseConnection(this.Connection);
            }
        }
        public DataSet SaveLabOrderTests(int Ptn_pk, int LocationID, DataTable ParameterID, int UserId, int OrderedByName, string OrderedByDate, string LabID, int FlagExist, string PreClinicLabDate)
        {
            ClsObject LabManagerTest = new ClsObject();
            try
            {
                this.Connection = DataMgr.GetConnection();
                this.Transaction = DataMgr.BeginTransaction(this.Connection);

                LabManagerTest.Connection = this.Connection;
                LabManagerTest.Transaction = this.Transaction;
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@Ptn_pk", SqlDbType.Int, Ptn_pk.ToString());
                ClsUtility.AddParameters("@LocationID", SqlDbType.Int, LocationID.ToString());
                ClsUtility.AddParameters("@UserId", SqlDbType.Int, UserId.ToString());
                ClsUtility.AddParameters("@ParameterID", SqlDbType.Int, "0");
                ClsUtility.AddParameters("@OrderedByName", SqlDbType.Int, OrderedByName.ToString());
                ClsUtility.AddParameters("@OrderedByDate", SqlDbType.DateTime, OrderedByDate.ToString());
                ClsUtility.AddParameters("@Flag", SqlDbType.Int, "0");
                ClsUtility.AddParameters("@LabID", SqlDbType.VarChar, LabID.ToString());
                ClsUtility.AddParameters("@FlagExist", SqlDbType.Int, FlagExist.ToString());
                ClsUtility.AddParameters("@PreClinicLabDate", SqlDbType.DateTime, PreClinicLabDate.ToString());
                DataSet dsLabTests = (DataSet)LabManagerTest.ReturnObject(ClsUtility.theParams, "Pr_Laboratory_SaveLabOrderTests_Constella", ClsUtility.ObjectEnum.DataSet);

                for (int i = 0; i < ParameterID.Rows.Count; i++)
                {
                    ClsUtility.Init_Hashtable();
                    ClsUtility.AddParameters("@Ptn_pk", SqlDbType.Int, Ptn_pk.ToString());
                    ClsUtility.AddParameters("@LocationID", SqlDbType.Int, LocationID.ToString());
                    ClsUtility.AddParameters("@UserId", SqlDbType.Int, UserId.ToString());
                    ClsUtility.AddParameters("@ParameterID", SqlDbType.Int, ParameterID.Rows[i][0].ToString());
                    ClsUtility.AddParameters("@OrderedByName", SqlDbType.Int, OrderedByName.ToString());
                    ClsUtility.AddParameters("@OrderedByDate", SqlDbType.DateTime, OrderedByDate.ToString());
                    ClsUtility.AddParameters("@Flag", SqlDbType.Int, "1");
                    ClsUtility.AddParameters("@LabID", SqlDbType.VarChar, LabID.ToString());
                    ClsUtility.AddParameters("@FlagExist", SqlDbType.Int, FlagExist.ToString());
                    ClsUtility.AddParameters("@PreClinicLabDate", SqlDbType.DateTime, PreClinicLabDate.ToString());
                    dsLabTests = (DataSet)LabManagerTest.ReturnObject(ClsUtility.theParams, "Pr_Laboratory_SaveLabOrderTests_Constella", ClsUtility.ObjectEnum.DataSet);
                }

                DataMgr.CommitTransaction(this.Transaction);
                DataMgr.ReleaseConnection(this.Connection);
                return dsLabTests;
            }

            catch
            {
                DataMgr.RollBackTransation(this.Transaction);
                throw;
            }
            finally
            {
                if (this.Connection != null)
                    DataMgr.ReleaseConnection(this.Connection);

            }

        }

        public DataSet GetPatientInfo(string patientid)
        {
            lock (this)
            {
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@patientid", SqlDbType.VarChar, patientid.ToString());
                ClsUtility.AddParameters("@password", SqlDbType.VarChar, ApplicationAccess.DBSecurity);
                ClsObject UserManager = new ClsObject();
                return (DataSet)UserManager.ReturnObject(ClsUtility.theParams, "pr_Laboratory_GetPatientInfo_Constella", ClsUtility.ObjectEnum.DataSet);
            }

        }
        public DataSet GetPatientRecordformStatus(int PatientID)
        {
            lock (this)
            {
                ClsObject PharmacyManager = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@Ptn_pk", SqlDbType.Int, PatientID.ToString());
                return (DataSet)PharmacyManager.ReturnObject(ClsUtility.theParams, "pr_Laboratory_GetPatientRecordformStatus_Futures", ClsUtility.ObjectEnum.DataSet);
            }
        }
        public DataSet GetPatientLabOrder(String PatientId)
        {
            lock (this)
            {
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@PatientID", SqlDbType.VarChar, PatientId.ToString());
                ClsObject UserManager = new ClsObject();
                return (DataSet)UserManager.ReturnObject(ClsUtility.theParams, "Pr_Laboratory_GetLabOrder_Constella", ClsUtility.ObjectEnum.DataSet);
            }
        }
        public DataTable ReturnLabQuery(string theQuery)
        {
            lock (this)
            {
                ClsObject theQB = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@QryString", SqlDbType.VarChar, theQuery);
                return (DataTable)theQB.ReturnObject(ClsUtility.theParams, "pr_General_SQLTable_Parse", ClsUtility.ObjectEnum.DataTable);
            }
        }

        public DataSet GetPatientLab(String LabId)
        {
            lock (this)
            {
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@LabID", SqlDbType.VarChar, LabId.ToString());
                ClsObject UserManager = new ClsObject();
                return (DataSet)UserManager.ReturnObject(ClsUtility.theParams, "Pr_Laboratory_GetLabResults_Constella", ClsUtility.ObjectEnum.DataSet);
            }
        }
        public DataSet GetPatientLabTestID(String LabId)
        {
            lock (this)
            {
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@LabID", SqlDbType.VarChar, LabId.ToString());
                ClsObject OrderMgr = new ClsObject();
                return (DataSet)OrderMgr.ReturnObject(ClsUtility.theParams, "Pr_Laboratory_GetLabTestID_Constella", ClsUtility.ObjectEnum.DataSet);
            }
        }

        public DataSet GetLabValues()
        {
            lock (this)
            {
                ClsUtility.Init_Hashtable();
                ClsObject UserManager = new ClsObject();
                return (DataSet)UserManager.ReturnObject(ClsUtility.theParams, "Pr_Laboratory_GetLabValues_Constella", ClsUtility.ObjectEnum.DataSet);
            }
        }
        public DataSet GetLabs()
        {
            lock (this)
            {
                ClsUtility.Init_Hashtable();
                ClsObject UserManager = new ClsObject();
                return (DataSet)UserManager.ReturnObject(ClsUtility.theParams, "Pr_Laboratory_GetLabs", ClsUtility.ObjectEnum.DataSet);
            }
        }

        public DataTable GetEmployeeDetails()
        {
            lock (this)
            {
                ClsObject LoginManager = new ClsObject();
                ClsUtility.Init_Hashtable();
                return (DataTable)LoginManager.ReturnObject(ClsUtility.theParams, "pr_Admin_GetEmployeeDetails_Constella", ClsUtility.ObjectEnum.DataTable);
            }
        }
        public DataTable GetLaborderdate(int PatientID, int LocationID, int LabId)
        {
            lock (this)
            {
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@PatientID", SqlDbType.Int, PatientID.ToString());
                ClsUtility.AddParameters("@LocationID", SqlDbType.Int, LocationID.ToString());
                ClsUtility.AddParameters("@LabTestId", SqlDbType.Int, LabId.ToString());
                ClsObject LabManager = new ClsObject();
                return (DataTable)LabManager.ReturnObject(ClsUtility.theParams, "pr_Laboratory_GetLabOrderDate_Constella", ClsUtility.ObjectEnum.DataTable);
            }
        }

        public DataTable GetBmiValue(int PatientID, int LocationID, int VisitID ,int statusHW)
        {
            lock (this)
            {
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@PatientID", SqlDbType.Int, PatientID.ToString());
                ClsUtility.AddParameters("@LocationID", SqlDbType.Int, LocationID.ToString());
                ClsUtility.AddParameters("@VisitID", SqlDbType.Int, VisitID.ToString());
                ClsUtility.AddParameters("@IsHeightWeight", SqlDbType.Int, statusHW.ToString());
                ClsObject LabManager = new ClsObject();
                return (DataTable)LabManager.ReturnObject(ClsUtility.theParams, "pr_Clincial_GetBMIValue", ClsUtility.ObjectEnum.DataTable);
            }
        }

        public DataSet GetPatientLabTestIDTouch(BIQTouchLabFields objLabFields)
        {
            lock (this)
            {
                ClsObject LabFieldsManager = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@LabIDs", SqlDbType.VarChar, objLabFields.LabTestIDs);
                ClsUtility.AddParameters("@Flag", SqlDbType.VarChar, objLabFields.Flag);
                ClsUtility.AddParameters("@LabName", SqlDbType.VarChar, objLabFields.LabTestName);
                return (DataSet)LabFieldsManager.ReturnObject(ClsUtility.theParams, "Pr_Laboratory_GetLabTestID", ClsUtility.ObjectEnum.DataSet);
            }
            throw new NotImplementedException();
        }

        #region "Delete Lab Form"
        public int DeleteLabForms(string FormName, int OrderNo, int PatientId, int UserID)
        {

            try
            {
                int theAffectedRows = 0;
                this.Connection = DataMgr.GetConnection();
                this.Transaction = DataMgr.BeginTransaction(this.Connection);

                ClsObject DeleteLabForm = new ClsObject();
                DeleteLabForm.Connection = this.Connection;
                DeleteLabForm.Transaction = this.Transaction;

                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@OrderNo", SqlDbType.Int, OrderNo.ToString());
                ClsUtility.AddParameters("@FormName", SqlDbType.VarChar, FormName);
                ClsUtility.AddParameters("@PatientId", SqlDbType.Int, PatientId.ToString());
                ClsUtility.AddParameters("@UserID", SqlDbType.Int, UserID.ToString());

                theAffectedRows = (int)DeleteLabForm.ReturnObject(ClsUtility.theParams, "pr_Clinical_DeletePatientForms_Constella", ClsUtility.ObjectEnum.ExecuteNonQuery);


                DataMgr.CommitTransaction(this.Transaction);
                DataMgr.ReleaseConnection(this.Connection);
                return theAffectedRows;
            }
            catch
            {
                DataMgr.RollBackTransation(this.Transaction);
                throw;
            }
            finally
            {
                if (this.Connection != null)
                    DataMgr.ReleaseConnection(this.Connection);
            }

        }
        #endregion

        #region IQTouchMethords
        public DataSet IQTouchGetPatientLabTestID(BIQTouchLabFields objLabFields)
        {
            lock (this)
            {
                ClsObject labFieldsManager = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@LabIDs", SqlDbType.VarChar, objLabFields.LabTestIDs);
                ClsUtility.AddParameters("@Flag", SqlDbType.VarChar, objLabFields.Flag);
                ClsUtility.AddParameters("@LabName", SqlDbType.VarChar, objLabFields.LabTestName);
                ClsUtility.AddParameters("@labOrderID", SqlDbType.Int, objLabFields.LabOrderId.ToString());
                return (DataSet)labFieldsManager.ReturnObject(ClsUtility.theParams, "Pr_IQTouch_Laboratory_GetLabTestID", ClsUtility.ObjectEnum.DataSet);
            }
            throw new NotImplementedException();
        }
        public DataSet IQTouchLaboratory_GetLabOrder(BIQTouchLabFields objLabFields)
        {
            lock (this)
            {
                ClsObject labFieldsManager = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@patientid", SqlDbType.VarChar, objLabFields.Ptnpk.ToString());
                ClsUtility.AddParameters("@locationid", SqlDbType.Int, objLabFields.LocationId.ToString());
                ClsUtility.AddParameters("@LabOrderId", SqlDbType.Int, objLabFields.LabOrderId.ToString());
                ClsUtility.AddParameters("@Flag", SqlDbType.VarChar, objLabFields.Flag);
                return (DataSet)labFieldsManager.ReturnObject(ClsUtility.theParams, "Pr_IQTouch_Laboratory_GetLabOrder", ClsUtility.ObjectEnum.DataSet);
            }
            throw new NotImplementedException();
        }
       


        public DataSet IQTouchGetlabDemo(BIQTouchLabFields objLabFields)
        {
            lock (this)
            {
                ClsObject labFieldsManager = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@p_flag", SqlDbType.VarChar, objLabFields.Flag.ToString());
                ClsUtility.AddParameters("@p_labTestId", SqlDbType.Int, objLabFields.LabTestID.ToString());
                ClsUtility.AddParameters("@p_labTestName", SqlDbType.VarChar, objLabFields.LabTestName.ToString());
                return (DataSet)labFieldsManager.ReturnObject(ClsUtility.theParams, "pr_Lab_Demo", ClsUtility.ObjectEnum.DataSet);
            }
            throw new NotImplementedException();
        }

        public DataSet IQTouchLaboratoryGetArvMutationMasterList(BIQTouchLabFields objLabFields)
        {
            lock (this)
            {
                ClsObject labFieldsManager = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@Flag", SqlDbType.VarChar, objLabFields.Flag.ToString());
                ClsUtility.AddParameters("@ARV_TypeID", SqlDbType.Int, objLabFields.ArvTypeID.ToString());
                return (DataSet)labFieldsManager.ReturnObject(ClsUtility.theParams, "Pr_IQTouch_Laboratory_GetARVMutationMasterList", ClsUtility.ObjectEnum.DataSet);
            }
            throw new NotImplementedException();
        }
        public DataSet IQTouchLaboratoryGetArvMutationDetails(BIQTouchLabFields objLabFields)
        {
            lock (this)
            {
                ClsObject labFieldsManager = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@Flag", SqlDbType.VarChar, objLabFields.Flag.ToString());
                ClsUtility.AddParameters("@LabOrderID", SqlDbType.Int, objLabFields.LabOrderId.ToString());
                return (DataSet)labFieldsManager.ReturnObject(ClsUtility.theParams, "Pr_IQTouch_Laboratory_GetARVMutationDetails", ClsUtility.ObjectEnum.DataSet);
            }
            throw new NotImplementedException();
        }

        public DataSet IQTouchLaboratoryGetGenXpertDetails(BIQTouchLabFields objLabFields, int TestId)
        {
            lock (this)
            {
                ClsObject labFieldsManager = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@Flag", SqlDbType.VarChar, objLabFields.Flag.ToString());
                ClsUtility.AddParameters("@LabOrderID", SqlDbType.Int, objLabFields.LabOrderId.ToString());
                ClsUtility.AddParameters("@TestId", SqlDbType.Int, TestId.ToString());
                return (DataSet)labFieldsManager.ReturnObject(ClsUtility.theParams, "Pr_IQTouch_Laboratory_GetARVMutationDetails", ClsUtility.ObjectEnum.DataSet);
            }
            throw new NotImplementedException();
        }



        public int IQTouchSaveLabOrderTests(BIQTouchLabFields objLabFields, List<BIQTouchLabFields> labIds, List<BIQTouchLabFields> ArvMutationFields, DataTable theDTGenXpert)
        {
            ClsObject labManagerTest = new ClsObject();
            int theRowAffected = 0;
            int totalRowInserted = 0;
            
            try
            {
                this.Connection = DataMgr.GetConnection();
                this.Transaction = DataMgr.BeginTransaction(this.Connection);

                labManagerTest.Connection = this.Connection;
                labManagerTest.Transaction = this.Transaction;
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@Ptn_pk", SqlDbType.Int, objLabFields.Ptnpk.ToString());
                ClsUtility.AddParameters("@LocationID", SqlDbType.Int, objLabFields.LocationId.ToString());
                ClsUtility.AddParameters("@UserId", SqlDbType.Int, objLabFields.UserId.ToString());
                ClsUtility.AddParameters("@ParameterID", SqlDbType.Int, "0");
                ClsUtility.AddParameters("@OrderedByName", SqlDbType.Int, objLabFields.OrderedByName.ToString());

                if (objLabFields.OrderedByDate.Year.ToString() != "1900")
                {
                    ClsUtility.AddParameters("@OrderedByDate", SqlDbType.VarChar, String.Format("{0:dd-MMM-yyyy}", objLabFields.OrderedByDate));
                }


                ClsUtility.AddParameters("@Flag", SqlDbType.Int, objLabFields.IntFlag.ToString());
                ClsUtility.AddParameters("@LabID", SqlDbType.VarChar, objLabFields.LabTestID.ToString());
                ClsUtility.AddParameters("@FlagExist", SqlDbType.Int, "0");
                if (objLabFields.PreClinicLabDate.Year.ToString() != "1900")
                {
                    ClsUtility.AddParameters("@PreClinicLabDate", SqlDbType.VarChar, String.Format("{0:dd-MMM-yyyy}", objLabFields.PreClinicLabDate));
                }
                ClsUtility.AddParameters("@ReportedBy", SqlDbType.Int, objLabFields.ReportedByName.ToString());
                if (objLabFields.ReportedByDate.Year.ToString() != "1900")
                {
                    ClsUtility.AddParameters("@ReportedByDate", SqlDbType.VarChar, String.Format("{0:dd-MMM-yyyy}",objLabFields.ReportedByDate));
                }

                ClsUtility.AddParameters("@LabOrderId", SqlDbType.Int, objLabFields.LabOrderId.ToString());
                ClsUtility.AddParameters("@TestResults", SqlDbType.VarChar, objLabFields.TestResults);
                ClsUtility.AddParameters("@TestResultId", SqlDbType.Int, objLabFields.TestResultId.ToString());
                ClsUtility.AddParameters("@DeleteFlag", SqlDbType.VarChar, "N");


                theRowAffected = (int)labManagerTest.ReturnObject(ClsUtility.theParams, "Pr_IQTouch_Laboratory_AddLabOrderTests", ClsUtility.ObjectEnum.ExecuteNonQuery);
                totalRowInserted = totalRowInserted + theRowAffected;

                if (labIds.Count > 0)
                {
                    foreach (var Value in labIds)
                    {

                        ClsUtility.Init_Hashtable();
                        ClsUtility.AddParameters("@Ptn_pk", SqlDbType.Int, Value.Ptnpk.ToString());
                        ClsUtility.AddParameters("@LocationID", SqlDbType.Int, Value.LocationId.ToString());
                        ClsUtility.AddParameters("@UserId", SqlDbType.Int, Value.UserId.ToString());
                        ClsUtility.AddParameters("@ParameterID", SqlDbType.Int, Value.SubTestID.ToString());
                        ClsUtility.AddParameters("@OrderedByName", SqlDbType.Int, Value.OrderedByName.ToString());
                        if (Value.OrderedByDate.Year.ToString() != "1900")
                        {
                            ClsUtility.AddParameters("@OrderedByDate", SqlDbType.VarChar, String.Format("{0:dd-MMM-yyyy}",Value.OrderedByDate));
                        }

                        ClsUtility.AddParameters("@Flag", SqlDbType.Int, Value.IntFlag.ToString());
                        ClsUtility.AddParameters("@LabID", SqlDbType.VarChar, Value.LabTestID.ToString());
                        ClsUtility.AddParameters("@FlagExist", SqlDbType.Int, "0");
                        if (Value.PreClinicLabDate.Year.ToString() != "1900")
                        {
                            ClsUtility.AddParameters("@PreClinicLabDate", SqlDbType.VarChar, String.Format("{0:dd-MMM-yyyy}", Value.PreClinicLabDate));
                        }
                        ClsUtility.AddParameters("@ReportedBy", SqlDbType.Int, Value.ReportedByName.ToString());
                        if (Value.ReportedByDate.Year.ToString() != "1900")
                        {
                            ClsUtility.AddParameters("@ReportedByDate", SqlDbType.VarChar, String.Format("{0:dd-MMM-yyyy}",Value.ReportedByDate));
                        }
                        ClsUtility.AddParameters("@LabOrderId", SqlDbType.Int, Value.LabOrderId.ToString());
                        ClsUtility.AddParameters("@TestResults", SqlDbType.VarChar, Value.TestResults);
                        ClsUtility.AddParameters("@TestResultId", SqlDbType.Int, Value.TestResultId.ToString());
                        ClsUtility.AddParameters("@DeleteFlag", SqlDbType.VarChar, Value.Flag.ToString());


                        theRowAffected = (int)labManagerTest.ReturnObject(ClsUtility.theParams, "Pr_IQTouch_Laboratory_AddLabOrderTests", ClsUtility.ObjectEnum.ExecuteNonQuery);
                        totalRowInserted = totalRowInserted + theRowAffected;
                    }
                }
                if (ArvMutationFields.Count > 0)
                {
                    foreach (var ValueArv in ArvMutationFields)
                    {

                        ClsUtility.Init_Hashtable();
                        ClsUtility.AddParameters("@LabOrderId", SqlDbType.Int, ValueArv.LabOrderId.ToString());
                        ClsUtility.AddParameters("@ParameterID", SqlDbType.Int, ValueArv.SubTestID.ToString());
                        ClsUtility.AddParameters("@UserId", SqlDbType.Int, ValueArv.UserId.ToString());
                        ClsUtility.AddParameters("@MutationID", SqlDbType.Int, ValueArv.MutationID.ToString());
                        ClsUtility.AddParameters("@OtherMutation", SqlDbType.VarChar, ValueArv.OtherMutation.ToString());
                        ClsUtility.AddParameters("@DeleteFlag", SqlDbType.VarChar, ValueArv.Flag.ToString());
                        theRowAffected = (int)labManagerTest.ReturnObject(ClsUtility.theParams, "Pr_IQTouch_Laboratory_AddArvMutationDetails", ClsUtility.ObjectEnum.ExecuteNonQuery);
                        totalRowInserted = totalRowInserted + theRowAffected;
                    }
                }

                if (theDTGenXpert.Rows.Count>0)
                {
                    foreach (DataRow theDR in theDTGenXpert.Rows)
                    {
                        ClsUtility.Init_Hashtable();
                        ClsUtility.AddParameters("@LabOrderId", SqlDbType.Int, theDR["LabId"].ToString());
                        ClsUtility.AddParameters("@ABFID", SqlDbType.Int, theDR["ABFID"].ToString());
                        ClsUtility.AddParameters("@ABFText", SqlDbType.Int, theDR["ABFText"].ToString());
                        ClsUtility.AddParameters("@GeneXpertID", SqlDbType.Int, theDR["GeneXpertID"].ToString());
                        ClsUtility.AddParameters("@GeneXpertText", SqlDbType.Int, theDR["GeneXpertText"].ToString());
                        ClsUtility.AddParameters("@CultSens", SqlDbType.Int, theDR["CultSens"].ToString());
                        ClsUtility.AddParameters("@CultSensText", SqlDbType.Int, theDR["CultSensText"].ToString());
                        ClsUtility.AddParameters("@ParameterID", SqlDbType.Int, theDR["ParameterID"].ToString());
                        theRowAffected = (int)labManagerTest.ReturnObject(ClsUtility.theParams, "Pr_IQTouch_Laboratory_AddGenXpertDetails", ClsUtility.ObjectEnum.ExecuteNonQuery);
                        totalRowInserted = totalRowInserted + theRowAffected;
                    }
                }


                DataMgr.CommitTransaction(this.Transaction);
                DataMgr.ReleaseConnection(this.Connection);
                return totalRowInserted;
            }

            catch
            {
                DataMgr.RollBackTransation(this.Transaction);
                throw;
            }
            finally
            {
                if (this.Connection != null)
                    DataMgr.ReleaseConnection(this.Connection);

            }

        }

        public DataSet GetPreDefinedLablist(int SystemId)
        {
            lock (this)
            {
                ClsObject PediatricManager = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@SystemId", SqlDbType.Int, SystemId.ToString());
                return (DataSet)PediatricManager.ReturnObject(ClsUtility.theParams, "pr_Lab_GetPreDefinedLablist", ClsUtility.ObjectEnum.DataSet);
            }
        }
        #endregion
    }
}
