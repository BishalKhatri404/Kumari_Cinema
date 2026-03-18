<%@ Page Title="Tickets" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Tickets.aspx.cs" Inherits="Kumari_Cinema.BasicForms.Tickets" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header-bar">
  <div class="container-fluid px-4">
    <h2>??? Ticket Management</h2>
    <p class="mb-0" style="color:#ccc;">Issue and manage cinema tickets</p>
  </div>
</div>

<div class="container-fluid px-4">
  <asp:Label ID="lblMsg" runat="server" CssClass="alert-cinema d-block mb-3" Visible="false" />

  <div class="card mb-4">
    <div class="card-header"><asp:Label ID="lblFormTitle" runat="server" Text="Issue New Ticket" /></div>
    <div class="card-body">
      <asp:HiddenField ID="hfTicketId" runat="server" Value="0" />
      <div class="row g-3">
      <div class="col-md-3">
 <label class="form-label">Booking *</label>
   <asp:DropDownList ID="ddlBooking" runat="server" CssClass="form-select" />
    <asp:RequiredFieldValidator ControlToValidate="ddlBooking" runat="server" InitialValue=""
  ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgTicket" />
    </div>
 <div class="col-md-2">
   <label class="form-label">Ticket Number</label>
    <asp:TextBox ID="txtTicketNumber" runat="server" CssClass="form-control" MaxLength="30" />
      </div>
     <div class="col-md-2">
 <label class="form-label">Status</label>
    <asp:DropDownList ID="ddlTicketStatus" runat="server" CssClass="form-select">
    <asp:ListItem Value="ISSUED">ISSUED</asp:ListItem>
     <asp:ListItem Value="USED">USED</asp:ListItem>
     <asp:ListItem Value="CANCELLED">CANCELLED</asp:ListItem>
     <asp:ListItem Value="REFUNDED">REFUNDED</asp:ListItem>
   </asp:DropDownList>
        </div>
 <div class="col-md-3">
     <label class="form-label">Pricing *</label>
     <asp:DropDownList ID="ddlPricing" runat="server" CssClass="form-select" />
<asp:RequiredFieldValidator ControlToValidate="ddlPricing" runat="server" InitialValue=""
ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgTicket" />
        </div>
    <div class="col-md-2">
       <label class="form-label">Seat *</label>
        <asp:DropDownList ID="ddlSeat" runat="server" CssClass="form-select" />
   <asp:RequiredFieldValidator ControlToValidate="ddlSeat" runat="server" InitialValue=""
     ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgTicket" />
        </div>
    <div class="col-12 mt-2">
   <asp:Button ID="btnSave" runat="server" Text="?? Save" CssClass="btn btn-cinema-primary me-2"
  OnClick="btnSave_Click" ValidationGroup="vgTicket" />
 <asp:Button ID="btnCancel" runat="server" Text="? Cancel" CssClass="btn btn-outline-secondary"
OnClick="btnCancel_Click" CausesValidation="false" />
  </div>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-header"><strong>?? All Tickets</strong></div>
    <div class="card-body p-0">
      <asp:GridView ID="gvTickets" runat="server" AutoGenerateColumns="false"
   CssClass="table mb-0" GridLines="None" DataKeyNames="TICKETID"
   OnRowCommand="gvTickets_RowCommand" ShowHeaderWhenEmpty="true">
        <Columns>
        <asp:BoundField DataField="TICKETID" HeaderText="ID" />
          <asp:BoundField DataField="TICKETNUMBER" HeaderText="Ticket #" />
  <asp:BoundField DataField="USERNAME" HeaderText="User" />
  <asp:BoundField DataField="BOOKINGID" HeaderText="Booking" />
      <asp:BoundField DataField="SEATLABEL" HeaderText="Seat" />
       <asp:BoundField DataField="AMOUNT" HeaderText="Amount" DataFormatString="{0:N2}" />
   <asp:BoundField DataField="TICKETSTATUS" HeaderText="Status" />
          <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-nowrap">
         <ItemTemplate>
     <asp:LinkButton CommandName="EditRow" CommandArgument='<%# Eval("TICKETID") %>'
     runat="server" CssClass="btn btn-sm btn-outline-warning me-1">?? Edit</asp:LinkButton>
         <asp:LinkButton CommandName="DeleteRow" CommandArgument='<%# Eval("TICKETID") %>'
       runat="server" CssClass="btn btn-sm btn-outline-danger"
    OnClientClick="return confirm('Delete this ticket?');">??? Delete</asp:LinkButton>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No tickets found.</p></EmptyDataTemplate>
      </asp:GridView>
    </div>
  </div>
</div>
</asp:Content>
