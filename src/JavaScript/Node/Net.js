import * as net from "net"

export function isIP(input) {
    return net.isIP(input)
}

export function isIPv4(input) {
    return net.isIPv4(input)
}

export function isIPv6(input) {
    return net.isIPv6(input)
}
