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
    public class SkillTypeControler : Connection
    {
        private SqlConnection con;
        SqlTransaction trans;
        public string ErrorMessage { set; get; }



        public SkillTypeInfo[] SelectAllSkillTypeList(bool forDropDown)
        {
            DataTable ds = FillDataSet("select * from tbl_skill_type").Tables[0];
            SkillType_Collection skillTypeList = new SkillType_Collection();
            if (forDropDown)
            {
                SkillTypeInfo skillInfo = new SkillTypeInfo() { ID = 0, SkillTypeName = "-Select Skill Type-" };
                skillTypeList.Add(skillInfo);
            }
            if (ds.Rows.Count > 0)
            {
                foreach (DataRow r in ds.Rows)
                {
                    SkillTypeInfo skillInfo = new SkillTypeInfo();
                    skillInfo.ID = int.Parse(r["ID"].ToString());
                    skillInfo.SkillTypeName = r["SkillTypeName"].ToString();
                    skillInfo.SkillTypeDescription = r["Description"].ToString();
                    skillTypeList.Add(skillInfo);
                }
            }
            return skillTypeList.ToArray();
        }






        public int InsertNewSkillType(string skillTypeName, string decription)
        {
            int flag = 0;
            try
            {
                bool f = new_insert_update_command("insert into tbl_skill_type(SkillTypeName,Description)  values('" + skillTypeName + "','" + decription + "')");
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

        public bool DeleteSkillType(string[] skilltypeList)
        {
            this.con = Connection_Main.set_dbconnection();
            this.trans = this.con.BeginTransaction();
            string sql = "";
            bool f = false;
            try
            {
                if (skilltypeList.Length > 0)
                {
                    for (int a = 0; a < skilltypeList.Length; a++)
                    {
                        sql = "delete from tbl_skill_type where ID='" + skilltypeList[a] + "'";
                        f = ExecuteUpdateNonQuery(sql, this.con, this.trans);
                        if (!f)
                        {
                            this.ErrorMessage = Connection.ErrorMessage;
                            break;
                        }
                    }
                }
            }
            catch (Exception e)
            {
                f = false;
                this.ErrorMessage = e.Message;
            }
            finally
            {
                if (f)
                    this.trans.Commit();
                else
                    this.trans.Rollback();
                this.con.Close();
                this.trans.Dispose();
            }
            return f;
        }

        /// <summary>
        /// Update existing skill type details.
        /// </summary>
        /// <param name="skillTypeName">new skill type name</param>
        /// <param name="skillTypeID">existing skill type ID</param>
        /// <param name="desc">new description</param>
        /// <returns>0-any error,1-success,2-duplicate skill type</returns>
        /// CREATED BY SAMEERA 2018-09-11
        public int UpdateSkillType(string skillTypeName, string skillTypeID, string desc)
        {
            int flag = 0;
            try
            {
                bool f = new_insert_update_command("update tbl_skill_type set SkillTypeName='" + skillTypeName + "',Description='" + desc + "' where ID ='" + skillTypeID + "'");
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

    public class SkillType_Collection : List<SkillTypeInfo>
    {
        public void Add(SkillTypeInfo st)
        {
            base.Add(st);
        }

    }


}