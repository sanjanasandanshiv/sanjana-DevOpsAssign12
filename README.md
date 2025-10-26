# sanjana-DevOpsAssign12

This repository is a complete submission for the assignment:
1.  [cite_start]**Design and Provision of a Multi-Server Django-PostgreSQL Application on AWS using Terraform and Ansible** [cite: 3-6]
2.  [cite_start]**Automation of Container Orchestration and CI/CD Deployment using Docker Swarm, Docker Compose, and GitHub Actions/Jenkins** [cite: 7-8]

**Repository for submission:** `sanjana-DevOpsAssign12`

[cite_start]This package contains the infrastructure-as-code (Terraform), configuration management (Ansible), container definitions (Docker), and a full functional Django app (login/register/home/logout) wired to a login table in PostgreSQL [cite: 13, 16-25, 30].

---

## Layout

sanjana-DevOpsAssign12/
├── .gitignore               # Excludes venv/, staticfiles_collected/, .terraform/
├── README.md                # Submission overview and instructions
├── ansible/
[cite_start]│   ├── install-docker.yml   # Installs Docker/Docker Compose prerequisites [cite: 53-56]
[cite_start]│   ├── swarm-init.yml       # Initializes Swarm Manager and joins Worker(s) [cite: 57]
[cite_start]│   └── inventory.ini        # References EIPs of Manager/Worker nodes [cite: 59]
├── ci/
[cite_start]│   └── deploy.yml           # GitHub Actions YAML file for CI/CD pipeline [cite: 117]
├── docker/
[cite_start]│   ├── Dockerfile           # Builds the Django Web application image [cite: 62]
[cite_start]│   └── docker-compose.yml   # Defines web (2 replicas) and db (PostgreSQL) services for Swarm [cite: 67-68]
├── django_app/
│   ├── manage.py
│   ├── requirements.txt
│   ├── main_project/        # Django project settings
[cite_start]│   └── user_auth/           # Django app: login, register, home, logout logic [cite: 17-25]
├── scripts/
[cite_start]│   └── bootstrap.sh         # Single script to run Terraform and Ansible [cite: 82-90]
[cite_start]├── selenium/                # Placeholder for Selenium test scripts [cite: 118]
└── terraform/
    [cite_start]├── main.tf              # Defines EC2 instances (t2.micro), Security Group, and EIPs [cite: 34, 44, 46]
    ├── provider.tf          # AWS provider configuration
    [cite_start]└── outputs.tf           # Outputs the public IP addresses [cite: 47]

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