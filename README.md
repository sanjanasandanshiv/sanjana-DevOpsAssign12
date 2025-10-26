# sanjana-IT736-DevOpsAssign12

This repository is a complete submission for the assignment:
1.  [cite_start]**Design and Provision of a Multi-Server Django-PostgreSQL Application on AWS using Terraform and Ansible** [cite: 3-6]
2.  [cite_start]**Automation of Container Orchestration and CI/CD Deployment using Docker Swarm, Docker Compose, and GitHub Actions/Jenkins** [cite: 7-8]

**Repository for submission:** `sanjana-DevOpsAssign12`

[cite_start]This package contains the infrastructure-as-code (Terraform), configuration management (Ansible), container definitions (Docker), and a full functional Django app (login/register/home/logout) wired to a login table in PostgreSQL [cite: 13, 16-25, 30].

sanjana-DevOpsAssign12/
├── .gitignore               # Excludes venv/, staticfiles_collected/, .terraform/
├── README.md                # Submission overview and instructions
├── ansible/
│   ├── install-docker.yml   # Installs Docker/Docker Compose prerequisites
│   ├── swarm-init.yml       # Initializes Swarm Manager and joins Worker(s)
│   └── inventory.ini        # References EIPs of Manager/Worker nodes
├── ci/
│   └── deploy.yml           # GitHub Actions YAML file for CI/CD pipeline
├── docker/
│   ├── Dockerfile           # Builds the Django Web application image
│   └── docker-compose.yml   # Defines web (2 replicas) and db (PostgreSQL) services for Swarm
├── django_app/
│   ├── manage.py
│   ├── requirements.txt
│   ├── main_project/        # Django project settings
│   └── user_auth/           # Django app: login, register, home, logout logic
├── scripts/
│   └── bootstrap.sh         # Single script to run Terraform and Ansible
├── selenium/                # Placeholder for Selenium test scripts
└── terraform/
    ├── main.tf              # Defines EC2 instances (t2.micro), Security Group, and EIPs
    ├── provider.tf          # AWS provider configuration
    └── outputs.tf           # Outputs the public IP addresses

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

## Notes

* The Django app is functional and can be tested.
* The Terraform and Ansible files are designed to provision the infrastructure on AWS as specified in the assignment.
* Placeholders (like AWS AMIs, secrets) must be replaced before attempting a real deployment.
* **Do not commit real secrets** or AWS keys to the repository. Use GitHub Actions Secrets.