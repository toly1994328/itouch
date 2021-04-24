import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef GestureNTapCallback = void Function();
typedef GestureNTapDownCallback = void Function(TapDownDetails details, int n);
typedef GestureNTapCancelCallback = void Function(int n);

//1 相邻触点大于 200 ms --- 取消 N 击
//2 触点自己触发取消事件 --- 取消 N 击
//3 落点在追踪中偏移量 > 18 逻辑像素 --- 取消 N 击
//4 落点与第一触点距离 > 200逻辑像素 --- 无效 N 击
//5 相邻触点间距 小于 40 ms --- 无效 N 击，重新追踪

class NTapGestureRecognizer extends GestureRecognizer {
  NTapGestureRecognizer(
      {Object debugOwner, PointerDeviceKind kind, this.maxN = 3})
      : super(debugOwner: debugOwner, kind: kind);

  @override
  void acceptGesture(int pointer) {
    if(tapCount!=maxN){
      _checkCancel();
    }
  }

  GestureNTapCallback onNTap;
  GestureNTapCancelCallback onNTapCancel;
  GestureNTapDownCallback onNTapDown;

  final int maxN;
  _TapTracker _prevTap;

  int tapCount = 0;

  final Map<int, _TapTracker> _trackers = <int, _TapTracker>{};

  Timer _tapTimer;

  @override
  String get debugDescription => 'N tap';

  @override
  void rejectGesture(int pointer) {
    _TapTracker tracker = _trackers[pointer];
    if (tracker == null && _prevTap != null && _prevTap.pointer == pointer)
      tracker = _prevTap;
    if (tracker != null) _reject(tracker);
  }

  @override
  bool isPointerAllowed(PointerDownEvent event) {
    if (_prevTap == null) {
      switch (event.buttons) {
        case kPrimaryButton:
          if (onNTap == null || onNTapCancel == null || onNTapDown == null)
            return false;
          break;
        default:
          return false;
      }
    }
    return super.isPointerAllowed(event);
  }

  @override
  void addAllowedPointer(PointerDownEvent event) {
    tapCount++;
    if (_prevTap != null) {
      if (!_prevTap.isWithinGlobalTolerance(event, kDoubleTapSlop)) {
        return;
      } else if (!_prevTap.hasElapsedMinTime() ||
          !_prevTap.hasSameButton(event)) {
        _reset();
        return _trackTap(event);
      } else if (onNTapDown != null) {
        final TapDownDetails details = TapDownDetails(
          globalPosition: event.position,
          localPosition: event.localPosition,
          kind: getKindForPointer(event.pointer),
        );
        invokeCallback<void>('onNTapDown', () => onNTapDown(details, tapCount));
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
      if (_prevTap == null || tapCount != maxN) {
        _registerTap(tracker);
      } else {
        _registerLastTap(tracker);
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

    if (_prevTap != null) {
      if (tracker == _prevTap) {
        _reset();
      } else {
        _checkCancel();
        if (_trackers.isEmpty) _reset();
      }
    }
  }

  void _checkCancel() {
    if (onNTapCancel != null)
      invokeCallback<void>('onNTapCancel', ()=>onNTapCancel(tapCount));
  }

  void _startDoubleTapTimer() {
    _tapTimer ??= Timer(kDoubleTapTimeout, _reset);
  }

  void _registerTap(_TapTracker tracker) {
    _startDoubleTapTimer();
    GestureBinding.instance.gestureArena.hold(tracker.pointer);
    _freezeTracker(tracker);
    _trackers.remove(tracker.pointer);
    _clearTrackers();

    _prevTap = tracker;
  }

  void _registerLastTap(_TapTracker tracker) {
    tracker.entry.resolve(GestureDisposition.accepted);
    _freezeTracker(tracker);
    _trackers.remove(tracker.pointer);
    _checkUp(tracker.initialButtons);
    _reset();
  }

  void _checkUp(int buttons) {
    assert(buttons == kPrimaryButton);
    if (onNTap != null) invokeCallback<void>('onNTap', () => onNTap);
  }

  void _reset() {
    _stopDoubleTapTimer();
    if (_prevTap != null) {
      if (_trackers.isNotEmpty) _checkCancel();
      final _TapTracker tracker = _prevTap;
      _prevTap = null;

      if (tapCount == 1) {
        tracker.entry.resolve(GestureDisposition.rejected);
      } else {
        tracker.entry.resolve(GestureDisposition.accepted);
      }
      _freezeTracker(tracker);
      GestureBinding.instance.gestureArena.release(tracker.pointer);
    }
    _clearTrackers();
    tapCount = 0;
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
