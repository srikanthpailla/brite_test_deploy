# Deploy Cloud SQL instance and Britetest docker service

Terraform scripts to perform below actions:
1. Create a Cloud SQL instance in GCP
2. Create CloudRun service with britetest docker image(defaults to srikanthreddypailla/learning:britetest1)
3. Configures CloudRun service to connect with Cloud SQL Instance
4. Allows unauthenticated invocations for public API or website


## How to deploy
Pre-requisites before you deploy:

1. Before we deply make sure to enable below mentioned api's in GCP
      - Service Usage API: serviceusage.googleapis.com
      - Cloud Run Admin API: run.googleapis.com
      - Cloud SQL Admin API: sqladmin.googleapis.com

2. In the repo root create keys.json file which should contain service accout keys.
   Refer https://cloud.google.com/iam/docs/keys-create-delete on how to create service account and get keys


Deployment:
From root of the repo run below commands
1. `terraform init`
2. `terraform plan`
3. `terraform apply`  : This will take aprox 15 mins (Creating CloudSQL take the most of the time)

Once deployment is successful, go to GCP console and then go to the CloudRun service, in the service details
you will find the url, which when you open will direct to FastAPI Swagger UI.
