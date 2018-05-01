using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base;
using System.Data;
using DataAccess.Entity;
using DataAccess.Common;
using Application.Common;
using Interface.NDR;

namespace BusinessProcess.NDR
{
    public class BNDRGeneration : ProcessBase, INDRGeneration
    {
        public BNDRGeneration()
        {

        }

        public DataSet GetPatientDetails(int facilityID)
        {
            lock (this)
            {
                ClsObject clsObject = new ClsObject();
                ClsUtility.Init_Hashtable();
                ClsUtility.AddParameters("@FacilityId", SqlDbType.Int, facilityID.ToString());
                ClsUtility.AddParameters("@DBKey", SqlDbType.VarChar, ApplicationAccess.DBSecurity);
                ClsObject UserManager = new ClsObject();
                return (DataSet)clsObject.ReturnObject(ClsUtility.theParams, "pr_NDR_GetPatientDetails", ClsDBUtility.ObjectEnum.DataSet);
            }
        }
    }
}
