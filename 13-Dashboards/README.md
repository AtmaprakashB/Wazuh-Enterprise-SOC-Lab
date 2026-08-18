# 13 - Dashboards

## Overview

This section documents the Wazuh Dashboard capabilities implemented in the SOC lab.

The dashboards provide visibility into security events, authentication activity, endpoint security posture, threat detection, and incident monitoring.

The objective is to demonstrate how a SOC analyst can use Wazuh to monitor security telemetry, investigate alerts, identify suspicious activity, correlate events, and support incident-response activities.

---

# Dashboard Architecture

```text
Monitored Endpoints
        ↓
   Wazuh Agents
        ↓
   Wazuh Manager
        ↓
     Decoders
        ↓
   Detection Rules
        ↓
   Wazuh Indexer
        ↓
  Wazuh Dashboard
        ↓
┌───────────────────────────────┐
│       SOC Dashboards           │
├───────────────────────────────┤
│ 01 - SOC Overview              │
│ 02 - Security Events           │
│ 03 - Authentication            │
│ 04 - Endpoint Security         │
│ 05 - Threat Detection          │
│ 06 - Incident Monitoring       │
└───────────────────────────────┘
        ↓
 SOC Investigation
        ↓
 Incident Response
