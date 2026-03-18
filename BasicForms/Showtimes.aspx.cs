using System;
using System.Data;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;

namespace Kumari_Cinema.BasicForms
{
    public partial class Showtimes : System.Web.UI.Page
    {
   protected void Page_Load(object sender, EventArgs e)
        {
 if (!IsPostBack) { LoadDropdowns(); BindGrid(); }
        }

  private void LoadDropdowns()
        {
   var movies = DbHelper.ExecuteQuery("SELECT MOVIEID, TITLE FROM Movie ORDER BY TITLE");
  ddlMovie.DataSource = movies;
 ddlMovie.DataTextField = "TITLE"; ddlMovie.DataValueField = "MOVIEID";
  ddlMovie.DataBind();
    ddlMovie.Items.Insert(0, new ListItem("-- Select Movie --", ""));

   var halls = DbHelper.ExecuteQuery(@"
SELECT h.HALLID, h.HALLNAME || ' - ' || t.THEATRENAME AS LABEL
FROM Hall h JOIN Theatre t ON t.THEATREID = h.THEATREID ORDER BY t.THEATRENAME, h.HALLNAME");
     ddlHall.DataSource = halls;
ddlHall.DataTextField = "LABEL"; ddlHall.DataValueField = "HALLID";
  ddlHall.DataBind();
     ddlHall.Items.Insert(0, new ListItem("-- Select Hall --", ""));

      var theatres = DbHelper.ExecuteQuery("SELECT THEATREID, THEATRENAME || ' (' || THEATRECITY || ')' AS LABEL FROM Theatre ORDER BY THEATRENAME");
     ddlTheatre.DataSource = theatres;
   ddlTheatre.DataTextField = "LABEL"; ddlTheatre.DataValueField = "THEATREID";
     ddlTheatre.DataBind();
       ddlTheatre.Items.Insert(0, new ListItem("-- Select Theatre --", ""));
        }

        private void BindGrid()
   {
   var dt = DbHelper.ExecuteQuery(@"
SELECT s.SHOWID, m.TITLE, h.HALLNAME, t.THEATRENAME, s.SHOWDATE, s.SHOWTIME
FROM Show_ s
JOIN Movie m ON m.MOVIEID = s.MOVIEID
JOIN Hall h ON h.HALLID = s.HALLID
JOIN Theatre t ON t.THEATREID = s.THEATREID
ORDER BY s.SHOWDATE DESC, s.SHOWTIME");
     gvShows.DataSource = dt;
         gvShows.DataBind();
 }

        protected void btnSave_Click(object sender, EventArgs e)
   {
     int id = int.Parse(hfShowId.Value);
   DateTime showDate;
      bool hasDate = DateTime.TryParse(txtShowDate.Text, out showDate);
 try
    {
      if (id == 0)
        {
      DbHelper.ExecuteNonQuery(
"INSERT INTO Show_ (SHOWID, SHOWDATE, SHOWTIME, MOVIEID, HALLID, THEATREID) " +
"VALUES ((SELECT NVL(MAX(SHOWID),0)+1 FROM Show_), :sd, :st, :mi, :hi, :ti)",
   new[]
    {
     new OracleParameter("sd", hasDate ? (object)showDate : DBNull.Value),
      new OracleParameter("st", txtShowTime.Text.Trim()),
    new OracleParameter("mi", int.Parse(ddlMovie.SelectedValue)),
  new OracleParameter("hi", int.Parse(ddlHall.SelectedValue)),
       new OracleParameter("ti", int.Parse(ddlTheatre.SelectedValue))
    });
       ShowMsg("Showtime added.", false);
   }
    else
    {
     DbHelper.ExecuteNonQuery(
"UPDATE Show_ SET SHOWDATE=:sd, SHOWTIME=:st, MOVIEID=:mi, HALLID=:hi, THEATREID=:ti WHERE SHOWID=:id",
new[]
   {
    new OracleParameter("sd", hasDate ? (object)showDate : DBNull.Value),
new OracleParameter("st", txtShowTime.Text.Trim()),
  new OracleParameter("mi", int.Parse(ddlMovie.SelectedValue)),
     new OracleParameter("hi", int.Parse(ddlHall.SelectedValue)),
     new OracleParameter("ti", int.Parse(ddlTheatre.SelectedValue)),
  new OracleParameter("id", id)
});
        ShowMsg("Showtime updated.", false);
 }
     }
     catch (Exception ex) { ShowMsg(ex.Message, true); }
     ResetForm(); BindGrid();
        }

     protected void btnCancel_Click(object sender, EventArgs e) { ResetForm(); }

        protected void gvShows_RowCommand(object sender, GridViewCommandEventArgs e)
        {
      int id = int.Parse(e.CommandArgument.ToString());
            if (e.CommandName == "EditRow")
  {
var dt = DbHelper.ExecuteQuery("SELECT * FROM Show_ WHERE SHOWID=:id", new[] { new OracleParameter("id", id) });
  if (dt.Rows.Count > 0)
     {
  DataRow r = dt.Rows[0];
  hfShowId.Value = id.ToString();
    ddlMovie.SelectedValue = r["MOVIEID"].ToString();
  ddlHall.SelectedValue = r["HALLID"].ToString();
  ddlTheatre.SelectedValue = r["THEATREID"].ToString();
     txtShowDate.Text = r["SHOWDATE"] == DBNull.Value ? "" : Convert.ToDateTime(r["SHOWDATE"]).ToString("yyyy-MM-dd");
  txtShowTime.Text = r["SHOWTIME"].ToString();
    lblFormTitle.Text = "Edit Showtime (ID:" + id + ")";
     }
  }
     else if (e.CommandName == "DeleteRow")
  {
     try { DbHelper.ExecuteNonQuery("DELETE FROM Show_ WHERE SHOWID=:id", new[] { new OracleParameter("id", id) }); ShowMsg("Showtime deleted.", false); }
 catch (Exception ex) { ShowMsg(ex.Message, true); }
            BindGrid();
    }
        }

        private void ResetForm()
  {
   hfShowId.Value = "0"; txtShowDate.Text = txtShowTime.Text = "";
     ddlMovie.SelectedIndex = ddlHall.SelectedIndex = ddlTheatre.SelectedIndex = 0;
  lblFormTitle.Text = "Add New Showtime";
        }

        private void ShowMsg(string msg, bool isError)
        {
  lblMsg.Text = msg; lblMsg.Visible = true;
     lblMsg.Style["color"] = isError ? "#ff4444" : "#ffd700";
      }
    }
}
