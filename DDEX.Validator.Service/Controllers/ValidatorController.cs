/*
 * ValidatorController.cs
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
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DDEX.ValidatorService.Models;
using RestMvc.Attributes;

namespace DDEX.ValidatorService.Controllers
{
    public class ValidatorController : Controller
    {
        private readonly IDdexValidator _ddexValidator;

        public ValidatorController(
            IDdexValidator ddexValidator)
        {
            this._ddexValidator = ddexValidator;
        }

        [Post("/validate/{releaseType}")]
        [ValidateInput(false)]
        public ActionResult Validate(string releaseType, string version, string xmlMessage)
        {
            var schematronPath = "Content/" + releaseType.Replace(" ", "") + "." + version.Replace(".", "") + ".xslt";

            var result = _ddexValidator.TransformOutputForScreen(
                        Server.MapPath("~/Content/OutputToHtml.xslt"),
                        _ddexValidator.Transform(
                            Server.MapPath("~/"),
                            xmlMessage,
                            releaseType,
                            version));

            return this.Content(result);
        }
    }
}
