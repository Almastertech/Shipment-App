# Pull-to-Refresh Contract

This template standardizes refresh behavior for list screens:

1. Do not run refresh while an initial load is in progress.
2. Do not run refresh while `loadMore` is in progress.
3. If cached content exists, keep UI responsive and allow stale-while-revalidate updates.
4. On refresh failure, preserve existing content and surface a friendly status.
5. Refresh must not reset pagination cursor incorrectly when load-more is active.

Use `PullToRefreshContract.run(...)` before invoking view-model refresh logic.
