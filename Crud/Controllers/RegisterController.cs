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
    public class RegisterController : Connection
    {
        private SqlConnection con;
        SqlTransaction trans;
        public string ErrorMessage { set; get; }


        public int InserUser(string F_NAME, string USERNAME, string PASSWORD)
        {
            int flag = 0;
            try
            {

                bool f = new_insert_update_command("insert into TBL_REGISTER(FNAME,USERNAME,PASSWORD) " +
                    " values('" + F_NAME.ToUpper() + "','" + USERNAME + "','" + PASSWORD + "')");
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


        public Register Selectuser(bool forDropDown , string username)
        {
            Register skillInfo = new Register();
            DataTable ds = FillDataSet("select * from TBL_REGISTER where USERNAME = '"+ username + "'").Tables[0];
            SkillType_Collection skillTypeList = new SkillType_Collection();
           
            if (ds.Rows.Count > 0)
            {
                foreach (DataRow r in ds.Rows)
                {
                    
                    skillInfo.ID = int.Parse(r["ID"].ToString());
                    skillInfo.FNAME = r["FNAME"].ToString();
                    skillInfo.EMAIL = r["USERNAME"].ToString();
                    skillInfo.PASSWORD = r["PASSWORD"].ToString();
                }
            }
            return skillInfo;
        }
        public class SkillType_Collection : List<Register>
        {
            public void Add(Register st)
            {
                base.Add(st);
            }

        }



    }


}