# agent-designer

Source: Claude skill
Original path: `components/claude-skills/engineering/skills/agent-designer/SKILL.md`
Description: Use when the user asks to design multi-agent systems, create agent architectures, define agent communication patterns, or build autonomous agent workflows.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Agent Designer - Multi-Agent System Architecture

**Tier:** POWERFUL  
**Category:** Engineering  
**Tags:** AI agents, architecture, system design, orchestration, multi-agent systems

## Overview

Agent Designer is a comprehensive toolkit for designing, architecting, and evaluating multi-agent systems. It provides structured approaches to agent architecture patterns, tool design principles, communication strategies, and performance evaluation frameworks for building robust, scalable AI agent systems.

## Core Capabilities

### 1. Agent Architecture Patterns

#### Single Agent Pattern
- **Use Case:** Simple, focused tasks with clear boundaries
- **Pros:** Minimal complexity, easy debugging, predictable behavior
- **Cons:** Limited scalability, single point of failure
- **Implementation:** Direct user-agent interaction with comprehensive tool access

#### Supervisor Pattern
- **Use Case:** Hierarchical task decomposition with centralized control
- **Architecture:** One supervisor agent coordinating multiple specialist agents
- **Pros:** Clear command structure, centralized decision making
- **Cons:** Supervisor bottleneck, complex coordination logic
- **Implementation:** Supervisor receives tasks, delegates to specialists, aggregates results

#### Swarm Pattern
- **Use Case:** Distributed problem solving with peer-to-peer collaboration
- **Architecture:** Multiple autonomous agents with shared objectives
- **Pros:** High parallelism, fault tolerance, emergent intelligence
- **Cons:** Complex coordination, potential conflicts, harder to predict
- **Implementation:** Agent discovery, consensus mechanisms, distributed task allocation

#### Hierarchical Pattern
- **Use Case:** Complex systems with multiple organizational layers
- **Architecture:** Tree structure with managers and workers at different levels
- **Pros:** Natural organizational mapping, clear responsibilities
- **Cons:** Communication overhead, potential bottlenecks at each level
- **Implementation:** Multi-level delegation with feedback loops

#### Pipeline Pattern
- **Use Case:** Sequential processing with specialized stages
- **Architecture:** Agents arranged in processing pipeline
- **Pros:** Clear data flow, specialized optimization per stage
- **Cons:** Sequential bottlenecks, rigid processing order
- **Implementation:** Message queues between stages, state handoffs

### 2. Agent Role Definition

#### Role Specification Framework
- **Identity:** Name, purpose statement, core competencies
- **Responsibilities:** Primary tasks, decision boundaries, success criteria
- **Capabilities:** Required tools, knowledge domains, processing limits
- **Interfaces:** Input/output formats, communication protocols
- **Constraints:** Security boundaries, resource limits, operational guidelines

#### Common Agent Archetypes

**Coordinator Agent**
- Orchestrates multi-agent workflows
- Makes high-level decisions and resource allocation
- Monitors system health and performance
- Handles escalations and conflict resolution

**Specialist Agent**
- Deep expertise in specific domain (code, data, research)
- Optimized tools and knowledge for specialized tasks
- High-quality output within narrow scope
- Clear handoff protocols for out-of-scope requests

**Interface Agent**
- Handles external interactions (users, APIs, systems)
- Protocol translation and format conversion
- Authentication and authorization management
- User experience optimization

**Monitor Agent**
- System health monitoring and alerting
- Performance metrics collection and analysis
- Anomaly detection and reporting
- Compliance and audit trail maintenance

### 3. Tool Design Principles

#### Schema Design
- **Input Validation:** Strong typing, required vs optional parameters
- **Output Consistency:** Standardized response formats, error handling
- **Documentation:** Clear descriptions, usage examples, edge cases
- **Versioning:** Backward compatibility, migration paths

#### Error Handling Patterns
- **Graceful Degradation:** Partial functionality when dependencies fail
- **Retry Logic:** Exponential backoff, circuit breakers, max attempts
- **Error Propagation:** Structured error responses, error classification
- **Recovery Strategies:** Fallback methods, alternative approaches

#### Idempotency Requirements
- **Safe Operations:** Read operations with no side effects
- **Idempotent Writes:** Same operation can be safely repeated
- **State Management:** Version tracking, conflict resolution
- **Atomicity:** All-or-nothing operation completion

### 4. Communication Patterns

#### Message Passing
- **Asynchronous Messaging:** Decoupled agents, message queues
- **Message Format:** Structured payloads with metadata
- **Delivery Guarantees:** At-least-once, exactly-once semantics
- **Routing:** Direct messaging, publish-subscribe, broadcast

#### Shared State
- **State Stores:** Centralized data repositories
- **Consistency Models:** Strong, eventual, weak consistency
- **Access Patterns:** Read-heavy, write-heavy, mixed workloads
- **Conflict Resolution:** Last-writer-wins, merge strategies

#### Event-Driven Architecture
- **Event Sourcing:** Immutable event logs, state reconstruction
- **Event Types:** Domain events, system events, integration events
- **Event Processing:** Real-time, batch, stream processing
- **Event Schema:** Versioned event formats, backward compatibility

### 5. Guardrails and Safety

#### Input Validation
- **Schema Enforcement:** Required fields, type checking, format validation
- **Content Filtering:** Harmful content detection, PII scrubbing
- **Rate Limiting:** Request throttling, resource quotas
- **Authentication:** Identity verification, authorization checks

#### Output Filtering
- **Content Moderation:** Harmful content removal, quality checks
- **Consistency Validation:** Logic checks, constraint verification
- **Formatting:** Standardized output formats, clean presentation
- **Audit Logging:** Decision trails, compliance records

#### Human-in-the-Loop
- **Approval Workflows:** Critical decision checkpoints
- **Escalation Triggers:** Confidence thresholds, risk assessment
- **Override Mechanisms:** Human judgment precedence
- **Feedback Loops:** Human corrections improve system behavior

### 6. Evaluation Frameworks

#### Task Completion Metrics
- **Success Rate:** Percentage of tasks completed successfully
- **Partial Completion:** Progress measurement for complex tasks
- **Task Classification:** Success criteria by task type
- **Failure Analysis:** Root cause identification and categorization

#### Quality Assessment
- **Output Quality:** Accuracy, relevance, completeness measures
- **Consistency:** Response variability across similar inputs
- **Coherence:** Logical flow and internal consistency
- **User Satisfaction:** Feedback scores, usage patterns

#### Cost Analysis
- **Token Usage:** Input/output token consumption per task
- **API Costs:** External service usage and charges
- **Compute Resources:** CPU, memory, storage u

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
