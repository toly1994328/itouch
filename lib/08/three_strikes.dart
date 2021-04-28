import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef GestureThreeTapCallback = void Function();

//1 相邻触点间距 小于 40 ms --- 重新追踪
//2 相邻触点大于 200 ms --- 无效三击

class ThreeTapGestureRecognizer extends GestureRecognizer {
  ThreeTapGestureRecognizer({
    Object debugOwner,
    PointerDeviceKind kind,
  }) : super(debugOwner: debugOwner, kind: kind);

  @override
  void acceptGesture(int pointer) {}

  GestureThreeTapCallback onThreeTap;
  GestureTapCancelCallback onThreeTapCancel;
  GestureTapDownCallback onThreeTapDown;

  _TapTracker _firstTap;
  _TapTracker _secondTap;
  final Map<int, _TapTracker> _trackers = <int, _TapTracker>{};

  Timer _tapTimer;

  @override
  String get debugDescription => 'three tap';

  @override
  void rejectGesture(int pointer) {
    // _TapTracker tracker = _trackers[pointer];
    // // If tracker isn't in the list, check if this is the first tap tracker
    // if (tracker == null &&
    //     _secondTap != null &&
    //     _secondTap.pointer == pointer) {
    //   tracker = _secondTap;
    // }
    //
    // // If tracker is still null, we rejected ourselves already
    // if (tracker != null) {
    //   tracker.entry.resolve(GestureDisposition.rejected);
    //   _freezeTracker(tracker);
    //   _stopDoubleTapTimer();
    //   // _reject(tracker)
    // }

    // if (tracker == null &&
    //     _secondTap != null &&
    //     _secondTap.pointer == pointer)
    //   tracker = _secondTap;
    // // If tracker is still null, we rejected ourselves already
    // if (tracker != null) _reject(tracker);
  }

  @override
  bool isPointerAllowed(PointerDownEvent event) {
    if (_firstTap == null || _secondTap == null) {
      switch (event.buttons) {
        case kPrimaryButton:
          if (onThreeTap == null ||
              onThreeTapCancel == null ||
              onThreeTapDown == null) return false;
          break;
        default:
          return false;
      }
    }
    return super.isPointerAllowed(event);
  }

  @override
  void addAllowedPointer(PointerDownEvent event) {
    if (_firstTap != null) {
      // 校验第二手势
      if (!_firstTap.isWithinGlobalTolerance(event, kDoubleTapSlop)) {
        // Ignore out-of-bounds second taps.
        return;
      } else if (!_firstTap.hasElapsedMinTime() ||
          !_firstTap.hasSameButton(event)) {
        // Restart when the second tap is too close to the first (touch screens
        // often detect touches intermittently), or when buttons mismatch.
        _reset();
        return _trackTap(event);
      } else if (_secondTap != null) {
        // 校验第三手势
        if (!_secondTap.isWithinGlobalTolerance(event, kDoubleTapSlop)) {
          // Ignore out-of-bounds second taps.
          return;
        } else if (!_secondTap.hasElapsedMinTime() ||
            !_secondTap.hasSameButton(event)) {
          // Restart when the second tap is too close to the first (touch screens
          // often detect touches intermittently), or when buttons mismatch.
          _reset();
          return _trackTap(event);
        } else if (onThreeTapDown != null) {
          final TapDownDetails details = TapDownDetails(
            globalPosition: event.position,
            localPosition: event.localPosition,
            kind: getKindForPointer(event.pointer),
          );
          invokeCallback<void>('onThreeTapDown', () => onThreeTapDown(details));
        }
      }
    }
    _trackTap(event);
  }

  void _trackTap(PointerDownEvent event) {
    _stopDoubleTapTimer();
    final _TapTracker tracker = _TapTracker(
      event: event,
      entry: GestureBinding.instance.gestureArena.add(event.pointer, this),
      doubleTapMinTime: kDoubleTapMinTime,
    );
    _trackers[event.pointer] = tracker;
    tracker.startTrackingPointer(_handleEvent, event.transform);
  }

  void _handleEvent(PointerEvent event) {
    final _TapTracker tracker = _trackers[event.pointer];
    if (event is PointerUpEvent) {

      if (_firstTap == null) {
        _registerFirstTap(tracker);
      } else if (_secondTap == null) {
        _registerSecondTap(tracker);
      } else {
        _registerThirdTap(tracker);
      }
    } else if (event is PointerMoveEvent) {
      if (!tracker.isWithinGlobalTolerance(event, kDoubleTapTouchSlop))
        _reject(tracker);
    } else if (event is PointerCancelEvent) {
      _reject(tracker);
    }
  }

  void _clearTrackers() {
    _trackers.values.toList().forEach(_reject);
    assert(_trackers.isEmpty);
  }

  void _freezeTracker(_TapTracker tracker) {
    tracker.stopTrackingPointer(_handleEvent);
  }

  void _reject(_TapTracker tracker) {
    _trackers.remove(tracker.pointer);
    tracker.entry.resolve(GestureDisposition.rejected);
    _freezeTracker(tracker);

    if (_firstTap != null) {
      if (tracker == _firstTap) {
        _reset();
      } else {
        _checkCancel();
        if (_trackers.isEmpty) _reset();
      }
    }

    if (_secondTap != null) {
      if (tracker == _secondTap) {
        _reset();
      } else {
        _checkCancel();
        if (_trackers.isEmpty) _reset();
      }
    }
  }

  void _checkCancel() {
    if (onThreeTapCancel != null)
      invokeCallback<void>('onThreeTapCancel', onThreeTapCancel);
  }

  void _startDoubleTapTimer() {
    _tapTimer ??= Timer(kDoubleTapTimeout, _reset);
  }

  void _registerFirstTap(_TapTracker tracker) {
    _startDoubleTapTimer();
    GestureBinding.instance.gestureArena.hold(tracker.pointer);
    // Note, order is important below in order for the clear -> reject logic to
    // work properly.
    _freezeTracker(tracker);
    _trackers.remove(tracker.pointer);
    _clearTrackers();
    _firstTap = tracker;
  }

  void _registerSecondTap(_TapTracker tracker) {
    _startDoubleTapTimer();
    GestureBinding.instance.gestureArena.hold(tracker.pointer);

    // Note, order is important below in order for the clear -> reject logic to
    // work properly.
    _freezeTracker(tracker);
    _trackers.remove(tracker.pointer);
    _clearTrackers();
    _secondTap = tracker;
  }

  void _registerThirdTap(_TapTracker tracker) {
    tracker.entry.resolve(GestureDisposition.accepted);
    _freezeTracker(tracker);
    _trackers.remove(tracker.pointer);
    _checkUp(tracker.initialButtons);
    _reset();
  }

  void _checkUp(int buttons) {
    assert(buttons == kPrimaryButton);
    if (onThreeTap != null) invokeCallback<void>('onThreeTap', onThreeTap);
  }

  void _reset() {
    _stopDoubleTapTimer();
    if (_firstTap != null) {
      if (_trackers.isNotEmpty) _checkCancel();
      // Note, order is important below in order for the resolve -> reject logic
      // to work properly.
      final _TapTracker tracker = _firstTap;
      _firstTap = null;

      tracker.entry.resolve(GestureDisposition.rejected);
      _freezeTracker(tracker);

      GestureBinding.instance.gestureArena.release(tracker.pointer);
    }
    if (_secondTap != null) {
      if (_trackers.isNotEmpty) _checkCancel();
      // Note, order is important below in order for the resolve -> reject logic
      // to work properly.
      final _TapTracker tracker = _secondTap;
      _secondTap = null;
      _reject(tracker);
      tracker.entry.resolve(GestureDisposition.rejected);
      _freezeTracker(tracker);
      GestureBinding.instance.gestureArena.release(tracker.pointer);
    }
    _clearTrackers();
  }

  void _stopDoubleTapTimer() {
    if (_tapTimer != null) {
      _tapTimer.cancel();
      _tapTimer = null;
    }
  }
}

class _TapTracker {
  _TapTracker({
    @required PointerDownEvent event,
    @required this.entry,
    @required Duration doubleTapMinTime,
  })  : assert(doubleTapMinTime != null),
        assert(event != null),
        assert(event.buttons != null),
        pointer = event.pointer,
        _initialGlobalPosition = event.position,
        initialButtons = event.buttons,
        _doubleTapMinTimeCountdown =
            _CountdownZoned(duration: doubleTapMinTime);

  final int pointer;
  final GestureArenaEntry entry;
  final Offset _initialGlobalPosition;
  final int initialButtons;
  final _CountdownZoned _doubleTapMinTimeCountdown;

  bool _isTrackingPointer = false;

  void startTrackingPointer(PointerRoute route, Matrix4 transform) {
    if (!_isTrackingPointer) {
      _isTrackingPointer = true;
      GestureBinding.instance.pointerRouter.addRoute(pointer, route, transform);
    }
  }

  void stopTrackingPointer(PointerRoute route) {
    if (_isTrackingPointer) {
      _isTrackingPointer = false;
      GestureBinding.instance.pointerRouter.removeRoute(pointer, route);
    }
  }

  bool isWithinGlobalTolerance(PointerEvent event, double tolerance) {
    final Offset offset = event.position - _initialGlobalPosition;
    return offset.distance <= tolerance;
  }

  bool hasElapsedMinTime() {
    return _doubleTapMinTimeCountdown.timeout;
  }

  bool hasSameButton(PointerDownEvent event) {
    return event.buttons == initialButtons;
  }
}

class _CountdownZoned {
  _CountdownZoned({@required Duration duration}) : assert(duration != null) {
    Timer(duration, _onTimeout);
  }

  bool _timeout = false;

  bool get timeout => _timeout;

  void _onTimeout() {
    _timeout = true;
  }
}
