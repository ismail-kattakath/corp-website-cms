# Security Guidelines

## Sensitive Data Management

This repository uses Terraform to manage infrastructure. **Never commit sensitive data** to version control.

### Protected Files (gitignored)

- `terraform.tfvars` - Contains actual credentials
- `*.tfstate` - May contain sensitive outputs
- `.terraform/` - Provider plugins and cache

### How to Use

1. **Copy the example file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Fill in your credentials in `terraform.tfvars`:**
   ```hcl
   cloudflare_zone_id   = "your-actual-zone-id"
   cloudflare_api_token = "your-actual-api-token"
   ```

3. **Never commit `terraform.tfvars`** - it's already in `.gitignore`

### Alternative: Environment Variables

Instead of `terraform.tfvars`, you can use environment variables:

```bash
export TF_VAR_cloudflare_zone_id="your-zone-id"
export TF_VAR_cloudflare_api_token="your-api-token"
terraform plan
```

### CI/CD Setup

For GitHub Actions or other CI/CD:

1. Store secrets in GitHub Secrets (Settings → Secrets → Actions)
2. Reference them in workflows:
   ```yaml
   - name: Terraform Plan
     env:
       TF_VAR_cloudflare_api_token: ${{ secrets.CLOUDFLARE_API_TOKEN }}
       TF_VAR_cloudflare_zone_id: ${{ secrets.CLOUDFLARE_ZONE_ID }}
     run: terraform plan
   ```

### Rotating Credentials

If credentials are accidentally committed:

1. **Rotate immediately** - revoke and create new tokens
2. Use `git filter-repo` or BFG Repo-Cleaner to remove from history
3. Force push to update remote repository
4. Notify team members to re-clone

### Best Practices

✅ **Do:**
- Use `.gitignore` for sensitive files
- Mark variables as `sensitive = true` in Terraform
- Use environment variables or secret managers
- Store state files securely (remote backend with encryption)
- Review commits before pushing

❌ **Don't:**
- Hardcode credentials in `.tf` files
- Commit `terraform.tfvars` with real values
- Share credentials in plain text
- Store secrets in version control
