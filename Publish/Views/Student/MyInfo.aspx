<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.StudentMyInfoModel>" %>

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
					<li class="active">2. My Details</li>
					<li class="disabled">3. My Time</li>
                    <li class="disabled">4. Confirmation</li>
				</ol>
				<form action="<%=Url.Action("SubmitMyInfo", "Student") %>" method="post">
                  <%= Html.HiddenFor(m => m.Code, new { id = Model.Code })%>
				  <div class="row">
                      <div class="col-md-6">
					      <div class="form-group">
                            <%= Html.LabelFor(m=>m.FirstName) %>
				            <%= Html.TextBoxFor(m=>m.FirstName, new{Class="form-control", PlaceHolder="First Name"}) %>
					      </div>
				      </div>
				      <div class="col-md-6">
					      <div class="form-group">
                            <%= Html.LabelFor(m=>m.LastName) %>
				            <%= Html.TextBoxFor(m=>m.LastName, new{Class="form-control", PlaceHolder="Last Name"}) %>
					      </div>
				      </div>
                  </div>
                  <div class="row">
				      <div class="col-md-12">
					      <div class="form-group">
                            <%= Html.LabelFor(m=>m.Email) %>
				            <%= Html.TextBoxFor(m => m.Email, new { Class = "form-control", PlaceHolder = "Email", type="email" })%>

					      </div>
				      </div>
                  </div>
				  <div class="row">
                      <div class="col-md-6">
					      <div class="form-group">
					        <%= Html.LabelFor(m => m.Gender)%><br />
                            <%= Html.RadioButtonFor(m => m.Gender, "M", new { Checked = "checked" })%> Male
					        <%= Html.RadioButtonFor(m => m.Gender, "F")%> Female
					      </div>
				      </div>
				      <div class="col-md-6">
					      <div class="form-group">
					        <%= Html.LabelFor(m=>m.Grade) %><br />
                            <%= Html.RadioButtonFor(m => m.Grade, "7", new { Checked = "checked" })%> 7th
					        <%= Html.RadioButtonFor(m => m.Grade, "8")%> 8th
					      </div>
				      </div>				  
                  </div>
                  <div class="row">
					<div id="desired-roles-list">
                    <%Html.RenderAction("DesiredRoles", new { studentCode = Model.Code, gender = Model.Gender, grade = Model.Grade }); %>
					</div>
                  </div>				  				  
				  <div class="row">
                      <div class="text-center">
				  	    <button type="submit" class="btn btn-default">Submit</button>
				      </div>
                  </div>
				</form>
                <%if (!Html.ViewData.ModelState.IsValid)
                    { %>
                    <div class="row"><div class="alert alert-danger col-lg-12" role="alert" style="margin-top: 10px;"><span class="glyphicon glyphicon-alert"></span><strong> Errors</strong><%= Html.ValidationSummary()%></div></div>
                    <%} %>
			</div>
        </div>
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js" type="text/javascript"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("input[name='Gender']:radio").change(function () { GetRolesList(); });
                $("input[name='Grade']:radio").change(function () { GetRolesList(); });
                $("#FirstName").focus();
            });

            function GetRolesList() {
                gender = $('input[name="Gender"]:checked').val();
                grade = $('input[name="Grade"]:checked').val();
                studentCode = $('input[name="Code"]').val();

                data = { studentCode: studentCode, gender: gender, grade: grade }

                $.ajax(
                        { type: "GET",
                            url: "/Student/DesiredRoles",
                            data: data,
                            contentType: "application/json;charset=utf-8",
                            dataType: "html",
                            async: true,
                            cache: false,
                            success: function (data) {
                                $('#desired-roles-list').html(data);
                            },
                            error: function (x, e) {
                                alert("The call to the server side failed. " + x.responseText);
                            }
                        });
            }
        </script>
	</body>
</html>
		
