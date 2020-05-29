import lxml.etree as ET

dom = ET.parse("ptx/outline.ptx")
xslt = ET.parse("xsl/pretext-setup.xsl")
transform = ET.XSLT(xslt)
newdom = transform(dom)
print("dot dot dot")
print(ET.tostring(newdom, pretty_print=True))