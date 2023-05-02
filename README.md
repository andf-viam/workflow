Automate your git-based docs-as-code workflow (like at Viam). For best results, place in $PATH!

# Core Workflow Tools
Use these tools to set up, check out, and commit your work:

## workflow
Clones your fork into a new local directory in your defined docs $WORKSPACE, checks out a new branch, sets it up for work, then opens a new VS Code workspace from that directory.

_Usage:_ workflow DOCS-1234-fix-typo-in-example from anywhere on your machine.

## push
Collects all your changes together under a commit, and creates a new - or updates an existing - PR. Pass the `-f` flag to force push an empty commit to trigger a site rebuild (or as an override in situations where a normal push fails).

_Usage:_ push from within the git repo you wish to push, best used within the VSCode terminal.

# Maintenance Workflow Tools
Use these tools periodically to maintain your work environment:

## rebasefork
Updates your forked copy of docs with the latest from upstream. `workflow` automatically fetches the latest state of upstream's `main` branch each run, so `rebasefork` only serves to save us time on `workflow`'s initial clone & rebase step. You can optionally use the `-f` flag to completely reset your fork to match current upstream exactly: doing so discards any fork-specific commits!

## cleanspace
Clean up any staging builds from all local git repos in $WORKSPACE.

# Example workflow usage, using these tools:

1. `workflow DOCS-1234-fix-typo-in-example`

1. In resulting VSCode window, edit appropriate Markdown files to address concerns raised in Jira ticket.

1. `push` when you are ready to commit & push your changes for review. Supply a commit message for your first commit, when prompted. In this workflow, all subsequent pushes are applied as `commit --amend`.

1. Proceed through the usual review process in GitHub. If changes are proposed, repeat steps 2 and 3 as needed.

1. Once LGTM, squash & merge

Occassionally, run `rebasefork` and `cleanspace`.
