# Project 24: Manual Chaos Test — Incident Notes

- **Incident ID:** CHAOS-001
- **Target System:** Linux EC2 Web Server (`[Instance ID]`) — Service: `httpd`
- **Date:** [YYYY-MM-DD]

## Timeline
| Timestamp (UTC) | Event | Observed State |
| :--- | :--- | :--- |
| `[HH:MM:SS]` | Baseline verification | `httpd` active; `HTTP/1.1 200 OK` |
| `[HH:MM:SS]` | Failure injected (`systemctl stop httpd`) | `httpd` inactive; `curl` returned `Connection refused` |
| `[HH:MM:SS]` | Remediation initiated (`systemctl start httpd`) | Service restarted cleanly |
| `[HH:MM:SS]` | Recovery verified | `httpd` active; `HTTP/1.1 200 OK` |

- **Total Downtime (MTTR):** `[~10–15 seconds]`

## Root Cause
Intentional manual service termination (`systemctl stop httpd`) executed during controlled chaos testing.

## Preventive Recommendations
1. Configure `Restart=always` and `RestartSec=5` in the systemd unit file for automatic local process recovery.
2. Deploy behind an Application Load Balancer + Auto Scaling Group with HTTP health checks to replace unhealthy instances automatically.
