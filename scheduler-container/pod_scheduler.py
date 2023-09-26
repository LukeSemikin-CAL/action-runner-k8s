from os import environ
from time import sleep

from modules.kubernetes import K8sScheduler
from modules.github import GithubAccessor

def scheduler():
    print("Polling")
    poll = GithubAccessor()
    scheduler = K8sScheduler()
    if poll.repo_runners_status(environ['ORGANISATION'], environ['REPOSITORY']) is True:
        scheduler.pod_scheduler()
    else:
        print("All Pods Idle")
        sleep(20)
        scheduler()

if __name__ == '__main__':
    scheduler()