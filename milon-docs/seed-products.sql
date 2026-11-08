-- ============================================================
-- HaatBazar — InfinityFree (PHP/MySQL) version-er jonno starter ponno
-- Site: https://haatbazar1.kesug.com
-- Kivabe bosabe: InfinityFree control panel -> MySQL Databases -> phpMyAdmin
--   -> tomar database select koro -> opore "SQL" tab -> ei puro file-er
--   lekha paste kore "Go" chap dao. Tarpor site refresh korlei demo
--   banner chole giye ei ponno gula dekhabe.
--
-- ⚠️ JORURI: Nicher sellerName, businessName ar phone ekhon nomuna hishebe
-- deya. Site sobar jonno share korar AGE phone-e tomar asol number ar
-- nam-e tomar asol nam/dokaner nam bosiye nio (Find & Replace korei hobe).
-- Phone ekhon: 01000000000 (placeholder)
--
-- Abar chalate chaile age purono seed muchte paro (tokhon nicher line-er
-- surur "--" tule diye age oita chalao):
-- DELETE FROM listings WHERE id LIKE 'seed-%';
-- ============================================================

SET NAMES utf8mb4;

INSERT INTO listings
(id, user_id, title, category, subcategory, district, upazila, price, unit, quantity, negotiable, sellerName, businessName, description, images, phone, saleType, minOrderQuantity, deliveryAvailable, status, created_at)
VALUES
('seed-001', NULL, 'Samsung Galaxy A55 5G (8GB RAM, 128GB)', 'electronics', 'মোবাইল ফোন', 'ঢাকা', 'মিরপুর', 38500, 'piece', 25, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'অফিসিয়াল ওয়ারেন্টি সহ নতুন স্মার্টফোন। Super AMOLED ডিসপ্লে, 50MP ক্যামেরা। ক্যাশ অন ডেলিভারি সুবিধা আছে।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 1 DAY),
('seed-002', NULL, 'HP ProBook 440 G10 ল্যাপটপ (Core i5, 16GB RAM, 512GB SSD)', 'electronics', 'কম্পিউটার ও ল্যাপটপ', 'ঢাকা', 'উত্তরা', 68500, 'piece', 10, 1, 'HaatBazar Seller', 'HaatBazar Official Store', 'অফিস ও ফ্রিল্যান্সিং কাজের জন্য উপযুক্ত ল্যাপটপ। 14 ইঞ্চি FHD ডিসপ্লে, 1 বছর সার্ভিস ওয়ারেন্টি।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 2 DAY),
('seed-003', NULL, 'ঢাকাই জামদানি শাড়ি — হাতে বোনা', 'fashion', 'শাড়ি ও থ্রি-পিস', 'নারায়ণগঞ্জ', 'রূপগঞ্জ', 4500, 'piece', 40, 1, 'HaatBazar Seller', 'HaatBazar Official Store', 'ঐতিহ্যবাহী ঢাকাই জামদানি, দক্ষ তাঁতির হাতে বোনা। পাইকারি অর্ডারে বিশেষ ছাড়।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 1 DAY),
('seed-004', NULL, 'পুরুষদের চামড়ার লোফার জুতা (সব সাইজ)', 'fashion', 'জুতা ও স্যান্ডেল', 'চট্টগ্রাম', 'পাহাড়তলী', 1450, 'piece', 60, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'আসল চামড়ার তৈরি আরামদায়ক লোফার। সাইজ 39-44 পর্যন্ত পাওয়া যাবে।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 3 DAY),
('seed-005', NULL, 'সেগুন কাঠের ডাবল খাট (৬ x ৭ ফুট)', 'home-kitchen', 'সোফা ও খাট', 'গাজীপুর', 'টঙ্গী', 32000, 'piece', 5, 1, 'HaatBazar Seller', 'HaatBazar Official Store', 'শুকনো সেগুন কাঠের মজবুত খাট, পালিশ সহ। ঢাকার ভিতরে ডেলিভারি ও সেটআপ ফ্রি।', '[]', '01000000000', 'retail', 1, 1, 'active', NOW() - INTERVAL 4 DAY),
('seed-006', NULL, 'অ্যালুমিনিয়াম প্রেশার কুকার ৫.৫ লিটার', 'home-kitchen', 'রান্নাঘরের সামগ্রী', 'ঢাকা', 'কেরানীগঞ্জ', 1650, 'piece', 80, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'ভারী গেজের অ্যালুমিনিয়াম প্রেশার কুকার, সেফটি ভালভ সহ। পাইকারি নিলে দাম কমবে।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 2 DAY),
('seed-007', NULL, 'নাজিরশাইল চাল — প্রিমিয়াম (২৫ কেজি বস্তা)', 'grocery', 'চাল, ডাল ও শস্য', 'নওগাঁ', 'সদর', 1950, 'bag', 200, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'ঝরঝরে ও সুগন্ধি নাজিরশাইল চাল। দোকান ও হোটেলের জন্য পাইকারি সরবরাহ করা হয়।', '[]', '01000000000', 'wholesale', 5, 1, 'active', NOW() - INTERVAL 1 DAY),
('seed-008', NULL, 'খাঁটি সরিষার তেল (৫ লিটার বোতল)', 'grocery', 'তেল ও মসলা', 'বগুড়া', 'শেরপুর', 1250, 'piece', 150, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'ঘানিতে ভাঙানো খাঁটি সরিষার তেল, কোনো ভেজাল নেই। রান্না ও আচারের জন্য উপযুক্ত।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 5 DAY),
('seed-009', NULL, 'ব্রি ধান ২৮ (মণ প্রতি পাইকারি)', 'agriculture', 'ধান ও চাল', 'দিনাজপুর', 'সদর', 1450, 'maund', 500, 1, 'HaatBazar Seller', 'HaatBazar Official Store', 'শুকনো ও পরিষ্কার ব্রি ধান ২৮। মিলার ও আড়তদারদের জন্য ট্রাক লোড সরবরাহ সম্ভব।', '[]', '01000000000', 'wholesale', 50, 0, 'active', NOW() - INTERVAL 3 DAY),
('seed-010', NULL, 'হাইব্রিড টমেটো বীজ (১০ গ্রাম প্যাকেট)', 'agriculture', 'বীজ', 'রাজশাহী', 'পবা', 350, 'piece', 300, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'উচ্চ ফলনশীল হাইব্রিড টমেটো বীজ, অঙ্কুরোদগম হার ৯০%+। কৃষকদের জন্য বিশেষ পরামর্শ ফ্রি।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 6 DAY),
('seed-011', NULL, 'দেশি দুধেল গাভী (দৈনিক দুধ ৮-১০ লিটার)', 'livestock-poultry-fish', 'দুধেল গাভী', 'সিরাজগঞ্জ', 'শাহজাদপুর', 95000, 'piece', 3, 1, 'HaatBazar Seller', 'HaatBazar Official Store', 'সুস্থ ও টিকা দেওয়া দেশি গাভী, বর্তমানে দৈনিক ৮-১০ লিটার দুধ দিচ্ছে। খামারে এসে দেখে নিতে পারবেন।', '[]', '01000000000', 'retail', 1, 0, 'active', NOW() - INTERVAL 2 DAY),
('seed-012', NULL, 'লেয়ার মুরগি — ডিম পাড়া (প্রতি পিস)', 'livestock-poultry-fish', 'মুরগি ও হাঁস', 'ময়মনসিংহ', 'ত্রিশাল', 480, 'piece', 200, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'ডিম উৎপাদন শুরু করা লেয়ার মুরগি। সর্বনিম্ন অর্ডার ৫০ পিস, খামার থেকে সংগ্রহ করতে হবে।', '[]', '01000000000', 'wholesale', 50, 0, 'active', NOW() - INTERVAL 4 DAY),
('seed-013', NULL, 'পাওয়ার টিলার ১২ হর্সপাওয়ার (ডিজেল)', 'machinery', 'কৃষিযন্ত্র', 'যশোর', 'সদর', 68500, 'piece', 8, 1, 'HaatBazar Seller', 'HaatBazar Official Store', 'জমি চাষের জন্য শক্তিশালী পাওয়ার টিলার, 1 বছর ইঞ্জিন ওয়ারেন্টি ও ফ্রি সার্ভিসিং।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 7 DAY),
('seed-014', NULL, 'ইলেকট্রিক ড্রিল মেশিন ৭৫০ ওয়াট', 'machinery', 'পাওয়ার টুলস', 'ঢাকা', 'তেজগাঁও', 2850, 'piece', 45, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'কংক্রিট ও কাঠে ছিদ্র করার ড্রিল মেশিন, বিট সেট সহ। ওয়ার্কশপ ও বাসার কাজে উপযোগী।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 3 DAY),
('seed-015', NULL, 'Bajaj Pulsar N160 (২০২৩ মডেল, ব্যবহৃত)', 'vehicles', 'মোটরসাইকেল', 'খুলনা', 'সোনাডাঙ্গা', 165000, 'piece', 1, 1, 'HaatBazar Seller', 'HaatBazar Official Store', 'এক হাতে চালানো, মাত্র ৯,৫০০ কিমি চলেছে। কাগজপত্র হালনাগাদ, নাম পরিবর্তন সম্ভব।', '[]', '01000000000', 'retail', 1, 0, 'active', NOW() - INTERVAL 5 DAY),
('seed-016', NULL, 'গাড়ির ব্যাটারি ১২V ৭০Ah (১৮ মাস ওয়ারেন্টি)', 'vehicles', 'টায়ার ও ব্যাটারি', 'ঢাকা', 'মিরপুর', 9500, 'piece', 30, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'প্রাইভেট কার ও মাইক্রোবাসের ব্যাটারি, পুরনো ব্যাটারিতে এক্সচেঞ্জ ছাড় আছে।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 6 DAY),
('seed-017', NULL, '৬০ গ্রেড রড (টন প্রতি পাইকারি)', 'construction', 'রড ও সিমেন্ট', 'নারায়ণগঞ্জ', 'সিদ্ধিরগঞ্জ', 92000, 'ton', 50, 1, 'HaatBazar Seller', 'HaatBazar Official Store', 'BSTI অনুমোদিত ৬০ গ্রেড রড। প্রজেক্ট সাইটে ডেলিভারি দেওয়া হয়, কমপক্ষে ২ টন অর্ডার।', '[]', '01000000000', 'wholesale', 2, 1, 'active', NOW() - INTERVAL 4 DAY),
('seed-018', NULL, 'প্রথম শ্রেণীর ইট (হাজার প্রতি)', 'construction', 'ইট ও বালু', 'মুন্সিগঞ্জ', 'সদর', 11500, 'piece', 100000, 1, 'HaatBazar Seller', 'HaatBazar Official Store', 'ভাটার প্রথম শ্রেণীর ইট, ভাঙন কম। দাম হাজার প্রতি, ট্রাকভাড়া আলাদা।', '[]', '01000000000', 'wholesale', 1000, 1, 'active', NOW() - INTERVAL 8 DAY),
('seed-019', NULL, 'ভিটামিন সি ফেস সিরাম ৩০ মি.লি.', 'beauty', 'ত্বকের যত্ন', 'ঢাকা', 'ধানমন্ডি', 650, 'piece', 120, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'সব ধরনের ত্বকের জন্য ভিটামিন সি সিরাম। আসল পণ্য, মেয়াদ উত্তীর্ণের তারিখ প্যাকেটে দেওয়া।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 2 DAY),
('seed-020', NULL, 'আরবি উদ আতর (১২ মি.লি.)', 'beauty', 'পারফিউম', 'চট্টগ্রাম', 'কোতোয়ালী', 850, 'piece', 75, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'দীর্ঘস্থায়ী সুগন্ধির অ্যালকোহল-মুক্ত উদ আতর। উপহার হিসেবেও চমৎকার।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 7 DAY),
('seed-021', NULL, 'এইচএসসি টেস্ট পেপার সেট (সব বিষয়)', 'books-office', 'পাঠ্যবই', 'ঢাকা', 'নীলক্ষেত', 780, 'set', 90, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'সর্বশেষ সিলেবাস অনুযায়ী সব বিষয়ের টেস্ট পেপার ও মডেল টেস্ট, সমাধান সহ।', '[]', '01000000000', 'both', 1, 1, 'active', NOW() - INTERVAL 3 DAY),
('seed-022', NULL, 'A4 কাগজ ৮০gsm (প্রতি রিম)', 'books-office', 'খাতা ও কাগজ', 'রাজশাহী', 'সদর', 520, 'piece', 400, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'অফিস ও প্রিন্টের জন্য ৮০gsm A4 কাগজ। ১০ রিমের বেশি নিলে পাইকারি দাম।', '[]', '01000000000', 'both', 10, 1, 'active', NOW() - INTERVAL 5 DAY),
('seed-023', NULL, 'পিকআপ ভাড়া — ঢাকার ভিতরে (ট্রিপ প্রতি)', 'services-rentals', 'পরিবহন ও ডেলিভারি', 'ঢাকা', 'যাত্রাবাড়ী', 2500, 'piece', 10, 1, 'HaatBazar Seller', 'HaatBazar Official Store', 'বাসা বদল ও মালামাল পরিবহনের জন্য ১ টন পিকআপ, চালক সহ। আগে বুকিং দিলে সময়মতো পৌঁছে যাবে।', '[]', '01000000000', 'retail', 1, 0, 'active', NOW() - INTERVAL 1 DAY),
('seed-024', NULL, 'এসি সার্ভিসিং ও গ্যাস রিফিল (বাসায় গিয়ে)', 'services-rentals', 'মেরামত সেবা', 'সিলেট', 'সদর', 1500, 'piece', 20, 0, 'HaatBazar Seller', 'HaatBazar Official Store', 'অভিজ্ঞ টেকনিশিয়ান বাসায় গিয়ে এসি সার্ভিসিং, গ্যাস রিফিল ও মেরামত করে। ৩০ দিনের সার্ভিস গ্যারান্টি।', '[]', '01000000000', 'retail', 1, 0, 'active', NOW() - INTERVAL 6 DAY);

-- Ses. Site-e giye refresh kore dekho: demo banner chole giye ei 24-ta ponno dekhabe.
