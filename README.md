# MDT-Microsoft
Automating MDT/WDS


NEEDS PYTHON INSTALLED, AS SCRIPT; 02 - XMLPARSE.PY IS A PYTHON SCRIPT.
You Reference image build share should be a ZTI. 

These scripts completely automates, creating a reference image and importing it to the deployment shares.
The python script replaces the task sequences 'install a operating system' with the newest imported operating system.



Script execution order

00 - AutoRef.ps1

01 - ImportOSinDepShare.ps1

02 - xmlparse.py

03 - CleanUpAutoRef.ps1
