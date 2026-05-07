# Develop GitHub Organization, Teams, Repos Management Standard

## 1. Purpose

This standard defines best practices for managing GitHub organizations, teams, and repositories in a development environment. The goal is to keep repository ownership clear, permissions least-privileged, governance auditable, and delivery efficient.

## 2. Scope

This standard applies to:

- GitHub organizations used for software development
- Organization owners, team maintainers, repository administrators, and engineers
- Source code repositories, shared workflow repositories, and template repositories

## 3. Guiding Principles

- Least privilege: grant the minimum access required to perform a job.
- Team-first access: assign permissions to teams instead of individual users whenever possible.
- Clear ownership: every repository must have an accountable owning team.
- Standardization: apply the same naming, branching, review, and security rules across repositories.
- Automation over manual control: prefer SSO, IdP group sync, rulesets, templates, and policy automation.
- Auditability: access changes, approvals, and repository lifecycle events must be traceable.

## 4. Organization Management Standard

### 4.1 Organization Design

- Use one GitHub organization per clear business, legal, or environment boundary.
- Do not mix unrelated business units, experimental sandboxes, and production-managed code in the same organization unless governance requirements are identical.
- Keep personal repositories out of the delivery path for shared or production software.

### 4.2 Organization Ownership

- Keep the number of organization owners small and controlled.
- Maintain at least two organization owners for continuity, but avoid broad owner membership.
- Assign organization owner only to platform administrators or governance leads, not normal engineering roles.
- Review owner membership at least quarterly.

### 4.3 Identity and Access Baseline

- Enforce SSO for all members when GitHub Enterprise features are available.
- Require MFA for all users.
- Integrate membership with the enterprise identity provider where possible.
- Set organization base permissions to `read` or `none`; avoid broad `write` defaults.
- Restrict repository creation if centralized governance is required.
- Restrict forking, outside collaboration, and GitHub App installation unless explicitly approved.

### 4.4 External Users

- Prefer internal team membership over outside collaborators.
- Allow outside collaborators only for approved business needs, fixed scope, and defined expiry.
- Review outside collaborator access monthly.

## 5. Team Management Standard

### 5.1 Team Structure

- Structure teams around stable ownership boundaries such as platform, backend, frontend, data, SRE, and security.
- Use nested teams when it reflects real responsibility, for example a top-level `engineering` team with child teams like `platform` and `payments`.
- Create service or domain teams only when they map to ongoing ownership, not temporary project names.

### 5.2 Team Naming Convention

- Use short, unambiguous, lowercase names.
- Prefer names that show function and scope, for example:

```text
engineering/platform
engineering/payments
engineering/frontend
security/appsec
operations/sre
```

- Avoid personal names, vague labels, or ticket-based names such as `team1`, `project-x-temp`, or `alice-team`.

### 5.3 Team Roles

- Use team maintainers to manage day-to-day membership and repository permissions.
- Do not use organization owners as a substitute for team maintainers.
- Keep maintainer assignment limited to people accountable for the team.

### 5.4 Membership Management

- Manage membership through IdP group synchronization whenever possible.
- Avoid granting repository permissions directly to individual users.
- Record the business reason for privileged team membership.
- Remove membership immediately during role change or offboarding.

## 6. Repository Management Standard

### 6.1 Repository Creation

Every new repository should have:

- a defined owning team
- a clear name
- a visibility classification
- a README
- a license where required
- issue and pull request templates where relevant
- branch protection or repository rulesets
- CODEOWNERS
- baseline security settings enabled

### 6.2 Repository Naming Convention

- Use consistent lowercase kebab-case naming.
- Prefer names that describe business capability or deployable unit.
- Suggested patterns:

```text
<domain>-<service>
<platform>-<component>
<team>-<tool>
```

- Examples:

```text
payments-api
customer-portal-ui
platform-terraform-modules
security-policy-as-code
```

- Avoid unclear names such as `test`, `demo`, `new-repo`, or version-specific names.

### 6.3 Repository Visibility

- Default to `private` unless there is a validated need for internal or public visibility.
- Public repositories require explicit approval, security review, and content review.
- Internal repositories should still follow the same security and ownership controls as private ones.

### 6.4 Repository Ownership

- Every repository must map to one primary owning team.
- Shared repositories may have supporting teams, but the primary owner must be explicit.
- Repository administrators should normally be assigned through the owning team, not individual accounts.

### 6.5 Repository Lifecycle

- Use repository templates for new services, libraries, and infrastructure modules.
- Archive repositories that are no longer actively maintained.
- Do not delete repositories without confirming retention, compliance, and dependency impact.
- Mark deprecated repositories in the README and repository description before archival.

## 7. Access Control Standard

### 7.1 Permission Model

- Assign repository access to teams, not users.
- Use `read` for most members, `write` for contributors, `maintain` or `admin` only for repository operators.
- Reserve `admin` for the owning platform team or designated maintainers.
- Do not grant `admin` simply to bypass process friction.

### 7.2 Direct User Access

- Direct user permissions are exceptions and should be time-bound.
- Review all direct user permissions at least monthly.
- Remove temporary elevated access after the approved task completes.

### 7.3 Service Accounts and Apps

- Prefer GitHub Apps over long-lived personal access tokens.
- Use fine-grained tokens with minimal scopes when tokens are unavoidable.
- Rotate credentials regularly and store them in an approved secrets manager.

## 8. Branch, PR, and Review Standard

### 8.1 Default Branch

- Standardize on `main` unless a regulated workflow requires otherwise.
- Protect the default branch with rulesets or branch protection.

### 8.2 Required Protections

- Require pull requests before merge.
- Require at least one approval for low-risk repositories and two approvals for shared, critical, or production-impacting repositories.
- Require status checks to pass before merge.
- Dismiss stale approvals when code changes after approval.
- Block force-push and branch deletion on protected branches.
- Require conversation resolution before merge.

### 8.3 Merge Strategy

- Standardize on squash merge or rebase merge for most application repositories.
- Keep merge policy consistent within the organization.
- Enable linear history where it improves traceability and team workflow.

## 9. CODEOWNERS Standard

- Every actively maintained repository must include a CODEOWNERS file.
- Prefer GitHub teams as code owners instead of individuals.
- Use individuals only as temporary secondary owners or for very small repositories.
- Define ownership from broad paths to specific paths.
- Keep the file aligned with real operational ownership.

Example:

```text
*                         @my-org/engineering-platform
/docs/                    @my-org/engineering-platform @my-org/security-appsec
/services/payments/       @my-org/engineering-payments
/services/customer-ui/    @my-org/engineering-frontend
```

## 10. Security and Compliance Standard

- Enable secret scanning and push protection where supported.
- Enable Dependabot alerts and security updates for supported ecosystems.
- Enable code scanning for critical repositories.
- Require signed commits or signed tags where supply-chain controls demand it.
- Protect deployment environments with reviewer gates for production workflows.
- Store reusable workflows in controlled repositories and version them explicitly.

## 11. Repository Content Standard

Each production or shared repository should contain:

- `README.md`
- `.gitignore`
- `CODEOWNERS`
- CI workflow definitions
- security reporting guidance when externally visible
- contribution guidance when the repository accepts broader collaboration

Recommended repository health files:

- issue templates
- pull request template
- `SECURITY.md`
- `CONTRIBUTING.md`
- release process notes

## 12. Automation and Governance Standard

- Use a `.github` shared repository for common workflows, issue forms, and organization-wide defaults where appropriate.
- Use repository templates to enforce baseline files and controls.
- Use policy automation to detect missing branch protections, missing CODEOWNERS, inactive admins, and public exposure drift.
- Use scheduled audits for repository settings, team access, GitHub Apps, and secrets exposure.

## 13. Audit and Review Standard

### 13.1 Monthly Reviews

- outside collaborators
- direct user repository permissions
- new public repositories
- GitHub App installations

### 13.2 Quarterly Reviews

- organization owners
- team maintainers
- dormant repositories
- archived repositories pending deletion
- branch protection and ruleset coverage

### 13.3 Annual Reviews

- naming conventions and taxonomy fitness
- repository sprawl and consolidation opportunities
- governance exceptions
- incident learnings and policy updates

## 14. Onboarding and Offboarding Standard

- New joiners should receive access through team membership, not one-off repository grants.
- Privileged access should require role-based approval.
- Offboarding must remove organization membership, team membership, tokens, SSH keys, and app-linked credentials immediately.
- Automate offboarding from the identity provider whenever possible.

## 15. Exceptions Standard

- Exceptions must be documented with owner, reason, scope, compensating controls, approval, and expiry date.
- Exceptions should be time-bound and reviewed regularly.
- Permanent exceptions should trigger a policy review instead of becoming silent custom practice.

## 16. Recommended Baseline Checklist

Use this checklist for any new or existing managed repository:

- owning team assigned
- repository visibility approved
- direct user admin access removed
- CODEOWNERS present and team-based
- branch protection or rulesets enabled
- required status checks configured
- security alerts enabled
- README present
- repository archived or active status clear

## 17. Anti-Patterns to Avoid

- too many organization owners
- granting repository admin to individual developers by default
- using individuals instead of teams in CODEOWNERS everywhere
- creating repositories without a clear owner
- allowing direct pushes to `main`
- keeping dormant repositories writable forever
- using long-lived personal access tokens for automation
- letting external collaborators persist without review

## 18. Summary

Strong GitHub governance depends on a simple operating model: small owner groups, team-based access, explicit repository ownership, protected branches, mandatory CODEOWNERS, automated security controls, and regular audits. If these controls are standardized early, GitHub remains scalable without slowing engineering delivery.