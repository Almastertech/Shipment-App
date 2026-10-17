import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/screens/onboarding/data/on_boarding_data.dart';
import 'package:shipments/screens/onboarding/widgets/on_boarding_page.dart';
import 'package:shipments/screens/onboarding/widgets/on_boarding_progress.dart';

import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../core/storage/local_storage.dart';
import '../../core/utils/app_constants.dart';
import '../../injection.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const List<OnboardingPageData> _pages = <OnboardingPageData>[
    OnboardingPageData(
      imagePath: 'png/onboarding1.png',
      title: OnboardingTitle.protection,
    ),
    OnboardingPageData(
      imagePath: 'png/onboarding2.png',
      title: OnboardingTitle.tracking,
    ),
    OnboardingPageData(
      imagePath: 'png/onboarding3.png',
      title: OnboardingTitle.claim,
    ),
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isCompleting = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showNextPage() {
    if (_currentPage == _pages.length - 1) {
      _completeOnboarding();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _completeOnboarding() async {
    if (_isCompleting) return;
    setState(() => _isCompleting = true);

    await getIt<LocalStorage>().setBool(
      AppConstants.onboardingCompletedStorageKey,
      true,
    );
    if (!mounted) return;

    context.go(AppRoutes.loginMethod);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (page) => setState(() => _currentPage = page),
            itemBuilder: (context, index) {
              return OnboardingPage(
                page: _pages[index],
                isLastPage: index == _pages.length - 1,
                onNext: _showNextPage,
                onSkip: _completeOnboarding,
              );
            },
          ),
          PositionedDirectional(
            top: 0,
            start: AppSpacing.tokenL,
            end: AppSpacing.tokenL,
            child: IgnorePointer(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.tokenM),
                  child: OnboardingProgress(
                    pageCount: _pages.length,
                    currentPage: _currentPage,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
