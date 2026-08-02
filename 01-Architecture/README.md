# Architecture

This directory contains the architectural design and documentation for the **Wazuh Enterprise SOC Lab**.

The architecture is designed to simulate a real enterprise Security Operations Center (SOC) environment using **Wazuh**, **OPNsense**, and the **GOAD (Game of Active Directory)** lab.

---

# Architecture Overview

The lab consists of two separate networks:

| Network | Purpose |
|----------|---------|
| **Management Network (192.168.31.0/24)** | Hosts the Wazuh platform and OPNsense WAN interface |
| **Internal Lab Network (10.10.14.0/24)** | Contains the enterprise Active Directory environment |

The Management Network is connected to the home router, while OPNsense isolates and protects the internal enterprise environment.

---

# Architecture Diagrams

## 01. Network Topology

**File**

```
01-Network-Topology.drawio
01-Network-Topology.png
```

Shows the physical and logical network layout including:

- Internet
- Home Router
- OPNsense Firewall
- Wazuh Server
- GOAD Servers
- Ubuntu Linux
- Arch Linux (Red Team)

---

## 02. Final Architecture

**File**

```
02-Final-Architecture.drawio
02-Final-Architecture.png
```

Shows the complete enterprise SOC architecture including:

- Wazuh Manager
- Wazuh Indexer
- Wazuh Dashboard
- OPNsense Firewall
- GOAD Active Directory
- Windows Servers
- Ubuntu Linux
- Arch Linux
- Security monitoring capabilities

---

## 03. Log Flow

**File**

```
03-Log-Flow.drawio
03-Log-Flow.png
```

Illustrates how security telemetry reaches Wazuh.

Log sources include:

- Windows Event Logs
- Sysmon
- Wazuh Agents
- Linux Logs
- File Integrity Monitoring
- OPNsense Syslog
- Suricata IDS Alerts
- DNS Logs
- Authentication Logs

---

## 04. Attack Flow

**File**

```
04-Attack-Flow.drawio
04-Attack-Flow.png
```

Demonstrates the attack lifecycle inside the SOC lab.

Typical workflow:

```
Arch Linux
      ↓
Attack Simulation
      ↓
GOAD Environment
      ↓
Security Telemetry
      ↓
Wazuh Detection
      ↓
MITRE ATT&CK Mapping
      ↓
Alert Generation
      ↓
Incident Investigation
      ↓
Incident Response
```

---

# Network Architecture

```
Internet
        │
Home Router
192.168.31.1/24
        │
────────────── Management Network ──────────────
        │
        ├── Ubuntu 24.04
        │      Wazuh Manager
        │      Wazuh Indexer
        │      Wazuh Dashboard
        │
        └── OPNsense Firewall
               WAN: 192.168.31.63
               LAN: 10.10.14.254
                       │
────────────── Internal Network ────────────────
       10.10.14.0/24
                       │
      ├── DC01 Kingslanding
      ├── DC02 Winterfell
      ├── DC03 Meereen
      ├── SRV02 Castleblack
      ├── SRV03 Braavos
      ├── Ubuntu Linux
      └── Arch Linux
```

---

# Components

## OPNsense

- Stateful Firewall
- NAT
- DHCP
- Remote Syslog
- Suricata IDS/IPS
- Network Segmentation

---

## Wazuh

- Wazuh Manager
- Wazuh Indexer
- Wazuh Dashboard
- Rule Engine
- File Integrity Monitoring
- Vulnerability Detection
- MITRE ATT&CK Mapping

---

## GOAD Lab

Enterprise Active Directory environment containing:

- Three Domain Controllers
- Two Member Servers
- Active Directory
- DNS
- Group Policy
- SMB
- IIS
- MSSQL

---

## Ubuntu Linux

Used for:

- Linux Security Monitoring
- Wazuh Agent
- Syslog Testing
- Linux Event Collection

---

## Arch Linux

Used as the Red Team workstation.

Typical activities include:

- Password Spraying
- Kerberoasting
- SMB Enumeration
- BloodHound
- Lateral Movement
- Attack Simulation

---

# Log Collection

| Source | Collection Method |
|----------|------------------|
| Windows Servers | Wazuh Agent |
| Ubuntu Linux | Wazuh Agent |
| OPNsense | Remote Syslog (UDP 514) |
| Suricata | EVE JSON |
| Sysmon | Wazuh Agent |
| Linux Logs | Wazuh Agent |

---

# Security Capabilities

- Centralized Log Collection
- Threat Detection
- Security Monitoring
- File Integrity Monitoring
- Incident Detection
- MITRE ATT&CK Mapping
- Alerting
- Dashboards
- Incident Investigation
- Digital Forensics

---

# Future Enhancements

- Microsoft Defender for Endpoint
- Microsoft Sentinel Integration
- Sigma Rules
- YARA Scanning
- Velociraptor
- SOAR Automation
- Threat Intelligence
- Detection Engineering
- Purple Team Exercises

---

# Directory Structure

```
Architecture/
├── README.md
├── 01-Network-Topology.drawio
├── 01-Network-Topology.png
├── 02-Final-Architecture.drawio
├── 02-Final-Architecture.png
├── 03-Log-Flow.drawio
├── 03-Log-Flow.png
├── 04-Attack-Flow.drawio
└── 04-Attack-Flow.png
```

---

# Objective

The objective of this architecture is to provide a realistic enterprise SOC environment for:

- Blue Team Operations
- Threat Hunting
- Incident Response
- Detection Engineering
- Purple Team Exercises
- Active Directory Security
- Firewall Monitoring
- Enterprise Log Analysis

This architecture serves as the foundation for the **Wazuh Enterprise SOC Lab**, demonstrating enterprise-grade security monitoring, detection, and response workflows.
