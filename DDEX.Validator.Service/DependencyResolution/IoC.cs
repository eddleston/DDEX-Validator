/*
 * IoC.cs
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

using StructureMap;

namespace DDEX.ValidatorService.DependencyResolution {
    public static class IoC {
        public static IContainer Initialize() {
            ObjectFactory.Initialize(x => x.Scan(scan =>
                                                     {
                                                         scan.TheCallingAssembly();
                                                         scan.WithDefaultConventions();
                                                     }));
            return ObjectFactory.Container;
        }
    }
}