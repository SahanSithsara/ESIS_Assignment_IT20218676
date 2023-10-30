using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Windows.Forms;

namespace Crud.ConnectionFolder
{
    public class Connection_Main
    {

        public static string conString = "DESKTOP-HLDF9KI";
        public static string database = "PRINTME";
        public static string password = "123";
        public static string userName = "sa";

        public static SqlConnection set_dbconnection()
        {


        //------------------database connection string for server------------------------------------
       // String my_con = "Host=" + conString + "; UserName=" + userName + "; Port=44308;  Password=" + password + ";Database=" + database + ";CharSet=utf8;";

          //  String my_con = "Host=DESKTOP-HLDF9KI; UserName=sa; Port=44308;  Password=123 ;Database=CrudDemo; Trusted_Connection=True;";
            String my_con = "Server = DESKTOP-HLDF9KI; Database = PRINTME; User Id = sa; Password = 123; Trusted_Connection=True;";
            
            //DESKTOP-HLDF9KI

            SqlConnection con = new SqlConnection(my_con);
            try
            {
                if (con.State.ToString() != "Open")
                {
                    con.Open();
                }
                if (conString == null)
                {
                    MessageBox.Show("Cannot Create database access.\nHost Name = " + conString + "\nPlease check the network connection and try again !", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);

                }
            }
            catch (Exception e)
            {
                e.ToString();
                MessageBox.Show("Cannot Create database access.\nHost Name = " + conString + "\nPlease check the network connection and try again !", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                //Application.Exit();
            }
            return con;
        }


    }
}