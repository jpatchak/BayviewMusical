<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.AdminEditstudentViewModel>" %>

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
            <h4>Student Details</h4>
     
        	<form action="<%=Url.Action("SaveStudent", "Admin") %>" method="post">
			    <div class="col-md-6">
                    <%=Html.HiddenFor(m=>m.MusicalID) %>
                    <%=Html.HiddenFor(m=>m.StudentID) %>
				    <div class="form-group">
                        <%= Html.LabelFor(m=>m.Code) %>
				        <%= Html.TextBoxFor(m => m.Code, new Dictionary<string, object>(){{"readonly", "true"},{"class","form-control"}})%>
				    </div>
			    </div>
                <div class="col-md-6">
				    <div class="form-group">
                        <%= Html.LabelFor(m=>m.Email) %>
				        <%= Html.TextBoxFor(m => m.Email, new { Class = "form-control", PlaceHolder = "Email" })%>
				    </div>
			    </div>
			    <div class="col-md-6">
				    <div class="form-group">
                        <%= Html.LabelFor(m=>m.FirstName) %>
				        <%= Html.TextBoxFor(m => m.FirstName, new { Class = "form-control", PlaceHolder = "First Name" })%>
				    </div>
			    </div>
			    <div class="col-md-6">
				    <div class="form-group">
                        <%= Html.LabelFor(m=>m.LastName) %>
				        <%= Html.TextBoxFor(m => m.LastName, new { Class = "form-control", PlaceHolder = "Last Name" })%>
				    </div>
			    </div>
                <div class="col-md-4">
				    <div class="form-group">
                        <%= Html.LabelFor(m=>m.Gender) %>
				        <%= Html.DropDownListFor(m => m.Gender, Model.GenderList , new { Class = "form-control" })%>
				    </div>
			    </div>
                <div class="col-md-4">
				    <div class="form-group">
                        <%= Html.LabelFor(m=>m.Grade) %>
				        <%= Html.DropDownListFor(m => m.Grade, Model.GradeList , new { Class = "form-control" })%>
				    </div>
			    </div>
                <div class="col-md-4">
				    <div class="form-group">
                        <%= Html.LabelFor(m=>m.RoleID) %>
				        <%= Html.DropDownListFor(m => m.RoleID, Model.RoleList , new { Class = "form-control" })%>
				    </div>
			    </div>
                <div class="col-md-6">
				    <div class="form-group">
                        <%= Html.LabelFor(m=>m.DateID) %>
				        <%= Html.DropDownListFor(m => m.DateID, Model.DateList , new { Class = "form-control" })%>
				    </div>
			    </div>
                <div class="col-md-6">
				    <div class="form-group">
                        <%= Html.LabelFor(m=>m.TimeID) %>
				        <%= Html.DropDownListFor(m => m.TimeID, Model.TimeList , new { Class = "form-control" })%>
				    </div>
			    </div>
				<div class="text-center col-lg-12">
				<button type="submit" class="btn btn-default">Save</button>
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
            (function ($, window) {
                $.fn.replaceOptions = function (options, includeAll) {
                    var self, $option;

                    this.empty();
                    self = this;

                    if (includeAll == true) {
                        self.append($("<option></option>")
                    .attr("value", "0")
                    .text("All"));
                    }

                    $.each(options, function (index, option) {
                        $option = $("<option></option>")
                        .attr("value", option.Value)
                        .text(option.Text);
                        self.append($option);
                    });
                };
            })(jQuery, window);

            $(document).ready(function () {
                $("#student-nav-link").addClass("active");
                $("#mobile-help-text").text("Edit Student");
        
            $("#DateID").change(function (ev) {
                dateID = $("#DateID").val();

                data = { dateID: dateID }

                $.ajax(
                        { type: "GET",
                            url: "/Admin/GetTimeSlots",
                            data: data,
                            contentType: "application/json;charset=utf-8",
                            dataType: "json",
                            async: true,
                            cache: false,
                            success: function (data) {
                                $("#TimeID").replaceOptions(data, false)
                            },
                            error: function (x, e) {
                                alert("The call to the server side failed. " + x.responseText);
                            }
                        });
            });
            $("#clear-button").click(function (ev) {
                $("#inputFirstName").val('');
                $("#inputLastName").val('');
                $("#inputCode").val('');
                $("#select-gender").val('A');
                $("#select-grade").val('A');
                $("#select-role").val('0');
                $("#select-time").val('0');
                $("#select-date")
                    .val('0')
                    .trigger('change');
            });
            });
        </script>
    </body>
</html>

