# incident-commander

Source: Claude skill
Original path: `components/claude-skills/engineering-team/skills/incident-commander/SKILL.md`
Description: Comprehensive incident response framework from detection through resolution and post-incident review. Battle-tested SRE/DevOps practices: severity classification, timeline reconstruction, structured post-incident analysis. Use when declaring an incident, coordinating multi-team response during an outage, leading a post-mortem, or setting up on-call practices for a new service.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Incident Commander Skill

**Category:** Engineering Team  
**Tier:** POWERFUL  
**Author:** Claude Skills Team  
**Version:** 1.0.0  
**Last Updated:** February 2026

## Overview

The Incident Commander skill provides a comprehensive incident response framework for managing technology incidents from detection through resolution and post-incident review. This skill implements battle-tested practices from SRE and DevOps teams at scale, providing structured tools for severity classification, timeline reconstruction, and thorough post-incident analysis.

## Key Features

- **Automated Severity Classification** - Intelligent incident triage based on impact and urgency metrics
- **Timeline Reconstruction** - Transform scattered logs and events into coherent incident narratives
- **Post-Incident Review Generation** - Structured PIRs with multiple RCA frameworks
- **Communication Templates** - Pre-built templates for stakeholder updates and escalations
- **Runbook Integration** - Generate actionable runbooks from incident patterns

## Skills Included

### Core Tools

1. **Incident Classifier** (`incident_classifier.py`)
   - Analyzes incident descriptions and outputs severity levels
   - Recommends response teams and initial actions
   - Generates communication templates based on severity

2. **Timeline Reconstructor** (`timeline_reconstructor.py`)
   - Processes timestamped events from multiple sources
   - Reconstructs chronological incident timeline
   - Identifies gaps and provides duration analysis

3. **PIR Generator** (`pir_generator.py`)
   - Creates comprehensive Post-Incident Review documents
   - Applies multiple RCA frameworks (5 Whys, Fishbone, Timeline)
   - Generates actionable follow-up items

## Incident Response Framework

### Severity Classification System

#### SEV1 - Critical Outage
**Definition:** Complete service failure affecting all users or critical business functions

**Characteristics:**
- Customer-facing services completely unavailable
- Data loss or corruption affecting users
- Security breaches with customer data exposure
- Revenue-generating systems down
- SLA violations with financial penalties

**Response Requirements:**
- Immediate escalation to on-call engineer
- Incident Commander assigned within 5 minutes
- Executive notification within 15 minutes
- Public status page update within 15 minutes
- War room established
- All hands on deck if needed

**Communication Frequency:** Every 15 minutes until resolution

#### SEV2 - Major Impact
**Definition:** Significant degradation affecting subset of users or non-critical functions

**Characteristics:**
- Partial service degradation (>25% of users affected)
- Performance issues causing user frustration
- Non-critical features unavailable
- Internal tools impacting productivity
- Data inconsistencies not affecting user experience

**Response Requirements:**
- On-call engineer response within 15 minutes
- Incident Commander assigned within 30 minutes
- Status page update within 30 minutes
- Stakeholder notification within 1 hour
- Regular team updates

**Communication Frequency:** Every 30 minutes during active response

#### SEV3 - Minor Impact
**Definition:** Limited impact with workarounds available

**Characteristics:**
- Single feature or component affected
- <25% of users impacted
- Workarounds available
- Performance degradation not significantly impacting UX
- Non-urgent monitoring alerts

**Response Requirements:**
- Response within 2 hours during business hours
- Next business day response acceptable outside hours
- Internal team notification
- Optional status page update

**Communication Frequency:** At key milestones only

#### SEV4 - Low Impact
**Definition:** Minimal impact, cosmetic issues, or planned maintenance

**Characteristics:**
- Cosmetic bugs
- Documentation issues
- Logging or monitoring gaps
- Performance issues with no user impact
- Development/test environment issues

**Response Requirements:**
- Response within 1-2 business days
- Standard ticket/issue tracking
- No special escalation required

**Communication Frequency:** Standard development cycle updates

### Incident Commander Role

#### Primary Responsibilities

1. **Command and Control**
   - Own the incident response process
   - Make critical decisions about resource allocation
   - Coordinate between technical teams and stakeholders
   - Maintain situational awareness across all response streams

2. **Communication Hub**
   - Provide regular updates to stakeholders
   - Manage external communications (status pages, customer notifications)
   - Facilitate effective communication between response teams
   - Shield responders from external distractions

3. **Process Management**
   - Ensure proper incident tracking and documentation
   - Drive toward resolution while maintaining quality
   - Coordinate handoffs between team members
   - Plan and execute rollback strategies if needed

4. **Post-Incident Leadership**
   - Ensure thorough post-incident reviews are conducted
   - Drive implementation of preventive measures
   - Share learnings with broader organization

#### Decision-Making Framework

**Emergency Decisions (SEV1/2):**
- Incident Commander has full authority
- Bias toward action over analysis
- Document decisions for later review
- Consult subject matter experts but don't get blocked

**Resource Allocation:**
- Can pull in any necessary team members
- Authority to escalate to senior leadership
- Can approve emergency spend for external resources
- Make call on communication channels and timing

**Technical Decisions:**
- Lean on technical leads for implementation details
- Make final calls on trade-offs between speed and risk
- Approve rollback vs. fix-forward strategies
- Coordinate testing and validation approaches

### Communication Templates

#### Initial Incident Notification (SEV1/2)

```
Subject: [SEV{severity}] {Service Name} - {Brief Description}

Incident Details:
- Start Time: {timestamp}
- Severity: SEV{level}
- Impact: {user impact description}
- Current Status: {investigating/mitigating/resolved}

Technical Details:
- Affected Services: {service list}
- Symptoms: {what users are experiencing}
- Initial Assessment: {suspected root cause if known}

Response Team:
- Incident Commander: {name}
- Technical Lead: {name}
- SMEs Engaged: {list}

Next Update: {timestamp}
Status Page: {link}
War Room: {bridge/chat link}

---
{Incident Commander Name}
{Contact Information}
```

#### Executive Summary (SEV1)

```
Subject: URGENT - Customer-Impacting Outage - {Service Name}

Executive Summary:
{2-3 sentence description of customer impact and business implications}

Key Metrics:
- Time to Detection: {X minutes}
- Time to Engagement: {X minutes} 
- Estimated Customer Impact: {number/percentage}
- Current Status: {status}
- ETA to Resolution: {time or "investigating"}

Leadership Actions Required:
- [ ] Customer communication approval
- [ ] PR/Communications coordination  
- [ ] Resource allocation decis

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
