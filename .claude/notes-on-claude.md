    Do: Use short, declarative bullet points.
    Don't: Write long, narrative paragraphs.
    Do: Trim redundancy. If a folder is named components, you don't need to explain that it contains components.
    Don't: Include commentary or nice-to-have information. Only include rules Claude needs to know to do the work.




    Common bash commands
    Core files and utility functions
    Code style guidelines
    Testing instructions
    Repository etiquette (e.g., branch naming, merge vs. rebase, etc.)
    Developer environment setup (e.g., pyenv use, which compilers work)
    Any unexpected behaviors or warnings particular to the project
    Other information you want Claude to remember

    e.g. adding emphasis with "IMPORTANT" or "YOU MUST") to improve adherence.

Document frequently used tools in CLAUDE.md

b. Use Claude with MCP

Claude Code functions as both an MCP server and client. As a client, it can connect to any number of MCP servers to access their tools in three ways:

    In project config (available when running Claude Code in that directory)
    In global config (available in all projects)
    In a checked-in .mcp.json file (available to anyone working in your codebase). For example, you can add Puppeteer and Sentry servers to your .mcp.json, so that every engineer working on your repo can use these out of the box.

When working with MCP, it can also be helpful to launch Claude with the --mcp-debug flag to help identify configuration issues.


    Tech Stack: A declaration of your project's tools and versions (e.g., Astro 4.5, Tailwind CSS 3.4, TypeScript 5.3).





    Project Structure: An outline of key directories and their roles (e.g., src/components for reusable UI elements, src/lib for core business logic).
    Commands: A list of the most important npm, bash, or other scripts for building, testing, linting, and deploying your project. This prevents the AI from guessing commands and failing.
    Code Style & Conventions: Explicit guidelines on formatting, naming conventions, import/export syntax, and other stylistic rules. For example: "Destructure imports when possible (e.g., import { foo } from 'bar')."
    Repository Etiquette: Instructions on branch naming (feature/TICKET-123-description), commit message formats, and whether to merge or rebase.
    Core Files & Utilities: Pointers to essential files, such as a central api.ts or a utils.js full of helper functions, that the AI should be aware of.
    The "Do Not Touch" List: A critical section specifying things the AI should avoid, such as rewriting working legacy code, modifying configuration files, or skipping accessibility checks.
