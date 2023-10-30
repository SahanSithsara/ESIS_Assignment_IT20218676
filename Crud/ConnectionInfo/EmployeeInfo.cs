using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Crud.ConnectionInfo
{
    public class EmployeeInfo
    {

        public int ID { get; set; }

        public string FULL_NAME { get; set; }
        public string SLMCNO { get; set; }
        public string POSITION { get; set; }
        public string EMAIL { get; set; }
        public string CONTACT_NO { get; set; }
        public string USERNAME { get; set; }
        public int IsACTIVE { get; set; }
        //ID,FULL_NAME,SLMCNO,POSITION,EMAIL,CONTACT_NO,USERNAME,IsACTIVE
        //    TBL_EMPLOYEE

    }
}