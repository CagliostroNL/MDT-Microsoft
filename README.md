# MDT-Microsoft
Automating MDT/WDS


NEEDS PYTHON INSTALLED, AS SCRIPT; 02 - XMLPARSE.PY IS APYTHON SCRIPT.
You Reference image build share should be a ZTI. 

These scripts completly automate, creating a reference image and importing them to the deployment shares.
The python script replaces the task sequences 'install a operating system' with the newest imported operating system.



Script execution order

00 - AutoRef.ps1

01 - ImportOSinDepShare.ps1

02 - xmlparse.py

03 - CleanUpAutoRef.ps1
