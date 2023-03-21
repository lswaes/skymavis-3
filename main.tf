terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

# Add new users to org
resource "github_membership" "all" {
  for_each = {
    for member in csvdecode(file("members.csv")) :
    member.username => member
  }
  username = each.value.username
}

# Add new teams to the org

resource "github_team" "all" {
  for_each = {
    for team in csvdecode(file("teams.csv")) :
    team.name => team
  }
  name = each.value.name
}

# Add team membership

resource "github_team_membership" "members" {
for_each = { for tm in local.team_members : tm.name => tm }
team_id  = each.value.team_id
username = each.value.username
role     = each.value.role
}
