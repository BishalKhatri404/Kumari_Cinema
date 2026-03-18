<%@ Page Title="Hall Movie Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="TheatreCityHallMovie.aspx.cs" Inherits="Kumari_Cinema.ComplexForms.TheatreCityHallMovie" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header-bar">
  <div class="container-fluid px-4">
    <h2>??? Theatre / Hall Movie Report</h2>
    <p class="mb-0" style="color:#ccc;">View movies and showtimes for a specific hall</p>
  </div>
</div>

<div class="container-fluid px-4">
  <div class="card mb-4">
    <div class="card-header"><strong>?? Search Parameters</strong></div>
    <div class="card-body">
      <div class="row g-3 align-items-end">
    <div class="col-md-4">
   <label class="form-label">Select Hall *</label>
   <asp:DropDownList ID="ddlHall" runat="server" CssClass="form-select" />
  </div>
        <div class="col-md-2">
      <label class="form-label">Or Enter Hall ID</label>
      <asp:TextBox ID="txtHallId" runat="server" CssClass="form-control" placeholder="e.g. 1001" />
  </div>
   <div class="col-md-2 d-flex align-items-end">
<asp:Button ID="btnSearch" runat="server" Text="?? Run Report"
      CssClass="btn btn-cinema-primary w-100" OnClick="btnSearch_Click" />
</div>
    </div>
    </div>
  </div>

  <asp:Panel ID="pnlGrid" runat="server" Visible="false">
    <div class="card">
      <div class="card-header"><strong>?? Movies &amp; Showtimes for Selected Hall</strong></div>
      <div class="card-body p-0">
        <asp:GridView ID="gvHallMovies" runat="server" AutoGenerateColumns="false"
    CssClass="table mb-0" GridLines="None" ShowHeaderWhenEmpty="true">
          <Columns>
    <asp:BoundField DataField="THEATREID" HeaderText="Theatre ID" />
<asp:BoundField DataField="THEATRENAME" HeaderText="Theatre" />
 <asp:BoundField DataField="THEATRECITY" HeaderText="City" />
   <asp:BoundField DataField="HALLID" HeaderText="Hall ID" />
      <asp:BoundField DataField="HALLNAME" HeaderText="Hall" />
    <asp:BoundField DataField="MOVIEID" HeaderText="Movie ID" />
   <asp:BoundField DataField="TITLE" HeaderText="Movie" />
   <asp:BoundField DataField="GENRE" HeaderText="Genre" />
<asp:BoundField DataField="LANGUAGE" HeaderText="Language" />
  <asp:BoundField DataField="SHOWDATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" />
  <asp:BoundField DataField="SHOWTIME" HeaderText="Time" />
        </Columns>
      <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No showtimes found for this hall.</p></EmptyDataTemplate>
      </asp:GridView>
   </div>
    </div>
  </asp:Panel>

  <asp:Label ID="lblMsg" runat="server" CssClass="alert-cinema d-block mt-3" Visible="false" />
</div>
</asp:Content>
