namespace EMI.DDEX.ValidatorService.Models
{
    using System;
    using System.Collections;
    using System.IO;
    using System.Text;
    using System.Xml;
    using System.Xml.Xsl;
    using Saxon.Api;

    public class DdexValidator : IDdexValidator
    {
        public string Transform(string baseDir, string sourceXml, string releaseType, string version)
        {
            var sourceXsl = SchematronBuilder.CheckForNewerSchematron(baseDir, releaseType, version);

            // Create a Processor instance.
            var processor = new Processor();

            var result = new StringBuilder();

            var xmlDocumentBuilder = processor.NewDocumentBuilder();
            xmlDocumentBuilder.BaseUri = new Uri(baseDir);

            var xsltCompiler = processor.NewXsltCompiler();
            xsltCompiler.ErrorList = new ArrayList();
            var xmlToValidate = xmlDocumentBuilder.Build(new StringReader(sourceXml));
            var compiledXsl = xsltCompiler.Compile(new XmlTextReader(sourceXsl));
            var xmlValidator = compiledXsl.Load();

            // Set the root node of the source document to be the initial context node.
            xmlValidator.InitialContextNode = xmlToValidate;

            // BaseOutputUri is only necessary for xsl:result-document.
            xmlValidator.BaseOutputUri = new Uri(Path.Combine(baseDir, "output.xml"));

            var validationSerializer = new Serializer();

            using (var resultsWriter = new StringWriter(result))
            {
                validationSerializer.SetOutputWriter(resultsWriter);
                xmlValidator.Run(validationSerializer);
            }

            return result.ToString();
        }

        public string TransformOutputForScreen(string xsltUrl, string documentBody)
        {
            var xslt = new XslCompiledTransform();
            xslt.Load(xsltUrl);

            // Create the result writers...
            var transformedBody = new StringBuilder();
            var xmlWriter = new XmlTextWriter(new StringWriter(transformedBody));

            using (var stringReader = new StringReader(documentBody))
            {
                using (var xmlReader = XmlReader.Create(stringReader))
                {
                    xslt.Transform(xmlReader, null, xmlWriter);
                }
            }

            return transformedBody.ToString();
        }
    }
}