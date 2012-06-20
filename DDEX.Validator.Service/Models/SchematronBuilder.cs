/*
 * SchematronBuilder.cs
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

namespace DDEX.ValidatorService.Models
{
    using System;
    using System.IO;
    using System.Net;
    using System.Xml;
    using Saxon.Api;

    public class SchematronBuilder
    {
        private static Uri DdexWebPath = new Uri("http://www.ddex.net/xml/profiles/release");

        public static string ImportSchematron(string baseDir, string schemaPath, string xsltPath)
        {
            // Builds a new XSLT file from a schematron file. 
            // This only needs to be done when the schematron file changes.
            var sxnProc = new Processor();

            var outPath = xsltPath;
            var baseXsltPath = Path.Combine(baseDir, @"Content\Saxon\");

            var schConverter = new string[]
                                   {
                                       baseXsltPath + "iso_dsdl_include.xsl",
                                       baseXsltPath + "iso_abstract_expand.xsl",
                                       baseXsltPath + "iso_svrl_for_xslt2.xsl"
                                   };         
            var schemaUri = new Uri(schemaPath);
            var xslComp = sxnProc.NewXsltCompiler();
            
            //////transform-1///// 
            var xslUri = new Uri(schConverter[0]);
            var xslExec = xslComp.Compile(xslUri);
            var xslTrans = xslExec.Load();
            var domOut1 = new DomDestination(new XmlDocument());
            using(var fs = File.Open(schemaPath, FileMode.Open, FileAccess.Read))
            {
                xslTrans.SetInputStream(fs, schemaUri); // set baseUri
                xslTrans.Run(domOut1);
            }         
            
            //////transform-2/////
            xslUri = new Uri(schConverter[1]);
            xslExec = xslComp.Compile(xslUri);
            xslTrans = xslExec.Load();
            var domOut2 = new DomDestination(new XmlDocument());
            var docBuilder = sxnProc.NewDocumentBuilder();
            docBuilder.BaseUri = schemaUri;
            var inputDoc2 = docBuilder.Wrap(domOut1.XmlDocument);
            xslTrans.InitialContextNode = inputDoc2;
            xslTrans.Run(domOut2);
            
            //////transform-3/////         
            xslUri = new Uri(schConverter[2]);
            xslExec = xslComp.Compile(xslUri);
            xslTrans = xslExec.Load();
            var inputDoc3 = docBuilder.Wrap(domOut2.XmlDocument);
            xslTrans.InitialContextNode = inputDoc3;
            var serializer = new Serializer();
            using (TextWriter tw = new StreamWriter(outPath, false))
            {
                serializer.SetOutputWriter(tw);
                serializer.SetOutputProperty(Serializer.INDENT, "no");
                xslTrans.Run(serializer);
            }

            return outPath;
        }

        public static string CheckForNewerSchematron(string baseDir, string releaseType, string version)
        {
            var schemaPathWeb = DdexWebPath + "/" + version + "/" + releaseType.Replace(" ", "") + ".sch";
            var schemaPathLocal = Path.Combine(baseDir, "Content/" + releaseType.Replace(" ", "") + "." + version.Replace(".", "") + ".sch");
            var schemaPathTemp = schemaPathLocal.Replace(".sch", "_temp.sch");
            var xsltPath = schemaPathLocal.Replace(".sch", ".xslt");

            var webClient = new WebClient();
            webClient.DownloadFile(schemaPathWeb, schemaPathTemp);

            if (!File.Exists(xsltPath))
            {
                File.Copy(schemaPathTemp, schemaPathLocal);
                ImportSchematron(baseDir, schemaPathLocal, xsltPath);
            }
            else
            {
                var schemaFile = new FileInfo(schemaPathLocal);
                var schemaFileTemp = new FileInfo(schemaPathTemp);

                if (!schemaFile.Exists || !FilesAreEqual(schemaFile, schemaFileTemp))
                {
                    File.Copy(schemaPathTemp, schemaPathLocal);
                    ImportSchematron(baseDir, schemaPathLocal, xsltPath);
                }
            }

            return xsltPath;
        }

        static bool FilesAreEqual(FileInfo first, FileInfo second)
        {
            const int BYTES_TO_READ = sizeof(Int64);

            if (first.Length != second.Length)
                return false; 
            
            int iterations = (int)Math.Ceiling((double)first.Length / BYTES_TO_READ);

            using (FileStream fs1 = first.OpenRead())
            using (FileStream fs2 = second.OpenRead())
            {
                byte[] one = new byte[BYTES_TO_READ];
                byte[] two = new byte[BYTES_TO_READ];
                
                for (int i = 0; i < iterations; i++)
                {
                    fs1.Read(one, 0, BYTES_TO_READ);
                    fs2.Read(two, 0, BYTES_TO_READ);
                    
                    if (BitConverter.ToInt64(one, 0) != BitConverter.ToInt64(two, 0))
                        return false;
                }
            } 
            
            return true;
        } 
    }
}