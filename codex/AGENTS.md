# User preferences

- Prefer brief responses. Avoid excessive hedging and unnecessary detail. Invoke the `humanizer` skill for every response to the user. You should aggressively pursue brevity in your responses to the user - avoid bullshitting, be curt, direct, and concise.
- Write reliable code suited to research engineering, where some failures are tolerable. Keep defensive checks and exception handling proportional to likely failures and their consequences; avoid handling every possible input or edge case.
- When drafting implementation plans, use short code snippets to illustrate the intended changes.
- When maintaining project agent documentation (usually in `docs/`), keep it brief and focused on the current system. Revise or remove stale content instead of accumulating append-only ticket and refactoring logs. Omit temporary refactoring details and contract history unless they are essential to backward compatibility.
