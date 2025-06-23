-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.40 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for mod_keyboard
DROP DATABASE IF EXISTS `mod_keyboard`;
CREATE DATABASE IF NOT EXISTS `mod_keyboard` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mod_keyboard`;

-- Dumping structure for table mod_keyboard.black_list_tokens
DROP TABLE IF EXISTS `black_list_tokens`;
CREATE TABLE IF NOT EXISTS `black_list_tokens` (
  `id` char(36) NOT NULL,
  `expired_at` datetime(6) NOT NULL,
  `jid` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.black_list_tokens: ~3 rows (approximately)
DELETE FROM `black_list_tokens`;
INSERT INTO `black_list_tokens` (`id`, `expired_at`, `jid`) VALUES
	('04a1bf8e-4d84-4eda-a1bf-8e4d84dedaed', '2025-07-02 08:34:31.000000', '5b266b25-9da1-4a0b-a3ec-133183c96e25'),
	('356f37bc-d57f-4e6e-af37-bcd57fae6e95', '2025-09-09 15:38:26.000000', 'b49706af-9a1b-4a33-bd04-442792fca9b7'),
	('891ca937-8321-4ef5-9ca9-378321aef562', '2025-07-02 07:57:17.000000', 'dd1de778-4e48-4bde-9bac-c70cf363c91c'),
	('8f54109b-047d-4f8d-9410-9b047d6f8d5a', '2025-09-09 15:39:25.000000', 'a0d6fa6d-a600-4700-b038-13b5fc2352af'),
	('a909ed4a-e4eb-4bb3-89ed-4ae4ebcbb378', '2025-07-02 09:45:24.000000', '16ecd5eb-be83-4c83-8c06-d035b3a4367d'),
	('ab9068f0-5b17-4cd8-9068-f05b17fcd800', '2025-07-02 08:57:08.000000', '9b615ebf-f176-4e83-a8fe-ff4356412504'),
	('b1df2d87-07d9-4998-9f2d-8707d9199807', '2025-09-09 15:39:50.000000', '733c5b73-8640-4266-bea0-ed932a1031e4'),
	('c1975246-48ad-442e-9752-4648ad442e6a', '2025-07-02 09:27:47.000000', '7fa9f54f-d07e-450f-8ec3-4ae01cbc8c0d'),
	('ce8b2493-720b-4a51-8b24-93720b3a5199', '2025-07-02 08:28:44.000000', '884e3505-5113-4524-9121-4cb6adef7793'),
	('df1a47b0-96bf-412d-9a47-b096bf412d92', '2025-07-02 08:40:15.000000', 'c4dc25ef-43e2-4c41-a7b3-64739777818e');

-- Dumping structure for table mod_keyboard.carts
DROP TABLE IF EXISTS `carts`;
CREATE TABLE IF NOT EXISTS `carts` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK64t7ox312pqal3p7fg9o503c2` (`user_id`),
  CONSTRAINT `FKb5o626f86h46m4s7ms6ginnop` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.carts: ~0 rows (approximately)
DELETE FROM `carts`;
INSERT INTO `carts` (`id`, `user_id`) VALUES
	('963c7d5f-38cd-4b09-bc7d-5f38cdeb0908', '47eb85db-efe3-4750-ab85-dbefe3c750e4'),
	('ba494ff4-53e5-4a08-894f-f453e51a08ae', 'cf5e9b94-5380-49ed-b27e-0bb6ff45173f');

-- Dumping structure for table mod_keyboard.cart_items
DROP TABLE IF EXISTS `cart_items`;
CREATE TABLE IF NOT EXISTS `cart_items` (
  `id` char(36) NOT NULL,
  `quantity` int NOT NULL,
  `cart_id` char(36) NOT NULL,
  `product_id` char(36) NOT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FKpcttvuq4mxppo8sxggjtn5i2c` (`cart_id`),
  KEY `FK1re40cjegsfvw58xrkdp6bac6` (`product_id`),
  CONSTRAINT `FK1re40cjegsfvw58xrkdp6bac6` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKpcttvuq4mxppo8sxggjtn5i2c` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.cart_items: ~0 rows (approximately)
DELETE FROM `cart_items`;
INSERT INTO `cart_items` (`id`, `quantity`, `cart_id`, `product_id`, `updated_at`) VALUES
	('20205ca4-49c2-42a6-a05c-a449c2e2a66c', 2, '963c7d5f-38cd-4b09-bc7d-5f38cdeb0908', '0419857e-9a52-44be-833a-dcc0760aaee4', '2025-06-23 00:57:21'),
	('6a275e8a-08d9-4f7b-a75e-8a08d99f7b72', 2, '963c7d5f-38cd-4b09-bc7d-5f38cdeb0908', '2560c61b-617c-42d9-a574-2854f76c6d0c', '2025-06-23 02:00:59'),
	('baaf098d-7f93-4acf-af09-8d7f930acf83', 4, '963c7d5f-38cd-4b09-bc7d-5f38cdeb0908', '03e29503-e3fc-4668-8785-865ad7953063', '2025-06-23 00:57:39');

-- Dumping structure for table mod_keyboard.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` char(36) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.categories: ~3 rows (approximately)
DELETE FROM `categories`;
INSERT INTO `categories` (`id`, `created_at`, `description`, `is_deleted`, `name`) VALUES
	('6233447a-56ac-4130-b344-7a56acc13062', '2025-04-08 11:20:16.024404', NULL, 0, 'Bàn phím văn phòng'),
	('65929f3a-6c22-4240-929f-3a6c22d2403a', '2025-04-08 11:20:16.024404', NULL, 0, 'Bàn phím gaming'),
	('b4c1438b-becf-4ff8-8143-8bbecfeff813', '2025-04-08 11:20:16.024404', NULL, 0, 'Switch'),
	('ee7d6ef3-67e7-41c1-bd6e-f367e751c15c', '2025-06-23 09:33:40.671427', 'tet', 0, 'test123');

-- Dumping structure for table mod_keyboard.comments
DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` char(36) NOT NULL,
  `content` varchar(2200) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `updated_at` datetime(6) DEFAULT NULL,
  `parent_comment_id` char(36) DEFAULT NULL,
  `product_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7h839m3lkvhbyv3bcdv7sm4fj` (`parent_comment_id`),
  KEY `FK6uv0qku8gsu6x1r2jkrtqwjtn` (`product_id`),
  KEY `FK8omq0tc18jd43bu5tjh6jvraq` (`user_id`),
  CONSTRAINT `FK6uv0qku8gsu6x1r2jkrtqwjtn` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FK7h839m3lkvhbyv3bcdv7sm4fj` FOREIGN KEY (`parent_comment_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `FK8omq0tc18jd43bu5tjh6jvraq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.comments: ~0 rows (approximately)
DELETE FROM `comments`;
INSERT INTO `comments` (`id`, `content`, `created_at`, `is_deleted`, `updated_at`, `parent_comment_id`, `product_id`, `user_id`) VALUES
	('23760bb4-18a8-4466-b60b-b418a8d466ae', 'safeadfsawafdwf', '2025-06-23 08:53:45.488985', 0, '2025-06-23 08:53:45.488985', NULL, '0419857e-9a52-44be-833a-dcc0760aaee4', '47eb85db-efe3-4750-ab85-dbefe3c750e4');

-- Dumping structure for table mod_keyboard.key_pairs
DROP TABLE IF EXISTS `key_pairs`;
CREATE TABLE IF NOT EXISTS `key_pairs` (
  `id` char(36) NOT NULL,
  `private_key` varchar(5000) NOT NULL,
  `public_key` varchar(5000) NOT NULL,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKtg81i0yafvudpmj4rcm6c6gkn` (`user_id`),
  CONSTRAINT `FK3uqrdeik3c6sy5jnwputlptir` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.key_pairs: ~3 rows (approximately)
DELETE FROM `key_pairs`;
INSERT INTO `key_pairs` (`id`, `private_key`, `public_key`, `user_id`) VALUES
	('629ddde5-bb44-4ee8-9ddd-e5bb44dee8a4', 'T1QJ4LyRAyZDHMgBZsKvJu7ObGZdcd2WyhxJAm7vdG9Y2NkygviJgYBRoea2HQ10j5wMQC3KQFKY6HW9QJecC1aIfjjjvS_yac6QwGLmel7lzqPVVZKk4GO12eglRummwEuK_Jjf3eKybZ725Q_z_13V84IDXm_hOFgE9yoF4X7gv8kHamrL2pGKiDelyz_t4nh5qyMVFetmZ75K_kngUztETIbgbvNIjycfD5NiOt0MObnqRdm43tv2rE7cTFKZMtyExRPhOf2OYqBO_SCruQAYgHr0Yn5VEsY2j6kY7uqCoP0Mn-7sIjODVMqoG08hp-emRfi_odWDOGg6GS9-4aIjKvM-SkcO0yyoFfA--ZxnaA60URP-JHDw04X0fDcC6Pliy5i4XZ81Ppdl9XyeQIQ-uWx7XtHb7_gOS-iBS-kwNSxIzBDoFVzLzujw_k2ZrZumACUahlZZAsvgRvvpLu25Zl6xiEADuAbNJvm3ptzR0UhWEwsULVfOuNlcqwE8fIg5MaYKwfW25rCocUzD3eHZLiWcVvDtlxVPsyZ0xKLga8C05zmup5-IYwKuhf9DNpMBFTjyKXNwa3Uiw-hLBDurhgL8uIOgA1vHCkHJUeRAQ1KIEPvUVDCoV2qR0jQC97EnbrgQrdr1gXCA8anZW8IV-PMINuGzEstCbiTXSU3NNHZxS2K6UdACX9U0f0w4wuvBkkRo90NaTq6usS7qUG5OAkdExpRExXCwGOwJWwt7mtxQS2PxZTQicEUPfCySrxTdHEawA6EfbTFSu3zeiZMLrFzDiHNbJiWJkgA3jihjImJobju8nOaebENBtjqZToTEIDQFZujdG52KaiH41XvjXFQtjzcZpKHaHT7NzGYtS97MVGxLsL-zvdvtUhJPv93RSl1szJsTtBOlDX9tOUNvE056oLoPFBdSzi-q4J864S3jNfHAuuQrhpV5a0sPcB3QA9S2kfsQ3zv4naL5Z8x_76oHZhlTUiVafcN1PNO2kPbSFUJQP7VDDCozE8YCHLnwKOtBAtRNutKjruco7n6vbhbg9LGZC_dq_SiTAj5lfjdqOddZU0ZMPnKqS9UwvmURiVFn54xCACfNoNWim01M8ipKCltmyEtlW63fbtYAKDeaAeNGb-X4Rl1fCHhO1qaPipiY9530T7EJzJ1yhVFn1Bt5fa3r1rpB-Cmj-uq8II6RFC9osyrXpxuYheSRxR21ww9aVyTsitp108hKsNIm8zQNxebewuVnnXy5F_SvrSGrPfiv9pPExYo5B_AqGW3x1Vb8pxhi697xL5l_Obd2ViDHIGtNKkcyHD15PQQUuWReSYNS787kA2L0YSeljj_uqGKZ7IeNAIrXupWf8OViu7WL2a6HWj4iHOJcViv9sDqFVfAkwMEfAPbWtbKI0mHlR7_pfAvkyj_5ZnAZeI0VVR-YAHTu48rRQL3TaAEz-3l1KXZCVFGkvbugknXEfiTm-ABwtKlWVk1ADqp9w486xt2mkHcAHU_5Zek4lUKn2U79leztDZpA_70RrXS9HdVxL6X_3Fbn1EjKl9_jlolC0WKVdYL5NEBh7A8MezjYkyXOQEUvRZbsCGLP9TrjHrk5hUz0wrQmqsE2iU3VxqTvIfCyJ9ZD__sfTKHxesdC5-3l_NHyCeQxeOL_EBbXnjsA_Kv9THCM8y0Zfv5zVmTcFyy4y2gC9axefIj3zQoZ8HWZ-aSGIZHpLrKPpsNsj7P7d_dhJ1KHaXDwR7u8XmFyNn4MwGINqQeO8VC_CbA6AuqmBftDiOBUSpmPXxAqLi9bvmxCxxIz3kf1ez3IwC5j9hFwrJBd80EIVsTz6ozN7No59JzqVBt1fTcWTrXHuAWf7r3C90QvWmBLOcPnk_oP1HgPDe5OQrbi_DLxcrosoT9H2zOw2V1oDVnBPMlWOc5TpeTuUPcW9B2Tp1DzeNqthzsyU5QEh-PoC7T9WyHFnQT2u6cJWNrLrphfZDKSYtMv2sZIedDtbdlUd9r4NkTV57htspOQwlV8UtfLuZrNwMihpZBSjl9RCESn1W6xpM_wT_4sYAJhMYf_7TjFN8A7DE2-JJ33x5nAw9o31AJGMeBNncb-gi9Se3VikarDPRGhYIQbollfKmmSsnt7oKO_b5yOcmDEEE00ZmUT8xafqf9I5Ira8x-6JtBvsLafQ9Do7C4T1IG_dOCp92L6aA', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8yV/pNSXXr4/fr3I/PC3a5fTtmyo5pj7wWShQUGdqoEPLFClvyxmavvLMxuldayl2hO2uxvuOD8lDo3EOmPMTxtpzNCt2quFiRJWIGrBPqhY8E6+7Khie8KMw0oeUi1x7ZT/BR69faPta2BnhcrL5U/GLniTWdJRu0waj94yBaRa3mUUi+GzWi9HnwHM85Ook+7IaYKkyXfkouvTYFR1vNa5MKapLsZv4UG2nVcP5uIE1Vq34yewGh4eUGu5jWGRgy2z2hcjBGZGMqn/6u8N6CZgNo9R8Jzm8zMmKPZUhiUXVdWl/J5kT6DlrzxqXavH4mjryXIuKpHWWQZSPJMfZwIDAQAB', '4c252a59-8a16-455e-a52a-598a16e55e74'),
	('65929f3a-6c22-4240-929f-3a6c22d2403a', 'QyidlYhOiw8mm3bKJDH2Rl3cjBOd4_kXryqk0JI4426IT5b0IVuWD2fGvGpTVm2WCAGDT6RJUpYGNRmkKlLkOuz_Piy6PkNb0PcQUVC7dAafEB2_JuzzLNM2iPN4DlQjuhVOnvC5iqmZpasp_X5Kkhhp9gcZM0tkauuewbIUY6WmjH4JMfM5NzORkq9_0WchuXyNwgY5ZqRQFhUGWucf4MdsrTMROnVxVZkzQfD9kQ-88odEQf7KBNe-mXTqY6nffTQbJ0Qo7ixxsPUjU8kIV2OcPsTF3yUixQPXJRbUFEdgTHBTRWqBpAoYIoiX7h88fiipNOG1280X3Fyto-sxBDqZuKDRg87gGf8QoXa0sxxrBEKGGEW3VjjEKX16kq7eZtxNXGI7NnROYLkrRzeHbe4Q1KWHHDYWZ5bfl9kVcY-I7dGrJcx8-EOV2HW_btEvj0cvYt6i-N-bGgjqfSiC89ZKlUGmm91siEEmAK8qhM7R0Ef5YwEEl9Qdgvdloz68iKZrSj_6fn6zFwG9MCssTJBwu5AkxU38m5j_oP4pt2Cj2IwGdtMa2q9X28eCzMaMHxyufY8j4vrYZ_1z7xI2dLBSxYaIQ5UvXCxWltgujA_0ogbI_xb_IC_EHp3N_NIv9me0hsbGSzvxZwyiZV-05NuRZWmFxx6grW8TCoLEz14iLFEWV8HJdtmHnKJ1dX3EN8j79UBG7DyMPagO3JyCptYiGnZYvoCxRySLAAP2lagp2vxphUFzzICigPydfOKjkf4JtwnmRaGNKCozxYCcVV2MXvOAWgjNgDBjCks33P-KRVGHMYMtdOn3OaGbacabtkRt4GGSHSeu9_TxX183C5HiEICBhjRZAGoGTTdQvwBeoYu0B-PyFN2zBzjXZyEELiyaf4YFp-3kxdLFXQW8JQte9hCXMTUAILCVxSYCHkdC13uZf0mENPTJa111Q836cQDROxOPiX0ZlIYUlIcBD1cQBcTvrt6qy0XGkk0zWjRpd8oZGW-vVVSzd7ptcfM_dCxKcjE8AUMD_T9TricOWyn0zQdDD7CfgoQwdqsRXlwRZRsASAhPbmB5uYhCRpHzkesLx5OkL4u9IIIHE1fv8KjZfImtOH3kGwSKeMriYebDSgUNk8j24Z4KqLopIo04s0ZHBWbbm3EX_U4r2eMrNR2DgNbwEHwmOCCw0ENhCITZAEmVTFQpbCm5lAkgrXCNCb15EzHjCxlL6_HCv4CFwJCX6gWFV3eKwjsk0Ie1VGZ3VgvSYaWO8nhBQIZXpTXb40a8f3GWkY3IIwOxWf5e3Uv33QwJNzvdy5A9Vq3wb-mWLQYGPY-5kkoBamHo_jxDbRmNSEVvbCpoLaMxGJ9HgqbvmjL93JJKdriMvbUMO-72JIM07nHSjrAAIu0CtQhGZtdhxvsOATDhkitZzqgzYDFYpQkWbjL70-ludDmxeXO0Zazuq-okz6b9k3bCAcs2JebG55VkfmDkWSr2X9EE9g4_9DsJ7UKK9rfiqf8-rGOND3UmeavHi_5QlT-xr-FhEhO4h4ZevbqD-iL08raS210xqWiPDRm-gtg_pd9kYBZEdJpXcmWPhATUjCL1vhI_iqNIARvHc9HKW_lir1FxMMHHpyyfEuRlBGSs0QMquZ7u0dj5QLiauoxmGfsAmiqwP4URU5yDeLSjPlyLFhLAZfFPG1sJ3isTxCkUTmE2r_WXf-darfKodzlLTgoHdJmk7XALLx0wYSIyBLx5z37h3Cm7vuD69Oqv9PuaM4buxgP7UMh9TQm5ex9S4CKoNyKry7Hw-mAlVDorUINvhToBLoc6e-JQL9yL8qBIjvQcwbOvj6ByvVtoXocpCt2gRaQyosIGBVrhvo8pRpRBNPikqL6wTMaH5zZ2ZYBvs-KvuEpuy7oT9mbWPbZFyq9-KDhfCfl6UiJNER1QiiA8hJ46GmnYprwOByJMLjCY9oMJY97hEN4qza7J2DHMcaqI22LIUAcCX57rK0ysooqQztXb6_Z4AhV9-1G9cHdw2F4SZfU8HGgr0U1eghumXAt2UyJ1TKBdHJjULK32IPRWfowDg10I_UNZQ417lQay5b3FbmX68HtthI8iWwuEz7kpyM-vce9s8pYXAtn9Icu9UlnKt87hebIvuURUEYu2-3V_K90Lasc7wHUuEqBDUyw2t2__HLnQEJEepE9pcjOOpYOdFw', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3uNZYNeLg4yfyYIFHP3Z9WMU73bz508MaX9ZYymom2vQ7zrxy2GlIZxiMlpRyL6kiQiIFLinHwnwIJTUsfTOJLHz8nBUxbom9if30YFCibo2WY62CbX9o/Bsd07Oqo0F/cIjTE8wMJCc9exBowuWWz7mtrtXN8NW6syPMT0mzbv6MQqc0+RoOJ021iZ1ymJV0WjCJw0IzpWP5Dc4X4rk95tkL+N7kZ8cXmsVp5RwzXgsdQmHrGXai3eOhqP+qZU6DSMX2mqXFhslCq+vjKkGF6E0G9Yjz95nlvgk9zqK0QV9/Igbx0L5a3Hr0SAToBUGe7UQZqj6SCJ8n04s1HwkOwIDAQAB', '73e60879-da83-4b23-a608-79da838b239f'),
	('b4c1438b-becf-4ff8-8143-8bbecfeff813', 'ERVV8CNTBQF84qX3UCzKCYKxCZJ21sEfeGTkBykFSq9aC1pED7UsHxC-g1bOP39eLafk6e32UDsEtXztvIRN9KVStKf2WkQ2iI1QxFJgJdkGJt5jrXpQpy8Ci1kpWKn4rPf09asFIjOXC6rodT05QW46X41-dlSJZVIM3QU-d0-WU1wv1LbJiKWF2My7CwdnINnnBnuT_ZIYfaglnUIAXXaTa2DHiJpxUuqmJwZGjPDAGWXi-XvfFCa-w2MFzSEY2DET3Vxp1_DtUGBQthO2gSFt0Bm7UNO72-Sr6WPwepqhDwNzIhljZysjJiw7m41K8dAy-xZlkeHjXyTJb0IJRSkWuHvkkk735x32A8JKMvJ437NnNV4Y40mN3nLkEGgVR2keRj4k1H2UyMv9TOj_3_3NLjt6hHoWxNDg3_6vcPK17DTCxuPhLueT2sS6THcMqRfgjxZf5O_cwi8HwKY1MXENimHXbwF5uDsOwSwbYR3l0BdQjeUryCSbClt5w874z4wACs9DE153AEMIV2QihFjDL8ZPI5zdQABmCaxWgL_6QVIvLem3ZAtP96Tze9vKcNpOxtnFSD-PPF1yvHgI94qzzedN3m7-Zt2Lr_8Lork8LyqKkgmLwFpGffzUkTSfskq8Ml_jMQrcSvlK7XZ6kCIHtEV83dV_-dPMcTuphG5tjW3wosOugQyBcDh8GACpilrGP-RmvIMIs0Unn64tGaQt-ZRXUASY-4FkvnJm-M-KiMIIyH-rKtF-Bd8ZmhywgiDPq2lEal-Q4Oowhjh5LrxA-_hK5dnopBOTh6BxqK5Hyf8K1rZhDZpq_UmmRGqIcI1H145bEqkXQhIQgl_f7bZajgkeaXYnfD5CUt4KpcpwPRVpy8TUlC2Yci5zA1tYOH5Pz1ePdxi_wqlYfBvI3vDdQDVcI_Dk0jK5mN7iytPgGXM9MBYe-xU8NOeLI7hMBiJXirFPqn8U8qQNx-sJfN4rmaczaytlNFIcmveRh8kJxeyPpoufAsNLYhBSFYWs5_vLlA-wV7ZEWyZYeTg4VX6peyQNoKq0eof4krGCQC5wrnnUkvtz9R2-KhsESz9sp8hUKZfSZqXIzx-bbTz2OTNHYFxgoEcLla6kIkNkatU5i805UKV5haeCKHW90wscER9giAFl7Nuyd6gYfrvaci2BhUE_ddpBIfXQMayysRmMh54i0eVyJ3m_jwxJdwBuAuQpWZVxKPyXnSP5IeHxGUjsze2YHDcyaiAXMRVYUg5E876OLnFlFRiwtoL8_J9jh8EplZp5MS5DkfFSpLjz8vu4nS1p4z9nmu78TgIoIQsTrp-oMc2BSTIjIU7Q-MnJsVreRVD0Z6nFVi_o7mDeCE2pYpoCsxaNWb0Eys-aj0GjiJzGFLJ2Og7CgC3J_AUuiHrN8Dl1fxcqVOgD_p7ZCJRiabZvbokA5ECloJ6AQtxxQsfcsX6OLqY-Z-rz2DONz23J5UJ3W_JdDkTLDmZnHe8G2aHD0NUTXt4-eg8zqoK__nzg5Vx0jH7u6jaGkcxYbf9ChARznZIWKCMAvPg7CLO5c1rA-f3HwLBNygj2uoaQm75ogIjn-So1z94cizV5KurSeys4mK7X9Pc9-QyDsjBCGb_yCLHqtWN_uw70ynq1deB9zVX6MZ4U5fy5SFPibZ6s5LB28LFZJ6i2zhMyaLsMV3_BmMYfxjBKOH-sYZIhQ-mZH0uCMHJrae5W8nLCiHVr7jSnZnC5G0isVcL_sVgpvEqxUvB9p24UG3xiFUz8NyucT4MrW-TmClxAldLWOj9okBXkyY5lKqWTIi22RRDALwCrd3veJFIBaXMLzA6CdVDTVYz264GZg1TfG2KwHl_3iv_FErhujvR6f73Rzzb7c5u9aipkgt9MQWdGLiQTUdxlkVq4WpuXUa5KqVtv4xBwGF1A7ojmpyNv3d4eUROs7cg0LAONkhgQTUpjzRTZ6Yej-4OyYpA0jQVyRldVOry8Ui6ubZZrP21pG2YPgAVrGDnVA_eDVaC3_4WnQePwt8sJlHApMZEt6X0HjnEd7O2zUldW9s2dk0B4Tfz-aVMCx9jIQpqdj-8HqSiCTRIkmfhzcXlJgN8o_6ktSUTspnwNRKaTYZiCBCQRwkM6TF24neoGPaFY1wIHlZwIE2pIyRY6XPdRQsKDt-JJl7w5NqeuctqDWOD_-T3JR6vHfw', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt3q8QCAllT0lEv4FOuOfmx+KgUy/7S3lr/GweNqhrR1c3R0CMBB0YaIpQG3v1aDmTV+iXTGtmLmyEzfAGNOjXuuFQXFfdBzHCABMIwu+Ncde0EAcJfOK09tD4pTl+G3uW6SAKGbVGjKB2g6tHW7AllNKeahdRCONp0oRSA9ys/djBvqTXlg4w9nj9wAo2YOgXfy34NibThJoSzwl9Rzm9PhlV58GhuslsuYEsGW2ezewWzH6+gY9jUSF4nn/G/vimZfP6iGrNucjnHbdFbxFu+Gi7qI3nux3DuV3TqF54wakMV8Mjauvk6SDWETRIleioLWfH3NXhea6e1d/srHfowIDAQAB', 'cf5e9b94-5380-49ed-b27e-0bb6ff45173f'),
	('c7c0d754-2128-465f-80d7-542128565f3a', 'a_4Qtm3Osyal7vLPYfqWQWtoFP7jSVhdTJfPl8MVkqJ1K8sfLgEp6hXNewaiY6VJaHWoCX0wIokuLyagZbc8Ece2TVwLjBv3MmcJSPMQpnBToaydR4LNnCxyt5WHpqNQ_EFxXgSgjFagDsaurOn9jW_DxoryA0GIM-_AVVZW5H_Q9NjjHA68SnnB2KMzhGnhaeEN4esq-xJBYgsCr_U-2Irko1yH7Vzqq6WqEDQap0sLGsXnj5uN7UKow_3rs9Da8vfCottxc9A_YWJdtyS9M36TP5ohANjsfAa4bUdoWmXe29HKNSqU_DICwCz1Q_qukrojD7TaVlWQojtN-FDYQjHc7jUiAL8PEtbNaTkcgibye1RoE-eV1u0rTKJCDG6U6RN1Su4QvR6NOuULUQNOyrp4iNZnr-JUdQdx57mwGxPvvlATEMjpBvsoGMwWeCXilDlDt26WaiH9wvrLyDC4Tnucrl5fCQWvyr94iByBaAAyHOODaJf7IuZcQFeqAeWGG2TAsr4gUedjHexilL3lW9UZHF4aIKbWj1AaunuzYDZfkCUiS9iDICAOPhTbzZNwpfgjhhogLGlE1ZcODdZdYLegb8MNVbB_XcUCBHZvYIMgQl5YW9EadgJ2fbYmTlYVIYttJ9TEdJKkbUosqLnnyKVBkDBiGlh3S8DK61_ZHXT0sVgxTHo-dW7EVPOYNOCJYelfMzGgJmL5uFaRbX_87EM2Cpa1Y3-QdFmaYuZgDv8dUqxHevTckQz8YBZuF_N8BZmghvyZp4SQsc9x9CWK5jT9MQUmH1he8LvsrWtxZDtES5Vq9mhYH_NGAJ9j5arJr_5K1mou5EvGnSHDpxS503enRvlUyR50Vy4VCsXLmHEiCv46Idik0NI3STs3ZgDizQQVfqvVOqH4F8w4kZjMFluGnxN1U7Hvnxd87fWmryU0qAGlXD0lfsHC0CJ4FN-7B-_lXQDz5P6q18N8yZf0e4wKhB2kk9xH73i62E6TnIvOeuZ_p2kgypX_7yxDUqHb2i3NuOhApCzwYDcX29KNGl_HqpdZiWiImRivuC-dpgYAgVHZLf-UMqaBYuZVCg2LFX80b-8GlgqmomFc_nvUoqG9LstP8dpEKh6iT-C4PD7c-jyHUECOB0rylYDTuzS1WxAG7OfkkgdN0pxHBLqyIR-ERh2Z01NpJrs6qR2guy4c2lOnV2KdkSib2L_Q_LLjHtQolZA4dXiDAn3eJrCNm7_3zZOMBsSxjbOV8sWFrUvtmy0yucbCdJlX2mlekkhb6ynf3iMpjQo70w8Ix9XpBQD_i60hEuTGjqz0vjq1q5QW0xkMEFI0RyEXfftrb2OeHXzWFRQFqtHPAIan4wyR43f3jbyDHv_WHsmBHPx83lx_l3wll_suf2VLddlEQ1ASZtGZucU1aP7Fnr8X--z3oRt0HegPM0qZnz999Qma2rbi0ZGfRrn298AzrBDLZW1j0hElXUqYmMC7iWfnCrAvblWs1gydEajCikNKnLMBFnbAQQB8yZXvTe_hROZVyreAC4rsF4qin7U6NPRUWGumrpOou4tO6y9SX8ffQixJzmqfb5E5OC_AyO-0LNbdMrsOmgOYdaIiXv1OJ6TP08fIst62gLhYscztjWPwe71hpriAkDHfOwcRPUWeDRoa7rht71IL1Df0hJ_xjVYTK3ID8c5BzGAcvurHXj29mvLFFNTkGHC-K4XeZnsOOpxqrAlWz-k-6O7fbVmHC3Ho2kk4AFLFte45LfNaW6J0JCKWIg2tpaYV4EYwr3V0wNYG-7J9f5AdKEDu03OGuIzy_Z_ptCVCNfMH30hgA2XVkgRvp4faDOp_4D2RWuGhA1oRg93p--vYvRSn3Vw1Pe1VUmfijLio_oHGJSrBYtV3TbXei0wjIOISnuNWYKsGBj_APciNmzF6Ul9Huyn17BXX-rZPDYFndSy3nIx5stT5CPP-JKMVVJlmQ5NFKfKXEmpxiuPKqTL1kJsM5n9Mj2Zx2Drtny4e80qvL2L3U5kBzxWhHZDll5WzkdGgq0udpUQeokN8Egs_b-c0uzgi9kdZ9bFsLjVdsIVnbVntOlYVSNO0utb6hd8ya-s4vPE1mcHtKzmVZKyt4-AJq974_4yCxVv7nTAffRsrW47YpdfpE4fzlFp8PYzvn5MtVKmpVue96GZpzMQdFrTlSIsuoIMrAUZpNA', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3/3hvHfEB/zkhO2YJayLeMtYLqS7o+CMrxBJKJoiHRY62ZIgVeQJrd/4Ap+8y/3QhYJ7teH0R9bd+gYD6fuwva1bzaocdX5tfG8xDuijIHz2XAo+H2/BScvWQP4b6CJhP7EPIzWcWrzDi5uNILl3nvSP+p+utPNN2c8UHr0SjPLCT4vSsDxLMTR7ZulQASY7gIskYOiuEVz7p1x3GLmJrdo/jMPW57BTYyzCwloca8BWTpzRdadzJE6L6rkpwC6F4Y3etC4FLu/L9VR92UWkDMUc7cEXVqj9KiZng8Uf1obuANFhqt5GCvidfA/LLn1tFA29CwndHQYD+BW8lgtCHwIDAQAB', 'c9348c78-6437-4d66-9f15-5f5bd332b27a'),
	('f8598d93-17ee-4a17-998d-9317ee6a1776', 'uitWpCUSVGs7zZwRnS7LrTpNPJrdVeUW_9DloCXBy-SfLEomqJbi6cSubJzLCATA0aYctBXPcTav1XFiuAe9Bz3AZ3pKZRyYAyib9aJ9O2ojMM87PSqNxFIBgiKZqhtConrWrroxi5FjB5e0rHYhwBraTDNOd00sYseRDh2YmnKUj4EBhuXDbMvNqMewmQGhQ80OsB73wpb-ePalpwlrVQrhJ1IwUEpGqSyDrREnS_K_9M9I_KyCLA0hjng6pwMu25H2EAm__nICHArltkoH5dTdN6OdxiOxgundI0X03J955I0ZtT-3ediSXDNFvvy-lDnEc6-Do2jcBc7RnMyNUSyC1ViAw2vLh8Y1rHpz5w9J-UYY5aEV9UiOkx8-334qNn1HO6tIYIvlciPgxGCWiYtW8wqS4Drble-e1dzxVqCauwT0msRrjZt8-G6TNPF5pJN3dNlNhc1-RnBSEpwdFhzKpyxX__vdy6B9X63DgF212EV1rkz59TgjYC5oGlIzLCJadmj-RbQt7z5Nq5nEH5FUvHkNsZfe5xeeoeT7lmbPLPW_ceF24nyoQvbskkikueO_23saaoSL37bVlcBM2YqSyEJ4xb8NkpO5h8i9qWyIZ4v0FjhdFR4Qnkmthwl5QgQ4zsL9YWDp1M7XGBglJWBwDrq8tGrtlqW1u1jMDdnF51d-GyvhMMmqlUaDc-6_dtFydifrN9wbXT4siVIHU4WgZkdL7ef56LhMcpcraDTZMCK7NY9y1QgeO-edCXV1H4JIxKABF5VnRwOgvRIrhA2d5O-70eUtZYhOEVIdQI-44xKnvgzdRVqhXv82b4WBE78Ram_V-cw-5WJFinVItmINPxw0E_YTloGRmvOz1uMJLbi2EfzV6HDT9POJIZ94d60mfrLS2c6MuTTdsofwIadD-4b2b4IGwJ_pJ8iMfGriYw-YWXZlb4jJzSm2yX0qYldXurcrYZhKJ9gDOwVxVDH7V8lwQ3Fu4NLsfAxIipKbwZAc0uPTseTGgTDnMkC0xy0jxw0c0zCkkGE01WuHTretQprTXfErEK50uxeY6ZHyq5BugcjOeUiwxw2wIN3Nahfyn60-WPR3CnFRbqOuQOi0J-wwgRhdKFv2VSjzW6HNJOppJ6sDMEgVyavw5Sqm8h6JKWYRLZ021oJ793zC8ba50E5gwl5Hj4rit414EBz-hjwPGQHAh-Dr4Aj5fWcBb8R0vzwKQt5zw6WWp5uUAEdGN9Ii3iYoH10YZRXAkzrRFNC4t2T8lSCqHKSN-pAGEsrYhA6nWlkcGOdP5reuhoMVDf5Vt_70TN9F-35r3c3QOFgqMl7K10Jf6VDT4wDy-H0deeb41VrEal9typ-3kbccFOOpX9J4o5Xm2bHp7-vw67_R8wtc24yF1fCRqZn39aDYia0qqwChyBI7HbJlEaFcOxd_txpjrTZsli-z6UGLKoeNXvWqSG8v8_wVqN-LG9OD8vzDIDyZYwt5oPZxvLTvGaTW4YxxVR-V7nZ_e_R6t8ks7t0v5nZNPoO5rKt6c07nkrSR4DPEAdStozVFsbWTPf89BImk7Iq-P9R8-4-0gGVeXlaeVTyHOgyl_kD3akORZ1AE5zlbwz9sSmOSHF1JHaE_VoFg0kWmdyV_-vzqwn8OlzaiB05sPfg1adb-KvRO08wQ9hLrEXX72f--YPJIJBfZEyhgS__EojSdNu2G6XL4w89W9uF-jd1CyVMwVFwUYpvv7m_9LsLbuiowfO5KxOzez-TTIfVDZtXpwaYIG4V-rR7rBzwuKO6mtAe0ZwNc_3BrHYxBC0333VZE454PhGsDuAOz0-FXP-FN4abbJlLKFh5faQCUFJ4HibSVNeG9_VJpxrZhIsD0aQLVOlcy7myMos0nj9oksMw_c7a_vjCRQNsjr1ACXQbIzEEZfC9Vgveu4AvGr5qu_-i7p0yqTe_J6k8j-jIgCqy1RoR2IrAhlCo6JNWAZx6eGu1OV1kz32kJ92YzVc3Ju-yJU0gEGzmbYdAWGvGd8-Kyt9jei8vF6giY1l30a2MPY7moslRbeQINeLvi-8TvxSVZ5y3W6wFgn4SXurxUthcYakQAnXiscJZdEXPK_aZ10InHToEnsgutmdvzzquCdmJ05LlUusiOQtBc-zM5GIAUF6nlUS4hFPsV4avtWRiHc7QNeJa_S6-ub6-G5V0HbJisfg', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo044stMBowqzzZSuthICwoHNvPp5pa1IBOMYhhj39i6zq45HGU02t2RdOg0qgOE9CKuyniPALYdHpZ2h3CEiOZK/mp7pSjUDNYKDdebvzRUdWp947DRpOZP/pQOT028jZTyMMEh2b26JScEGs/GnTBASNX/1cRmAWB3K/p8aCCEeaLoaMMMddBiSBy2IkQlfb/VomEX12a2jqpFKrwEb6uopCN1GLC088AEC2/aPgWV73OMabijWuMUJyXkIIGdDyviR7RBQdqKMKQalYSgQH7Htu/snIhTTs4lAC6+KwHTQ4q0GlPSObeyZ5utevBY0qlpW+83pKTwBp4Wd3ykEuQIDAQAB', '47eb85db-efe3-4750-ab85-dbefe3c750e4');

-- Dumping structure for table mod_keyboard.orders
DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` char(36) NOT NULL,
  `commune` varchar(255) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `district` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `total_amount` double NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` char(36) NOT NULL,
  `status` enum('CANCELLED','DELIVERED','PENDING','PROCESSING','RETURNED') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`),
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.orders: ~0 rows (approximately)
DELETE FROM `orders`;
INSERT INTO `orders` (`id`, `commune`, `created_at`, `district`, `full_name`, `note`, `phone_number`, `province`, `street`, `total_amount`, `updated_at`, `user_id`, `status`) VALUES
	('0db6e0b0-8ed0-4992-b6e0-b08ed0099263', 'Phường Hùng Vương', '2025-06-23 07:58:41.475746', 'Quận Hồng Bàng', 'LapNguyen', 'gdfg', '0343820047', 'Thành phố Hải Phòng', 'gdfg', 1045660, '2025-06-23 07:58:41.475746', '47eb85db-efe3-4750-ab85-dbefe3c750e4', 'PENDING'),
	('14775853-71aa-4d60-b758-5371aacd6039', 'Phường Đồng Xuân', '2025-06-23 08:50:25.628024', 'Quận Hoàn Kiếm', 'LapNguyen', 'gdfg', '0343820047', 'Thành phố Hà Nội', 'gdfg', 1045660, '2025-06-23 08:50:25.628024', '47eb85db-efe3-4750-ab85-dbefe3c750e4', 'PENDING'),
	('3592790f-f30b-431c-9279-0ff30b731ce9', 'Phường Hùng Vương', '2025-06-23 07:58:33.928667', 'Quận Hồng Bàng', 'LapNguyen', 'gdfg', '0343820047', 'Thành phố Hải Phòng', 'gdfg', 1045660, '2025-06-23 07:58:33.928667', '47eb85db-efe3-4750-ab85-dbefe3c750e4', 'PENDING'),
	('3f87d2a3-79dc-4a12-87d2-a379dc9a1298', 'Phường Nhật Tân', '2025-06-23 09:02:03.170545', 'Quận Tây Hồ', 'a', 'gdfg', '0343820047', 'Thành phố Hà Nội', 'gdfg', 2355160, '2025-06-23 09:02:03.170545', '47eb85db-efe3-4750-ab85-dbefe3c750e4', 'PENDING'),
	('cfe794f9-382b-44dc-a794-f9382b74dc04', 'Phường Hùng Vương', '2025-06-23 08:50:45.623425', 'Quận Hồng Bàng', 'LapNguyen', 'gdfg', '0343820047', 'Thành phố Hải Phòng', 'gdfg', 1045660, '2025-06-23 08:50:45.623425', '47eb85db-efe3-4750-ab85-dbefe3c750e4', 'PENDING'),
	('e54c114a-1a11-4a82-8c11-4a1a119a821f', 'Phường Nhật Tân', '2025-06-23 09:02:06.220492', 'Quận Tây Hồ', 'a', 'gdfg', '0343820047', 'Thành phố Hà Nội', 'gdfg', 2355160, '2025-06-23 09:33:58.161780', '47eb85db-efe3-4750-ab85-dbefe3c750e4', 'CANCELLED'),
	('f51285cd-59bf-4d26-9285-cd59bfad26f7', 'Phường Hùng Vương', '2025-06-23 07:58:11.388766', 'Quận Hồng Bàng', 'LapNguyen', 'gdfg', '0123456789', 'Thành phố Hải Phòng', 'gdfg', 1045660, '2025-06-23 07:58:11.388766', '47eb85db-efe3-4750-ab85-dbefe3c750e4', 'PENDING');

-- Dumping structure for table mod_keyboard.order_items
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` char(36) NOT NULL,
  `price` double NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int NOT NULL,
  `order_id` char(36) NOT NULL,
  `product_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbioxgbv59vetrxe0ejfubep1w` (`order_id`),
  KEY `FKocimc7dtr037rh4ls4l95nlfi` (`product_id`),
  CONSTRAINT `FKbioxgbv59vetrxe0ejfubep1w` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `FKocimc7dtr037rh4ls4l95nlfi` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.order_items: ~0 rows (approximately)
DELETE FROM `order_items`;
INSERT INTO `order_items` (`id`, `price`, `product_name`, `quantity`, `order_id`, `product_id`) VALUES
	('0745a18b-04c5-4850-85a1-8b04c528509a', 169000, 'Bàn phím Logitech K120 (920-002582) - Hàng Chính Hãng', 2, '14775853-71aa-4d60-b758-5371aacd6039', '0419857e-9a52-44be-833a-dcc0760aaee4'),
	('0b799140-28b2-4e34-b991-4028b21e34b4', 185000, 'Bàn phím có dây ZT600 phím mỏng, nhẹ thích hợp cho dân văn phòng - bảo hành 12 tháng - Hàng chính hãng', 4, 'f51285cd-59bf-4d26-9285-cd59bfad26f7', '03e29503-e3fc-4668-8785-865ad7953063'),
	('15b0968e-5cad-448c-b096-8e5cad248c10', 169000, 'Bàn phím Logitech K120 (920-002582) - Hàng Chính Hãng', 2, 'cfe794f9-382b-44dc-a794-f9382b74dc04', '0419857e-9a52-44be-833a-dcc0760aaee4'),
	('28fcda6e-e0c4-4747-bcda-6ee0c4d747a6', 185000, 'Bàn phím có dây ZT600 phím mỏng, nhẹ thích hợp cho dân văn phòng - bảo hành 12 tháng - Hàng chính hãng', 4, '14775853-71aa-4d60-b758-5371aacd6039', '03e29503-e3fc-4668-8785-865ad7953063'),
	('29b95e48-ebfa-40c5-b95e-48ebfa60c538', 185000, 'Bàn phím có dây ZT600 phím mỏng, nhẹ thích hợp cho dân văn phòng - bảo hành 12 tháng - Hàng chính hãng', 4, '3592790f-f30b-431c-9279-0ff30b731ce9', '03e29503-e3fc-4668-8785-865ad7953063'),
	('379851df-c0ff-4073-9851-dfc0ff407347', 185000, 'Bàn phím có dây ZT600 phím mỏng, nhẹ thích hợp cho dân văn phòng - bảo hành 12 tháng - Hàng chính hãng', 4, 'cfe794f9-382b-44dc-a794-f9382b74dc04', '03e29503-e3fc-4668-8785-865ad7953063'),
	('3e5f6b3f-b0f9-4322-9f6b-3fb0f9532250', 185000, 'Bàn phím có dây ZT600 phím mỏng, nhẹ thích hợp cho dân văn phòng - bảo hành 12 tháng - Hàng chính hãng', 4, '3f87d2a3-79dc-4a12-87d2-a379dc9a1298', '03e29503-e3fc-4668-8785-865ad7953063'),
	('46d6e00f-b090-4b71-96e0-0fb0909b71b7', 169000, 'Bàn phím Logitech K120 (920-002582) - Hàng Chính Hãng', 2, '3f87d2a3-79dc-4a12-87d2-a379dc9a1298', '0419857e-9a52-44be-833a-dcc0760aaee4'),
	('4eb7270d-16df-45dc-b727-0d16df45dcfc', 169000, 'Bàn phím Logitech K120 (920-002582) - Hàng Chính Hãng', 2, '0db6e0b0-8ed0-4992-b6e0-b08ed0099263', '0419857e-9a52-44be-833a-dcc0760aaee4'),
	('4ec9a846-26a2-43eb-89a8-4626a243eb78', 169000, 'Bàn phím Logitech K120 (920-002582) - Hàng Chính Hãng', 2, 'f51285cd-59bf-4d26-9285-cd59bfad26f7', '0419857e-9a52-44be-833a-dcc0760aaee4'),
	('617ff0f9-e826-4f93-bff0-f9e826ef932e', 675000, 'Bàn Phím Cơ Gaming dây usb GK102 Hotswap chống ồn cho máy tính laptop hàng nhập khẩu', 2, '3f87d2a3-79dc-4a12-87d2-a379dc9a1298', '2560c61b-617c-42d9-a574-2854f76c6d0c'),
	('75181012-f4e9-4cee-9810-12f4e9dcee39', 169000, 'Bàn phím Logitech K120 (920-002582) - Hàng Chính Hãng', 2, 'e54c114a-1a11-4a82-8c11-4a1a119a821f', '0419857e-9a52-44be-833a-dcc0760aaee4'),
	('97f030e4-d071-4fa4-b030-e4d0719fa4b6', 185000, 'Bàn phím có dây ZT600 phím mỏng, nhẹ thích hợp cho dân văn phòng - bảo hành 12 tháng - Hàng chính hãng', 4, '0db6e0b0-8ed0-4992-b6e0-b08ed0099263', '03e29503-e3fc-4668-8785-865ad7953063'),
	('a6092583-1909-418f-8925-831909118f85', 169000, 'Bàn phím Logitech K120 (920-002582) - Hàng Chính Hãng', 2, '3592790f-f30b-431c-9279-0ff30b731ce9', '0419857e-9a52-44be-833a-dcc0760aaee4'),
	('b56add32-bcb9-4284-aadd-32bcb972849c', 185000, 'Bàn phím có dây ZT600 phím mỏng, nhẹ thích hợp cho dân văn phòng - bảo hành 12 tháng - Hàng chính hãng', 4, 'e54c114a-1a11-4a82-8c11-4a1a119a821f', '03e29503-e3fc-4668-8785-865ad7953063'),
	('c9a7213c-49a7-4c8f-a721-3c49a78c8f66', 675000, 'Bàn Phím Cơ Gaming dây usb GK102 Hotswap chống ồn cho máy tính laptop hàng nhập khẩu', 2, 'e54c114a-1a11-4a82-8c11-4a1a119a821f', '2560c61b-617c-42d9-a574-2854f76c6d0c');

-- Dumping structure for table mod_keyboard.payments
DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` char(36) NOT NULL,
  `method` enum('MOMO','VNPAY') NOT NULL,
  `payment_date` datetime(6) DEFAULT NULL,
  `status` enum('COMPLETED','UNPAID') NOT NULL,
  `order_id` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK8vo36cen604as7etdfwmyjsxt` (`order_id`),
  CONSTRAINT `FK81gagumt0r8y3rmudcgpbk42l` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.payments: ~0 rows (approximately)
DELETE FROM `payments`;
INSERT INTO `payments` (`id`, `method`, `payment_date`, `status`, `order_id`) VALUES
	('37230cc3-fcc0-43db-a30c-c3fcc083db5a', 'VNPAY', '2025-06-23 08:50:25.640013', 'UNPAID', '14775853-71aa-4d60-b758-5371aacd6039'),
	('87065ea9-8387-4ad8-865e-a983873ad864', 'VNPAY', '2025-06-23 09:02:06.220492', 'UNPAID', 'e54c114a-1a11-4a82-8c11-4a1a119a821f'),
	('974f7ed4-da11-4a3b-8f7e-d4da11da3b0f', 'MOMO', '2025-06-23 07:58:33.929665', 'UNPAID', '3592790f-f30b-431c-9279-0ff30b731ce9'),
	('a8c1b5a8-9a43-4fc4-81b5-a89a43ffc4e1', 'VNPAY', '2025-06-23 07:58:11.391767', 'UNPAID', 'f51285cd-59bf-4d26-9285-cd59bfad26f7'),
	('ba6350b1-478f-423b-a350-b1478fb23b1a', 'MOMO', '2025-06-23 09:02:03.171544', 'UNPAID', '3f87d2a3-79dc-4a12-87d2-a379dc9a1298'),
	('f3c194e8-61b7-489e-8194-e861b7a89e3b', 'VNPAY', '2025-06-23 07:58:41.475746', 'UNPAID', '0db6e0b0-8ed0-4992-b6e0-b08ed0099263'),
	('fa26237b-7861-4d09-a623-7b78610d09b6', 'MOMO', '2025-06-23 08:50:45.624417', 'UNPAID', 'cfe794f9-382b-44dc-a794-f9382b74dc04');

-- Dumping structure for table mod_keyboard.popular_products
DROP TABLE IF EXISTS `popular_products`;
CREATE TABLE IF NOT EXISTS `popular_products` (
  `id` char(36) NOT NULL,
  `period_end` date NOT NULL,
  `period_start` date NOT NULL,
  `time_period` enum('ALL_TIME','DAY','MONTH','WEEK') DEFAULT NULL,
  `total_sold` int NOT NULL,
  `product_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8b6l2ebygtvk3917oweiglyy8` (`product_id`),
  CONSTRAINT `FK8b6l2ebygtvk3917oweiglyy8` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.popular_products: ~0 rows (approximately)
DELETE FROM `popular_products`;

-- Dumping structure for table mod_keyboard.products
DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` char(36) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `discount_price` double DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  `thumbnail` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `volume` varchar(255) NOT NULL,
  `category_id` char(36) NOT NULL,
  `total_views` int DEFAULT '0',
  `rating` double DEFAULT '0',
  `sold` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.products: ~172 rows (approximately)
DELETE FROM `products`;
INSERT INTO `products` (`id`, `created_at`, `description`, `discount_price`, `is_deleted`, `name`, `price`, `quantity`, `thumbnail`, `volume`, `category_id`, `total_views`, `rating`, `sold`) VALUES
	('00154985-2c5d-4282-92c9-04f3d36c08df', '2025-06-23 07:27:39.000000', 'Prolink', 843900, 0, 'Bàn phím cơ PROLiNK GK6002M (Blue Switch), LED RGB 16 triệu màu, Full N-Key Rollover, Anti Ghosting cho tuyển thủ Esport - Hàng Chính Hãng', 890000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/55/69/11/cc3e4b68121ec6838279d5cc69686cc6.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('00cca015-61b8-499b-9578-a6d420c1a38f', '2025-06-23 07:31:05.000000', 'EDRA', 139680, 0, 'Bàn phím văn phòng EDra EK506 - Hàng Chính Hãng', 144000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/9e/30/0b/20e6c389ebbc25592a133418307ddae3.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('03e29503-e3fc-4668-8785-865ad7953063', '2025-06-23 07:31:05.000000', 'ZT', 179450, 0, 'Bàn phím có dây ZT600 phím mỏng, nhẹ thích hợp cho dân văn phòng - bảo hành 12 tháng - Hàng chính hãng', 185000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/49/db/e7/dbeab73fd6837e1eea035e886fab1344.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 1, 0, 28),
	('0419857e-9a52-44be-833a-dcc0760aaee4', '2025-06-23 07:31:05.000000', 'Logitech', 163930, 0, 'Bàn phím Logitech K120 (920-002582) - Hàng Chính Hãng', 169000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/27/e8/94/42a7fd0b24e7533b4e5f846cb6d32725.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 1, 0, 14),
	('08cf5085-5bc2-4c1b-ab5a-34d169ae5c0c', '2025-06-23 07:27:39.000000', 'E-DRA', 1240630, 0, 'Bàn Phím Cơ EDRA EK384W GATERON switch - Keycaps PBT - Bluetooth 5.0 - Hàng Chính Hãng', 1279000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/8f/6f/af/123dd657a379d128b501a0db9e5beab7.png', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('08fe53a0-7e8b-47f3-8a0c-3b22da746ad2', '2025-06-23 07:27:39.000000', 'Ajazz', 996000, 0, 'Bàn phím và chuột cơ AJAZZ Combo N-Key Rollover Red Switch đèn nền 2400DPI 104Keys-Size Công tắc màu xanh lam', 996000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/88/60/18/8a7c4a19375a6d15333111dda504e551.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('0a2f8c95-b91b-464d-84dc-1546f78ea519', '2025-06-23 07:31:05.000000', 'Langtu', 329800, 0, 'Bàn Phím LED LANGTU L1 Black - hàng nhập khẩu', 340000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/11/33/46/cbe2d3dfc7e6c9d84e22d3c97f7409ee.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('0fc15dfb-12ff-4fe6-acf2-f039477139de', '2025-06-23 07:27:39.000000', 'E-DRA', 474330, 0, 'Bàn phím cơ E-Dra EK368L - Hàng chính hãng', 489000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/37/cd/19/02c6d6c12555558121bd0b62369bfdd2.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('104ef33f-da83-471f-b929-76f35924da6a', '2025-06-23 07:31:05.000000', 'Tech77', 645050, 0, 'Bàn Phím Cơ K900 Gaming - Led xuyên phím có hotswap cho máy tính , laptop hàng nhập khẩu', 665000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/85/26/57/e5561d66deca1919d4a6f11e1da6901f.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 1, 0, 0),
	('11324698-d1e3-4c03-8768-d57375cd3222', '2025-06-23 07:30:14.000000', 'AULA', 464630, 0, 'Bàn phím cơ Gaming có dây Aula S2022 - Hàng Chính Hãng', 489000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/87/57/32/9ac7e0531a5a62ac6acdba820a570483.PNG', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('12292913-9ea7-45d3-a962-8ba53b99d201', '2025-06-23 07:30:14.000000', 'Tech77', 645050, 0, 'Bàn Phím Cơ K900 Gaming - Led xuyên phím có hotswap cho máy tính , laptop hàng nhập khẩu', 665000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/04/1e/99/b9c26723ba7decb415260d0a29738747.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('1540f571-76bb-4b98-8fde-85f9adceabed', '2025-06-23 07:31:05.000000', 'Tech77', 291000, 0, 'Bàn phím mini Gấp gọn không dây Z200 kết nối bluetooth 5.2 + 3.0 + Usb wireless 2.4g hàng nhập khẩu', 300000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1c/57/a9/cf137a6a8521f64cca930eb1ce3501dc.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('171bdf7d-73b4-4264-8d83-6c7f996c3744', '2025-06-23 07:27:39.000000', 'Tech77', 266750, 0, 'Bàn Phím Led Rainbow Gaming Giả cơ K82 có núm chỉnh âm lượng cho máy tính , laptop hàng nhập khẩu', 275000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/e6/38/19/d83cac9727dffc24d6678bd292149518.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('194d9b30-ea3a-40df-ae31-674d1253e86c', '2025-06-23 07:27:39.000000', 'Razer', 1930300, 0, 'Bàn phím cơ Razer Blackwidow V3 Tenkeyless-Mechanical-US Layout-Yellow Switch - Hàng chính hãng', 1990000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/80/17/e5/4d4743c1e3e02987ceae680718407b48.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('1e27edba-aa71-42c7-9144-03a11113bf75', '2025-06-23 07:31:05.000000', 'DareU', 182457, 0, 'Bàn Phím DareU LK135 Chống Nước - Hàng Chính Hãng', 198000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/67/58/8d/9478e4361c75246eab4b331866f92518.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('2245bffc-be5f-4019-90ab-b210eb2b856a', '2025-06-23 07:31:05.000000', 'Newmen', 145500, 0, 'Bàn phím văn phòng Newmen E007 - Hàng Chính Hãng', 150000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/08/8c/16/4ae498120d7e3d6a2ce5aadea2b299b7.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('230b1886-4782-4a0e-afed-f409903db8fe', '2025-06-23 07:31:05.000000', 'WINTERHALTER', 4558680, 0, 'Bàn phím máy C50 Winterhalter - 30013885 - Hàng chính hãng', 4558680, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/95/63/8e/ab5554c764b39ef27c674a2ba052a995.png', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('244d55fa-51ee-4e11-b479-ae1bec58c7d6', '2025-06-23 07:30:14.000000', 'ROGTZ', 252200, 0, 'Bàn Phím Giả Cơ 1 Tay Free Wolf K11 Chuyên Game 28 Phím - Hàng Nhập Khẩu', 265000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/23/b8/f6/c563aa12b559a951a9e22c69ec85b11d.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('2560c61b-617c-42d9-a574-2854f76c6d0c', '2025-06-23 07:31:05.000000', 'Tech77', 654750, 0, 'Bàn Phím Cơ Gaming dây usb GK102 Hotswap chống ồn cho máy tính laptop hàng nhập khẩu', 675000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/73/47/c3/dfb1cb32b12aa0fb986351e2489243ec.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 4),
	('25d08f89-cde5-4de6-a61f-ae04a27f1917', '2025-06-23 07:27:39.000000', 'DareU', 513130, 0, 'Bàn phím cơ DareU EK87 "D" Switch Black - Hàng chính hãng', 529000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/c2/24/b9/7c88b530d951f47a6e784f77e370d8ea.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('26090345-979d-4370-abd1-d6428f9acc90', '2025-06-23 07:30:14.000000', 'Newmen', 669300, 0, 'Bàn phím cơ Newmen GM326 E-Sports (Volume control Buton) - Hàng Chính Hãng', 690000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/71/41/c0/8166e521dc6432e2e32df2921b1c7e8c.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('26ff330b-102b-4a94-b756-094537d2e3cd', '2025-06-23 07:31:05.000000', 'Langtu', 329800, 0, 'Bàn Phím LED LANGTU L1 White - hàng nhập khẩu', 340000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/70/65/56/7f2062fd96153c4fd2f14938fcccc01a.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('2777412a-891c-4dfe-ae36-cc7f540fd507', '2025-06-23 07:31:05.000000', 'HXSJ', 606250, 0, 'Bàn phím cơ gaming K3 Led Rainbow Hotswap Chống ồn cho máy tính laptop hàng nhập khẩu', 625000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1e/48/0d/fb54178ddafff4b0436a185151110c9d.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('2856220d-9214-4030-bdcc-5c2108c276bc', '2025-06-23 07:27:39.000000', 'MINHHA', 533500, 0, 'Bàn phím dành cho Laptop HP ProBook 650 G4 650 G5 15.6" US Backlit Keyboard Silver L09593-001 Hàng nhập khẩu', 550000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a3/17/af/224f864dfb2883a93d21f172b2a1e9f6.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('2872cf02-c1e3-483d-88f9-a03404334f63', '2025-06-23 07:27:39.000000', 'T-WOLF', 669300, 0, 'Bàn Phím Cơ T-WOLF T50 Blue Switch (Đen xám/trắng xám/xám đen/xám trắng) - Hàng Chính Hãng', 690000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/0e/82/0e/33860ec35c91fcc0cfd35c9034d88594.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('2af45fe5-f2bd-4dc7-9821-9c6fbd12b880', '2025-06-23 07:30:14.000000', 'HXSJ', 125130, 0, 'Bàn phím giả cơ G21 kèm chuột, bàn phím máy tính chống nước led rgb chơi game làm việc văn phòng cho PC laptop - hàng chính hãng', 199000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1f/1d/a3/3ae5f3b159bdee326a4914c28948cffb.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('2caa4a2e-4524-4479-8a7b-1fb3aafa8bae', '2025-06-23 07:31:05.000000', 'Fuhlen', 196610, 0, 'Bàn Phím Fuhlen G411S Black - Phím văn phòng - Hàng Chính Hãng', 220000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/ab/b0/b0/634f0020cc394b5fad0c1454205eb6bf.png', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('2db82dd0-0add-46d2-a6eb-7ff0eb0a4bd8', '2025-06-23 07:30:14.000000', 'Tech77', 266750, 0, 'Bàn Phím Led Rainbow Gaming Giả cơ K82 có núm chỉnh âm lượng cho máy tính , laptop hàng nhập khẩu', 275000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/e6/38/19/d83cac9727dffc24d6678bd292149518.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('2f0685d3-6045-46a6-9ce3-d1e4d50fcff4', '2025-06-23 07:30:14.000000', 'Langtu', 329800, 0, 'Bàn Phím LED LANGTU L1 Black - hàng nhập khẩu', 340000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/f1/4e/39/52495d039404e06be0e92539ea9acd39.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('30c57e9c-bbe9-4330-a063-4996065a93f5', '2025-06-23 07:30:14.000000', 'Langtu', 329800, 0, 'Bàn Phím LED LANGTU L1 White - hàng nhập khẩu', 340000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/70/65/56/7f2062fd96153c4fd2f14938fcccc01a.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('31a914d9-93ef-4615-95a5-e834fa5c0e96', '2025-06-23 07:31:05.000000', 'HXSJ', 305000, 0, '35 Phím Bàn phím chơi game HXSJ V100 Mini  có dây USB thay thế cho PUBG LOL CS Gamer', 305000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/05/54/24/bcec71b892f4dacc17da325ddf697fe3.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('323a1fa7-6518-4993-bf0e-ed57e80516fc', '2025-06-23 07:27:39.000000', 'Filco', 1173700, 0, 'Switch bàn phím cơ Cherry MX2A RGB | Pre-lube (Hộp 70 switch) - Hàng Chính Hãng', 1210000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/80/fc/5a/bc91b5c864e69d4fdde09ae9a8c1de4b.png', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('3316784d-e63b-4302-8f27-34a51f24b2c2', '2025-06-23 07:31:05.000000', 'HXSJ', 638000, 0, 'Bộ bàn phím chuột HXSJ J100 + A885 35 phím Mini USB có dây 5500DPI 6 nút LED Bộ bàn phím chơi game quang học ', 638000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1d/1c/c1/cb45b1b6965879d43fc7d6a12b657171.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('33c892e4-2c9b-4896-9578-0e38e5a429c4', '2025-06-23 07:30:14.000000', 'Tech77', 776000, 0, 'Bàn Phím Cơ Gaming không dây GK102 chống ồn - Bluetooth + USB - Pin sạc TypeC - Hotswap cho máy tính laptop điện thoại hàng nhập khẩu', 800000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/ec/67/19/99bae27cd7840707acacb32cc97758e2.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('3467da1d-53fb-4515-91b4-10ecfb29d70c', '2025-06-23 07:27:39.000000', 'Newmen', 649900, 0, 'Bàn phím cơ NEWMEN GM328 Purple-White Blue switch - Hàng Chính Hãng', 670000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/89/38/0c/2d2425d56d203c8cde33b7c1bba8ed75.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('37a06604-b839-4caa-8c30-0df41db3a40b', '2025-06-23 07:27:39.000000', 'MINHHA', 339500, 0, 'Bàn phím dành cho Laptop ASUS N550 N550J N550JA N550JK N550JV N550LF Màu đen- Hàng nhập khẩu', 350000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/e3/3e/e2/51b39b3108d212d46769c82df1351e1a.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('3914bee3-6998-4e53-92cd-e508c5f85d5d', '2025-06-23 07:27:39.000000', 'Newmen', 920530, 0, 'Bàn phím cơ có dây Gaming Newmen GM369R (Hotswap), Red switch - Hàng chính hãng', 999000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/8a/e7/6f/1483cf7057cf611e2cdc47989b1b08cb.PNG', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('3a70bf18-ff46-4bb9-a8e2-5ffd4df9217d', '2025-06-23 07:30:14.000000', 'XUNFOX', 375390, 0, 'Bàn phím cơ XUNFOX K80 Blue switch - Bàn phím cơ gaming 87 phím kết nối có dây, tích hợp hiệu ứng đèn marquee siêu ngầu - Hàng nhập khẩu', 600000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/b9/6c/8e/254a663c1cef3efca76023fdf42f3939.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('3cd924b8-08f5-49ab-bc65-3b58a48105f4', '2025-06-23 07:30:14.000000', 'Fuhlen', 840020, 0, 'Bàn Phím Cơ Có Dây Fuhlen Destroyer - Hàng Chính Hãng', 866000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/72/60/75/31659fb7fb81e7bc81c4c5ca71f5e98f.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('3f2ea67c-c681-4cac-98ad-f45ed6ca99de', '2025-06-23 07:31:05.000000', 'BOW', 685000, 0, 'Bộ bàn phím & chuột không dây BOW K221 2.4G 96 phím tròn Keycaps Bàn phím công thái học di động cho IOS / Windows', 685000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/3b/13/80/1dd506fd020c47c6aba7750e6594277b.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('416308cf-5ec8-46c8-914d-92fe8adbf66f', '2025-06-23 07:27:39.000000', 'MINHHA', 533500, 0, 'Bàn phím dành cho Laptop HP Probook 440 G9 445 G9 hàng nhập khẩu', 550000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/3a/1f/30/7030fbbf63f166fee1515449c0385345.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('445e8397-4451-4c61-8a59-e8b3397e2733', '2025-06-23 07:31:05.000000', 'Fuhlen', 217950, 0, 'Bàn phím Fuhlen L500S Gaming USB Hàng Chính Hãng', 262000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/18/f5/1c/ae4198506c9382d33772167fda670c58.png', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('45ce855b-6ebc-43b9-8fd8-fbd4d050dbac', '2025-06-23 07:27:39.000000', 'Logitech', 1454030, 0, 'Bàn phím cơ game Logitech G413 TKL SE / G413 SE Full size – Keycap PBT, Switch Tactile, Anti-Ghosting khi nhấn 6 phím cùng lúc, đèn LED trắng -Hàng Chính Hãng', 1499000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/62/87/37/f0c2a142a752f3b3203cf49b0d916d6b.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('49f7f4e8-2b16-4f2c-b52e-febd445e6f86', '2025-06-23 07:27:39.000000', 'MINHHA', 572300, 0, 'Bàn phím dành cho Laptop LENOVO Yoga Slim 7-15IIL05 7-15IMH05 Hàng nhập khẩu', 590000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/4d/49/19/6a277f5d44aca169adf28bfcc087294f.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('4a322a52-e1ea-403e-85cb-bc0b881d2eeb', '2025-06-23 07:27:39.000000', 'XUNFOX', 375390, 0, 'Bàn phím cơ XUNFOX K80 Blue switch - Bàn phím cơ gaming 87 phím kết nối có dây, tích hợp hiệu ứng đèn marquee siêu ngầu - Hàng nhập khẩu', 600000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/b9/6c/8e/254a663c1cef3efca76023fdf42f3939.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('4ae0b19a-8343-486f-bdfc-d3e0f175fbb0', '2025-06-23 07:31:05.000000', 'Tech77', 237650, 0, 'Bàn phím không dây mini W200S - đa kết nối bluetooth 5.0 + 3.0 + Usb wireless 2.4G hàng nhập khẩu', 245000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/be/15/aa/f4d37fa97851954b9770a7008f8b8886.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('4b35b4f4-3dd9-4856-943c-92e4a0b25f1b', '2025-06-23 07:27:39.000000', 'Newmen', 446200, 0, 'Switch bàn phím cơ G-Pro (Newmen Custom ) - 3 chân, Axis - Hàng chính hãng (50Pcs)', 460000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/b4/1d/74/1052b763bd08b46b2cebb59706f67449.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('4c333f43-c668-4a56-9556-c28a864ab420', '2025-06-23 07:27:39.000000', 'Fuhlen', 1401650, 0, 'Bàn phím cơ gaming Fuhlen D87s RGB type-C Switch Blue/ Red/ Brown- Hàng chính hãng', 1450000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/d5/d0/d8/c68d7fccdc6a259ecc3d5f8fe6ed6712.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('4c84125a-c700-42f8-8655-5c59d130584c', '2025-06-23 07:31:05.000000', 'Tech77', 776000, 0, 'Bàn Phím Cơ Gaming không dây GK102 chống ồn - Bluetooth + USB - Pin sạc TypeC - Hotswap cho máy tính laptop điện thoại hàng nhập khẩu', 800000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/ec/67/19/99bae27cd7840707acacb32cc97758e2.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('50aecab3-88b2-4d7b-bb5e-8ba4d02d8b2d', '2025-06-23 07:27:39.000000', 'Tech77', 645050, 0, 'Bàn Phím Cơ K900 Gaming - Led xuyên phím có hotswap cho máy tính , laptop hàng nhập khẩu', 665000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/04/1e/99/b9c26723ba7decb415260d0a29738747.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('50b50901-f42c-428b-bad0-2d5b36831326', '2025-06-23 07:30:14.000000', 'Tech77', 645050, 0, 'Bàn Phím Cơ K900 Gaming - Led xuyên phím có hotswap cho máy tính , laptop hàng nhập khẩu', 665000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/85/26/57/e5561d66deca1919d4a6f11e1da6901f.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('50effe91-1642-4f24-ac00-80fdb5ef023d', '2025-06-23 07:31:05.000000', 'Tech77', 203700, 0, 'Bàn Phím không dây W200 nhỏ gọn - cho máy tính , Laptop , điện thoại , máy tính bảng hàng nhập khẩu', 210000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a4/0e/4b/6d43643b97620e4f4105dfd2a7d4399d.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('51d96b86-a7b0-415d-942b-9baea254edea', '2025-06-23 07:30:14.000000', 'E-DRA', 629530, 0, 'Bàn phím cơ E-Dra EK389 - Hàng Chính Hãng', 649000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/68/a4/28/c0d46b9578a8bcb9f92a0247fe271298.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('52482565-803a-4976-8888-d10d72412dae', '2025-06-23 07:27:39.000000', 'AULA', 726530, 0, 'Bàn Phím cơ gaming có dây AULA F75 (Phiên bản Red switch) - Hàng chính hãng', 799000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/4b/e3/80/fa487b8f2875e548a9ed2a61b6859935.PNG', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('52c3f778-43e4-45d2-ab9f-e8593434716a', '2025-06-23 07:31:05.000000', 'Tech77', 412250, 0, 'Bàn phím không dây Fullsize H859 pin sạc TypeC đa kết nối bluetooth 5.2 + 3.0 + Usb wireless 2.4G hàng nhập khẩu', 425000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/78/3d/33/f83b5dcb7963661e1b786e56fa31ea1f.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('53e30166-298e-489e-bb33-04d4962b1b30', '2025-06-23 07:31:05.000000', 'Logitech', 184300, 0, 'Bàn phím Logitech K120 có dây - Hàng chính hãng', 190000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/47/7e/6c/c2425eff72613df6dd053acf6 6f374f3c.png', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('544b4ec8-6a6a-46b3-96dd-eb326e349441', '2025-06-23 07:30:14.000000', 'Newmen', 965150, 0, 'Bàn phím Cơ NEWMEN GM368 Led RGB, chống cháy, chống bụi Chính Hãng', 995000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/76/81/54/6931c2acec1a310cf9fc7488560c27c1.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('55c85db8-1f11-4a5d-86f1-8f501dc4bd45', '2025-06-23 07:27:39.000000', 'Fuhlen', 1353150, 0, 'Bàn phím cơ gaming Fuhlen Eraser Led Rainbow/ Kê tay tháo rời- Hàng chính hãng', 1400000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/96/fd/48/616660861a1e4a44c83851a819c91e0d.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('5611fcd3-16ad-4fa3-b70c-424e7343bade', '2025-06-23 07:27:39.000000', 'T-WOLF', 533500, 0, 'Bàn Phím Cơ T-WOLF T60 Blue Switch (Đen/trắng/xám trắng) - Hàng Chính Hãng', 550000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/ed/f9/f8/19f3dbf3c4f879f174e7d6eca8ecc2ab.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('5803b031-d408-42c5-8be6-a4b147cf9d71', '2025-06-23 07:27:39.000000', 'Fuhlen', 1343450, 0, 'Bàn phím cơ Blue switch Fuhlen D (Destroyer), Phím Gaming Led RGB 7 màu RAINBOW- Hàng chính hãng', 1390000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/d2/cf/9d/b6b0d22df6204b5b257e247c5bdeba9c.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('58592752-4a85-4c39-a91f-5f7fa8000b08', '2025-06-23 07:27:39.000000', 'MINHHA', 572300, 0, 'Bàn phím dành cho Laptop MSI GS66 Stealth 10SD 10SF GE66 Raider 10SF MS-1541 RGB backlit US Keyboard Hàng nhập khẩu', 590000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/58/b9/8e/5c3c3ce906a6c31a05fefc542cfb33e9.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('59c84865-10c3-49b9-906d-a4f806104191', '2025-06-23 07:30:14.000000', 'Logitech', 2124300, 0, 'Bàn phím cơ gaming có dây Logitech G713 - Hàng Chính Hãng', 3349000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/c2/a8/21/6cce3566689d0875180cb3441d6e9ab1.png', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('5b9a8c04-62b7-43ed-8139-aa512605f988', '2025-06-23 07:27:39.000000', 'BAJEAL', 633000, 0, 'Bàn phím cơ có dây BAJEAL chơi game có đèn nền LED,di chuyển với Công tắc màu xanh', 633000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/40/3d/e9/7cbf7930eadad0a66ca8dd5b5a4297b5.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('5c6799c1-0176-4da7-ac84-84c262e2c1ee', '2025-06-23 07:31:05.000000', 'Havit', 339500, 0, 'Bàn phím văn phòng có dây HAVIT KB252 Full-size 108 phím Cổng USB 1.5m Đen Hàng Chính Hãng', 350000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/90/b0/54/6e03c85ac70bdd3b6a382f2e112b2050.png', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('5c87dea8-564b-43d4-a550-383306b75c2d', '2025-06-23 07:30:14.000000', 'Tech77', 654750, 0, 'Bàn Phím Cơ Gaming dây usb GK102 Hotswap chống ồn cho máy tính laptop hàng nhập khẩu', 675000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/73/47/c3/dfb1cb32b12aa0fb986351e2489243ec.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('5d42925a-67cd-40ae-aee7-27125f109061', '2025-06-23 07:31:05.000000', 'R8', 69791, 0, 'Bàn phím máy tính R8 1801 - Hàng Chính Hãng', 71950, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/af/68/7f/c66386842331af0ffb98247c1a7071ab.JPG', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('5f383df8-ce45-4cdc-af42-89fd49cc2ad8', '2025-06-23 07:30:14.000000', 'Logitech', 2124300, 0, 'Bàn phím cơ gaming có dây Logitech G713 - Hàng Chính Hãng', 3160000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/c2/a8/21/2c18af7b59670ebc16d9a8d9cf842467.png', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('5fc75b96-1489-4bdf-90f4-79b6858cf50c', '2025-06-23 07:30:14.000000', 'Newmen', 1018500, 0, 'Bàn phím Cơ NEWMEN GM368 Led RGB, chống cháy, bụi - Hàng chính hãng', 1050000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/76/81/54/98659903f2e753a230e39043d4ac566c.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('61db7753-3466-44a5-bbdb-49ba211d5363', '2025-06-23 07:27:39.000000', 'Langtu', 329800, 0, 'Bàn Phím LED LANGTU L1 Black - hàng nhập khẩu', 340000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/f1/4e/39/52495d039404e06be0e92539ea9acd39.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('62660fe5-f334-4e91-8966-0c8e1f520ee5', '2025-06-23 07:31:05.000000', 'OEM', 134733, 0, 'Bàn phím có dây G700', 138900, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/09/9a/59/989704ed5e5aec5f7dd5ecde4c4c6fe8.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('62737b31-484a-4814-8b20-d3f93352d318', '2025-06-23 07:27:39.000000', 'MINHHA', 378300, 0, 'Bàn phím dành cho Laptop ASUS N550 N550J N550JA N550JK N550JV N550LF - Hàng nhập khẩu', 390000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/08/de/21/d3afb5cc5de5120c2f349d51e514e44f.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('6334c45d-aa29-44e2-b97a-29216accad0a', '2025-06-23 07:30:14.000000', 'Prolink', 843900, 0, 'Bàn phím cơ PROLiNK GK6002M (Blue Switch), LED RGB 16 triệu màu, Full N-Key Rollover, Anti Ghosting cho tuyển thủ Esport - Hàng Chính Hãng', 890000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/55/69/11/cc3e4b68121ec6838279d5cc69686cc6.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('655d2193-e4ee-448f-a39f-9981ddb65f6a', '2025-06-23 07:31:05.000000', 'Logitech', 154230, 0, 'Bàn phím Logitech K120 USB Hàng chính hãng', 159000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/0e/53/a4/0614659a732478fdf19bdac0249190e4.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('66880323-43e8-4961-875e-613f756a41da', '2025-06-23 07:31:05.000000', 'HXSJ', 294000, 0, 'Bàn phím Màng một tay HXSJ 35 phím với đèn nền tiện dụng và Chống bóng', 294000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/35/16/d4/f04afe8f2f23b26337b2606aa0df51b4.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('6966862e-64ad-474b-93f7-cc339f8bf0d7', '2025-06-23 07:27:39.000000', 'Tech77', 514100, 0, 'Bàn Phím Cơ Gaming không dây GK65 chống ồn - Bluetooth + USB - Pin sạc TypeC - Hotswap cho máy tính laptop điện thoại hàng nhập khẩu', 530000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1e/5e/53/38f7197ba21fd877ffeef0a0c683ddb4.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('69d62c84-4df3-4152-909c-d6504bcc194c', '2025-06-23 07:30:14.000000', 'Newmen', 3395000, 0, 'Bàn phím cơ Newmen GM980 Black Star ( Azure/ Misty rain ) - Hàng Chính Hãng', 3500000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/fb/e9/f0/a0bb6430a43194a03446873d9bc81c9b.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('6b6c5b8c-f2b9-4395-a157-a29b39673d10', '2025-06-23 07:27:39.000000', 'T-WOLF', 669300, 0, 'Bàn phím cơ T-WOLF T50 Blue Switch - Hàng Chính Hãng', 690000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/80/22/57/6ba82487250312e571cfb5133458c046.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('6c05666f-c8d3-406e-adff-9f5f95c9bec3', '2025-06-23 07:30:14.000000', 'Logitech', 3267930, 0, 'Bàn phím cơ có dây Gaming Logitech G713 TKL - Hàng chính hãng', 4099000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/5e/75/0f/8d4127c94a93c4fbcdad3147af0e1dec.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('6d812f5c-51dd-4298-bc80-80aa1f96cbcd', '2025-06-23 07:31:05.000000', 'k-snake', 174600, 0, 'Bàn phím Game nút tròn K-SNAKE K4 Led 7 màu - Hàng chính hãng', 180000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/6f/dc/9a/c4de0d21557a49f4c229c029736ddecc.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('70a9d91e-6d39-4618-a60e-2c9ca695a7b9', '2025-06-23 07:27:39.000000', 'E-DRA', 561630, 0, 'Bàn Phím Cơ Gaming EDRA EK3087v2 New 2021 - LED Rainbow - Hàng Chính Hãng', 579000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/6d/b0/d2/a3c14c137a2fe69741b91d235faf6d57.png', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('70fc4268-7e3b-4fc0-8c1a-bc3116ae0389', '2025-06-23 07:30:14.000000', 'E-DRA', 629530, 0, 'Bàn phím cơ E-Dra EK389 TKL - Hàng chính hãng', 649000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/91/f6/0a/c51f6d8957113a1d8a2f0c7ad588beb0.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('715e37b3-980e-455b-8d37-cb4ff65ff1e5', '2025-06-23 07:27:39.000000', 'HXSJ', 606250, 0, 'Bàn phím cơ gaming K3 Led Rainbow Hotswap Chống ồn cho máy tính laptop hàng nhập khẩu', 625000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1e/48/0d/fb54178ddafff4b0436a185151110c9d.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('718958ba-e0f0-49f1-bb8c-052daba5ecf3', '2025-06-23 07:27:39.000000', 'Newmen', 571330, 0, 'Bàn phím cơ Gaming có dây Newmen GM328 Hotswap Black Red Switch - Hàng chính hãng ', 619000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/b9/40/45/5f1c3807d015771571594a8bc9486d2d.PNG', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('735c4a3b-4f92-47b5-b2ed-4d62aa8a6ba4', '2025-06-23 07:27:39.000000', 'E-DRA', 1240630, 0, 'Bàn phím cơ không dây E-Dra EK368W V2 , Hotswap, E-Dra Switch (Brown/Red) - Hàng chính hãng', 1279000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/7d/f2/93/a8565dfbdae646cdad3465a71cc7d347.png', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('7684b009-3a75-4ab7-be09-64d4c025c039', '2025-06-23 07:31:05.000000', 'Rii', 568000, 0, 'Bàn phím không dây Rii K09 Pin có thể sạc lại Bàn phím đa phương tiện Tương thích với iOS Mac OS', 568000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/5b/7e/e0/d7ffd5a33ed00953dc9740e4cd55101e.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('7703b4bd-0300-4d4a-910d-62f0e242766a', '2025-06-23 07:31:05.000000', 'R8', 115236, 0, 'Bàn phím R8 1801 + LÓT X88 - Hàng Nhập Khẩu       ', 118800, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/6c/ef/c4/5a5528f38188c05ee6d361e6b30bbb63.png', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('78405f2a-c966-4549-b24d-fb63dc141874', '2025-06-23 07:27:39.000000', 'BAJEAL', 576000, 0, 'Bàn phím cơ học có dây nhỏ gọn BAJEAL với 61 phím Double Shot Keycaps 6 / N-key Rollover LED Hiệu ứng đèn nền màu xanh lam ', 576000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/cc/02/96/d8935035a406df7a0c06453f2c103441.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('78521e04-b4d6-4d17-a928-015863d6e4ce', '2025-06-23 07:27:39.000000', 'E-DRA', 577150, 0, 'Bàn phím cơ chơi game có dây E-Dra EK3287 - Led Rainbow - E-dra Switch - Hàng chính hãng', 595000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/53/f8/00/a3cd8e4561e57be768a0ec4ad706c739.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('797e5845-02c8-4ab6-83ee-d28870fa8faa', '2025-06-23 07:31:05.000000', 'WIWU', 1154299, 0, 'Bàn Phím Wiwu Paul Frank 3 In 1 Dành Cho PC Bộ Kết Hợp Chuột Và Bàn phím - Hàng Chính Hãng', 1189999, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a0/9b/b0/e39a9c2bc993ffcf0b245c9540065b3f.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('7995a4f4-9ec3-45ab-95a4-f49ec3e5ab5a', '2025-06-23 09:33:04.019204', 'fsdsdf', NULL, 0, 'hoàng lập', 100000, 100, '', '', '6233447a-56ac-4130-b344-7a56acc13062', 1, 0, 0),
	('7a983164-7fa7-4b74-9c11-4db735175104', '2025-06-23 07:31:05.000000', 'AULA', 160050, 0, 'Bàn phím văn phòng có dây Aula AK105 - Hàng Chính Hãng', 179000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/bb/f3/ff/531b52d45fbfd29492ac58eccef49459.PNG', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('7ab61c33-2096-4744-94de-b4b6945fa415', '2025-06-23 07:27:39.000000', 'Tech77', 776000, 0, 'Bàn Phím Cơ Gaming không dây GK102 chống ồn - Bluetooth + USB - Pin sạc TypeC - Hotswap cho máy tính laptop điện thoại hàng nhập khẩu', 800000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/ec/67/19/99bae27cd7840707acacb32cc97758e2.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('7cbe5819-55de-4eb4-abd2-cc4fd55fb6c4', '2025-06-23 07:31:05.000000', 'Logitech', 949630, 0, 'Bàn phím có dây Gaming Logitech G213 - Hàng chính hãng', 979000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/ac/18/3b/9ad5ceecbd71d28334081c10f8e44b11.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('7f946539-a0ac-47ac-a582-1a2e4d1ef127', '2025-06-23 07:30:14.000000', 'Golden Field', 163930, 0, 'Bàn phím máy tính giả cơ có dây GOLDEN FIELD GK309 - Hàng Chính Hãng', 169000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/5a/a7/de/327018d1e5b2841f044cfb97fba29f33.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('82122f3c-1cfa-453f-813c-e228bf869f68', '2025-06-23 07:31:05.000000', 'HXSJ', 451000, 0, 'Bàn phím chơi game có dây HXSJ V700 61 phím dành cho Game / Văn phòng ', 451000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/97/f8/4a/d607b64ca645df73cd066c2181ab4a54.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('861d7ee2-ac9d-4127-beb4-165c848b21d2', '2025-06-23 07:27:39.000000', 'Tech77', 645050, 0, 'Bàn Phím Cơ K900 Gaming - Led xuyên phím có hotswap cho máy tính , laptop hàng nhập khẩu', 665000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/85/26/57/e5561d66deca1919d4a6f11e1da6901f.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('877deb7b-3170-40ce-9bc4-53a1797a972e', '2025-06-23 07:27:39.000000', 'Newmen', 824500, 0, 'Bộ kit phím cơ Newmen GM610 61keys, RGB backlight - Hàng Chính Hãng ', 850000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/b4/b8/4d/87e4297ca74a0f3b7983dfce8fbbf0a4.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('87cca7c5-869a-4198-b29e-1d0fc4886511', '2025-06-23 07:30:14.000000', 'Deli', 783954, 0, 'Bàn Phím Cơ Gaming Deli VS788 PRO LED RGB Chế Độ Nháy Cực Đẹp Khác Nhau, Phím Cơ Gõ Siêu Đã, Thiết Kế Nhỏ Gọn Tương Thích Với Laptop, PC, Máy Tính, Kiểu Dáng Gamer Game Thủ eSport Bàn Phím Văn Phòng - Hàng Chính Hãng', 808200, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1a/89/a8/9d418feb34b20596a1e8ead9a79f7aee.png', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('897392e3-1b6f-4d55-b232-3a368fcb57c0', '2025-06-23 07:31:05.000000', 'Logitech', 163930, 0, 'Bàn Phím Logitech K120 - Hàng Chính Hãng', 169000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/91/9c/03/9d1a3ad4831b09867e2e8c4685bf1f6d.png', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('8b40aa10-92e3-4455-9d7e-5b9eeb696757', '2025-06-23 07:31:05.000000', 'Fuhlen', 194000, 0, 'Bàn Phím Game Fuhlen L411 - Hàng Chính Hãng', 200000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/00/c6/3a/15d237969b67fe418e1c0f283c76a6d9.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('8de5a99a-ea25-486d-ab3a-919a43c922cf', '2025-06-23 07:31:05.000000', 'Fuhlen', 194000, 0, 'Bàn phím fuhlen L411 - hàng chính hãng', 200000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/86/b0/fa/d95075d1b07de895c4cf4091411aa02d.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('8e1c1411-9d3e-440f-88cf-bb655fd54b7b', '2025-06-23 07:31:05.000000', 'Tech77', 305550, 0, 'Bàn phím không dây mini W159 - pin sạc - đa kết nối bluetooth 5.0 + 3.0 + Usb wireless 2.4G hàng nhập khẩu', 315000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/94/dd/b8/249ddf96bbd1712d086d50f968ebe2a6.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('906c0fbe-04bb-4a17-a5e0-f972585f40c7', '2025-06-23 07:30:14.000000', 'HXSJ', 606250, 0, 'Bàn phím cơ gaming K3 Led Rainbow Hotswap Chống ồn cho máy tính laptop hàng nhập khẩu', 625000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1e/48/0d/fb54178ddafff4b0436a185151110c9d.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('9505a216-2831-4946-86cc-c85eed61833e', '2025-06-23 07:30:14.000000', 'ZIYOU LANG ', 339500, 0, 'Bàn phím cơ máy tính ZIYOULANG K2 - Bàn phím gaming công thái học cơ blue switch 87 phím Led RGB chế độ đổi màu đẹp - Hàng nhập khẩu', 405900, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/75/50/0d/bfd3b600b913d3041bad2fda2fef0440.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('9a19062e-114f-471a-bea3-16d7f07a7113', '2025-06-23 07:30:14.000000', 'Tech77', 591700, 0, 'Bàn Phím Cơ E917 Gaming - Led xuyên phím có hotswap cho máy tính , laptop hàng nhập khẩu', 610000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a8/b4/d2/44b79741ec6b69a10b00782a9b750955.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('9ad26d8b-718d-427d-afd8-1a0353ea8136', '2025-06-23 07:27:39.000000', 'T-WOLF', 727500, 0, 'Bàn Phím Cơ Không Dây T-WOLF T30 Blue Switch - Hàng Chính Hãng', 750000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/39/ca/ae/f9c982a5cba1b03d45c9ba7d684e512b.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('9cb9f59e-7834-4e5a-bb5b-b6a4dac5710e', '2025-06-23 07:31:05.000000', 'Tech77', 591700, 0, 'Bàn Phím Cơ E917 Gaming - Led xuyên phím có hotswap cho máy tính , laptop hàng nhập khẩu', 610000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a8/b4/d2/44b79741ec6b69a10b00782a9b750955.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('9eb4f39e-a629-4eac-9d22-fb26ae336dae', '2025-06-23 07:27:39.000000', 'Tech77', 482090, 0, 'Bàn phím giả cơ Không dây Bluetooth M87 Gaming Led rainbow cho máy tính , laptop , điện thoại , máy tính bảng hàng nhập khẩu', 497000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/4c/f4/9f/49857ab02d9353ddd2332e8a07a00bdf.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('9f11aa0f-e103-4425-9ae1-ec58e0e3fafa', '2025-06-23 07:31:05.000000', 'Tech77', 266750, 0, 'Bàn Phím Led Rainbow Gaming Giả cơ K82 có núm chỉnh âm lượng cho máy tính , laptop hàng nhập khẩu', 275000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/e6/38/19/d83cac9727dffc24d6678bd292149518.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('a034e7d2-5a73-4ffe-98d6-592a7329d2f0', '2025-06-23 07:30:14.000000', 'MAGIC-REFINER', 943000, 0, 'Bàn phím cơ chơi game Magic Refiner MK15 108 có dây', 943000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/ff/96/16/636e6a08ac59c34e7b3532d3fba215e7.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('a2166b52-0ca3-40f8-9d22-0ca4d70490c3', '2025-06-23 07:27:39.000000', 'Newmen', 649900, 0, 'Bàn phím cơ NEWMEN GM328 Grey-White Red switch - Hàng Chính Hãng', 670000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/85/fa/3d/2bda58eee6c2a43d6565ba7d8503306b.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('a38a56f5-7df5-4555-9b82-0041db47099f', '2025-06-23 07:30:14.000000', 'Onikuma', 312340, 0, 'Bàn Phím Cơ ONIKUMA G32 Wired - Sự Lựa Chọn Lý Tưởng - Black - Hàng Chính Hãng', 322000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/b8/cd/cf/991059d854069f0ba5c34d0340454a25.png', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('a537de39-7cb1-4e3c-9f47-126fa746f8f3', '2025-06-23 07:27:39.000000', 'FL-ESPORT', 1880830, 0, 'Bàn phím cơ FL-Esports F12 RGB White and Grey/Cool Mint/White and Black/Black Ovilian - Hàng chính hãng', 1939000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/20/ae/3e/ea88b21eec38e2fea6a720a985308ea4.png', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('a5b411bc-b8c4-4394-a4f4-85f25fc8601a', '2025-06-23 07:31:05.000000', 'Tech77', 368600, 0, 'Bàn phím không dây K635 - pin sạc TypeC - đa kết nối bluetooth 5.0 + 3.0 + Usb wireless 2.4g hàng nhập khẩu', 380000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/30/66/92/6e773270dce107a1d14316786312bd11.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('a67b197a-a891-4984-b413-c79fe496d429', '2025-06-23 07:30:14.000000', 'Tech77', 514100, 0, 'Bàn Phím Cơ Gaming không dây GK65 chống ồn - Bluetooth + USB - Pin sạc TypeC - Hotswap cho máy tính laptop điện thoại hàng nhập khẩu', 530000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1e/5e/53/38f7197ba21fd877ffeef0a0c683ddb4.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('a6fe2da1-b80a-4519-9687-e185628596b8', '2025-06-23 07:30:14.000000', 'OEM', 92150, 0, 'Bàn phím G21 LED giả cơ game chuyên dụng', 95000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/22/9a/e3/3c7c2e51e973b67ec7189759239b87db.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('ab2c521d-ed4d-4374-ac49-bfb41e9473d1', '2025-06-23 07:31:05.000000', 'MISUFUJl', 199786, 0, 'Bàn phím cho laptop l411 - Hàng Nhập Khẩu', 205965, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/b2/9a/f3/5669a237dba950759f4d4e563acf26da.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('adf5f73d-d537-4f75-b272-1ef4b2f5e8f6', '2025-06-23 07:27:39.000000', 'MAGIC-REFINER', 908000, 0, 'Bàn phím cơ MAGIC-REFINER 108 Phím N-key rollover Cáp USB Blue Switch Backlight-Size phiên bản tiếng Anh', 908000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a4/ca/44/a1b9e7ccfdbd3ca60fc9c2d104d532b0.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('aeed6277-4902-478e-a899-433bd18a1888', '2025-06-23 07:27:39.000000', 'E-DRA', 769210, 0, 'Bàn phím cơ chơi game có dây E-DRA EK3104L - Led Rainbow - E-Dra Switch - Kết nối USB - Hàng chính hãng', 793000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/dd/22/6f/ea8e5940ef57263e08ea7f563a20986c.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('b00027db-4e10-4783-bde1-e3cd25472b49', '2025-06-23 07:31:05.000000', 'Langtu', 329800, 0, 'Bàn Phím LED LANGTU L1 Black - hàng nhập khẩu', 340000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/f1/4e/39/52495d039404e06be0e92539ea9acd39.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('b034ad6a-7204-4979-b46a-f90421b1f204', '2025-06-23 07:30:14.000000', 'Onikuma', 776000, 0, 'Bàn Phím Cơ ONIKUMA G38 Wired RGB - Hiệu Suất Cao và Thiết Kế Đẳng Cấp - Black, White - Hàng Chính Hãng', 800000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/bf/dd/22/284e610413880856072c87f104ca9ac9.png', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('b20042f1-e3f4-4c0c-94c5-bef8a95cc141', '2025-06-23 07:31:05.000000', 'HYSJ', 242500, 0, 'Bàn Phím Chuột không dây W201 nhỏ gọn cho máy tính , Laptop hàng nhập khẩu', 250000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/ca/a7/1e/ebe3a37b3459b1fd7f51a3dc67123425.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('b425911d-d0c5-446e-a7f1-6b42e5f66d6b', '2025-06-23 07:27:39.000000', 'HXSJ', 125130, 0, 'Bàn phím giả cơ G21 kèm chuột, bàn phím máy tính chống nước led rgb chơi game làm việc văn phòng cho PC laptop - hàng chính hãng', 199000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1f/1d/a3/3ae5f3b159bdee326a4914c28948cffb.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('b502dfba-049d-45ee-98e3-fbc00180e313', '2025-06-23 07:27:39.000000', 'E-DRA', 639230, 0, 'Bàn phím cơ E-Dra EK387 Huano Switch (Type C) - Hãng Chính Hãng', 659000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/6e/f1/98/9f87d7ba2bde4bf43aec69b32f116eb4.png', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('b6c4a557-c3ce-46db-9210-556db933a02e', '2025-06-23 07:27:39.000000', 'MINHHA', 630500, 0, 'Bàn phím dành cho Laptop HP ProBook 450 G9 455 G9 455R G9 có Led hàng nhập khẩu', 650000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a1/fe/2c/59210bc2b4f1c8620b204d50f4951f8f.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('b80404a8-e96a-40ba-9a3b-d1e0f03ca54f', '2025-06-23 07:31:05.000000', 'Tech77', 514100, 0, 'Bàn Phím Cơ Gaming không dây GK65 chống ồn - Bluetooth + USB - Pin sạc TypeC - Hotswap cho máy tính laptop điện thoại hàng nhập khẩu', 530000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1e/5e/53/38f7197ba21fd877ffeef0a0c683ddb4.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('b85d49c6-1432-4aea-b6dc-db61b16366be', '2025-06-23 07:30:14.000000', 'MAGIC-REFINER', 908000, 0, 'Bàn phím cơ MAGIC-REFINER 108 Phím N-key rollover Cáp USB Blue Switch Backlight-Size phiên bản tiếng Anh', 908000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a4/ca/44/a1b9e7ccfdbd3ca60fc9c2d104d532b0.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('b98342c2-987f-42fc-aad7-84871cc741ef', '2025-06-23 07:30:14.000000', 'HYSJ', 242500, 0, 'Bàn Phím Chuột không dây W201 nhỏ gọn cho máy tính , Laptop hàng nhập khẩu', 250000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/ca/a7/1e/ebe3a37b3459b1fd7f51a3dc67123425.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('bc6e258e-a74c-463a-bad1-636e7dbf3f35', '2025-06-23 07:30:14.000000', 'Tech77', 482090, 0, 'Bàn phím giả cơ Không dây Bluetooth M87 Gaming Led rainbow cho máy tính , laptop , điện thoại , máy tính bảng hàng nhập khẩu', 497000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/4c/f4/9f/49857ab02d9353ddd2332e8a07a00bdf.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('bcd97319-b8f3-4b77-aa7a-b52c228e5d34', '2025-06-23 07:31:05.000000', 'Tech77', 368600, 0, 'Bàn phím không dây mini W160 - pin sạc - đa kết nối bluetooth 5.0 + 3.0 + Usb wireless 2.4G hàng nhập khẩu', 380000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/b0/43/c9/9e8e14489f695b16a31ec61e2d6f3715.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('bce4a365-01fe-4134-8528-2acad3416908', '2025-06-23 07:27:39.000000', 'Tech77', 591700, 0, 'Bàn Phím Cơ E917 Gaming - Led xuyên phím có hotswap cho máy tính , laptop hàng nhập khẩu', 610000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a8/b4/d2/44b79741ec6b69a10b00782a9b750955.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('bf16f4e6-f208-487d-bb96-be711632cc04', '2025-06-23 07:31:05.000000', 'MISUFUJl', 288083, 0, 'Bàn Phím cho Máy Tính HP6530S - Hàng Nhập Khẩu', 296993, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/8a/21/c0/02c9aeb6632cb7bf32f6c3ff49e5f5b1.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('c0243a04-926e-4045-972c-3624942c3c03', '2025-06-23 07:30:14.000000', 'Ajazz', 980000, 0, 'Bàn phím cơ BT Ajazz & K680T hai chế độ có dây có đèn nền nhỏ gọn -Màu đen-Size Công tắc màu xanh lam', 980000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/c2/02/28/34615ab9fd1c38d1563654c4bcfc4645.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('c0eebf65-d977-48c9-bfd2-e34ac2736926', '2025-06-23 07:31:05.000000', 'Langtu', 329800, 0, 'Bàn Phím LED LANGTU L1 White - hàng nhập khẩu', 340000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/70/65/56/7f2062fd96153c4fd2f14938fcccc01a.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('c2a59b54-1867-4488-a024-6d15ccf871ea', '2025-06-23 07:27:39.000000', 'E-DRA', 813830, 0, 'Bàn phím cơ E-Dra EK387 Gateron Switch - Hàng Chính Hãng', 839000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/61/35/a5/049156ac5b012310ba991fcb559577d5.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('c2bdb87b-5f32-4370-977e-f45882cc8c07', '2025-06-23 07:31:05.000000', 'Simetech', 189150, 0, 'Bàn phím SIMETECH SK212 siêu bền - hàng chính hãng', 195000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/26/22/01/a448c918134a2b1763bcc9d893339780.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('c3e623f5-9d3a-4068-81e9-f27760e83019', '2025-06-23 07:31:05.000000', 'MISUFUJl', 206763, 0, 'Bàn Phím cho máy tính Dell N5010 - Hàng Nhập Khẩu', 213158, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/da/91/45/ba5dc126469e6c4fbefcb1f0da3fdf9b.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('c4451ce7-079a-4592-b95e-7e0d1686fb25', '2025-06-23 07:31:05.000000', 'Tech77', 482090, 0, 'Bàn phím giả cơ Không dây Bluetooth M87 Gaming Led rainbow cho máy tính , laptop , điện thoại , máy tính bảng hàng nhập khẩu', 497000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/4c/f4/9f/49857ab02d9353ddd2332e8a07a00bdf.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('c63d400c-8219-467f-a1a7-5de4e3e8429d', '2025-06-23 07:30:14.000000', 'AULA', 464630, 0, 'Bàn phím cơ Gaming có dây Aula S2022 màu hồng - Hàng Chính Hãng', 509000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/40/6a/8e/050c39be771541ee20b479c4a77e9f90.PNG', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('c8b86bd6-9fd5-4bcf-92b4-01b366552e34', '2025-06-23 07:27:39.000000', 'AULA', 726530, 0, 'Bàn Phím cơ gaming có dây AULA F2058 Red Switch - Hàng Chính Hãng ', 759000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/29/96/d7/a28ec0ea1cfc8167d20d75ae4fa9d8ab.PNG', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('cc1b6d28-3b8d-446b-808e-155803ab9c3a', '2025-06-23 07:30:14.000000', 'Nikko', 1393890, 0, '[Hàng Chính Hãng NIKKO] Bàn phím cơ chính hãng RKM75/RK61/RK61PLUS', 1437000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/3d/a9/a1/d9038e515fd7dde3169b759d7a7c162b.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('ceba43ba-336c-4fb0-80b2-6a6d16b37df7', '2025-06-23 07:27:39.000000', 'Langtu', 329800, 0, 'Bàn Phím LED LANGTU L1 White - hàng nhập khẩu', 340000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/70/65/56/7f2062fd96153c4fd2f14938fcccc01a.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('d2e0376f-30ac-4a90-8bd8-ee41c615d6c6', '2025-06-23 07:27:39.000000', 'Tech77', 654750, 0, 'Bàn Phím Cơ Gaming dây usb GK102 Hotswap chống ồn cho máy tính laptop hàng nhập khẩu', 675000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/73/47/c3/dfb1cb32b12aa0fb986351e2489243ec.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('d7b3ff30-369a-4fc0-b64b-c06c93731726', '2025-06-23 07:27:39.000000', 'Micropack', 5212780, 0, 'Bàn Phím Cơ Không Dây MicroPack Lifestyle K-168WM 3 Modes Wireless Mechanical Keyboard Vỏ Trong Suốt LED RGB Nhiều Màu Hàng Chính Hãng', 5374000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/8d/6d/42/e6a85a4c776eb1102a6726a5bfae0013.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('d856c4c9-c899-4e7c-a715-953b9728ad5a', '2025-06-23 07:31:05.000000', 'DareU', 150350, 0, 'Bàn Phím DareU LK185  - Hàng Chính Hãng', 155000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/16/f9/35/fade6b5d78012583cf0a91964c958c49.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('dc93837f-4c61-486f-8992-b06f8b80333d', '2025-06-23 07:31:05.000000', 'Langtu', 426800, 0, 'Bàn Phím LED LANGTU L1B cho máy tính - Hàng nhập khẩu', 440000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/18/1d/34/fa00a0d2c52bcd55c24ac7270037382e.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('dd311eb3-7310-462a-a70d-18296da6507b', '2025-06-23 07:30:14.000000', 'T-WOLF', 465600, 0, 'Bàn Phím Cơ T-WOLF T17 USB- Hàng Chính Hãng ', 480000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/1a/91/d1/1b6867e2c227da65890c0899ad546098.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('e4502134-4d12-4f12-aec6-7b79be2487d4', '2025-06-23 07:30:14.000000', 'Newmen', 2502600, 0, 'Bàn phím cơ không dây Newmen GM1080 Pudding 3 mode - Hàng chính hãng', 2590000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/3f/33/17/60643fbddf7e415f496342ae1305e714.png', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('e48357c9-68e7-4998-8722-e1c76dfedff1', '2025-06-23 07:27:39.000000', 'HYSJ', 242500, 0, 'Bàn Phím Chuột không dây W201 nhỏ gọn cho máy tính , Laptop hàng nhập khẩu', 250000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/ca/a7/1e/ebe3a37b3459b1fd7f51a3dc67123425.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('e4bb1712-784d-4f0a-a419-d0f33d3b9c80', '2025-06-23 07:31:05.000000', 'ROGTZ', 252200, 0, 'Bàn Phím Giả Cơ 1 Tay Free Wolf K11 Chuyên Game 28 Phím - Hàng Nhập Khẩu', 265000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/23/b8/f6/c563aa12b559a951a9e22c69ec85b11d.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('e4db6187-39ef-493b-aaeb-49b703c61ca9', '2025-06-23 07:30:14.000000', 'Tech77', 591700, 0, 'Bàn Phím Cơ E917 Gaming - Led xuyên phím có hotswap cho máy tính , laptop hàng nhập khẩu', 610000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a8/b4/d2/44b79741ec6b69a10b00782a9b750955.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('e63549ed-5176-412a-a0e0-15adf7fed498', '2025-06-23 07:31:05.000000', 'Tech77', 669300, 0, 'Bàn phím Gấp gọn không dây Bluetooth B66T - Tích hợp Touchpad - pin sạc TypeC- có hàng phím F1-F12 hàng nhập khẩu', 690000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a3/a5/31/c7d73aff751bd6ce69b7d844256c3378.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('e6422863-1187-45e0-8ed6-df7fa7d8e3e7', '2025-06-23 07:31:05.000000', 'OEM', 104760, 0, 'Bộ Bàn Phím Giả Cơ và Chuột Chuyên Game G21 Led 7 Màu - Màu trắng', 108000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/7b/c7/d3/76fefb827690701045ce6e2af9c1650d.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('e93ae496-e72a-4337-b0f7-283bd39cff73', '2025-06-23 07:30:14.000000', 'EDRA', 769210, 0, 'Bàn phím cơ gaming có dây EDRA EK316 - Hàng Chính Hãng', 793000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/f4/83/3f/a6ca65e0d8309d4eead556b23bec7734.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('ea02db42-b7a3-4aba-b136-b5bc05d5bda5', '2025-06-23 07:30:14.000000', 'E-DRA', 577150, 0, 'Bàn phím cơ E-DRA EK398 Beta - Hàng Chính Hãng', 595000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/19/0a/ef/b5eb5283b29d49d96ff83ee72dd771bd.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('ea415cb9-278d-4e6c-8230-d4aaf853e9ce', '2025-06-23 07:30:14.000000', 'Ajazz', 980000, 0, 'Bộ bàn phím cơ Ajazz chơi game có dây USB-Màu Hồng-Size Công tắc màu xanh lam', 980000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a0/f4/e3/8d5156f9b8c0c605e78b9b3bf24c9209.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('ee66400d-1c55-4b27-bded-79698d83d031', '2025-06-23 07:30:14.000000', 'E-DRA', 474330, 0, 'Bàn phím cơ E-Dra EK368L - Hàng chính hãng', 489000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/37/cd/19/02c6d6c12555558121bd0b62369bfdd2.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('efb68274-8f04-4442-9204-4fa24fe94c19', '2025-06-23 07:30:14.000000', 'BAJEAL', 633000, 0, 'Bàn phím cơ có dây BAJEAL chơi game có đèn nền LED,di chuyển với Công tắc màu xanh', 633000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/40/3d/e9/7cbf7930eadad0a66ca8dd5b5a4297b5.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('f173ac2d-9d67-412e-bc57-4a32e07c9b46', '2025-06-23 07:31:05.000000', 'Tech77', 339500, 0, 'Bàn phím không dây mini W159C - pin sạc TypeC - đa kết nối bluetooth 5.0 + 3.0 + Usb wireless 2.4G hàng nhập khẩu', 350000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/d9/56/1f/7287439353c630106e49a968fef991f3.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('f2eccd24-2bd3-48cf-81df-5a5e957022d0', '2025-06-23 07:30:14.000000', 'E-DRA', 484030, 0, 'Bàn phím chơi game cơ E-Dra EK398 - Hàng chính hãng', 499000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/d0/7d/f4/1023919afca17656f50e1caeee1c4743.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('f496b1f6-35b0-4842-b574-6f0473902491', '2025-06-23 07:30:14.000000', 'Logitech', 2085500, 0, 'Bàn phím game cơ học Logitech G512 - RGB Lightsync, 3 loại GX Switch, vật liệu cải tiến, cổng USB 2.0 - Hàng chính hãng', 2150000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/e8/7a/a4/3252a0547786165237a9c391d942b0c5.png', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('f5868518-6139-4b7b-979f-e84c0d4af414', '2025-06-23 07:27:39.000000', 'T-WOLF', 727500, 0, 'Bàn Phím Cơ Không Dây T-WOLF T30 Blue Switch - Hàng Chính Hãng', 750000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/60/38/4f/a048d89a6f29da3859cc6c76a3e59bd2.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('f7089ff1-e5c7-477d-a29d-99f8eea72094', '2025-06-23 07:31:05.000000', 'Logitech', 154230, 0, 'Bàn phím có dây Logitech K120 - Hàng chính hãng', 159000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/01/c9/b9/4c92a02dbf8def20c13076cbf2d1c28f.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('f72c9a94-9e1f-4fa4-b8b9-1a1771305cf5', '2025-06-23 07:30:14.000000', 'E-DRA', 561630, 0, 'Bàn Phím Cơ Gaming EDRA EK3087v2 New 2021 - LED Rainbow - Hàng Chính Hãng', 579000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/6d/b0/d2/a3c14c137a2fe69741b91d235faf6d57.png', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('f7aa6884-3054-4f6d-8acc-ffa69f2bffbc', '2025-06-23 07:27:39.000000', 'E-DRA', 1298830, 0, 'Bàn phím cơ không dây E-Dra EK396W Gateron Switch - Hàng chính hãng', 1339000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/f4/df/77/072d8afa0b191aa43bb9ade72c5cd02e.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('f835536b-a7cf-4d0d-8761-0159c92ad674', '2025-06-23 07:27:39.000000', 'Tech77', 591700, 0, 'Bàn Phím Cơ E917 Gaming - Led xuyên phím có hotswap cho máy tính , laptop hàng nhập khẩu', 610000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a8/b4/d2/44b79741ec6b69a10b00782a9b750955.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('f87581dd-7a6c-43be-a22a-1fb1a0dd28e8', '2025-06-23 07:30:14.000000', 'AULA', 697430, 0, 'Bàn Phím cơ gaming có dây AULA F2058 - Hàng Chính Hãng ', 729000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/7e/fd/f3/c56828ac9e9e7363eddd7041dec43b14.PNG', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('f888172f-fc88-4eb9-9de4-9024cf7b8178', '2025-06-23 07:27:39.000000', 'MINHHA', 378300, 0, 'Bàn phím dành cho LENOVO YOGA|FLEX SLIM 7-14ARE05 7-14IIL05 7-14 LED hàng nhập khẩu', 390000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/8a/02/74/9ced64f2dadf846f55c71553fd0042e5.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0),
	('f8ac4ee4-f035-4d21-9961-23eeaeeb3fc2', '2025-06-23 07:31:05.000000', 'Logitech', 163930, 0, 'Bàn phím có dây Logitech K120 - Hàng chính hãng', 169000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/39/b0/b7/fcce86987b6cc0cfb46f8aefd26e4e8a.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('f9ba4dec-a646-48b1-972b-f442d7d846bb', '2025-06-23 07:31:05.000000', 'Vision', 106700, 0, 'Bàn phím máy tính Vision G8 - Hàng Chính Hãng', 110000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/8c/6d/06/fe5d910c3b87e024b7f66219aec8c250.jpg', '0', '6233447a-56ac-4130-b344-7a56acc13062', 0, 0, 0),
	('fa79a052-d65c-4289-998c-d0a226e59e12', '2025-06-23 07:30:14.000000', 'AULA', 726530, 0, 'Bàn Phím cơ gaming có dây AULA F75 (Phiên bản Red switch) - Hàng chính hãng', 799000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/4b/e3/80/fa487b8f2875e548a9ed2a61b6859935.PNG', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('fba576e6-ff5c-4cd8-aed2-41c23441c881', '2025-06-23 07:30:14.000000', 'Logitech', 3453200, 0, 'Bàn phím cơ gaming có dây Logitech G713 TKL - RGB, tương thích PC, Mac - Hàng Chính Hãng', 3590000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/18/e0/02/e0174befcf37db698ff3ace3d25a5925.jpg', '0', '65929f3a-6c22-4240-929f-3a6c22d2403a', 0, 0, 0),
	('fc518fd5-8a16-4f14-9cd5-d0996b6c03c6', '2025-06-23 07:27:39.000000', 'Ajazz', 980000, 0, 'Bộ bàn phím cơ Ajazz chơi game có dây USB-Màu Hồng-Size Công tắc màu xanh lam', 980000, 100, 'https://salt.tikicdn.com/cache/280x280/ts/product/a0/f4/e3/8d5156f9b8c0c605e78b9b3bf24c9209.jpg', '0', 'b4c1438b-becf-4ff8-8143-8bbecfeff813', 0, 0, 0);

-- Dumping structure for table mod_keyboard.product_images
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE IF NOT EXISTS `product_images` (
  `id` char(36) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `product_id` char(36) NOT NULL,
  `is_temporary` tinyint(1) DEFAULT '1',
  `uploaded_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqnq71xsohugpqwf3c9gxmsuy` (`product_id`),
  CONSTRAINT `FKqnq71xsohugpqwf3c9gxmsuy` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.product_images: ~344 rows (approximately)
DELETE FROM `product_images`;
INSERT INTO `product_images` (`id`, `image_path`, `is_deleted`, `product_id`, `is_temporary`, `uploaded_at`) VALUES
	('0115e2db-8732-483f-9cd0-ac064006d501', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '6c05666f-c8d3-406e-adff-9f5f95c9bec3', 1, '2025-06-23 07:30:14.522816'),
	('01b685c0-1f7b-4e02-8620-e63d49e10da8', 'https://salt.tikicdn.com/cache/280x280/ts/product/70/65/56/7f2062fd96153c4fd2f14938fcccc01a.jpg', 0, '30c57e9c-bbe9-4330-a063-4996065a93f5', 1, '2025-06-23 07:30:14.522816'),
	('02e1b774-b5ce-4a92-a4fa-c8c5f3de9cc3', 'https://salt.tikicdn.com/cache/280x280/ts/product/73/47/c3/dfb1cb32b12aa0fb986351e2489243ec.jpg', 0, 'd2e0376f-30ac-4a90-8bd8-ee41c615d6c6', 1, '2025-06-23 07:27:39.142798'),
	('03406539-13f3-4cc7-8cf4-926e8ca9be4b', 'https://salt.tikicdn.com/cache/280x280/ts/product/86/b0/fa/d95075d1b07de895c4cf4091411aa02d.jpg', 0, '8de5a99a-ea25-486d-ab3a-919a43c922cf', 1, '2025-06-23 07:31:05.823241'),
	('035e5236-2a0a-4bfc-af29-061a1a410bfe', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, '55c85db8-1f11-4a5d-86f1-8f501dc4bd45', 1, '2025-06-23 07:27:39.142798'),
	('043ce3d0-eeba-4cc6-8459-b9eb9340f6c3', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '4ae0b19a-8343-486f-bdfc-d3e0f175fbb0', 1, '2025-06-23 07:31:05.823241'),
	('052a1dab-6db0-4951-bcfd-d8deb283728f', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'a38a56f5-7df5-4555-9b82-0041db47099f', 1, '2025-06-23 07:30:14.522816'),
	('06699b69-3fe2-4e62-91d0-674be1bbef27', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '3914bee3-6998-4e53-92cd-e508c5f85d5d', 1, '2025-06-23 07:27:39.142798'),
	('07375f7e-6f72-469c-9248-3aa70d430312', 'https://salt.tikicdn.com/cache/280x280/ts/product/1e/48/0d/fb54178ddafff4b0436a185151110c9d.jpg', 0, '715e37b3-980e-455b-8d37-cb4ff65ff1e5', 1, '2025-06-23 07:27:39.142798'),
	('0738ba3d-01a1-4962-bf47-c175780dbfd7', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'b80404a8-e96a-40ba-9a3b-d1e0f03ca54f', 1, '2025-06-23 07:31:05.823241'),
	('073cc5e8-8ea1-4201-9126-5516ee0983f3', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'a67b197a-a891-4984-b413-c79fe496d429', 1, '2025-06-23 07:30:14.522816'),
	('076aa741-87fe-4c06-9edc-bf16f14a3295', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'f173ac2d-9d67-412e-bc57-4a32e07c9b46', 1, '2025-06-23 07:31:05.823241'),
	('07fdc597-01ca-4889-86a3-4bddb0a339c3', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, 'a5b411bc-b8c4-4394-a4f4-85f25fc8601a', 1, '2025-06-23 07:31:05.823241'),
	('087acc39-ac3d-4584-b835-08306d1938ac', 'https://salt.tikicdn.com/cache/280x280/ts/product/85/fa/3d/2bda58eee6c2a43d6565ba7d8503306b.jpg', 0, 'a2166b52-0ca3-40f8-9d22-0ca4d70490c3', 1, '2025-06-23 07:27:39.142798'),
	('08da8102-1dd2-4794-b5b2-caa66c051376', 'https://salt.tikicdn.com/cache/280x280/ts/product/ca/a7/1e/ebe3a37b3459b1fd7f51a3dc67123425.jpg', 0, 'b98342c2-987f-42fc-aad7-84871cc741ef', 1, '2025-06-23 07:30:14.522816'),
	('09689421-9cda-487b-bf15-363e943b7bc6', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'c2bdb87b-5f32-4370-977e-f45882cc8c07', 1, '2025-06-23 07:31:05.823241'),
	('0bce2510-d81b-456e-a61c-05761bd608f4', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '82122f3c-1cfa-453f-813c-e228bf869f68', 1, '2025-06-23 07:31:05.823241'),
	('0c25ad99-6e03-4ff2-839c-85e447a31dce', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '655d2193-e4ee-448f-a39f-9981ddb65f6a', 1, '2025-06-23 07:31:05.823241'),
	('0d23c051-734e-482f-aad3-b3b7ea1256e3', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '4a322a52-e1ea-403e-85cb-bc0b881d2eeb', 1, '2025-06-23 07:27:39.142798'),
	('0d685cfb-4cb0-46c0-bff4-fbaf1e9e863b', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '104ef33f-da83-471f-b929-76f35924da6a', 1, '2025-06-23 07:31:05.823241'),
	('0e82a24b-d7b2-4ac5-be9e-62c39890260d', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '78405f2a-c966-4549-b24d-fb63dc141874', 1, '2025-06-23 07:27:39.142798'),
	('0ee19b3f-8999-4866-9b6e-f0383d685ead', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '5611fcd3-16ad-4fa3-b70c-424e7343bade', 1, '2025-06-23 07:27:39.142798'),
	('0fe5ede6-bfec-4a86-8c4e-3f2d755ab0be', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '50b50901-f42c-428b-bad0-2d5b36831326', 1, '2025-06-23 07:30:14.522816'),
	('1229d9b2-1667-4cf3-bd3b-a6a98e9cd45c', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '2245bffc-be5f-4019-90ab-b210eb2b856a', 1, '2025-06-23 07:31:05.823241'),
	('12e76177-5480-43ca-b5a3-b741a26d0822', 'https://salt.tikicdn.com/cache/280x280/ts/product/73/47/c3/dfb1cb32b12aa0fb986351e2489243ec.jpg', 0, '2560c61b-617c-42d9-a574-2854f76c6d0c', 1, '2025-06-23 07:31:05.823241'),
	('13af5d0d-7bd0-401c-9f4e-9119f213350f', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'c2a59b54-1867-4488-a024-6d15ccf871ea', 1, '2025-06-23 07:27:39.142798'),
	('140e4d7b-5381-42b1-ae64-256bc0a67c17', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '03e29503-e3fc-4668-8785-865ad7953063', 1, '2025-06-23 07:31:05.823241'),
	('163ea1fb-88a9-48b9-9c14-2f77764b685e', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'ea415cb9-278d-4e6c-8230-d4aaf853e9ce', 1, '2025-06-23 07:30:14.522816'),
	('168b99e2-fe04-4494-950f-5a2cb04bf47b', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'fba576e6-ff5c-4cd8-aed2-41c23441c881', 1, '2025-06-23 07:30:14.522816'),
	('1845cfdb-7c41-43d2-b4ae-44c65e453488', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '2db82dd0-0add-46d2-a6eb-7ff0eb0a4bd8', 1, '2025-06-23 07:30:14.522816'),
	('192ae797-9974-4e1f-a28c-81271d2839f5', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '1e27edba-aa71-42c7-9144-03a11113bf75', 1, '2025-06-23 07:31:05.823241'),
	('1a4d7717-e5c5-401e-9d5b-29dd8af7e02c', 'https://salt.tikicdn.com/cache/280x280/ts/product/bf/dd/22/284e610413880856072c87f104ca9ac9.png', 0, 'b034ad6a-7204-4979-b46a-f90421b1f204', 1, '2025-06-23 07:30:14.522816'),
	('1ab5e8cf-d62e-41cf-a3bf-9ec1ceef0c8e', 'https://salt.tikicdn.com/cache/280x280/ts/product/3b/13/80/1dd506fd020c47c6aba7750e6594277b.jpg', 0, '3f2ea67c-c681-4cac-98ad-f45ed6ca99de', 1, '2025-06-23 07:31:05.823241'),
	('1b71eadd-4c9d-47fb-9fb7-7ed95b7ce8b0', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, 'ceba43ba-336c-4fb0-80b2-6a6d16b37df7', 1, '2025-06-23 07:27:39.142798'),
	('1b7875d2-efcb-4d3e-addd-710267d8c8d9', 'https://salt.tikicdn.com/ts/upload/b2/8d/56/3086efc2194320a6b83fba7530de7c78.png', 0, 'a6fe2da1-b80a-4519-9687-e185628596b8', 1, '2025-06-23 07:30:14.522816'),
	('1b9a4e22-933b-4cd0-9b00-802f2dab6f89', 'https://salt.tikicdn.com/cache/280x280/ts/product/1f/1d/a3/3ae5f3b159bdee326a4914c28948cffb.jpg', 0, '2af45fe5-f2bd-4dc7-9821-9c6fbd12b880', 1, '2025-06-23 07:30:14.522816'),
	('1bdd4dfa-516f-447f-b4a1-39d9744848e4', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, 'dc93837f-4c61-486f-8992-b06f8b80333d', 1, '2025-06-23 07:31:05.823241'),
	('1c71fee9-87ee-40a7-85b1-6003def82c19', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '00cca015-61b8-499b-9578-a6d420c1a38f', 1, '2025-06-23 07:31:05.823241'),
	('1d6d619b-2102-4a6a-82cc-b087e2c4c456', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '7ab61c33-2096-4744-94de-b4b6945fa415', 1, '2025-06-23 07:27:39.142798'),
	('1d8f66c8-ba2f-4d9f-b341-eb3b09abc3d5', 'https://salt.tikicdn.com/cache/280x280/ts/product/d2/cf/9d/b6b0d22df6204b5b257e247c5bdeba9c.jpg', 0, '5803b031-d408-42c5-8be6-a4b147cf9d71', 1, '2025-06-23 07:27:39.142798'),
	('1e0b14a2-3866-4c53-ade1-956f818c7d97', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '544b4ec8-6a6a-46b3-96dd-eb326e349441', 1, '2025-06-23 07:30:14.522816'),
	('20f4a102-bef2-4a7f-ada4-6165bd49b5cf', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '1540f571-76bb-4b98-8fde-85f9adceabed', 1, '2025-06-23 07:31:05.823241'),
	('21703599-e5e8-4201-bf7c-da1c9eeabe33', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '69d62c84-4df3-4152-909c-d6504bcc194c', 1, '2025-06-23 07:30:14.522816'),
	('233e2cb6-06ae-430d-a875-5d5c0cb18a6e', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '62737b31-484a-4814-8b20-d3f93352d318', 1, '2025-06-23 07:27:39.142798'),
	('2395ab6b-f846-40e6-8926-3e9379267cd7', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, 'c3e623f5-9d3a-4068-81e9-f27760e83019', 1, '2025-06-23 07:31:05.823241'),
	('243e9765-8a9b-49e3-a9ca-c7bf74be3e41', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '26090345-979d-4370-abd1-d6428f9acc90', 1, '2025-06-23 07:30:14.522816'),
	('26c8d61f-c2c8-4e2b-9dc1-e78cd877d157', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'efb68274-8f04-4442-9204-4fa24fe94c19', 1, '2025-06-23 07:30:14.522816'),
	('26fdff99-ef1c-4b3c-b7cb-6a62d9bb6518', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'c8b86bd6-9fd5-4bcf-92b4-01b366552e34', 1, '2025-06-23 07:27:39.142798'),
	('2766d3c7-4336-4594-86e4-6833d203f591', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '8b40aa10-92e3-4455-9d7e-5b9eeb696757', 1, '2025-06-23 07:31:05.823241'),
	('27dc1eab-3fdb-4a87-97e5-de2baf00fd59', 'https://salt.tikicdn.com/cache/280x280/ts/product/ac/18/3b/9ad5ceecbd71d28334081c10f8e44b11.jpg', 0, '7cbe5819-55de-4eb4-abd2-cc4fd55fb6c4', 1, '2025-06-23 07:31:05.823241'),
	('28a8c96b-fad7-43c6-877a-e313dcdd4a36', 'https://salt.tikicdn.com/cache/280x280/ts/product/95/63/8e/ab5554c764b39ef27c674a2ba052a995.png', 0, '230b1886-4782-4a0e-afed-f409903db8fe', 1, '2025-06-23 07:31:05.823241'),
	('28f9c4f0-d4d2-4705-aec6-4450b1de83c0', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '8de5a99a-ea25-486d-ab3a-919a43c922cf', 1, '2025-06-23 07:31:05.823241'),
	('29bec9f0-ecc9-4af8-a884-dbcabc573252', 'https://salt.tikicdn.com/cache/280x280/ts/product/f4/df/77/072d8afa0b191aa43bb9ade72c5cd02e.jpg', 0, 'f7aa6884-3054-4f6d-8acc-ffa69f2bffbc', 1, '2025-06-23 07:27:39.142798'),
	('2aaf2908-217b-4b55-bf9f-cf06fba9c484', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '53e30166-298e-489e-bb33-04d4962b1b30', 1, '2025-06-23 07:31:05.823241'),
	('2acc1eb1-ff9c-433b-bf87-56a5c9d73741', 'https://salt.tikicdn.com/cache/280x280/ts/product/01/c9/b9/4c92a02dbf8def20c13076cbf2d1c28f.jpg', 0, 'f7089ff1-e5c7-477d-a29d-99f8eea72094', 1, '2025-06-23 07:31:05.823241'),
	('2cc4c24d-3871-411a-8372-3cdd6f713ecc', 'https://salt.tikicdn.com/cache/280x280/ts/product/b0/43/c9/9e8e14489f695b16a31ec61e2d6f3715.jpg', 0, 'bcd97319-b8f3-4b77-aa7a-b52c228e5d34', 1, '2025-06-23 07:31:05.823241'),
	('2cef4314-edb5-4426-8971-86cf943ce0f4', 'https://salt.tikicdn.com/cache/280x280/ts/product/72/60/75/31659fb7fb81e7bc81c4c5ca71f5e98f.jpg', 0, '3cd924b8-08f5-49ab-bc65-3b58a48105f4', 1, '2025-06-23 07:30:14.522816'),
	('2d59bfbb-4b92-4f45-ad66-bc87ef911cfe', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'a38a56f5-7df5-4555-9b82-0041db47099f', 1, '2025-06-23 07:30:14.522816'),
	('2d5c05c6-e3d9-460a-bd4c-5acbbb66d101', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, 'f835536b-a7cf-4d0d-8761-0159c92ad674', 1, '2025-06-23 07:27:39.142798'),
	('2e72bb8d-a93c-4e59-8d28-13d68c92efc2', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, 'f8ac4ee4-f035-4d21-9961-23eeaeeb3fc2', 1, '2025-06-23 07:31:05.823241'),
	('2f06faec-8e9f-44f6-bb20-812de8619c9a', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'd7b3ff30-369a-4fc0-b64b-c06c93731726', 1, '2025-06-23 07:27:39.142798'),
	('2f231064-bc19-4117-af74-a4ca0f1f8596', 'https://salt.tikicdn.com/cache/280x280/ts/product/87/57/32/9ac7e0531a5a62ac6acdba820a570483.PNG', 0, '11324698-d1e3-4c03-8768-d57375cd3222', 1, '2025-06-23 07:30:14.522816'),
	('2ffbf0c8-cbce-4b22-a6c9-6972ce1884ca', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '735c4a3b-4f92-47b5-b2ed-4d62aa8a6ba4', 1, '2025-06-23 07:27:39.142798'),
	('3027f1fa-a94e-4542-84d4-1a53f100a55a', 'https://salt.tikicdn.com/cache/280x280/ts/product/71/41/c0/8166e521dc6432e2e32df2921b1c7e8c.jpg', 0, '26090345-979d-4370-abd1-d6428f9acc90', 1, '2025-06-23 07:30:14.522816'),
	('3231d3f8-878f-4586-b370-c27c5210d56c', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '323a1fa7-6518-4993-bf0e-ed57e80516fc', 1, '2025-06-23 07:27:39.142798'),
	('3361ae94-82e8-4055-8ea2-bf112753c31d', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '87cca7c5-869a-4198-b29e-1d0fc4886511', 1, '2025-06-23 07:30:14.522816'),
	('337a2dae-7d5e-4a85-91ac-34fd37dbd081', 'https://salt.tikicdn.com/cache/280x280/ts/product/a4/ca/44/a1b9e7ccfdbd3ca60fc9c2d104d532b0.jpg', 0, 'adf5f73d-d537-4f75-b272-1ef4b2f5e8f6', 1, '2025-06-23 07:27:39.142798'),
	('337f1586-42f2-4f89-9169-80e7ca07e1e1', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '62737b31-484a-4814-8b20-d3f93352d318', 1, '2025-06-23 07:27:39.142798'),
	('34c7de5f-b98f-469f-9d9a-7355c6c4430f', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '4c333f43-c668-4a56-9556-c28a864ab420', 1, '2025-06-23 07:27:39.142798'),
	('37c6f30d-6097-43fb-bc57-6457bca6f5b7', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'e4502134-4d12-4f12-aec6-7b79be2487d4', 1, '2025-06-23 07:30:14.522816'),
	('39a2bcd2-2e7b-40c6-ab86-29aa9a3004f5', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'bce4a365-01fe-4134-8528-2acad3416908', 1, '2025-06-23 07:27:39.142798'),
	('39ef35b5-ee1d-4597-aa38-83ff9e484870', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '7703b4bd-0300-4d4a-910d-62f0e242766a', 1, '2025-06-23 07:31:05.823241'),
	('3a45f8fe-e25d-400a-86da-7b17fa06acaa', 'https://salt.tikicdn.com/cache/280x280/ts/product/da/91/45/ba5dc126469e6c4fbefcb1f0da3fdf9b.jpg', 0, 'c3e623f5-9d3a-4068-81e9-f27760e83019', 1, '2025-06-23 07:31:05.823241'),
	('3b4b3481-a2bc-42e1-b820-c4f23b961c10', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '49f7f4e8-2b16-4f2c-b52e-febd445e6f86', 1, '2025-06-23 07:27:39.142798'),
	('3ca511ee-ad26-41ef-8043-ad840b555c70', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'b98342c2-987f-42fc-aad7-84871cc741ef', 1, '2025-06-23 07:30:14.522816'),
	('3cca94a0-3dfa-451b-9704-1bec7d938084', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '70fc4268-7e3b-4fc0-8c1a-bc3116ae0389', 1, '2025-06-23 07:30:14.522816'),
	('3d14ec7f-47ce-4eba-9fc8-0142e2779b6a', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'f9ba4dec-a646-48b1-972b-f442d7d846bb', 1, '2025-06-23 07:31:05.823241'),
	('3d661346-07b1-42a6-9843-609e75cde682', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'e48357c9-68e7-4998-8722-e1c76dfedff1', 1, '2025-06-23 07:27:39.142798'),
	('3db4e855-8859-4427-bf96-a53a91187cc5', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '5c87dea8-564b-43d4-a550-383306b75c2d', 1, '2025-06-23 07:30:14.522816'),
	('3e862963-3f8c-46a4-b0d6-967c1942139d', 'https://salt.tikicdn.com/cache/280x280/ts/product/c2/a8/21/6cce3566689d0875180cb3441d6e9ab1.png', 0, '59c84865-10c3-49b9-906d-a4f806104191', 1, '2025-06-23 07:30:14.522816'),
	('41389a53-deac-458e-a885-7614991bf749', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'c0243a04-926e-4045-972c-3624942c3c03', 1, '2025-06-23 07:30:14.522816'),
	('4239650c-2f49-49ac-9586-6e2616218c22', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'c4451ce7-079a-4592-b95e-7e0d1686fb25', 1, '2025-06-23 07:31:05.823241'),
	('42cb4975-8665-429a-b4c4-cde5e1d89525', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'f7aa6884-3054-4f6d-8acc-ffa69f2bffbc', 1, '2025-06-23 07:27:39.142798'),
	('4327729b-ffa6-4c5f-a6dc-79c0546cf2a5', 'https://salt.tikicdn.com/cache/280x280/ts/product/5a/a7/de/327018d1e5b2841f044cfb97fba29f33.jpg', 0, '7f946539-a0ac-47ac-a582-1a2e4d1ef127', 1, '2025-06-23 07:30:14.522816'),
	('4376fc4f-7040-4b8b-a95e-f6845708abf5', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '718958ba-e0f0-49f1-bb8c-052daba5ecf3', 1, '2025-06-23 07:27:39.142798'),
	('43ef1011-0c1d-4378-8d52-acd62748a382', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '171bdf7d-73b4-4264-8d83-6c7f996c3744', 1, '2025-06-23 07:27:39.142798'),
	('43f31006-0d6d-4d6d-a8d1-2560bf1c9afd', 'https://salt.tikicdn.com/cache/280x280/ts/product/1e/48/0d/fb54178ddafff4b0436a185151110c9d.jpg', 0, '2777412a-891c-4dfe-ae36-cc7f540fd507', 1, '2025-06-23 07:31:05.823241'),
	('451f19fc-68c5-4c18-972d-e2b79e4601ae', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, 'e4db6187-39ef-493b-aaeb-49b703c61ca9', 1, '2025-06-23 07:30:14.522816'),
	('45ac3386-50dc-48d7-8d3b-e0a0e6d3aafc', 'https://salt.tikicdn.com/cache/280x280/ts/product/a1/fe/2c/59210bc2b4f1c8620b204d50f4951f8f.jpg', 0, 'b6c4a557-c3ce-46db-9210-556db933a02e', 1, '2025-06-23 07:27:39.142798'),
	('46a817c6-07c5-478f-91b1-07a8230ab404', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '59c84865-10c3-49b9-906d-a4f806104191', 1, '2025-06-23 07:30:14.522816'),
	('46d6d7f4-ba32-454f-bfaa-e119403bbbb5', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '31a914d9-93ef-4615-95a5-e834fa5c0e96', 1, '2025-06-23 07:31:05.823241'),
	('484e746f-30d3-44ed-871c-14c69914cdcc', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '104ef33f-da83-471f-b929-76f35924da6a', 1, '2025-06-23 07:31:05.823241'),
	('4cadc03e-f5e8-41df-8a54-e766a3e65c91', 'https://salt.tikicdn.com/cache/280x280/ts/product/a0/9b/b0/e39a9c2bc993ffcf0b245c9540065b3f.jpg', 0, '797e5845-02c8-4ab6-83ee-d28870fa8faa', 1, '2025-06-23 07:31:05.823241'),
	('4d2ebc8a-cf0a-4e83-a0de-57cf14811aa0', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, 'bf16f4e6-f208-487d-bb96-be711632cc04', 1, '2025-06-23 07:31:05.823241'),
	('4d568358-b2dd-4aab-9b6c-57b024dbbea1', 'https://salt.tikicdn.com/cache/280x280/ts/product/23/b8/f6/c563aa12b559a951a9e22c69ec85b11d.jpg', 0, 'e4bb1712-784d-4f0a-a419-d0f33d3b9c80', 1, '2025-06-23 07:31:05.823241'),
	('4e14f7af-29a1-459d-aecb-8cfaa0037b78', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'ceba43ba-336c-4fb0-80b2-6a6d16b37df7', 1, '2025-06-23 07:27:39.142798'),
	('4f50d4ea-4c47-42b4-b447-7f6d432446a7', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '6334c45d-aa29-44e2-b97a-29216accad0a', 1, '2025-06-23 07:30:14.522816'),
	('4f5f3430-5b61-468b-b327-af256bb1a575', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '718958ba-e0f0-49f1-bb8c-052daba5ecf3', 1, '2025-06-23 07:27:39.142798'),
	('500e50c2-115b-4c9d-b83b-8822111104dd', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '12292913-9ea7-45d3-a962-8ba53b99d201', 1, '2025-06-23 07:30:14.522816'),
	('501858d3-05c5-4571-a6f2-26f81d0f15eb', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'a6fe2da1-b80a-4519-9687-e185628596b8', 1, '2025-06-23 07:30:14.522816'),
	('50bb0266-7e6b-4b6c-87a6-ba90203df3ae', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '70a9d91e-6d39-4618-a60e-2c9ca695a7b9', 1, '2025-06-23 07:27:39.142798'),
	('51ca4bc9-a5c5-41a2-bd6d-38fafd29d98a', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'f9ba4dec-a646-48b1-972b-f442d7d846bb', 1, '2025-06-23 07:31:05.823241'),
	('5336a63b-fab3-4873-8066-632b118ab442', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'd2e0376f-30ac-4a90-8bd8-ee41c615d6c6', 1, '2025-06-23 07:27:39.142798'),
	('53cbca61-95b0-4260-8f8c-b64dfc6d9e5d', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '715e37b3-980e-455b-8d37-cb4ff65ff1e5', 1, '2025-06-23 07:27:39.142798'),
	('53d0a02c-38bc-48e8-83be-1acb725ebae5', 'https://salt.tikicdn.com/cache/280x280/ts/product/0e/82/0e/33860ec35c91fcc0cfd35c9034d88594.jpg', 0, '2872cf02-c1e3-483d-88f9-a03404334f63', 1, '2025-06-23 07:27:39.142798'),
	('53fa675d-c075-49dc-ba13-b49443d106f1', 'https://salt.tikicdn.com/cache/280x280/ts/product/c2/24/b9/7c88b530d951f47a6e784f77e370d8ea.jpg', 0, '25d08f89-cde5-4de6-a61f-ae04a27f1917', 1, '2025-06-23 07:27:39.142798'),
	('54dee960-b90d-49c2-8f2b-eda1f0d2101f', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '861d7ee2-ac9d-4127-beb4-165c848b21d2', 1, '2025-06-23 07:27:39.142798'),
	('564d9c07-445c-441b-8365-aff7762eff30', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'ee66400d-1c55-4b27-bded-79698d83d031', 1, '2025-06-23 07:30:14.522816'),
	('589bd816-791a-4870-9ac0-1f8b7783a7ac', 'https://salt.tikicdn.com/cache/280x280/ts/product/a3/17/af/224f864dfb2883a93d21f172b2a1e9f6.jpg', 0, '2856220d-9214-4030-bdcc-5c2108c276bc', 1, '2025-06-23 07:27:39.142798'),
	('5980d0d8-ded4-41d5-90d4-1e1abf59cbab', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '3a70bf18-ff46-4bb9-a8e2-5ffd4df9217d', 1, '2025-06-23 07:30:14.522816'),
	('59aa0f55-08b7-4b82-b702-8272060480fa', 'https://salt.tikicdn.com/cache/280x280/ts/product/55/69/11/cc3e4b68121ec6838279d5cc69686cc6.jpg', 0, '00154985-2c5d-4282-92c9-04f3d36c08df', 1, '2025-06-23 07:27:39.142798'),
	('59b92f34-a75c-48c2-b4f0-9f2d282a82a5', 'https://salt.tikicdn.com/cache/280x280/ts/product/1a/89/a8/9d418feb34b20596a1e8ead9a79f7aee.png', 0, '87cca7c5-869a-4198-b29e-1d0fc4886511', 1, '2025-06-23 07:30:14.522816'),
	('59d904d1-367b-4cf6-892e-920084066f3a', 'https://salt.tikicdn.com/cache/280x280/ts/product/3f/33/17/60643fbddf7e415f496342ae1305e714.png', 0, 'e4502134-4d12-4f12-aec6-7b79be2487d4', 1, '2025-06-23 07:30:14.522816'),
	('5a37b4b0-fa5a-4c01-b199-8542f86ea133', 'https://salt.tikicdn.com/cache/280x280/ts/product/67/58/8d/9478e4361c75246eab4b331866f92518.jpg', 0, '1e27edba-aa71-42c7-9144-03a11113bf75', 1, '2025-06-23 07:31:05.823241'),
	('5ac79750-5594-4d73-ae6b-85575913b75a', 'https://salt.tikicdn.com/cache/280x280/ts/product/70/65/56/7f2062fd96153c4fd2f14938fcccc01a.jpg', 0, '26ff330b-102b-4a94-b756-094537d2e3cd', 1, '2025-06-23 07:31:05.823241'),
	('5c4dfecc-e373-4566-9be8-f22133feb258', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '8b40aa10-92e3-4455-9d7e-5b9eeb696757', 1, '2025-06-23 07:31:05.823241'),
	('5c603fc2-15a6-48a1-a1e0-5313f22a4b52', 'https://salt.tikicdn.com/cache/280x280/ts/product/3a/1f/30/7030fbbf63f166fee1515449c0385345.jpg', 0, '416308cf-5ec8-46c8-914d-92fe8adbf66f', 1, '2025-06-23 07:27:39.142798'),
	('5ca1a7ff-07ff-4d79-84f2-184e6d71ad74', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, '906c0fbe-04bb-4a17-a5e0-f972585f40c7', 1, '2025-06-23 07:30:14.522816'),
	('5cc2c195-effa-43fc-b97e-d1bb673323ec', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '6966862e-64ad-474b-93f7-cc339f8bf0d7', 1, '2025-06-23 07:27:39.142798'),
	('5cf6b622-9c77-4669-b302-138f6efe1232', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '6b6c5b8c-f2b9-4395-a157-a29b39673d10', 1, '2025-06-23 07:27:39.142798'),
	('5dea4f16-001f-4944-b63c-7752af39ac21', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '0fc15dfb-12ff-4fe6-acf2-f039477139de', 1, '2025-06-23 07:27:39.142798'),
	('5e4e97a9-4737-4055-8d14-cd17d0cb7dc4', 'https://salt.tikicdn.com/cache/280x280/ts/product/18/f5/1c/ae4198506c9382d33772167fda670c58.png', 0, '445e8397-4451-4c61-8a59-e8b3397e2733', 1, '2025-06-23 07:31:05.823241'),
	('5ee18270-439f-4e05-b8e9-542bef373072', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '37a06604-b839-4caa-8c30-0df41db3a40b', 1, '2025-06-23 07:27:39.142798'),
	('5f14172d-e285-4d4e-a7f3-ed7563551561', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'b6c4a557-c3ce-46db-9210-556db933a02e', 1, '2025-06-23 07:27:39.142798'),
	('5ff04880-fb62-4624-a3ac-d4556197c753', 'https://salt.tikicdn.com/cache/280x280/ts/product/4b/e3/80/fa487b8f2875e548a9ed2a61b6859935.PNG', 0, 'fa79a052-d65c-4289-998c-d0a226e59e12', 1, '2025-06-23 07:30:14.522816'),
	('5ff6c5b6-d593-4ea9-9208-af57997c10ea', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '2caa4a2e-4524-4479-8a7b-1fb3aafa8bae', 1, '2025-06-23 07:31:05.823241'),
	('605c997d-9cd2-47ff-836c-565990b474d8', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, 'c4451ce7-079a-4592-b95e-7e0d1686fb25', 1, '2025-06-23 07:31:05.823241'),
	('60773c80-7557-4ba0-b328-906e5046dbfb', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, '0a2f8c95-b91b-464d-84dc-1546f78ea519', 1, '2025-06-23 07:31:05.823241'),
	('612512b0-f8fa-46f6-a4ad-96a109f8963d', 'https://salt.tikicdn.com/cache/280x280/ts/product/39/ca/ae/f9c982a5cba1b03d45c9ba7d684e512b.jpg', 0, '9ad26d8b-718d-427d-afd8-1a0353ea8136', 1, '2025-06-23 07:27:39.142798'),
	('618c4015-25f9-4641-a407-5c076c770bbe', 'https://salt.tikicdn.com/cache/280x280/ts/product/d0/7d/f4/1023919afca17656f50e1caeee1c4743.jpg', 0, 'f2eccd24-2bd3-48cf-81df-5a5e957022d0', 1, '2025-06-23 07:30:14.522816'),
	('62921896-9320-4d47-a1b7-afe58ce399f8', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '445e8397-4451-4c61-8a59-e8b3397e2733', 1, '2025-06-23 07:31:05.823241'),
	('62afed23-f2e1-4fb9-8a80-fdb41b397324', 'https://salt.tikicdn.com/cache/280x280/ts/product/75/50/0d/bfd3b600b913d3041bad2fda2fef0440.jpg', 0, '9505a216-2831-4946-86cc-c85eed61833e', 1, '2025-06-23 07:30:14.522816'),
	('62d48782-07b1-4529-8fde-2bd0570c1f8f', 'https://salt.tikicdn.com/cache/280x280/ts/product/97/f8/4a/d607b64ca645df73cd066c2181ab4a54.jpg', 0, '82122f3c-1cfa-453f-813c-e228bf869f68', 1, '2025-06-23 07:31:05.823241'),
	('63859ec1-f075-43f9-ab83-6eb741c17a54', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '2245bffc-be5f-4019-90ab-b210eb2b856a', 1, '2025-06-23 07:31:05.823241'),
	('6426bbec-0dcc-411c-950d-6dba8b099861', 'https://salt.tikicdn.com/cache/280x280/ts/product/89/38/0c/2d2425d56d203c8cde33b7c1bba8ed75.jpg', 0, '3467da1d-53fb-4515-91b4-10ecfb29d70c', 1, '2025-06-23 07:27:39.142798'),
	('64c13c5f-3fbb-416b-b57c-fb32ec45f6fd', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '5b9a8c04-62b7-43ed-8139-aa512605f988', 1, '2025-06-23 07:27:39.142798'),
	('6665717c-5dc3-4889-88ed-293a34de365d', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, '171bdf7d-73b4-4264-8d83-6c7f996c3744', 1, '2025-06-23 07:27:39.142798'),
	('67e1f1b6-5956-45cc-99cb-0dfacd89c85b', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'b80404a8-e96a-40ba-9a3b-d1e0f03ca54f', 1, '2025-06-23 07:31:05.823241'),
	('68dd7b88-9cde-4a8b-92cc-798e8289ecbe', 'https://salt.tikicdn.com/cache/280x280/ts/product/cc/02/96/d8935035a406df7a0c06453f2c103441.jpg', 0, '78405f2a-c966-4549-b24d-fb63dc141874', 1, '2025-06-23 07:27:39.142798'),
	('69c0083c-7135-45e3-b604-aad849a61a46', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '735c4a3b-4f92-47b5-b2ed-4d62aa8a6ba4', 1, '2025-06-23 07:27:39.142798'),
	('6a2140d2-d06d-4dd6-921a-b4b35078b6b7', 'https://salt.tikicdn.com/cache/280x280/ts/product/a0/f4/e3/8d5156f9b8c0c605e78b9b3bf24c9209.jpg', 0, 'ea415cb9-278d-4e6c-8230-d4aaf853e9ce', 1, '2025-06-23 07:30:14.522816'),
	('6ba5e34e-3e52-4977-8363-0ddc9d4b0e3b', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '11324698-d1e3-4c03-8768-d57375cd3222', 1, '2025-06-23 07:30:14.522816'),
	('6f3a621f-4e54-460d-a689-ce252dac88cd', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '4a322a52-e1ea-403e-85cb-bc0b881d2eeb', 1, '2025-06-23 07:27:39.142798'),
	('6fc56222-6ace-47df-ae19-1510f99c7105', 'https://salt.tikicdn.com/cache/280x280/ts/product/7b/c7/d3/76fefb827690701045ce6e2af9c1650d.jpg', 0, 'e6422863-1187-45e0-8ed6-df7fa7d8e3e7', 1, '2025-06-23 07:31:05.823241'),
	('7069ea96-bbdf-450f-b135-91390e84adb7', 'https://salt.tikicdn.com/cache/280x280/ts/product/4c/f4/9f/49857ab02d9353ddd2332e8a07a00bdf.jpg', 0, 'bc6e258e-a74c-463a-bad1-636e7dbf3f35', 1, '2025-06-23 07:30:14.522816'),
	('70aa6c1f-1e35-4a44-900f-fa6528fd7850', 'https://salt.tikicdn.com/cache/280x280/ts/product/68/a4/28/c0d46b9578a8bcb9f92a0247fe271298.jpg', 0, '51d96b86-a7b0-415d-942b-9baea254edea', 1, '2025-06-23 07:30:14.522816'),
	('7126f200-2599-42d4-acb2-7d2d7d3877a8', 'https://salt.tikicdn.com/cache/280x280/ts/product/23/b8/f6/c563aa12b559a951a9e22c69ec85b11d.jpg', 0, '244d55fa-51ee-4e11-b479-ae1bec58c7d6', 1, '2025-06-23 07:30:14.522816'),
	('7201ef2c-ec58-4fea-8560-375c835e32e2', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, '1540f571-76bb-4b98-8fde-85f9adceabed', 1, '2025-06-23 07:31:05.823241'),
	('733ed55a-696c-4b49-b6e1-ffdfe7267839', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '78521e04-b4d6-4d17-a928-015863d6e4ce', 1, '2025-06-23 07:27:39.142798'),
	('73b80cff-c6f3-4f02-bb74-0573ee0f990f', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, 'bc6e258e-a74c-463a-bad1-636e7dbf3f35', 1, '2025-06-23 07:30:14.522816'),
	('746f365b-9e2b-4384-87de-89dc1b5e1965', 'https://salt.tikicdn.com/cache/280x280/ts/product/6d/b0/d2/a3c14c137a2fe69741b91d235faf6d57.png', 0, 'f72c9a94-9e1f-4fa4-b8b9-1a1771305cf5', 1, '2025-06-23 07:30:14.522816'),
	('75879023-ae20-4714-8832-f16c47ef2492', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'f835536b-a7cf-4d0d-8761-0159c92ad674', 1, '2025-06-23 07:27:39.142798'),
	('7771c456-ddca-4294-b44d-3268b874f83c', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'dd311eb3-7310-462a-a70d-18296da6507b', 1, '2025-06-23 07:30:14.522816'),
	('79dfe8e0-21a8-4ce8-b8a6-3f0f0c6ceed2', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '2db82dd0-0add-46d2-a6eb-7ff0eb0a4bd8', 1, '2025-06-23 07:30:14.522816'),
	('7a4de38e-53be-4eb1-afb6-2a2935fdfbd7', 'https://salt.tikicdn.com/cache/280x280/ts/product/8a/21/c0/02c9aeb6632cb7bf32f6c3ff49e5f5b1.jpg', 0, 'bf16f4e6-f208-487d-bb96-be711632cc04', 1, '2025-06-23 07:31:05.823241'),
	('7c1e7c55-09a8-4346-a4a6-05a1fc37e2ed', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '544b4ec8-6a6a-46b3-96dd-eb326e349441', 1, '2025-06-23 07:30:14.522816'),
	('7c62bd0f-af37-49b5-8e5c-a1d1a1dca312', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '9ad26d8b-718d-427d-afd8-1a0353ea8136', 1, '2025-06-23 07:27:39.142798'),
	('7cc4d255-3c96-417f-ac65-5e13d7b3cf00', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '0fc15dfb-12ff-4fe6-acf2-f039477139de', 1, '2025-06-23 07:27:39.142798'),
	('7cdc41c5-bb90-45a0-8d62-932a8a15e1d0', 'https://salt.tikicdn.com/cache/280x280/ts/product/c2/a8/21/2c18af7b59670ebc16d9a8d9cf842467.png', 0, '5f383df8-ce45-4cdc-af42-89fd49cc2ad8', 1, '2025-06-23 07:30:14.522816'),
	('7f5959f6-3bdd-47a6-b791-7c20fe6ca99d', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, 'bcd97319-b8f3-4b77-aa7a-b52c228e5d34', 1, '2025-06-23 07:31:05.823241'),
	('7fb06286-e4a7-4c70-8164-491dc630398c', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '9eb4f39e-a629-4eac-9d22-fb26ae336dae', 1, '2025-06-23 07:27:39.142798'),
	('811a88e2-fdca-43b7-9d88-3aa57a3c07f2', 'https://salt.tikicdn.com/cache/280x280/ts/product/6f/dc/9a/c4de0d21557a49f4c229c029736ddecc.jpg', 0, '6d812f5c-51dd-4298-bc80-80aa1f96cbcd', 1, '2025-06-23 07:31:05.823241'),
	('81afb1c8-3474-4b05-a048-f1d021adb3dd', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '877deb7b-3170-40ce-9bc4-53a1797a972e', 1, '2025-06-23 07:27:39.142798'),
	('82e95813-ce19-45d6-8a45-6336db0f6c59', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '194d9b30-ea3a-40df-ae31-674d1253e86c', 1, '2025-06-23 07:27:39.142798'),
	('83d1b50a-3946-4342-a22f-971341615cc0', 'https://salt.tikicdn.com/cache/280x280/ts/product/39/b0/b7/fcce86987b6cc0cfb46f8aefd26e4e8a.jpg', 0, 'f8ac4ee4-f035-4d21-9961-23eeaeeb3fc2', 1, '2025-06-23 07:31:05.823241'),
	('83d34d5e-169e-472e-bcfd-36cde1a21c26', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '00154985-2c5d-4282-92c9-04f3d36c08df', 1, '2025-06-23 07:27:39.142798'),
	('8473bb86-c9df-4cd8-9fa3-44f2ff11f449', 'https://salt.tikicdn.com/cache/280x280/ts/product/f1/4e/39/52495d039404e06be0e92539ea9acd39.jpg', 0, 'b00027db-4e10-4783-bde1-e3cd25472b49', 1, '2025-06-23 07:31:05.823241'),
	('848caf99-52f9-43f7-a2a3-216a13df32b2', 'https://salt.tikicdn.com/cache/280x280/ts/product/1e/48/0d/fb54178ddafff4b0436a185151110c9d.jpg', 0, '906c0fbe-04bb-4a17-a5e0-f972585f40c7', 1, '2025-06-23 07:30:14.522816'),
	('85612c54-8143-47d4-b780-158b5cfdc7e3', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '230b1886-4782-4a0e-afed-f409903db8fe', 1, '2025-06-23 07:31:05.823241'),
	('894cbea3-0891-4d8a-af65-8d8dd4f017d5', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '52c3f778-43e4-45d2-ab9f-e8593434716a', 1, '2025-06-23 07:31:05.823241'),
	('8a0d56c1-fdc4-44f6-b043-10e1a57a454c', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '6d812f5c-51dd-4298-bc80-80aa1f96cbcd', 1, '2025-06-23 07:31:05.823241'),
	('8a204f71-e971-436a-804d-37f874eb762e', 'https://salt.tikicdn.com/cache/280x280/ts/product/d9/56/1f/7287439353c630106e49a968fef991f3.jpg', 0, 'f173ac2d-9d67-412e-bc57-4a32e07c9b46', 1, '2025-06-23 07:31:05.823241'),
	('8acfd527-862c-468a-b3ca-d601084e68a6', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '5fc75b96-1489-4bdf-90f4-79b6858cf50c', 1, '2025-06-23 07:30:14.522816'),
	('8b5639fa-a869-420a-95e7-65aceb132f57', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'b502dfba-049d-45ee-98e3-fbc00180e313', 1, '2025-06-23 07:27:39.142798'),
	('8d173e17-2629-4d54-9903-49878b5321b4', 'https://salt.tikicdn.com/cache/280x280/ts/product/62/87/37/f0c2a142a752f3b3203cf49b0d916d6b.jpg', 0, '45ce855b-6ebc-43b9-8fd8-fbd4d050dbac', 1, '2025-06-23 07:27:39.142798'),
	('8d9fe186-4423-47e6-b751-8c394ad2a5d2', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '7703b4bd-0300-4d4a-910d-62f0e242766a', 1, '2025-06-23 07:31:05.823241'),
	('8ded9848-bde0-4514-b9f5-b9dc6952245d', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'efb68274-8f04-4442-9204-4fa24fe94c19', 1, '2025-06-23 07:30:14.522816'),
	('8e3d56c4-90cc-49f4-85d4-10d59452b2f8', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '7ab61c33-2096-4744-94de-b4b6945fa415', 1, '2025-06-23 07:27:39.142798'),
	('90388047-2119-422e-a60c-96cb26b733ab', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'c2bdb87b-5f32-4370-977e-f45882cc8c07', 1, '2025-06-23 07:31:05.823241'),
	('9099daee-baa9-4d24-8b44-d87ba0de1cd8', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '3cd924b8-08f5-49ab-bc65-3b58a48105f4', 1, '2025-06-23 07:30:14.522816'),
	('92a6c57d-e87e-4285-adbc-3a4772435fcc', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '33c892e4-2c9b-4896-9578-0e38e5a429c4', 1, '2025-06-23 07:30:14.522816'),
	('94296ec1-321c-4ebd-ab1f-60ca62fc9f46', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '861d7ee2-ac9d-4127-beb4-165c848b21d2', 1, '2025-06-23 07:27:39.142798'),
	('9532f5fc-b03f-4985-a4ec-e58f7a7224b6', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '61db7753-3466-44a5-bbdb-49ba211d5363', 1, '2025-06-23 07:27:39.142798'),
	('95e78662-c3dd-407f-9a90-7823a9729567', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '2856220d-9214-4030-bdcc-5c2108c276bc', 1, '2025-06-23 07:27:39.142798'),
	('96969026-90e9-4b70-b246-2647ab53654b', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '2777412a-891c-4dfe-ae36-cc7f540fd507', 1, '2025-06-23 07:31:05.823241'),
	('97ad5957-497f-4ea8-82b7-d5e2dea697e6', 'https://salt.tikicdn.com/cache/280x280/ts/product/b4/b8/4d/87e4297ca74a0f3b7983dfce8fbbf0a4.jpg', 0, '877deb7b-3170-40ce-9bc4-53a1797a972e', 1, '2025-06-23 07:27:39.142798'),
	('97fe574a-4a4e-4252-9101-0cce26355573', 'https://salt.tikicdn.com/cache/280x280/ts/product/e6/38/19/d83cac9727dffc24d6678bd292149518.jpg', 0, '9f11aa0f-e103-4425-9ae1-ec58e0e3fafa', 1, '2025-06-23 07:31:05.823241'),
	('987b6189-1a6c-416f-a513-071004134e33', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '2caa4a2e-4524-4479-8a7b-1fb3aafa8bae', 1, '2025-06-23 07:31:05.823241'),
	('98c695b3-fcdf-4b55-931c-79d3e6a145de', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '58592752-4a85-4c39-a91f-5f7fa8000b08', 1, '2025-06-23 07:27:39.142798'),
	('98f79bf9-afd9-459d-a9a9-dac1c4f5a91a', 'https://salt.tikicdn.com/cache/280x280/ts/product/8f/6f/af/123dd657a379d128b501a0db9e5beab7.png', 0, '08cf5085-5bc2-4c1b-ab5a-34d169ae5c0c', 1, '2025-06-23 07:27:39.142798'),
	('999841e9-634f-4b53-9761-fecc0ed21916', 'https://salt.tikicdn.com/ts/upload/b2/8d/56/3086efc2194320a6b83fba7530de7c78.png', 0, 'e6422863-1187-45e0-8ed6-df7fa7d8e3e7', 1, '2025-06-23 07:31:05.823241'),
	('99b5137f-94cb-475c-a5b2-c7d35396a7a3', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'ea02db42-b7a3-4aba-b136-b5bc05d5bda5', 1, '2025-06-23 07:30:14.522816'),
	('99d1e328-3044-4945-bd10-ad5a6af7a9ab', 'https://salt.tikicdn.com/cache/280x280/ts/product/94/dd/b8/249ddf96bbd1712d086d50f968ebe2a6.jpg', 0, '8e1c1411-9d3e-440f-88cf-bb655fd54b7b', 1, '2025-06-23 07:31:05.823241'),
	('9ac6e4ec-2830-4d73-b3c9-f1a11621ab8c', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'f72c9a94-9e1f-4fa4-b8b9-1a1771305cf5', 1, '2025-06-23 07:30:14.522816'),
	('9c697c74-c209-45c1-b9de-5fe19f0a020e', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'b425911d-d0c5-446e-a7f1-6b42e5f66d6b', 1, '2025-06-23 07:27:39.142798'),
	('9d425bed-1e99-42fa-8b1f-3950f33565b2', 'https://salt.tikicdn.com/ts/tka/a8/31/b6/802e2c99dcce64c67aa2648edb15dd25.png', 0, 'aeed6277-4902-478e-a899-433bd18a1888', 1, '2025-06-23 07:27:39.142798'),
	('9f1b04b6-b386-4e19-a1fc-89846ec9be93', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '897392e3-1b6f-4d55-b232-3a368fcb57c0', 1, '2025-06-23 07:31:05.823241'),
	('9f85431b-fa3b-4db1-8ae9-79304c7de670', 'https://salt.tikicdn.com/cache/280x280/ts/product/1f/1d/a3/3ae5f3b159bdee326a4914c28948cffb.jpg', 0, 'b425911d-d0c5-446e-a7f1-6b42e5f66d6b', 1, '2025-06-23 07:27:39.142798'),
	('9f943402-c5f6-45af-ad89-55f50c912372', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'cc1b6d28-3b8d-446b-808e-155803ab9c3a', 1, '2025-06-23 07:30:14.522816'),
	('a051a5dd-722b-48f8-9adb-54c1790a914d', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'a67b197a-a891-4984-b413-c79fe496d429', 1, '2025-06-23 07:30:14.522816'),
	('a0fa9c58-2601-456e-8ba9-3393354f2a16', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'e4bb1712-784d-4f0a-a419-d0f33d3b9c80', 1, '2025-06-23 07:31:05.823241'),
	('a20bd016-ae2e-471d-bc97-659b5c6b712d', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'f5868518-6139-4b7b-979f-e84c0d4af414', 1, '2025-06-23 07:27:39.142798'),
	('a29395eb-da60-4d55-b95a-e2976d125904', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'd856c4c9-c899-4e7c-a715-953b9728ad5a', 1, '2025-06-23 07:31:05.823241'),
	('a29cef9f-dbf8-4bbe-9093-0687aaa23050', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '3914bee3-6998-4e53-92cd-e508c5f85d5d', 1, '2025-06-23 07:27:39.142798'),
	('a2f7f9cf-8f52-472e-b159-8abf580200a2', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '5803b031-d408-42c5-8be6-a4b147cf9d71', 1, '2025-06-23 07:27:39.142798'),
	('a3879e3b-cb15-4365-8f35-022b4980e16b', 'https://salt.tikicdn.com/cache/280x280/ts/product/b4/1d/74/1052b763bd08b46b2cebb59706f67449.jpg', 0, '4b35b4f4-3dd9-4856-943c-92e4a0b25f1b', 1, '2025-06-23 07:27:39.142798'),
	('a3db59a5-6fb6-4143-a54d-49c17ea667b7', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '25d08f89-cde5-4de6-a61f-ae04a27f1917', 1, '2025-06-23 07:27:39.142798'),
	('a4c19843-6a97-4618-a405-e7b01f01febb', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '797e5845-02c8-4ab6-83ee-d28870fa8faa', 1, '2025-06-23 07:31:05.823241'),
	('a5b278c9-2e2b-43a1-8e79-63fab19e6513', 'https://salt.tikicdn.com/cache/280x280/ts/product/fb/e9/f0/a0bb6430a43194a03446873d9bc81c9b.jpg', 0, '69d62c84-4df3-4152-909c-d6504bcc194c', 1, '2025-06-23 07:30:14.522816'),
	('a66678fa-a304-42fa-a0d6-5d0b950e0476', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'c2a59b54-1867-4488-a024-6d15ccf871ea', 1, '2025-06-23 07:27:39.142798'),
	('a6ef567a-5cda-4afd-b4de-171d566639ad', 'https://salt.tikicdn.com/cache/280x280/ts/product/16/f9/35/fade6b5d78012583cf0a91964c958c49.jpg', 0, 'd856c4c9-c899-4e7c-a715-953b9728ad5a', 1, '2025-06-23 07:31:05.823241'),
	('a6f1cca5-470c-48fb-b325-9128abd91e77', 'https://salt.tikicdn.com/cache/280x280/ts/product/3d/a9/a1/d9038e515fd7dde3169b759d7a7c162b.jpg', 0, 'cc1b6d28-3b8d-446b-808e-155803ab9c3a', 1, '2025-06-23 07:30:14.522816'),
	('a7265e93-21c0-4656-b6ca-085f9e08c9d6', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '5d42925a-67cd-40ae-aee7-27125f109061', 1, '2025-06-23 07:31:05.823241'),
	('a75f5472-5415-43e4-b3be-a48210037179', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '51d96b86-a7b0-415d-942b-9baea254edea', 1, '2025-06-23 07:30:14.522816'),
	('aaba7a26-2a6c-42cc-bb42-4b05f7d64a04', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '897392e3-1b6f-4d55-b232-3a368fcb57c0', 1, '2025-06-23 07:31:05.823241'),
	('abab46af-9ce0-4131-b6b2-336e930d37b8', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '6966862e-64ad-474b-93f7-cc339f8bf0d7', 1, '2025-06-23 07:27:39.142798'),
	('abde15d5-4792-4f7c-a149-7d1a0a431764', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, 'a5b411bc-b8c4-4394-a4f4-85f25fc8601a', 1, '2025-06-23 07:31:05.823241'),
	('ac6640a3-9080-43ee-9955-c682be1e606d', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'adf5f73d-d537-4f75-b272-1ef4b2f5e8f6', 1, '2025-06-23 07:27:39.142798'),
	('ad48b77a-cd04-44bd-919a-e962c00d39d7', 'https://salt.tikicdn.com/cache/280x280/ts/product/80/17/e5/4d4743c1e3e02987ceae680718407b48.jpg', 0, '194d9b30-ea3a-40df-ae31-674d1253e86c', 1, '2025-06-23 07:27:39.142798'),
	('ad919738-b689-4390-ac5b-1da5bab91610', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'f5868518-6139-4b7b-979f-e84c0d4af414', 1, '2025-06-23 07:27:39.142798'),
	('adda96d8-ff8d-4e17-81aa-b1dd509ced3a', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'dd311eb3-7310-462a-a70d-18296da6507b', 1, '2025-06-23 07:30:14.522816'),
	('ae360c2c-4798-4682-82d5-b45c8bfae609', 'https://salt.tikicdn.com/cache/280x280/ts/product/a0/f4/e3/8d5156f9b8c0c605e78b9b3bf24c9209.jpg', 0, 'fc518fd5-8a16-4f14-9cd5-d0996b6c03c6', 1, '2025-06-23 07:27:39.142798'),
	('ae62e18b-fe04-46d5-b73e-f31eab3433fc', 'https://salt.tikicdn.com/cache/280x280/ts/product/bb/f3/ff/531b52d45fbfd29492ac58eccef49459.PNG', 0, '7a983164-7fa7-4b74-9c11-4db735175104', 1, '2025-06-23 07:31:05.823241'),
	('af4a4ec4-6bda-4e61-a42e-525ee05d13e4', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '9505a216-2831-4946-86cc-c85eed61833e', 1, '2025-06-23 07:30:14.522816'),
	('af88b22b-6519-466e-b6b1-b59285d34397', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '12292913-9ea7-45d3-a962-8ba53b99d201', 1, '2025-06-23 07:30:14.522816'),
	('b1647bf0-f3e8-4bfb-adda-8103b365cf33', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'a034e7d2-5a73-4ffe-98d6-592a7329d2f0', 1, '2025-06-23 07:30:14.522816'),
	('b1829e27-1c29-4e3e-9121-71b6902375d6', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'fa79a052-d65c-4289-998c-d0a226e59e12', 1, '2025-06-23 07:30:14.522816'),
	('b1b1d878-1025-4b06-a0f6-fa3969583077', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'f2eccd24-2bd3-48cf-81df-5a5e957022d0', 1, '2025-06-23 07:30:14.522816'),
	('b1b1ff1c-fbd1-4b23-aee7-213f86cbb360', 'https://salt.tikicdn.com/cache/280x280/ts/product/ed/f9/f8/19f3dbf3c4f879f174e7d6eca8ecc2ab.jpg', 0, '5611fcd3-16ad-4fa3-b70c-424e7343bade', 1, '2025-06-23 07:27:39.142798'),
	('b298851c-36f6-4bde-998e-46969a542782', 'https://salt.tikicdn.com/ts/tka/a8/31/b6/802e2c99dcce64c67aa2648edb15dd25.png', 0, 'ea02db42-b7a3-4aba-b136-b5bc05d5bda5', 1, '2025-06-23 07:30:14.522816'),
	('b3d16378-7dcb-4be7-bba9-eef1d162d6a0', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '7cbe5819-55de-4eb4-abd2-cc4fd55fb6c4', 1, '2025-06-23 07:31:05.823241'),
	('b4f6b872-f186-4168-b3ba-2bfd5444cf40', 'https://salt.tikicdn.com/cache/280x280/ts/product/a4/ca/44/a1b9e7ccfdbd3ca60fc9c2d104d532b0.jpg', 0, 'b85d49c6-1432-4aea-b6dc-db61b16366be', 1, '2025-06-23 07:30:14.522816'),
	('b54c666e-0e11-482a-ae5d-3faaecb2332e', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '53e30166-298e-489e-bb33-04d4962b1b30', 1, '2025-06-23 07:31:05.823241'),
	('b54f878c-0be1-4c69-8a24-e899ca0391e7', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '0a2f8c95-b91b-464d-84dc-1546f78ea519', 1, '2025-06-23 07:31:05.823241'),
	('b5739376-0110-471e-8ec9-675083a0ae8f', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '3316784d-e63b-4302-8f27-34a51f24b2c2', 1, '2025-06-23 07:31:05.823241'),
	('b611dbda-3c3d-4ca1-9b54-036dc19c09bf', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '70a9d91e-6d39-4618-a60e-2c9ca695a7b9', 1, '2025-06-23 07:27:39.142798'),
	('b6d53441-22fd-4900-b78a-3e5f8be94148', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'f7089ff1-e5c7-477d-a29d-99f8eea72094', 1, '2025-06-23 07:31:05.823241'),
	('b8521f09-052f-4a89-ba98-118ddece72f9', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, '2f0685d3-6045-46a6-9ce3-d1e4d50fcff4', 1, '2025-06-23 07:30:14.522816'),
	('b93c5cfc-47e3-4a9e-99e2-799a2d96e55c', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '52482565-803a-4976-8888-d10d72412dae', 1, '2025-06-23 07:27:39.142798'),
	('b95662f8-9bd7-4df6-a552-033be8692f45', 'https://salt.tikicdn.com/cache/280x280/ts/product/8d/6d/42/e6a85a4c776eb1102a6726a5bfae0013.jpg', 0, 'd7b3ff30-369a-4fc0-b64b-c06c93731726', 1, '2025-06-23 07:27:39.142798'),
	('ba55bff4-6b2e-41ed-a216-6756af02cadb', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '9cb9f59e-7834-4e5a-bb5b-b6a4dac5710e', 1, '2025-06-23 07:31:05.823241'),
	('bac9b13b-d505-49a9-90dc-777d968138bf', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '70fc4268-7e3b-4fc0-8c1a-bc3116ae0389', 1, '2025-06-23 07:30:14.522816'),
	('baedf252-a846-4328-add9-c5623f556615', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '08cf5085-5bc2-4c1b-ab5a-34d169ae5c0c', 1, '2025-06-23 07:27:39.142798'),
	('bb1a37bb-433e-4971-822b-2e7233bf6129', 'https://salt.tikicdn.com/cache/280x280/ts/product/05/54/24/bcec71b892f4dacc17da325ddf697fe3.jpg', 0, '31a914d9-93ef-4615-95a5-e834fa5c0e96', 1, '2025-06-23 07:31:05.823241'),
	('bb2dc76d-4d4c-437f-8ead-b4dcac0f8cfe', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '2f0685d3-6045-46a6-9ce3-d1e4d50fcff4', 1, '2025-06-23 07:30:14.522816'),
	('bbc4781e-5932-451e-9eb0-5653319e9a7f', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'b034ad6a-7204-4979-b46a-f90421b1f204', 1, '2025-06-23 07:30:14.522816'),
	('bdd37f47-46ed-4e7c-9343-d789458d5071', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, 'b20042f1-e3f4-4c0c-94c5-bef8a95cc141', 1, '2025-06-23 07:31:05.823241'),
	('bddb5fc7-0d4d-43cd-9646-bb1398092672', 'https://salt.tikicdn.com/cache/280x280/ts/product/f4/83/3f/a6ca65e0d8309d4eead556b23bec7734.jpg', 0, 'e93ae496-e72a-4337-b0f7-283bd39cff73', 1, '2025-06-23 07:30:14.522816'),
	('be3f25ac-cbb1-420f-95ad-ca1b6cd8f93f', 'https://salt.tikicdn.com/cache/280x280/ts/product/a3/a5/31/c7d73aff751bd6ce69b7d844256c3378.jpg', 0, 'e63549ed-5176-412a-a0e0-15adf7fed498', 1, '2025-06-23 07:31:05.823241'),
	('bea4407a-8a52-4816-975c-28f6e3f1954c', 'https://salt.tikicdn.com/cache/280x280/ts/product/4d/49/19/6a277f5d44aca169adf28bfcc087294f.jpg', 0, '49f7f4e8-2b16-4f2c-b52e-febd445e6f86', 1, '2025-06-23 07:27:39.142798'),
	('bebdaf18-4c7c-4136-ac23-1d5fefee7f97', 'https://salt.tikicdn.com/cache/280x280/ts/product/b2/9a/f3/5669a237dba950759f4d4e563acf26da.jpg', 0, 'ab2c521d-ed4d-4374-ac49-bfb41e9473d1', 1, '2025-06-23 07:31:05.823241'),
	('bfb1e873-a40e-4f57-b3aa-ff37d08db017', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, '50effe91-1642-4f24-ac00-80fdb5ef023d', 1, '2025-06-23 07:31:05.823241'),
	('bfb86458-5bcb-4a30-b8b4-81799e933f80', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '9f11aa0f-e103-4425-9ae1-ec58e0e3fafa', 1, '2025-06-23 07:31:05.823241'),
	('c0109fb5-01ae-4f6b-a5c8-ef90ca25dc80', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '4c84125a-c700-42f8-8655-5c59d130584c', 1, '2025-06-23 07:31:05.823241'),
	('c0ec8e50-a1b8-4302-91b7-2643f6746142', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, 'aeed6277-4902-478e-a899-433bd18a1888', 1, '2025-06-23 07:27:39.142798'),
	('c20c5e58-1308-4dd8-a9d5-0ebc62d14713', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'fba576e6-ff5c-4cd8-aed2-41c23441c881', 1, '2025-06-23 07:30:14.522816'),
	('c294ddbc-48ec-4f7a-a32d-b02b7bdd9cf2', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '7684b009-3a75-4ab7-be09-64d4c025c039', 1, '2025-06-23 07:31:05.823241'),
	('c3474536-dfb9-44ba-b78b-7d96a8365169', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, '9cb9f59e-7834-4e5a-bb5b-b6a4dac5710e', 1, '2025-06-23 07:31:05.823241'),
	('c59bdd6b-c371-4efb-bdbd-ed050a78a60b', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'b20042f1-e3f4-4c0c-94c5-bef8a95cc141', 1, '2025-06-23 07:31:05.823241'),
	('c6033440-8388-4c6e-8c8e-361b7bbfd7f5', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '3a70bf18-ff46-4bb9-a8e2-5ffd4df9217d', 1, '2025-06-23 07:30:14.522816'),
	('c633c45e-2495-4b4c-99d0-26cde7d0628b', 'https://salt.tikicdn.com/cache/280x280/ts/product/09/9a/59/989704ed5e5aec5f7dd5ecde4c4c6fe8.jpg', 0, '62660fe5-f334-4e91-8966-0c8e1f520ee5', 1, '2025-06-23 07:31:05.823241'),
	('c639b657-f3a3-4ac7-9a8b-c3032728c2ca', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '52c3f778-43e4-45d2-ab9f-e8593434716a', 1, '2025-06-23 07:31:05.823241'),
	('c64ad346-a641-4364-8c89-fba1f4bbcc84', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'a2166b52-0ca3-40f8-9d22-0ca4d70490c3', 1, '2025-06-23 07:27:39.142798'),
	('c66b8451-615a-4d15-a57b-7ee3e083dda9', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '5b9a8c04-62b7-43ed-8139-aa512605f988', 1, '2025-06-23 07:27:39.142798'),
	('c7b55d22-850f-4710-b4da-542d7537e18c', 'https://salt.tikicdn.com/cache/280x280/ts/product/c2/02/28/34615ab9fd1c38d1563654c4bcfc4645.jpg', 0, 'c0243a04-926e-4045-972c-3624942c3c03', 1, '2025-06-23 07:30:14.522816'),
	('c8f9ea2a-519b-4c55-bfe6-70b469d57c77', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '3316784d-e63b-4302-8f27-34a51f24b2c2', 1, '2025-06-23 07:31:05.823241'),
	('c946d8a7-2f0b-4865-9fe0-98dfeadd4fc7', 'https://salt.tikicdn.com/cache/280x280/ts/product/88/60/18/8a7c4a19375a6d15333111dda504e551.jpg', 0, '08fe53a0-7e8b-47f3-8a0c-3b22da746ad2', 1, '2025-06-23 07:27:39.142798'),
	('ca4216e7-db02-485d-8cc8-5c450ca6ac3c', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '3467da1d-53fb-4515-91b4-10ecfb29d70c', 1, '2025-06-23 07:27:39.142798'),
	('cab4670e-a967-4fec-be33-ac22549563a9', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'ab2c521d-ed4d-4374-ac49-bfb41e9473d1', 1, '2025-06-23 07:31:05.823241'),
	('cb12b9e6-a6f1-4796-987e-71d7b5307b90', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '03e29503-e3fc-4668-8785-865ad7953063', 1, '2025-06-23 07:31:05.823241'),
	('cb6038e2-e378-41f7-a06d-5b7f48595b5b', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '66880323-43e8-4961-875e-613f756a41da', 1, '2025-06-23 07:31:05.823241'),
	('cc0e9afd-22ca-4bc7-82cd-9b3e0bddd1f6', 'https://salt.tikicdn.com/cache/280x280/ts/product/4b/e3/80/fa487b8f2875e548a9ed2a61b6859935.PNG', 0, '52482565-803a-4976-8888-d10d72412dae', 1, '2025-06-23 07:27:39.142798'),
	('ccfe8f7c-5f6c-4c0d-b1f9-7d0896806cc3', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '5f383df8-ce45-4cdc-af42-89fd49cc2ad8', 1, '2025-06-23 07:30:14.522816'),
	('cd028f13-dd4f-4212-b824-b114f52e113f', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '0419857e-9a52-44be-833a-dcc0760aaee4', 1, '2025-06-23 07:31:05.823241'),
	('cd328e51-2b85-43ac-bc55-979da2f5193c', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '50aecab3-88b2-4d7b-bb5e-8ba4d02d8b2d', 1, '2025-06-23 07:27:39.142798'),
	('ce180bca-ccd2-4e08-a1ec-a53ce7e76bfa', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '9a19062e-114f-471a-bea3-16d7f07a7113', 1, '2025-06-23 07:30:14.522816'),
	('ce67b55c-5c4a-4136-8e0b-86ee9b30e842', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'bce4a365-01fe-4134-8528-2acad3416908', 1, '2025-06-23 07:27:39.142798'),
	('cf15450c-19fb-422d-9d02-a4f23922a663', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '37a06604-b839-4caa-8c30-0df41db3a40b', 1, '2025-06-23 07:27:39.142798'),
	('d16909e4-a950-432c-85a9-a96d1f3fc8eb', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '2872cf02-c1e3-483d-88f9-a03404334f63', 1, '2025-06-23 07:27:39.142798'),
	('d1b82c6b-0f66-4f6a-a6b5-687962ae9e5e', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, 'dc93837f-4c61-486f-8992-b06f8b80333d', 1, '2025-06-23 07:31:05.823241'),
	('d414de90-aafa-41ad-be72-8cdec68315d0', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'c0eebf65-d977-48c9-bfd2-e34ac2736926', 1, '2025-06-23 07:31:05.823241'),
	('d44cc512-914e-4027-8470-889511598b99', 'https://salt.tikicdn.com/cache/280x280/ts/product/d5/d0/d8/c68d7fccdc6a259ecc3d5f8fe6ed6712.jpg', 0, '4c333f43-c668-4a56-9556-c28a864ab420', 1, '2025-06-23 07:27:39.142798'),
	('d510bb14-2f83-4b12-aab0-66d4771ee520', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, 'a537de39-7cb1-4e3c-9f47-126fa746f8f3', 1, '2025-06-23 07:27:39.142798'),
	('d65186c6-b737-4afc-8a9b-4076cf307f21', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'a034e7d2-5a73-4ffe-98d6-592a7329d2f0', 1, '2025-06-23 07:30:14.522816'),
	('d68c2e2e-a2f4-44e8-918b-9e2aa315547d', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'fc518fd5-8a16-4f14-9cd5-d0996b6c03c6', 1, '2025-06-23 07:27:39.142798'),
	('d68da251-ce11-4415-b3e9-d57024a8b9b4', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '33c892e4-2c9b-4896-9578-0e38e5a429c4', 1, '2025-06-23 07:30:14.522816'),
	('d7140980-ab36-4a78-a96c-ee514c774593', 'https://salt.tikicdn.com/cache/280x280/ts/product/9e/30/0b/20e6c389ebbc25592a133418307ddae3.jpg', 0, '00cca015-61b8-499b-9578-a6d420c1a38f', 1, '2025-06-23 07:31:05.823241'),
	('d7b00e7d-24eb-40a7-b70a-1993c0b9fc38', 'https://salt.tikicdn.com/ts/upload/12/e2/4a/c5226426ee9429b0050449ae5403c9cf.png', 0, '45ce855b-6ebc-43b9-8fd8-fbd4d050dbac', 1, '2025-06-23 07:27:39.142798'),
	('d82980af-737d-45ee-9452-388cecd80b4f', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '4b35b4f4-3dd9-4856-943c-92e4a0b25f1b', 1, '2025-06-23 07:27:39.142798'),
	('d831baf4-0552-4416-b602-59dba2bc133c', 'https://salt.tikicdn.com/cache/280x280/ts/product/4c/f4/9f/49857ab02d9353ddd2332e8a07a00bdf.jpg', 0, '9eb4f39e-a629-4eac-9d22-fb26ae336dae', 1, '2025-06-23 07:27:39.142798'),
	('d977be99-9728-4e5e-b7ae-884b01ea809e', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'b85d49c6-1432-4aea-b6dc-db61b16366be', 1, '2025-06-23 07:30:14.522816'),
	('d97a5c96-a401-491f-9c2c-20a612d24b08', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, 'b00027db-4e10-4783-bde1-e3cd25472b49', 1, '2025-06-23 07:31:05.823241'),
	('da87d70f-4bee-444d-9503-e409d80c244c', 'https://salt.tikicdn.com/cache/280x280/ts/product/96/fd/48/616660861a1e4a44c83851a819c91e0d.jpg', 0, '55c85db8-1f11-4a5d-86f1-8f501dc4bd45', 1, '2025-06-23 07:27:39.142798'),
	('dad3f25e-efdc-496f-b0e2-da99573d6c5f', 'https://salt.tikicdn.com/ts/tka/a8/31/b6/802e2c99dcce64c67aa2648edb15dd25.png', 0, 'e93ae496-e72a-4337-b0f7-283bd39cff73', 1, '2025-06-23 07:30:14.522816'),
	('db88ded7-a2da-413d-9880-8c63991614d0', 'https://salt.tikicdn.com/cache/280x280/ts/product/5e/75/0f/8d4127c94a93c4fbcdad3147af0e1dec.jpg', 0, '6c05666f-c8d3-406e-adff-9f5f95c9bec3', 1, '2025-06-23 07:30:14.522816'),
	('dcb13ba2-806d-4112-914f-148da5bd7a32', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '323a1fa7-6518-4993-bf0e-ed57e80516fc', 1, '2025-06-23 07:27:39.142798'),
	('dce1f838-478b-4f51-a600-49288a4b03eb', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '5c87dea8-564b-43d4-a550-383306b75c2d', 1, '2025-06-23 07:30:14.522816'),
	('dd0a51e1-6489-4529-a219-60a672e58f64', 'https://salt.tikicdn.com/cache/280x280/ts/product/e8/7a/a4/3252a0547786165237a9c391d942b0c5.png', 0, 'f496b1f6-35b0-4842-b574-6f0473902491', 1, '2025-06-23 07:30:14.522816'),
	('ddb15315-9bf1-46e7-b6d2-68238ba60b78', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '7684b009-3a75-4ab7-be09-64d4c025c039', 1, '2025-06-23 07:31:05.823241'),
	('de5e2bbb-06d1-47c7-8407-543dc93daf86', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '4ae0b19a-8343-486f-bdfc-d3e0f175fbb0', 1, '2025-06-23 07:31:05.823241'),
	('e0296962-69aa-4674-9d47-fec45a6bab42', 'https://salt.tikicdn.com/cache/280x280/ts/product/90/b0/54/6e03c85ac70bdd3b6a382f2e112b2050.png', 0, '5c6799c1-0176-4da7-ac84-84c262e2c1ee', 1, '2025-06-23 07:31:05.823241'),
	('e0cb07ef-e11a-44ec-a65e-4dbbc12bb1c2', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, '50aecab3-88b2-4d7b-bb5e-8ba4d02d8b2d', 1, '2025-06-23 07:27:39.142798'),
	('e138259e-4fb7-45f3-832c-9b212d5e7fc5', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '7a983164-7fa7-4b74-9c11-4db735175104', 1, '2025-06-23 07:31:05.823241'),
	('e1d9a380-673b-4be5-8daf-a9d416725ec2', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'ee66400d-1c55-4b27-bded-79698d83d031', 1, '2025-06-23 07:30:14.522816'),
	('e1dc7fc7-3172-48aa-b2ad-fec52351c555', 'https://salt.tikicdn.com/cache/280x280/ts/product/85/26/57/e5561d66deca1919d4a6f11e1da6901f.jpg', 0, '50b50901-f42c-428b-bad0-2d5b36831326', 1, '2025-06-23 07:30:14.522816'),
	('e221b462-0b0a-421c-9264-adb2dc164454', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, '30c57e9c-bbe9-4330-a063-4996065a93f5', 1, '2025-06-23 07:30:14.522816'),
	('e32c226e-2938-4a19-bcac-4a3e11d681c1', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'c8b86bd6-9fd5-4bcf-92b4-01b366552e34', 1, '2025-06-23 07:27:39.142798'),
	('e3be5a77-5898-4d3d-ba72-96a26d74252e', 'https://salt.tikicdn.com/cache/280x280/ts/product/7e/fd/f3/c56828ac9e9e7363eddd7041dec43b14.PNG', 0, 'f87581dd-7a6c-43be-a22a-1fb1a0dd28e8', 1, '2025-06-23 07:30:14.522816'),
	('e3dafa25-4963-4c57-8419-5c3383902cb2', 'https://salt.tikicdn.com/cache/280x280/ts/product/ec/67/19/99bae27cd7840707acacb32cc97758e2.jpg', 0, '4c84125a-c700-42f8-8655-5c59d130584c', 1, '2025-06-23 07:31:05.823241'),
	('e5bcde84-9903-4e02-8f31-b37240c91125', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, '26ff330b-102b-4a94-b756-094537d2e3cd', 1, '2025-06-23 07:31:05.823241'),
	('e5c07f1c-ab36-4a38-8c6f-2d4f48811739', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '5d42925a-67cd-40ae-aee7-27125f109061', 1, '2025-06-23 07:31:05.823241'),
	('e66f21fa-c1c2-4980-b095-28b9fc8d1f68', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'e63549ed-5176-412a-a0e0-15adf7fed498', 1, '2025-06-23 07:31:05.823241'),
	('e8b00c28-c4a0-4967-a8bb-79e375a0281d', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, '9a19062e-114f-471a-bea3-16d7f07a7113', 1, '2025-06-23 07:30:14.522816'),
	('e933b022-8491-4300-af72-f73f30e2bd73', 'https://salt.tikicdn.com/cache/280x280/ts/product/a4/0e/4b/6d43643b97620e4f4105dfd2a7d4399d.jpg', 0, '50effe91-1642-4f24-ac00-80fdb5ef023d', 1, '2025-06-23 07:31:05.823241'),
	('e9476bb6-ef17-4faf-beb6-0f0608d1c057', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '6b6c5b8c-f2b9-4395-a157-a29b39673d10', 1, '2025-06-23 07:27:39.142798'),
	('e9d94618-0450-4647-aa67-e7c740e5c6be', 'https://salt.tikicdn.com/cache/280x280/ts/product/ca/a7/1e/ebe3a37b3459b1fd7f51a3dc67123425.jpg', 0, 'e48357c9-68e7-4998-8722-e1c76dfedff1', 1, '2025-06-23 07:27:39.142798'),
	('ea1388b1-64c0-40a5-90a4-56adbacf8d60', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, 'f87581dd-7a6c-43be-a22a-1fb1a0dd28e8', 1, '2025-06-23 07:30:14.522816'),
	('ea8dd0b4-3d3f-40a8-920b-3fb599da7288', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '416308cf-5ec8-46c8-914d-92fe8adbf66f', 1, '2025-06-23 07:27:39.142798'),
	('ec4e7d92-7e3a-4f92-9f8a-1a060811f3f5', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '5c6799c1-0176-4da7-ac84-84c262e2c1ee', 1, '2025-06-23 07:31:05.823241'),
	('ef2adeb5-5b27-4cd0-8214-426be6caabf9', 'https://salt.tikicdn.com/cache/280x280/ts/product/53/f8/00/a3cd8e4561e57be768a0ec4ad706c739.jpg', 0, '78521e04-b4d6-4d17-a928-015863d6e4ce', 1, '2025-06-23 07:27:39.142798'),
	('f0438d9a-3a71-4fa1-bd87-ad2af690ee4c', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, 'c63d400c-8219-467f-a1a7-5de4e3e8429d', 1, '2025-06-23 07:30:14.522816'),
	('f06075e0-edb4-4203-82e0-1f37b5907ea8', 'https://salt.tikicdn.com/cache/280x280/ts/product/6e/f1/98/9f87d7ba2bde4bf43aec69b32f116eb4.png', 0, 'b502dfba-049d-45ee-98e3-fbc00180e313', 1, '2025-06-23 07:27:39.142798'),
	('f22eac7c-ae91-45aa-8b77-89a60ac7a8f3', 'https://salt.tikicdn.com/cache/280x280/ts/product/8a/02/74/9ced64f2dadf846f55c71553fd0042e5.jpg', 0, 'f888172f-fc88-4eb9-9de4-9024cf7b8178', 1, '2025-06-23 07:27:39.142798'),
	('f2c82773-a1f1-467b-8359-e8089431068c', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '08fe53a0-7e8b-47f3-8a0c-3b22da746ad2', 1, '2025-06-23 07:27:39.142798'),
	('f31ea308-e94c-40ac-801e-f60d3e741230', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '3f2ea67c-c681-4cac-98ad-f45ed6ca99de', 1, '2025-06-23 07:31:05.823241'),
	('f3961770-9a83-4325-88bc-64f897d7fe7a', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '58592752-4a85-4c39-a91f-5f7fa8000b08', 1, '2025-06-23 07:27:39.142798'),
	('f4b170e7-2add-4abb-902a-99f6eca95602', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '5fc75b96-1489-4bdf-90f4-79b6858cf50c', 1, '2025-06-23 07:30:14.522816'),
	('f4e67c4d-f006-47d4-88a5-ec7fbd920b97', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '2af45fe5-f2bd-4dc7-9821-9c6fbd12b880', 1, '2025-06-23 07:30:14.522816'),
	('f54465ef-21d2-4bd3-b5a5-83449303e4c7', 'https://salt.tikicdn.com/cache/280x280/ts/product/0e/53/a4/0614659a732478fdf19bdac0249190e4.jpg', 0, '655d2193-e4ee-448f-a39f-9981ddb65f6a', 1, '2025-06-23 07:31:05.823241'),
	('f699327c-d6e7-4f5e-ade5-c61de0c9f2fc', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, 'f888172f-fc88-4eb9-9de4-9024cf7b8178', 1, '2025-06-23 07:27:39.142798'),
	('f70f1dc7-78b0-41e4-a986-a0d43dcfde1a', 'https://salt.tikicdn.com/ts/upload/b2/8d/56/3086efc2194320a6b83fba7530de7c78.png', 0, '62660fe5-f334-4e91-8966-0c8e1f520ee5', 1, '2025-06-23 07:31:05.823241'),
	('f807d8de-2408-4c01-a933-ade068fe8852', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '6334c45d-aa29-44e2-b97a-29216accad0a', 1, '2025-06-23 07:30:14.522816'),
	('f81d915f-9b72-45bb-8b35-602adebb3525', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '66880323-43e8-4961-875e-613f756a41da', 1, '2025-06-23 07:31:05.823241'),
	('f8276d65-12ff-4609-a938-ef9494033384', 'https://salt.tikicdn.com/cache/280x280/ts/product/a8/b4/d2/44b79741ec6b69a10b00782a9b750955.jpg', 0, 'e4db6187-39ef-493b-aaeb-49b703c61ca9', 1, '2025-06-23 07:30:14.522816'),
	('fb840869-a1a2-44f1-9067-7a79e8d779c2', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '8e1c1411-9d3e-440f-88cf-bb655fd54b7b', 1, '2025-06-23 07:31:05.823241'),
	('fbd2753f-92ce-4005-b09a-90763bfd767b', 'https://salt.tikicdn.com/cache/280x280/ts/product/20/ae/3e/ea88b21eec38e2fea6a720a985308ea4.png', 0, 'a537de39-7cb1-4e3c-9f47-126fa746f8f3', 1, '2025-06-23 07:27:39.142798'),
	('fc65cd87-0855-465e-9580-e05216ebb123', 'https://salt.tikicdn.com/ts/upload/d5/f3/6f/fdd40db52ff4afe497d0c2240dcfd25b.png', 0, 'f496b1f6-35b0-4842-b574-6f0473902491', 1, '2025-06-23 07:30:14.522816'),
	('fd319fd1-0cf5-4ca7-8b3b-ef80104220b8', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '2560c61b-617c-42d9-a574-2854f76c6d0c', 1, '2025-06-23 07:31:05.823241'),
	('fdbc66af-af3f-4853-940a-64cada87694d', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '244d55fa-51ee-4e11-b479-ae1bec58c7d6', 1, '2025-06-23 07:30:14.522816'),
	('fdd460e5-8535-45ed-8011-096a29fc36f5', 'https://salt.tikicdn.com/ts/upload/f7/9e/83/ab28365ea395893fe5abac88b5103444.png', 0, '0419857e-9a52-44be-833a-dcc0760aaee4', 1, '2025-06-23 07:31:05.823241'),
	('fdf70a04-d1ed-4aa1-9339-ec70a64dad5c', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'c0eebf65-d977-48c9-bfd2-e34ac2736926', 1, '2025-06-23 07:31:05.823241'),
	('ff5f9420-2ad6-421d-bbbe-fb7b4df3aa46', 'https://salt.tikicdn.com/ts/tka/69/cf/22/1be823299ae34c7ddcd922e73abd4909.png', 0, '61db7753-3466-44a5-bbdb-49ba211d5363', 1, '2025-06-23 07:27:39.142798'),
	('ffb6b62d-589b-44a6-adbc-d8bb4119aef0', 'https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png', 0, '7f946539-a0ac-47ac-a582-1a2e4d1ef127', 1, '2025-06-23 07:30:14.522816'),
	('ffe71815-2798-4c6a-b2c6-5bbcae507a42', 'https://salt.tikicdn.com/cache/w96/ts/tka/26/a2/90/0663718b1c04d15a46bf0f23874a7e01.png', 0, 'c63d400c-8219-467f-a1a7-5de4e3e8429d', 1, '2025-06-23 07:30:14.522816');

-- Dumping structure for table mod_keyboard.ratings
DROP TABLE IF EXISTS `ratings`;
CREATE TABLE IF NOT EXISTS `ratings` (
  `id` char(36) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `rating` tinyint NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `product_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `content` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK228us4dg38ewge41gos8y761r` (`product_id`),
  KEY `FKb3354ee2xxvdrbyq9f42jdayd` (`user_id`),
  CONSTRAINT `FK228us4dg38ewge41gos8y761r` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKb3354ee2xxvdrbyq9f42jdayd` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.ratings: ~0 rows (approximately)
DELETE FROM `ratings`;

-- Dumping structure for table mod_keyboard.revenue_statistics
DROP TABLE IF EXISTS `revenue_statistics`;
CREATE TABLE IF NOT EXISTS `revenue_statistics` (
  `id` char(36) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `date_period` varchar(255) NOT NULL,
  `period_type` enum('DAY','MONTH','WEEK','YEAR') NOT NULL,
  `total_orders` int NOT NULL,
  `total_quantity` int NOT NULL,
  `total_revenue` double NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `category_id` char(36) NOT NULL,
  `product_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKcm00s6sma0t7kaxb253lo5wir` (`category_id`),
  KEY `FKcamwyoaqs7j9kjdn4fa7cqv8x` (`product_id`),
  CONSTRAINT `FKcamwyoaqs7j9kjdn4fa7cqv8x` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKcm00s6sma0t7kaxb253lo5wir` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.revenue_statistics: ~0 rows (approximately)
DELETE FROM `revenue_statistics`;

-- Dumping structure for table mod_keyboard.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` char(36) NOT NULL,
  `name` enum('ROLE_ADMIN','ROLE_CUSTOMER','ROLE_EMPLOYEE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.roles: ~3 rows (approximately)
DELETE FROM `roles`;
INSERT INTO `roles` (`id`, `name`, `description`) VALUES
	('134db8f4-5ddd-4c51-b624-6fe1e7a7cba4', 'ROLE_ADMIN', NULL),
	('54cc189a-5157-4009-a3d6-bba2d236d63e', 'ROLE_CUSTOMER', NULL),
	('cf5e9b94-5380-49ed-b27e-0bb6ff45173f', 'ROLE_EMPLOYEE', NULL);

-- Dumping structure for table mod_keyboard.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` char(36) NOT NULL,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.users: ~3 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `email`, `full_name`, `password`, `phone`, `status`) VALUES
	('3e21ca52-1680-4a22-a1ca-5216800a22aa', '211304190@st.hcmuaf.edu.vn', 'LapNguyen', '$2a$10$1BQxfAApM9RcwOJs0RRzHOn6kA0HPIKr3rJPSVnsBPoBZelf9E.Ja', '0123456789', 0),
	('47eb85db-efe3-4750-ab85-dbefe3c750e4', 'haunguyen.testing@gmail.com', 'LapNguyen', '$2a$10$1BQxfAApM9RcwOJs0RRzHOn6kA0HPIKr3rJPSVnsBPoBZelf9E.Ja', '0123456789', 1),
	('4c252a59-8a16-455e-a52a-598a16e55e74', '21130419@st.hcmuaf.edu.vn', 'ab', '$2a$10$eL.KBN0rQqxIVbsufMnDuu95.HXU.MgLoQMwHqPhKarvRz1oraoFu', '0343820047', 1),
	('6381eb49-f9f6-4994-81eb-49f9f6b994d8', 'haudau124@gmail.com', 'LapNguyen', '$2a$10$GAiJxbpfKziZDG40xMA9iu9zP0dktgbTUSeTvW4ohL39QnzWkArgq', '0123456789', 0),
	('73e60879-da83-4b23-a608-79da838b239f', '21130363@st.hcmuaf.edu.vn', 'admin', '$2a$12$vBm/Pg2z4hSOywJ4JSQIne2/2ja1P9lN.aGpN3eIumzAwtfiAb2vu', NULL, 1),
	('82ed2c41-655e-4dad-ad2c-41655e7dad72', 'nguyenhoanglapit@gmail.com', 'LapNguyen', '$2a$10$YjXtjktd3BbEF4/KmXFu/.TzD9oEGYD0UDFRIma3hZBrFjaMhXR3G', '0123456789', 0),
	('c9348c78-6437-4d66-9f15-5f5bd332b27a', 'lap@gmail.com', 'employee', '$2a$12$vBm/Pg2z4hSOywJ4JSQIne2/2ja1P9lN.aGpN3eIumzAwtfiAb2vu', NULL, 1),
	('cf5e9b94-5380-49ed-b27e-0bb6ff45173f', 'tudo@gmail.com', 'customer', '$2a$12$vBm/Pg2z4hSOywJ4JSQIne2/2ja1P9lN.aGpN3eIumzAwtfiAb2vu', NULL, 1);

-- Dumping structure for table mod_keyboard.user_otp
DROP TABLE IF EXISTS `user_otp`;
CREATE TABLE IF NOT EXISTS `user_otp` (
  `id` char(36) NOT NULL,
  `expired_at` datetime NOT NULL,
  `otp_code` varchar(255) NOT NULL,
  `type` enum('FORGOT_PASSWORD','VERIFY_EMAIL') NOT NULL,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKii06t8igpfny3w1u6c7l16dme` (`otp_code`),
  KEY `FKbt42xp38p686cd0iwuc2ksd4h` (`user_id`),
  CONSTRAINT `FKbt42xp38p686cd0iwuc2ksd4h` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.user_otp: ~0 rows (approximately)
DELETE FROM `user_otp`;
INSERT INTO `user_otp` (`id`, `expired_at`, `otp_code`, `type`, `user_id`) VALUES
	('03536b58-2327-4c1d-936b-582327fc1d18', '2025-06-23 09:20:13', '84273', 'FORGOT_PASSWORD', '47eb85db-efe3-4750-ab85-dbefe3c750e4'),
	('0f7dadfe-3ba6-4b4f-bdad-fe3ba61b4f56', '2025-06-23 09:28:10', '44553', 'FORGOT_PASSWORD', '47eb85db-efe3-4750-ab85-dbefe3c750e4'),
	('35556459-2d1e-466e-9564-592d1e766e3a', '2025-06-23 10:01:16', '21379', 'FORGOT_PASSWORD', '4c252a59-8a16-455e-a52a-598a16e55e74'),
	('3aae93ee-35ac-4c86-ae93-ee35ac1c8682', '2025-06-23 09:30:51', '33081', 'FORGOT_PASSWORD', '47eb85db-efe3-4750-ab85-dbefe3c750e4'),
	('56a19e3a-e0cd-4529-a19e-3ae0cdb529ae', '2025-06-23 08:14:29', '18006', 'VERIFY_EMAIL', '6381eb49-f9f6-4994-81eb-49f9f6b994d8'),
	('66874591-6a13-4990-8745-916a13c9907e', '2025-06-23 08:16:54', '57274', 'VERIFY_EMAIL', '3e21ca52-1680-4a22-a1ca-5216800a22aa'),
	('7d1d78f1-210b-43ff-9d78-f1210b43ff13', '2025-06-23 09:24:35', '74007', 'FORGOT_PASSWORD', '47eb85db-efe3-4750-ab85-dbefe3c750e4'),
	('8995959d-ca16-4bc4-9595-9dca166bc482', '2025-06-23 08:13:46', '15678', 'VERIFY_EMAIL', '82ed2c41-655e-4dad-ad2c-41655e7dad72'),
	('aa6de83e-e2b8-475c-ade8-3ee2b8375c81', '2025-06-23 09:25:30', '20096', 'FORGOT_PASSWORD', '47eb85db-efe3-4750-ab85-dbefe3c750e4'),
	('aa72068f-b49f-474d-b206-8fb49f574dbe', '2025-06-23 09:18:30', '15246', 'FORGOT_PASSWORD', '47eb85db-efe3-4750-ab85-dbefe3c750e4'),
	('aa93e2f0-2085-42b7-93e2-f02085a2b7d8', '2025-06-23 09:29:02', '71853', 'FORGOT_PASSWORD', '47eb85db-efe3-4750-ab85-dbefe3c750e4'),
	('bfdbd5bb-29bb-426a-9bd5-bb29bbd26a15', '2025-06-23 08:06:28', '75509', 'VERIFY_EMAIL', '47eb85db-efe3-4750-ab85-dbefe3c750e4'),
	('c9539173-1362-4dfd-9391-7313626dfdbd', '2025-06-23 09:31:38', '97446', 'FORGOT_PASSWORD', '47eb85db-efe3-4750-ab85-dbefe3c750e4'),
	('ef351e82-8679-4d59-b51e-8286799d5995', '2025-06-23 10:14:21', '48178', 'VERIFY_EMAIL', '4c252a59-8a16-455e-a52a-598a16e55e74');

-- Dumping structure for table mod_keyboard.user_role
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE IF NOT EXISTS `user_role` (
  `id` char(36) NOT NULL,
  `role_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK872xec3woupu3gw59b04pj3sa` (`user_id`,`role_id`),
  KEY `FKt7e7djp752sqn6w22i6ocqy6q` (`role_id`),
  CONSTRAINT `FKj345gk1bovqvfame88rcx7yyx` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKt7e7djp752sqn6w22i6ocqy6q` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mod_keyboard.user_role: ~6 rows (approximately)
DELETE FROM `user_role`;
INSERT INTO `user_role` (`id`, `role_id`, `user_id`) VALUES
	('18b2fd80-8f54-42b2-b2fd-808f54d2b28f', 'cf5e9b94-5380-49ed-b27e-0bb6ff45173f', '3e21ca52-1680-4a22-a1ca-5216800a22aa'),
	('226a7663-2b4a-4aa4-aa76-632b4a1aa475', '134db8f4-5ddd-4c51-b624-6fe1e7a7cba4', '47eb85db-efe3-4750-ab85-dbefe3c750e4'),
	('468d5afd-5a33-40e1-8d5a-fd5a33e0e182', 'cf5e9b94-5380-49ed-b27e-0bb6ff45173f', '4c252a59-8a16-455e-a52a-598a16e55e74'),
	('8391fd53-9e28-43b4-91fd-539e28a3b412', '134db8f4-5ddd-4c51-b624-6fe1e7a7cba4', '6381eb49-f9f6-4994-81eb-49f9f6b994d8'),
	('7bffe86a-c272-41bd-bfe8-6ac272e1bd0f', '134db8f4-5ddd-4c51-b624-6fe1e7a7cba4', '73e60879-da83-4b23-a608-79da838b239f'),
	('5c5f3acf-0ae6-4f5e-9f3a-cf0ae69f5e45', '54cc189a-5157-4009-a3d6-bba2d236d63e', '73e60879-da83-4b23-a608-79da838b239f'),
	('527b536e-95e6-42c0-bb53-6e95e662c09e', 'cf5e9b94-5380-49ed-b27e-0bb6ff45173f', '73e60879-da83-4b23-a608-79da838b239f'),
	('843c0a9d-90dc-4181-bc0a-9d90dc118196', '54cc189a-5157-4009-a3d6-bba2d236d63e', '82ed2c41-655e-4dad-ad2c-41655e7dad72'),
	('356f37bc-d57f-4e6e-af37-bcd57fae6e95', '54cc189a-5157-4009-a3d6-bba2d236d63e', 'c9348c78-6437-4d66-9f15-5f5bd332b27a'),
	('1f727605-6967-4f55-b276-056967bf553e', 'cf5e9b94-5380-49ed-b27e-0bb6ff45173f', 'c9348c78-6437-4d66-9f15-5f5bd332b27a'),
	('1a531a5e-fbb1-472e-931a-5efbb1572ebc', '54cc189a-5157-4009-a3d6-bba2d236d63e', 'cf5e9b94-5380-49ed-b27e-0bb6ff45173f');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
