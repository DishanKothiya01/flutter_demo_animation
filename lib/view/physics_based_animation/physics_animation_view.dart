import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/physics.dart';

class PhysicsAnimationView extends StatefulWidget {
  const PhysicsAnimationView({super.key});

  @override
  State<PhysicsAnimationView> createState() => _PhysicsAnimationViewState();
}

class _PhysicsAnimationViewState extends State<PhysicsAnimationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  Offset _dragOffset = Offset.zero;
  Offset _startOffset = Offset.zero;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController.unbounded(vsync: this);
    _controller.addListener(() {
      setState(() {
        _dragOffset = _animation.value;
      });
    });
  }

  void _runSpringAnimation(Offset velocity) {
    final spring = SpringDescription(
      mass: 1,
      stiffness: 500,
      damping: 15,
    );

    final simulationX = SpringSimulation(
      spring,
      _dragOffset.dx,
      0,
      velocity.dx,
    );

    final simulationY = SpringSimulation(
      spring,
      _dragOffset.dy,
      0,
      velocity.dy,
    );

    _animation = _controller.drive(
      Tween<Offset>(
        begin: _dragOffset,
        end: Offset.zero,
      ),
    );

    _controller.animateWith(_CombinedSpringSimulation(simulationX, simulationY));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Physics-Based Animation")),
      body: GestureDetector(
        onPanStart: (details) {
          _controller.stop();
          _startOffset = details.localPosition;
        },
        onPanUpdate: (details) {
          setState(() {
            _dragOffset += details.delta;
          });
        },
        onPanEnd: (details) {
          _runSpringAnimation(details.velocity.pixelsPerSecond);
        },
        child: Stack(
          children: [
            Center(
              child: Transform.translate(
                offset: _dragOffset,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Combine X and Y simulation for 2D spring behavior
class _CombinedSpringSimulation extends Simulation {
  final SpringSimulation _simX;
  final SpringSimulation _simY;

  _CombinedSpringSimulation(this._simX, this._simY);

  @override
  double x(double time) => Offset(_simX.x(time), _simY.x(time)).distance;

  @override
  double dx(double time) => Offset(_simX.dx(time), _simY.dx(time)).distance;

  @override
  bool isDone(double time) => _simX.isDone(time) && _simY.isDone(time);
}
