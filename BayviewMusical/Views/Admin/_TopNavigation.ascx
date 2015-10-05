<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<BayviewMusical.Models.AdminTopNavigationViewModel>" %>

    <!--NAV bar-->
    <nav class="navbar navbar-default">
      <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-main" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Bayview Musical Auditions</a><p class="visible-xs navbar-text" id="mobile-help-text">Musical Details</p>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="nav-main">
          <ul class="nav navbar-nav">
              <li class="dropdown">
                <a href="/Admin/Home?musicalID=<%=Model.Musical.musicalID %>" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" id="musical-name"><%=Model.Musical.name %> <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <%foreach (BayviewMusical.Musical m in Model.AllMusicals)
                  { %>
                    <li><a href="/Admin/Home?musicalID=<%=m.musicalID %>"><%=m.name %></a></li>
                <%} %>
                <li role="separator" class="divider"></li>
                <li><a href="/Admin/Home?musicalID=0">New Musical...</a></li>
              </ul>
            </li>
            <li class="nav-link" id="home-nav-link"><a href="/Admin/Home?musicalID=<%=Model.Musical.musicalID %>">Musical Details <span class="sr-only">(current)</span></a></li>
            <li class="nav-link" id="date-nav-link"><a href="/Admin/AuditionDates?musicalID=<%=Model.Musical.musicalID %>">Audition Dates</a></li>
            <li class="nav-link" id="role-nav-link"><a href="/Admin/Roles?musicalID=<%=Model.Musical.musicalID %>">Roles</a></li>
            <li class="nav-link" id="student-nav-link"><a href="/Admin/Students?musicalID=<%=Model.Musical.musicalID %>">Students</a></li>
            <li class="nav-link" id="account-nav-link"><a href="/Admin/MyAccount?musicalID=<%=Model.Musical.musicalID %>">My Account</a></li>
          </ul>
          <p class="navbar-text navbar-right"><a href="/Admin/Logout" class="navbar-link">Logout</a></p>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container-fluid -->
    </nav>