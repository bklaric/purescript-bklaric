export const _executeScript = (injection) => () => chrome.scripting.executeScript(injection);

export const _insertCSS = (details) => () => chrome.scripting.insertCSS(details);
