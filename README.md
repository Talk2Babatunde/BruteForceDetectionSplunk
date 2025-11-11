# Automated Brute-Force Login Detection & Email Alerting in Splunk

**Short description**  
End-to-end Splunk detection pipeline that identifies brute-force login attempts (Windows Event ID 4625), correlates failed logins by user/IP/host, and delivers enriched email alerts to SOC analysts in under 2 minutes.
<img width="1000" height="579" alt="image18" src="https://github.com/user-attachments/assets/af63d8d5-a7e3-484e-bd5d-46aa0409569d" />

**Why this matters**  
- Built a production-like detection pipeline that cut false alerts by ~60% and improved detection latency to <2 minutes.  
- Demonstrates hands-on skills in detection engineering, Splunk administration, Windows audit configuration, scripting, and secure alerting.  
- Ready-to-deploy artifacts (Splunk saved searches, forwarder config, alert templates, test scripts) that accelerate SOC onboarding and detection maturity.

---

## Project structure
BruteForceDetectionSplunk/
│
├─ README.md
├─ screenshots/
│ ├─ step1_auditpol.png
│ ├─ step2_forwarder.png
│ ├─ step3_email.png
│ ├─ step4_savedsearch.png
│ ├─ step5_simulator.png
│ └─ step6_alert.png
│
├─ configs/
│ ├─ inputs.conf
│ ├─ outputs.conf
│ ├─ savedsearches.conf
│ └─ alert_actions.conf (example template — NO real passwords)
│
├─ scripts/
│ └─ brute_force_simulator.ps1
│
└─ diagrams/
└─ architecture.png


---

## Key deliverables
1. **Splunk saved search & alert config** — SPL that correlates repeated EventID 4625 events across a 5-minute window and triggers email alerts.  
2. **Universal Forwarder config** — minimal `inputs.conf`/`outputs.conf` to collect Windows Security logs and forward to indexer.  
3. **Email alert action template** — secure, placeholder-based example showing TLS SMTP integration.  
4. **PowerShell simulator** — reproducible script to generate 4625 events for testing and validation.  
5. **Architecture diagram & screenshots** — visual evidence of setup, validation, and delivered alerts.

---

## Quick technical summary
- **Log source**: Windows Security Event Log (4625 = failed logon)  
- **Forwarder**: Splunk Universal Forwarder (Windows) or Winlogbeat alternative  
- **Indexer**: Splunk Enterprise on Ubuntu  
- **Detection**: SPL correlation (≥5 failed attempts per user/IP within 5 minutes)  
- **Alert**: Email via SMTP (Gmail example) with contextual fields (host, username, source IP, failure reason, timestamps)  
- **Test**: PowerShell script simulates repeated failed logons to validate pipeline

---

## Installation & usage (high-level)
1. Enable Windows audit policy (Account Logon / Logon success & failure).  
2. Install Splunk Universal Forwarder and drop `inputs.conf`/`outputs.conf` (see `configs/`). Restart UF.  
3. Configure Splunk indexer with `alert_actions.conf` (use a secure store or vault for credentials). Restart Splunk.  
4. Import `savedsearches.conf` or create the saved search in Splunk Web using the provided SPL. Configure email action.  
5. Run `scripts/brute_force_simulator.ps1` on a Windows test VM to generate failed logons and verify alerts.  
6. Review screenshots and `architecture.png` for validation evidence.

---

## Results & impact (from lab)
- **Detection latency**: < 2 minutes from ingestion to email alert.  
- **True positive accuracy**: ≈95% after tuning fields and thresholds.  
- **Alert noise reduction**: ≈60% through targeted filtering (LogonType, FailureReason, internal IP exclusions).  
- **Skill signals for recruiters**: detection engineering, SIEM tuning, Windows event parsing, secure integration (SMTP), automated testing.

---

## Files & purpose 
- `configs/inputs.conf` — shows you can collect Windows Security logs (4625).  
- `configs/outputs.conf` — demonstrates secure forwarding to the indexer.  
- `configs/savedsearches.conf` — contains the SPL and alert configuration (thresholds, schedule).  
- `configs/alert_actions.conf` — example SMTP config (no secrets committed).  
- `scripts/brute_force_simulator.ps1` — reproducible test harness for validation.  
- `screenshots/`, `diagrams/` — evidence and explanation for non-technical stakeholders.

---

## Notes & best practices
- **Never commit real credentials** — store SMTP app passwords in a secrets manager or OS-level protected store.  
- Use environment-specific suppression/whitelists to reduce false positives in production.  
- Consider webhook/ORchestration integration (SOAR) for automated containment in future iterations.

---

## Contact / Links
- GitHub: https://github.com/Talk2Babatunde/  
- LinkedIn: www.linkedin.com/in/babatunde-qodri-27716b1a5  

## Contributing / sanity checklist
- Do NOT commit real credentials. Use placeholders and reference a secure store.
- Test the `brute_force_simulator.ps1` only in an isolated lab VM.
- Tune thresholds (count/time window) before deploying to production to avoid noisy alerts.
