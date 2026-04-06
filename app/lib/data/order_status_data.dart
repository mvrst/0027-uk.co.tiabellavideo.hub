class Milestone {
  const Milestone({required this.label, required this.done, this.highlight = false});
  final String label;
  final bool done;
  final bool highlight;
}

/// Static sample order — honest local data only (docs/app_contract.md §7).
abstract final class OrderStatusData {
  static const projectTitle = 'Corporate Brand Video';
  static const reference = 'TPH-2024-0112';
  static const progressLabel = '65% Complete';

  static const milestones = <Milestone>[
    Milestone(label: 'Brief approved', done: true),
    Milestone(label: 'Script & storyboard', done: true),
    Milestone(label: 'Filming', done: true),
    Milestone(label: 'First cut review', done: false, highlight: true),
    Milestone(label: 'Final delivery', done: false),
  ];
}
