using Crud.ConnectionInfo;
using Crud.Controllers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Crud.View
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static string SaveUser(string F_NAME, string USERNAME, string PASSWORD)
        {
            string Username = "";
            string Password = "";

            if(USERNAME != null)
            {
                Username = Encrypt(USERNAME, "ThisIsASecretKey");
            }
            if (PASSWORD != null)
            {
                Password = Encrypt(PASSWORD, "ThisIsASecretKey");
            }

            string returnMsg = "";
            RegisterController EmpTypeCtrl = new RegisterController();
            try
            {
                int flag = 0;
                flag = EmpTypeCtrl.InserUser(F_NAME, Username, Password);
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


        public static string Encrypt(string plainText, string key)
        {
            using (AesCryptoServiceProvider aesAlg = new AesCryptoServiceProvider())
            {
                aesAlg.Key = Encoding.UTF8.GetBytes(key);
                aesAlg.IV = new byte[16]; // Initialization Vector

                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

                using (MemoryStream msEncrypt = new MemoryStream())
                {
                    using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                        {
                            swEncrypt.Write(plainText);
                        }
                    }

                    return Convert.ToBase64String(msEncrypt.ToArray());
                }
            }
        }

        [WebMethod]
        public static string get_User( string txtlogun, string txtpw)
        {
            string returnString = "";
            var uInfo = HttpContext.Current.Session["RegUser"];
            string txtlogun2 = Encrypt(txtlogun, "ThisIsASecretKey");
            List<Register> user = new List<Register>();
            RegisterController lCtrl = new RegisterController();
            Register UserList = lCtrl.Selectuser(false, txtlogun2);

            string fname = UserList.FNAME.ToString();
            string Un = UserList.EMAIL.ToString();
            string pw = UserList.PASSWORD.ToString();

            if (txtlogun == Decrypt( Un, "ThisIsASecretKey")  && txtpw == Decrypt(pw, "ThisIsASecretKey"))
            {
                returnString = "OK";
            }



            return returnString;
        }


        public static string Decrypt(string cipherText, string key)
        {
            using (AesCryptoServiceProvider aesAlg = new AesCryptoServiceProvider())
            {
                aesAlg.Key = Encoding.UTF8.GetBytes(key);
                aesAlg.IV = new byte[16]; // Initialization Vector

                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

                using (MemoryStream msDecrypt = new MemoryStream(Convert.FromBase64String(cipherText)))
                {
                    using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {
                            return srDecrypt.ReadToEnd();
                        }
                    }
                }
            }
        }




    }
}