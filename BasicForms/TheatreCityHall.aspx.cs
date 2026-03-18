using System;
using System.Data;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;

namespace Kumari_Cinema.BasicForms
{
    public partial class TheatreCityHall : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
   if (!IsPostBack) { BindTheatres(); BindHallDropdown(); BindHalls(); }
     }

 private void BindTheatres()
    {
 var dt = DbHelper.ExecuteQuery(
  "SELECT THEATREID, THEATRENAME, THEATRECITY, THEATREADDRESS, THEATRECONTACTNUMBER FROM Theatre ORDER BY THEATREID");
            gvTheatres.DataSource = dt;
            gvTheatres.DataBind();
   }

        private void BindHallDropdown()
        {
   var dt = DbHelper.ExecuteQuery("SELECT THEATREID, THEATRENAME || ' - ' || THEATRECITY AS LABEL FROM Theatre ORDER BY THEATRENAME");
     ddlHallTheatre.DataSource = dt;
  ddlHallTheatre.DataTextField = "LABEL";
         ddlHallTheatre.DataValueField = "THEATREID";
    ddlHallTheatre.DataBind();
ddlHallTheatre.Items.Insert(0, new ListItem("-- Select Theatre --", ""));
        }

        private void BindHalls()
{
            var dt = DbHelper.ExecuteQuery(@"
SELECT h.HALLID, h.HALLNAME, t.THEATRENAME, t.THEATRECITY, h.HALLCAPACITY, h.SEATLAYOUT
FROM Hall h JOIN Theatre t ON t.THEATREID = h.THEATREID
ORDER BY t.THEATRENAME, h.HALLNAME");
            gvHalls.DataSource = dt;
            gvHalls.DataBind();
        }

      // ------- Theatre CRUD -------
        protected void btnSaveTheatre_Click(object sender, EventArgs e)
      {
      int id = int.Parse(hfTheatreId.Value);
            try
     {
      if (id == 0)
     {
  DbHelper.ExecuteNonQuery(
  "INSERT INTO Theatre (THEATREID, THEATRENAME, THEATRECITY, THEATREADDRESS, THEATRECONTACTNUMBER) " +
 "VALUES ((SELECT NVL(MAX(THEATREID),0)+1 FROM Theatre), :tn, :tc, :ta, :tp)",
new[] {
          new OracleParameter("tn", txtTheatreName.Text.Trim()),
  new OracleParameter("tc", txtTheatreCity.Text.Trim()),
   new OracleParameter("ta", txtTheatreAddress.Text.Trim()),
    new OracleParameter("tp", txtTheatreContact.Text.Trim()) });
      ShowMsg("Theatre added.", false);
           }
   else
    {
      DbHelper.ExecuteNonQuery(
"UPDATE Theatre SET THEATRENAME=:tn, THEATRECITY=:tc, THEATREADDRESS=:ta, THEATRECONTACTNUMBER=:tp WHERE THEATREID=:id",
  new[] {
      new OracleParameter("tn", txtTheatreName.Text.Trim()),
     new OracleParameter("tc", txtTheatreCity.Text.Trim()),
           new OracleParameter("ta", txtTheatreAddress.Text.Trim()),
        new OracleParameter("tp", txtTheatreContact.Text.Trim()),
        new OracleParameter("id", id) });
            ShowMsg("Theatre updated.", false);
     }
     }
            catch (Exception ex) { ShowMsg(ex.Message, true); }
            ResetTheatreForm();
          BindTheatres(); BindHallDropdown(); BindHalls();
    }

        protected void btnCancelTheatre_Click(object sender, EventArgs e) { ResetTheatreForm(); }

        protected void gvTheatres_RowCommand(object sender, GridViewCommandEventArgs e)
        {
    int id = int.Parse(e.CommandArgument.ToString());
     if (e.CommandName == "EditTheatre")
 {
var dt = DbHelper.ExecuteQuery("SELECT * FROM Theatre WHERE THEATREID=:id", new[] { new OracleParameter("id", id) });
   if (dt.Rows.Count > 0)
   {
         DataRow r = dt.Rows[0];
      hfTheatreId.Value = id.ToString();
     txtTheatreName.Text = r["THEATRENAME"].ToString();
       txtTheatreCity.Text = r["THEATRECITY"].ToString();
      txtTheatreAddress.Text = r["THEATREADDRESS"].ToString();
  txtTheatreContact.Text = r["THEATRECONTACTNUMBER"].ToString();
            lblTheatreTitle.Text = "Edit Theatre (ID:" + id + ")";
  }
     }
            else if (e.CommandName == "DeleteTheatre")
      {
         try { DbHelper.ExecuteNonQuery("DELETE FROM Theatre WHERE THEATREID=:id", new[] { new OracleParameter("id", id) }); ShowMsg("Theatre deleted.", false); }
    catch (Exception ex) { ShowMsg(ex.Message, true); }
                BindTheatres(); BindHallDropdown(); BindHalls();
     }
        }

        private void ResetTheatreForm()
        {
        hfTheatreId.Value = "0";
     txtTheatreName.Text = txtTheatreCity.Text = txtTheatreAddress.Text = txtTheatreContact.Text = "";
   lblTheatreTitle.Text = "Add New Theatre";
        }

  // ------- Hall CRUD -------
        protected void btnSaveHall_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfHallId.Value);
            try
    {
                if (id == 0)
             {
      DbHelper.ExecuteNonQuery(
          "INSERT INTO Hall (HALLID, HALLNAME, HALLCAPACITY, SEATLAYOUT, THEATREID) " +
 "VALUES ((SELECT NVL(MAX(HALLID),0)+1 FROM Hall), :hn, :hc, :sl, :ti)",
   new[] {
  new OracleParameter("hn", txtHallName.Text.Trim()),
         new OracleParameter("hc", string.IsNullOrWhiteSpace(txtCapacity.Text) ? (object)DBNull.Value : int.Parse(txtCapacity.Text)),
     new OracleParameter("sl", txtSeatLayout.Text.Trim()),
    new OracleParameter("ti", int.Parse(ddlHallTheatre.SelectedValue)) });
   ShowMsg("Hall added.", false);
      }
    else
         {
   DbHelper.ExecuteNonQuery(
       "UPDATE Hall SET HALLNAME=:hn, HALLCAPACITY=:hc, SEATLAYOUT=:sl, THEATREID=:ti WHERE HALLID=:id",
       new[] {
            new OracleParameter("hn", txtHallName.Text.Trim()),
        new OracleParameter("hc", string.IsNullOrWhiteSpace(txtCapacity.Text) ? (object)DBNull.Value : int.Parse(txtCapacity.Text)),
     new OracleParameter("sl", txtSeatLayout.Text.Trim()),
  new OracleParameter("ti", int.Parse(ddlHallTheatre.SelectedValue)),
 new OracleParameter("id", id) });
   ShowMsg("Hall updated.", false);
        }
     }
       catch (Exception ex) { ShowMsg(ex.Message, true); }
            ResetHallForm(); BindHalls();
      }

  protected void btnCancelHall_Click(object sender, EventArgs e) { ResetHallForm(); }

   protected void gvHalls_RowCommand(object sender, GridViewCommandEventArgs e)
    {
  int id = int.Parse(e.CommandArgument.ToString());
     if (e.CommandName == "EditHall")
       {
        var dt = DbHelper.ExecuteQuery("SELECT * FROM Hall WHERE HALLID=:id", new[] { new OracleParameter("id", id) });
 if (dt.Rows.Count > 0)
     {
     DataRow r = dt.Rows[0];
      hfHallId.Value = id.ToString();
        ddlHallTheatre.SelectedValue = r["THEATREID"].ToString();
  txtHallName.Text = r["HALLNAME"].ToString();
txtCapacity.Text = r["HALLCAPACITY"] == DBNull.Value ? "" : r["HALLCAPACITY"].ToString();
           txtSeatLayout.Text = r["SEATLAYOUT"].ToString();
         lblHallTitle.Text = "Edit Hall (ID:" + id + ")";
      }
     }
      else if (e.CommandName == "DeleteHall")
  {
  try { DbHelper.ExecuteNonQuery("DELETE FROM Hall WHERE HALLID=:id", new[] { new OracleParameter("id", id) }); ShowMsg("Hall deleted.", false); }
          catch (Exception ex) { ShowMsg(ex.Message, true); }
    BindHalls();
    }
        }

        private void ResetHallForm()
        {
  hfHallId.Value = "0";
      txtHallName.Text = txtCapacity.Text = txtSeatLayout.Text = "";
            lblHallTitle.Text = "Add New Hall";
        }

 private void ShowMsg(string msg, bool isError)
        {
            lblMsg.Text = msg; lblMsg.Visible = true;
       lblMsg.Style["color"] = isError ? "#ff4444" : "#ffd700";
        }
    }
}
