provider "spacelift" {
}

resource "spacelift_policy" "git_push_policy" {
  name        = "Autoattach Git Push Policy"
  body        = file("${path.module}/policies/git_push.rego")
  type        = "GIT_PUSH"
  labels      = ["autoattach:*"]
  space_id    = "root"
}

resource "spacelift_stack" "stack" {
  count                  = 500
  name                   = "auto-stack-${count.index + 1}"
  repository             = "autoattach-test"
  branch                 = "main"
  space_id               = "root"
  labels                 = ["autoattach:git-policy"]
  project_root           = "/"
}
