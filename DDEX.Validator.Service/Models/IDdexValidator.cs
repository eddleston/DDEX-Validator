using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EMI.DDEX.ValidatorService.Models
{
    public interface IDdexValidator
    {
        string Transform(string baseDir, string sourceXml, string releaseType, string version);
        string TransformOutputForScreen(string xsltUrl, string documentBody);
    }
}
