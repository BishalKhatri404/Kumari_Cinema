using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;

namespace Kumari_Cinema.ComplexForms
{
    public partial class MovieOccupancy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadMovies();
        }

        private void LoadMovies()
        {
            var dt = DbHelper.ExecuteQuery("SELECT MOVIEID, MOVIEID || ' - ' || TITLE AS LABEL FROM Movie ORDER BY TITLE");
            ddlMovie.DataSource = dt;
            ddlMovie.DataTextField = "LABEL"; ddlMovie.DataValueField = "MOVIEID";
            ddlMovie.DataBind();
            ddlMovie.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Movie --", ""));
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string mid = !string.IsNullOrWhiteSpace(txtMovieId.Text) ? txtMovieId.Text.Trim() : ddlMovie.SelectedValue;
            if (string.IsNullOrWhiteSpace(mid))
            { ShowMsg("Please select or enter a Movie ID.", true); return; }

            int movieId = int.Parse(mid);

            var dt = DbHelper.ExecuteQuery(@"
SELECT * FROM (
    SELECT TH.THEATRENAME, TH.THEATRECITY, H.HALLNAME, H.HALLCAPACITY,
           COUNT(T.TICKETID) AS PAIDTICKETS,
         ROUND((COUNT(T.TICKETID) / H.HALLCAPACITY) * 100, 2) AS OCCUPANCYPERCENTAGE,
     ROW_NUMBER() OVER (ORDER BY (COUNT(T.TICKETID) / H.HALLCAPACITY) DESC) AS RANK
    FROM Movie M
    JOIN Show_ S ON M.MOVIEID = S.MOVIEID
    JOIN Hall H ON S.HALLID = H.HALLID
    JOIN Theatre TH ON H.THEATREID = TH.THEATREID
    JOIN Booking B ON S.SHOWID = B.SHOWID
    JOIN Ticket T ON B.BOOKINGID = T.BOOKINGID
    JOIN Pricing P ON T.PRICEID = P.PRICEID
    WHERE M.MOVIEID = :MovieID AND P.PAYMENTSTATUS = 'PAID'
    GROUP BY TH.THEATRENAME, TH.THEATRECITY, H.HALLNAME, H.HALLCAPACITY
) WHERE RANK <= 3",
       new[] { new OracleParameter("MovieID", movieId) });

            if (dt.Rows.Count > 0)
            {
                gvOccupancy.DataSource = dt;
                gvOccupancy.DataBind();
                pnlGrid.Visible = true;
                lblMsg.Visible = false;
            }
            else
            {
                pnlGrid.Visible = false;
                ShowMsg("No occupancy data found for Movie ID " + movieId + ".", true);
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
