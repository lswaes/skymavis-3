terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}
provider "github" {
  token = "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"
  owner = "lswaes"
}

// create new team
resource "github_team" "sre" {
  name        = "SRE"
  description = "Site Reliability Engineering"
  privacy     = "closed"
}

// create and add member to team
resource "github_team_membership" "sre_team_membership" {
  team_id  = github_team.sre.id
  username = "<username>"
  role     = "member"
}

data "github_team_repository" "sre_team_repo" {
  team_id    = github_team.sre.id
  repository = github_repository.sre_scripts.name
  permission = "push"
}