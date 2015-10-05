<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<BayviewMusical.Models.AdminStudentViewModel>" %>

<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Bayview Musical Auditions</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="/Content/bootstrap-sortable.css">
	</head>
	<body>
        <!--top nav-->
        <% Html.RenderAction("TopNavigation", "Admin", new { musicalID = Model.MusicalID }); %>    
        <!-- main content div -->
    <div class="container-fluid">
        <%=Html.HiddenFor(m=>m.MusicalID) %>
      <div class="col-lg-3">
      </div>
      <div class="col-lg-6">
          <h4>Student Search</h4>
          <div class="col-md-4">
            <div class="form-group">
              <label for="inputFirstName">First Name</label>
              <input type="text" class="form-control" id="inputFirstName" placeholder="First Name">
            </div>
          </div>
          <div class="col-md-4">
            <div class="form-group">
              <label for="inputLastName">Last Name</label>
              <input type="text" class="form-control" id="inputLastName" placeholder="Last Name">
            </div>
          </div>
          <div class="col-md-4">
            <div class="form-group">
              <label for="inputCode">Secret Code</label>
              <input type="text" class="form-control" id="inputCode" placeholder="Secret Code">
            </div>
          </div>          
          <div class="col-md-4">
            <div class="form-group">
              <label for="select-gender">Gender</label>
              <select class="form-control" value="A" id="select-gender">
                <option value="A">All</option>
                <option value="M">Male</option>
                <option value="F">Female</option>
              </select>
            </div>
          </div>       
          <div class="col-md-4">
            <div class="form-group">
              <label for="select-grade">Grade</label>
              <select class="form-control" value="A" id="select-grade">
                <option value="A">All</option>
                <option value="7">7th</option>
                <option value="8">8th</option>
              </select>
            </div>
          </div>               
          <div class="col-md-4">
            <div class="form-group">
              <label for="select-role">Role</label>
              <select class="form-control" value="A" id="select-role">
                <option value="0">All</option>
                <%foreach (BayviewMusical.MusicalRole mr in BayviewMusical.MusicalRole.AllRoles(Model.MusicalID))
                  { %>
                <option value="<%=mr.roleID %>"><%=mr.name %></option>
                <%} %>
              </select>
            </div>
          </div> 
          <div class="col-md-6">
            <div class="form-group">
              <label for="select-date">Audition Date</label>
              <select class="form-control" id="select-date">
                <option value="0">All</option>
                <%foreach (BayviewMusical.Models.MusicalDate md in BayviewMusical.Models.MusicalDate.AllDates(Model.MusicalID))
                  { %>
                <option value="<%=md.DateID %>"><%=md.DateDisplay %></option>
                <%} %>
                
              </select>
            </div>
          </div>     
          <div class="col-md-6">
            <div class="form-group">
              <label for="select-date">Audition Date</label>
              <select class="form-control" id="select-time">
                <option value="0">All</option>
              </select>
            </div>
          </div>      
          <div class="text-center col-lg-12">
            <a class="btn btn-primary" id="search-button">Search</a>
            <a class="btn btn-default" id="clear-button">Clear</a>
          </div>                       
      </div>
      <div class="col-lg-3">

      </div>  
      <div class="col-lg-12" id="search-results">
        
      </div>    
    </div>
    <!-- end main content div -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js" type="text/javascript"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.3.1/moment.min.js" type="text/javascript"></script>
    <script src="/Scripts/bootstrap-sortable.js" type="text/javascript"></script>
    
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
            $("#select-date").change(function (ev) {
                dateID = $("#select-date").val();

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
                                $("#select-time").replaceOptions(data, true)
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
            $("#search-button").click(function (ev) {
                //string musicalID, string firstName, string lastName, string code, string gender, string grade, string roleID, string dateID, string timeID
                musicalID = $("#MusicalID").val();
                firstName = $("#inputFirstName").val();
                lastName = $("#inputLastName").val();
                code = $("#inputCode").val();
                gender = $("#select-gender").val();
                grade = $("#select-grade").val();
                roleID = $("#select-role").val();
                dateID = $("#select-date").val();
                timeID = $("#select-time").val();

                data = { musicalID: musicalID,
                    firstName: firstName,
                    lastName: lastName,
                    code: code,
                    gender: gender,
                    grade: grade,
                    roleID: roleID,
                    dateID: dateID,
                    timeID: timeID
                };

                $.ajax(
                        { type: "GET",
                            url: "/Admin/StudentSearch",
                            data: data,
                            contentType: "application/json;charset=utf-8",
                            dataType: "html",
                            async: true,
                            cache: false,
                            success: function (data) {
                                $("#search-results").html(data);
                                $.bootstrapSortable(true);
                            },
                            error: function (x, e) {
                                alert("The call to the server side failed. " + x.responseText);
                            }
                        });
            });
            $("#student-nav-link").addClass("active");
            $("#mobile-help-text").text("Students");
        });
        function DeleteStudent(code) {
            data = { code: code };
            $.ajax(
                        { type: "POST",
                            url: "/Admin/DeleteStudent",
                            data: data,
                            datatype: "json",
                            async: true,
                            cache: false,
                            success: function (data) {
                                $("#" + code).remove();
                            },
                            error: function (x, e) {
                                alert("The call to the server side failed. " + x.responseText);
                            }
                        });
            
        }
    </script>
  </body>
</html>
