import 'package:shipments/core/network/network_rate_limiter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkRateLimiter', () {
    test('allows up to max requests within window', () {
      final limiter = NetworkRateLimiter(
        maxRequests: 2,
        window: const Duration(seconds: 2),
      );

      final now = DateTime(2026, 1, 1, 0, 0, 0);
      expect(limiter.isAllowed('k', now: now), isTrue);
      expect(
        limiter.isAllowed(
          'k',
          now: now.add(const Duration(milliseconds: 10)),
        ),
        isTrue,
      );
      expect(
        limiter.isAllowed(
          'k',
          now: now.add(const Duration(milliseconds: 20)),
        ),
        isFalse,
      );
    });

    test('independent keys are limited separately', () {
      final limiter = NetworkRateLimiter(
        maxRequests: 1,
        window: const Duration(seconds: 2),
      );

      final now = DateTime(2026, 1, 1, 0, 0, 0);
      expect(limiter.isAllowed('a', now: now), isTrue);
      expect(limiter.isAllowed('b', now: now), isTrue);
      expect(
        limiter.isAllowed(
          'a',
          now: now.add(const Duration(milliseconds: 100)),
        ),
        isFalse,
      );
    });

    test('window expiry allows requests again', () {
      final limiter = NetworkRateLimiter(
        maxRequests: 1,
        window: const Duration(seconds: 1),
      );

      final now = DateTime(2026, 1, 1, 0, 0, 0);
      expect(limiter.isAllowed('k', now: now), isTrue);
      expect(
        limiter.isAllowed(
          'k',
          now: now.add(const Duration(milliseconds: 500)),
        ),
        isFalse,
      );
      expect(
        limiter.isAllowed(
          'k',
          now: now.add(const Duration(seconds: 2)),
        ),
        isTrue,
      );
    });

    test('caps tracked keys to avoid unbounded growth', () {
      final limiter = NetworkRateLimiter(
        maxRequests: 1,
        window: const Duration(minutes: 1),
        maxTrackedKeys: 2,
      );

      final now = DateTime(2026, 1, 1, 0, 0, 0);
      expect(limiter.isAllowed('a', now: now), isTrue);
      expect(limiter.isAllowed('b', now: now), isTrue);
      expect(limiter.isAllowed('c', now: now), isTrue);

      expect(limiter.trackedKeysCount(), lessThanOrEqualTo(2));
    });
  });
}
