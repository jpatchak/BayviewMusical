<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.AdminHomeViewModel>" %>

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
        	<form action="<%=Url.Action("SaveMusical", "Admin") %>" method="post">
			    <div class="col-md-12">
                    <%=Html.HiddenFor(m=>m.MusicalID) %>
				    <div class="form-group">
                    <%= Html.LabelFor(m=>m.MusicalName) %>
				    <%= Html.TextBoxFor(m=>m.MusicalName, new{Class="form-control", PlaceHolder="Musical Name"}) %>
				    </div>
			    </div>
                <div class="col-md-6">
				    <div class="form-group">
                    <%= Html.LabelFor(m=>m.SignUpStartDate) %>
				    <%= Html.TextBoxFor(m => m.SignUpStartDate, new { Class = "form-control", PlaceHolder = "Start Date" })%>
                    </div>
				</div>
                <div class="col-md-6">
				    <div class="form-group">
                    <%= Html.LabelFor(m=>m.SignUpEndDate) %>
				    <%= Html.TextBoxFor(m => m.SignUpEndDate, new { Class = "form-control", PlaceHolder = "End Date" })%>
                    </div>
				</div>
			    <div class="col-md-12">
				    <div class="form-group">
                    <%= Html.LabelFor(m=>m.ExpiredMessage) %>
				    <%= Html.TextAreaFor(m => m.ExpiredMessage, new { Class = "form-control", PlaceHolder = "This is the text that shows if a user tries to enter a code for a musical that has closed its sign up window. Basic HTML is supported (e.g. anchor tags for links)." })%>
				    </div>
			    </div>
			    <div class="col-md-12">
				    <div class="form-group">
                    <%= Html.LabelFor(m=>m.ConfirmationMessage) %>
				    <%= Html.TextAreaFor(m => m.ConfirmationMessage, new { Class = "form-control", PlaceHolder = "This is the text that shows when a user has completed signing up for an audition. Basic HTML is supported (e.g. anchor tags for links)." })%>
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
                $("#home-nav-link").addClass("active");
                $("#mobile-help-text").text("Musical Details");
                $("#MusicalName").focus();
            });
        </script>
    </body>
</html>
