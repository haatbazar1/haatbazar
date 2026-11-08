# HaatBazar — Admin Guide (Bangla)

Live site-e (Render) admin panel theke kivabe website maintain korba, tar sohoj guide.
(Mone rekho: GitHub Pages-er demo admin panel sajano — asol kaj hobe live site-e.)

## Login
- Address: tomar live site-er `/admin` (jemon https://tomar-site.onrender.com/admin)
- Login: Render env-te bosano `ADMIN_EMAIL` ar `ADMIN_PASSWORD`
- Demo password (HaatBazarDemo!2026) ekhane cholbe na — oita sudhu public demo-r.

## Dashboard-e ja dekhte parba
- Mot active listing, mot user, mot order
- Sesh 7 dine listing view ar contact (buyer-ra kotojon jogajog koreche)
- Samprotik listing-er talika — pase status bodlanor option

## Protidiner maintain-er kaj

### 1. Order porichalona
- Notun order gula ek jaygay dekhte parba (buyer-er nam, phone, thikana, ponno, poriman)
- Order ship kora — courier booking (courier credential env-te thakle kaj korbe)
- Delivery status refresh kore latest obostha jana

### 2. Bikreta (seller) jachai
- Seller-ra business name + NID-er ses 4 digit diye abedon kore
- Tumi **Approve / Reject / Pending** rakhhte parba, sathe note dite parba
- Jachai chara seller-der upor nojor rakha-i site-er bissas

### 3. Listing moderation
- Jekono listing **Active / Paused / Sold / Removed** korte parba
- Vul, nishiddho ba sold-out ponno pele pause/remove kore dao
- Seller nijeo tar account theke nijer listing-er status bodlate pare

### 4. Analytics (porisongkhan)
- Sesh 7 diner: view, contact, contact-rate, order-rate
- Top category ar top listing — kon ponno beshi dekha hocche
- Notun seller sonkhya, fire-asa visitor
- Marketing khoroch bosale **proti contact-e khoroch** (cost per contact) hisab dekhay

## Admin panel theke ja hobe NA (egula Render/GitHub theke)
- Payment (SSLCommerz), SMS, courier credential — Render-er Environment-e bosate hoy
- Business-er tothyo (legal name, address, trade licence) — env theke ashe, site-er legal page-e dekhay
- Admin password bodol — env-te `ADMIN_PASSWORD` bodle save korlei hobe
- Notun feature/ba code bodol — GitHub repo theke push korle Render auto deploy kore

## Nirapotta tips
- Admin password karo sathe share koro na; demo password kokhono live-e use koro na
- Majhe majhe seller jachai ar order list check kora obhyas rakho
- Sondhehojonok listing dekhlei age pause kore pore jachai koro
