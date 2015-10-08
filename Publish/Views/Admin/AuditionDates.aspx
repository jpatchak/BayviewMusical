<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.AdminDatesViewModel>" %>

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
        <div class="col-lg-6 col-lg-offset-3">
        	<h4>Dates and Times</h4>
			<%if(Model.MusicalDates.Count>0){ %><p>Click on a date below to edit or delete times.</p><%} %>
            <a class="btn btn-default" style="margin-bottom:5px;" href="/Admin/EditAuditionDate?musicalID=<%=Model.MusicalID %>&dateID=0">New Audition Date</a>
			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                <%foreach (BayviewMusical.Models.MusicalDate md in Model.MusicalDates)
                  { %>
				<div class="panel panel-default" id="date<%=md.DateID %>">
				    <div class="panel-heading" role="tab" id="heading<%=md.DateID %>">
				        <h4 class="panel-title">
				        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=md.DateID %>" aria-expanded="false" aria-controls="collapse<%=md.DateID %>">
				            <%=md.DateDisplay%>
				        </a>
                        <a class="btn btn-default btn-xs" style="margin-left:10px;" href="/Admin/EditAuditionDate?musicalID=<%=Model.MusicalID %>&dateID=<%=md.DateID %>"><span class="glyphicon glyphicon-pencil" title="Edit Date"></span></a>
                        <td><button class="btn btn-danger btn-xs data-okcancel-dialog" data-modal-title="Delete <%=md.DateDisplay %>" data-modal-body="Delete <%=md.DateDisplay %> and all associations to students and time slots?" data-modal-okclick="DeleteAuditionDate('<%=md.DateID %>')" title="Delete Time Slot"><span class="glyphicon glyphicon-remove-sign"></span></button></td>
				        </h4>

				    </div>
				    <div id="collapse<%=md.DateID %>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=md.DateID %>">
				        <div class="panel-body">
                        <a class="btn btn-default" style="margin-bottom:5px;" href="/Admin/EditAuditionTime?musicalID=<%=Model.MusicalID %>&dateID=<%=md.DateID %>&timeID=0">New Audition Time</a>
				        <table class="table table-striped">
                            <tr>
                                <th>Time Slot Name</th>
                                <th>Capacity</th>
                                <th>Status</th>
                                <th></th>
                                <th></th>
                            </tr>
                            <%foreach (BayviewMusical.Models.TimeSlot ts in md.TimeSlots)
                              { %>
                                <tr id="time<%=ts.ID %>" style="<%=ts.Status=="Full"?"font-style:italic;":"" %>">
				          		    <td><%=ts.Name%></td>
				          		    <td><%=ts.Message%></td>
                                    <td><%=ts.Status%></td>
                                    <td><a class="btn btn-default btn-xs" title="Edit Time Slot" href="/Admin/EditAuditionTime?musicalID=<%=Model.MusicalID %>&dateID=<%=md.DateID %>&timeID=<%=ts.ID %>"><span class="glyphicon glyphicon-pencil"></span></a></td>
                                    <td><button class="btn btn-danger btn-xs data-okcancel-dialog" data-modal-title="Delete <%=ts.Name %>" data-modal-body="Delete the <%=ts.Name %> time slot on <%=md.DateDisplay %> and all associations to students?" data-modal-okclick="DeleteAuditionTime('<%=ts.ID %>')" title="Delete Time Slot"><span class="glyphicon glyphicon-remove-sign"></span></button></td>
                          	    </tr>
                            <%} %>
				        </table>
				        </div>
				    </div>
				</div>
                <%} %>
            </div>
        </div>
        </div>
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js" type="text/javascript"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="/Scripts/ModalDialog.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#date-nav-link").addClass("active");
                $("#mobile-help-text").text("Audition Dates");
            });
            function DeleteAuditionTime(timeID) {
                data = { timeID: timeID };
                $.ajax(
                        { type: "POST",
                            url: "/Admin/DeleteAuditionTime",
                            data: data,
                            dataType: "json",
                            async: true,
                            cache: false,
                            success: function (data) {
                                $("#time" + timeID).remove();
                            },
                            error: function (x, e) {
                                alert("The call to the server side failed. " + x.responseText);
                            }
                        });
                
            }
            function DeleteAuditionDate(dateID) {
                data = { dateID: dateID };
                $.ajax(
                        { type: "POST",
                            url: "/Admin/DeleteAuditionDate",
                            data: data,
                            dataType: "json",
                            async: true,
                            cache: false,
                            success: function (data) {
                                $("#date" + dateID).remove();
                            },
                            error: function (x, e) {
                                alert("The call to the server side failed. " + x.responseText);
                            }
                        });

            }
        </script>
    </body>
</html>
