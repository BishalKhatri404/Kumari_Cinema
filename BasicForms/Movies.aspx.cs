using System;
using System.Data;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;

namespace Kumari_Cinema.BasicForms
{
    public partial class Movies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
  if (!IsPostBack) BindGrid();
      }

private void BindGrid()
        {
    var dt = DbHelper.ExecuteQuery(
     "SELECT MOVIEID, TITLE, DURATION, GENRE, LANGUAGE, RELEASEDATE FROM Movie ORDER BY MOVIEID");
            gvMovies.DataSource = dt;
      gvMovies.DataBind();
      }

     protected void btnSave_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfMovieId.Value);
     DateTime relDate;
  bool hasDate = DateTime.TryParse(txtReleaseDate.Text, out relDate);
       try
            {
        if (id == 0)
           {
      DbHelper.ExecuteNonQuery(
                "INSERT INTO Movie (MOVIEID, TITLE, DURATION, GENRE, LANGUAGE, RELEASEDATE) " +
    "VALUES ((SELECT NVL(MAX(MOVIEID),0)+1 FROM Movie), :ti, :du, :ge, :la, :rd)",
           new[]
       {
  new OracleParameter("ti", txtTitle.Text.Trim()),
    new OracleParameter("du", string.IsNullOrWhiteSpace(txtDuration.Text) ? (object)DBNull.Value : int.Parse(txtDuration.Text)),
         new OracleParameter("ge", txtGenre.Text.Trim()),
      new OracleParameter("la", txtLanguage.Text.Trim()),
                new OracleParameter("rd", hasDate ? (object)relDate : DBNull.Value)
            });
    ShowMsg("Movie added successfully.", false);
        }
            else
           {
             DbHelper.ExecuteNonQuery(
   "UPDATE Movie SET TITLE=:ti, DURATION=:du, GENRE=:ge, LANGUAGE=:la, RELEASEDATE=:rd WHERE MOVIEID=:id",
  new[]
    {
               new OracleParameter("ti", txtTitle.Text.Trim()),
     new OracleParameter("du", string.IsNullOrWhiteSpace(txtDuration.Text) ? (object)DBNull.Value : int.Parse(txtDuration.Text)),
     new OracleParameter("ge", txtGenre.Text.Trim()),
              new OracleParameter("la", txtLanguage.Text.Trim()),
       new OracleParameter("rd", hasDate ? (object)relDate : DBNull.Value),
       new OracleParameter("id", id)
      });
             ShowMsg("Movie updated successfully.", false);
       }
     }
            catch (Exception ex) { ShowMsg("Error: " + ex.Message, true); }
          ResetForm();
            BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e) { ResetForm(); }

        protected void gvMovies_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       int id = int.Parse(e.CommandArgument.ToString());
          if (e.CommandName == "EditRow")
 {
var dt = DbHelper.ExecuteQuery("SELECT * FROM Movie WHERE MOVIEID=:id",
          new[] { new OracleParameter("id", id) });
     if (dt.Rows.Count > 0)
      {
 DataRow r = dt.Rows[0];
    hfMovieId.Value = id.ToString();
 txtTitle.Text = r["TITLE"].ToString();
          txtDuration.Text = r["DURATION"] == DBNull.Value ? "" : r["DURATION"].ToString();
   txtGenre.Text = r["GENRE"].ToString();
         txtLanguage.Text = r["LANGUAGE"].ToString();
         txtReleaseDate.Text = r["RELEASEDATE"] == DBNull.Value ? "" :
      Convert.ToDateTime(r["RELEASEDATE"]).ToString("yyyy-MM-dd");
         lblFormTitle.Text = "Edit Movie (ID: " + id + ")";
      }
         }
        else if (e.CommandName == "DeleteRow")
{
           try
                {
       DbHelper.ExecuteNonQuery("DELETE FROM Movie WHERE MOVIEID=:id",
  new[] { new OracleParameter("id", id) });
       ShowMsg("Movie deleted.", false);
              }
          catch (Exception ex) { ShowMsg("Cannot delete: " + ex.Message, true); }
  BindGrid();
            }
        }

        private void ResetForm()
        {
          hfMovieId.Value = "0";
            txtTitle.Text = txtGenre.Text = txtDuration.Text = txtLanguage.Text = txtReleaseDate.Text = "";
            lblFormTitle.Text = "Add New Movie";
  }

        private void ShowMsg(string msg, bool isError)
        {
     lblMsg.Text = msg;
            lblMsg.Visible = true;
            lblMsg.Style["color"] = isError ? "#ff4444" : "#ffd700";
        }
    }
}
