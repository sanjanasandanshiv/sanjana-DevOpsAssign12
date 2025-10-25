# sanjana-DevOpsAssign12

This repository is a complete submission for the assignment:
1.  [cite_start]**Design and Provision of a Multi-Server Django-PostgreSQL Application on AWS using Terraform and Ansible** [cite: 3-6]
2.  [cite_start]**Automation of Container Orchestration and CI/CD Deployment using Docker Swarm, Docker Compose, and GitHub Actions/Jenkins** [cite: 7-8]

**Repository for submission:** `sanjana-DevOpsAssign12`

[cite_start]This package contains the infrastructure-as-code (Terraform), configuration management (Ansible), container definitions (Docker), and a full functional Django app (login/register/home/logout) wired to a login table in PostgreSQL [cite: 13, 16-25, 30].

---

## Layout

sanjana-DevOpsAssign12/ ├─ terraform/ │ ├─ main.tf │ ├─ provider.tf │ └─ outputs.tf ├─ ansible/ │ ├─ inventory.ini │ ├─ install-docker.yml │ └─ swarm-init.yml ├─ docker/ │ ├─ Dockerfile │ └─ docker-compose.yml ├─ django_app/ │ ├─ manage.py │ ├─ requirements.txt │ ├─ main_project/ │ └─ user_auth/ ├─ scripts/ │ └─ bootstrap.sh ├─ .github/ (or ci/) │ └─ workflows/ │ └─ deploy.yml └─ selenium/ └─ (test_scripts.py)


---

## Notes

* The Django app is functional and can be tested.
* The Terraform and Ansible files are designed to provision the infrastructure on AWS as specified in the assignment.
* Placeholders (like AWS AMIs, secrets) must be replaced before attempting a real deployment.
* **Do not commit real secrets** or AWS keys to the repository. Use GitHub Actions Secrets.

---

## Quick Local Run (Using Docker Compose)

This command lets you test the Django application *locally* without deploying to AWS.

1.  Install Docker & Docker Compose.
2.  From the repository root folder, run:
    ```bash
    docker compose -f docker/docker-compose.yml up --build
    ```
3.  Access the app on `http://localhost:80` after the containers are up.
4.  You can register a new user and then log in.
