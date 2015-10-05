using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace BayviewMusical
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "StudentDefault",
                "",
                new { controller = "Student", action = "SignUp" }
                );
            routes.MapRoute(
                "StudentTime",
                "MyTime",
                new { controller = "Student", action = "MyTime" }
                );
            routes.MapRoute(
                "StudentConfirmation",
                "Confirmation",
                new { controller = "Student", action = "Confirmation" }
                );
            routes.MapRoute(
                "StudentSignUp",
                "SignUp",
                new { controller = "Student", action = "SignUp" }
                );
            routes.MapRoute(
                "StudentInfo",
                "MyInfo",
                new { controller = "Student", action = "MyInfo" }
                );
            routes.MapRoute(
                "AdminLogin",
                "Login",
                new { controller = "Admin", action = "Login" }
                );
            routes.MapRoute(
                "AdminHome",
                "Home",
                new { controller = "Admin", action = "Home" }
                );
            routes.MapRoute(
                "AdminDates",
                "AuditionDates",
                new { controller = "Admin", action = "AuditionDates" }
                );
            routes.MapRoute(
                "AdminRoles",
                "Roles",
                new { controller = "Admin", action = "Roles" }
                );
            routes.MapRoute(
                "AdminStudents",
                "Students",
                new { controller = "Admin", action = "Students" }
                );
            routes.MapRoute(
                "AdminAccount",
                "MyAccount",
                new { controller = "Admin", action = "MyAccount" }
                );   
            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            RegisterRoutes(RouteTable.Routes);
        }
    }
}