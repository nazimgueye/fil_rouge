provider "kubernetes" {
  config_path = "~/.kube/config" //"~/.kube/config"
}
resource "kubernetes_manifest" "deployment_web" {
  manifest = yamldecode(file("../k8s_mysql_deploiement.yaml"))
}

resource "kubernetes_manifest" "deployment_db" {
  manifest = yamldecode(file("../k8s_php_deploiement.yaml"))
}

resource "kubernetes_manifest" "db-service" {
  manifest = yamldecode(file("../k8s_mysql_service.yaml"))
}
resource "kubernetes_manifest" "web-service" {
  manifest = yamldecode(file("../k8s_php_service.yaml"))
}