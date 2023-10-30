using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Crud.ConnectionFolder
{
    public class Connection
    {



        public static bool isDuplicateKey = false;
        public static bool isForignKey = false;
        public static string[] duplicateArray;
        // public LoginInfoControler logInfoCtrl;

        public static string ErrorMessage { set; get; }


        public static bool new_insert_update_command(string command)
        {

            isDuplicateKey = false;
            isForignKey = false;
            try
            {
                SqlConnection con = Connection_Main.set_dbconnection();
                SqlCommand cmd = new SqlCommand(command, con);
                cmd.ExecuteNonQuery();
                con.Close();
                return true;
            }

            catch (SqlException ex)
            {
                if (ex.Number == 1062)
                {
                    isDuplicateKey = true;
                    duplicateArray = ex.Message.Split(' ');
                }
                else if (ex.Number == 1452)
                {
                    isForignKey = true;
                    ex.ToString();
                    //  MessageBox.Show(ex.Message);
                    ErrorMessage = ex.Message;
                }
                else if (ex.Number == 1451)
                {
                    //  ex.ToString();
                    //  MessageBox.Show("Sorry ! You cannot add this.");
                    ////  ErrorMessage = ex.Message;
                    isForignKey = true;
                    ex.ToString();
                    //  MessageBox.Show(ex.Message);
                    ErrorMessage = ex.Message;
                }
                ErrorMessage = ex.Message;
                return false;
            }
            catch (Exception ex)
            {
                ex.ToString();
                // MessageBox.Show(ex.Message);
                ErrorMessage = ex.Message;
                return false;
            }
        }

        public static bool ExecuteUpdateNonQuery(string sql, SqlConnection connection, SqlTransaction transaction)
        {
            bool status = false;
            isDuplicateKey = false;
            isForignKey = false;
            try
            {


                SqlCommand command = new SqlCommand(sql, connection, transaction);
                // command.CommandTimeout = 200;
                int rowAffected = command.ExecuteNonQuery();
                // if (rowAffected > 0)
                status = true;


            }
            catch (SqlException ex)
            {
                status = false;
                //  MessageBox.Show(ex.Message);
                if (ex.Number == 1062)
                    isDuplicateKey = true;
                else if (ex.Number == 1451)
                    isForignKey = true;
                status = false;
                ErrorMessage = ex.Message;
            }

            return status;
        }

        public static DataSet FillDataSet(string select)
        {
            DataSet dataset = new DataSet();
            try
            {
                SqlConnection con = Connection_Main.set_dbconnection();
               SqlCommand cmd = new SqlCommand(select, con);
                SqlDataAdapter data_adapter = new SqlDataAdapter(cmd);
                data_adapter.Fill(dataset);
                con.Close();
            }
            catch (Exception e)
            {
                string error = e.ToString();
                ErrorMessage = e.Message;
                //  MessageBox.Show(e.Message);
            }
            return dataset;
        }





    }
}