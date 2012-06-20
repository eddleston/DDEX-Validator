using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using DDEXValidator.Tests.Properties;
using DDEX.ValidatorService.Controllers;
using DDEX.ValidatorService.Models;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using DDEX.ValidatorService;
using Moq;

namespace DDEXValidator.Tests.Controllers
{
    [TestClass]
    public class HomeControllerTest
    {
        [TestMethod]
        public void Index()
        {
            // Arrange
            var validator = new Mock<IDdexValidator>();
            var controller = new HomeController(validator.Object);

            // Act
            var result = controller.Index() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual("Welcome to the DDEX validator!", result.ViewBag.Message);
        }

        [TestMethod]
        public void About()
        {
            // Arrange
            var validator = new Mock<IDdexValidator>();
            var controller = new HomeController(validator.Object);

            // Act
            var result = controller.About() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void ValidateDdexWithXmlText()
        {
            // Arrange
            var validator = new Mock<IDdexValidator>();
            var controller = new HomeController(validator.Object);
            var xmlMessage = TestSettings.Default.EmptyXml;

            var context = new Mock<ControllerContext>();
            var server = new Mock<HttpServerUtilityBase>();
            var request = new Mock<HttpRequestBase>();
            var files = new Mock<HttpFileCollectionBase>();

            context.Setup(x => x.HttpContext.Request).Returns(request.Object);
            context.Setup(x => x.HttpContext.Server).Returns(server.Object);
            context.Setup(x => x.HttpContext.Request.Files).Returns(files.Object);
            context.Setup(x => x.HttpContext.Request.Files.Count).Returns(0);
            controller.ControllerContext = context.Object;
            validator.Setup(x => x.Transform(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>())).Returns("");

            // Act
            var result = controller.ValidateDdex("Audio Single", "10", xmlMessage) as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void ValidateDdexWithXmlFile()
        {
            // Arrange
            var validator = new Mock<IDdexValidator>();
            var controller = new HomeController(validator.Object);
            var xmlMessage = TestSettings.Default.EmptyXml;

            var context = new Mock<ControllerContext>();
            var server = new Mock<HttpServerUtilityBase>();
            var request = new Mock<HttpRequestBase>();
            var files = new Mock<HttpFileCollectionBase>();
            var enc = new UTF8Encoding();

            var file1 = new Mock<HttpPostedFileBase>();
            file1.Setup(d => d.FileName).Returns("AudioSingle.33.xml");
            file1.Setup(d => d.InputStream).Returns(new MemoryStream(enc.GetBytes(Resources.AudioSingle_33)));
            file1.Setup(d => d.ContentLength).Returns(enc.GetBytes(Resources.AudioSingle_33).Length);

            context.Setup(x => x.HttpContext.Request).Returns(request.Object);
            context.Setup(x => x.HttpContext.Server).Returns(server.Object);
            context.Setup(x => x.HttpContext.Request.Files.Count).Returns(1);
            context.Setup(x => x.HttpContext.Request.Files[0]).Returns(file1.Object);
            controller.ControllerContext = context.Object;
            validator.Setup(x => x.Transform(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>())).Returns("");

            // Act
            var result = controller.ValidateDdex("Audio Single", "10", xmlMessage) as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }
    }
}
