export function unsafeReadProtoTaggedImpl(name) {
    return function (value) {
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
}

export function toArrayDefault(object) {
    return function () {
        return Array.from(object)
    }
}
