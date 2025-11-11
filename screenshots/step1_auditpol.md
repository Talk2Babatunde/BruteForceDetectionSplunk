# Enable auditing
auditpol /set /subcategory:"Account Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Logon" /success:enable /failure:enable

<img width="671" height="49" alt="image8" src="https://github.com/user-attachments/assets/4125fe3d-4092-45f6-8dcb-6102731ce841" />
<img width="576" height="243" alt="image16" src="https://github.com/user-attachments/assets/b9e3d245-a311-4836-a105-f0e4d42a54d5" />

# Verify auditing
auditpol /get /category:"Logon/Logoff"

<img width="736" height="578" alt="image13" src="https://github.com/user-attachments/assets/157e3b28-7f61-4629-afc5-5a918ad2ff55" />

Figure 1: Auditing enabled for both Success and Failure logon events on Windows to capture 4624 and 4625 logs.





