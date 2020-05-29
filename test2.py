import os
import lxml.etree as ET

inputpath = ".\\ptx"
xsltfile = ".\\xsl\\pretext-setup.xsl"
outpath = ".\\output"

#Note: need to have the output directories installed for exsl to work.
# for dirpath, dirnames, filenames in os.walk(inputpath):
#             for filename in filenames:
#                 if filename.endswith(('.xml', '.txt')):
dom = ET.parse("./ptx/outline.ptx")
xslt = ET.parse(xsltfile)
transform = ET.XSLT(xslt)
newdom = transform(dom)
infile = str((ET.tostring(newdom, pretty_print=True)))
outfile = open("output-test.ptx", 'a')
outfile.write(infile)