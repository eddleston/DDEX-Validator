/*
 * AdHoc.cs
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
using System.IO;
using System.Xml;
using DDEX.ValidatorService.Models;
using NUnit.Framework;

namespace DDEXValidator.Tests
{
    [TestFixture]
    public class AdHoc
    {
        [Test]
        public void ValidateManyDdexDocuments()
        {
            var directoryInfo = new DirectoryInfo(@"\\localhost\DDEX 3.4 samples");
            foreach (var file in directoryInfo.GetFiles())
            {
                ValidateDdexDocument(file);
            }
        }

        [Test]
        public void ValidateOneDdexDocument()
        {
            var fileName = @"\\localhost\DDEX 3.4 samples\12345_VideoAlbum.xml";
            var fileInfo = new FileInfo(fileName);
            ValidateDdexDocument(fileInfo);
        }

        private void ValidateDdexDocument(FileInfo file)
        {
            try
            {
                var xmlDocument = new XmlDocument();
                xmlDocument.Load(file.FullName);

                var newReleaseMessage = new NewReleaseMessage();
                newReleaseMessage.FromXml(xmlDocument.OuterXml);
                var releaseProfile = newReleaseMessage.GetReleaseProfile();
                if (releaseProfile == "Ringtune")
                {
                    releaseProfile = "Ringtone";
                }

                var validator = new DdexValidator();
                var baseDir = @"C:\";
                var version = "10";
                var xsltPath = baseDir + "\\OutputToHtml.xslt";

                var validatorResponse = validator.Transform(baseDir, newReleaseMessage.ToXml(), releaseProfile, version);
                var formattedResponse = validator.TransformOutputForScreen(xsltPath, validatorResponse);

                if (!formattedResponse.Contains("This message is valid!"))
                {
                    Console.WriteLine("Response for file: " + file.FullName + ":" + formattedResponse);
                }
            }
            catch(Exception e)
            {
                Console.WriteLine("Exception for file: " + file.FullName + ":" + e.Message + e.StackTrace);
            }
        }
    }
}
