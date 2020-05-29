import os
import lxml.etree as ET

# inputpath = ".\\ptx"
xsltfile = "..\\..\\mathbook\\xsl\\mathbook-html.xsl"
# outpath = ".\\output"


# for dirpath, dirnames, filenames in os.walk(inputpath):
#             for filename in filenames:
#                 if filename.endswith(('.xml', '.txt')):
dom = ET.parse("../../mathbook/examples/sample-article/sample-article.xml")
xslt = ET.parse(xsltfile)
transform = ET.XSLT(xslt)
transform(dom)
newdom = transform(dom)
infile = str((ET.tostring(newdom, pretty_print=True)))
outfile = open("output-test.tex", 'a')
outfile.write(infile)