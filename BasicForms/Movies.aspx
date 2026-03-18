<%@ Page Title="Movies" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Movies.aspx.cs" Inherits="Kumari_Cinema.BasicForms.Movies" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header-bar">
  <div class="container-fluid px-4">
    <h2>?? Movie Management</h2>
    <p class="mb-0" style="color:#ccc;">Manage movies in the cinema system</p>
  </div>
</div>

<div class="container-fluid px-4">
  <asp:Label ID="lblMsg" runat="server" CssClass="alert-cinema d-block mb-3" Visible="false" />

  <div class="card mb-4">
    <div class="card-header"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Movie" /></div>
    <div class="card-body">
  <asp:HiddenField ID="hfMovieId" runat="server" Value="0" />
      <div class="row g-3">
        <div class="col-md-4">
          <label class="form-label">Title *</label>
          <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" MaxLength="200" />
   <asp:RequiredFieldValidator ControlToValidate="txtTitle" runat="server"
     ErrorMessage="Required" ForeColor="Red" Display="Dynamic" ValidationGroup="vgMovie" />
</div>
        <div class="col-md-2">
          <label class="form-label">Duration (min)</label>
      <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" MaxLength="4" />
        </div>
        <div class="col-md-3">
          <label class="form-label">Genre</label>
          <asp:TextBox ID="txtGenre" runat="server" CssClass="form-control" MaxLength="100" />
  </div>
  <div class="col-md-2">
          <label class="form-label">Language</label>
          <asp:TextBox ID="txtLanguage" runat="server" CssClass="form-control" MaxLength="50" />
        </div>
      <div class="col-md-3">
  <label class="form-label">Release Date</label>
   <asp:TextBox ID="txtReleaseDate" runat="server" CssClass="form-control" TextMode="Date" />
        </div>
        <div class="col-12 mt-3">
       <asp:Button ID="btnSave" runat="server" Text="?? Save" CssClass="btn btn-cinema-primary me-2"
      OnClick="btnSave_Click" ValidationGroup="vgMovie" />
    <asp:Button ID="btnCancel" runat="server" Text="? Cancel" CssClass="btn btn-outline-secondary"
            OnClick="btnCancel_Click" CausesValidation="false" />
   </div>
    </div>
    </div>
  </div>

  <div class="card">
    <div class="card-header"><strong>?? All Movies</strong></div>
    <div class="card-body p-0">
      <asp:GridView ID="gvMovies" runat="server" AutoGenerateColumns="false"
        CssClass="table mb-0" GridLines="None" DataKeyNames="MOVIEID"
        OnRowCommand="gvMovies_RowCommand" ShowHeaderWhenEmpty="true">
     <Columns>
        <asp:BoundField DataField="MOVIEID" HeaderText="ID" />
          <asp:BoundField DataField="TITLE" HeaderText="Title" />
      <asp:BoundField DataField="DURATION" HeaderText="Duration" />
          <asp:BoundField DataField="GENRE" HeaderText="Genre" />
          <asp:BoundField DataField="LANGUAGE" HeaderText="Language" />
          <asp:BoundField DataField="RELEASEDATE" HeaderText="Release Date" DataFormatString="{0:dd/MM/yyyy}" />
          <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-nowrap">
   <ItemTemplate>
        <asp:LinkButton CommandName="EditRow" CommandArgument='<%# Eval("MOVIEID") %>'
            runat="server" CssClass="btn btn-sm btn-outline-warning me-1">?? Edit</asp:LinkButton>
       <asp:LinkButton CommandName="DeleteRow" CommandArgument='<%# Eval("MOVIEID") %>'
      runat="server" CssClass="btn btn-sm btn-outline-danger"
       OnClientClick="return confirm('Delete this movie?');">??? Delete</asp:LinkButton>
          </ItemTemplate>
       </asp:TemplateField>
    </Columns>
        <EmptyDataTemplate><p class="text-center p-3" style="color:#888;">No movies found.</p></EmptyDataTemplate>
      </asp:GridView>
    </div>
  </div>
</div>
</asp:Content>
