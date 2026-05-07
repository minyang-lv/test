# Develop Terraform Development Guideline

## 1. Purpose

This guideline defines best practices for developing, reviewing, testing, and operating Terraform code. The objective is to keep infrastructure changes predictable, secure, reusable, and auditable across teams and environments.

## 2. Scope

This guideline applies to:

- Terraform code used to provision or manage cloud, platform, network, security, or application infrastructure
- reusable modules and root modules
- local development, pull request validation, CI/CD execution, and production infrastructure changes
- engineers, platform teams, SRE, security reviewers, and approvers working with Terraform

## 3. Guiding Principles

- treat Terraform as production code and review it to the same standard as application code
- keep modules small, focused, and reusable
- separate environments and state clearly to reduce blast radius
- prefer deterministic, reviewable plans over ad hoc changes
- automate formatting, validation, scanning, and apply workflows wherever possible
- protect credentials, state, and deployment paths as sensitive assets
- make every infrastructure change traceable to source control, plan output, and approval

## 4. Repository and Directory Structure Standard

Terraform code should use a clear structure that separates reusable modules from environment-specific root modules.

Recommended structure:

```text
terraform/
  modules/
    network/
    eks/
    rds/
  live/
    dev/
      network/
      app/
    test/
      network/
      app/
    prod/
      network/
      app/
```

Guidelines:

- keep reusable modules under `modules/`
- keep deployable root modules under environment-specific directories
- do not mix multiple unrelated environments in the same root module directory
- keep each root module scoped to a clear responsibility, such as `network`, `database`, or `app`

## 5. Version Management Standard

- pin the Terraform CLI version using `required_version`
- pin provider versions using `required_providers`
- commit `.terraform.lock.hcl` for consistent provider resolution
- upgrade Terraform and providers in a controlled change with review and validation
- do not leave provider versions fully unbounded in shared repositories

Example:

```hcl
terraform {
  required_version = "~> 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

## 6. Module Development Standard

### 6.1 Module Design

- each module should have one clear purpose
- design modules around stable infrastructure capabilities, not temporary project names
- prefer composition of smaller modules over large multi-purpose modules
- avoid embedding environment-specific values directly in reusable modules

### 6.2 Module Interface

- expose only necessary input variables
- provide meaningful descriptions for variables and outputs
- use sensible defaults only for values that are truly safe and reusable
- mark sensitive inputs and outputs appropriately
- avoid exposing internal implementation details unless consumers require them

### 6.3 Module Reuse

- version reusable modules explicitly when shared across teams
- document module inputs, outputs, examples, and limitations
- avoid breaking module interfaces without a versioned change strategy

## 7. Root Module Standard

- root modules should wire together reusable modules and environment-specific settings
- keep business or environment decisions in the root module, not inside shared modules
- do not duplicate large blocks of module or resource code across environments when a reusable module can remove the repetition
- keep variable values explicit and easy to review

## 8. Naming Convention Standard

- use lowercase and underscores for Terraform local names, variable names, and output names
- use resource names that reflect business meaning, not temporary ticket identifiers
- keep module names short and capability-based, such as `network`, `iam_role`, or `eks_cluster`
- align resource tags or labels with the platform tagging standard

Recommended tags or metadata where supported:

- environment
- application
- owner
- cost_center
- managed_by = terraform
- data_classification where required

## 9. State Management Standard

- use remote state for shared or long-lived environments
- enable state locking where the backend supports it
- separate state files by environment and responsibility to reduce blast radius
- restrict access to state storage because it may contain sensitive values
- back up state according to platform requirements
- do not edit state manually except under controlled break-glass procedures

Recommended practices:

- one root module should map to one state boundary
- production state must be isolated from non-production state
- state backend credentials should not be hard-coded in Terraform files

## 10. Environment Management Standard

- use separate directories, accounts, subscriptions, projects, or backends for long-lived environments
- prefer explicit environment isolation over relying only on Terraform workspaces for critical environments
- use workspaces only when the operating model is well understood and the blast radius remains acceptable
- keep environment-specific variables outside reusable module code

## 11. Variables, Outputs, and Locals Standard

- define every variable with a type
- add descriptions to variables and outputs
- use validation rules for inputs when invalid values can be checked early
- keep `locals` for derived values, naming consistency, and repeated expressions
- avoid excessive `locals` that make the configuration harder to read
- do not pass secrets through plain-text variable defaults

Example:

```hcl
variable "environment" {
  type        = string
  description = "Deployment environment"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be one of dev, test, prod"
  }
}
```

## 12. Security Standard

- never commit credentials, secrets, private keys, or state files to source control
- use approved secret stores or short-lived identity federation for provider authentication
- mark sensitive values as `sensitive = true` where appropriate
- restrict who can run apply against production targets
- scan Terraform code for security and policy issues in the default pipeline
- use least privilege for cloud roles, service accounts, and backend access

Additional controls:

- protect production variables and secrets with environment-level access controls
- review IAM, network, encryption, and public exposure changes with extra scrutiny
- treat policy exceptions as time-bound and documented

## 13. Provider and External Dependency Standard

- use trusted providers from approved registries
- review third-party modules before adoption
- pin external module versions instead of using floating references
- avoid using Git branches as long-term module sources for shared environments
- validate dependency changes in pull requests with full plan review

## 14. Formatting, Validation, and Quality Gates Standard

Every Terraform change should pass automated quality checks before merge.

Minimum baseline:

- `terraform fmt`
- `terraform validate`
- `terraform plan` for affected root modules
- static analysis or policy checks appropriate to the organization
- secret detection and dependency review where supported

Recommended additional controls:

- linting for Terraform style and anti-pattern detection
- security scanning such as misconfiguration checks
- policy-as-code validation for required organizational controls

## 15. Plan and Apply Workflow Standard

- run `terraform plan` in pull requests for all affected root modules
- review the plan output as the primary evidence of intended change
- apply only reviewed code from the protected branch
- prefer CI/CD-driven apply for shared environments instead of local operator apply
- apply the exact reviewed plan file where the platform and workflow support it

Do not use these patterns as normal delivery workflow:

- applying unreviewed local changes directly to shared environments
- using `-target` routinely to bypass dependency planning
- using `-auto-approve` outside approved automation paths

## 16. Change Review Standard

- require pull request review for all Terraform changes
- require platform or service owner review for high-impact infrastructure changes
- require security review for changes affecting IAM, public exposure, encryption, secrets, or network controls
- require plan review before approving destructive or production-impacting changes
- document accepted risks, manual steps, and migration sequencing in the pull request

## 17. Drift Management Standard

- avoid manual changes in environments managed by Terraform
- detect configuration drift on a scheduled basis for critical environments
- reconcile drift through source-controlled Terraform changes whenever possible
- document and review any manual changes made under emergency procedures

## 18. Import, State Change, and Destructive Action Standard

- treat `terraform import`, `state mv`, `state rm`, and similar state operations as controlled changes
- document why the state operation is needed and what objects are affected
- validate state changes in a safe environment or with peer review before production execution
- review destroy actions and resource replacement actions carefully in the plan output
- require explicit approval for destructive production changes

## 19. CI/CD Standard for Terraform

- separate validation and apply stages where possible
- limit apply permissions to approved branches, tags, and environments
- use short-lived credentials for CI/CD execution when supported
- store pipeline definitions in version control and protect them with review rules
- retain plan, apply, and audit logs according to operational requirements

## 20. Documentation Standard

Each reusable module or root module should include enough documentation for safe use.

Minimum documentation:

- purpose
- owner or maintaining team
- required Terraform and provider versions
- inputs and outputs
- usage example
- backend or environment assumptions
- known limitations or manual dependencies

Recommended files:

- `README.md`
- example configuration where appropriate
- operational notes for production-sensitive modules

## 21. Testing Strategy Standard

- validate module logic in isolated environments before production use
- test destructive or replacement-heavy changes in lower environments when practical
- rehearse schema, network, IAM, or state-sensitive changes before production rollout
- verify created resources using cloud-native or platform-native inspection where needed
- include post-apply smoke checks for critical infrastructure paths

## 22. Anti-Patterns to Avoid

- one massive root module managing everything in every environment
- storing state locally for shared production environments
- using broad administrator credentials for routine Terraform runs
- committing `.tfstate`, `.tfvars` with secrets, or `.terraform/` contents
- copying and pasting resource blocks across environments instead of designing reusable modules
- merging Terraform code without validating plan output
- making emergency console changes and never reconciling them back into code

## 23. Recommended Baseline Checklist

- Terraform and provider versions pinned
- remote backend configured
- state locking enabled where supported
- module inputs typed and documented
- `.terraform.lock.hcl` committed
- formatting and validation checks enabled
- plan reviewed before merge or apply
- secrets kept out of code and state access restricted
- production apply path controlled through CI/CD or approved operator process
- module and root module documentation present

## 24. Summary

Strong Terraform development practices depend on clear module boundaries, isolated state, deterministic plans, protected apply paths, and secure automation. If Terraform code is structured like maintainable software rather than ad hoc scripting, teams can scale infrastructure delivery without losing control of security, quality, or change traceability.