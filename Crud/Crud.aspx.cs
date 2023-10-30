using Crud.ConnectionFolder;
using Crud.ConnectionInfo;
using Crud.Controllers;
using Microsoft.Exchange.WebServices.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;




namespace Crud
{
    public partial class Crud : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
           
        }


        [WebMethod]
        public static string get_skill_list()
        {
            string returnString = "";
            var uInfo = HttpContext.Current.Session["RegUser"];

           
                
                    string table = "<table cellspacing='0' rules='all' class='table table-bordered table-hover' border='1' id='gridList' name='gridList' style='border-collapse: collapse;'>";
                    table = table + "<tbody><tr class='gridHeader'><th scope='col'>&nbsp;</th><th scope='col'>Skill Type Name</th><th scope='col'>Description</th></tr>";

                    SkillTypeControler lCtrl = new SkillTypeControler();
                    SkillTypeInfo[] skillTypeInfoList = lCtrl.SelectAllSkillTypeList(false);
                    if (skillTypeInfoList.Length > 0)
                    {
                        for (int a = 0; a < skillTypeInfoList.Length; a++)
                        {
                            if (a % 2 == 0)
                                table = table + "<tr class='gridRow'>";
                            else
                                table = table + "<tr class='GridAlernativeRow'>";
                            table = table + "<td><input id='ContentPlaceHolder1_ChildContent1_CompanyGrid_CheckBox1_0' type='checkbox' > </td>";
                            table = table + "<td><input type='hidden' value='" + skillTypeInfoList[a].ID.ToString() + "'/><a href=''>" + skillTypeInfoList[a].SkillTypeName + "</a></td>";
                            table = table + "<td>" + skillTypeInfoList[a].SkillTypeDescription + "</td></tr>";
                        }
                    }
                    returnString = table + "</tbody></table>";
                
           
            return returnString;
        }


        [WebMethod]
        public static string DeleteSkillType(string[] deleteList)
        {
            string returnMsg = "";
            var uInfo = HttpContext.Current.Session["RegUser"];

                    try
                    {
                        SkillTypeControler skillTypeCtrl = new SkillTypeControler();
                        bool flag = skillTypeCtrl.DeleteSkillType(deleteList);
                        if (flag)
                            return "OK";
                        else
                            returnMsg = skillTypeCtrl.ErrorMessage;
                    }
                    catch (Exception ee)
                    {
                        returnMsg = ee.Message;
                    }
                
           
            return returnMsg;
        }

        [WebMethod]
        public static string InsertSkillType(string skillTypeName, string ClickType, string skillTypeId, string desc)
        {
            string returnMsg = "";
            SkillTypeControler skillTypeCtrl = new SkillTypeControler();

            try
            {
                int flag = 0;

                if (ClickType == "Save")
                    {
                         
                           flag = skillTypeCtrl.InsertNewSkillType(skillTypeName, desc);
                            if (flag == 0)
                            {
                                returnMsg = skillTypeCtrl.ErrorMessage;
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
                    else if (ClickType == "Update")
                    {

                            flag = skillTypeCtrl.UpdateSkillType(skillTypeName, skillTypeId, desc);
                            if (flag == 0)
                            {
                                returnMsg = skillTypeCtrl.ErrorMessage;
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
                
            }
            catch (Exception ee)
            {
                returnMsg = ee.Message;
            }
            return returnMsg;
        }




















    }
}