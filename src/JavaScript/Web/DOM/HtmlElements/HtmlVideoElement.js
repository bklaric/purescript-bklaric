export const src = (video) => () => video.src

export const setSrc = (src) => (video) => () => video.src = src

export const removeSrc = (video) => () => video.removeAttribute("src")

export const currentSrc = (video) => () => video.currentSrc

export const poster = (video) => () => video.poster

export const videoWidth = (video) => () => video.videoWidth

export const videoHeight = (video) => () => video.videoHeight

export const readyState = (video) => () => video.readyState

export const muted = (video) => () => video.muted

export const setMuted = (muted) => (video) => () => video.muted = muted

export const setLoop = (loop) => (video) => () => video.loop = loop

export const setAutoplay = (autoplay) => (video) => () => video.autoplay = autoplay

export const setPlaysInline = (playsInline) => (video) => () => video.playsInline = playsInline

export const currentTime = (video) => () => video.currentTime

export const setCurrentTime = (currentTime) => (video) => () => video.currentTime = currentTime

export const duration = (video) => () => video.duration

export const paused = (video) => () => video.paused

export const play = (video) => () => video.play()

export const pause = (video) => () => video.pause()

export const load = (video) => () => video.load()

export const volume = (video) => () => video.volume

export const setVolume = (volume) => (video) => () => video.volume = volume

export const playbackRate = (video) => () => video.playbackRate

export const setPlaybackRate = (rate) => (video) => () => video.playbackRate = rate

export const buffered = (video) => () => {
    const ranges = []
    for (let index = 0; index < video.buffered.length; index++)
        ranges.push({ start: video.buffered.start(index), end: video.buffered.end(index) })
    return ranges
}

export const disablePictureInPicture = (video) => () => !!video.disablePictureInPicture

export const requestPictureInPicture = (video) => () => video.requestPictureInPicture().then(() => {})
