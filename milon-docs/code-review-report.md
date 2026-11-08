# HaatBazar — কোড রিভিউ রিপোর্ট

তারিখ: ৮ নভেম্বর ২০২৬
যা রিভিউ হয়েছে: তোমার আপলোড করা `haatbazar-main.zip` (২৪ অক্টোবর ২০২৬-এর সংস্করণ) — Node/Express backend (`server.js`), React frontend (`src/`), InfinityFree PHP সংস্করণ, Docker, GitHub workflow, স্ক্রিপ্ট ও কনফিগ।
নোট: GitHub repo-তে এর চেয়ে নতুন কোড আছে (শেষ push ৩১ অক্টোবর) — এই রিপোর্ট ZIP সংস্করণের উপর।

সারসংক্ষেপ: মোট **৮টি বড় (High)**, **১৭টি মাঝারি (Medium)** ও **১৫টির মতো ছোট (Low)** সমস্যা পাওয়া গেছে। কোনো আসল পাসওয়ার্ড/সিক্রেট কোডে পাওয়া যায়নি — এটা ভালো দিক।

---

## 🔴 বড় সমস্যা (আগে ঠিক করা জরুরি)

### 1. Stock কখনোই কমে না — অসীম overselling সম্ভব
- `server.js` (order তৈরি ও payment-paid callback) এবং PHP `index.php` — কোথাও `UPDATE listings SET quantity` নেই (নিজে grep করে যাচাই করা)।
- ফল: একটা listing-এ stock ৮ থাকলেও পর পর যত খুশি ৮টি করে order দেওয়া যাবে। পরীক্ষা স্ক্রিপ্ট শুধু একবারের বেশি-পরিমাণ order পরীক্ষা করে, তাই এটা ধরা পড়েনি।

### 2. Payment শুরু করার route-এ login লাগে না, ownership check ফাঁকি দেওয়া যায়
- `server.js:227` — `POST /api/payments/sslcommerz/init` route-এ `signedIn` check নেই।
- Ownership check-টা এমনভাবে লেখা যে session-ই না থাকলে check-টাই skip হয়ে যায়। Guest order-এর ID (UUID) কেউ পেলে সে payment শুরু করতে পারবে, এমনকি "payment in progress" lock ব্যবহার করে আসল ক্রেতাকে বারবার আটকে দিতে পারবে।

### 3. ফোন নম্বর দিয়ে password reset করলে ওই নম্বরের সব account-এর password বদলে যায়
- `server.js:202` — `UPDATE users SET password_hash=? WHERE phone=?`
- Phone নম্বরের উপর UNIQUE constraint নেই, registration-এ একই নম্বর বারবার ব্যবহার করা যায়। ফলে একবার OTP verify করলেই ওই নম্বরওয়ালা সব account-এর password বদলে যাবে।

### 4. Live site-এ demo (ভুয়া) listing দেখায় ও order পর্যন্ত করা যায়
- `src/pages/Home.tsx` — API থেকে 0টা item এলে বা API down থাকলে ৬০টা sample listing দেখানো হয়। এই fallback `VITE_DEMO_MODE` দিয়ে বন্ধ করার ব্যবস্থা Home পেজে নেই।
- Demo listing-এর Order বোতাম আসল `/api/orders`-এ ভুয়া listing ID পাঠায়। Banner দেখালেও live ক্রেতা বিভ্রান্ত হবে।

### 5. `.gitignore`-এ সবচেয়ে বিপজ্জনক দুটি ফাইল নেই
- `.gitignore`-এ শুধু `.env*`, `dist/`, `*.log` আছে। নেই: `infinityfree/config.php` (আসল DB ও SSLCommerz পাসওয়ার্ড থাকে এখানে) এবং `data/` / `*.sqlite` (password hash ও session-সহ database)।
- ভুলে `git add .` করলেই এগুলো public repo-তে চলে যেতে পারে।

### 6. PHP (InfinityFree) সংস্করণে login/register-এ কোনো throttling নেই
- `infinityfree/api/index.php` — ব্যর্থ login চেষ্টার কোনো হিসাব/বিরতি নেই। Brute-force করে password আন্দাজ করা সম্ভব। Node সংস্করণে এই সুরক্ষা আছে, PHP-তে নেই।

### 7. PHP session cookie-তে কোনো hardening নেই
- শুধু খালি `session_start()`; Secure / HttpOnly / SameSite কোনোটাই স্পষ্টভাবে set করা হয়নি। Node সংস্করণে এগুলো আছে।

### 8. InfinityFree/PHP সংস্করণ আসলে অসম্পূর্ণ পণ্য
- PHP-তে নেই: listing তৈরি/এডিট, ছবি upload, OTP, password reset, seller verification, courier, analytics।
- অর্থাৎ InfinityFree-তে বিক্রেতা বিজ্ঞাপনই দিতে পারবে না। Node ও PHP সংস্করণ দুটো এখন দুই রকম পণ্য।

---

## 🟠 মাঝারি সমস্যা

**Backend (Node)**
9. কোনো CSRF token নেই — সব state-changing route শুধু session cookie-র উপর নির্ভরশীল (`sameSite:lax` আংশিক বাঁচায়, পুরোপুরি নয়)।
10. OTP সীমা শুধু IP অনুযায়ী — একই ফোনে বারবার OTP পাঠানোর (SMS-bombing / খরচ বাড়ানো) কোনো per-phone সীমা, cooldown বা পুরনো code বাতিলের ব্যবস্থা নেই।
11. বিক্রেতার ব্যক্তিগত ফোন নম্বর public route-এ পাওয়া যায় — `GET /api/listings/:id/phone`-এ login লাগে না, শুধু IP সীমা; scraper সহজে সব নম্বর তুলে নিতে পারবে।
12. Analytics ও contact endpoint-এ login/সীমা কিছুই নেই — কেউ অসীম ভুয়া event ঢুকিয়ে admin-এর হিসাব নষ্ট করতে ও database ফুলিয়ে ফেলতে পারবে।
13. Session secret-এর hardcoded fallback (`'local-dev-only-change-this-secret'`) — deploy-এ `NODE_ENV=production` দিতে ভুললেই পরিচিত secret ও non-Secure cookie চালু থাকবে।
14. ছবি upload-এ মোট quota ও অপ্রয়োজনীয় ছবি পরিষ্কারের ব্যবস্থা নেই — একজন user অনবরত 5MB ছবি তুলে disk ভরে ফেলতে পারবে।
15. Content-Security-Policy বন্ধ রাখা হয়েছে (`server.js:112`) — সার্ভার নিজে অনেক HTML পেজ বানায়, তাই কোনো interpolation ফসকে গেলে সুরক্ষা-জাল নেই।
16. OpenAPI spec-এর সঙ্গে আসল server মেলে না — spec-এ এমন ৭+ route আছে যা server-এ নেই, আর server-এর register/OTP/payment/admin route-গুলো spec-এ নেই। Spec দিয়ে client বানালে 404 খাবে।

**Frontend**
17. Admin analytics পেজে পৌঁছানোরই কোনো পথ নেই — `setShowAnalytics(true)` কোথাও call হয় না; feature-টা মৃত।
18. Footer-এর `/contact`, `/about`, `/privacy`, `/terms` ইত্যাদি লিংক কোথাও যায় না — ওই route/component-ই নেই।
19. Listing সর্বোচ্চ ৫০টা পর্যন্তই দেখায়, চুপচাপ — pagination নেই, ৫০-এর পরের listing অদৃশ্য।
20. ছবি upload ব্যর্থ হলে পুরো বিজ্ঞাপন দেওয়াই আটকে যায় — "ছবি ছাড়া পোস্ট" বিকল্প নেই।
21. ফর্ম validation পাতলা — দাম ০ টাকা দেওয়া যায়, `minOrderQuantity > quantity` হলেও সতর্কবার্তা নেই।

**PHP / Config**
22. MySQL schema-তে Node-র ৬টা table নেই (OTP, courier, analytics, seller verification ইত্যাদি); `payment_transactions` table-এর গঠনও দুই জায়গায় দুই রকম — ডেটা এক backend থেকে অন্যটায় নেওয়া যাবে না।
23. PHP checkout `payment_transactions`-এ কিছুই লেখে না — payment-এর কোনো audit record থাকে না।
24. PHP checkout-এ `minOrderQuantity` যাচাই হয় না; stock check transaction-এর বাইরে — race condition-এ oversell।
25. Fail/cancel payment callback যাচাই ছাড়াই order-এর status বদলে দেয় (success/IPN ঠিকমতো যাচাই হয়)।
26. Password নীতি দুই জায়গায় দুই রকম — PHP-তে ১০ অক্ষর, Node-এ ১২ অক্ষর।
27. `package-lock.json` নেই, সব জায়গায় `npm install` — build প্রতিবার একই রকম হবে তার নিশ্চয়তা নেই।
28. GitHub Pages deploy, validation workflow শেষ হওয়ার অপেক্ষা না করেই চলে যেতে পারে।
29. `database/marketplace-migration.sql` আসলে PostgreSQL প্রস্তাব — SQLite/MySQL কোনোটাতেই সরাসরি চলবে না; listings অংশ comment করা।

---

## 🟡 ছোট সমস্যা

- Password reset করলেও আগের login করা session গুলো বাতিল হয় না।
- Payment callback পুরোপুরি idempotent নয়; SSLCommerz-এর `verify_sign` যাচাই হয় না (তবে validation API call হয় — নিচে দেখো)।
- Login-এর সময়ের পার্থক্য দিয়ে বোঝা যায় email-টা আছে কিনা (account enumeration)।
- Login redirect-এ `/\evil.com` ধরনের backslash bypass।
- OTP তুলনা constant-time নয় (প্রভাব ছোট, ৫ বার চেষ্টার সীমা আছে)।
- Listing-এর ফোন নম্বর বিক্রেতার নিজের verified নম্বর কিনা যাচাই হয় না — অন্যের নম্বর বসানো যায়।
- Order dialog-এ quantity নিজে থেকে কমে গিয়ে minimum-এর নিচে নামতে পারে, সতর্কবার্তা ছাড়া।
- Analytics-এর `contact`, `order` ইত্যাদি event frontend থেকে কখনো পাঠানোই হয় না — admin-এর "contact rate" প্রায় সবসময় ০ দেখাবে।
- "X% OFF" badge আছে, কিন্তু আসল/ছাড়ের দামের হিসাব দেখানো হয় না।
- GitHub Pages-এ বসালে API base (`/api`) কাজ করবে না — ফলে সেখানে স্থায়ীভাবে demo listing-ই দেখাবে (৪ নম্বর সমস্যার সঙ্গে যুক্ত)।
- `.dockerignore`-এ `infinityfree/config.php` নেই — Docker build image/cache-এ সিক্রেট ঢুকে যেতে পারে।
- `check-integrations` ও `seo-audit` স্ক্রিপ্ট কখনো fail করে না — সমস্যা থাকলেও "pass" দেখায়।
- `config.example.php`-তে `sslcommerz_sandbox => true` — production-এ ভুলে sandbox-ই থেকে যেতে পারে।
- PHP search-এ LIKE-এর `%`/`_` escape করা হয়নি (SQL injection নয়, শুধু wildcard আচরণ)।
- Project-এর ভিতরে পুরনো `haatbazar-payments-otp-courier-seo-v2.zip` (২১ অক্টোবর) রয়ে গেছে — সেটার frontend কোড বর্তমান কোডের সঙ্গে ইতিমধ্যে মেলে না। বিভ্রান্তি ও ভুল সংস্করণ ব্যবহারের ঝুঁকি।

---

## ✅ যা ঠিকঠাক আছে (যাচাই করা)

- **SQL injection পাওয়া যায়নি** — Node ও PHP দুই জায়গাতেই সব query parameterized/prepared।
- **Payment যাচাই সঠিকভাবে করা হয়** — browser redirect বিশ্বাস করা হয় না; সার্ভার SSLCommerz validation API ডেকে status, tran_id, currency (BDT) ও amount মিলিয়ে দেখে। Fail/cancel-কে payment-এর প্রমাণ ধরা হয় না।
- **Password ও OTP ভিত্তি শক্ত** — bcrypt (cost 12), কমপক্ষে ১২ অক্ষরের password (Node), login-এ session regenerate; OTP `crypto.randomInt` দিয়ে তৈরি, hash করে রাখা, ৫ মিনিট মেয়াদ, সর্বোচ্চ ৫ বার চেষ্টা, একবার ব্যবহারযোগ্য।
- **ছবি upload যাচাই ভালো** — size মিলিয়ে দেখা, magic-byte দিয়ে আসল ফাইল টাইপ যাচাই, সার্ভারের বানানো ফাইলের নাম (path traversal-এর সুযোগ নেই)।
- **Frontend-এ XSS-এর পথ পাওয়া যায়নি** — `dangerouslySetInnerHTML` কোথাও নেই; order-এর মোট দাম client পাঠায় না, সার্ভার নিজে হিসাব করে।
- **কোথাও আসল সিক্রেট/পাসওয়ার্ড নেই** — `.env.example` ও `config.example.php` শুধু placeholder।
- Docker app non-root user-এ চলে; compose-এ healthcheck আছে; `validate.yml` push/PR-এ syntax + catalog + API test + build চালায়।

---

## পরামর্শ — কোন ক্রমে ঠিক করবে

1. **সবার আগে (live করার আগে অবশ্যই):** ১ (stock), ২ (payment init auth), ৩ (phone reset), ৫ (.gitignore)।
2. **তারপর:** ৪ (demo listing gate), ১০ (per-phone OTP সীমা), ১১ (ফোন নম্বর সুরক্ষা), ১২ (analytics সীমা)।
3. **সিদ্ধান্ত দরকার:** InfinityFree/PHP সংস্করণটা রাখবে কিনা — রাখলে ৬, ৭, ৮, ২২–২৫ ঠিক করতে হবে; না রাখলে সেটা project থেকে সরিয়ে দিলেই অনেক জটিলতা কমে।
4. **সুবিধামতো:** বাকিগুলো ধাপে ধাপে।
