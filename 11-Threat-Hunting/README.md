# Threat Hunting: Windows Process Execution & PowerShell Analysis

## Lab Environment Overview

| Component | Details |
| :--- | :--- |
| **SIEM** | Wazuh |
| **Target Endpoint** | WINTERFELL |
| **Agent Name** | `winterfell` |
| **Agent ID** | `002` |
| **Endpoint IP** | `192.168.110.146` |
| **Domain** | `north.sevenkingdoms.local` |
| **Operating System** | Windows |
| **Endpoint Monitoring** | Sysmon |
| **Primary Event** | Sysmon Event ID 1 (Process Creation) |
| **Search Interface** | Wazuh Discover |
| **Data Source** | `wazuh-archives-*` |

---

## Threat Hunting Methodology

The investigation was performed against the Wazuh archive data source (`wazuh-archives-*`), containing Windows Event Channel data collected from the **WINTERFELL** endpoint using a progressive hunting workflow:

1. **Identify the Endpoint:** Filter telemetry by `agent.name: winterfell`.
2. **Identify Process Creation Events:** Filter by `data.win.system.eventID: 1`.
3. **Combine Filters:** Search for process creation events specifically from the target endpoint.
4. **Narrow to PowerShell:** Target specific scripting activity using image filters.
5. **Investigate Process Lineage:** Review parent-child relationships, command lines, and metadata.
6. **Correlate Additional Telemetry:** Check network connections, file activity, and authentication logs.

---

## Investigation Steps & Findings

### 1. Initial Process Execution Hunt
The initial Wazuh threat-hunting query identified Sysmon Process Creation events from the WINTERFELL endpoint.

* **DQL Query:**
  ```text
  agent.name: winterfell AND data.win.system.eventID: 1


  Threat Hunting Data Source

The investigation was performed against the Wazuh archive data source:

wazuh-archives-*

The archived telemetry contains Windows Event Channel data collected from the WINTERFELL endpoint.

Sysmon Event ID 1 was used as the primary telemetry source for investigating Windows process creation activity.

The event provides useful information including:

Process image
Command line
Parent process
Parent command line
User
Process ID
Parent process ID
Integrity level
Process hashes
Process metadata
Initial Process Execution Hunt

The first hunting query searched for Sysmon Process Creation events on the WINTERFELL endpoint.

DQL:

agent.name: winterfell AND data.win.system.eventID: 1

The query filters the archived telemetry for:

Endpoint:
winterfell


Event:
Sysmon Event ID 1


Activity:
Process Creation

This provided the initial dataset for the process-execution investigation.

Screenshots
1. Process Execution Hunt

The initial Wazuh threat-hunting query was used to identify Sysmon Process Creation events from the WINTERFELL endpoint.

Screenshot Explanation

The screenshot shows the Wazuh Discover search using:

agent.name: winterfell AND data.win.system.eventID: 1

The query returned Sysmon Event ID 1 process creation events from the WINTERFELL endpoint.

The results demonstrate that Wazuh is receiving and indexing Windows process creation telemetry.

This provides the analyst with a starting point for proactive endpoint investigation.

2. Process Execution Details

The second stage involved expanding an individual Sysmon Event ID 1 event to examine the available process metadata.

Screenshot Explanation

The expanded Wazuh event provides detailed process execution information.

The available telemetry includes:

agent.name
agent.ip
data.win.eventdata.image
data.win.eventdata.commandLine
data.win.eventdata.currentDirectory
data.win.eventdata.description
data.win.eventdata.company
data.win.eventdata.hashes
data.win.eventdata.processId
data.win.eventdata.parentProcessId
data.win.system.eventID

This allows the SOC analyst to move from a broad process-execution search into detailed event analysis.

The additional process metadata can be used to establish:

What process executed
Which command line was used
Which process launched it
Which account executed it
Which process IDs were assigned
Which hashes were recorded
3. Process Execution Analysis

The investigation was then narrowed to PowerShell process execution.

The DQL query used was:

agent.name: winterfell AND data.win.system.eventID: 1 AND data.win.eventdata.image: *powershell*

Screenshot Explanation

The screenshot provides evidence of PowerShell process execution recorded by Sysmon Event ID 1.

The investigated event contains:

Process:
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe


Command Line:
powershell c:\setup\bot_rdp.ps1


Parent Process:
C:\Windows\System32\cmd.exe


Parent Command Line:
cmd.exe /c powershell c:\setup\bot_rdp.ps1


User:
NORTH\robb.stark


Integrity Level:
High


Process ID:
4108


Parent Process ID:
2104


Sysmon Event ID:
1

The event also contains process hashes and additional Sysmon metadata.

This provides the SOC analyst with process lineage, execution context, and user information for further investigation.

Process Lineage

The observed process relationship can be represented as:

cmd.exe
   │
   └── powershell.exe
          │
          └── c:\setup\bot_rdp.ps1

The telemetry provides both the parent and child process identifiers:

Parent Process ID:
2104


Process ID:
4108

This information allows the analyst to reconstruct the process execution chain and determine how the PowerShell process was launched.

PowerShell Hunting

After identifying general process creation activity, the investigation was narrowed to PowerShell-related events.

DQL:

agent.name: winterfell AND data.win.system.eventID: 1 AND data.win.eventdata.image: *powershell*

The query searches for:

Endpoint:
winterfell


Event:
Sysmon Event ID 1


Process:
PowerShell

The investigation identified a PowerShell process executing:

powershell c:\setup\bot_rdp.ps1

The parent process was:

C:\Windows\System32\cmd.exe

The parent command line was:

cmd.exe /c powershell c:\setup\bot_rdp.ps1
Process Execution Metadata

The Sysmon event provides additional information that can be used during the investigation.

Process Image
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

This identifies the executable responsible for the process creation event.

Command Line
powershell c:\setup\bot_rdp.ps1

The command line identifies the PowerShell script that was executed.

Command-line information is particularly useful during threat hunting because it provides additional context beyond the process name.

Parent Process
C:\Windows\System32\cmd.exe

The PowerShell process was launched by the Windows command shell.

Parent Command Line
cmd.exe /c powershell c:\setup\bot_rdp.ps1

The parent command line provides additional context about how the PowerShell process was initiated.

User
NORTH\robb.stark

The event identifies the Windows account associated with the process execution.

Integrity Level
High

The event indicates that the process was running with High integrity.

Process Identifiers
Process ID:
4108


Parent Process ID:
2104

These identifiers can be used to correlate process activity across related telemetry.

Investigation Findings

The threat-hunting investigation confirmed that Wazuh was successfully collecting Sysmon Process Creation telemetry from the WINTERFELL endpoint.

The investigation progressed from broad process creation activity to a focused PowerShell investigation.

The observed process chain was:

cmd.exe
   │
   └── powershell.exe
          │
          └── c:\setup\bot_rdp.ps1

The PowerShell process was associated with:

User:
NORTH\robb.stark

The process was executed with:

Integrity Level:
High

The event was recorded as:

Sysmon Event ID:
1

The telemetry also provided process hashes, process IDs, parent process IDs, command-line information, and other metadata.

Analyst Assessment

The presence of PowerShell execution does not automatically indicate malicious activity.

PowerShell is a legitimate Windows administration and automation utility and can be used by:

System administrators
Applications
Security tools
Deployment systems
Automation scripts

However, the following characteristics provide useful hunting context:

PowerShell execution
Script execution
cmd.exe as the parent process
High integrity execution
Script located under C:\setup\
Associated user account
Process and parent process identifiers
Available process hashes

Therefore, the observed event should be treated as a hunting lead requiring additional investigation, rather than automatically classified as malicious.

Additional telemetry should be correlated before making a final determination.

Recommended SOC Investigation

A SOC analyst investigating this type of process execution can correlate the event with additional endpoint telemetry.

Process Creation
        │
        ├── Parent Process
        │
        ├── Child Process
        │
        ├── Command Line
        │
        ├── User Account
        │
        ├── Process Hash
        │
        ├── Network Connections
        │
        ├── File Activity
        │
        └── Authentication Events

Useful supporting telemetry can include:

Sysmon Process Creation
Sysmon Network Connection
Sysmon File Creation
Windows Authentication Events
PowerShell activity
RDP activity
Network connections
File creation and modification
Wazuh security alerts
Threat Hunting Methodology

The investigation followed a progressive hunting methodology.

1. Identify the Endpoint
agent.name: winterfell

This limits the investigation to the target Windows endpoint.

2. Identify Process Creation Events
data.win.system.eventID: 1

Sysmon Event ID 1 represents Process Creation telemetry.

3. Combine the Filters
agent.name: winterfell AND data.win.system.eventID: 1

This searches for process creation events specifically from the WINTERFELL endpoint.

4. Narrow to PowerShell
agent.name: winterfell AND data.win.system.eventID: 1 AND data.win.eventdata.image: *powershell*

This narrows the investigation to PowerShell process creation events.

5. Investigate Process Lineage

Review:

image
parentImage
commandLine
parentCommandLine
processId
parentProcessId
user
integrityLevel
hashes

This provides the analyst with process execution context.

6. Correlate Additional Telemetry

Use additional Wazuh telemetry to determine whether the process execution is related to:

Persistence
Credential Access
Lateral Movement
Defense Evasion
Network Communication
File Activity
Authentication activity
MITRE ATT&CK Mapping
Technique	Description
T1059	Command and Scripting Interpreter
T1059.001	PowerShell
T1059.003	Windows Command Shell

The observed PowerShell and command-shell execution provides useful context for mapping the activity to MITRE ATT&CK.

The ATT&CK mapping provides investigative context and does not by itself establish that the observed activity is malicious.

Evidence Summary
Evidence	Description
01-Process-Execution-Hunt.png	Initial Sysmon Event ID 1 process-execution hunt
02-Process-Execution-Details.png	Expanded process-creation event and metadata
03-Process-Execution-Analysis.png	PowerShell execution and parent-child process analysis
Project Structure
11-Threat-Hunting/
│
├── README.md
│
├── 01-Process-Execution/
│   └── README.md
│
└── Screenshots/
    ├── 01-Process-Execution-Hunt.png
    ├── 02-Process-Execution-Details.png
    └── 03-Process-Execution-Analysis.png
Skills Demonstrated
Wazuh Threat Hunting
Wazuh Discover
Sysmon Event Analysis
Windows Process Investigation
Process Creation Hunting
PowerShell Hunting
Command-Line Analysis
Parent-Child Process Analysis
Endpoint Telemetry Analysis
Security Investigation
MITRE ATT&CK Mapping
SOC Analyst Investigation
Key Takeaways
Wazuh can be used for proactive threat hunting in addition to alert-based monitoring.
Sysmon Event ID 1 provides detailed process creation telemetry.
Process image, command line, parent process, user, process IDs, and hashes provide valuable investigation context.
PowerShell execution can be narrowed using Wazuh Discover queries.
Parent-child process relationships help analysts reconstruct execution chains.
Command-line analysis provides additional context that may not be visible from the process name alone.
PowerShell execution should be investigated in context rather than automatically classified as malicious.
Threat hunting can turn large volumes of endpoint telemetry into focused investigations.
The collected evidence provides a practical foundation for further Wazuh detection engineering and incident investigation.
Conclusion

The Process Execution Threat Hunting exercise demonstrates a practical SOC investigation workflow using Wazuh and Sysmon.

The investigation started with a broad search for Sysmon Process Creation events and progressively narrowed the dataset to PowerShell execution.

The analyst was able to investigate:

Endpoint
   ↓
Process Creation
   ↓
PowerShell
   ↓
Command Line
   ↓
Parent Process
   ↓
User
   ↓
Process IDs
   ↓
Hashes
   ↓
Further Investigation

This demonstrates how Wazuh can be used not only to respond to generated alerts, but also to proactively search endpoint telemetry for activity that may require additional investigation.

The three screenshots provide practical evidence of the hunting workflow, from initial process discovery through detailed process analysis.

Evidence

The following screenshots are embedded directly in this README:

Process Execution Hunt

Process Execution Details

Process Execution Analysis
