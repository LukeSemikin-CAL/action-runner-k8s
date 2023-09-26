from os import environ
from github import Github

class GithubAccessor:
    
    def __init__(self) :
        self.auth = Github(login_or_token=environ['GITHUB_PAT'])
    
    def set_organisation(self, org_name):
        return self.auth.get_organization(org_name)
    
    def organisation_repos(self, org_name):
        org_repos = []
        for repo in self.set_org(org_name).get_repos():
            org_repos.append(repo.name)
        return org_repos
    
    def set_repo(self, org_name, repo_name):
        return self.set_org(org_name).get_repo(repo_name)
    
    def repo_runners_status(self, org_name, repo_name):
        inactive_runners = []
        for runner in self.set_repo(org_name, repo_name):
            if runner.status.upper() == "IDLE":
                inactive_runners.append((runner.name, runner))
        if len(inactive_runners) != 0:
            return True
        else:
            return False



    