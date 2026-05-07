# Deliver DevOps Platform Usage Trainings to Application Development Team

## 1. Purpose

This document defines how to plan, deliver, and measure DevOps platform usage trainings for application development teams. The objective is to help engineers use the platform safely, consistently, and effectively across source control, CI/CD, environments, release workflows, and operational support.

## 2. Scope

This training guidance applies to:

- application development teams adopting or expanding use of the DevOps platform
- platform engineering, DevOps, SRE, security, release, and engineering management stakeholders
- onboarding, team enablement, platform migration, and platform capability rollout programs
- shared platform capabilities such as repositories, pipelines, artifact registries, environments, access controls, release controls, and observability integrations

## 3. Training Objectives

The training program should enable application development teams to:

- understand the purpose, boundaries, and supported usage model of the DevOps platform
- use standard source control, branch, review, and repository workflows correctly
- build, test, package, and deploy applications through approved CI/CD paths
- consume shared platform services without bypassing security or governance controls
- troubleshoot routine pipeline, environment, and deployment issues safely
- follow release, rollback, incident, and access management expectations
- understand when to use self-service capabilities and when to escalate to the platform team

## 4. Audience

Primary audience:

- application developers
- technical leads
- QA or test engineers interacting with CI/CD and release flows
- engineering managers responsible for team adoption

Secondary audience:

- SRE or operations engineers supporting application teams
- security champions
- release coordinators

## 5. Training Principles

- teach the supported platform path, not unofficial shortcuts
- combine conceptual understanding with hands-on practice
- tailor examples to the team's real application delivery workflow
- start with secure defaults and platform guardrails
- keep training role-based so participants learn what they actually need to operate
- measure outcomes using observable usage and delivery behavior, not attendance alone

## 6. Roles and Responsibilities

### 6.1 Platform Team

- owns training content for platform capabilities and guardrails
- provides reference architectures, templates, demo repositories, and sample pipelines
- delivers or coordinates instructor-led sessions and office hours
- maintains documentation and updates training material when the platform changes

### 6.2 Application Team Manager

- identifies participants and required learning depth by role
- ensures engineers attend required sessions and complete hands-on exercises
- tracks adoption progress and escalates blockers

### 6.3 Trainers or Subject Matter Experts

- explain platform workflows, standards, and supported operating model
- demonstrate real usage patterns, troubleshooting steps, and common failure scenarios
- assess participant readiness and collect feedback

### 6.4 Participants

- complete prerequisites before the live sessions
- attend the required training modules
- complete labs, assessments, and follow-up tasks on time
- use the platform according to documented standards after training

## 7. Training Delivery Model

Use a layered delivery model so teams receive both baseline knowledge and role-relevant depth.

Recommended delivery layers:

- foundational training for all participants
- role-based training for developers, leads, release owners, and support roles
- hands-on labs for real platform workflows
- office hours or clinics for team-specific questions
- refresher training when major platform capabilities or standards change

## 8. Training Prerequisites

Before training begins, participants should have:

- corporate identity, SSO, and MFA configured
- access to the DevOps platform and required repositories or projects
- local development environment working at the baseline level
- ability to clone repositories, create branches, and open pull requests
- access to the training environment, sandbox, or demo project

## 9. Core Curriculum

The foundational curriculum should cover the platform end-to-end from code to deployment.

### 9.1 Platform Overview

- platform purpose and supported operating model
- shared services offered by the platform team
- team responsibilities versus platform responsibilities
- standard onboarding and support channels

### 9.2 Source Control and Collaboration

- repository structure and ownership model
- branch strategy and pull request expectations
- CODEOWNERS, review flow, and merge protections
- tagging, release branches, and traceability expectations

### 9.3 CI/CD Pipeline Usage

- approved pipeline templates and reusable workflows
- required quality gates such as build, test, scan, and policy checks
- pipeline variables, secrets handling, and environment scoping
- reading pipeline logs and troubleshooting common failures

### 9.4 Artifact and Dependency Management

- artifact repositories and container registries
- package provenance and versioning expectations
- approved dependency sources and supply-chain controls

### 9.5 Environment and Deployment Usage

- environment promotion path from development to production
- deployment approvals, gates, and release evidence
- rollback expectations and deployment validation steps
- feature flags or progressive delivery controls where used

### 9.6 Security and Compliance Controls

- secrets handling and credential boundaries
- least privilege and access request process
- security scans, policy checks, and escalation expectations
- what is blocked by design and why

### 9.7 Observability and Operational Readiness

- logs, metrics, dashboards, and alerts relevant to releases
- how to verify post-deployment health
- incident escalation path and release-time coordination expectations

## 10. Role-Based Training Tracks

### 10.1 Developer Track

- day-to-day repository, branch, and PR workflow
- running and troubleshooting pipelines
- consuming platform templates and deployment patterns
- safe rollback and post-deploy verification basics

### 10.2 Technical Lead Track

- repository and pipeline governance expectations
- release coordination and production readiness review
- reviewing risky infrastructure, security, or deployment changes
- team adoption metrics and exception handling

### 10.3 QA or Test Track

- validation stages in CI/CD
- test evidence expectations for release readiness
- smoke testing and non-production promotion flows

### 10.4 SRE or Support Track

- deployment observability and health verification
- release troubleshooting and escalation
- rollback decision support and operational runbooks

## 11. Recommended Training Phases

### 11.1 Phase 1: Preparation

- confirm participant list and role mapping
- confirm prerequisites and access readiness
- prepare sandbox repositories, sample applications, and lab guides
- publish agenda, objectives, and expected outcomes

### 11.2 Phase 2: Foundation Sessions

- deliver baseline platform overview and supported workflows
- demonstrate standard end-to-end delivery path
- explain governance, security, and release guardrails

### 11.3 Phase 3: Hands-On Labs

- create a feature branch
- open a pull request
- trigger or observe CI validation
- fix a failing pipeline scenario
- promote an artifact through non-production environments
- execute post-deployment validation and a rollback exercise where practical

### 11.4 Phase 4: Team-Specific Enablement

- map the training to the team's actual repositories and services
- review real pipeline definitions, release process, and operational dependencies
- close adoption gaps and document outstanding blockers

### 11.5 Phase 5: Follow-Up and Support

- run office hours or clinics
- answer implementation questions from the first live usage period
- refine training material from observed friction points

## 12. Delivery Formats

Use a mix of delivery formats to improve retention and adoption.

Recommended formats:

- instructor-led overview sessions
- live demonstrations
- guided labs
- recorded walkthroughs for repeat viewing
- quick reference guides and checklists
- team-specific Q and A sessions

## 13. Hands-On Training Environment Standard

Training is most effective when participants work in a safe but realistic environment.

The training environment should:

- be isolated from production
- include representative repositories, pipelines, secrets boundaries, and environments
- allow participants to make mistakes without business impact
- include common failure cases for troubleshooting practice
- mirror approved templates and controls used in real delivery flows

## 14. Assessment and Success Criteria

Training should verify operational readiness, not just attendance.

Minimum expected outcomes:

- participant can explain the supported platform workflow for their role
- participant can use the approved repository and pull request flow
- participant can read pipeline results and identify the basic cause of failure
- participant can follow the environment promotion and release path correctly
- participant understands how to request access, escalate issues, and avoid unsupported shortcuts

Recommended assessment methods:

- lab completion
- short knowledge checks
- observed walkthrough of a standard delivery flow
- first live usage review with the platform or lead engineer

## 15. Adoption Metrics

Measure training effectiveness using operational outcomes.

Recommended metrics:

- training attendance and completion rate
- lab completion rate
- time to first successful pull request through the standard path
- time to first successful deployment through the approved pipeline
- reduction in support tickets caused by basic usage errors
- reduction in policy bypass attempts or unsupported workflow usage
- participant feedback and confidence score

## 16. Post-Training Support Model

The support model should be clear before the team starts using the platform independently.

Recommended support channels:

- office hours during early adoption
- platform documentation and quick-start guides
- support chat channel or ticket queue
- escalation path for production-impacting issues
- named contacts for pipeline, environment, and access issues

## 17. Common Topics That Require Extra Attention

- secrets and environment variable handling
- production deployment approvals and release evidence
- rollback expectations
- permissions and separation of duties
- differences between sandbox, non-production, and production workflows
- use of shared templates versus custom pipeline logic

## 18. Anti-Patterns to Avoid

- training only on slides without platform hands-on work
- teaching unofficial shortcuts that bypass security or governance
- assuming developers understand the platform because they know Git or CI tools generally
- delivering the same depth to every role regardless of responsibility
- ending training at session completion without adoption follow-up
- letting teams copy old pipeline patterns that are no longer supported

## 19. Recommended Training Checklist

- audience and roles identified
- prerequisites completed
- access to sandbox or demo project confirmed
- agenda and materials published
- baseline platform overview delivered
- role-based training delivered
- hands-on labs completed
- assessments completed
- office hours scheduled
- adoption metrics captured
- follow-up actions assigned

## 20. Summary

Effective DevOps platform training is a structured enablement program, not a one-time presentation. The strongest programs combine platform standards, practical labs, team-specific workflows, and post-training support so application teams can adopt the platform confidently while staying within the approved delivery, security, and governance model.
