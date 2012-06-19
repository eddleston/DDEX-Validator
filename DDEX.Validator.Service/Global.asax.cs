using System.Reflection;
using System.Web.Mvc;
using System.Web.Routing;
using EMI.DDEX.ValidatorService.DependencyResolution;
using log4net.Config;
using RestMvc;

namespace EMI.DDEX.ValidatorService
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            RouteTable.Routes.MapAssembly(Assembly.GetExecutingAssembly());
        }

        protected void Application_Start()
        {
            DependencyResolver.SetResolver(new StructureMapDependencyResolver(StructureMapContainer.Create()));

            XmlConfigurator.Configure();
            AreaRegistration.RegisterAllAreas();

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
        }
    }
}