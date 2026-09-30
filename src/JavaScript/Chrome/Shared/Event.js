function curry(fn) {
    return function curried(...args) {
        if (args.length >= fn.length) {
            // Empty function to simulate effect/promise.
            return function () {
                return fn.apply(this, args);
            }
        } else {
            return function (...moreArgs) {
                return curried.apply(this, args.concat(moreArgs));
            }
        }
    };
}

export const toEventListener = (listener) => function () { // This function receives all event arguments.
    const argumentsArray = Array.from(arguments)
    var listenerResult = listener
    for (var index = 0; index < argumentsArray.length; ++index) {
        // A curried listener takes one argument per step and ends in an effect, which takes none.
        // Stop there: browsers differ in how many arguments an event carries (Firefox's
        // action.onClicked adds OnClickData), and feeding the extra one to the effect would run it
        // here and leave its result to be called below.
        if (listenerResult.length === 0) {
            break
        }
        if (typeof argumentsArray[index] == "function") {
            listenerResult = listenerResult(curry(argumentsArray[index]))
        }
        else {
            listenerResult = listenerResult(argumentsArray[index])
        }
    }
    return listenerResult()
}

export const addListener = (listener) => (event) => () => event.addListener(listener)

export const removeListener = (listener) => (event) => () => event.removeListener(listener)

export const hasListener = (listener) => (event) => () => event.hasListener(listener)
