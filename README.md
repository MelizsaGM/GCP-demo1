# GCP-demo1
Example of a Terraform script integrated in a Jenkins pipeline (Google Cloud Provider)

## Prerequisites
* Terraform installed
* Gcloud SKD installed
* GCP service account
* Jenkins (Terraform plugin installed)

It supports creating:
- Custom VPC "new-network"
- Custom subnetwork depending on the custom VPC (us-central1)
- Firewall rule under the custom VPC
- Ubuntu Virtual machine
 - `Zone: us-central1-a`
 - `Machine type: e2-standard-2`
-A PubSub Topic and Subscription
 - A Cron job which uses gcloud command to read the PubSub messages and write it into GCS as a json file 
 - A Cloud Scheduler to publish a new message to the PubSub topic every 1 minute at Mexico City time zone 

## Terraform and Jenkins integration using Github repo
- Install Terraform plugin in Jenkins
- Configure Terraform in Jenkins
- Add repository credential
- Add GCP secret key to access the project.
- Create a pipeline using Jenkinsfile

### Usage
- Everything will be run on Jenkins
- Jenkins will be able to apply and destroy.
- An action should be select (apply/destroy)
- Select the pipeline and then Build with parameters.
- Depending on the option selected Jenkins will run the terraform script and perform that action on the GCP project.
