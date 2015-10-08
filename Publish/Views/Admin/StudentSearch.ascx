<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<BayviewMusical.Models.AdminStudentSearchViewModel>" %>
<div class="col-md-12">
<p><%=Model.SearchResults.Count %> Search Results</p>
</div>
<table class="table table-striped sortable">
    <thead>
        <tr>
            <th>Code</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Gender</th>
            <th>Grade</th>
            <th>Email</th>
            <th>Role</th>
            <th>Date</th>
            <th>Time</th>
            <th data-defaultsort='disabled'></th>
            <th data-defaultsort='disabled'></th>
        </tr>
    </thead>
    <tbody>
        <%foreach (BayviewMusical.Models.StudentSearchResult sr in Model.SearchResults)
          { %>
          <tr id="<%=sr.code %>">
            <td><%=sr.code %></td>
            <td><%=sr.firstName %></td>
            <td><%=sr.lastName %></td>
            <td><%=sr.gender %></td>
            <td><%=sr.grade %></td>
            <td><%=sr.email %></td>
            <td><%=sr.roleName %></td>
            <td data-dateformat="MM/DD/YYYY"><%=sr.dateName %></td>
            <td data-value="<%=sr.dateName %><%=sr.timeName %>"><%=sr.timeName %></td>
            <td><a class="btn btn-default btn-xs" href="/Admin/EditStudent?musicalID=<%=sr.musicalID %>&studentID=<%=sr.studentID %>"><span class="glyphicon glyphicon-pencil"></span></a></td>
            <td><button class="btn btn-danger btn-xs data-okcancel-dialog" data-modal-title="Delete <%=sr.firstName %> <%=sr.lastName %>?" data-modal-body="Are you sure you want to delete this student?" data-modal-okclick="DeleteStudent('<%=sr.code %>')"><span class="glyphicon glyphicon-remove-sign"></span></button></td>
          </tr>
        <%} %>
    </tbody>
</table>
<script src="/Scripts/ModalDialog.js" type="text/javascript"></script>

