enum ProjectTypeKind { videoProduction, postProduction, photography }

enum DurationKind { oneDay, twoToThreeDays, oneWeekPlus }

extension ProjectTypeKindX on ProjectTypeKind {
  String get apiName => switch (this) {
        ProjectTypeKind.videoProduction => 'video_production',
        ProjectTypeKind.postProduction => 'post_production',
        ProjectTypeKind.photography => 'photography',
      };

  static ProjectTypeKind fromQuery(String? q) {
    switch (q) {
      case 'post_production':
        return ProjectTypeKind.postProduction;
      case 'photography':
        return ProjectTypeKind.photography;
      default:
        return ProjectTypeKind.videoProduction;
    }
  }
}

extension DurationKindX on DurationKind {
  String get apiName => switch (this) {
        DurationKind.oneDay => 'one_day',
        DurationKind.twoToThreeDays => 'two_to_three_days',
        DurationKind.oneWeekPlus => 'one_week_plus',
      };

  static DurationKind fromQuery(String? q) {
    switch (q) {
      case 'one_day':
        return DurationKind.oneDay;
      case 'one_week_plus':
        return DurationKind.oneWeekPlus;
      default:
        return DurationKind.twoToThreeDays;
    }
  }
}
