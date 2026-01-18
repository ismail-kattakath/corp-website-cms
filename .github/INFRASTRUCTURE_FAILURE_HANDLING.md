# Infrastructure Failure Handling

## Problem
**Scenario**: CI passes → PR merges → Terraform Cloud auto-apply fails
**Result**: Code in `main` branch, but infrastructure deployment broken

## Solution: Multi-Layer Safety Net

### Layer 1: Pre-Merge Validation ✅ CONFIGURED

#### Required Status Checks (ALL must pass before merge):
1. **Test Application Code** - App builds and tests pass
2. **Validate Infrastructure Code** - Terraform syntax and validation
3. **Security Checks** - Trivy security scan
4. **Terraform Cloud** - Speculative plan succeeds
5. **CI Passed** - Overall gate

**Configuration**:
```bash
# Branch protection enforces these checks
# Includes Terraform Cloud status check from speculative plans
# Admins cannot bypass (enforce_admins: true)
```

**How it prevents failures**:
- Terraform Cloud runs speculative plan on every PR
- Posts GitHub status check (pass/fail)
- PR cannot merge unless Terraform plan succeeds
- Auto-apply only runs on code that already passed planning

### Layer 2: Post-Merge Monitoring

#### Terraform Cloud Run Notifications
**Current**: Run executes silently, may fail unnoticed
**Recommended**: Configure notifications

**Setup** (via Terraform Cloud UI or API):
1. **Slack Notifications**
   - Workspace Settings → Notifications
   - Add Slack webhook
   - Trigger: Run fails, needs attention

2. **Email Notifications**
   - Organization Settings → Notification Settings
   - Email on: Run failures, policy failures

3. **GitHub Status Updates**
   - Terraform Cloud posts commit status
   - Failed runs show in GitHub commit history

### Layer 3: Rollback Strategy

#### Automatic Rollback (Not Implemented)
**Option A**: GitHub Actions workflow
```yaml
# .github/workflows/rollback-on-failure.yml
on:
  workflow_run:
    workflows: ["CI - Continuous Integration"]
    types: [completed]
    branches: [main]

jobs:
  check-terraform-status:
    runs-on: ubuntu-latest
    steps:
      - name: Check Terraform Cloud run status
        run: |
          # Query Terraform Cloud API
          # If run failed, create PR to revert merge commit
```

#### Manual Rollback (Current)
```bash
# 1. Identify failed commit
git log --oneline

# 2. Create revert PR
git revert <commit-hash>
git push origin revert-branch

# 3. Fast-track merge (emergency fix)
gh pr create --title "Revert: Failed deployment" --body "Rollback"
gh pr merge --admin --squash
```

### Layer 4: Deployment Gates (Production Best Practice)

#### Disable Auto-Apply (Recommended for Production)
```bash
# Update workspace to require manual approval
TF_TOKEN=$(grep token ~/.terraform.d/credentials.tfrc.json | cut -d'"' -f4)
curl -X PATCH \
  --header "Authorization: Bearer $TF_TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --data '{"data":{"type":"workspaces","attributes":{"auto-apply":false}}}' \
  "https://app.terraform.io/api/v2/workspaces/ws-cfBjPeFsyq5o6rSm"
```

**Workflow with Manual Apply**:
1. PR created → Terraform Cloud speculative plan
2. PR merged → Terraform Cloud runs plan
3. **WAIT**: Plan succeeds, waits for manual approval
4. Team reviews plan output
5. Manual click "Confirm & Apply"
6. Infrastructure deployed

**Benefits**:
- Catch issues in plan output humans notice
- Control deployment timing
- Extra safety for production

**Drawback**:
- Not fully automated (requires human approval)

### Layer 5: Canary Deployments (Advanced)

For critical infrastructure:
```yaml
# Multiple environments
- Workspace: corp-website-canary (10% traffic)
- Workspace: corp-website-staging (internal testing)
- Workspace: corp-website-production (main traffic)

# Deployment flow:
1. Merge → Canary auto-deploys
2. Monitor metrics (5 minutes)
3. If healthy → Promote to production
4. If unhealthy → Auto-rollback canary
```

## Current Configuration

✅ **Enabled**:
- Terraform Cloud speculative plans on PRs
- Terraform Cloud status check required
- Admin enforcement (can't bypass checks)
- Auto-apply on merge to main

❌ **Not Enabled**:
- Slack/Email notifications on failure
- Automatic rollback on deployment failure
- Manual approval gate for production
- Canary deployments

## Recommended Next Steps

### Immediate (High Priority):
1. ✅ Add Terraform Cloud to required checks - **DONE**
2. 🔲 Configure Slack notifications for run failures
3. 🔲 Document rollback procedure in runbook

### Short-term (Next Sprint):
1. 🔲 Implement automatic rollback workflow
2. 🔲 Consider disabling auto-apply for manual gate
3. 🔲 Add deployment monitoring/alerting

### Long-term (Future Enhancement):
1. 🔲 Multi-environment setup (staging → production)
2. 🔲 Canary deployment strategy
3. 🔲 Sentinel policies (Team tier - cost estimation, compliance)

## Testing the Safety Net

To verify protection works:

```bash
# 1. Create intentionally failing Terraform change
echo 'resource "invalid_resource" "test" {}' >> main.tf

# 2. Create PR
git checkout -b test/fail-terraform
git add main.tf
git commit -m "test: intentional Terraform failure"
git push origin test/fail-terraform
gh pr create --title "Test: Terraform validation" --body "Should fail"

# 3. Verify:
# - Terraform Cloud status check fails
# - PR shows "Checks failed"
# - Cannot merge (even with admin privileges)

# 4. Cleanup
gh pr close --delete-branch
git checkout main
```

## Monitoring Checklist

After every deployment, verify:
- [ ] Terraform Cloud run succeeded
- [ ] GitHub Actions CI passed
- [ ] Website accessible (https://kattakath.com)
- [ ] No errors in Firebase Hosting
- [ ] DNS records correct
- [ ] SSL certificate valid

## Emergency Contacts

- **Terraform Cloud**: https://app.terraform.io/app/kattakath-technologies-inc/corp-website
- **GitHub Actions**: https://github.com/ismail-kattakath/corp-website/actions
- **Firebase Console**: https://console.firebase.google.com/project/corp-core-hub
- **Cloudflare**: https://dash.cloudflare.com/6e28971881e488941d052bbbf50d69cd
