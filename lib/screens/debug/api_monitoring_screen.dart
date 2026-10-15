import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/monitoring/api_request_metric.dart';
import '../../core/monitoring/in_memory_api_monitoring_service.dart';
import '../../l10n/app_localizations.dart';

class ApiMonitoringScreen extends StatelessWidget {
  const ApiMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<InMemoryApiMonitoringService>(
      builder: (context, monitor, _) {
        final recent = monitor.recent(limit: 20);
        final slowest = monitor.slowest(limit: 10);
        final failed = monitor.failed(limit: 10);

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.apiMonitorTitle),
            actions: <Widget>[
              IconButton(
                onPressed: monitor.clear,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              _MetricSection(
                title: l10n.apiMonitorRecentRequests,
                emptyLabel: l10n.apiMonitorNoRecords,
                items: recent,
              ),
              const SizedBox(height: 16),
              _MetricSection(
                title: l10n.apiMonitorSlowestRequests,
                emptyLabel: l10n.apiMonitorNoRecords,
                items: slowest,
              ),
              const SizedBox(height: 16),
              _MetricSection(
                title: l10n.apiMonitorFailedRequests,
                emptyLabel: l10n.apiMonitorNoRecords,
                items: failed,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MetricSection extends StatelessWidget {
  const _MetricSection({
    required this.title,
    required this.emptyLabel,
    required this.items,
  });

  final String title;
  final String emptyLabel;
  final List<ApiRequestMetric> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (items.isEmpty)
              Text(emptyLabel)
            else
              ...items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '${item.method} ${item.path} '
                    '| ${item.statusCode ?? '-'} '
                    '| ${item.duration.inMilliseconds}ms '
                    '${item.isSuccess ? '' : '| ${item.errorType ?? 'error'}'}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
