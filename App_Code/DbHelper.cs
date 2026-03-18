using System;
using System.Configuration;
using System.Data;
using Oracle.ManagedDataAccess.Client;

namespace Kumari_Cinema
{
    public static class DbHelper
    {
      public static string ConnectionString
       => ConfigurationManager.ConnectionStrings["OracleConn"].ConnectionString;

    public static OracleConnection GetConnection()
    {
  return new OracleConnection(ConnectionString);
        }

     public static DataTable ExecuteQuery(string sql, OracleParameter[] parameters = null)
     {
            var dt = new DataTable();
  using (var conn = GetConnection())
        using (var cmd = new OracleCommand(sql, conn))
     {
       cmd.CommandType = CommandType.Text;
 if (parameters != null)
 cmd.Parameters.AddRange(parameters);
       conn.Open();
            using (var da = new OracleDataAdapter(cmd))
     da.Fill(dt);
  }
     return dt;
     }

    public static int ExecuteNonQuery(string sql, OracleParameter[] parameters = null)
        {
     using (var conn = GetConnection())
   using (var cmd = new OracleCommand(sql, conn))
            {
          cmd.CommandType = CommandType.Text;
     if (parameters != null)
       cmd.Parameters.AddRange(parameters);
   conn.Open();
      return cmd.ExecuteNonQuery();
 }
        }

        public static object ExecuteScalar(string sql, OracleParameter[] parameters = null)
 {
     using (var conn = GetConnection())
   using (var cmd = new OracleCommand(sql, conn))
      {
    cmd.CommandType = CommandType.Text;
  if (parameters != null)
       cmd.Parameters.AddRange(parameters);
        conn.Open();
          return cmd.ExecuteScalar();
   }
    }
    }
}
