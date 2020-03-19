# MacOS Hardware Query Scripts

Information required:

1. Bonjour Name

2. Device Name

3. OS Version

4. Disk space information (total/used/available)

5. IP address

6. Last signed in use

7. 3rd party software installed

Potential Ideas:

1. Use a script that SSHs into each machine.
    1. Script will be run from Jeremy’s Machine with a RSA key
    2. Each Apple machine will only accept SSH requests from Jeremy’s Machine   
    3.Query script will run, snag info, then push info into CSV file
2. Have a script that runs at some outside trigger and/or maintains a database somewhere of those machines.
3. JAMF?


Computer Information:
VU412-iMac1
