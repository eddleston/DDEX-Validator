/*
 * IDdexValidator.cs
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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DDEX.ValidatorService.Models
{
    public interface IDdexValidator
    {
        string Transform(string baseDir, string sourceXml, string releaseType, string version);
        string TransformOutputForScreen(string xsltUrl, string documentBody);
    }
}
