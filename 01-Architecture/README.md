# Architecture

This folder contains all architecture diagrams for the Wazuh Enterprise SOC Lab.

---

# 01. Network Topology

![Network Topology](01-Network-Topology.png)

Shows the physical and logical network connectivity between:

- Internet
- Home Router
- OPNsense Firewall
- Wazuh Server
- GOAD Lab
- Ubuntu Linux
- Arch Linux

---

# 02. Final Enterprise Architecture

![Final Architecture](02-Final-Architecture.png)

The final enterprise SOC architecture showing:

- Wazuh Manager
- Wazuh Indexer
- Wazuh Dashboard
- OPNsense Firewall
- GOAD Active Directory
- Windows Servers
- Ubuntu Linux
- Arch Linux
- Security telemetry sources
- SOC capabilities

---

# 03. Log Flow

![Log Flow](03-Log-Flow.png)

This diagram illustrates how security telemetry flows into Wazuh.

Sources include:

- Windows Event Logs
- Sysmon
- Wazuh Agents
- OPNsense Syslog
- Suricata Alerts
- Linux Logs

---

# 04. Attack Flow

![Attack Flow](04-Attack-Flow.png)

Illustrates the attack lifecycle:

Arch Linux
→ GOAD Environment
→ Security Telemetry
→ Wazuh Detection
→ MITRE ATT&CK Mapping
→ Alert
→ Investigation
→ Incident Response

---

# Directory

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
