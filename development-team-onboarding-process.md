# Develop Development Team Onboarding Process

## 1. Purpose

This process defines how to onboard new members into a development team in a consistent, secure, and productive way. The objective is to reduce ramp-up time, ensure required access is granted correctly, and help each new joiner become an effective contributor with clear ownership and support.

## 2. Scope

This process applies to:

- new engineers joining the development organization
- internal transfers moving into a development team
- contractors or temporary contributors with development responsibilities
- engineering managers, onboarding buddies, platform teams, and repository administrators

## 3. Guiding Principles

- Standardize the baseline experience for every new joiner.
- Grant access through roles and teams, not one-off manual exceptions.
- Prioritize security and least privilege from day one.
- Provide a clear learning path with measurable onboarding outcomes.
- Make the first contribution small, real, and production-relevant.
- Use documentation and automation to reduce onboarding variance.

## 4. Onboarding Roles and Responsibilities

### 4.1 Hiring Manager

- owns the onboarding plan and expected outcomes
- assigns an onboarding buddy before the start date
- confirms role scope, team placement, and first 30/60/90 day goals
- reviews onboarding progress weekly during the first month

### 4.2 Onboarding Buddy

- acts as the first technical contact for the new joiner
- helps with environment setup, team rituals, and repository navigation
- reviews the first tasks and first pull request
- identifies blockers early and escalates when needed

### 4.3 Platform or IT Team

- prepares laptop, endpoint security, identity enrollment, and core tools
- provisions access through approved groups and workflows
- validates that required baseline tooling is available and current

### 4.4 Repository or Service Owners

- explain system boundaries, ownership, and delivery expectations
- provide service-specific documentation and runbooks
- identify the initial low-risk contribution path

### 4.5 New Joiner

- completes required training and environment setup tasks on time
- documents blockers early
- follows secure development and review practices
- demonstrates independent contribution by the end of the onboarding period

## 5. Onboarding Phases

### 5.1 Preboarding: Before Day 1

Complete these tasks before the start date whenever possible:

- create company identity, email, and SSO account
- enroll MFA
- provision laptop and endpoint protection
- grant baseline communication tools and calendar access
- assign development team, GitHub organization teams, and project trackers
- send onboarding schedule, documentation links, and first-week expectations
- assign onboarding buddy and manager intro meetings

### 5.2 Day 1: Access and Orientation

Day 1 should focus on access, security, and team alignment:

- confirm identity access, VPN, SSO, MFA, and device compliance
- join required communication channels and team meetings
- review team mission, organization structure, and delivery model
- review the development lifecycle: branch strategy, PR process, CI/CD, release flow, and incident path
- validate access to code hosting, ticketing, artifact repositories, cloud consoles, and documentation systems

### 5.3 Week 1: Environment and Context

By the end of the first week, the new joiner should be able to build, test, and review code locally:

- install required SDKs, package managers, CLIs, and IDE extensions
- clone core repositories and verify local build and test commands
- review repository standards such as README, CODEOWNERS, branching, linting, and release practices
- walk through the architecture of the primary product or service
- review team ceremonies: standup, planning, backlog refinement, review, and retrospective
- shadow one code review, one deployment path, and one operational troubleshooting flow

### 5.4 First 30 Days: Guided Contribution

The first 30 days should establish safe contribution ability:

- complete all mandatory engineering and security training
- understand the team backlog, priorities, and ownership boundaries
- complete at least one documentation update and one low-risk code change
- open, address feedback on, and merge the first pull request
- learn service observability basics: logs, metrics, dashboards, and alerts
- review production support expectations, escalation paths, and incident roles

### 5.5 Days 31-60: Increasing Ownership

The next phase should move from guided tasks to scoped ownership:

- independently deliver small to medium changes
- participate actively in design and code review discussions
- troubleshoot routine build or deployment issues with limited guidance
- understand dependent systems, interfaces, and non-functional requirements
- contribute to test coverage, automation, or developer experience improvements

### 5.6 Days 61-90: Operational Readiness

By the end of the onboarding period, the engineer should be operating with limited supervision:

- own a scoped feature, component, or service area
- participate in on-call preparation or production readiness review where relevant
- demonstrate working knowledge of security, compliance, and data handling rules
- contribute to documentation or onboarding improvements based on fresh experience
- agree with the manager on transition from onboarding to normal performance expectations

## 6. Access Provisioning Standard

Access should be provisioned through approved groups and role mappings, not ad hoc grants.

### 6.1 Baseline Access

- company identity account
- email and communication tools
- SSO and MFA
- device management and endpoint protection
- VPN or zero-trust access
- HR and internal knowledge systems as required

### 6.2 Engineering Access

- GitHub organization membership
- team-based repository access
- issue tracking and sprint tooling
- CI/CD visibility
- artifact and package registry access
- container registry access where required
- cloud development or non-production access as approved

### 6.3 Elevated Access

- grant admin, production, or secret-management access only when justified by role
- use approval workflow and time-bound grants where possible
- log and review privileged access assignments

## 7. Developer Environment Setup Standard

The new joiner should be able to reproduce the supported engineering environment using documented setup steps.

Required baseline:

- approved operating system and patch baseline
- supported shell and terminal tools
- source control tooling and SSH or GitHub authentication
- language runtimes and package managers relevant to the team
- local build, test, lint, and formatting commands
- secrets bootstrap process for non-production development
- access to container runtime or local orchestration tools if required

Recommended validation checklist:

- can authenticate to GitHub successfully
- can clone repositories
- can install dependencies
- can run the local test suite
- can run linting or static checks
- can start the application or service locally
- can open a pull request from a feature branch

## 8. Knowledge Transfer Standard

Each onboarding program should include structured knowledge transfer in the following areas:

- business domain and customer impact
- system architecture and service boundaries
- repository layout and code ownership
- development standards and secure coding expectations
- release workflow and rollback approach
- production support model and incident process
- team norms for communication, collaboration, and decision making

Preferred learning assets:

- architecture diagrams
- service README files
- operational runbooks
- coding standards
- recorded walkthroughs
- example pull requests and design documents

## 9. First Contribution Standard

The first contribution should be intentionally small, reviewable, and useful.

Good first tasks include:

- fixing documentation gaps
- adding or improving automated tests
- resolving a minor bug with low blast radius
- improving logging, validation, or developer tooling
- cleaning up non-critical technical debt with clear scope

Avoid giving a new joiner a first task that depends on:

- cross-team coordination across many systems
- undocumented production changes
- urgent incident-driven work
- privileged access that is not yet justified

## 10. Onboarding Success Criteria

The onboarding process is considered successful when the new joiner can:

- access required systems without unmanaged exceptions
- explain the team's mission, services, and core workflows
- run the project locally and pass standard checks
- submit and merge a pull request using the normal review process
- follow team security and operational expectations
- identify where documentation, ownership, and escalation live

## 11. Manager Checkpoints

Managers should run formal checkpoints at these milestones:

### 11.1 End of Week 1

- access and environment are working
- onboarding schedule is understood
- no unresolved setup blockers remain

### 11.2 End of Day 30

- first contribution has been completed
- repository and architecture basics are understood
- training completion is on track

### 11.3 End of Day 60

- independent delivery is improving
- collaboration and review participation are established
- any role-specific skill gaps are documented and addressed

### 11.4 End of Day 90

- onboarding goals are complete
- transition to normal delivery expectations is appropriate
- feedback on the onboarding process is captured

## 12. Common Risks and Controls

- access delays: use pre-approved role-based provisioning and start-date readiness checks
- inconsistent setup: maintain a single source of truth for environment setup documentation
- knowledge gaps: assign a buddy and require structured walkthrough sessions
- over-privileged access: review access by role and remove unused permissions early
- weak first-task selection: maintain a curated list of safe starter tasks per team

## 13. Metrics and Continuous Improvement

Track onboarding quality with a small set of measurable indicators:

- time to full baseline access
- time to successful local build
- time to first pull request
- time to first merged change
- mandatory training completion rate
- onboarding satisfaction feedback
- recurring blockers by tool, team, or access domain

Review these metrics quarterly and update the onboarding process when repeated friction appears.

## 14. Recommended Onboarding Checklist

- identity account created
- MFA enrolled
- laptop provisioned and compliant
- GitHub organization and team membership assigned
- required repositories accessible
- local environment setup completed
- build, test, and lint commands validated
- team rituals attended
- architecture walkthrough completed
- first task assigned
- first pull request merged
- 30/60/90 day review completed

## 15. Summary

An effective development team onboarding process is not just an access checklist. It is a structured path from secure entry to independent contribution. The strongest onboarding programs combine role-based access, reliable environment setup, explicit learning milestones, guided first contributions, and manager checkpoints that confirm real progress.