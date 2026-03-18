<%@ Page Title="Movie Occupancy Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="MovieOccupancy.aspx.cs" Inherits="Kumari_Cinema.ComplexForms.MovieOccupancy" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header-bar">
  <div class="container-fluid px-4">
    <h2>?? Movie Occupancy Report</h2>
    <p class="mb-0" style="color:#ccc;">Top 3 halls by occupancy percentage for a movie (paid tickets)</p>
  </div>
</div>

<div class="container-fluid px-4">
  <div class="card mb-4">
    <div class="card-header"><strong>?? Search Parameters</strong></div>
    <div class="card-body">
      <div class="row g-3 align-items-end">
 <div class="col-md-4">
     <label class="form-label">Select Movie *</label>
    <asp:DropDownList ID="ddlMovie" runat="server" CssClass="form-select" />
  </div>
  <div class="col-md-2">
     <label class="form-label">Or Enter Movie ID</label>
     <asp:TextBox ID="txtMovieId" runat="server" CssClass="form-control" placeholder="e.g. 101" />
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
      <div class="card-header"><strong>?? Top 3 Halls by Occupancy</strong></div>
      <div class="card-body p-0">
    <asp:GridView ID="gvOccupancy" runat="server" AutoGenerateColumns="false"
    CssClass="table mb-0" GridLines="None" ShowHeaderWhenEmpty="true">
        <Columns>
  <asp:BoundField DataField="RANK" HeaderText="Rank" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
  <asp:BoundField DataField="THEATRENAME" HeaderText="Theatre" />
  <asp:BoundField DataField="THEATRECITY" HeaderText="City" />
  <asp:BoundField DataField="HALLNAME" HeaderText="Hall" />
  <asp:BoundField DataField="HALLCAPACITY" HeaderText="Capacity" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
  <asp:BoundField DataField="PAIDTICKETS" HeaderText="Paid Tickets" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
  <asp:BoundField DataField="OCCUPANCYPERCENTAGE" HeaderText="Occupancy %" DataFormatString="{0:N2}" ItemStyle-CssClass="text-end" HeaderStyle-CssClass="text-end" />
        </Columns>
          <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No occupancy data found for this movie.</p></EmptyDataTemplate>
        </asp:GridView>
  </div>
    </div>
  </asp:Panel>

  <asp:Label ID="lblMsg" runat="server" CssClass="alert-cinema d-block mt-3" Visible="false" />
</div>
</asp:Content>
