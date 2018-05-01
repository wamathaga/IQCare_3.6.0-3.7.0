using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
namespace Interface.Clinical
{
    public interface IPatientRegistration
    {
        //IQCare Section
        DataTable GetPatientRecord(int PatientID);

        DataSet GetPatientEnroll(string patientid, int VisitID);
        DataSet GetPatientRegistration(int patientid, int VisitType);
        
        //Removed-21-10-2010
        //int UpdatePatientRegistration(Hashtable ht, DataTable dtCaretype, DataTable dtARTsponsor, DataTable dt, DataTable dtBarrier, int VisitID, int dataquality, DataTable theCustomFieldData);
        //DataTable SaveNewRegistration(Hashtable ht, DataTable dtCaretype, DataTable dtARTsponsor, DataTable dt, DataTable dtBarrier, int dataquality, DataTable theCustomFieldData, Int32 VisitId);
        
        /// ///////////////////////////////////////////////////////////////////////
       
        
        DataSet GetAllDropDowns();
        DataSet GetDuplicatePatientSearchResults(string lastname, string middlename, string firstname, string address, string phone);
        DataSet GetPatientSearchResults(int FId, string lastname, string middlename, string firstname, string enrollment, string gender, DateTime dob, string status, int ModuleId);
        DataSet GetEnrolment(string CountryID, string PossitionID, string SatelliteID, string PatientClinicID, string enrolmentid, int deleteflag);
        DataSet GetAge(DateTime dob, DateTime regdate);
        DataSet GetVisitDate_IELAB(int patientid, int LocationID);
        DataTable theVisitIDDT(string patientid);
        DataSet theDropdown(string ID, string Flag);
        //ExposedInfant Section
        DataSet GetExposedInfantByParentId(int Ptn_Pk);
        DataSet GetMaxAutoPopulateIdentifier(string columnname);
        int DeleteExposedInfantById(int Id);
        int SaveExposedInfant(int Id, int Ptn_Pk, int ExposedInfantId, string FirstName, string LastName, DateTime DOB, string FeedingPractice3mos,
            string CTX2mos, string HIVTestType, string HIVResult, string FinalStatus, DateTime? DeathDate, int UserID);

        //CTC Section
        DataTable SavePatientRegistrationCTC(Hashtable ht, int Flag, DataTable theCustomFieldData);
        DataSet GetPatientDetailsCTC(string patientId, string CountryID, string PosID, string SatelliteID, string PatientClinicID, int Existflag, int VisitID);
        DataSet GetDrugGenericCTC();
        //PMTCT Section
        DataTable SavePatientRegistrationPMTCT(Hashtable ht, DataTable theCustomFieldData);
        DataSet GetPatientRegistrationPMTCT(int patientId);
        //DataTable UpdatePatientRegistrationPMTCT(Hashtable ht, DataTable theCustomFieldData);
        DataTable Validate(string Argument, string Flag);
        DataSet GetChildDetail(int patientid, int LocationID);
        DataSet SaveInfantInfo(Int64 PatientId, Int64 LocationID, Int64 VisitId, Int64 ParentId, Int64 UserID);
        int DeleteInfantInfo(int PatientId, int UserID);
        //Added on 21-10-2010
        DataSet GetPatientTechnicalAreaDetails(int patientid, string ModuleName, int ModuleID);
        DataTable SaveNewRegistration(Hashtable ht, DataTable dtCaretype, DataTable dtARTsponsor, DataTable dt, DataTable dtBarrier, int dataquality, DataTable theCustomFieldData);
        DataSet InsertUpdatePatientRegistration(Hashtable ht, DataTable dtCaretype, DataTable dtARTsponsor, DataTable dt, DataTable dtBarrier, int VisitID, int dataquality, DataTable theCustomFieldData);
        DataTable SaveNewRegistration(Hashtable ht, int dataquality);
        int UpdatePatientRegistration(Hashtable ht, int Ptn_Pk, int VisitID, int dataquality);
        DataTable SaveUpdateTechnicalArea(Hashtable ht, int VisitID);
        DataSet GetFieldNames(int ModuleID,int patientId);
        DataSet GetModuleNames(int FacilityID);
        DataSet GetModuleNames(int FacilityID, int UserId);
        DataTable CheckDuplicateIdentifiervaule(string Columnname, string Columnvalue);
        DataSet GetFieldName_and_Label(int FeatureID, int PatientID);
        DataSet Common_GetSaveUpdateforCustomRegistrion(string Insert);
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        DataSet CheckIdentity(string ExposedInfantId);
        
         
        
      }
}
