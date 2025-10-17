'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "5cbc93a44730eaf335d1810066b2a6e2",
"index.html": "d8d265458d4a40c25ceb2129061be809",
"/": "d8d265458d4a40c25ceb2129061be809",
"main.dart.js": "79012589aba3cd693fc75a4015cfa289",
"version.json": "90f056871b6aaa136ccca2d3f595d8f9",
"assets/assets/images/air_mineral.jpg": "b2f747485c2101bc45fc2c6925982646",
"assets/assets/images/ayam_geprek.jpeg": "0f0e3ca11a60563514a500b0acdc26cc",
"assets/assets/images/ayam_goreng.jpg": "ca4cc31166a04cdd4ae911e452f26190",
"assets/assets/images/capcay.jpg": "dd25fd8a44a47e5e72490c2744264737",
"assets/assets/images/es_teh.jpg": "077bd13607c635220096d5191c829386",
"assets/assets/images/bakwan_jagung.jpeg": "2b9c1cc330b234bcd2609a4ab8c52e3f",
"assets/assets/images/es_jeruk.jpeg": "6d747895507d5111d1c9d5b20ea4ba58",
"assets/assets/images/jeruk_hangat.jpg": "329d307c774c68997b8d58628ef15bbd",
"assets/assets/images/mie_ayam.jpg": "1064b63c51a5b7848f5e3125088efaea",
"assets/assets/images/jus_alpukat.jpeg": "b7a61fd463c03715de7b86446d84c0bc",
"assets/assets/images/kopi_hitam.jpg": "d52e23b049a8be4f77750967bf81e1e3",
"assets/assets/images/perkedel.jpg": "1d71674cb13e7bfe4c71dd4b2a141d16",
"assets/assets/images/nasi_goreng.jpg": "9ba8b3559056362d92be38bd3eff8ba0",
"assets/assets/images/nasi_putih.jpg": "2e3333c1bf4c4831f3bc2c3533dc26da",
"assets/assets/images/sayur_asem.jpg": "8a3904125de5cd9b662a212b0c11320e",
"assets/assets/images/sayur_lodeh.jpg": "6224b31a16d49d75ab93ba9c38e6132b",
"assets/assets/images/soto_ayam.jpg": "f4a7f83f151c09026147610cc89472a8",
"assets/assets/images/tahu_goreng.jpeg": "16d57dd4f7c720a060128c23382db326",
"assets/assets/images/teh_hangat.jpg": "e5c958db240cd3489584445f6216396b",
"assets/assets/images/telur_dadar.jpeg": "d32e3c842df20721f000116c065f2001",
"assets/assets/images/telur_matasapi.jpeg": "7c241a8353fa5447a624bfb6f372c971",
"assets/assets/images/une.png": "1c3577bf9ea39d13ee72a8e14bee2e98",
"assets/assets/images/telur_rebus.jpeg": "03d9851be3251d174f48554c8b1e80b8",
"assets/assets/images/tumis_kangkung.jpg": "c2dc0ea39399efd6854f5d1fef950a09",
"assets/assets/images/tempe_goreng.jpg": "66fbf3768c9f2a0f64382c77a07b36e4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/fonts/MaterialIcons-Regular.otf": "67e7c54cc9648278e3c6532d3ee6cdd4",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "c90ea20c42ec8117be4fc3672f136d7e",
"assets/AssetManifest.bin": "c3f67c0b0832fe02651bc65f091a4280",
"assets/AssetManifest.bin.json": "862eb309049d0d4fec5d84180f295b78",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "089e7165fe1010ea50691869b6f53503",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"manifest.json": "4e012b3fa9f2fae67986ff75ea3e1693"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
