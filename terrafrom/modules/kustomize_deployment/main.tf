resource "null_resource" "kustomize_apply" {
  triggers = {
    kustomize_files_hash = filemd5("${var.kustomize_directory}/kustomization.yaml")
  }

  provisioner "local-exec" {
    command = "kubectl apply -k ${var.kustomize_directory}"
  }
}
