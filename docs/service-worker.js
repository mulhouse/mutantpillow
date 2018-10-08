const version = "1.0.0";
const appName = "Donna";
const CACHES_TO_STORE =[
    "/mutantpillow/",
    "/mutantpillow/audio/To grow up (1899)/05 San Ku Kai (la guerre).mp3",
    "/mutantpillow/audio/Tour de l'Europe (2004)/03-Scorpio.mp3",
    "/mutantpillow/audio/Strawberries need rain (1797)/07-Grand'Ma.mp3",
    "/mutantpillow/audio/Strawberries need rain (1797)/12-Wilk.mp3",
    "/mutantpillow/index.html",
    "/mutantpillow/manifest.json",
    "https://fonts.googleapis.com/icon?family=Material+Icons",
    "https://fonts.gstatic.com/s/materialicons/v41/flUhRq6tzZclQEJ-Vdg-IuiaDsNcIhQ8tQ.woff2"
];

self.addEventListener("install", (event)=> {
    event.waitUntil(
        caches.open(appName+" "+version)
        .then((cache)=> {
            // cache opened!
            return cache.addAll(CACHES_TO_STORE);
        })
    )
})

self.addEventListener('fetch', function (event) {
    event.respondWith(
        caches.match(event.request)
        .then(function (response) {
            // Cache hit - return response
            if (response) {
                return response;
            }
            return fetch(event.request);
        })
    );
});

