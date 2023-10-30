using Crud.ConnectionFolder;
using Crud.ConnectionInfo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Crud.Controllers
{
    public class EmployeeControler : Connection
    {
        private SqlConnection con;
        SqlTransaction trans;
        public string ErrorMessage { set; get; }





        public int InserEmployee(string FULL_NAME, string SLMCNO, string POSITION, string EMAIL, string CONTACT_NO, string USERNAME,string PASSWORD)
        {
            int flag = 0;
            try
            {

                //ID,FULL_NAME,SLMCNO,POSITION,EMAIL,CONTACT_NO,USERNAME,PASSWORD,IsACTIVE
                //    TBL_EMPLOYEE
                bool f = new_insert_update_command("insert into TBL_EMPLOYEE(FULL_NAME,SLMCNO,POSITION,EMAIL,CONTACT_NO,USERNAME,PASSWORD,IsACTIVE) " +
                    " values('" + FULL_NAME.ToUpper() + "','" + SLMCNO.ToUpper() + "','" + POSITION.ToUpper() + "','" + EMAIL + "','" + CONTACT_NO + "','" + USERNAME.ToUpper() + "','" + PASSWORD + "','1')");
                if (f)
                    flag = 1;
                else
                {
                    if (isDuplicateKey)
                        flag = 2;
                    else
                        flag = 0;
                    this.ErrorMessage = Connection.ErrorMessage;
                }
            }
            catch (Exception e)
            {
                flag = 0;
                this.ErrorMessage = e.Message;
            }
            return flag;
        }
  
    }


}