using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EMI.DDEX.ValidatorService.Models;
using RestMvc.Attributes;

namespace EMI.DDEX.ValidatorService.Controllers
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
