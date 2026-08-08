# 07 – Defense Evasion

## Overview

After successfully escalating privileges during the previous attack phase, the next objective was to demonstrate defense-evasion techniques against endpoint security controls.

This simulation demonstrates how an attacker may attempt to execute a privilege-escalation payload that is detected and blocked by endpoint security controls, followed by controlled AMSI bypass activity to allow subsequent payload execution.

The attack was executed against the Wazuh Enterprise SOC Lab to validate endpoint security monitoring, payload detection, AMSI visibility, and Wazuh security-event collection.

---

# Objectives

- Execute a controlled privilege-escalation payload.
- Validate endpoint security detection and blocking.
- Observe the security response when the payload is detected.
- Demonstrate AMSI-related defense evasion.
- Execute the AMSI bypass within the isolated lab environment.
- Establish a Meterpreter session after the bypass.
- Validate endpoint monitoring and Wazuh visibility.
- Document the defensive controls encountered during the attack.

---

# MITRE ATT&CK Mapping

| Technique | ID |
| --------------------------------------------- | --------- |
| Impair Defenses: Disable or Modify Tools | T1562.001 |
| Command and Scripting Interpreter | T1059 |
| PowerShell | T1059.001 |

---

# Lab Environment

| Component | Description |
| ------------------- | ------------------------- |
| SIEM | Wazuh |
| Firewall | OPNsense |
| Endpoint Monitoring | Sysmon |
| Attacker | Arch Linux |
| Target | Windows Server |
| Web Server | IIS |
| Previous Access | `IIS APPPOOL\DefaultAppPool` |
| Privilege Context | `NT AUTHORITY\SYSTEM` |

---

# Attack Tools

- PrinterSpoofer
- PowerShell
- Metasploit Framework
- Meterpreter
- Wazuh
- Sysmon

---

# Attack Workflow

```text
Privilege-Escalation Payload
        │
        ▼
PrinterSpoofer Execution Attempt
        │
        ▼
Endpoint Security Detection
        │
        ▼
Payload Blocked / Removed
        │
        ▼
AMSI Protection Encountered
        │
        ▼
Controlled AMSI Bypass
        │
        ▼
Payload Execution
        │
        ▼
Meterpreter Session
        │
        ▼
Wazuh / Endpoint Telemetry
