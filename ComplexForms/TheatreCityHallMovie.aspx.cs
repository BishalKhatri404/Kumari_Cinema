using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

namespace Kumari_Cinema.ComplexForms
{
public partial class TheatreCityHallMovie : System.Web.UI.Page
    {
   protected void Page_Load(object sender, EventArgs e)
 {
      if (!IsPostBack) LoadHalls();
     }

   private void LoadHalls()
   {
     var dt = DbHelper.ExecuteQuery(@"
SELECT h.HALLID, h.HALLID || ' - ' || h.HALLNAME || ' (' || t.THEATRENAME || ')' AS LABEL
FROM Hall h JOIN Theatre t ON t.THEATREID = h.THEATREID ORDER BY t.THEATRENAME, h.HALLNAME");
  ddlHall.DataSource = dt;
  ddlHall.DataTextField = "LABEL"; ddlHall.DataValueField = "HALLID";
 ddlHall.DataBind();
  ddlHall.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Hall --", ""));
   }

   protected void btnSearch_Click(object sender, EventArgs e)
    {
 string hid = !string.IsNullOrWhiteSpace(txtHallId.Text) ? txtHallId.Text.Trim() : ddlHall.SelectedValue;
  if (string.IsNullOrWhiteSpace(hid))
      { ShowMsg("Please select or enter a Hall ID.", true); return; }

    int hallId = int.Parse(hid);

     // Exact coursework query
   var dt = DbHelper.ExecuteQuery(@"
SELECT TH.THEATREID, TH.THEATRENAME, TH.THEATRECITY, H.HALLID, H.HALLNAME,
       M.MOVIEID, M.TITLE, M.GENRE, M.LANGUAGE, S.SHOWDATE, S.SHOWTIME
FROM Theatre TH
JOIN Hall H ON TH.THEATREID = H.THEATREID
JOIN Show_ S ON H.HALLID = S.HALLID
JOIN Movie M ON S.MOVIEID = M.MOVIEID
WHERE H.HALLID = :HallID",
     new[] { new OracleParameter("HallID", hallId) });

     if (dt.Rows.Count > 0)
    {
  gvHallMovies.DataSource = dt;
     gvHallMovies.DataBind();
       pnlGrid.Visible = true;
   lblMsg.Visible = false;
   }
    else
     {
  pnlGrid.Visible = false;
    ShowMsg("No showtimes found for Hall ID " + hallId + ".", true);
     }
   }

  private void ShowMsg(string msg, bool isError)
    {
   lblMsg.Text = msg; lblMsg.Visible = true;
    lblMsg.Style["color"] = isError ? "#ff4444" : "#ffd700";
 pnlGrid.Visible = false;
        }
  }
}
