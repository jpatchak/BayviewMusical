<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.StudentSignUpModel>" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Bayview Musical Auditions</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.14.0/jquery.validate.min.js" type="text/javascript"></script>
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
		      <a class="navbar-brand" href="/">Bayview Musical Auditions</a><p class="navbar-text"><%=BayviewMusical.Musical.CurrentMusical().name %></p>
		    </div>

		    <!-- Collect the nav links, forms, and other content for toggling -->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		      <ul class="nav navbar-nav">
		      </ul>
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>
		<div class="container-fluid">
        
			<div class="col-md-6 col-md-offset-3">
				<ol class="breadcrumb">
					<li class="active">1. My Code</li>
					<li class="disabled">2. My Details</li>
					<li class="disabled">3. My Time</li>
                    <li class="disabled">4. Confirmation</li>
				</ol>
				<form action="<%=Url.Action("SubmitCode", "Student") %>" method="post">
				  <div class="form-group">
                    <%= Html.LabelFor(m=>m.code) %>
				    <%= Html.TextBoxFor(m=>m.code, new{Class="form-control", PlaceHolder="My Code"}) %>
				  </div>
				  <div class="text-center row">
				  	<button type="submit" class="btn btn-default">Submit</button>
				  </div>
                  <%if (!Html.ViewData.ModelState.IsValid)
                    { %>
                    <div class="alert alert-danger" role="alert" style="margin-top: 10px;"><span class="glyphicon glyphicon-alert"></span><strong> Errors</strong><%= Html.ValidationSummary()%></div>
                    <%} %>
				</form>
			</div>
		</div>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js" type="text/javascript"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" type="text/javascript"></script>		
        <script type="text/javascript">
            $(document).ready(function () {
                $("#code").focus();
            });
        </script>
	</body>
</html>