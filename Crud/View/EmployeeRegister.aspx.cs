using Crud.ConnectionInfo;
using Crud.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Crud.View
{
    public partial class EmployeeRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static string SaveEmployee(string FULL_NAME, string SLMCNO, string POSITION, string EMAIL, string CONTACT_NO, string USERNAME, string PASSWORD)
        {
            string returnMsg = "";
            EmployeeControler EmpTypeCtrl = new EmployeeControler();

            try
            {
                int flag = 0;

                
                    flag = EmpTypeCtrl.InserEmployee(FULL_NAME, SLMCNO, POSITION, EMAIL, CONTACT_NO, USERNAME, PASSWORD);
                    if (flag == 0)
                    {
                        returnMsg = EmpTypeCtrl.ErrorMessage;
                    }
                    else if (flag == 1)
                    {
                        returnMsg = "OK";
                    }
                    else
                    {
                        returnMsg = "Duplicate";
                    }

                

            }
            catch (Exception ee)
            {
                returnMsg = ee.Message;
            }
            return returnMsg;
        }










    }
}