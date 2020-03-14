''' 
    Version: 2.0
    Author: Cagliostro
    Creation Date: 21-02-2020
    
'''

import xml.etree.ElementTree as ET
import sys

#-----------Variables-------------
task = [r"E:\MDTZTI\Control\ZTI-BASIC\ts.xml"]
guid = [r"C:\Users\Administrator\Desktop\MDTZTI.txt"]

#----------functions---------------
def writeXML(filePath, guidPath):
    tree = ET.parse(filePath)
    root = tree.getroot()
    for var in root.iter("variable"):
        PropertyValue = var.get('property')
        if PropertyValue == 'OSGUID':
            readFile = open(guidPath, 'r')
            content = readFile.read()
            readFile.close
            print(content)
            var.text = content
    tree.write(filePath)

#----------task-------------  
for t, g in zip(task, guid):
    writeXML(t, g)
