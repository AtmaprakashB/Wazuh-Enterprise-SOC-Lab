# 01 - Initial Reconnaissance

## Overview

Initial Reconnaissance is the first phase of the attack simulation where an attacker gathers information about the target environment after gaining access to the internal network. The objective is to identify systems, services, Active Directory infrastructure, network shares, and domain information that can be used during later attack stages.

This lab simulates common reconnaissance techniques in a hybrid enterprise environment and validates that the generated telemetry is collected by Wazuh for detection, threat hunting, and incident response.

---

# Objectives

- Simulate attacker reconnaissance activities
- Discover Windows and Linux assets
- Enumerate Active Directory services
- Generate telemetry for Wazuh
- Validate log collection and visibility
- Map reconnaissance activities to MITRE ATT&CK

---

# Lab Environment

| Component | Purpose |
|-----------|----------|
| ARCH | Attacker Machine |
| Windows Domain Controllers | Reconnaissance Target |
| Windows Member Servers | Reconnaissance Target |
| Ubuntu Server | Linux Target |
| OPNsense | Network Firewall |
| Wazuh Manager | Log Collection & Analysis |
| Wazuh Dashboard | Investigation |
| Sysmon | Windows Telemetry |

---

# Attack Scenario

An attacker has obtained access to the internal enterprise network and begins reconnaissance to understand the environment before attempting credential attacks or privilege escalation.

The attacker performs:

- Network discovery
- SMB enumeration
- Domain enumeration
- LDAP enumeration
- DNS enumeration
- Active Directory relationship mapping

Each activity generates telemetry that is collected by Wazuh and later analyzed during the Threat Hunting and Incident Response phases.

---

# Attack Workflow

```text
Attacker (ARCH)
        │
        ▼
Network Discovery
        │
        ▼
SMB Enumeration
        │
        ▼
Domain Enumeration
        │
        ▼
LDAP Enumeration
        │
        ▼
DNS Enumeration
        │
        ▼
BloodHound Collection
        │
        ▼
Telemetry Generated
        │
        ▼
Wazuh Detection
        │
        ▼
Threat Hunting
        │
        ▼
Incident Response
```

---

# Attack Simulations

The following reconnaissance activities are performed during this phase.

| Activity | Description |
|----------|-------------|
| Network Discovery | Identify live hosts and exposed services |
| SMB Enumeration | Enumerate SMB services, domains, and shares |
| Domain Enumeration | Discover Active Directory users and domain information |
| LDAP Enumeration | Enumerate Active Directory objects |
| DNS Enumeration | Enumerate Active Directory DNS records |
| BloodHound Collection | Collect Active Directory relationship data |

---

# Expected Telemetry

The attack activities generate telemetry from multiple sources.

| Source | Expected Telemetry |
|--------|--------------------|
| OPNsense | Network connections and scan activity |
| Windows Security Logs | Authentication and service activity |
| Sysmon | Process creation events |
| Linux Syslog | SSH and system activity |
| Wazuh | Collected events, alerts, and searchable telemetry |

> **Note:** Not every reconnaissance activity will generate a high-severity alert. Many reconnaissance techniques are primarily useful for threat hunting and correlation.

---

# MITRE ATT&CK Mapping

| Activity | Technique |
|----------|-----------|
| Network Discovery | T1046 – Network Service Scanning |
| SMB Enumeration | T1018 – Remote System Discovery |
| Domain Enumeration | T1087.002 – Domain Account Discovery |
| LDAP Enumeration | T1087.002 – Domain Account Discovery |
| DNS Enumeration | T1018 – Remote System Discovery |
| BloodHound Collection | T1069.002 – Permission Groups Discovery |
| BloodHound Collection | T1482 – Domain Trust Discovery |

---

# Detection Validation

During this lab, verify that:

- Reconnaissance activity is visible in the Wazuh Dashboard.
- Relevant logs are successfully collected.
- Events are searchable for threat hunting.
- Detection rules trigger where applicable.
- Telemetry is available for incident investigation.

---

# Evidence Collection

Capture screenshots for:

1. Network Discovery
2. SMB Enumeration
3. Domain Enumeration
4. LDAP Enumeration
5. DNS Enumeration
6. BloodHound Collection
7. Wazuh Dashboard
8. Event Details
9. Threat Hunting Results

Store all screenshots in:

```text
10-Attack-Simulation/Screenshots/
```

---

# Related Modules

This attack simulation supports the following project modules:

- **11-Threat-Hunting**
- **12-Incident-Response**

The telemetry generated during this phase will be used to perform threat hunting, investigate alerts, and validate detection capabilities.

---

# Key Takeaways

- Initial reconnaissance is one of the earliest phases of an attack lifecycle.
- Enumeration activities reveal valuable information about enterprise infrastructure.
- Wazuh collects telemetry generated during reconnaissance, enabling analysts to identify suspicious behavior.
- Reconnaissance telemetry provides the foundation for threat hunting and incident response throughout the remainder of the project.
