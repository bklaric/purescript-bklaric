module JavaScript.Web.DOM.Class where

class Event (event :: Type)

class EventTarget (eventTarget :: Type)

class EventTarget node <= Node node

class Node element <= Element element

class Element htmlElement <= HtmlElement htmlElement
