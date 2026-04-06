class WorkflowStep {
  const WorkflowStep({required this.title, required this.body});
  final String title;
  final String body;
}

abstract final class WorkflowCopy {
  static const subtitle =
      'A clear, managed process from first contact to final delivery.';

  static const steps = <WorkflowStep>[
    WorkflowStep(
      title: '1. Discovery & brief',
      body:
          'We align on goals, audience, and deliverables. You receive a clear scope and timeline.',
    ),
    WorkflowStep(
      title: '2. Pre-production',
      body:
          'Scripting, storyboards, locations, and crew planning — everything before the shoot.',
    ),
    WorkflowStep(
      title: '3. Production',
      body:
          'Filming days managed end-to-end with professional crew and equipment.',
    ),
    WorkflowStep(
      title: '4. Post-production',
      body:
          'Edit, colour, sound, and graphics — with structured review rounds.',
    ),
    WorkflowStep(
      title: '5. Delivery',
      body:
          'Final masters in agreed formats plus archive handoff when required.',
    ),
  ];
}
