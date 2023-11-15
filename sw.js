const DEBUG = false;
const USE_CACHE = true;

self.addEventListener("install", function (event) {
    logEvent(event);
    const filesToCache = [
        "./",
        "./index.html",
        "./Smalltalk78.js",
        "./vm.js",
        "./icons/icon-78.png",
    ];
    const installCache = async function () {
        const cache = await caches.open("v1");
        return Promise.all(
            filesToCache.map((file) =>
                cache.add(file).catch(() => log(`Error caching ${file}`))
            )
        );
    };

    event.waitUntil(installCache);
    self.skipWaiting();
});

self.addEventListener("activate", function (event) {
    logEvent(event);
    event.waitUntil(self.clients.claim());
});

self.addEventListener("fetch", async function (event) {
    const url = new URL(event.request.url);
    logEvent(
        event,
        `${url.protocol}//${url.hostname}:${url.port}/${url.pathname}${url.search}`
    );

    event.respondWith(getCachedResponseOrFetch(event.request));
});

async function getCachedResponseOrFetch(request) {
    const cachedResponse = await getCachedResponse(request);
    if (cachedResponse) {
        log("Cached Response");
        return cachedResponse;
    } else {
        log("Fetched Response");
        return fetch(request);
    }
}

async function getCachedResponse(request) {
    if (USE_CACHE) {
        return caches.open("v1").then((cache) => cache.match(request));
    }
}

// Logging
function log(...args) {
    if (!DEBUG) {
        return;
    }
    console.log("[sw]", ...args);
}

function logEvent(event, ...args) {
    log(`${event.type}`, ...args);
}
