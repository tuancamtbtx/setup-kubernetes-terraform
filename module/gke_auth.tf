module "gke_auth" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version = "24.1.0"
  depends_on   = [module.gke]
  project_id   = var.project_id
  location     = module.gke.location
  cluster_name = module.gke.name
}