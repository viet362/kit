# gcp-cloud-architect

Source: Claude skill
Original path: `components/claude-skills/engineering-team/skills/gcp-cloud-architect/SKILL.md`
Description: Design GCP architectures for startups and enterprises. Use when asked to design Google Cloud infrastructure, deploy to GKE or Cloud Run, configure BigQuery pipelines, optimize GCP costs, or migrate to GCP. Covers Cloud Run, GKE, Cloud Functions, Cloud SQL, BigQuery, and cost optimization.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# GCP Cloud Architect

Design scalable, cost-effective Google Cloud architectures for startups and enterprises with infrastructure-as-code templates.

---

## Workflow

### Step 1: Gather Requirements

Collect application specifications:

```
- Application type (web app, mobile backend, data pipeline, SaaS)
- Expected users and requests per second
- Budget constraints (monthly spend limit)
- Team size and GCP experience level
- Compliance requirements (GDPR, HIPAA, SOC 2)
- Availability requirements (SLA, RPO/RTO)
```

### Step 2: Design Architecture

Run the architecture designer to get pattern recommendations:

```bash
python scripts/architecture_designer.py --input requirements.json
```

**Example output:**

```json
{
  "recommended_pattern": "serverless_web",
  "service_stack": ["Cloud Storage", "Cloud CDN", "Cloud Run", "Firestore", "Identity Platform"],
  "estimated_monthly_cost_usd": 30,
  "pros": ["Low ops overhead", "Pay-per-use", "Auto-scaling", "No cold starts on Cloud Run min instances"],
  "cons": ["Vendor lock-in", "Regional limitations", "Eventual consistency with Firestore"]
}
```

Select from recommended patterns:
- **Serverless Web**: Cloud Storage + Cloud CDN + Cloud Run + Firestore
- **Microservices on GKE**: GKE Autopilot + Cloud SQL + Memorystore + Cloud Pub/Sub
- **Serverless Data Pipeline**: Pub/Sub + Dataflow + BigQuery + Looker
- **ML Platform**: Vertex AI + Cloud Storage + BigQuery + Cloud Functions

See `references/architecture_patterns.md` for detailed pattern specifications.

**Validation checkpoint:** Confirm the recommended pattern matches the team's operational maturity and compliance requirements before proceeding to Step 3.

### Step 3: Estimate Cost

Analyze estimated costs and optimization opportunities:

```bash
python scripts/cost_optimizer.py --resources current_setup.json --monthly-spend 2000
```

**Example output:**

```json
{
  "current_monthly_usd": 2000,
  "recommendations": [
    { "action": "Right-size Cloud SQL db-custom-4-16384 to db-custom-2-8192", "savings_usd": 380, "priority": "high" },
    { "action": "Purchase 1-yr committed use discount for GKE nodes", "savings_usd": 290, "priority": "high" },
    { "action": "Move Cloud Storage objects >90 days to Nearline", "savings_usd": 75, "priority": "medium" }
  ],
  "total_potential_savings_usd": 745
}
```

Output includes:
- Monthly cost breakdown by service
- Right-sizing recommendations
- Committed use discount opportunities
- Sustained use discount analysis
- Potential monthly savings

Use the [GCP Pricing Calculator](https://cloud.google.com/products/calculator) for detailed estimates.

### Step 4: Generate IaC

Create infrastructure-as-code for the selected pattern:

```bash
python scripts/deployment_manager.py --app-name my-app --pattern serverless_web --region us-central1
```

**Example Terraform HCL output (Cloud Run + Firestore):**

```hcl
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

resource "google_cloud_run_v2_service" "api" {
  name     = "${var.environment}-${var.app_name}-api"
  location = var.region

  template {
    containers {
      image = "gcr.io/${var.project_id}/${var.app_name}:latest"
      resources {
        limits = {
          cpu    = "1000m"
          memory = "512Mi"
        }
      }
      env {
        name  = "FIRESTORE_PROJECT"
        value = var.project_id
      }
    }
    scaling {
      min_instance_count = 0
      max_instance_count = 10
    }
  }
}

resource "google_firestore_database" "default" {
  project     = var.project_id
  name        = "(default)"
  location_id = var.region
  type        = "FIRESTORE_NATIVE"
}
```

**Example gcloud CLI deployment:**

```bash
# Deploy Cloud Run service
gcloud run deploy my-app-api \
  --image gcr.io/$PROJECT_ID/my-app:latest \
  --region us-central1 \
  --platform managed \
  --allow-unauthenticated \
  --memory 512Mi \
  --cpu 1 \
  --min-instances 0 \
  --max-instances 10

# Create Firestore database
gcloud firestore databases create --location=us-central1
```

> Full templates including Cloud CDN, Identity Platform, IAM, and Cloud Monitoring are generated by `deployment_manager.py` and also available in `references/architecture_patterns.md`.

### Step 5: Configure CI/CD

Set up automated deployment with Cloud Build or GitHub Actions:

```yaml
# cloudbuild.yaml
steps:
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA', '.']

  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA']

  - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk'
    entrypoint: gcloud
    args:
      - 'run'
      - 'deploy'
      - 'my-app-api'
      - '--image=gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA'
      - '--region=us-central1'
      - '--platform=managed'

images:
  - 'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA'
```

```bash
# Connect repo and create trigger
gcloud builds triggers create github \
  --repo-name=my-app \
  --repo-owner=my-org \
  --branch-pattern="^main$" \
  --build-config=cloudbuild.yaml
```

### Step 6: Security Review

Verify security configuration:

```bash
# Review IAM bindings
gcloud projects get-iam-policy $PROJECT_ID --format=json

# Check service account permissions
gcloud iam service-accounts list --project=$PROJECT_ID

# Verify VPC Service Controls (if applicable)
gcloud access-context-manager perimeters list --policy=$POLICY_ID
```

**Security checklist:**
- IAM roles follow least privilege (prefer predefined roles over basic roles)
- Service accounts use Workload Identity for GKE
- VPC Service Controls configured for sensitive APIs
- Cloud KMS encryption keys for customer-managed encryption
- Cloud Audit Logs enabled for all admin activity
- Organization policies restrict public access
- Secret Manager used for all credentials

**If deployment fails:**

1. Check the failure reason:
   ```bash
   gcloud run services describe my-app-api --region us-central1
   gcloud logging read "resource.type=cloud_run_revision" --limit=20
   ```
2. Review Cloud Logging for application errors.
3. Fix the configuration or container image.
4. Redeploy:
   ```bash
   gcloud run deploy my-app-api --image gcr.io/$PROJECT_ID/my-app:latest --region us-central1
   ```

**Common failure causes:**
- IAM permission errors -- verify service account roles and `--allow-unauthenticated` flag
- Quota exceeded -- request quota increase via IAM & Admin > Quotas
- Container startup failure -- check container logs and health check configuration
- Region not enabled -- enable the required APIs with `gcloud services enable`

---

## Tools

### architecture_designer.py

Recommends GCP services bas

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
