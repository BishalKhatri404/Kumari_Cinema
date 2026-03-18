<%@ Page Title="Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Users.aspx.cs" Inherits="Kumari_Cinema.BasicForms.Users" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header-bar">
  <div class="container-fluid px-4">
    <h2>?? User Management</h2>
    <p class="mb-0" style="color:#ccc;">Create, view, edit and delete user accounts</p>
  </div>
</div>

<div class="container-fluid px-4">
  <asp:Label ID="lblMsg" runat="server" CssClass="alert-cinema d-block mb-3" Visible="false" />

  <div class="card mb-4">
    <div class="card-header">
<asp:Label ID="lblFormTitle" runat="server" Text="Add New User" />
 </div>
    <div class="card-body">
      <asp:HiddenField ID="hfUserId" runat="server" Value="0" />
<div class="row g-3">
        <div class="col-md-3">
          <label class="form-label">UserName *</label>
     <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" MaxLength="100" />
          <asp:RequiredFieldValidator ControlToValidate="txtUserName" runat="server"
            ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgUser" />
        </div>
        <div class="col-md-3">
          <label class="form-label">Email</label>
     <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" MaxLength="100" />
      </div>
  <div class="col-md-3">
       <label class="form-label">Phone</label>
          <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" MaxLength="20" />
  </div>
        <div class="col-md-2">
   <label class="form-label">Age</label>
<asp:TextBox ID="txtAge" runat="server" CssClass="form-control" MaxLength="3" />
        </div>
        <div class="col-12 mt-3">
 <asp:Button ID="btnSave" runat="server" Text="?? Save" CssClass="btn btn-cinema-primary me-2"
         OnClick="btnSave_Click" ValidationGroup="vgUser" />
 <asp:Button ID="btnCancel" runat="server" Text="? Cancel" CssClass="btn btn-outline-secondary"
            OnClick="btnCancel_Click" CausesValidation="false" />
        </div>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-header"><strong>?? All Users</strong></div>
    <div class="card-body p-0">
      <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="false"
   CssClass="table mb-0" GridLines="None" DataKeyNames="USERID"
    OnRowCommand="gvUsers_RowCommand" ShowHeaderWhenEmpty="true">
        <Columns>
          <asp:BoundField DataField="USERID" HeaderText="ID" />
     <asp:BoundField DataField="USERNAME" HeaderText="UserName" />
       <asp:BoundField DataField="PHONE" HeaderText="Phone" />
 <asp:BoundField DataField="EMAIL" HeaderText="Email" />
      <asp:BoundField DataField="AGE" HeaderText="Age" />
          <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-nowrap">
     <ItemTemplate>
           <asp:LinkButton CommandName="EditRow" CommandArgument='<%# Eval("USERID") %>'
     runat="server" CssClass="btn btn-sm btn-outline-warning me-1">?? Edit</asp:LinkButton>
            <asp:LinkButton CommandName="DeleteRow" CommandArgument='<%# Eval("USERID") %>'
                runat="server" CssClass="btn btn-sm btn-outline-danger"
         OnClientClick="return confirm('Delete this user?');">??? Delete</asp:LinkButton>
  </ItemTemplate>
  </asp:TemplateField>
     </Columns>
 <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No users found.</p></EmptyDataTemplate>
      </asp:GridView>
    </div>
  </div>
</div>
</asp:Content>
