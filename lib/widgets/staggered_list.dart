import 'package:flutter/material.dart';

class StaggeredListAnimation extends StatefulWidget {
  const StaggeredListAnimation({super.key, required this.items});

  final List<String> items;
  @override
  State<StaggeredListAnimation> createState() => _StaggeredListAnimationState();
}

class _StaggeredListAnimationState extends State<StaggeredListAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        // Each item animates during its portion of the timeline
        final startInterval = index / widget.items.length;
        final endInterval = (index + 1) / widget.items.length;

        final animation =
            Tween<Offset>(
              begin: Offset(1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  startInterval,
                  endInterval,
                  curve: Curves.easeOutCubic,
                ),
              ),
            );

        return SlideTransition(
          position: animation,
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _controller,
              curve: Interval(startInterval, endInterval),
            ),
            child: ListTile(title: Text(widget.items[index])),
          ),
        );
      },
    );
  }
}
