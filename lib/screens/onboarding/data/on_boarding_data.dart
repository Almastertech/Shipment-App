class OnboardingPageData {
  const OnboardingPageData({
    required this.imagePath,
    required this.title,
  });

  final String imagePath;
  final OnboardingTitle title;
}

enum OnboardingTitle { protection, tracking, claim }
