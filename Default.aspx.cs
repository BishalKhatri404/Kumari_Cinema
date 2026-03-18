using System;
using System.Data;
using System.Web.UI;

namespace Kumari_Cinema
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        if (!IsPostBack)
  LoadDashboard();
        }

        private void LoadDashboard()
    {
     try
            {
    lblMovies.Text = (DbHelper.ExecuteScalar("SELECT COUNT(*) FROM Movie") ?? 0).ToString();
      lblTickets.Text = (DbHelper.ExecuteScalar("SELECT COUNT(*) FROM Ticket WHERE TICKETSTATUS = 'ISSUED'") ?? 0).ToString();
           lblUsers.Text = (DbHelper.ExecuteScalar("SELECT COUNT(*) FROM Users") ?? 0).ToString();
         lblShows.Text = (DbHelper.ExecuteScalar("SELECT COUNT(*) FROM Show_ WHERE SHOWDATE >= TRUNC(SYSDATE)") ?? 0).ToString();

  // Top 5 movies by bookings
    var dtMovies = DbHelper.ExecuteQuery(@"
SELECT * FROM (
    SELECT m.TITLE, m.GENRE, COUNT(t.TICKETID) AS BOOKINGS
    FROM Movie m
    JOIN Show_ s ON s.MOVIEID = m.MOVIEID
 JOIN Booking b ON b.SHOWID = s.SHOWID
    JOIN Ticket t ON t.BOOKINGID = b.BOOKINGID
    GROUP BY m.TITLE, m.GENRE
    ORDER BY BOOKINGS DESC
) WHERE ROWNUM <= 5");
      gvTopMovies.DataSource = dtMovies;
      gvTopMovies.DataBind();

    // Revenue by theatre
                var dtRevenue = DbHelper.ExecuteQuery(@"
SELECT * FROM (
    SELECT th.THEATRENAME AS THEATRE_NAME, th.THEATRECITY AS CITY, SUM(p.AMOUNT) AS REVENUE
  FROM Theatre th
    JOIN Hall h ON h.THEATREID = th.THEATREID
    JOIN Show_ s ON s.HALLID = h.HALLID
JOIN Booking b ON b.SHOWID = s.SHOWID
    JOIN Ticket t ON t.BOOKINGID = b.BOOKINGID
    JOIN Pricing p ON p.PRICEID = t.PRICEID
    WHERE p.PAYMENTSTATUS = 'PAID'
    GROUP BY th.THEATRENAME, th.THEATRECITY
    ORDER BY REVENUE DESC
) WHERE ROWNUM <= 5");
                gvRevenue.DataSource = dtRevenue;
         gvRevenue.DataBind();

                // Recent bookings
       var dtRecent = DbHelper.ExecuteQuery(@"
SELECT * FROM (
    SELECT b.BOOKINGID, u.USERNAME, m.TITLE, b.BOOKINGDATE, b.BOOKINGSTATUS AS STATUS
    FROM Booking b
    JOIN Users u ON u.USERID = b.USERID
    LEFT JOIN Show_ s ON s.SHOWID = b.SHOWID
    LEFT JOIN Movie m ON m.MOVIEID = s.MOVIEID
    ORDER BY b.BOOKINGDATE DESC
) WHERE ROWNUM <= 10");
        gvRecentBookings.DataSource = dtRecent;
    gvRecentBookings.DataBind();

        // Monthly bookings bar chart
       var dtChart = DbHelper.ExecuteQuery(@"
SELECT TO_CHAR(BOOKINGDATE,'Mon') AS MONTH_SHORT,
       TO_CHAR(BOOKINGDATE,'Month') AS MONTH_NAME,
       COUNT(*) AS CNT
FROM Booking
WHERE EXTRACT(YEAR FROM BOOKINGDATE) = EXTRACT(YEAR FROM SYSDATE)
GROUP BY TO_CHAR(BOOKINGDATE,'Mon'), TO_CHAR(BOOKINGDATE,'Month'),
         EXTRACT(MONTH FROM BOOKINGDATE)
ORDER BY EXTRACT(MONTH FROM BOOKINGDATE)");

       if (dtChart.Rows.Count > 0)
   {
   double maxVal = 1;
               foreach (DataRow r in dtChart.Rows)
   {
 double v = Convert.ToDouble(r["CNT"]);
 if (v > maxVal) maxVal = v;
               }
    dtChart.Columns.Add("BAR_HEIGHT", typeof(int));
           foreach (DataRow r in dtChart.Rows)
          r["BAR_HEIGHT"] = (int)(Convert.ToDouble(r["CNT"]) / maxVal * 140);
      }
      rptMonthChart.DataSource = dtChart;
        rptMonthChart.DataBind();
            }
       catch { /* DB not connected - graceful degradation */ }
        }
    }
}