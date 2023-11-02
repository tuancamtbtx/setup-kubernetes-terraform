# Setup GKE by Terraform 
Here's a step-by-step guide on how to set up a Google Kubernetes Engine (GKE) cluster using Terraform:

**Prerequisites:**

- A Google Cloud Platform (GCP) account with billing enabled.
- The `gcloud` CLI tool installed on your machine.
- The Terraform CLI tool installed on your machine.

**Steps:**

1. Create a new project in the Google Cloud Console and enable the Kubernetes Engine API.

2. Set up service account credentials for Terraform by following these steps:
   - In the Google Cloud Console, go to the IAM & Admin page.
   - Click on Service accounts, then click on Create service account.
   - Enter a name for the service account and click on Create.
   - Add the Kubernetes Engine Admin role to the service account.
   - Click on Create key and choose JSON as the key type.
   - Save the generated key file to a secure location on your machine.

3. Create a new directory for your Terraform configuration files.

4. Create a new file named `main.tf` in the directory and add the following code to it:

   ```terraform
   provider "google" {
     credentials = file("<path-to-your-key-file>")
     project     = "<your-project-id>"
     region      = "us-central1"
   }
   
   resource "google_container_cluster" "cluster" {
     name               = "my-gke-cluster"
     location           = "us-central1"
     initial_node_count = 3
   
     node_config {
       machine_type = "n1-standard-1"
     }
   
     master_auth {
       username = ""
       password = ""
   
       client_certificate_config {
         issue_client_certificate = false
       }
     }
   }
   ```

   Replace `<path-to-your-key-file>` with the path to the key file you generated in step 2, and `<your-project-id>` with the ID of your GCP project.

5. Initialize the Terraform configuration by running the following command in the directory:

   ```
   terraform init
   ```

6. Preview the changes that Terraform will make by running the following command:

   ```
   terraform plan
   ```

   This will show you the resources that Terraform will create or modify.

7. Apply the changes by running the following command:

   ```
   terraform apply
   ```

   This will create the GKE cluster with the specified configuration.

8. Connect to the cluster by running the following command:

   ```
   gcloud container clusters get-credentials my-gke-cluster --region us-central1
   ```

   This will add the cluster to your `kubeconfig` file and allow you to use `kubectl` to interact with the cluster.

9. Verify that the cluster is running by running the following command:

   ```
   kubectl get nodes
   ```

   This should show you the three nodes that were created for the cluster.

That's it! You now have a GKE cluster set up using Terraform. You can modify the configuration in `main.tf` to add more nodes, change the machine type, or configure other options. When you're done using the cluster, you can delete it by running the following command:

```
terraform destroy
```

This will delete all resources created by Terraform, including the GKE cluster.