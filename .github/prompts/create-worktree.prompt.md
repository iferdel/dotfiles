---
mode: agent
description: Create a git worktree and branch in an adjacent {project}-worktrees folder.
---

Follow these steps to create a git worktree. The branch name is: ${input:branchName:new branch name}

1. Get the current project's folder name.

2. Create a folder adjacent to the current project's folder and name it {current project folder name}-worktrees. For example, if the current project folder is named myapp, create a folder called myapp-worktrees. Both myapp and myapp-worktrees should have the same parent folder.

3. Create a git worktree and branch named ${input:branchName} from the main project folder and save it inside the {current project folder name}-worktrees folder that was created.

4. cd into the new ${input:branchName} worktree folder.
