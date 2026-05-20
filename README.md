# ddev-claude-code-dbhub-playwright <!-- omit in toc -->

> Opinionated fork of [ddev-claude-code](https://github.com/FreelyGive/ddev-claude-code),
> extending it with DBHub (database MCP) and Playwright (browser MCP) services.

## Claude Code

Claude Code runs inside the DDEV web container and is accessible using
`ddev claude`. Running inside the container gives Claude direct access to
all project files, services (database, cache, etc.), and `ddev` commands —
no host credentials or tunnelling needed.

Configuration is stored in `.ddev/.claude.json` and `.ddev/.claude/`, and
persisted across restarts. You can drop in an existing `.ddev/.claude.json`
to reuse an API key or pre-approved tool list.

The host's `~/.claude/` and `~/.claude.json` are also mounted into the
container, so global Claude settings and credentials are available automatically.

To let Claude interact with GitLab, authenticate `glab` once with
`ddev glab auth login`. Configuration is stored in `.ddev/.glab-cli/` and
persisted across restarts.

## DBHub

[DBHub](https://github.com/bytebase/dbhub) is an MCP server that gives Claude
direct access to the project's MariaDB instance (`db:3306`). It also exposes
an optional database management UI at:

```
https://dbhub.<sitename>.<tld>
```

To disable it, remove or rename `docker-compose.dbhub.yaml` in your `.ddev/`
directory.

## Playwright (MCP)

A Playwright service is included, running a headless Chromium browser with
both a WebSocket automation server (port 3000) and a
[Playwright MCP](https://github.com/microsoft/playwright-mcp) HTTP server
(port 3301). This lets Claude Code control a browser directly.

To enable the MCP integration, add the following to your project's `.mcp.json`
(create it at the project root if it doesn't exist):

```json
{
  "mcpServers": {
    "playwright": {
      "type": "http",
      "url": "http://playwright:3301/mcp"
    }
  }
}
```

The service is reachable from inside the DDEV web container only. If you need
host access, add a `ports:` entry to `docker-compose.playwright.yaml` — but
note this will conflict if multiple DDEV projects run the service simultaneously.

