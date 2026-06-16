---
title: Git Basics
video: 
---


##  Version Control System
A version control system, or VCS, tracks the history of changes as people and teams collaborate on projects together. As developers make changes to the project, any earlier version of the project can be recovered at any time.

Developers can review project history to find out:
- Which changes were made?
- Who made the changes?
- When were the changes made?
- Why were changes needed?

VCSs give each contributor a unified and consistent view of a project, surfacing work that's already in progress. Seeing a transparent history of changes, who made them, and how they contribute to the development of a project helps team members stay aligned while working independently.

In a distributed version control system, every developer has a full copy of the project and project history. Unlike once popular centralized version control systems, Distributed Version Control Systems (DVCSs) don't need a constant connection to a central repository. Git is the most popular distributed version control system. Git is commonly used for both open source and commercial software development, with significant benefits for individuals, teams, and businesses.

Git lets developers see the entire timeline of their changes, decisions, and progression of any project in one place. From the moment they access the history of a project, the developer has all the context they need to understand it and start contributing.

Developers work in every time zone. With a DVCS like Git, collaboration can happen any time while maintaining source code integrity. Using branches, developers can safely propose changes to production code.

Businesses using Git can break down communication barriers between teams and keep them focused on doing their best work. Plus, Git makes it possible to align experts across a business to collaborate on major projects.

## About repositories
A repository, or Git project, encompasses the entire collection of files and folders associated with a project, along with each file's revision history. The file history appears as snapshots in time called commits. The commits can be organized into multiple lines of development called branches. Because Git is a DVCS, repositories are self-contained units and anyone who has a copy of the repository can access the entire codebase and its history. Using the command line or other ease-of-use interfaces, a Git repository also allows for: interaction with the history, cloning the repository, creating branches, committing, merging, comparing changes across versions of code, and more.

Through platforms like GitHub, Git also provides more opportunities for project transparency and collaboration. Public repositories help teams work together to build the best possible final product.

## How GitHub works
GitHub hosts Git repositories and provides developers with tools to ship better code through command line features, issues (threaded discussions), pull requests, code review, or the use of a collection of free and for-purchase apps in the GitHub Marketplace. With collaboration layers like the GitHub flow, a community of 100 million developers, and an ecosystem with hundreds of integrations, GitHub changes the way software is built.

GitHub builds collaboration directly into the development process. Work is organized into repositories where developers can outline requirements or direction and set expectations for team members. Then, using the GitHub flow, developers simply create a branch to work on updates, commit changes to save them, open a pull request to propose and discuss changes, and merge pull requests once everyone is on the same page. For more information, see GitHub flow.

## Git Getting Started

### Git Install
You can download Git for free from the following website: [https://www.git-scm.com/](https://www.git-scm.com/)

### Using Git with Command Line
To start using Git, open your Command shell.

For Windows, you can use Git Bash, which comes included in Git for Windows. For Mac and Linux, you can use the built-in terminal.

First, check if Git is properly installed:

```bash
   git --version
```

Example output:
```bash
   git version 2.30.2.windows.1
```

If Git is installed, it should show something like `git version X.Y`.

### Configure Git
Let Git know who you are. Type the commands in your CLI. This is important for version control systems, as each Git commit uses this information:

```bash
git config --global user.name "your-username"
git config --global user.email "your-email@example.com"
```

Change the username and email address to your own. Use `--global` to set the username and email for every repository on your computer. If you want to set the username/email for just the current repo, remove `--global`.

### Creating Git Folder
Create a new folder for your project:

```bash
mkdir myproject
cd myproject
```

`mkdir` makes a new directory. `cd` changes the current working directory.

Now that we are in the correct directory, we can start by initializing Git!

### Initialize Git
Once you have navigated to the correct folder, initialize Git on that folder:

```bash
git init
```

Example output:
```bash
Initialized empty Git repository in /Users/user/myproject/.git/
```

You just created your first Git repository! Git now knows that it should watch the folder you initiated it on. Git creates a hidden folder to keep track of changes.

## Creating a Repository on GitHub:
**Go to [GitHub](https://github.com) and sign in or sign up to create an account.**

**Click on the “New repository” button.**

**Fill in the repository name, description, and choose whether it should be public or private.**

**Click “Create repository”.**

## Connecting Local Repository to GitHub:
**Follow the instructions provided after creating the repository to push your local repository to GitHub.**



### Basic Git commands
To use Git, developers use specific commands to copy, create, change, and combine code. These commands can be executed directly from the command line or by using an application like GitHub Desktop. Here are some common commands for using Git:

- `git init` initializes a brand new Git repository and begins tracking an existing directory. It adds a hidden subfolder within the existing directory that houses the internal data structure required for version control.
- `git clone` creates a local copy of a project that already exists remotely. The clone includes all the project's files, history, and branches.
- `git add` stages a change. Git tracks changes to a developer's codebase, but it's necessary to stage and take a snapshot of the changes to include them in the project's history. This command performs staging, the first part of that two-step process. Any changes that are staged will become a part of the next snapshot and a part of the project's history. Staging and committing separately gives developers complete control over the history of their project without changing how they code and work.
- `git commit` saves the snapshot to the project history and completes the change-tracking process. In short, a commit functions like taking a photo. Anything that's been staged with `git add` will become a part of the snapshot with `git commit`.
- `git status` shows the status of changes as untracked, modified, or staged.
- `git branch` shows the branches being worked on locally.
- `git merge` merges lines of development together. This command is typically used to combine changes made on two distinct branches. For example, a developer would merge when they want to combine changes from a feature branch into the main branch for deployment.
- `git pull` updates the local line of development with updates from its remote counterpart. Developers use this command if a teammate has made commits to a branch on a remote, and they would like to reflect those changes in their local environment.
- `git push` updates the remote repository with any commits made locally to a branch.


### Example: Start a new repository and publish it to GitHub
First, you will need to create a new repository on GitHub. For more information, see Hello World. Do not initialize the repository with a README, .gitignore or License file. This empty repository will await your code.

```bash
# create a new directory, and initialize it with git-specific functions
git init my-repo

# change into the `my-repo` directory
cd my-repo

# create the first file in the project
touch README.md

# git isn't aware of the file, stage it
git add README.md

# take a snapshot of the staging area
git commit -m "add README to initial commit"

# provide the path for the repository you created on github
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY-NAME.git

# push changes to github
git push --set-upstream origin main
```

### Example: contribute to an existing branch on GitHub
This example assumes that you already have a project called repo on the machine and that a new branch has been pushed to GitHub since the last time changes were made locally.

```bash
# change into the `repo` directory
cd repo

# update all remote tracking branches, and the currently checked out branch
git pull

# change into the existing branch called `feature-a`
git checkout feature-a

# make changes, for example, edit `file1.md` using the text editor

# stage the changed file
git add file1.md

# take a snapshot of the staging area
git commit -m "edit file1"

# push changes to github
git push
```

