<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Kumari_Cinema._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header-bar">
  <div class="container-fluid px-4">
<h2>🎬 Dashboard — Kumari Cinemas</h2>
    <p class="mb-0" style="color:#ccc;">Welcome to the Movie Ticketing Management System</p>
  </div>
</div>

<%-- Stats Row --%>
<div class="container-fluid px-4">
  <div class="row g-3 mb-4">
    <div class="col-md-3">
 <div class="card text-center p-3" style="border-left:4px solid #ffd700;">
        <div style="font-size:2.5rem;">🎥</div>
        <div style="font-size:2rem;color:#ffd700;font-weight:700;">
          <asp:Label ID="lblMovies" runat="server" Text="0" /></div>
        <div style="color:#ccc;">Total Movies</div>
  </div>
  </div>
    <div class="col-md-3">
      <div class="card text-center p-3" style="border-left:4px solid #00b4d8;">
        <div style="font-size:2.5rem;">🎟️</div>
        <div style="font-size:2rem;color:#00b4d8;font-weight:700;">
       <asp:Label ID="lblTickets" runat="server" Text="0" /></div>
        <div style="color:#ccc;">Tickets Sold</div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card text-center p-3" style="border-left:4px solid #90e0ef;">
<div style="font-size:2.5rem;">👤</div>
        <div style="font-size:2rem;color:#90e0ef;font-weight:700;">
    <asp:Label ID="lblUsers" runat="server" Text="0" /></div>
        <div style="color:#ccc;">Registered Users</div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card text-center p-3" style="border-left:4px solid #ff8c00;">
   <div style="font-size:2.5rem;">🏛️</div>
    <div style="font-size:2rem;color:#ff8c00;font-weight:700;">
          <asp:Label ID="lblShows" runat="server" Text="0" /></div>
        <div style="color:#ccc;">Active Shows</div>
      </div>
    </div>
  </div>

  <div class="row g-3 mb-4">
    <%-- Top Movies --%>
    <div class="col-md-6">
   <div class="card h-100">
        <div class="card-header"><strong>🏆 Top 5 Movies by Bookings</strong></div>
        <div class="card-body p-0">
     <asp:GridView ID="gvTopMovies" runat="server" AutoGenerateColumns="false"
    CssClass="table table-sm mb-0" GridLines="None" ShowHeaderWhenEmpty="true">
            <Columns>
      <asp:BoundField DataField="TITLE" HeaderText="Movie Title" />
              <asp:BoundField DataField="GENRE" HeaderText="Genre" />
            <asp:BoundField DataField="BOOKINGS" HeaderText="Bookings" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
            </Columns>
  <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No data available</p></EmptyDataTemplate>
       </asp:GridView>
        </div>
      </div>
    </div>

    <%-- Revenue Summary --%>
  <div class="col-md-6">
      <div class="card h-100">
<div class="card-header"><strong>💰 Revenue by Theatre (Top 5)</strong></div>
        <div class="card-body p-0">
          <asp:GridView ID="gvRevenue" runat="server" AutoGenerateColumns="false"
    CssClass="table table-sm mb-0" GridLines="None" ShowHeaderWhenEmpty="true">
          <Columns>
         <asp:BoundField DataField="THEATRE_NAME" HeaderText="Theatre" />
 <asp:BoundField DataField="CITY" HeaderText="City" />
     <asp:BoundField DataField="REVENUE" HeaderText="Revenue (Rs.)" DataFormatString="{0:N2}" ItemStyle-CssClass="text-end" HeaderStyle-CssClass="text-end" />
            </Columns>
 <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No data available</p></EmptyDataTemplate>
          </asp:GridView>
        </div>
      </div>
    </div>
  </div>

  <div class="row g-3 mb-4">
    <%-- Recent Bookings --%>
    <div class="col-md-8">
      <div class="card">
        <div class="card-header"><strong>📅 Recent Bookings (Last 10)</strong></div>
   <div class="card-body p-0">
          <asp:GridView ID="gvRecentBookings" runat="server" AutoGenerateColumns="false"
            CssClass="table table-sm mb-0" GridLines="None" ShowHeaderWhenEmpty="true">
<Columns>
    <asp:BoundField DataField="BOOKINGID" HeaderText="ID" />
   <asp:BoundField DataField="USERNAME" HeaderText="User" />
         <asp:BoundField DataField="TITLE" HeaderText="Movie" />
              <asp:BoundField DataField="BOOKINGDATE" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
   <asp:BoundField DataField="STATUS" HeaderText="Status" />
  </Columns>
       <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No data available</p></EmptyDataTemplate>
  </asp:GridView>
     </div>
      </div>
    </div>

    <%-- Quick Links --%>
    <div class="col-md-4">
      <div class="card h-100">
        <div class="card-header"><strong>⚡ Quick Access</strong></div>
        <div class="card-body d-flex flex-column gap-2">
          <a href="BasicForms/Users.aspx" class="btn btn-cinema-primary w-100">👤 Manage Users</a>
      <a href="BasicForms/Movies.aspx" class="btn btn-cinema-primary w-100">🎥 Manage Movies</a>
   <a href="BasicForms/TheatreCityHall.aspx" class="btn btn-cinema-primary w-100">🏛️ Theatre &amp; Hall</a>
     <a href="BasicForms/Showtimes.aspx" class="btn btn-cinema-primary w-100">🕐 Showtimes</a>
       <a href="BasicForms/Tickets.aspx" class="btn btn-cinema-primary w-100">🎟️ Tickets</a>
     <a href="ComplexForms/UserTicket.aspx" class="btn btn-outline-warning w-100">🎫 User Ticket Report</a>
          <a href="ComplexForms/TheatreCityHallMovie.aspx" class="btn btn-outline-warning w-100">🏛️ Hall Movie Report</a>
      <a href="ComplexForms/MovieOccupancy.aspx" class="btn btn-outline-warning w-100">📊 Occupancy Report</a>
        </div>
      </div>
    </div>
  </div>

  <%-- Visual Bar Chart (CSS-only) --%>
  <div class="row g-3 mb-4">
    <div class="col-12">
   <div class="card">
        <div class="card-header"><strong>📊 Bookings Per Month (Current Year)</strong></div>
        <div class="card-body">
          <div id="barChart" style="display:flex;align-items:flex-end;gap:8px;height:160px;padding:10px 0;">
            <asp:Repeater ID="rptMonthChart" runat="server">
  <ItemTemplate>
                <div style="display:flex;flex-direction:column;align-items:center;flex:1;">
    <div style="background:linear-gradient(180deg,#ffd700,#ff8c00);width:100%;height:<%# Eval("BAR_HEIGHT") %>px;border-radius:4px 4px 0 0;min-height:4px;"
             title='<%# Eval("MONTH_NAME") + ": " + Eval("CNT") + " bookings" %>'></div>
   <small style="color:#ccc;margin-top:4px;font-size:0.65rem;"><%# Eval("MONTH_SHORT") %></small>
       </div>
         </ItemTemplate>
         </asp:Repeater>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</asp:Content>
