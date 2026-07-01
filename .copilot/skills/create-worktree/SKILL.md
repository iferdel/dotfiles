---
name: create-worktree
description: Create a git worktree and branch in an adjacent {project}-worktrees folder. Use when asked to create a worktree; the user supplies the new branch name.
---

Follow these steps to create a git worktree. Take the new branch name from the
user's prompt (ask for it if they didn't provide one).

1. Get the current project's folder name.

2. Create a folder adjacent to the current project's folder and name it
   `{current project folder name}-worktrees`. For example, if the current
   project folder is named `myapp`, create a folder called `myapp-worktrees`.
   Both `myapp` and `myapp-worktrees` should have the same parent folder.

3. Create a git worktree and branch (named as the user specified) from the main
   project folder and save it inside the `{current project folder name}-worktrees`
   folder that was created.

4. `cd` into the new worktree folder.
