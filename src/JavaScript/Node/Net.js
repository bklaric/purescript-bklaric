import * as net from "net"

export const isIP = (input) => net.isIP(input)

export const isIPv4 = (input) => net.isIPv4(input)

export const isIPv6 = (input) => net.isIPv6(input)
