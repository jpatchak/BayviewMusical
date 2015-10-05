﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.AdminLoginViewModel>" %>

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
		<nav class="navbar navbar-default">
		  <div class="container-fluid">
		    <!-- Brand and toggle get grouped for better mobile display -->
		    <div class="navbar-header">
		      <a class="navbar-brand" href="/">Bayview Musical Auditions</a><p class="navbar-text">System Administrator Login</p>
		    </div>

		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      <ul class="nav navbar-nav">
		      </ul>
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>
		<div class="container-fluid">
			<div class="col-lg-3">
			</div>
			<div class="col-lg-6">
				<form action="<%=Url.Action("DoLogin", "Admin") %>" method="post">
				  <div class="col-md-12">
					  <div class="form-group">
                        <%=Html.LabelFor(m=>m.UserName) %>
                        <%=Html.TextBoxFor(m => m.UserName, new { Class = "form-control", PlaceHolder = "Username" })%>
                      </div>
                  </div>
				  <div class="col-md-12">
					  <div class="form-group">
                        <%=Html.LabelFor(m=>m.Password) %>
                        <%=Html.TextBoxFor(m => m.Password, new { type = "password", Class="form-control", PlaceHolder="Password" })%>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.14.0/jquery.validate.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#UserName").focus();
            });
        </script>
	</body>
</html>