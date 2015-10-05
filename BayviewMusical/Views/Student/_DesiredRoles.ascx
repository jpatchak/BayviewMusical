<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<BayviewMusical.Models.DesiredRolesViewModel>" %>

					    <%= Html.LabelFor(m=>m.DesiredRoles) %><br />
					    <div class="col-sm-6">
                            <%int i = 0; %>
                            <%foreach(BayviewMusical.Models.RoleCheckbox chk in Model.DesiredRoles){ %>
                               <%if (i % 2 == 0)
                                 { %><input type="radio" name="DesiredRoles", value="<%=chk.RoleID %>", <%=chk.IsChecked ? "checked" : string.Empty %> /> <%=chk.RoleName%><br /><%} %>
                                 <%i++; %>
                            <%} %>
					    </div>
					    <div class="col-sm-6">
                            <%i = 0; %>
                            <%foreach(BayviewMusical.Models.RoleCheckbox chk in Model.DesiredRoles){ %>
                               <%if (i % 2 == 1)
                                 { %><input type="radio" name="DesiredRoles", value="<%=chk.RoleID %>", <%=chk.IsChecked ? "checked" : string.Empty %> /> <%=chk.RoleName%><br /><%} %>
                                 <%i++; %>
                            <%} %>					    	
					    </div>