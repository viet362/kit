# observability-designer

Source: Claude skill
Original path: `components/claude-skills/engineering/skills/observability-designer/SKILL.md`
Description: Design production-ready observability strategies combining metrics, logs, and traces. Includes SLI/SLO design, golden-signals monitoring, alert optimization. Use when adding observability to a new service, refactoring alerting that is too noisy, or designing an SLO program before scaling production load.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Observability Designer (POWERFUL)

**Category:** Engineering  
**Tier:** POWERFUL  
**Description:** Design comprehensive observability strategies for production systems including SLI/SLO frameworks, alerting optimization, and dashboard generation.

## Overview

Observability Designer enables you to create production-ready observability strategies that provide deep insights into system behavior, performance, and reliability. This skill combines the three pillars of observability (metrics, logs, traces) with proven frameworks like SLI/SLO design, golden signals monitoring, and alert optimization to create comprehensive observability solutions.

## Core Competencies

### SLI/SLO/SLA Framework Design
- **Service Level Indicators (SLI):** Define measurable signals that indicate service health
- **Service Level Objectives (SLO):** Set reliability targets based on user experience
- **Service Level Agreements (SLA):** Establish customer-facing commitments with consequences
- **Error Budget Management:** Calculate and track error budget consumption
- **Burn Rate Alerting:** Multi-window burn rate alerts for proactive SLO protection

### Three Pillars of Observability

#### Metrics
- **Golden Signals:** Latency, traffic, errors, and saturation monitoring
- **RED Method:** Rate, Errors, and Duration for request-driven services
- **USE Method:** Utilization, Saturation, and Errors for resource monitoring
- **Business Metrics:** Revenue, user engagement, and feature adoption tracking
- **Infrastructure Metrics:** CPU, memory, disk, network, and custom resource metrics

#### Logs
- **Structured Logging:** JSON-based log formats with consistent fields
- **Log Aggregation:** Centralized log collection and indexing strategies
- **Log Levels:** Appropriate use of DEBUG, INFO, WARN, ERROR, FATAL levels
- **Correlation IDs:** Request tracing through distributed systems
- **Log Sampling:** Volume management for high-throughput systems

#### Traces
- **Distributed Tracing:** End-to-end request flow visualization
- **Span Design:** Meaningful span boundaries and metadata
- **Trace Sampling:** Intelligent sampling strategies for performance and cost
- **Service Maps:** Automatic dependency discovery through traces
- **Root Cause Analysis:** Trace-driven debugging workflows

### Dashboard Design Principles

#### Information Architecture
- **Hierarchy:** Overview → Service → Component → Instance drill-down paths
- **Golden Ratio:** 80% operational metrics, 20% exploratory metrics
- **Cognitive Load:** Maximum 7±2 panels per dashboard screen
- **User Journey:** Role-based dashboard personas (SRE, Developer, Executive)

#### Visualization Best Practices
- **Chart Selection:** Time series for trends, heatmaps for distributions, gauges for status
- **Color Theory:** Red for critical, amber for warning, green for healthy states
- **Reference Lines:** SLO targets, capacity thresholds, and historical baselines
- **Time Ranges:** Default to meaningful windows (4h for incidents, 7d for trends)

#### Panel Design
- **Metric Queries:** Efficient Prometheus/InfluxDB queries with proper aggregation
- **Alerting Integration:** Visual alert state indicators on relevant panels
- **Interactive Elements:** Template variables, drill-down links, and annotation overlays
- **Performance:** Sub-second render times through query optimization

### Alert Design and Optimization

#### Alert Classification
- **Severity Levels:** 
  - **Critical:** Service down, SLO burn rate high
  - **Warning:** Approaching thresholds, non-user-facing issues
  - **Info:** Deployment notifications, capacity planning alerts
- **Actionability:** Every alert must have a clear response action
- **Alert Routing:** Escalation policies based on severity and team ownership

#### Alert Fatigue Prevention
- **Signal vs Noise:** High precision (few false positives) over high recall
- **Hysteresis:** Different thresholds for firing and resolving alerts
- **Suppression:** Dependent alert suppression during known outages
- **Grouping:** Related alerts grouped into single notifications

#### Alert Rule Design
- **Threshold Selection:** Statistical methods for threshold determination
- **Window Functions:** Appropriate averaging windows and percentile calculations
- **Alert Lifecycle:** Clear firing conditions and automatic resolution criteria
- **Testing:** Alert rule validation against historical data

### Runbook Generation and Incident Response

#### Runbook Structure
- **Alert Context:** What the alert means and why it fired
- **Impact Assessment:** User-facing vs internal impact evaluation
- **Investigation Steps:** Ordered troubleshooting procedures with time estimates
- **Resolution Actions:** Common fixes and escalation procedures
- **Post-Incident:** Follow-up tasks and prevention measures

#### Incident Detection Patterns
- **Anomaly Detection:** Statistical methods for detecting unusual patterns
- **Composite Alerts:** Multi-signal alerts for complex failure modes
- **Predictive Alerts:** Capacity and trend-based forward-looking alerts
- **Canary Monitoring:** Early detection through progressive deployment monitoring

### Golden Signals Framework

#### Latency Monitoring
- **Request Latency:** P50, P95, P99 response time tracking
- **Queue Latency:** Time spent waiting in processing queues
- **Network Latency:** Inter-service communication delays
- **Database Latency:** Query execution and connection pool metrics

#### Traffic Monitoring
- **Request Rate:** Requests per second with burst detection
- **Bandwidth Usage:** Network throughput and capacity utilization
- **User Sessions:** Active user tracking and session duration
- **Feature Usage:** API endpoint and feature adoption metrics

#### Error Monitoring
- **Error Rate:** 4xx and 5xx HTTP response code tracking
- **Error Budget:** SLO-based error rate targets and consumption
- **Error Distribution:** Error type classification and trending
- **Silent Failures:** Detection of processing failures without HTTP errors

#### Saturation Monitoring
- **Resource Utilization:** CPU, memory, disk, and network usage
- **Queue Depth:** Processing queue length and wait times
- **Connection Pools:** Database and service connection saturation
- **Rate Limiting:** API throttling and quota exhaustion tracking

### Distributed Tracing Strategies

#### Trace Architecture
- **Sampling Strategy:** Head-based, tail-based, and adaptive sampling
- **Trace Propagation:** Context propagation across service boundaries
- **Span Correlation:** Parent-child relationship modeling
- **Trace Storage:** Retention policies and storage optimization

#### Service Instrumentation
- **Auto-Instrumentation:** Framework-based automatic trace generation
- **Manual Instrumentation:** Custom span creation for business logic
- **Baggage Handling:** Cross-cutting concern propagation
- **Performance Impact:** Instrumentation overhead measurement and optimization

### Log Aggregation Patterns

#### Collection Architecture
- **Agent

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
