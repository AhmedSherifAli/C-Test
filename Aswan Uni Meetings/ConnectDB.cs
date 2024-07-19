using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Aswan_Uni_Meetings
{
    public class ConnectDB
    {
        // Inserat , Update , Delete from DB
        public void ExecuteData(string stored_procuder, SqlParameter[] param)
        {
            string ConnectionString = "con";
            string strcon = ConfigurationManager.ConnectionStrings[ConnectionString].ConnectionString;
            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();
                SqlCommand sqlcmd = new SqlCommand();
                sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                sqlcmd.CommandText = stored_procuder;
                sqlcmd.Connection = con;
                if (param != null)
                {
                    sqlcmd.Parameters.AddRange(param);
                }
                sqlcmd.ExecuteNonQuery();
            }
        }

        // Selection Tables From DB
        public DataSet SelectData(string stored_procuder, SqlParameter[] param)
        {
            string ConnectionString = "con";
            string strcon = ConfigurationManager.ConnectionStrings[ConnectionString].ConnectionString;
            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();
                SqlCommand sqlcmd = new SqlCommand();
                sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                sqlcmd.CommandText = stored_procuder;
                sqlcmd.Connection = con;
                if (param != null)
                {
                    sqlcmd.Parameters.AddRange(param);
                }
                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                return ds;
            }
        }

        public DataTable SelectDataOne(string stored_procuder, SqlParameter[] param)
        {
            string ConnectionString = "con";
            string strcon = ConfigurationManager.ConnectionStrings[ConnectionString].ConnectionString;
            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();
                SqlCommand sqlcmd = new SqlCommand();
                sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                sqlcmd.CommandText = stored_procuder;
                sqlcmd.Connection = con;
                if (param != null)
                {
                    sqlcmd.Parameters.AddRange(param);
                }
                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
                DataTable ds = new DataTable();
                da.Fill(ds);
                return ds;
            }
        }
    }
}