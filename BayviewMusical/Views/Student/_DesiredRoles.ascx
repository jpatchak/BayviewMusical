<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<BayviewMusical.Models.DesiredRolesViewModel>" %>
                        <div class="col-md-12">
					    <%= Html.LabelFor(m=>m.DesiredRoles) %>
                        </div>
					    <div class="col-md-6">
                            <%int i = 0; %>
                            <%foreach(BayviewMusical.Models.RoleCheckbox chk in Model.DesiredRoles){ %>
                               <%if (i % 2 == 0)
                                 { %><input type="radio" name="DesiredRoles", value="<%=chk.RoleID %>", <%=chk.IsChecked ? "checked" : string.Empty %> /> <%=chk.RoleName%><br /><%} %>
                                 <%i++; %>
                            <%} %>
					    </div>
					    <div class="col-md-6">
                            <%i = 0; %>
                            <%foreach(BayviewMusical.Models.RoleCheckbox chk in Model.DesiredRoles){ %>
                               <%if (i % 2 == 1)
                                 { %><input type="radio" name="DesiredRoles", value="<%=chk.RoleID %>", <%=chk.IsChecked ? "checked" : string.Empty %> /> <%=chk.RoleName%><br /><%} %>
                                 <%i++; %>
                            <%} %>					    	
					    </div>