# 12 - Incident Response

## Overview

Incident Response is the structured process used by a security team to identify, investigate, contain, eradicate, and recover from security incidents.

In this lab, Wazuh was used to demonstrate an end-to-end incident-response workflow against a controlled **SSH brute-force attack**.

The simulated attack originated from `192.168.31.150` and targeted the Ubuntu endpoint `syskey` at `192.168.31.174`.

Wazuh detected the repeated SSH authentication failures, generated a custom security alert, automatically executed the `firewall-drop` Active Response, blocked the attacking IP, and provided evidence for the containment, eradication, and recovery phases.

---

# Incident Response Lifecycle

```text
Attack
  |
  v
01 - Alert Identification
  |
  v
02 - Investigation
  |
  v
03 - Containment
  |
  v
04 - Eradication
  |
  v
05 - Recovery
  |
  v
Incident Resolved
