<%@ Page Title="Theatre and Hall" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
  CodeBehind="TheatreCityHall.aspx.cs" Inherits="Kumari_Cinema.BasicForms.TheatreCityHall" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header-bar">
  <div class="container-fluid px-4">
    <h2>??? Theatre &amp; Hall Management</h2>
    <p class="mb-0" style="color:#ccc;">Manage theatres and their halls</p>
  </div>
</div>

<div class="container-fluid px-4">
  <asp:Label ID="lblMsg" runat="server" CssClass="alert-cinema d-block mb-3" Visible="false" />

  <div class="card mb-4">
    <div class="card-header"><asp:Label ID="lblTheatreTitle" runat="server" Text="Add New Theatre" /></div>
    <div class="card-body">
      <asp:HiddenField ID="hfTheatreId" runat="server" Value="0" />
      <div class="row g-3">
        <div class="col-md-3">
     <label class="form-label">Theatre Name *</label>
     <asp:TextBox ID="txtTheatreName" runat="server" CssClass="form-control" MaxLength="150" />
   <asp:RequiredFieldValidator ControlToValidate="txtTheatreName" runat="server"
            ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgTheatre" />
      </div>
        <div class="col-md-2">
<label class="form-label">City</label>
          <asp:TextBox ID="txtTheatreCity" runat="server" CssClass="form-control" MaxLength="100" />
        </div>
        <div class="col-md-3">
    <label class="form-label">Address</label>
   <asp:TextBox ID="txtTheatreAddress" runat="server" CssClass="form-control" MaxLength="255" />
        </div>
        <div class="col-md-2">
     <label class="form-label">Contact Number</label>
    <asp:TextBox ID="txtTheatreContact" runat="server" CssClass="form-control" MaxLength="20" />
        </div>
     <div class="col-12 mt-2">
       <asp:Button ID="btnSaveTheatre" runat="server" Text="?? Save Theatre"
        CssClass="btn btn-cinema-primary me-2" OnClick="btnSaveTheatre_Click" ValidationGroup="vgTheatre" />
          <asp:Button ID="btnCancelTheatre" runat="server" Text="? Cancel"
     CssClass="btn btn-outline-secondary" OnClick="btnCancelTheatre_Click" CausesValidation="false" />
        </div>
      </div>
    </div>
  </div>

  <div class="card mb-5">
<div class="card-header"><strong>??? All Theatres</strong></div>
<div class="card-body p-0">
      <asp:GridView ID="gvTheatres" runat="server" AutoGenerateColumns="false"
    CssClass="table mb-0" GridLines="None" DataKeyNames="THEATREID"
    OnRowCommand="gvTheatres_RowCommand" ShowHeaderWhenEmpty="true">
        <Columns>
          <asp:BoundField DataField="THEATREID" HeaderText="ID" />
 <asp:BoundField DataField="THEATRENAME" HeaderText="Name" />
        <asp:BoundField DataField="THEATRECITY" HeaderText="City" />
          <asp:BoundField DataField="THEATREADDRESS" HeaderText="Address" />
          <asp:BoundField DataField="THEATRECONTACTNUMBER" HeaderText="Contact" />
          <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-nowrap">
            <ItemTemplate>
            <asp:LinkButton CommandName="EditTheatre" CommandArgument='<%# Eval("THEATREID") %>'
                runat="server" CssClass="btn btn-sm btn-outline-warning me-1">?? Edit</asp:LinkButton>
    <asp:LinkButton CommandName="DeleteTheatre" CommandArgument='<%# Eval("THEATREID") %>'
                runat="server" CssClass="btn btn-sm btn-outline-danger"
    OnClientClick="return confirm('Delete this theatre?');">??? Delete</asp:LinkButton>
   </ItemTemplate>
          </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No theatres found.</p></EmptyDataTemplate>
      </asp:GridView>
    </div>
  </div>

  <hr style="border-color:#2a2a4e;" />

<div class="card mb-4">
    <div class="card-header"><asp:Label ID="lblHallTitle" runat="server" Text="Add New Hall" /></div>
    <div class="card-body">
      <asp:HiddenField ID="hfHallId" runat="server" Value="0" />
<div class="row g-3">
        <div class="col-md-3">
          <label class="form-label">Theatre *</label>
          <asp:DropDownList ID="ddlHallTheatre" runat="server" CssClass="form-select" />
          <asp:RequiredFieldValidator ControlToValidate="ddlHallTheatre" runat="server"
            InitialValue="" ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgHall" />
     </div>
 <div class="col-md-3">
    <label class="form-label">Hall Name *</label>
<asp:TextBox ID="txtHallName" runat="server" CssClass="form-control" MaxLength="100" />
          <asp:RequiredFieldValidator ControlToValidate="txtHallName" runat="server"
            ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgHall" />
        </div>
        <div class="col-md-2">
          <label class="form-label">Capacity</label>
          <asp:TextBox ID="txtCapacity" runat="server" CssClass="form-control" MaxLength="4" />
</div>
        <div class="col-md-3">
          <label class="form-label">Seat Layout</label>
 <asp:TextBox ID="txtSeatLayout" runat="server" CssClass="form-control" MaxLength="200" />
        </div>
        <div class="col-12 mt-2">
          <asp:Button ID="btnSaveHall" runat="server" Text="?? Save Hall"
     CssClass="btn btn-cinema-primary me-2" OnClick="btnSaveHall_Click" ValidationGroup="vgHall" />
      <asp:Button ID="btnCancelHall" runat="server" Text="? Cancel"
            CssClass="btn btn-outline-secondary" OnClick="btnCancelHall_Click" CausesValidation="false" />
   </div>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-header"><strong>?? All Halls (with Theatre)</strong></div>
    <div class="card-body p-0">
      <asp:GridView ID="gvHalls" runat="server" AutoGenerateColumns="false"
  CssClass="table mb-0" GridLines="None" DataKeyNames="HALLID"
      OnRowCommand="gvHalls_RowCommand" ShowHeaderWhenEmpty="true">
        <Columns>
   <asp:BoundField DataField="HALLID" HeaderText="Hall ID" />
      <asp:BoundField DataField="HALLNAME" HeaderText="Hall" />
          <asp:BoundField DataField="THEATRENAME" HeaderText="Theatre" />
          <asp:BoundField DataField="THEATRECITY" HeaderText="City" />
    <asp:BoundField DataField="HALLCAPACITY" HeaderText="Capacity" />
     <asp:BoundField DataField="SEATLAYOUT" HeaderText="Layout" />
       <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-nowrap">
            <ItemTemplate>
 <asp:LinkButton CommandName="EditHall" CommandArgument='<%# Eval("HALLID") %>'
          runat="server" CssClass="btn btn-sm btn-outline-warning me-1">?? Edit</asp:LinkButton>
 <asp:LinkButton CommandName="DeleteHall" CommandArgument='<%# Eval("HALLID") %>'
        runat="server" CssClass="btn btn-sm btn-outline-danger"
                OnClientClick="return confirm('Delete this hall?');">??? Delete</asp:LinkButton>
            </ItemTemplate>
      </asp:TemplateField>
   </Columns>
        <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No halls found.</p></EmptyDataTemplate>
      </asp:GridView>
    </div>
  </div>
</div>
</asp:Content>
