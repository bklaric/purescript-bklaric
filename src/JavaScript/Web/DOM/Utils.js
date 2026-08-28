export const _unsafeReadProtoTagged = (name) => (value) => {
    var obj = value
    while (obj != null) {
        var proto = Object.getPrototypeOf(obj)
        var ctor = proto.constructor.name
        if (ctor === name) {
            return value
        } else if (ctor === "Object") {
            return null
        }
        obj = proto
    }
    return null
}

export const toArrayDefault = (object) => () => Array.from(object)
