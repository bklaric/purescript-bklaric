module JavaScript.Web.DOM.Class where

class Event (event :: Type)

class Event errorEvent <= ErrorEvent errorEvent

class Event promiseRejectionEvent <= PromiseRejectionEvent promiseRejectionEvent

class Event uiEvent <= UiEvent uiEvent

class UiEvent mouseEvent <= MouseEvent mouseEvent

class MouseEvent wheelEvent <= WheelEvent wheelEvent

class UiEvent keyboardEvent <= KeyboardEvent keyboardEvent

class UiEvent touchEvent <= TouchEvent (touchEvent :: Type)

class UiEvent focusEvent <= FocusEvent focusEvent

class Event messageEvent <= MessageEvent messageEvent

class Event popStateEvent <= PopStateEvent popStateEvent

class EventTarget (eventTarget :: Type)

class EventTarget node <= Node node

class Node element <= Element element

class Element htmlElement <= HtmlElement htmlElement
