/*
 * StructureMapContainer.cs
 * Copyright 2012 Paul Eddleston
 * 
 *  Licensed under the Apache Licence, Version 2.0 (the "Licence");
 *  you may not use this file except in compliance with the Licence.
 *  You may obtain a copy of the Licence at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *      
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either 
 *  express or implied.  See the License for the specific language
 *  governing permissions and limitations under the Licence.
*/

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