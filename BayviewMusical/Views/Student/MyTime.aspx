<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.StudentMyTimeModel>" %>

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
			<div class="col-lg-3">
			</div>
			<div class="col-lg-6">
				<ol class="breadcrumb">
					<li class="disabled">1. My Code</li>
					<li><a href="/MyInfo?code=<%=Model.Code %>">2. My Details</a></li>
					<li class="active">3. My Time</li>
                    <%if (!Model.HasTime)
                      { %><li class="disabled"><%}
                      else
                      { %><li><a href="/Confirmation?code=<%=Model.Code %>"><%} %>4. Confirmation<%if (Model.HasTime)
                                                                                                   {%></a><%} %></li>
				</ol>
				<h4>Select Your Time</h4>
				<p>Click on a date below to select your time.</p>
                <%if (Model.InfoMessage != null)
                  { %>
                <p><%=Model.InfoMessage%></p>
                <%} %>
				<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                    <%foreach (BayviewMusical.Models.MusicalDate md in Model.MusicalDates){ %>
				  <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="heading<%=md.DateID %>">
				      <h4 class="panel-title">
				        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=md.DateID %>" aria-expanded="false" aria-controls="collapse<%=md.DateID %>">
				          <%=md.DateDisplay %>
				        </a>
				      </h4>
				    </div>
				    <div id="collapse<%=md.DateID %>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=md.DateID %>">
				      <div class="panel-body">
                        <%if (md.TimeSlots.Select(t=>t).Where(t=>t.Status!="Inactive").Count()==0)
                          { %><p>There are no active times available. Please check back later.</p><%} %>
				        <table class="table table-striped">
                            <%foreach (BayviewMusical.Models.TimeSlot ts in md.TimeSlots)
                              { %>
                              <%if (ts.Status != "Inactive")
                                { %>
                                  <tr style="<%=ts.Message.Contains("Full")?"font-style:italic;":"" %>">
				          		    <td><%=ts.Name%></td>
				          		    <td><%=ts.Message%></td>
				          		    <td><%if (ts.Status == "Active")
                                          { %><button class="btn btn-xs btn-default btn-signup" data-id="<%=ts.ID %>">Sign Up</button><%} %>
                                        <%if (ts.Status == "Mine")
                                          { %><i>My Slot</i><%} %>
                                    </td>
                          	    </tr>
                            <%} %>
                            <%} %>
				        </table>
				      </div>
				    </div>
				  </div>
                  <%} %>
                                  <%if (!Html.ViewData.ModelState.IsValid)
                    { %>
                    <div class="alert alert-danger col-xs-12" role="alert" style="margin-top: 10px;"><span class="glyphicon glyphicon-alert"></span><strong> Errors</strong><%= Html.ValidationSummary()%></div>
                    <%} %>
			</div>

            <form id="hidden-form" action="<%=Url.Action("SubmitMyTime", "Student") %>" method="post" style="display:none;">
                <%=Html.TextBoxFor(m=>m.Code) %>
                <input id="timeID" name="timeID" />
            </form>
			<div class="col-lg-3">
			</div>
		</div>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js" type="text/javascript"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" type="text/javascript"></script>	
        <script>
            $(document).ready(function () {
                $(".btn-signup").click(function (e) {
                    $("#timeID").val($(this).attr("data-id"));
                    $("#hidden-form").submit();
                });
            });
        </script>	
	</body>
</html>