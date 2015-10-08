<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.AdminRolesViewModel>" %>

<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Bayview Musical Auditions</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<style>
			li.active{
				font-weight: bold;
			}
		</style>
	</head>
	<body>
        <!--top nav-->
        <% Html.RenderAction("TopNavigation", "Admin", new { musicalID = Model.MusicalID }); %>
        <div class="container-fluid">
            <div class="col-md-6 col-md-offset-3">
        	    <h4>Roles</h4>
                <a class="btn btn-default" href="/Admin/EditMusicalRole?musicalID=<%=Model.MusicalID %>&roleID=0">Add New Role</a>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Role Name</th>
                            <th>Gender</th>
                            <th>Grade</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%foreach(BayviewMusical.Models.AdminRoleTableRow r in Model.Roles){ %>
                        <tr id="Role<%=r.ID %>">
                            <td><%=r.Name %></td>
                            <td><%=r.GenderName %></td>
                            <td><%=r.GradeLevelName %></td>
                            <td><a class="btn btn-default btn-xs" title="Edit Role" href="/Admin/EditMusicalRole?musicalID=<%=Model.MusicalID %>&roleID=<%=r.ID %>"><span class="glyphicon glyphicon-pencil"></span></a></td>
                            <td><button class="btn btn-danger btn-xs data-okcancel-dialog" data-modal-title="Delete <%=r.Name %>" data-modal-body="Delete the <%=r.Name %> role and all associations to students?" data-modal-okclick="DeleteRole('<%=r.ID %>')" title="Delete Role"><span class="glyphicon glyphicon-remove-sign"></span></button></td>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
            </div>
        </div>
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js" type="text/javascript"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="/Scripts/ModalDialog.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#role-nav-link").addClass("active");
                $("#mobile-help-text").text("Roles");
            });
            function DeleteRole(roleID) {
                data = { roleID: roleID };
                $.ajax(
                        { type: "POST",
                            url: "/Admin/DeleteMusicalRole",
                            data: data,
                            dataType: "json",
                            async: true,
                            cache: false,
                            success: function (data) {
                                $("#Role" + roleID).remove();
                            },
                            error: function (x, e) {
                                alert("The call to the server side failed. " + x.responseText);
                            }
                        });
                
            }
        </script>
    </body>
</html>

