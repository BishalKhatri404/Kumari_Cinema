using System;
using System.Data;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;

namespace Kumari_Cinema.BasicForms
{
    public partial class Tickets : System.Web.UI.Page
    {
    protected void Page_Load(object sender, EventArgs e)
        {
     if (!IsPostBack) { LoadDropdowns(); BindGrid(); }
  }

   private void LoadDropdowns()
   {
     var bookings = DbHelper.ExecuteQuery(@"
SELECT B.BOOKINGID, 'Booking#' || B.BOOKINGID || ' - ' || U.USERNAME || ' (' || TO_CHAR(B.BOOKINGDATE,'DD/MM/YY') || ')' AS LABEL
FROM Booking B JOIN Users U ON U.USERID = B.USERID ORDER BY B.BOOKINGDATE DESC");
    ddlBooking.DataSource = bookings;
ddlBooking.DataTextField = "LABEL"; ddlBooking.DataValueField = "BOOKINGID";
 ddlBooking.DataBind();
     ddlBooking.Items.Insert(0, new ListItem("-- Select Booking --", ""));

var seats = DbHelper.ExecuteQuery("SELECT SEATID, SEATROW || SEATNUMBER AS LABEL FROM Seat ORDER BY SEATROW, SEATNUMBER");
        ddlSeat.DataSource = seats;
     ddlSeat.DataTextField = "LABEL"; ddlSeat.DataValueField = "SEATID";
     ddlSeat.DataBind();
    ddlSeat.Items.Insert(0, new ListItem("-- Select Seat --", ""));

     var pricing = DbHelper.ExecuteQuery("SELECT PRICEID, 'Rs.' || AMOUNT || ' (' || PAYMENTSTATUS || ')' AS LABEL FROM Pricing ORDER BY PRICEID");
     ddlPricing.DataSource = pricing;
  ddlPricing.DataTextField = "LABEL"; ddlPricing.DataValueField = "PRICEID";
  ddlPricing.DataBind();
     ddlPricing.Items.Insert(0, new ListItem("-- Select Pricing --", ""));
   }

  private void BindGrid()
    {
 var dt = DbHelper.ExecuteQuery(@"
SELECT T.TICKETID, T.TICKETNUMBER, T.TICKETSTATUS, T.BOOKINGID,
 U.USERNAME, SE.SEATROW || SE.SEATNUMBER AS SEATLABEL, P.AMOUNT
FROM Ticket T
JOIN Booking B ON B.BOOKINGID = T.BOOKINGID
JOIN Users U ON U.USERID = B.USERID
JOIN Seat SE ON SE.SEATID = T.SEATID
JOIN Pricing P ON P.PRICEID = T.PRICEID
ORDER BY T.TICKETID DESC");
       gvTickets.DataSource = dt;
     gvTickets.DataBind();
        }

  protected void btnSave_Click(object sender, EventArgs e)
      {
  int id = int.Parse(hfTicketId.Value);
  try
    {
   if (id == 0)
     {
 DbHelper.ExecuteNonQuery(
"INSERT INTO Ticket (TICKETID, BOOKINGID, TICKETNUMBER, TICKETSTATUS, PRICEID, SEATID) " +
"VALUES ((SELECT NVL(MAX(TICKETID),0)+1 FROM Ticket), :bi, :tn, :ts, :pi, :si)",
 new[]
         {
   new OracleParameter("bi", int.Parse(ddlBooking.SelectedValue)),
    new OracleParameter("tn", txtTicketNumber.Text.Trim()),
      new OracleParameter("ts", ddlTicketStatus.SelectedValue),
 new OracleParameter("pi", int.Parse(ddlPricing.SelectedValue)),
      new OracleParameter("si", int.Parse(ddlSeat.SelectedValue))
     });
       ShowMsg("Ticket issued.", false);
    }
 else
     {
    DbHelper.ExecuteNonQuery(
"UPDATE Ticket SET BOOKINGID=:bi, TICKETNUMBER=:tn, TICKETSTATUS=:ts, PRICEID=:pi, SEATID=:si WHERE TICKETID=:id",
   new[]
    {
 new OracleParameter("bi", int.Parse(ddlBooking.SelectedValue)),
      new OracleParameter("tn", txtTicketNumber.Text.Trim()),
     new OracleParameter("ts", ddlTicketStatus.SelectedValue),
    new OracleParameter("pi", int.Parse(ddlPricing.SelectedValue)),
    new OracleParameter("si", int.Parse(ddlSeat.SelectedValue)),
         new OracleParameter("id", id)
       });
     ShowMsg("Ticket updated.", false);
    }
    }
     catch (Exception ex) { ShowMsg(ex.Message, true); }
    ResetForm(); BindGrid();
    }

   protected void btnCancel_Click(object sender, EventArgs e) { ResetForm(); }

    protected void gvTickets_RowCommand(object sender, GridViewCommandEventArgs e)
        {
     int id = int.Parse(e.CommandArgument.ToString());
 if (e.CommandName == "EditRow")
  {
   var dt = DbHelper.ExecuteQuery("SELECT * FROM Ticket WHERE TICKETID=:id", new[] { new OracleParameter("id", id) });
  if (dt.Rows.Count > 0)
  {
   DataRow r = dt.Rows[0];
   hfTicketId.Value = id.ToString();
  ddlBooking.SelectedValue = r["BOOKINGID"].ToString();
  txtTicketNumber.Text = r["TICKETNUMBER"].ToString();
    ddlTicketStatus.SelectedValue = r["TICKETSTATUS"].ToString();
      ddlPricing.SelectedValue = r["PRICEID"].ToString();
    ddlSeat.SelectedValue = r["SEATID"].ToString();
   lblFormTitle.Text = "Edit Ticket (ID:" + id + ")";
   }
  }
            else if (e.CommandName == "DeleteRow")
   {
   try { DbHelper.ExecuteNonQuery("DELETE FROM Ticket WHERE TICKETID=:id", new[] { new OracleParameter("id", id) }); ShowMsg("Ticket deleted.", false); }
    catch (Exception ex) { ShowMsg(ex.Message, true); }
  BindGrid();
  }
        }

  private void ResetForm()
   {
  hfTicketId.Value = "0"; txtTicketNumber.Text = "";
ddlBooking.SelectedIndex = ddlSeat.SelectedIndex = ddlPricing.SelectedIndex = 0;
        ddlTicketStatus.SelectedIndex = 0;
   lblFormTitle.Text = "Issue New Ticket";
  }

  private void ShowMsg(string msg, bool isError)
  { lblMsg.Text = msg; lblMsg.Visible = true; lblMsg.Style["color"] = isError ? "#ff4444" : "#ffd700"; }
    }
}
