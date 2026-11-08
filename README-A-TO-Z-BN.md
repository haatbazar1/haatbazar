# HaatBazar — A to Z

বাংলাদেশের খুচরা ও পাইকারি অনলাইন মার্কেটপ্লেস। এই repo-তে HaatBazar ওয়েবসাইটের সবকিছু সাজানো আছে: আসল কোড (সব নিরাপত্তা fix সহ), deploy-এর সব গাইড, ডাটাবেস seed, আর প্রকল্পের পুরো ইতিহাস।

## এই repo-তে যা যা আছে

| অংশ | বর্ণনা |
|---|---|
| `src/`, `server.js`, `server/` | React/Vite frontend + Node/Express backend (আসল ওয়েবসাইট) |
| `render.yaml` | Render.com-এ এক ক্লিকে deploy-এর Blueprint |
| `Dockerfile`, `docker-compose.yml` | VPS-এ চালানোর জন্য |
| `infinityfree/` | PHP/MySQL সংস্করণ (InfinityFree-র জন্য) |
| `database/` | ডাটাবেস সম্পর্কিত ফাইল |
| `DEPLOY-GUIDE-BN.md` | Render deploy-এর ধাপে ধাপে বাংলা গাইড |
| `FIXES-2026-11-08.md` | 2026-11-08-এ করা সব নিরাপত্তা fix-এর তালিকা |
| `milon-docs/ADMIN-GUIDE-BN.md` | Admin panel দিয়ে সাইট রক্ষণাবেক্ষণের গাইড |
| `milon-docs/code-review-report.md` | পুরো কোড রিভিউ রিপোর্ট (8টি বড় সমস্যা সহ) |
| `milon-docs/seed-products.sql` | 24টি starter পণ্যের SQL |
| `milon-docs/setup-and-seed.sql` | PHP সংস্করণের টেবিল + পণ্য একসাথে বসানোর SQL |
| `docs/` | প্রকল্পের নিজস্ব আগের ডকুমেন্ট |
| `.env.example` | পরিবেশ variable-এর **নমুনা** — এখানে কখনো আসল মান বসবে না |

## Live সংস্করণগুলো

1. **Render (আসল full live — পরিকল্পনায় আছে):** Node সংস্করণ। `render.yaml` দিয়ে deploy হবে। দরকার: Render account, card, আর dashboard-এ env মান (নিচের checklist)। Service: Oregon region-এ তৈরি করা আছে।
2. **InfinityFree / PHP (preview):** https://haatbazar1.kesug.com — টেবিল তৈরি ও 24টি পণ্য database-এ আছে। শেষ ধাপ বাকি: `htdocs/config.php`-তে database-এর **আসল password** বসানো (এখন placeholder আছে), তাহলেই API পণ্য দেখাবে।
3. **GitHub Pages demo (শুধু design দেখার):** https://milonpro48-ux.github.io/haatbazar/ — এখানে admin panel simulated, আসল data নেই।
4. **Muse app সংস্করণ:** Muse-এর ভিতরে পূর্ণাঙ্গ HaatBazar app (মালিক প্যানেল সহ) — সেখান থেকে public live link বানানো হচ্ছে।

## Render env checklist (আসল মান শুধু Render dashboard-এ)

`NODE_ENV=production`, `NODE_VERSION=20`, `DATA_DIR=/var/data`, `SESSION_SECRET` (লম্বা random), `PUBLIC_BASE_URL`, `ADMIN_EMAIL`, `ADMIN_PASSWORD` (শক্ত), `BUSINESS_LEGAL_NAME`, `BUSINESS_ADDRESS`, `BUSINESS_PHONE`, `SUPPORT_EMAIL`, `TRADE_LICENSE_NO`। ঐচ্ছিক: `SSLCOMMERZ_*`, `SMS_*`, `COURIER_*`।

## ⚠️ নিরাপত্তা — জরুরি নিয়ম

- **আসল password/secret কখনো এই repo-তে (বা কোনো git repo-তে) commit করা যাবে না।** `.env.example`-এ শুধু placeholder থাকবে।
- আগের repo-তে (milonpro48-ux/haatbazar) 2026-11-08-এ একবার ভুলে আসল `ADMIN_PASSWORD` ও `SESSION_SECRET` commit হয়ে গিয়েছিল। সেগুলো Render-এ **নতুন করে বদলানো (rotate) হয়েছে কিনা নিশ্চিত হয়ে নাও** — না হলে এখনই বদলাও। Git history থেকে পুরোনো মান সম্পূর্ণ মোছা কঠিন, তাই rotate করাই আসল সুরক্ষা।
- WhatsApp (order-এর জন্য): **01629152161** — এটি site-এ public যোগাযোগ নম্বর হিসেবে ব্যবহৃত হয়।

## যোগাযোগ

মালিক: Milon — WhatsApp: 01629152161
