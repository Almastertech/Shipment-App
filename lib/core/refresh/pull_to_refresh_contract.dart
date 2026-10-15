enum PullToRefreshSkipReason {
  initialLoading,
  loadingMore,
}

class PullToRefreshDecision {
  const PullToRefreshDecision._({
    required this.shouldRun,
    this.skipReason,
  });

  const PullToRefreshDecision.run() : this._(shouldRun: true);

  const PullToRefreshDecision.skip(PullToRefreshSkipReason reason)
      : this._(
          shouldRun: false,
          skipReason: reason,
        );

  final bool shouldRun;
  final PullToRefreshSkipReason? skipReason;
}

class PullToRefreshContract {
  static PullToRefreshDecision evaluate({
    required bool isInitialLoading,
    required bool isLoadingMore,
  }) {
    if (isInitialLoading) {
      return const PullToRefreshDecision.skip(
        PullToRefreshSkipReason.initialLoading,
      );
    }

    if (isLoadingMore) {
      return const PullToRefreshDecision.skip(
        PullToRefreshSkipReason.loadingMore,
      );
    }

    return const PullToRefreshDecision.run();
  }

  static Future<PullToRefreshDecision> run({
    required bool isInitialLoading,
    required bool isLoadingMore,
    required Future<void> Function() refreshAction,
  }) async {
    final decision = evaluate(
      isInitialLoading: isInitialLoading,
      isLoadingMore: isLoadingMore,
    );

    if (!decision.shouldRun) {
      return decision;
    }

    await refreshAction();
    return decision;
  }
}
