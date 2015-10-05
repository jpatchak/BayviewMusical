<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.AdminEditMusicalRole>" %>

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
        <div class="col-lg-3">
        </div>
        <div class="col-lg-6">
        	<form action="<%=Url.Action("SaveMusicalRole", "Admin") %>" method="post">
			    <div class="col-md-12">
                    <%=Html.HiddenFor(m=>m.MusicalID) %>
                    <%=Html.HiddenFor(m=>m.RoleID) %>
				    <div class="form-group">
                    <%= Html.LabelFor(m=>m.RoleName) %>
				    <%= Html.TextBoxFor(m => m.RoleName, new { Class = "form-control", PlaceHolder = "Role Name" })%>
				    </div>
			    </div>
                <div class="col-md-6">
				    <div class="form-group">
                        <%= Html.LabelFor(m=>m.Gender) %>
				        <%= Html.DropDownListFor(m => m.Gender, Model.GenderList , new { Class = "form-control" })%>
				    </div>
			    </div>
                <div class="col-md-6">
				    <div class="form-group">
                        <%= Html.LabelFor(m=>m.Grade) %>
				        <%= Html.DropDownListFor(m => m.Grade, Model.GradeList , new { Class = "form-control" })%>
				    </div>
			    </div>

				<div class="text-center col-lg-12">
				<button type="submit" class="btn btn-default">Submit</button>
				</div>
			</form>
            <%if (!Html.ViewData.ModelState.IsValid)
                { %>
                <div class="alert alert-danger col-xs-12" role="alert" style="margin-top: 10px;"><span class="glyphicon glyphicon-alert"></span><strong> Errors</strong><%= Html.ValidationSummary()%></div>
                <%} %>
        </div>
        <div class="col-lg-3">
        </div>
        </div>
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js" type="text/javascript"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#role-nav-link").addClass("active");
                $("#mobile-help-text").text("Roles");
            });
        </script>
    </body>
</html>
