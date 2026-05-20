#ddev-generated
ARG PLAYWRIGHT_VERSION=v1.60.0
FROM mcr.microsoft.com/playwright:${PLAYWRIGHT_VERSION}-noble

ARG PLAYWRIGHT_MCP_VERSION=latest

RUN npm install -g @playwright/mcp@${PLAYWRIGHT_MCP_VERSION} && \
    npx @playwright/mcp install-browser chrome-for-testing

WORKDIR /e2e

HEALTHCHECK --interval=5s --timeout=3s --retries=20 --start-period=15s \
  CMD bash -c 'echo > /dev/tcp/localhost/3301' 2>/dev/null

CMD bash -c "\
  npx playwright run-server --port 3000 --host 0.0.0.0 --path /ddev-pw-token & \
  npx @playwright/mcp --port 3301 --host 0.0.0.0 --allowed-hosts '*' --ignore-https-errors --headless --browser chromium & \
  wait -n"
