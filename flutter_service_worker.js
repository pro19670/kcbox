'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "68c2546e903935276a190405b48ebf8c",
".git/config": "0504eb0f9c9bc504bc6c863d8e042fda",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "ac6a3e2d7e381c6f888297fe4f3104be",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "d1417863ed4bde4e9a0d60bc00123844",
".git/logs/refs/heads/gh-pages": "d1417863ed4bde4e9a0d60bc00123844",
".git/logs/refs/remotes/origin/gh-pages": "ecf8a84c495392b7f5fe898fb80f1f91",
".git/objects/03/2fe904174b32b7135766696dd37e9a95c1b4fd": "80ba3eb567ab1b2327a13096a62dd17e",
".git/objects/04/bb9c7b655a9660aea7c85c2178009ef95cf963": "159f4d75ce096da569d64ce5120122b1",
".git/objects/0d/54d8d5823798dd2f3085efc1cfcbf95fbb51a3": "3d79c6ad8a64cda5f67a098beb823a49",
".git/objects/16/725f7a1a9806da8c0a91b74b1b8fb7b6634677": "9c0e7c8d2493ba546bb7005124aa27ab",
".git/objects/17/bd3a58823bb432b5931e039a1c3d394f3bdc98": "258b6b2d00e179e4696893dfea374c47",
".git/objects/2d/c35f2105162aa2c1497b5ca5227d12f1bae7d6": "2f3fd09d5b05d14b8ca2c33f7fdf1e0f",
".git/objects/2d/e009ce135a7f036caf439a7ef25e90b923f340": "e7066cb2a0e39bf26cc0b8ecbb8e7f11",
".git/objects/33/31d9290f04df89cea3fb794306a371fcca1cd9": "e54527b2478950463abbc6b22442144e",
".git/objects/35/96d08a5b8c249a9ff1eb36682aee2a23e61bac": "e931dda039902c600d4ba7d954ff090f",
".git/objects/38/7da2536150a4460938cac9ce833df30b49f674": "9f86e9e8b6b920ac5b329eaf59d56702",
".git/objects/40/1184f2840fcfb39ffde5f2f82fe5957c37d6fa": "1ea653b99fd29cd15fcc068857a1dbb2",
".git/objects/41/12eb133f15469fc387c59f45b78cc8bb5e9b78": "ec5bf58999b6908bdd7f8f70f8c8dfa8",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/47/18dfd991407cce8c36b62785ccd930b0ebac57": "3d0b347e2a5b0a439c73819a3e78e95b",
".git/objects/4c/680b90531336821faf3e04ca53230c4d3411d7": "46f86a2dce690498fce3be61dbebeede",
".git/objects/4f/02e9875cb698379e68a23ba5d25625e0e2e4bc": "254bc336602c9480c293f5f1c64bb4c7",
".git/objects/55/a56de477939dc166fe0c3a0497c2313d062db7": "983d68b41a7a726ff9cf865b761eed1e",
".git/objects/56/1315d659d6a012f8c7778f1088d92eebc7d4ce": "715b6a3dabe2e4803cbceb1e61df66e8",
".git/objects/56/e4a554f001152d4235b0eef8aac7ec0d57c573": "e24a3b4c8b3f421c8247b8da55988bd1",
".git/objects/57/7946daf6467a3f0a883583abfb8f1e57c86b54": "846aff8094feabe0db132052fd10f62a",
".git/objects/57/d9c2e36eda8c74d4c30890f45c2a7ef8e278ee": "7da44384171db468689e8b4e845d39b3",
".git/objects/5f/2978aae94b03c0945922b46b8fbf8106d1ab41": "e0a551dee3907b51de162e88e584b966",
".git/objects/5f/bf1f5ee49ba64ffa8e24e19c0231e22add1631": "f19d414bb2afb15ab9eb762fd11311d6",
".git/objects/64/5116c20530a7bd227658a3c51e004a3f0aefab": "f10b5403684ce7848d8165b3d1d5bbbe",
".git/objects/6a/b0205673470117f73b7a0301cb79b48fb4eec5": "cf78205ba33235c14c73984777662908",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/77/c40e16966e0bd7d47d6d5acd5da80452f64611": "28ef898ab22ae5c7c6f41c08a953dd6b",
".git/objects/83/c313dd8ae55ca3a3652d68ac74561bcaa6253f": "15ab3dc5064c1ac73bf939fac17e83c1",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/51a9b155d31c44b148d7e287fc2872e0cafd42": "9f785032380d7569e69b3d17172f64e8",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/91/4a40ccb508c126fa995820d01ea15c69bb95f7": "8963a99a625c47f6cd41ba314ebd2488",
".git/objects/99/8757a9a9e697ebbf45318f6e684fac45d91881": "cc59c121b40156faf992c48785ba6ea2",
".git/objects/9a/3c82d19db61eb741b6c11a383941166b038b48": "8858b848a5e254130a1497305cff74b3",
".git/objects/a5/de584f4d25ef8aace1c5a0c190c3b31639895b": "9fbbb0db1824af504c56e5d959e1cdff",
".git/objects/a8/8c9340e408fca6e68e2d6cd8363dccc2bd8642": "11e9d76ebfeb0c92c8dff256819c0796",
".git/objects/b2/7f9c00dd1efc0052384d749d15286bde4c7871": "55cf14c60f4ba6fc89e2cab071ec1a35",
".git/objects/b2/de03d581ceb0facfe10abd83fad4a6f34cb151": "8e98ff992481003c9747f99bcb512aa3",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/bb/be649d73134b659833de456ccc8b244460773f": "707c7b7aebf6a7e2157e98078be9bffb",
".git/objects/bd/7fffec20ad62075c8d6589e16ff5e58e05c562": "1e33604622e8d618384dfa21665f9429",
".git/objects/c6/efd0997e54d448aaa70c1ac46cfcbfe6505eb9": "98135603e52cc07c31453cecec8a71b8",
".git/objects/ce/de10a33aaa008a5eeb60be2208b48f8329e7c0": "ebcd25c0827ab384f4c287711edc2804",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/d9/3952e90f26e65356f31c60fc394efb26313167": "1401847c6f090e48e83740a00be1c303",
".git/objects/e3/9ca5d9b01cf8bc042044587cd6c62556c4dfe9": "16ea7bb070be8ff1027a1ad810bdb00d",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ef/b875788e4094f6091d9caa43e35c77640aaf21": "27e32738aea45acd66b98d36fc9fc9e0",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f3/709a83aedf1f03d6e04459831b12355a9b9ef1": "538d2edfa707ca92ed0b867d6c3903d1",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/refs/heads/gh-pages": "0efa8901814801886b0b430a6b7dec50",
".git/refs/remotes/origin/gh-pages": "0efa8901814801886b0b430a6b7dec50",
"assets/AssetManifest.bin": "2a7fe77266eb679dda8a2cf1e7acfc81",
"assets/AssetManifest.bin.json": "e7b7d0db149cf84aa84a50043166a37e",
"assets/AssetManifest.json": "3d6ee27428b89c5d81290d0873153412",
"assets/assets/images/default_background.jpg": "ff06046489bd7248cdcf2b0348de1782",
"assets/assets/images/default_home.jpg": "b94e2f2bd2121357b706dbdf30e5c656",
"assets/assets/images/home.png": "16f7cf2042280a7e79f4d6690a16f43d",
"assets/assets/images/home_bg.jpg": "3598d4db12c017fa8ccd09c04a7eadda",
"assets/assets/images/office.png": "9ba62e529afdfa3a2f35a0db364dba70",
"assets/assets/images/office_structure.png": "c590be104f4d5e86ae544469e0a89db5",
"assets/assets/images/room_structure.png": "976ab800d33e7397495a0e9ec4fc445e",
"assets/assets/images/structure_bg.png": "892bb99b0b2086441c70143dce17a13b",
"assets/assets/images/warehouse.png": "b94e2f2bd2121357b706dbdf30e5c656",
"assets/assets/images/warehouse_structure.png": "694b4a190c135dd19dfe94708edc4f65",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "2be48669f7a3b8345f29550731af5095",
"assets/NOTICES": "dc616dc08ebfc3361690c1e0f1c185c0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "9663c90c6fd92cccfd743c5d753e4ac1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "d32f1720caf857e0b1fe1a9f8a2dde5a",
"/": "d32f1720caf857e0b1fe1a9f8a2dde5a",
"main.dart.js": "aa1c3ccc2c82a580ffccd2a1d05e6c60",
"manifest.json": "f507ccba519636c8a00ebdac4926b4fe",
"version.json": "f5e5e819f103befc5695e47185291777"};
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
