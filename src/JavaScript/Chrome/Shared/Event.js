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

export function toEventListener(listener) {
    return function () { // This function receives all event arguments.
        const argumentsArray = Array.from(arguments)
        var listenerResult = listener
        for (var index = 0; index < argumentsArray.length; ++index) {
            if (typeof argumentsArray[index] == "function") {
                listenerResult = listenerResult(curry(argumentsArray[index]))
            }
            else {
                listenerResult = listenerResult(argumentsArray[index])
            }
        }
        return listenerResult()
    }
}

export function addListener(listener) {
    return function (event) {
        return function () {
            event.addListener(listener)
        }
    }
}

export function removeListener(listener) {
    return function (event) {
        return function () {
            event.removeListener(listener)
        }
    }
}

export function hasListener(listener) {
    return function (event) {
        return function () {
            event.hasListener(listener)
        }
    }
}
