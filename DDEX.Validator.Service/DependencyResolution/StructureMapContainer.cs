namespace EMI.DDEX.ValidatorService.DependencyResolution
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using Saxon.Api;
    using StructureMap;

    public static class StructureMapContainer
    {
        public static IContainer Create()
        {
            ObjectFactory.Initialize(
                x =>
                {
                    x.Scan(
                        scan =>
                        {
                            scan.TheCallingAssembly();
                            //scan.AssembliesFromApplicationBaseDirectory();
                            scan.WithDefaultConventions();
                        });
                    x.Scan(
                        scan =>
                        {
                            scan.TheCallingAssembly();
                            //scan.AssembliesFromApplicationBaseDirectory();
                            scan.LookForRegistries();
                        });
                });
            return ObjectFactory.Container;
        }
    }
}