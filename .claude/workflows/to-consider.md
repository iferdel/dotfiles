We recommend using the word "think" to trigger extended thinking mode
 "think" < "think hard" < "think harder" < "ultrathink." Each level allocates progressively more thinking budget for Claude to use.

 example of workflow
 - Ask Claude to read relevant files, images, or URLs,
 - Ask Claude to make a plan for how to approach a specific problem
 - Ask Claude to implement its solution in code.
 - Ask Claude to commit the result and create a pull request.
 Steps #1-#2 are crucial—without them, Claude tends to jump straight to coding a solution.


another example:
- Ask Claude to write tests based on expected input/output pairs. 
- Tell Claude to run the tests and confirm they fail. 
- Ask Claude to commit the tests 
- Ask Claude to write code that passes the tests, 
- Ask Claude to commit the code 

Claude performs best when it has a clear target to iterate against—a visual mock, a test case, or another kind of output. By providing expected outputs like tests, Claude can make changes, evaluate results, and incrementally improve until it succeeds.




another workflow

Write code, screenshot result, iterate
    Give Claude a way to take browser screenshots (e.g., with the Puppeteer MCP server, an iOS simulator MCP server, or manually copy / paste screenshots into Claude).
    Give Claude a visual mock by copying / pasting or drag-dropping an image, or giving Claude the image file path.
    Ask Claude to implement the design in code, take screenshots of the result, and iterate until its result matches the mock.
    Ask Claude to commit when you're satisfied.




---

viualizations in particuylar (data)
“aesthetically pleasing” is a keyword


---

Give Claude images

Claude excels with images and diagrams through several methods:

    Paste screenshots (pro tip: hit cmd+ctrl+shift+4 in macOS to screenshot to clipboard and ctrl+v to paste. Note that this is not cmd+v like you would usually use to paste on mac and does not work remotely.)
    Drag and drop images directly into the prompt input
    Provide file paths for images

This is particularly useful when working with design mocks as reference points for UI development, and visual charts for analysis and debugging. If you are not adding visuals to context, it can still be helpful to be clear with Claude about how important it is for the result to be visually appealing.


 Give Claude URLs

Paste specific URLs alongside your prompts for Claude to fetch and read. To avoid permission prompts for the same domains (e.g., docs.foo.com), use /permissions to add domains to your allowlist.


Use checklists and scratchpads for complex workflows


 Pass data into Claude

Several methods exist for providing data to Claude:

    Copy and paste directly into your prompt (most common approach)
    Pipe into Claude Code (e.g., cat foo.txt | claude), particularly useful for logs, CSVs, and large data
    Tell Claude to pull data via bash commands, MCP tools, or custom slash commands
    Ask Claude to read files or fetch URLs (works for images too)

Most sessions involve a combination of these approaches. For example, you can pipe in a log file, then tell Claude to use a tool to pull in additional context to debug the logs.
