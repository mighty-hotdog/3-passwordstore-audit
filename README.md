
# PasswordStore

This is my 1st learning audit conducted on a mock smart contract application `Password Store`. This app allows a user to store a private password and retrieve it later. The user may also set a new password. The password is protected from access by other users who are not able to access it.

# Final Audit Report

The final audit report [20240624 PasswordStoreApp Code Review Report](https://github.com/mighty-hotdog/3-passwordstore-audit/tree/audit) is located in the `audit-data` folder.

- [PasswordStore](#passwordstore)
- [Final Audit Report](#final-audit-report)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Git](#git)
  - [Quickstart](#quickstart)
- [Usage](#usage)
  - [Deploy (local)](#deploy-local)
  - [Testing](#testing)
    - [Test Coverage](#test-coverage)
- [Audit Scope Details](#audit-scope-details)
  - [Create the audit report](#create-the-audit-report)

# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`

## Git

There are 2 branches. The `main` branch contains the onboarded client material. The `audit` branch contains the audit stuff and final report.

The libraries listed in this repo are irrelevant. They are not needed in the codebase.

## Quickstart

This is my 1st learning code audit. On a mock app. 

You don't want to clone this.

# Usage

## Deploy (local)

1. Start a local node

```
make anvil
```

2. Deploy

This will default to your local node. You need to have it running in another terminal in order for it to deploy.

```
make deploy
```

## Testing

```
forge test
```

### Test Coverage

```
forge coverage
```

and for coverage based testing: 

```
forge coverage --report debug
```

# Audit Scope Details

- Commit Hash:  2e8f81e263b3a9d18fab4fb5c46805ffc10a9990
- In Scope:
```
./src/
└── PasswordStore.sol
```
- Solc Version: 0.8.18
- Chain(s) to deploy contract to: Ethereum

## Create the audit report

View the [audit-report-templating](https://github.com/Cyfrin/audit-report-templating) repo for details on how to generate the audit report.

```bash
cd report-cooking
pandoc report-work-in-progress.md -o 'Protocol Review Report.pdf' --from markdown --template=eisvogel --listings
```