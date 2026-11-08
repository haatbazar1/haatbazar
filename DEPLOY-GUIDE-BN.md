# HaatBazar — Deploy গাইড

সংস্করণ: ৮ নভেম্বর ২০২৬ — fix করা কোড + production build (`dist/`) সহ। PHP login throttling ও session hardening-সহ (রিভিউর বড় সমস্যা ৬ ও ৭)।
এই প্যাকেজের অবস্থা: **build ও test পাস করা, deploy-এর জন্য তৈরি।** শুধু hosting আর আসল credentials বাকি।

## যা যাচাই করা হয়েছে ✅

- `npm run build` — TypeScript check + Vite production build সফল (`dist/index.html`, JS 226 KB / gzip 67 KB, CSS 19.6 KB)
- Project-এর API test — ৭/৭ PASS
- Fix-এর আলাদা test (stock, payment ownership, duplicate phone) — ৭/৭ PASS
- Catalog validation — ১২ ক্যাটাগরি, ৬৪ জেলা, ১০২ সাবক্যাটাগরি OK
- PHP ফাইল syntax — OK
- **PHP login throttling test — ৯/৯ PASS** (১০ ব্যর্থ login-এ ইমেইল lock, ৩০ চেষ্টায় IP lock, ১৫ মিনিটে মেয়াদ শেষ) ও **session cookie hardening যাচাই** (HttpOnly, SameSite=Lax, HTTPS-এ Secure) — বিস্তারিত `FIXES-2026-11-08.md`-এ
- **Production mode smoke test** — `NODE_ENV=production` দিয়ে server চালু করে homepage (built frontend), `/api/healthz`, `/api/listings`, `/api/catalog` — সব ঠিকঠাক উত্তর দিয়েছে

## Hosting-এর শর্ত (Node সংস্করণের জন্য)

- Node.js 20 বা তার বেশি
- সবসময় চালু থাকা process (shared PHP hosting-এ চলবে না — সেটার জন্য আলাদা InfinityFree PHP সংস্করণ আছে, তবে সেটা অসম্পূর্ণ)
- **Persistent disk** — `DATA_DIR`-এ SQLite database, session আর upload করা ছবি থাকে; disk মুছে গেলে সব ডেটা যাবে
- HTTPS — `PUBLIC_BASE_URL` অবশ্যই `https://` হতে হবে (payment শুরুই হবে না নইলে)
- পোর্ট: app `PORT` env অনুযায়ী চলে (default 3000); সামনে reverse proxy (Nginx/Caddy) বা hosting-এর নিজের proxy

## Deploy — পদ্ধতি A: Docker (VPS থাকলে সহজ)

```bash
unzip haatbazar-deploy.zip
cd haatbazar-main
cp .env.example .env      # .env-তে আসল মানগুলো বসাও (নিচের তালিকা দেখো)
docker compose up -d --build
```

Compose-এ healthcheck (`/api/healthz`) আর data volume আগেই সাজানো আছে।

## Deploy — পদ্ধতি B: Node hosting (Render / Railway / Fly.io / নিজের VPS + PM2)

```bash
npm ci            # package-lock.json আছে, ঠিক একই dependency আসবে
npm run build     # dist/ প্যাকেজে তৈরিই আছে; চাইলে নতুন করে বানানো যাবে
npm start         # node server.js
```

Hosting panel-এ নিচের env variable গুলো set করো। VPS + PM2 হলে `.env` ফাইলে রাখো (`cp .env.example .env`)।

## Env variables

**অবশ্যই লাগবে (না দিলে production server চালুই হবে না):**

| Variable | মন্তব্য |
|---|---|
| `NODE_ENV` | `production` |
| `SESSION_SECRET` | কমপক্ষে ৩২ অক্ষর, এলোমেলো ও গোপন। উদাহরণ তৈরি: `openssl rand -hex 32` |
| `PUBLIC_BASE_URL` | তোমার আসল domain, যেমন `https://haatbazar1.kesug.com` |
| `ADMIN_EMAIL`, `ADMIN_PASSWORD` | Admin account; password কমপক্ষে ১২ অক্ষর |
| `BUSINESS_LEGAL_NAME`, `BUSINESS_ADDRESS`, `BUSINESS_PHONE`, `SUPPORT_EMAIL`, `TRADE_LICENSE_NO` | তোমার নিবন্ধিত ব্যবসার **আসল** তথ্য — বানিয়ে লেখা যাবে না (site-এর legal পেজে এগুলোই দেখায়) |

**Integration (পরে যোগ করা যাবে; না থাকলে সংশ্লিষ্ট সুবিধা বন্ধ থাকে, site চলে):**

| Variable | কাজ |
|---|---|
| `SSLCOMMERZ_STORE_ID`, `SSLCOMMERZ_STORE_PASSWORD`, `SSLCOMMERZ_LIVE` | Online payment। আগে sandbox (`LIVE=false`) দিয়ে test, তারপর live |
| `SMS_API_URL`, `SMS_API_KEY` | OTP SMS। Provider-এর আসল API ধরন মিলিয়ে নিতে হবে |
| `COURIER_API_URL`, `COURIER_API_KEY`, `COURIER_API_SECRET`, `COURIER_PROVIDER` | Courier shipment |

**রেখে দাও যেমন আছে:** `VITE_DEMO_MODE=false` (build-এর সময় লাগে; প্যাকেজের build-এ demo বন্ধই আছে)।

## Live করার আগে শেষ checklist

- [ ] `node scripts/check-integrations.mjs` চালিয়ে দেখো কোন credential বাকি (এখন ৬টা বাকি: SSLCommerz ২, SMS ২, courier ২)
- [ ] SSLCommerz **sandbox**-এ পুরো payment যাত্রা test: init → success → fail → cancel → IPN
- [ ] SMS OTP আসল নম্বরে পৌঁছায় কিনা test
- [ ] Registration → login → ad দেওয়া (ছবিসহ) → order → stock কমে কিনা — পুরো যাত্রা একবার নিজে করে দেখো
- [ ] Database backup চালু: `npm run backup` (নিয়মিত চালানোর ব্যবস্থা করো)
- [ ] Domain থেকে SEO audit: `PUBLIC_BASE_URL=https://<domain> npm run seo:audit`
- [ ] সতর্কতা: এই fix গুলো GitHub repo-তে এখনো যায়নি — repo-র কোড আলাদা (নতুন) সংস্করণ। Deploy এই প্যাকেজ থেকেই করো, অথবা আগে repo-র কোডে fix গুলো মিলিয়ে নাও।

## সমস্যা হলে

- Server চালু না হলে log দেখো — production-এ কোন env বাকি থাকলে server নিজেই নাম ধরে বলে দেবে।
- Payment শুরু না হলে: `PUBLIC_BASE_URL` https কিনা, পরিমাণ ১০–৫০০,০০০ টাকার মধ্যে কিনা, gateway credential ঠিক কিনা দেখো।
- ছবি upload না হলে: `DATA_DIR` লেখার অনুমতি (write permission) আছে কিনা দেখো।
