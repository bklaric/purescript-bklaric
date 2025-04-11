module JavaScript.Web.DOM.Class where

class Event (event :: Type)

class Event uiEvent <= UiEvent uiEvent

class UiEvent mouseEvent <= MouseEvent mouseEvent

class UiEvent touchEvent <= TouchEvent (touchEvent :: Type)

class Event event <= MessageEvent event

class EventTarget (eventTarget :: Type)

class EventTarget node <= Node node

class Node element <= Element element

class Element htmlElement <= HtmlElement htmlElement
