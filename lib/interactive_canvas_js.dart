@JS()
library interactive_canvas_js;

import 'package:js/js.dart';

@JS()
abstract class InteractiveCanvas {
  external void sendTextQuery(String text);
  external void ready(InteractiveCanvasCallbacks callbacks);
}

@JS()
@anonymous
abstract class InteractiveCanvasCallbacks {
  external factory InteractiveCanvasCallbacks({
    _OnUpdateCallback onUpdate,
  });
  external _OnUpdateCallback get onUpdate;
}

typedef _OnUpdateCallback = Function(OnUpdateData data);

@JS()
external InteractiveCanvas get interactiveCanvas;

@JS()
abstract class OnUpdateData {
  external factory OnUpdateData();
  external String get command;
  external int get tint;
  external bool get spin;
}
