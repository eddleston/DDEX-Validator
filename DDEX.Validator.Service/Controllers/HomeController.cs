﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Xml;
using log4net;
using log4net.Repository.Hierarchy;
using EMI.DDEX.ValidatorService.Models;
using RestMvc.Attributes;

namespace EMI.DDEX.ValidatorService.Controllers
{
    public class HomeController : Controller
    {
        private static readonly ILog Logger = LogManager.GetLogger(typeof(HomeController));
        private readonly IDdexValidator _ddexValidator;

        public HomeController(
            IDdexValidator ddexValidator)
        {
            this._ddexValidator = ddexValidator;
        }

        [Get("/")]
        public ActionResult Index()
        {
            ViewBag.Message = "Welcome to the DDEX validator!";

            return View();
        }

        [Post("/")]
        [ValidateInput(false)]
        public ActionResult ValidateDdex(string releaseType, string version, string xmlMessage)
        {
            var xmlInput = xmlMessage;

            try
            {
                if (Request.Files != null && Request.Files.Count > 0 && Request.Files[0].ContentLength > 0)
                {
                    using (var textReader = new StreamReader(Request.Files[0].InputStream))
                    {
                        xmlInput = textReader.ReadToEnd();
                    }
                }

                if (!String.IsNullOrEmpty(xmlInput))
                {
                    ViewBag.Message = _ddexValidator.TransformOutputForScreen(
                                            Server.MapPath("~/Content/OutputToHtml.xslt"),
                                            _ddexValidator.Transform(
                                                Server.MapPath("~/"),
                                                xmlInput,
                                                releaseType,
                                                version
                                                ));
                }
            }
            catch (Exception ex)
            {
                Logger.Debug(ex.Message + ex.StackTrace);
                throw;
            }
            return View();
        }

        [Get("/about")]
        public ActionResult About()
        {
            return View();
        }
    }
}
