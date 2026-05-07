# Develop Security Standard for CI/CD

## 1. Purpose

This standard defines the minimum security requirements and best practices for designing, operating, and maintaining CI/CD pipelines. The objective is to reduce the risk of unauthorized code changes, credential exposure, supply-chain compromise, unsafe deployments, and weak auditability across the software delivery lifecycle.

## 2. Scope

This standard applies to:

- source control triggered build and deployment pipelines
- CI systems, CD systems, runners, agents, and shared build infrastructure
- application teams, platform teams, DevOps engineers, SRE, security teams, and release approvers
- internal and third-party integrations used by build, test, packaging, signing, and deployment workflows
- build artifacts, container images, packages, infrastructure templates, and deployment manifests

## 3. Guiding Principles

- enforce least privilege for users, pipelines, runners, and service identities
- prefer ephemeral, automated, and auditable execution over long-lived shared state
- treat the pipeline as production infrastructure and secure it accordingly
- separate build, approval, and deployment responsibilities where risk requires it
- verify provenance, integrity, and trust of source, dependencies, and artifacts
- make security controls part of the default pipeline, not optional follow-up work
- keep every release action traceable to an identity, workflow, artifact, and approval event

## 4. Roles and Responsibilities

### 4.1 Platform or CI/CD Administration Team

- owns the CI/CD platform baseline, runner security, and administrative configuration
- maintains approved pipeline templates, hardened runner images, and shared security controls
- restricts privileged pipeline features and reviews platform-level exceptions

### 4.2 Application or Service Team

- maintains pipeline definitions for its services within the approved security baseline
- ensures required testing, scanning, approvals, and deployment rules are implemented
- removes unused secrets, tokens, jobs, and integrations

### 4.3 Security Team

- defines minimum control requirements for secure build and deployment
- reviews exceptions, high-risk pipeline patterns, and critical findings
- supports incident response, threat modeling, and control validation

### 4.4 Release or Change Approver

- confirms that production deployment approvals follow the required policy
- validates separation of duties when manual approval gates are required

## 5. Identity and Access Management Standard

### 5.1 Human Access

- require SSO and MFA for all CI/CD administrative users
- assign access through groups or roles, not direct individual exceptions where avoidable
- keep CI/CD administrator membership small and reviewed regularly
- separate read-only observers from users who can modify pipelines, secrets, or deployment targets

### 5.2 Service Identities

- use dedicated service identities for automation
- scope each service identity to the minimum repositories, environments, and APIs required
- avoid shared credentials across unrelated pipelines or teams
- rotate long-lived credentials on a defined schedule until they can be replaced

### 5.3 Federated Access

- prefer short-lived federated credentials such as OIDC-based cloud access over stored static credentials
- bind trust policies to specific repositories, branches, tags, environments, or workflow identities
- deny broad wildcard trust relationships unless formally approved

## 6. Pipeline Governance Standard

- store pipeline definitions in version control
- require pull request review for pipeline changes
- protect branches that control production deployment workflows
- keep deployment approval logic in the managed pipeline, not in undocumented operator steps
- separate build workflows from deployment workflows when this improves control and blast-radius containment

High-risk pipeline changes should require expanded review, including changes to:

- deployment targets
- secrets handling
- runner privileges
- approval gates
- production branches or tags
- third-party action or plugin sources

## 7. Runner and Agent Security Standard

### 7.1 Runner Model

- prefer ephemeral runners or short-lived build agents for untrusted or mixed workloads
- isolate runners by sensitivity level, repository class, or environment where needed
- avoid using the same runner pool for both low-trust and production-sensitive workloads

### 7.2 Host Hardening

- patch runner operating systems and base images regularly
- remove unnecessary tools, services, and network exposure from runner images
- run jobs as non-root where possible
- restrict privileged container execution unless technically required and explicitly approved

### 7.3 Workspace Hygiene

- clean workspaces after each job
- prevent cross-job persistence of secrets, caches, and artifacts unless explicitly designed and protected
- encrypt runner disks or ephemeral storage when required by data sensitivity

### 7.4 Network Controls

- restrict runner egress to approved package registries, source platforms, artifact stores, and target systems
- limit inbound access to self-hosted runners to approved administration paths
- separate internet-exposed and internal deployment runners when risk requires it

## 8. Secrets Management Standard

- never store secrets in source control, pipeline definitions, or build logs
- use the CI/CD platform secret store or an approved enterprise secrets manager
- scope secrets by repository, environment, and job purpose
- mask secrets in logs and prevent them from being echoed by scripts
- require approval for access to production secrets
- rotate secrets after suspected exposure, personnel change, or scheduled expiry

Preferred pattern:

- fetch short-lived credentials just in time
- inject them only into the job that needs them
- revoke or expire them automatically after use

## 9. Source and Branch Protection Standard

- enforce branch protection or repository rulesets for default and release branches
- require pull requests, approvals, and passing status checks for code and pipeline changes
- block direct pushes to protected branches
- require CODEOWNERS for pipeline, deployment, and infrastructure definition paths
- restrict who can create or update protected tags used for releases

## 10. Third-Party Integration Standard

- use only approved plugins, marketplace actions, shared libraries, or reusable workflows
- pin third-party actions or plugins to immutable versions or commit SHAs where supported
- review requested permissions for each third-party integration before use
- remove unused integrations promptly
- monitor vendor security advisories for critical CI/CD dependencies

Do not allow pipelines to execute arbitrary remote code from untrusted locations without explicit review.

## 11. Dependency and Supply Chain Security Standard

- run dependency vulnerability scanning in the default pipeline for supported ecosystems
- verify package registry sources and restrict dependency installation to approved registries where possible
- detect tampering, malicious packages, and unexpected dependency source changes
- generate an SBOM for managed applications where required by policy or risk level
- sign or attest build outputs when the platform supports provenance controls

## 12. Build Integrity Standard

- build from reviewed source in version control, not from developer workstations
- make builds reproducible where practical
- use controlled base images and build toolchains
- ensure the build process records the source revision, build identity, and timestamp
- fail the build on critical integrity or policy violations unless an approved exception exists

## 13. Artifact and Image Security Standard

- publish artifacts only to approved registries or artifact repositories
- restrict who can overwrite, delete, or promote artifacts
- sign container images or artifacts where supported and required
- scan artifacts and images for vulnerabilities before promotion to higher environments
- retain artifact metadata sufficient to trace an artifact to its source revision and pipeline execution
- prevent production deployment from artifacts built outside the approved pipeline

## 14. Environment and Deployment Security Standard

- separate non-production and production environments with distinct credentials and approval rules
- require explicit approval for production deployments when policy or risk level requires it
- restrict which branches, tags, or workflow identities may deploy to production
- enforce environment protection rules for sensitive targets
- use separate deployment identities for each environment or environment tier

Where possible:

- use progressive delivery, canary, or blue-green deployment for high-impact systems
- gate production rollout on smoke tests and health validation
- disable or roll back feature exposure quickly through feature flags or deployment controls

## 15. Infrastructure as Code and Configuration Security Standard

- store infrastructure and deployment configuration in version control
- require code review and scanning for infrastructure templates, manifests, and policy files
- separate secret values from configuration code
- validate configuration drift and unauthorized manual changes to managed environments
- protect state backends, deployment manifests, and environment configuration repositories to the same standard as application code

## 16. Logging, Monitoring, and Audit Standard

- log pipeline executions, approvals, secret access events, runner administration, and deployment actions
- retain audit logs according to organizational policy and incident response needs
- alert on suspicious CI/CD activity, including unusual runner behavior, secret access anomalies, failed login spikes, or unauthorized pipeline changes
- monitor for disabled security gates, bypassed approvals, or unexpected production deployment paths

## 17. Approval and Separation of Duties Standard

- require independent approval for production changes when the risk model requires separation of duties
- do not allow a single user to both modify a sensitive pipeline control and approve its production use without compensating controls
- restrict emergency bypass permissions to a small set of accountable roles
- record the reason, approver, and duration for any override or bypass action

## 18. Secure Defaults for Pipeline Stages

### 18.1 Commit and Pull Request Stage

- run linting, unit tests, static analysis, and secret detection
- block merge on critical findings according to policy

### 18.2 Build Stage

- use approved build images and locked dependency sources
- record source revision and artifact metadata

### 18.3 Test Stage

- run integration or security tests appropriate to the service risk
- isolate test credentials and test data from production values

### 18.4 Release and Deploy Stage

- deploy only approved artifacts
- require environment-scoped permissions and release approvals where required
- validate deployment outcome before marking the release successful

## 19. Incident Response Standard for CI/CD

- treat CI/CD compromise, secret leakage, or unauthorized deployment as a security incident
- maintain a runbook for disabling affected pipelines, runners, credentials, and deployment paths
- rotate exposed secrets and invalidate compromised tokens immediately
- preserve logs, runner metadata, workflow history, and artifact provenance for investigation
- perform post-incident review and update pipeline controls based on findings

## 20. Exception Management Standard

- document all exceptions with owner, scope, rationale, compensating controls, approval, and expiry date
- review CI/CD security exceptions regularly
- remove expired exceptions promptly
- use recurring exceptions as input for control redesign rather than permanent manual drift

## 21. Minimum Baseline Checklist

Every managed CI/CD pipeline should meet this baseline:

- pipeline code stored in version control
- branch protection enabled for pipeline changes
- CODEOWNERS defined for workflow and deployment paths
- secrets stored outside source control
- short-lived credentials preferred over static secrets
- runner isolation defined
- vulnerability or dependency scanning enabled
- artifact provenance and traceability available
- production deployment approval path defined
- audit logging and alerting enabled
- rollback or disablement path documented

## 22. Anti-Patterns to Avoid

- storing cloud keys or production passwords directly in pipeline files
- using shared administrator tokens across multiple pipelines
- allowing unreviewed changes to deployment workflows
- running untrusted pull request code on privileged self-hosted runners
- using mutable third-party action versions without pinning
- promoting artifacts with no source traceability
- granting production deploy rights to every developer by default
- bypassing failed security gates without documented approval

## 23. Summary

CI/CD systems are part of the production attack surface. The strongest security posture comes from treating pipelines, runners, secrets, artifacts, and approvals as governed infrastructure. If least privilege, ephemeral execution, verified provenance, protected deployment paths, and auditable controls are standardized, teams can deliver quickly without turning the delivery pipeline into the weakest link.