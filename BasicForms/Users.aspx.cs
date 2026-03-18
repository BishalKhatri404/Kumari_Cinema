using System;
using System.Data;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;

namespace Kumari_Cinema.BasicForms
{
    public partial class Users : System.Web.UI.Page
    {
     protected void Page_Load(object sender, EventArgs e)
        {
          if (!IsPostBack) BindGrid();
   }

        private void BindGrid()
      {
   var dt = DbHelper.ExecuteQuery(
          "SELECT USERID, USERNAME, PHONE, EMAIL, AGE FROM Users ORDER BY USERID");
            gvUsers.DataSource = dt;
         gvUsers.DataBind();
}

        protected void btnSave_Click(object sender, EventArgs e)
        {
        int id = int.Parse(hfUserId.Value);
      try
            {
      if (id == 0)
          {
         DbHelper.ExecuteNonQuery(
         "INSERT INTO Users (USERID, USERNAME, PHONE, EMAIL, AGE) " +
   "VALUES ((SELECT NVL(MAX(USERID),0)+1 FROM Users), :un, :ph, :em, :ag)",
     new[]
   {
             new OracleParameter("un", txtUserName.Text.Trim()),
    new OracleParameter("ph", txtPhone.Text.Trim()),
      new OracleParameter("em", txtEmail.Text.Trim()),
               new OracleParameter("ag", string.IsNullOrWhiteSpace(txtAge.Text) ? (object)DBNull.Value : int.Parse(txtAge.Text))
         });
    ShowMsg("User added successfully.", false);
   }
      else
      {
               DbHelper.ExecuteNonQuery(
                  "UPDATE Users SET USERNAME=:un, PHONE=:ph, EMAIL=:em, AGE=:ag WHERE USERID=:id",
     new[]
         {
    new OracleParameter("un", txtUserName.Text.Trim()),
  new OracleParameter("ph", txtPhone.Text.Trim()),
      new OracleParameter("em", txtEmail.Text.Trim()),
       new OracleParameter("ag", string.IsNullOrWhiteSpace(txtAge.Text) ? (object)DBNull.Value : int.Parse(txtAge.Text)),
         new OracleParameter("id", id)
 });
           ShowMsg("User updated successfully.", false);
                }
         }
   catch (Exception ex) { ShowMsg("Error: " + ex.Message, true); }
            ResetForm();
            BindGrid();
   }

        protected void btnCancel_Click(object sender, EventArgs e) { ResetForm(); }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
         int id = int.Parse(e.CommandArgument.ToString());
            if (e.CommandName == "EditRow")
    {
     var dt = DbHelper.ExecuteQuery(
              "SELECT * FROM Users WHERE USERID = :id",
  new[] { new OracleParameter("id", id) });
                if (dt.Rows.Count > 0)
     {
             DataRow r = dt.Rows[0];
          hfUserId.Value = id.ToString();
       txtUserName.Text = r["USERNAME"].ToString();
   txtPhone.Text = r["PHONE"].ToString();
       txtEmail.Text = r["EMAIL"].ToString();
     txtAge.Text = r["AGE"] == DBNull.Value ? "" : r["AGE"].ToString();
        lblFormTitle.Text = "Edit User (ID: " + id + ")";
      }
            }
  else if (e.CommandName == "DeleteRow")
       {
   try
 {
      DbHelper.ExecuteNonQuery("DELETE FROM Users WHERE USERID = :id",
      new[] { new OracleParameter("id", id) });
          ShowMsg("User deleted.", false);
       }
        catch (Exception ex) { ShowMsg("Cannot delete - may have related bookings. " + ex.Message, true); }
       BindGrid();
       }
    }

        private void ResetForm()
        {
            hfUserId.Value = "0";
        txtUserName.Text = txtEmail.Text = txtPhone.Text = txtAge.Text = "";
            lblFormTitle.Text = "Add New User";
        }

        private void ShowMsg(string msg, bool isError)
        {
 lblMsg.Text = msg;
   lblMsg.Visible = true;
       lblMsg.Style["color"] = isError ? "#ff4444" : "#ffd700";
        }
  }
}
