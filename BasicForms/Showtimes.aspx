<%@ Page Title="Showtimes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Showtimes.aspx.cs" Inherits="Kumari_Cinema.BasicForms.Showtimes" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header-bar">
  <div class="container-fluid px-4">
  <h2>?? Showtime Management</h2>
    <p class="mb-0" style="color:#ccc;">Schedule and manage movie showtimes</p>
  </div>
</div>

<div class="container-fluid px-4">
  <asp:Label ID="lblMsg" runat="server" CssClass="alert-cinema d-block mb-3" Visible="false" />

  <div class="card mb-4">
  <div class="card-header"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Showtime" /></div>
    <div class="card-body">
      <asp:HiddenField ID="hfShowId" runat="server" Value="0" />
      <div class="row g-3">
        <div class="col-md-3">
        <label class="form-label">Movie *</label>
  <asp:DropDownList ID="ddlMovie" runat="server" CssClass="form-select" />
  <asp:RequiredFieldValidator ControlToValidate="ddlMovie" runat="server" InitialValue=""
          ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgShow" />
        </div>
        <div class="col-md-3">
          <label class="form-label">Hall *</label>
    <asp:DropDownList ID="ddlHall" runat="server" CssClass="form-select" />
     <asp:RequiredFieldValidator ControlToValidate="ddlHall" runat="server" InitialValue=""
ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgShow" />
        </div>
   <div class="col-md-3">
          <label class="form-label">Theatre *</label>
          <asp:DropDownList ID="ddlTheatre" runat="server" CssClass="form-select" />
     <asp:RequiredFieldValidator ControlToValidate="ddlTheatre" runat="server" InitialValue=""
            ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgShow" />
   </div>
        <div class="col-md-2">
   <label class="form-label">Show Date *</label>
          <asp:TextBox ID="txtShowDate" runat="server" CssClass="form-control" TextMode="Date" />
   <asp:RequiredFieldValidator ControlToValidate="txtShowDate" runat="server"
    ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgShow" />
      </div>
        <div class="col-md-2">
          <label class="form-label">Show Time</label>
      <asp:TextBox ID="txtShowTime" runat="server" CssClass="form-control" MaxLength="10" placeholder="e.g. 18:00" />
      </div>
        <div class="col-12 mt-2">
   <asp:Button ID="btnSave" runat="server" Text="?? Save" CssClass="btn btn-cinema-primary me-2"
            OnClick="btnSave_Click" ValidationGroup="vgShow" />
 <asp:Button ID="btnCancel" runat="server" Text="? Cancel" CssClass="btn btn-outline-secondary"
   OnClick="btnCancel_Click" CausesValidation="false" />
   </div>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-header"><strong>?? All Showtimes</strong></div>
    <div class="card-body p-0">
      <asp:GridView ID="gvShows" runat="server" AutoGenerateColumns="false"
    CssClass="table mb-0" GridLines="None" DataKeyNames="SHOWID"
        OnRowCommand="gvShows_RowCommand" ShowHeaderWhenEmpty="true">
        <Columns>
          <asp:BoundField DataField="SHOWID" HeaderText="ID" />
          <asp:BoundField DataField="TITLE" HeaderText="Movie" />
          <asp:BoundField DataField="HALLNAME" HeaderText="Hall" />
       <asp:BoundField DataField="THEATRENAME" HeaderText="Theatre" />
          <asp:BoundField DataField="SHOWDATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" />
          <asp:BoundField DataField="SHOWTIME" HeaderText="Time" />
<asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-nowrap">
         <ItemTemplate>
      <asp:LinkButton CommandName="EditRow" CommandArgument='<%# Eval("SHOWID") %>'
      runat="server" CssClass="btn btn-sm btn-outline-warning me-1">?? Edit</asp:LinkButton>
    <asp:LinkButton CommandName="DeleteRow" CommandArgument='<%# Eval("SHOWID") %>'
                runat="server" CssClass="btn btn-sm btn-outline-danger"
           OnClientClick="return confirm('Delete this showtime?');">??? Delete</asp:LinkButton>
    </ItemTemplate>
  </asp:TemplateField>
        </Columns>
      <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No showtimes found.</p></EmptyDataTemplate>
      </asp:GridView>
    </div>
  </div>
</div>
</asp:Content>
