# Simulate repeated failed logons
<img width="991" height="286" alt="image2" src="https://github.com/user-attachments/assets/d121761f-8d44-4c7d-b12f-1a98546d9adc" />
# Check Security logs locally
<img width="1004" height="216" alt="image1" src="https://github.com/user-attachments/assets/95ce9e6c-9f0b-4485-8c0c-e8b9795f29f4" />
**Figure 5:** Left — PowerShell simulator running repeated failed LogonUser attempts to generate Event ID 4625 entries. Right — Get-WinEvent output showing recent 4625 failed logons with TimeCreated, Account, and IpAddress, confirming the host recorded the simulated brute‑force activity.
