# Azure Zero Trust (Bicep + GitHub Actions) Starter

This repository deploys a **Zero Trust baseline** to Azure:

- **Identity**: Conditional Access (CA) & Privileged Identity Management (PIM) automation (Microsoft Graph)
- **Network**: Hub-and-spoke, Azure Firewall, Bastion (Bicep)
- **Monitoring**: Microsoft Sentinel workspace + starter analytics rule & playbook
- **Data**: Azure Policy for private-by-default patterns
- **Devices**: Defender for Endpoint (MDE) Attack Surface Reduction (ASR) baseline; Intune hooks
- **CI/CD**: GitHub Actions using **OIDC** (no client secret)

> ⚠️ **Important**: Conditional Access can cause lockouts. Pilot in a test tenant or use **report-only** first. Keep at least two break-glass accounts **excluded** from CA.

## Quick Start

1. **Create an App Registration** in Entra ID (Azure AD) and grant API permissions with admin consent:
   - `Policy.ReadWrite.ConditionalAccess`, `Directory.Read.All`, `RoleManagement.ReadWrite.Directory`
2. Configure **GitHub OIDC** federated credential for the app (issuer: `https://token.actions.githubusercontent.com`).
3. In your GitHub repo, set **Secrets**:
   - `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`
4. In your GitHub repo, set **Variables** (example):
   - `AZ_RG=zt-baseline-rg`, `AZ_LOCATION=eastus`, `PREFIX=zt`, `PIM_USER_OBJECT_ID=<objectId>`
5. Run **Deploy Infra (Bicep)** workflow → creates networking hub, Firewall, Bastion, and Sentinel.
6. Run **Deploy Policies** workflow → creates & assigns baseline policies (deny public storage, etc.).
7. Run **Deploy Identity** workflow → creates CA policies & PIM eligibility (edit placeholders before running).

## Deploy from CLI (optional)
```bash
az group create -n zt-baseline-rg -l eastus
az deployment group create -g zt-baseline-rg   --template-file infra/bicep/main.bicep   --parameters prefix=zt location=eastus
```

## What’s Included
- `.github/workflows/*` – CI/CD pipelines for infra, policies, identity
- `infra/bicep/*` – Hub/spoke, Firewall, Bastion, Sentinel
- `policy/*` – Azure Policy definitions & subscription assignment
- `identity/*` – Conditional Access & PIM scripts (Microsoft Graph)
- `device/*` – MDE ASR baseline & Intune placeholders
- `monitoring/sentinel/*` – Workspace content: analytics rule, workbook, playbook
- `data/*` – Storage & Key Vault hardening (baseline)

## Safety & Rollback
- Start with **report-only** CA or restrict to a pilot group.
- Exclude **break-glass** accounts and monitor their sign-ins.
- Keep emergency access procedure documented offline.

## License
MIT
