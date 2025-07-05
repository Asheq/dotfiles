chrome.runtime.onInstalled.addListener(() => {
    chrome.contextMenus.create({
        id: "openInFirefox",
        title: "Open link in Firefox",
        contexts: ["link"]
    });
});

chrome.contextMenus.onClicked.addListener((info, _tab) => {
    if (info.menuItemId === "openInFirefox") {
        console.log("Sending URL to native app:", info.linkUrl);
        chrome.runtime.sendNativeMessage(
            "com.asheqimran.open_in_firefox",
            {url: info.linkUrl},
            (response) => {
                if (chrome.runtime.lastError) {
                    console.error("Native messaging error:", chrome.runtime.lastError.message);
                } else {
                    console.log("Native host response:", response);
                }
            }
        );
    }
});
