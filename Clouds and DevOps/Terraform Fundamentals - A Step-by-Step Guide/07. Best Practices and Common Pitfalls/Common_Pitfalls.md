# **Common Pitfalls**

1. Ignoring Infrastructure Drift
    * **Pitfall:** Relying solely on Terraform to manage all changes without accounting for manual modifications or third-party integrations.
    * **Solution:** Schedule periodic drift detection and reconcile state with actual infrastructure.

2. Overusing depends_on
    * **Pitfall:** Explicitly defining dependencies when Terraform's internal dependency graph would suffice, leading to bloated configurations.
    * **Solution:** Use depends_on sparingly and only for cross-module or external dependencies.

3. Not Accounting for Provider-Specific Limitations
    * **Pitfall:** Assuming consistent behavior across providers (e.g., AWS, Azure, GCP).
    * **Solution:** Review provider documentation and test configurations in staging environments to identify quirks.

4. Mismanaging Resource Lifecycles
    * **Pitfall:** Using default lifecycle rules, causing unintended resource recreation (e.g., IP changes on VPC modifications).
    * **Solution:** Use lifecycle meta-arguments (ignore_changes, create_before_destroy) strategically to control updates.

5. Complex Data Source Queries
    * **Pitfall:** Overusing data sources for querying existing infrastructure, leading to performance issues in large environments.
    * **Solution:** Use data sources judiciously and consider caching outputs for frequently accessed data.

6. Inadequate Rollback Planning
    * **Pitfall:** Relying solely on Terraform’s state to roll back changes after failed applies.
    * **Solution:** Implement manual rollback steps or use version-controlled infrastructure snapshots.

7. Inconsistent Provider Configurations
    * **Pitfall:** Defining providers inconsistently across modules, leading to mismatches in regions or authentication methods.
    * **Solution:** Centralize provider configurations using a shared providers.tf file or pass provider blocks into modules.

8. Ignoring Performance Impacts
    * **Pitfall:** Creating overly large plans for updates, causing long execution times and potential timeouts.
    * **Solution:** Optimize plans by targeting specific resources or splitting infrastructure across workspaces.

9. Committing State Files or Sensitive Data
    * **Pitfall:** Accidentally committing terraform.tfstate or secrets to version control.
    * **Solution:** Add .gitignore rules for sensitive files and enable secrets scanning tools.

10. Blindly Accepting Terraform Defaults
    * **Pitfall:** Using Terraform defaults (e.g., 0.0.0.0/0 for security group rules) without understanding their implications.
    * **Solution:** Define explicit configurations for security-critical resources.
