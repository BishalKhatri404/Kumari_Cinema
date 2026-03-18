using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

namespace Kumari_Cinema.ComplexForms
{
    public partial class UserTicket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
 if (!IsPostBack) LoadUsers();
  }

    private void LoadUsers()
        {
   var dt = DbHelper.ExecuteQuery("SELECT USERID, USERID || ' - ' || USERNAME AS LABEL FROM Users ORDER BY USERID");
        ddlUser.DataSource = dt;
     ddlUser.DataTextField = "LABEL"; ddlUser.DataValueField = "USERID";
  ddlUser.DataBind();
       ddlUser.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select User --", ""));
        }

  protected void btnSearch_Click(object sender, EventArgs e)
      {
     string uid = !string.IsNullOrWhiteSpace(txtUserId.Text) ? txtUserId.Text.Trim() : ddlUser.SelectedValue;
     if (string.IsNullOrWhiteSpace(uid))
     {
     ShowMsg("Please select or enter a User ID.", true);
     return;
   }

     int userId = int.Parse(uid);

     // Exact coursework query
   var dt = DbHelper.ExecuteQuery(@"
SELECT U.USERID, U.USERNAME, U.PHONE, U.EMAIL, U.AGE,
       T.TICKETID, T.TICKETNUMBER, T.TICKETSTATUS, B.BOOKINGDATE, P.AMOUNT
FROM Users U
JOIN Booking B ON U.USERID = B.USERID
JOIN Ticket T ON B.BOOKINGID = T.BOOKINGID
JOIN Pricing P ON T.PRICEID = P.PRICEID
WHERE U.USERID = :UserID
  AND B.BOOKINGDATE BETWEEN ADD_MONTHS(SYSDATE, -6) AND SYSDATE
  AND P.PAYMENTSTATUS = 'PAID'",
  new[] { new OracleParameter("UserID", userId) });

  if (dt.Rows.Count > 0)
  {
      DataRow first = dt.Rows[0];
     lblUID.Text = first["USERID"].ToString();
  lblUName.Text = first["USERNAME"].ToString();
 lblUPhone.Text = first["PHONE"].ToString();
    lblUEmail.Text = first["EMAIL"].ToString();
       lblUAge.Text = first["AGE"] == DBNull.Value ? "-" : first["AGE"].ToString();
        pnlUserDetail.Visible = true;

       gvUserTickets.DataSource = dt;
     gvUserTickets.DataBind();
   pnlGrid.Visible = true;
          lblMsg.Visible = false;
   }
  else
  {
      pnlUserDetail.Visible = false;
      pnlGrid.Visible = false;
  ShowMsg("No paid tickets found for User ID " + userId + " in the last 6 months.", true);
 }
   }

      private void ShowMsg(string msg, bool isError)
   {
            lblMsg.Text = msg; lblMsg.Visible = true;
     lblMsg.Style["color"] = isError ? "#ff4444" : "#ffd700";
     pnlUserDetail.Visible = pnlGrid.Visible = false;
        }
    }
}
