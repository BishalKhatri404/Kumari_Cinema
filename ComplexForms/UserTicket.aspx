<%@ Page Title="User Ticket Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="UserTicket.aspx.cs" Inherits="Kumari_Cinema.ComplexForms.UserTicket" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header-bar">
  <div class="container-fluid px-4">
    <h2>?? User Ticket Report</h2>
  <p class="mb-0" style="color:#ccc;">View user details and paid tickets from the last 6 months</p>
</div>
</div>

<div class="container-fluid px-4">
  <div class="card mb-4">
    <div class="card-header"><strong>?? Search Parameters</strong></div>
    <div class="card-body">
<div class="row g-3 align-items-end">
        <div class="col-md-4">
          <label class="form-label">Select User *</label>
    <asp:DropDownList ID="ddlUser" runat="server" CssClass="form-select" />
        </div>
   <div class="col-md-2">
          <label class="form-label">Or Enter User ID</label>
  <asp:TextBox ID="txtUserId" runat="server" CssClass="form-control" placeholder="e.g. 1" />
     </div>
        <div class="col-md-2 d-flex align-items-end">
    <asp:Button ID="btnSearch" runat="server" Text="?? Run Report"
CssClass="btn btn-cinema-primary w-100" OnClick="btnSearch_Click" />
        </div>
      </div>
    </div>
  </div>

  <asp:Panel ID="pnlUserDetail" runat="server" Visible="false" CssClass="card mb-4">
    <div class="card-header"><strong>?? User Details</strong></div>
    <div class="card-body">
      <div class="row">
  <div class="col-md-2"><strong style="color:#ffd700;">User ID:</strong><br /><asp:Label ID="lblUID" runat="server" /></div>
  <div class="col-md-3"><strong style="color:#ffd700;">UserName:</strong><br /><asp:Label ID="lblUName" runat="server" /></div>
  <div class="col-md-2"><strong style="color:#ffd700;">Phone:</strong><br /><asp:Label ID="lblUPhone" runat="server" /></div>
  <div class="col-md-3"><strong style="color:#ffd700;">Email:</strong><br /><asp:Label ID="lblUEmail" runat="server" /></div>
  <div class="col-md-2"><strong style="color:#ffd700;">Age:</strong><br /><asp:Label ID="lblUAge" runat="server" /></div>
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnlGrid" runat="server" Visible="false">
    <div class="card">
      <div class="card-header"><strong>??? Paid Tickets - Last 6 Months</strong></div>
      <div class="card-body p-0">
        <asp:GridView ID="gvUserTickets" runat="server" AutoGenerateColumns="false"
       CssClass="table mb-0" GridLines="None" ShowHeaderWhenEmpty="true">
          <Columns>
     <asp:BoundField DataField="TICKETID" HeaderText="Ticket ID" />
   <asp:BoundField DataField="TICKETNUMBER" HeaderText="Ticket #" />
     <asp:BoundField DataField="TICKETSTATUS" HeaderText="Status" />
  <asp:BoundField DataField="BOOKINGDATE" HeaderText="Booking Date" DataFormatString="{0:dd/MM/yyyy}" />
  <asp:BoundField DataField="AMOUNT" HeaderText="Amount (Rs.)" DataFormatString="{0:N2}" ItemStyle-CssClass="text-end" HeaderStyle-CssClass="text-end" />
          </Columns>
          <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No paid tickets found in the last 6 months.</p></EmptyDataTemplate>
        </asp:GridView>
      </div>
    </div>
  </asp:Panel>

  <asp:Label ID="lblMsg" runat="server" CssClass="alert-cinema d-block mt-3" Visible="false" />
</div>
</asp:Content>
