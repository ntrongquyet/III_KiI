using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace SQLOnTap
{
    class Provider
    {
        static string ConnectString = @"Data Source=DESKTOP-TFRI6IG\SQLEXPRESS;Initial Catalog=QuanLyHocSinh;Integrated Security=True";
        SqlConnection Connection { get; set; }
        public void Connect()
        {
            try
            {
                if (Connection == null)
                    Connection = new SqlConnection(ConnectString);
                if (Connection != null && Connection.State != ConnectionState.Closed)
                    Connection.Close();
                Connection.Open();
            }
            catch(SqlException ex)
            {
                throw ex;
            }
        }
        public void DisConnect()
        {
            if (Connection != null && Connection.State != ConnectionState.Open)
                Connection.Close();
        }
        public int ExecuteNonQuery(CommandType cmtType,string SQLString,params SqlParameter[]parameters)
        {
            try
            {
                SqlCommand command = Connection.CreateCommand();
                command.CommandText = SQLString;
                command.CommandType = cmtType;
                if (parameters != null && parameters.Length > 0)
                    command.Parameters.AddRange(parameters);
                int nRow = command.ExecuteNonQuery();
                return nRow;
            }
            catch(SqlException ex)
            {
                throw ex;
            }
        }
        public DataTable ExecuteQuery(CommandType cmtType,string SQLString,params SqlParameter[] parameters)
        {
            try
            {
                SqlCommand command = Connection.CreateCommand();
                command.CommandType = cmtType;
                command.CommandText = SQLString;
                if (parameters != null & parameters.Length > 0)
                    command.Parameters.AddRange(parameters);
                SqlDataAdapter da = new SqlDataAdapter(command);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
   }
}
