# Sending JINSAFE_QUIZ via IPs of the system.

1. The "Sending_via_IPs.bat" file facilitates the transmission of "installJINSAFEQUIZ.bat" and "jinsafe.zip" to designated destination systems based on their respective IP addresses.

2. The IP addresses must be preconfigured and stored in the "credential.csv" file. For instance: 192.168.1.44
                                                                                                 168.7.99.0

4. Upon execution, the "Sending_via_IPs.bat" script differentiates between successful and unsuccessful transfers. The IP addresses of the systems where the files are sent successfully are recorded in the "success_ips.csv" file, while the IP addresses of systems where the file transfer failed are stored in the "failed_ips.csv" file.

5. The designated location for copying the files is "\\!ips[%%i]!\C$\Users\Public\Downloads".

6. Before initiating the file transfer, ensure to set the appropriate organization User and Password for authorization.(i.e. Administrator and its respective password)

7. Make sure that all the file(i.e. .bat, .zip, .csv) are in same folder. 

Please ensure to adhere to the specified instructions and configuration for a successful and secure transfer process.
