<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.AdminEditAuditionTime>" %>
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
        	<form action="<%=Url.Action("SaveAuditionTime", "Admin") %>" method="post">
			    <div class="col-md-12">
                    <%=Html.HiddenFor(m=>m.MusicalID) %>
                    <%=Html.HiddenFor(m=>m.DateID) %>
                    <%=Html.HiddenFor(m=>m.TimeID) %>
				    <div class="form-group">
                    <%= Html.LabelFor(m=>m.TimeDescription) %>
				    <%= Html.TextBoxFor(m => m.TimeDescription, new { Class = "form-control", PlaceHolder = "Time Slot Description" })%>
				    </div>
			    </div>
			    <div class="col-md-4">
				    <div class="form-group">
                    <%= Html.LabelFor(m=>m.SignUpStartDate) %>
				    <%= Html.TextBoxFor(m => m.SignUpStartDate, new { Class = "form-control", PlaceHolder = "Signup Begins ('MM/DD/YYYY')" })%>
				    </div>
			    </div>
                <div class="col-md-4">
				    <div class="form-group">
                    <%= Html.LabelFor(m=>m.SignUpEndDate) %>
				    <%= Html.TextBoxFor(m => m.SignUpEndDate, new { Class = "form-control", PlaceHolder = "Signup Ends ('MM/DD/YYYY')" })%>
				    </div>
			    </div>
			    <div class="col-md-4">
				    <div class="form-group">
                    <%= Html.LabelFor(m=>m.Capacity) %>
				    <%= Html.TextBoxFor(m => m.Capacity, new { Class = "form-control", PlaceHolder = "Max Capacity" })%>
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
                $("#date-nav-link").addClass("active");
                $("#mobile-help-text").text("Audition Dates");
                $("#TimeDescription").focus();
            });
        </script>
    </body>
</html>
