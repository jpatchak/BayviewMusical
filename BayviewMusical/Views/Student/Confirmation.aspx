<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.StudentConfirmationModel>" %>

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
					<li class="disabled">1. My Code</li>
					<li><a href="/MyInfo?code=<%=Model.Code %>">2. My Details</a></li>
					<li> <a href="/MyTime?code=<%=Model.Code %>">3. My Time</a></li>
                    <li class="active">4. Confirmation</li>
				</ol>
                <p><%=Model.ConfirmationMessage %></p>
                <div class="jumbotron">
                    <p>You are signed up for the following time:</p>
                    <p><strong><%=Model.AuditionDate %></strong><br />
                        <strong><%=Model.AuditionGroup %></strong>
                    </p>
                </div>
			</div>
		</div>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js" type="text/javascript"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" type="text/javascript"></script>	
	</body>
</html>
