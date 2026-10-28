-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: demandium_db
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance_pending` decimal(24,2) NOT NULL DEFAULT '0.00',
  `received_balance` decimal(24,2) NOT NULL DEFAULT '0.00',
  `account_payable` decimal(24,2) NOT NULL DEFAULT '0.00',
  `account_receivable` decimal(24,2) NOT NULL DEFAULT '0.00',
  `total_withdrawn` decimal(24,2) NOT NULL DEFAULT '0.00',
  `total_expense` decimal(24,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES ('2b9d4e99-f23d-4895-9167-22795f96d690','c8a9caef-2d69-406e-9dbe-7049e62357b4',0.00,0.00,0.00,0.00,0.00,0.00,'2026-09-25 19:10:11','2026-09-25 19:10:11'),('52c8d458-cd18-489f-942a-6fcfd892ca64','8be51d97-6fe0-4d46-a9c6-d77b4d2386f5',0.00,0.00,0.00,1274.38,0.00,0.00,'2026-09-13 02:47:50','2026-10-18 20:19:54'),('97fa7a50-db08-4803-928f-0f29301247cf','a72401cd-34d4-4f5d-9276-3e0c860e4cab',0.00,0.00,0.00,0.00,0.00,0.00,'2026-09-25 19:22:55','2026-09-25 19:22:55'),('acct-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001',3500.00,33172.62,2474.38,18000.00,8000.00,2500.00,'2026-09-12 15:45:50','2026-10-18 20:19:54'),('acct-0001-0001-0001-000000000002','prvd-0001-0001-0001-000000000002',2200.00,9000.00,800.00,11000.00,5000.00,1500.00,'2026-09-12 15:45:50','2026-09-12 15:45:50'),('acct-0001-0001-0001-000000000003','prvd-0001-0001-0001-000000000003',5000.00,25000.00,2000.00,30000.00,12000.00,4000.00,'2026-09-12 15:45:50','2026-09-12 15:45:50'),('acct-0001-0001-0001-000000000004','prvd-0001-0001-0001-000000000004',8000.00,40000.00,3000.00,50000.00,20000.00,6000.00,'2026-09-12 15:45:50','2026-09-12 15:45:50'),('acct-0001-0001-0001-000000000005','prvd-0001-0001-0001-000000000005',4200.00,20000.00,1500.00,24000.00,10000.00,3000.00,'2026-09-12 15:45:50','2026-09-12 15:45:50'),('ecffb135-e8e2-4d0d-90c3-e62650e05f48','3bd529e7-16ec-4e40-84fa-ca0306faa7f6',0.00,0.00,0.00,0.00,0.00,0.00,'2026-09-25 18:40:09','2026-09-25 18:40:09'),('f3719ad7-5cdd-4db8-964d-9454a5bae7eb','31f1bff9-432d-48ab-8e12-dcfc38d46069',0.00,0.00,0.00,0.00,0.00,0.00,'2026-09-17 23:42:50','2026-09-17 23:42:50'),('ff324544-0c0a-4fcd-bddd-dd4ce223c3c3','0eb668a3-bef8-41e8-a539-a005a1037075',0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-21 15:24:00','2026-10-21 15:24:00');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `added_to_carts`
--

DROP TABLE IF EXISTS `added_to_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `added_to_carts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `count` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_guest` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `added_to_carts`
--

LOCK TABLES `added_to_carts` WRITE;
/*!40000 ALTER TABLE `added_to_carts` DISABLE KEYS */;
INSERT INTO `added_to_carts` VALUES (1,'31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000005',1,'2026-09-19 01:20:07','2026-09-19 01:20:07',0),(2,'80a7a9e0-b360-11f1-ac87-ad5d03a4c734','svc-0001-0001-0001-000000000001',1,'2026-09-19 02:13:44','2026-09-19 02:13:44',1),(3,'0c5f5d80-b59f-11f1-8d05-a13989c3aa29','svc-0001-0001-0001-000000000001',1,'2026-09-21 22:50:22','2026-09-21 22:50:22',1),(4,'31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000001',38,'2026-09-22 18:00:29','2026-10-27 10:05:29',0),(5,'22e2cc70-b97f-11f1-8db5-ef537e278407','svc-0001-0001-0001-000000000001',1,'2026-09-26 20:58:13','2026-09-26 20:58:13',1),(6,'74546110-bbf3-11f1-896a-3509cd30c05d','svc-0001-0001-0001-000000000001',5,'2026-09-30 01:04:22','2026-09-30 02:25:51',1),(7,'51fe5050-bc9b-11f1-b9ca-33a8614b4b6f','svc-0001-0001-0001-000000000001',1,'2026-09-30 19:52:34','2026-09-30 19:52:34',1),(8,'22ba5cd0-bcb4-11f1-8309-9b372e7bac32','svc-0001-0001-0001-000000000001',1,'2026-09-30 22:52:21','2026-09-30 22:52:21',1),(9,'2c310670-bd80-11f1-b0e8-0dfb9e6318b8','svc-0001-0001-0001-000000000001',1,'2026-10-01 23:30:12','2026-10-01 23:30:12',1),(10,'cust-0001-0001-0001-000000000001','svc-0001-0001-0001-000000000002',4,'2026-10-02 18:29:00','2026-10-02 18:47:02',0),(11,'cust-0001-0001-0001-000000000001','svc-0001-0001-0001-000000000001',24,'2026-10-02 22:20:10','2026-10-27 16:02:53',0),(12,'31f1bff9-432d-48ab-8e12-dcfc38d46069','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5',4,'2026-10-05 03:47:34','2026-10-27 10:44:07',0),(13,'332c04b0-c30d-11f1-a097-2f27d9504379','svc-0001-0001-0001-000000000001',1,'2026-10-09 17:40:22','2026-10-09 17:40:22',1),(14,'5d22f46b-3fc5-4e24-ba89-9758a3ed2f55','svc-0001-0001-0001-000000000001',2,'2026-10-12 11:47:42','2026-10-12 12:16:49',1),(15,'18a2a9e0-c5fc-11f1-ac03-37b626f924f1','svc-0001-0001-0001-000000000001',8,'2026-10-12 12:24:05','2026-10-18 19:45:50',1),(16,'667d9bb6-672b-4c13-86eb-ba2c5bca6664','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5',1,'2026-10-13 16:44:47','2026-10-13 16:44:47',1),(17,'6338def3-8c22-4433-b00d-e515f661fd80','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5',1,'2026-10-13 17:43:59','2026-10-13 17:43:59',1),(18,'6265773a-d7cd-4fe1-8325-cf39cf3a2ea2','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:25:35','2026-10-14 10:25:35',1),(19,'44e6582d-b02a-4d6b-bfeb-5aa389e529cf','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:30:57','2026-10-14 10:30:57',1),(20,'1f11dec2-cc68-4c71-808e-7a7ce8e2373f','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:33:25','2026-10-14 10:33:25',1),(21,'d1ac4acb-2d40-444e-8d75-345ca36b30f4','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:34:42','2026-10-14 10:34:42',1),(22,'0b0a510f-61a2-49a8-af78-1e7a487938a4','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:36:56','2026-10-14 10:36:56',1),(23,'9b6c8600-396a-4606-88d9-a1e581d4ebbc','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:37:08','2026-10-14 10:37:08',1),(24,'f44a28fa-6eb1-4a0b-aa32-602d7be66896','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:37:45','2026-10-14 10:37:45',1),(25,'3508fb57-9ac6-4177-946a-334d23f19a13','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:38:11','2026-10-14 10:38:11',1),(26,'e417b5a9-e087-4a52-aaa0-6beb7df95559','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:38:42','2026-10-14 10:38:42',1),(27,'8fb5c7e3-da6a-477e-88ef-2003c4bcb790','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:39:20','2026-10-14 10:39:20',1),(28,'c05d2ca3-4881-4060-955b-c4e48793798b','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:43:50','2026-10-14 10:43:50',1),(29,'e1de451e-bad5-4468-801a-25346e13730a','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:47:01','2026-10-14 10:47:01',1),(30,'a367bd15-4c46-45a5-9e01-43d6d78f3976','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:51:20','2026-10-14 10:51:20',1),(31,'0b533d1a-2e20-4f76-bd35-6eb17bc845ed','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:54:21','2026-10-14 10:54:21',1),(32,'5502f459-26c8-466b-9e04-4c0dbf41445e','svc-0001-0001-0001-000000000001',1,'2026-10-14 10:55:48','2026-10-14 10:55:48',1),(33,'6e15f780-d0fe-11f1-8fc9-ad06dd1f1198','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5',2,'2026-10-26 14:41:39','2026-10-27 11:59:40',1),(34,'6e15f780-d0fe-11f1-8fc9-ad06dd1f1198','svc-0001-0001-0001-000000000001',4,'2026-10-26 18:18:40','2026-10-26 18:18:50',1),(35,'cust-0001-0001-0001-000000000001','513bce46-8576-413f-9809-96ba2fb8a5f2',6,'2026-10-27 14:50:26','2026-10-27 17:01:00',0),(36,'cust-0001-0001-0001-000000000001','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5',2,'2026-10-27 15:36:23','2026-10-27 17:28:05',0);
/*!40000 ALTER TABLE `added_to_carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addon_settings`
--

DROP TABLE IF EXISTS `addon_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addon_settings` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `test_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `settings_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'live',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `additional_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`),
  KEY `payment_settings_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addon_settings`
--

LOCK TABLES `addon_settings` WRITE;
/*!40000 ALTER TABLE `addon_settings` DISABLE KEYS */;
INSERT INTO `addon_settings` VALUES ('070c6bbd-d777-11ed-96f4-0c7a158e4469','twilio','{\"gateway\":\"twilio\",\"mode\":\"live\",\"status\":0,\"sid\":\"data\",\"messaging_service_sid\":\"data\",\"token\":\"data\",\"from\":\"data\",\"otp_template\":\"data\"}','{\"gateway\":\"twilio\",\"mode\":\"live\",\"status\":0,\"sid\":\"data\",\"messaging_service_sid\":\"data\",\"token\":\"data\",\"from\":\"data\",\"otp_template\":\"data\"}','sms_config','live',0,NULL,'2026-09-22 02:29:37',NULL),('070c766c-d777-11ed-96f4-0c7a158e4469','2factor','{\"gateway\":\"2factor\",\"mode\":\"live\",\"status\":1,\"api_key\":\"data\",\"otp_template\":\"OTP1\"}','{\"gateway\":\"2factor\",\"mode\":\"live\",\"status\":1,\"api_key\":\"data\",\"otp_template\":\"OTP1\"}','sms_config','live',1,NULL,'2026-09-22 02:29:37',NULL),('0d8a9308-d6a5-11ed-962c-0c7a158e4469','mercadopago','{\"gateway\":\"mercadopago\",\"mode\":\"test\",\"status\":\"0\",\"access_token\":\"data\",\"public_key\":\"data\"}','{\"gateway\":\"mercadopago\",\"mode\":\"test\",\"status\":\"0\",\"access_token\":\"data\",\"public_key\":\"data\"}','payment_config','test',0,NULL,'2023-08-27 11:57:11','{\"gateway_title\":null,\"gateway_image\":\"2023-04-12-64367be3b7b6a.png\"}'),('0d8a9e49-d6a5-11ed-962c-0c7a158e4469','liqpay','{\"gateway\":\"liqpay\",\"mode\":\"test\",\"status\":\"0\",\"private_key\":\"data\",\"public_key\":\"data\"}','{\"gateway\":\"liqpay\",\"mode\":\"test\",\"status\":\"0\",\"private_key\":\"data\",\"public_key\":\"data\"}','payment_config','test',0,NULL,'2023-08-12 06:32:31','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('101befdf-d44b-11ed-8564-0c7a158e4469','paypal','{\"gateway\":\"paypal\",\"mode\":\"test\",\"status\":\"0\",\"client_id\":\"data\",\"client_secret\":\"data\"}','{\"gateway\":\"paypal\",\"mode\":\"test\",\"status\":\"0\",\"client_id\":\"data\",\"client_secret\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 03:41:32','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('133d9647-cabb-11ed-8fec-0c7a158e4469','hyper_pay','{\"gateway\":\"hyper_pay\",\"mode\":\"test\",\"status\":\"0\",\"entity_id\":\"data\",\"access_code\":\"data\"}','{\"gateway\":\"hyper_pay\",\"mode\":\"test\",\"status\":\"0\",\"entity_id\":\"data\",\"access_code\":\"data\"}','payment_config','test',0,NULL,'2023-08-12 06:32:42','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('1821029f-d776-11ed-96f4-0c7a158e4469','msg91','{\"gateway\":\"msg91\",\"mode\":\"live\",\"status\":0,\"template_id\":\"data\",\"auth_key\":\"data\"}','{\"gateway\":\"msg91\",\"mode\":\"live\",\"status\":0,\"template_id\":\"data\",\"auth_key\":\"data\"}','sms_config','live',0,NULL,'2026-09-22 02:29:37',NULL),('18210f2b-d776-11ed-96f4-0c7a158e4469','nexmo','{\"gateway\":\"nexmo\",\"mode\":\"live\",\"status\":0,\"api_key\":\"\",\"api_secret\":\"\",\"token\":\"\",\"from\":\"\",\"otp_template\":\"\"}','{\"gateway\":\"nexmo\",\"mode\":\"live\",\"status\":0,\"api_key\":\"\",\"api_secret\":\"\",\"token\":\"\",\"from\":\"\",\"otp_template\":\"\"}','sms_config','live',0,NULL,'2026-09-22 02:29:37',NULL),('18fbb21f-d6ad-11ed-962c-0c7a158e4469','foloosi','{\"gateway\":\"foloosi\",\"mode\":\"test\",\"status\":\"0\",\"merchant_key\":\"data\"}','{\"gateway\":\"foloosi\",\"mode\":\"test\",\"status\":\"0\",\"merchant_key\":\"data\"}','payment_config','test',0,NULL,'2023-08-12 06:34:33','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('2767d142-d6a1-11ed-962c-0c7a158e4469','paytm','{\"gateway\":\"paytm\",\"mode\":\"test\",\"status\":\"0\",\"merchant_key\":\"data\",\"merchant_id\":\"data\",\"merchant_website_link\":\"data\"}','{\"gateway\":\"paytm\",\"mode\":\"test\",\"status\":\"0\",\"merchant_key\":\"data\",\"merchant_id\":\"data\",\"merchant_website_link\":\"data\"}','payment_config','test',0,NULL,'2023-08-22 06:30:55','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('3201d2e6-c937-11ed-a424-0c7a158e4469','amazon_pay','{\"gateway\":\"amazon_pay\",\"mode\":\"test\",\"status\":\"0\",\"pass_phrase\":\"data\",\"access_code\":\"data\",\"merchant_identifier\":\"data\"}','{\"gateway\":\"amazon_pay\",\"mode\":\"test\",\"status\":\"0\",\"pass_phrase\":\"data\",\"access_code\":\"data\",\"merchant_identifier\":\"data\"}','payment_config','test',0,NULL,'2023-08-12 06:36:07','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('4593b25c-d6a1-11ed-962c-0c7a158e4469','paytabs','{\"gateway\":\"paytabs\",\"mode\":\"test\",\"status\":\"0\",\"profile_id\":\"data\",\"server_key\":\"data\",\"base_url\":\"data\"}','{\"gateway\":\"paytabs\",\"mode\":\"test\",\"status\":\"0\",\"profile_id\":\"data\",\"server_key\":\"data\",\"base_url\":\"data\"}','payment_config','test',0,NULL,'2023-08-12 06:34:51','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('4e9b8dfb-e7d1-11ed-a559-0c7a158e4469','bkash','{\"gateway\":\"bkash\",\"mode\":\"test\",\"status\":\"0\",\"app_key\":\"data\",\"app_secret\":\"data\",\"username\":\"data\",\"password\":\"data\"}','{\"gateway\":\"bkash\",\"mode\":\"test\",\"status\":\"0\",\"app_key\":\"data\",\"app_secret\":\"data\",\"username\":\"data\",\"password\":\"data\"}','payment_config','test',0,NULL,'2023-08-12 06:39:42','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('544a24a4-c872-11ed-ac7a-0c7a158e4469','fatoorah','{\"gateway\":\"fatoorah\",\"mode\":\"test\",\"status\":\"0\",\"api_key\":\"data\"}','{\"gateway\":\"fatoorah\",\"mode\":\"test\",\"status\":\"0\",\"api_key\":\"data\"}','payment_config','test',0,NULL,'2023-08-12 06:36:24','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('58c1bc8a-d6ac-11ed-962c-0c7a158e4469','ccavenue','{\"gateway\":\"ccavenue\",\"mode\":\"test\",\"status\":\"0\",\"merchant_id\":\"data\",\"working_key\":\"data\",\"access_code\":\"data\"}','{\"gateway\":\"ccavenue\",\"mode\":\"test\",\"status\":\"0\",\"merchant_id\":\"data\",\"working_key\":\"data\",\"access_code\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 03:42:38','{\"gateway_title\":null,\"gateway_image\":\"2023-04-13-643783f01d386.png\"}'),('5e2d2ef9-d6ab-11ed-962c-0c7a158e4469','thawani','{\"gateway\":\"thawani\",\"mode\":\"test\",\"status\":\"0\",\"public_key\":\"data\",\"private_key\":\"data\"}','{\"gateway\":\"thawani\",\"mode\":\"test\",\"status\":\"0\",\"public_key\":\"data\",\"private_key\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:50:40','{\"gateway_title\":null,\"gateway_image\":\"2023-04-13-64378f9856f29.png\"}'),('60cc83cc-d5b9-11ed-b56f-0c7a158e4469','sixcash','{\"gateway\":\"sixcash\",\"mode\":\"test\",\"status\":\"0\",\"public_key\":\"data\",\"secret_key\":\"data\",\"merchant_number\":\"data\",\"base_url\":\"data\"}','{\"gateway\":\"sixcash\",\"mode\":\"test\",\"status\":\"0\",\"public_key\":\"data\",\"secret_key\":\"data\",\"merchant_number\":\"data\",\"base_url\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:16:17','{\"gateway_title\":null,\"gateway_image\":\"2023-04-12-6436774e77ff9.png\"}'),('68579846-d8e8-11ed-8249-0c7a158e4469','alphanet_sms','{\"gateway\":\"alphanet_sms\",\"mode\":\"live\",\"status\":0,\"api_key\":\"\",\"otp_template\":\"\"}','{\"gateway\":\"alphanet_sms\",\"mode\":\"live\",\"status\":0,\"api_key\":\"\",\"otp_template\":\"\"}','sms_config','live',0,NULL,NULL,NULL),('6857a2e8-d8e8-11ed-8249-0c7a158e4469','sms_to','{\"gateway\":\"sms_to\",\"mode\":\"live\",\"status\":0,\"api_key\":\"\",\"sender_id\":\"\",\"otp_template\":\"\"}','{\"gateway\":\"sms_to\",\"mode\":\"live\",\"status\":0,\"api_key\":\"\",\"sender_id\":\"\",\"otp_template\":\"\"}','sms_config','live',0,NULL,NULL,NULL),('74c30c00-d6a6-11ed-962c-0c7a158e4469','hubtel','{\"gateway\":\"hubtel\",\"mode\":\"test\",\"status\":\"0\",\"account_number\":\"data\",\"api_id\":\"data\",\"api_key\":\"data\"}','{\"gateway\":\"hubtel\",\"mode\":\"test\",\"status\":\"0\",\"account_number\":\"data\",\"api_id\":\"data\",\"api_key\":\"data\"}','payment_config','test',0,NULL,'2023-08-12 06:37:43','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('74e46b0a-d6aa-11ed-962c-0c7a158e4469','tap','{\"gateway\":\"tap\",\"mode\":\"test\",\"status\":\"0\",\"secret_key\":\"data\"}','{\"gateway\":\"tap\",\"mode\":\"test\",\"status\":\"0\",\"secret_key\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:50:09','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('761ca96c-d1eb-11ed-87ca-0c7a158e4469','swish','{\"gateway\":\"swish\",\"mode\":\"test\",\"status\":\"0\",\"number\":\"data\"}','{\"gateway\":\"swish\",\"mode\":\"test\",\"status\":\"0\",\"number\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:17:02','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('7b1c3c5f-d2bd-11ed-b485-0c7a158e4469','payfast','{\"gateway\":\"payfast\",\"mode\":\"test\",\"status\":\"0\",\"merchant_id\":\"data\",\"secured_key\":\"data\"}','{\"gateway\":\"payfast\",\"mode\":\"test\",\"status\":\"0\",\"merchant_id\":\"data\",\"secured_key\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:18:13','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('8592417b-d1d1-11ed-a984-0c7a158e4469','esewa','{\"gateway\":\"esewa\",\"mode\":\"test\",\"status\":\"0\",\"merchantCode\":\"data\"}','{\"gateway\":\"esewa\",\"mode\":\"test\",\"status\":\"0\",\"merchantCode\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:17:38','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('9162a1dc-cdf1-11ed-affe-0c7a158e4469','viva_wallet','{\"gateway\":\"viva_wallet\",\"mode\":\"test\",\"status\":\"0\",\"client_id\": \"\",\"client_secret\": \"\"}\n','{\"gateway\":\"viva_wallet\",\"mode\":\"test\",\"status\":\"0\",\"client_id\": \"\",\"client_secret\": \"\"}','payment_config','test',0,NULL,NULL,NULL),('998ccc62-d6a0-11ed-962c-0c7a158e4469','stripe','{\"gateway\":\"stripe\",\"mode\":\"live\",\"status\":\"1\",\"api_key\":\"data\",\"published_key\":\"data\"}','{\"gateway\":\"stripe\",\"mode\":\"live\",\"status\":\"1\",\"api_key\":\"data\",\"published_key\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:18:55','{\"gateway_title\":\"Stripe\",\"gateway_image\":null}'),('a3313755-c95d-11ed-b1db-0c7a158e4469','iyzi_pay','{\"gateway\":\"iyzi_pay\",\"mode\":\"test\",\"status\":\"0\",\"api_key\":\"data\",\"secret_key\":\"data\",\"base_url\":\"data\"}','{\"gateway\":\"iyzi_pay\",\"mode\":\"test\",\"status\":\"0\",\"api_key\":\"data\",\"secret_key\":\"data\",\"base_url\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:20:02','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('a76c8993-d299-11ed-b485-0c7a158e4469','momo','{\"gateway\":\"momo\",\"mode\":\"live\",\"status\":\"0\",\"api_key\":\"data\",\"api_user\":\"data\",\"subscription_key\":\"data\"}','{\"gateway\":\"momo\",\"mode\":\"live\",\"status\":\"0\",\"api_key\":\"data\",\"api_user\":\"data\",\"subscription_key\":\"data\"}','payment_config','live',0,NULL,'2023-08-30 04:19:28','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('a8608119-cc76-11ed-9bca-0c7a158e4469','moncash','{\"gateway\":\"moncash\",\"mode\":\"test\",\"status\":\"0\",\"client_id\":\"data\",\"secret_key\":\"data\"}','{\"gateway\":\"moncash\",\"mode\":\"test\",\"status\":\"0\",\"client_id\":\"data\",\"secret_key\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:47:34','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('ad5af1c1-d6a2-11ed-962c-0c7a158e4469','razor_pay','{\"gateway\":\"razor_pay\",\"mode\":\"live\",\"status\":\"1\",\"api_key\":\"data\",\"api_secret\":\"data\"}','{\"gateway\":\"razor_pay\",\"mode\":\"live\",\"status\":\"1\",\"api_key\":\"data\",\"api_secret\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:47:00','{\"gateway_title\":\"Razor pay\",\"gateway_image\":null}'),('ad5b02a0-d6a2-11ed-962c-0c7a158e4469','senang_pay','{\"gateway\":\"senang_pay\",\"mode\":\"live\",\"status\":\"0\",\"callback_url\":\"https:\\/\\/url\\/return-senang-pay\",\"secret_key\":\"data\",\"merchant_id\":\"data\"}','{\"gateway\":\"senang_pay\",\"mode\":\"live\",\"status\":\"0\",\"callback_url\":\"https:\\/\\/url\\/return-senang-pay\",\"secret_key\":\"data\",\"merchant_id\":\"data\"}','payment_config','test',0,NULL,'2023-08-27 09:58:57','{\"gateway_title\":\"Senang pay\",\"gateway_image\":null}'),('b6c333f6-d8e9-11ed-8249-0c7a158e4469','akandit_sms','{\"gateway\":\"akandit_sms\",\"mode\":\"live\",\"status\":0,\"username\":\"\",\"password\":\"\",\"otp_template\":\"\"}','{\"gateway\":\"akandit_sms\",\"mode\":\"live\",\"status\":0,\"username\":\"\",\"password\":\"\",\"otp_template\":\"\"}','sms_config','live',0,NULL,NULL,NULL),('b6c33c87-d8e9-11ed-8249-0c7a158e4469','global_sms','{\"gateway\":\"global_sms\",\"mode\":\"live\",\"status\":0,\"user_name\":\"\",\"password\":\"\",\"from\":\"\",\"otp_template\":\"\"}','{\"gateway\":\"global_sms\",\"mode\":\"live\",\"status\":0,\"user_name\":\"\",\"password\":\"\",\"from\":\"\",\"otp_template\":\"\"}','sms_config','live',0,NULL,NULL,NULL),('b8992bd4-d6a0-11ed-962c-0c7a158e4469','paymob_accept','{\"gateway\":\"paymob_accept\",\"mode\":\"live\",\"status\":\"0\",\"api_key\":\"\",\"iframe_id\":\"\",\"integration_id\":\"\", \"hmac\": \"\"}','{\"gateway\":\"paymob_accept\",\"mode\":\"test\",\"status\":\"0\",\"api_key\":\"\",\"iframe_id\":\"\",\"integration_id\":\"\", \"hmac\": \"\"}','payment_config','test',0,NULL,NULL,NULL),('c41c0dcd-d119-11ed-9f67-0c7a158e4469','maxicash','{\"gateway\":\"maxicash\",\"mode\":\"test\",\"status\":\"0\",\"merchantId\":\"data\",\"merchantPassword\":\"data\"}','{\"gateway\":\"maxicash\",\"mode\":\"test\",\"status\":\"0\",\"merchantId\":\"data\",\"merchantPassword\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:49:15','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('c9249d17-cd60-11ed-b879-0c7a158e4469','pvit','{\"gateway\":\"pvit\",\"mode\":\"test\",\"status\":\"0\",\"mc_tel_merchant\": \"\",\"access_token\": \"\", \"mc_merchant_code\": \"\"}','{\"gateway\":\"pvit\",\"mode\":\"test\",\"status\":\"0\",\"mc_tel_merchant\": \"\",\"access_token\": \"\", \"mc_merchant_code\": \"\"}','payment_config','test',0,NULL,NULL,NULL),('cb0081ce-d775-11ed-96f4-0c7a158e4469','releans','{\"gateway\":\"releans\",\"mode\":\"live\",\"status\":0,\"api_key\":\"\",\"from\":\"\",\"otp_template\":\"\"}','{\"gateway\":\"releans\",\"mode\":\"live\",\"status\":0,\"api_key\":\"\",\"from\":\"\",\"otp_template\":\"\"}','sms_config','live',0,NULL,'2026-09-22 02:29:37',NULL),('d4f3f5f1-d6a0-11ed-962c-0c7a158e4469','flutterwave','{\"gateway\":\"flutterwave\",\"mode\":\"live\",\"status\":\"1\",\"secret_key\":\"data\",\"public_key\":\"data\",\"hash\":\"data\"}','{\"gateway\":\"flutterwave\",\"mode\":\"live\",\"status\":\"1\",\"secret_key\":\"data\",\"public_key\":\"data\",\"hash\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:41:03','{\"gateway_title\":\"Flutterwave\",\"gateway_image\":null}'),('d822f1a5-c864-11ed-ac7a-0c7a158e4469','paystack','{\"gateway\":\"paystack\",\"mode\":\"live\",\"status\":\"1\",\"callback_url\":\"https:\\/\\/api.paystack.co\",\"public_key\":\"data\",\"secret_key\":\"data\",\"merchant_email\":\"data\"}','{\"gateway\":\"paystack\",\"mode\":\"live\",\"status\":\"1\",\"callback_url\":\"https:\\/\\/api.paystack.co\",\"public_key\":\"data\",\"secret_key\":\"data\",\"merchant_email\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 04:20:45','{\"gateway_title\":\"Paystack\",\"gateway_image\":null}'),('daec8d59-c893-11ed-ac7a-0c7a158e4469','xendit','{\"gateway\":\"xendit\",\"mode\":\"test\",\"status\":\"0\",\"api_key\":\"data\"}','{\"gateway\":\"xendit\",\"mode\":\"test\",\"status\":\"0\",\"api_key\":\"data\"}','payment_config','test',0,NULL,'2023-08-12 06:35:46','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('dc0f5fc9-d6a5-11ed-962c-0c7a158e4469','worldpay','{\"gateway\":\"worldpay\",\"mode\":\"test\",\"status\":\"0\",\"OrgUnitId\":\"data\",\"jwt_issuer\":\"data\",\"mac\":\"data\",\"merchantCode\":\"data\",\"xml_password\":\"data\"}','{\"gateway\":\"worldpay\",\"mode\":\"test\",\"status\":\"0\",\"OrgUnitId\":\"data\",\"jwt_issuer\":\"data\",\"mac\":\"data\",\"merchantCode\":\"data\",\"xml_password\":\"data\"}','payment_config','test',0,NULL,'2023-08-12 06:35:26','{\"gateway_title\":null,\"gateway_image\":\"\"}'),('e0450278-d8eb-11ed-8249-0c7a158e4469','signal_wire','{\"gateway\":\"signal_wire\",\"mode\":\"live\",\"status\":0,\"project_id\":\"\",\"token\":\"\",\"space_url\":\"\",\"from\":\"\",\"otp_template\":\"\"}','{\"gateway\":\"signal_wire\",\"mode\":\"live\",\"status\":0,\"project_id\":\"\",\"token\":\"\",\"space_url\":\"\",\"from\":\"\",\"otp_template\":\"\"}','sms_config','live',0,NULL,NULL,NULL),('e0450b40-d8eb-11ed-8249-0c7a158e4469','paradox','{\"gateway\":\"paradox\",\"mode\":\"live\",\"status\":0,\"api_key\":\"\"}','{\"gateway\":\"paradox\",\"mode\":\"live\",\"status\":0,\"api_key\":\"\"}','sms_config','live',0,NULL,NULL,NULL),('ea346efe-cdda-11ed-affe-0c7a158e4469','ssl_commerz','{\"gateway\":\"ssl_commerz\",\"mode\":\"live\",\"status\":\"1\",\"store_id\":\"data\",\"store_password\":\"data\"}','{\"gateway\":\"ssl_commerz\",\"mode\":\"live\",\"status\":\"1\",\"store_id\":\"data\",\"store_password\":\"data\"}','payment_config','test',0,NULL,'2023-08-30 03:43:49','{\"gateway_title\":\"Ssl commerz\",\"gateway_image\":null}'),('eed88336-d8ec-11ed-8249-0c7a158e4469','hubtel','{\"gateway\":\"hubtel\",\"mode\":\"live\",\"status\":0,\"sender_id\":\"\",\"client_id\":\"\",\"client_secret\":\"\",\"otp_template\":\"\"}','{\"gateway\":\"hubtel\",\"mode\":\"live\",\"status\":0,\"sender_id\":\"\",\"client_id\":\"\",\"client_secret\":\"\",\"otp_template\":\"\"}','sms_config','live',0,NULL,NULL,NULL),('f149c546-d8ea-11ed-8249-0c7a158e4469','viatech','{\"gateway\":\"viatech\",\"mode\":\"live\",\"status\":0,\"api_url\":\"\",\"api_key\":\"\",\"sender_id\":\"\",\"otp_template\":\"\"}','{\"gateway\":\"viatech\",\"mode\":\"live\",\"status\":0,\"api_url\":\"\",\"api_key\":\"\",\"sender_id\":\"\",\"otp_template\":\"\"}','sms_config','live',0,NULL,NULL,NULL),('f149cd9c-d8ea-11ed-8249-0c7a158e4469','019_sms','{\"gateway\":\"019_sms\",\"mode\":\"live\",\"status\":0,\"password\":\"\",\"username\":\"\",\"username_for_token\":\"\",\"sender\":\"\",\"otp_template\":\"\"}','{\"gateway\":\"019_sms\",\"mode\":\"live\",\"status\":0,\"password\":\"\",\"username\":\"\",\"username_for_token\":\"\",\"sender\":\"\",\"otp_template\":\"\"}','sms_config','live',1,NULL,NULL,NULL),('f3bc3756-c542-11f1-8827-1601b0e38757','textbee','{\"status\":0,\"api_url\":\"\",\"api_key\":\"\",\"device_id\":\"\",\"otp_template\":\"Your verification OTP is: #OTP#\"}','{\"status\":0,\"api_url\":\"\",\"api_key\":\"\",\"device_id\":\"\",\"otp_template\":\"Your verification OTP is: #OTP#\"}','sms_config','live',0,'2026-10-11 07:11:17','2026-10-11 07:11:17',NULL);
/*!40000 ALTER TABLE `addon_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advertisement_attachments`
--

DROP TABLE IF EXISTS `advertisement_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertisement_attachments` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `advertisement_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_extension_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'promotional_video, provider_profile_image, provider_cover_image',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertisement_attachments`
--

LOCK TABLES `advertisement_attachments` WRITE;
/*!40000 ALTER TABLE `advertisement_attachments` DISABLE KEYS */;
INSERT INTO `advertisement_attachments` VALUES ('19be3bf1-f0da-4a2c-a2c8-78cdcfbadca7','61fd0824-59e3-4045-98e4-635658f25b0d','jpeg','2026-09-22-6ab255ef16830.jpeg','provider_profile_image','2026-09-22 23:18:23','2026-09-22 23:18:23'),('77f46c23-03c9-482a-9072-24773267310e','61fd0824-59e3-4045-98e4-635658f25b0d','webp','2026-09-22-6ab255efb30c1.webp','provider_cover_image','2026-09-22 23:18:24','2026-09-22 23:18:24');
/*!40000 ALTER TABLE `advertisement_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advertisement_notes`
--

DROP TABLE IF EXISTS `advertisement_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertisement_notes` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `advertisement_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'paused, denied',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertisement_notes`
--

LOCK TABLES `advertisement_notes` WRITE;
/*!40000 ALTER TABLE `advertisement_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `advertisement_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advertisement_settings`
--

DROP TABLE IF EXISTS `advertisement_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertisement_settings` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `advertisement_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertisement_settings`
--

LOCK TABLES `advertisement_settings` WRITE;
/*!40000 ALTER TABLE `advertisement_settings` DISABLE KEYS */;
INSERT INTO `advertisement_settings` VALUES ('a6c212e2-ec71-4b3d-a71c-d56b67353af8','61fd0824-59e3-4045-98e4-635658f25b0d','rating','1','2026-09-22 23:18:24','2026-09-22 23:18:24'),('fd806b0d-43f1-4750-bcea-7870962de166','61fd0824-59e3-4045-98e4-635658f25b0d','review','1','2026-09-22 23:18:24','2026-09-22 23:18:24');
/*!40000 ALTER TABLE `advertisement_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advertisements`
--

DROP TABLE IF EXISTS `advertisements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertisements` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `readable_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'video_promotion, profile_promotion',
  `is_paid` tinyint NOT NULL DEFAULT '0',
  `start_date` datetime NOT NULL DEFAULT '2024-05-20 20:36:19',
  `end_date` datetime NOT NULL DEFAULT '2024-05-20 20:36:19',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending' COMMENT 'pending, approved, running, expired, denied, paused, canceled',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_updated` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertisements`
--

LOCK TABLES `advertisements` WRITE;
/*!40000 ALTER TABLE `advertisements` DISABLE KEYS */;
INSERT INTO `advertisements` VALUES ('61fd0824-59e3-4045-98e4-635658f25b0d','6116397594','hii','hii','prvd-0001-0001-0001-000000000001',NULL,'profile_promotion',0,'2026-09-22 00:00:00','2026-10-02 23:59:59','approved','2026-09-22 23:18:23','2026-09-22 23:19:47',0);
/*!40000 ALTER TABLE `advertisements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_setting_logs`
--

DROP TABLE IF EXISTS `ai_setting_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_setting_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `seller_id` bigint unsigned NOT NULL,
  `total_generated_count` int NOT NULL DEFAULT '0',
  `total_image_generated_count` int NOT NULL DEFAULT '0',
  `limit_at_time` int DEFAULT NULL,
  `section_usage` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ai_setting_logs_seller_id_index` (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_setting_logs`
--

LOCK TABLES `ai_setting_logs` WRITE;
/*!40000 ALTER TABLE `ai_setting_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_setting_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_settings`
--

DROP TABLE IF EXISTS `ai_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ai_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_limit` int NOT NULL DEFAULT '0',
  `image_upload_limit` int NOT NULL DEFAULT '0',
  `settings` json DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_settings`
--

LOCK TABLES `ai_settings` WRITE;
/*!40000 ALTER TABLE `ai_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_details`
--

DROP TABLE IF EXISTS `bank_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_details` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acc_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acc_holder_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `routing_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_details`
--

LOCK TABLES `bank_details` WRITE;
/*!40000 ALTER TABLE `bank_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banners` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect_link` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banners`
--

LOCK TABLES `banners` WRITE;
/*!40000 ALTER TABLE `banners` DISABLE KEYS */;
INSERT INTO `banners` VALUES ('af3af78f-1db7-4de4-9208-27679ceecf7d','2','slider',NULL,NULL,'2026-09-25-6ab6157977583.png',1,'2026-09-25 19:32:27','2026-09-25 19:32:27'),('d137ee4f-c27b-45b1-8b0c-eaefc343ea95','3','slider',NULL,NULL,'2026-09-25-6ab6158ed9354.png',1,'2026-09-25 19:32:49','2026-09-25 19:32:49');
/*!40000 ALTER TABLE `banners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bonuses`
--

DROP TABLE IF EXISTS `bonuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bonuses` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bonus_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bonus_amount_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bonus_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `minimum_add_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `maximum_bonus_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bonuses`
--

LOCK TABLES `bonuses` WRITE;
/*!40000 ALTER TABLE `bonuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `bonuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_additional_information`
--

DROP TABLE IF EXISTS `booking_additional_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_additional_information` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_additional_information`
--

LOCK TABLES `booking_additional_information` WRITE;
/*!40000 ALTER TABLE `booking_additional_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_additional_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_details`
--

DROP TABLE IF EXISTS `booking_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_cost` decimal(24,3) NOT NULL DEFAULT '0.000',
  `quantity` int NOT NULL DEFAULT '1',
  `discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `tax_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_cost` decimal(24,3) NOT NULL DEFAULT '0.000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `campaign_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `overall_coupon_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`id`),
  KEY `booking_details_booking_id_index` (`booking_id`),
  KEY `booking_details_service_id_index` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_details`
--

LOCK TABLES `booking_details` WRITE;
/*!40000 ALTER TABLE `booking_details` DISABLE KEYS */;
INSERT INTO `booking_details` VALUES (1,'bkg-0001-0001-0001-000000000001','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',2499.000,1,0.000,449.820,2499.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(2,'bkg-0001-0001-0001-000000000002','svc-0001-0001-0001-000000000009','Ceiling Fan Installation','Standard-Fan',399.000,1,0.000,71.820,399.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(3,'bkg-0001-0001-0001-000000000003','svc-0001-0001-0001-000000000014','AC General Servicing','Split-AC-Service',499.000,1,0.000,89.820,499.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(4,'bkg-0001-0001-0001-000000000004','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','1-BHK',1499.000,1,200.000,269.820,1299.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,200.000),(5,'bkg-0001-0001-0001-000000000005','svc-0001-0001-0001-000000000005','Pipe Leakage Repair','Major-Repair',899.000,1,0.000,161.820,899.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(6,'bkg-0001-0001-0001-000000000006','svc-0001-0001-0001-000000000013','AC Gas Refill and Charging','R32-Gas',1999.000,1,0.000,359.820,1999.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(7,'bkg-0001-0001-0001-000000000007','svc-0001-0001-0001-000000000005','Pipe Leakage Repair','Minor-Fix',299.000,1,0.000,53.820,299.000,'2026-09-12 15:45:55','2026-10-19 12:48:06',0.000,0.000),(8,'bkg-0001-0001-0001-000000000008','svc-0001-0001-0001-000000000012','AC Installation Split and Window','Split-AC-1.5-Ton',1499.000,1,0.000,269.820,1499.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(9,'bkg-0001-0001-0001-000000000009','svc-0001-0001-0001-000000000003','Sofa and Upholstery Cleaning','3-Seater-Sofa',799.000,1,0.000,143.820,799.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(10,'bkg-0001-0001-0001-000000000010','svc-0001-0001-0001-000000000014','AC General Servicing','Split-AC-Service',499.000,1,0.000,89.820,499.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(11,'bkg-0001-0001-0001-000000000015','svc-0001-0001-0001-000000000007','Tap and Faucet Repair','Repair-Only',199.000,1,0.000,35.820,199.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(12,'bkg-0001-0001-0001-000000000016','svc-0001-0001-0001-000000000013','AC Gas Refill and Charging','R22-Gas',1200.000,1,0.000,216.000,1200.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(13,'bkg-0001-0001-0001-000000000017','svc-0001-0001-0001-000000000007','Tap and Faucet Repair','Repair-New-Faucet',699.000,1,100.000,125.820,599.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,100.000),(14,'bkg-0001-0001-0001-000000000018','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','3-BHK',3499.000,1,0.000,629.820,3499.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(15,'bkg-0001-0001-0001-000000000019','svc-0001-0001-0001-000000000010','Switch and Socket Replacement','switch-socket-repair',299.000,1,0.000,53.820,299.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,0.000),(16,'bkg-0001-0001-0001-000000000020','svc-0001-0001-0001-000000000015','Pest Control Service','2-BHK-Standard',2799.000,1,300.000,503.820,2499.000,'2026-09-12 15:45:55','2026-09-12 15:45:55',0.000,300.000),(17,'6fe2ffa1-c8c4-4575-85a8-f2e3f1bfb1ca','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',2499.000,1,0.000,449.820,2948.820,'2026-09-22 18:25:21','2026-09-22 18:25:21',0.000,0.000),(18,'0978aaa3-bde3-4438-a245-b9c7dbebfd62','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-09-26 20:59:22','2026-09-26 20:59:22',0.000,0.000),(19,'3304fbdd-50cd-4f25-b89a-b58f5fbc3a15','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',2499.000,1,0.000,449.820,2948.820,'2026-09-29 02:08:12','2026-09-29 02:08:12',0.000,0.000),(20,'266d8d8f-6d7e-4a24-b55b-cc1a75a950f0','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',2499.000,1,0.000,449.820,2948.820,'2026-09-30 22:57:06','2026-09-30 22:57:06',0.000,0.000),(41,'793bc200-73cc-4d88-b168-8fbc6d014840','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-07 17:11:03','2026-10-07 17:11:03',0.000,0.000),(42,'b88bab80-6999-4fb8-975d-2c8f0694ccb8','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','3-BHK',1110.000,1,0.000,199.800,1309.800,'2026-10-09 17:47:49','2026-10-09 17:47:49',0.000,0.000),(43,'3340ac66-4cb5-47fd-abbb-945c7265642a','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5','Door Work','new',10.000,1,0.000,0.000,10.000,'2026-10-12 10:41:40','2026-10-12 10:41:40',0.000,0.000),(44,'7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-12 10:45:44','2026-10-12 10:45:44',0.000,0.000),(47,'92960767-886f-457e-9ca1-dd880dfed02c','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-12 14:12:51','2026-10-12 14:12:51',0.000,0.000),(48,'3164cc17-5142-4fec-9ad8-0d8630191ca6','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-12 16:32:55','2026-10-12 16:32:55',0.000,0.000),(49,'9b60556f-f7bf-442a-bd28-812410ad43ab','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,0.000,1101.000,'2026-10-12 18:15:29','2026-10-12 18:15:29',0.000,0.000),(50,'de1f2f03-b0e8-4f30-9ea5-1347f479359e','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,0.000,1101.000,'2026-10-13 10:04:05','2026-10-13 10:04:05',0.000,0.000),(51,'1ad4108d-50b7-4087-ae27-3a8c959c4247','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-13 18:06:00','2026-10-13 18:06:00',0.000,0.000),(52,'045e05ee-79de-4f7b-8f9e-5d3e81b159b9','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:25:36','2026-10-14 10:25:36',0.000,0.000),(53,'7f3678b6-f9f3-42e5-a46d-5ad9ea81a162','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:30:58','2026-10-14 10:30:58',0.000,0.000),(54,'5f45385f-3e6e-433b-b1de-2f4b56143e03','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:33:25','2026-10-14 10:33:25',0.000,0.000),(55,'bac3a7c1-d2b8-4e37-9901-61a4e8216c9a','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:34:43','2026-10-14 10:34:43',0.000,0.000),(56,'bc86c09e-6a09-4bc8-8018-0b0528d3fcd4','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:36:56','2026-10-14 10:36:56',0.000,0.000),(57,'d5925f5c-5bdb-4d34-895f-6cac40a9be7f','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:37:08','2026-10-14 10:37:08',0.000,0.000),(58,'f7343c12-59cf-4ed2-8412-b100ecd83050','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:37:45','2026-10-14 10:37:45',0.000,0.000),(59,'e90e21ac-aed6-45d4-b9b4-b4240f1da37d','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:38:11','2026-10-14 10:38:11',0.000,0.000),(60,'0d5bfd23-a8c9-4793-8bc4-40535c29c9ee','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:38:42','2026-10-14 10:38:42',0.000,0.000),(61,'4eb7f298-418b-45cd-b3d9-bb05329fbf50','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:39:21','2026-10-14 10:39:21',0.000,0.000),(62,'0f68ead5-e564-46ee-8eab-3acded861f93','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:43:50','2026-10-14 10:43:50',0.000,0.000),(63,'09aa1dcb-32ec-4230-9ef4-c71fed46410e','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:47:02','2026-10-14 10:47:02',0.000,0.000),(64,'a7664860-8d72-4543-99ac-a449b68f9249','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:51:20','2026-10-14 10:51:20',0.000,0.000),(65,'64b578a9-e217-4317-81db-6cce9704ba6a','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:54:22','2026-10-14 10:54:22',0.000,0.000),(66,'cb068c74-9139-43a0-bd6b-19f297d537b7','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 10:55:49','2026-10-14 10:55:49',0.000,0.000),(67,'d23f021f-76e8-46cb-886b-e629552fe499','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 14:30:03','2026-10-14 14:30:03',0.000,0.000),(68,'d662278a-b37c-4b0c-adae-01ce044bc49d','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 16:41:46','2026-10-14 16:41:46',0.000,0.000),(69,'ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 17:34:37','2026-10-14 17:34:37',0.000,0.000),(70,'b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-14 18:19:13','2026-10-14 18:19:13',0.000,0.000),(71,'44b8a2b5-a07e-407d-864c-ad75d6bd7eb9','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-15 10:17:10','2026-10-15 10:17:10',0.000,0.000),(72,'dbca7d1b-7afb-4bed-9bdc-bae32d87c53c','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','4-BHK',1011.000,1,0.000,181.980,1192.980,'2026-10-15 10:50:41','2026-10-15 10:50:41',0.000,0.000),(73,'b3b5a47b-29dd-4dd3-babd-7397e8935a44','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-15 11:51:10','2026-10-15 11:51:10',0.000,0.000),(74,'e3948edf-bb94-4b2e-aae3-347ea82ddeb3','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-15 12:16:21','2026-10-15 12:16:21',0.000,0.000),(75,'c288a76f-082e-41b1-8bd6-f21ae91729b0','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-15 12:36:34','2026-10-15 12:36:34',0.000,0.000),(76,'f85b4243-7dbe-4b19-b044-ef1c99b7abb6','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-15 14:49:45','2026-10-15 14:49:45',0.000,0.000),(77,'68dc44cd-8dda-4e86-be4c-b8c228da89b4','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-15 15:48:48','2026-10-15 15:48:48',0.000,0.000),(78,'ee5de3cc-d7a0-4932-8320-c564d8dae66b','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-15 17:34:28','2026-10-15 17:34:28',0.000,0.000),(79,'2f018e52-fdb8-4f46-9553-60eea6807e89','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','3-BHK',1110.000,1,0.000,199.800,1309.800,'2026-10-15 17:49:29','2026-10-15 17:49:29',0.000,0.000),(80,'0123f3e2-f818-46c7-aca2-d229fb029299','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-16 09:50:26','2026-10-16 09:50:26',0.000,0.000),(81,'d9ac8ce7-35be-45b6-a83a-dcee2fc0aaf2','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-18 20:06:51','2026-10-18 20:06:51',0.000,0.000),(82,'03009368-b8e9-4122-845c-35058d02a231','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-18 20:12:55','2026-10-18 20:12:55',0.000,0.000),(83,'2e667db0-22d4-4f2c-a3f3-fd6edc0ac096','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,1,0.000,198.180,1299.180,'2026-10-18 20:15:49','2026-10-18 20:15:49',0.000,0.000),(84,'6e5eebe2-d583-4ff4-a801-198228365253','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',1101.000,2,0.000,0.000,2202.000,'2026-10-18 20:50:30','2026-10-19 13:18:05',0.000,0.000),(90,'1a71cd0f-8b05-4b13-9f7c-ae84a2cf7bff','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','3-BHK',3499.000,1,0.000,629.820,4128.820,'2026-10-27 12:21:04','2026-10-27 12:21:04',0.000,0.000),(91,'b5814625-ca70-4c33-9549-46fd4e0fd52e','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',2499.000,1,0.000,449.820,2948.820,'2026-10-27 12:28:32','2026-10-27 12:28:32',0.000,0.000),(92,'e3421053-1718-494d-b96f-ae231ced63af','513bce46-8576-413f-9809-96ba2fb8a5f2','jass','1',10.000,1,0.000,0.000,10.000,'2026-10-27 14:51:20','2026-10-27 14:51:20',0.000,0.000),(93,'4a186688-74fb-45be-86ba-5ac62d7ea342','513bce46-8576-413f-9809-96ba2fb8a5f2','jass','1',10.000,1,0.000,0.000,10.000,'2026-10-27 15:20:56','2026-10-27 15:20:56',0.000,0.000),(94,'7f7da454-3ef2-413f-9c1d-99f868008536','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5','Door Work','new',1110.000,1,0.000,0.000,1110.000,'2026-10-27 15:37:21','2026-10-27 15:37:21',0.000,0.000),(95,'32982b71-73c9-490f-8ad3-dc9733458339','513bce46-8576-413f-9809-96ba2fb8a5f2','jass','1',10.000,1,0.000,0.000,10.000,'2026-10-27 15:38:32','2026-10-27 15:38:32',0.000,0.000),(96,'eb4fefb9-aa35-42ad-bb9d-0411fd4dde39','513bce46-8576-413f-9809-96ba2fb8a5f2','jass','1',10.000,1,0.000,0.000,10.000,'2026-10-27 15:47:40','2026-10-27 15:47:40',0.000,0.000),(97,'b6242049-0682-4e0d-982f-c9de3f4e7ef9','513bce46-8576-413f-9809-96ba2fb8a5f2','jass','1',10.000,1,0.000,0.000,10.000,'2026-10-27 15:54:17','2026-10-27 15:54:17',0.000,0.000),(98,'2033219c-7431-4ac6-a51f-264abfed80eb','svc-0001-0001-0001-000000000001','Full Home Deep Cleaning','2-BHK',2499.000,1,0.000,449.820,2948.820,'2026-10-27 16:03:04','2026-10-27 16:03:04',0.000,0.000),(99,'031a9851-64e3-4561-a94d-cc0b0070638d','513bce46-8576-413f-9809-96ba2fb8a5f2','jass','1',10.000,1,0.000,0.000,10.000,'2026-10-27 17:01:17','2026-10-27 17:01:17',0.000,0.000),(100,'e27c6207-9e5d-4549-b181-73451ad964d4','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5','Door Work','new',1110.000,1,0.000,0.000,1110.000,'2026-10-27 17:28:31','2026-10-27 17:28:31',0.000,0.000);
/*!40000 ALTER TABLE `booking_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_details_amounts`
--

DROP TABLE IF EXISTS `booking_details_amounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_details_amounts` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_details_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_unit_cost` decimal(24,2) NOT NULL DEFAULT '0.00',
  `service_quantity` int NOT NULL DEFAULT '0',
  `service_tax` decimal(24,2) NOT NULL DEFAULT '0.00',
  `discount_by_admin` decimal(24,2) NOT NULL DEFAULT '0.00',
  `discount_by_provider` decimal(24,2) NOT NULL DEFAULT '0.00',
  `coupon_discount_by_admin` decimal(24,2) NOT NULL DEFAULT '0.00',
  `coupon_discount_by_provider` decimal(24,2) NOT NULL DEFAULT '0.00',
  `campaign_discount_by_admin` decimal(24,2) NOT NULL DEFAULT '0.00',
  `campaign_discount_by_provider` decimal(24,2) NOT NULL DEFAULT '0.00',
  `admin_commission` decimal(24,2) NOT NULL DEFAULT '0.00',
  `provider_commission` decimal(24,2) NOT NULL DEFAULT '0.00',
  `provider_earning` decimal(24,2) NOT NULL DEFAULT '0.00',
  `serviceman_earning` decimal(24,2) NOT NULL DEFAULT '0.00',
  `platform_fee` decimal(24,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `booking_repeat_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_repeat_details_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_details_amounts`
--

LOCK TABLES `booking_details_amounts` WRITE;
/*!40000 ALTER TABLE `booking_details_amounts` DISABLE KEYS */;
INSERT INTO `booking_details_amounts` VALUES ('02d894c4-82a0-4f3e-b5f8-432d60fd9270','62','0f68ead5-e564-46ee-8eab-3acded861f93',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:43:50','2026-10-14 10:43:50',NULL,NULL),('071491f1-27fe-4312-a5b3-09390e123bfd','99','031a9851-64e3-4561-a94d-cc0b0070638d',10.00,1,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 17:01:17','2026-10-27 17:01:17',NULL,NULL),('0bcc1eb6-77bb-455c-8fc4-f344b2cd006a','18','0978aaa3-bde3-4438-a245-b9c7dbebfd62',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1299.18,1101.00,0.00,'2026-09-26 20:59:22','2026-10-07 14:32:40',NULL,NULL),('1035836f-3f40-48f7-bd56-a7d5aa1235c6','100','e27c6207-9e5d-4549-b181-73451ad964d4',1110.00,1,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 17:28:31','2026-10-27 17:28:31',NULL,NULL),('12962f6e-6b58-4c04-b163-71241bc26080','56','bc86c09e-6a09-4bc8-8018-0b0528d3fcd4',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:36:56','2026-10-14 10:36:56',NULL,NULL),('179a7317-d18f-4623-84ec-9dea714c34da','83','2e667db0-22d4-4f2c-a3f3-fd6edc0ac096',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1299.18,1101.00,0.00,'2026-10-18 20:15:49','2026-10-18 20:19:54',NULL,NULL),('19681455-d9b8-497a-a673-b89fd2a5d5a0','98','2033219c-7431-4ac6-a51f-264abfed80eb',2499.00,1,449.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 16:03:04','2026-10-27 16:03:04',NULL,NULL),('1cf3614f-0d79-4da6-93fe-3710fee2511a','73','b3b5a47b-29dd-4dd3-babd-7397e8935a44',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-15 11:51:10','2026-10-15 11:51:10',NULL,NULL),('1d7acd34-ced0-4ad9-9d4f-512a693497eb','84','6e5eebe2-d583-4ff4-a801-198228365253',1101.00,2,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-18 20:50:30','2026-10-19 13:18:05',NULL,NULL),('2239166d-f751-4f46-a407-c8c3098dde5b','19','3304fbdd-50cd-4f25-b89a-b58f5fbc3a15',2499.00,1,449.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-09-29 02:08:12','2026-09-29 02:08:12',NULL,NULL),('242443f0-fa79-466c-a179-34a0f4043011','25','22b0c62f-5eb2-44c7-9390-7278813ce022',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-02 22:20:31','2026-10-02 22:20:31',NULL,NULL),('27f3d7d2-0ce3-4669-8230-080ce1a67c10','81','d9ac8ce7-35be-45b6-a83a-dcee2fc0aaf2',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-18 20:06:51','2026-10-18 20:06:51',NULL,NULL),('32259f6f-bc32-4d66-8e6b-e5bfadb44e15','65','64b578a9-e217-4317-81db-6cce9704ba6a',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:54:22','2026-10-14 10:54:22',NULL,NULL),('33a6ab54-e99c-4f3e-9299-3fc60c36c12b','24','7f4ba9ec-0cf5-4671-b725-89160062b3f2',599.00,1,107.82,0.00,0.00,0.00,0.00,0.00,0.00,89.85,0.00,616.97,0.00,0.00,'2026-10-02 18:47:06','2026-10-02 19:09:20',NULL,NULL),('340e09a3-12f5-4cf0-8718-699d7422c015','44','7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1748.18,1550.00,0.00,'2026-10-12 10:45:44','2026-10-16 10:39:57',NULL,NULL),('3549a496-3772-46ed-9e10-f7ca3d94c136','76','f85b4243-7dbe-4b19-b044-ef1c99b7abb6',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-15 14:49:45','2026-10-15 14:49:45',NULL,NULL),('3a6923e4-29d1-4439-affe-c69e9f83e5c8','75','c288a76f-082e-41b1-8bd6-f21ae91729b0',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-15 12:36:34','2026-10-15 12:36:34',NULL,NULL),('3b7e394c-0ba5-4972-8e23-d0f323005f24','72','dbca7d1b-7afb-4bed-9bdc-bae32d87c53c',1011.00,1,181.98,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-15 10:50:41','2026-10-15 10:50:41',NULL,NULL),('3c9124c6-5ee1-40b6-8451-59a076ca58bb','63','09aa1dcb-32ec-4230-9ef4-c71fed46410e',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1299.18,1101.00,0.00,'2026-10-14 10:47:02','2026-10-14 14:05:52',NULL,NULL),('3d69e68a-406d-4132-bdf6-f995e7198f13','88','2e19ecfd-f3de-45b2-b22e-42f3add59ebe',2499.00,1,449.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 12:07:19','2026-10-27 12:07:19',NULL,NULL),('3e027c10-5174-4c16-acae-a51725b121b1','60','0d5bfd23-a8c9-4793-8bc4-40535c29c9ee',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:38:42','2026-10-14 10:38:42',NULL,NULL),('490e1e3c-4b01-40e9-a8bb-c2b53373e8a9','22','f8a2fc22-79f2-4333-96e9-7e564a3f9246',599.00,1,107.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-02 18:35:12','2026-10-02 18:35:12',NULL,NULL),('4e6e36d6-9d19-459a-bafd-c473efaa7922','7','bkg-0001-0001-0001-000000000007',299.00,1,53.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-19 12:48:06','2026-10-19 12:48:06',NULL,NULL),('510b9a3a-4841-4af0-b9d7-af463a3a3fcc','61','4eb7f298-418b-45cd-b3d9-bb05329fbf50',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:39:21','2026-10-14 10:39:21',NULL,NULL),('51f877d4-3291-41de-968c-be2c19e33a73','50','de1f2f03-b0e8-4f30-9ea5-1347f479359e',1101.00,1,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-13 10:04:05','2026-10-13 10:04:05',NULL,NULL),('591ced88-a3bc-4c9c-9969-48b9bf26a2ae','20','266d8d8f-6d7e-4a24-b55b-cc1a75a950f0',2499.00,1,449.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-09-30 22:57:06','2026-09-30 22:57:06',NULL,NULL),('5d7d0270-ab63-4878-acd7-2cd15d4615d9','89','3dbdd63f-a1a8-4969-97bd-456b677e593c',4499.00,1,809.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 12:15:54','2026-10-27 12:15:54',NULL,NULL),('632ff5e7-eb8b-4c61-913e-a733242719be','93','4a186688-74fb-45be-86ba-5ac62d7ea342',10.00,1,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 15:20:56','2026-10-27 15:20:56',NULL,NULL),('6b013972-9896-45dc-a1f9-2c16eb79bde2','80','0123f3e2-f818-46c7-aca2-d229fb029299',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-16 09:50:26','2026-10-16 09:50:26',NULL,NULL),('71dc02cb-de63-4bb1-99be-74c2f2ca295e','90','1a71cd0f-8b05-4b13-9f7c-ae84a2cf7bff',3499.00,1,629.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 12:21:04','2026-10-27 12:21:04',NULL,NULL),('74c85e08-f212-4829-8363-7bc18d27986c','51','1ad4108d-50b7-4087-ae27-3a8c959c4247',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-13 18:06:00','2026-10-13 18:06:00',NULL,NULL),('7dde1acc-6d8e-49a9-bb5b-5ed79c8669d3','23','52c8ec66-d962-40f5-84ad-4b4cd73c8631',599.00,1,107.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-02 18:39:19','2026-10-02 18:39:19',NULL,NULL),('80ddc115-4644-4c40-9033-ee2ca4f92377','74','e3948edf-bb94-4b2e-aae3-347ea82ddeb3',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-15 12:16:21','2026-10-15 12:16:21',NULL,NULL),('83c24129-3d16-43e6-b4cf-e0d2b4005453','17','6fe2ffa1-c8c4-4575-85a8-f2e3f1bfb1ca',2499.00,1,449.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-09-22 18:25:21','2026-09-22 18:25:21',NULL,NULL),('89397317-9514-4e8c-ba7e-c11e92883379','70','b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 18:19:14','2026-10-14 18:19:14',NULL,NULL),('8f93b815-8ae6-45cf-bb99-5ae9ce963d42','82','03009368-b8e9-4122-845c-35058d02a231',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-18 20:12:55','2026-10-18 20:12:55',NULL,NULL),('9439b61f-3432-44b2-8ce8-61b8e7bd02be','95','32982b71-73c9-490f-8ad3-dc9733458339',10.00,1,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 15:38:32','2026-10-27 15:38:32',NULL,NULL),('9455c762-dabe-4179-9c8e-bd4c4765041b','64','a7664860-8d72-4543-99ac-a449b68f9249',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:51:20','2026-10-14 10:51:20',NULL,NULL),('9633df05-03b3-4e22-a32a-2bc335e8bf4d','97','b6242049-0682-4e0d-982f-c9de3f4e7ef9',10.00,1,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 15:54:17','2026-10-27 15:54:17',NULL,NULL),('990b8997-df3b-4860-8883-20d1f4a67bb3','59','e90e21ac-aed6-45d4-b9b4-b4240f1da37d',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:38:11','2026-10-14 10:38:11',NULL,NULL),('99402364-42c9-4b6c-b365-c33ae9d0db95','47','92960767-886f-457e-9ca1-dd880dfed02c',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,1299.18,1101.00,0.00,'2026-10-12 14:12:51','2026-10-12 15:21:32',NULL,NULL),('9be66882-d775-4af4-91b1-e58158daa288','91','b5814625-ca70-4c33-9549-46fd4e0fd52e',2499.00,1,449.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 12:28:32','2026-10-27 12:28:32',NULL,NULL),('a323aa9c-0f28-4104-bd76-b8cfcfcb5c56','67','d23f021f-76e8-46cb-886b-e629552fe499',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 14:30:03','2026-10-14 14:30:03',NULL,NULL),('b03e5f06-9b14-4d63-8030-6de5838d7a3f','66','cb068c74-9139-43a0-bd6b-19f297d537b7',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:55:49','2026-10-14 10:55:49',NULL,NULL),('b4483f64-a1f4-4623-bcd7-6d10060cd769','55','bac3a7c1-d2b8-4e37-9901-61a4e8216c9a',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:34:43','2026-10-14 10:34:43',NULL,NULL),('b574151e-d042-41cf-92a8-adf573fd2af4','78','ee5de3cc-d7a0-4932-8320-c564d8dae66b',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-15 17:34:28','2026-10-15 17:34:28',NULL,NULL),('ba075e36-7d93-4076-b5af-827ac81af8a0','21','3e512024-7e3b-4b0d-8500-f826924f65b2',599.00,1,107.82,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-02 18:29:40','2026-10-02 18:29:40',NULL,NULL),('ba08b42a-119c-42a1-9c9c-0d30ff8c5c8e','71','44b8a2b5-a07e-407d-864c-ad75d6bd7eb9',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-15 10:17:10','2026-10-15 10:17:10',NULL,NULL),('c0252f25-1ea6-46f0-8d33-b52ba4b0ed32','53','7f3678b6-f9f3-42e5-a46d-5ad9ea81a162',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:30:58','2026-10-14 10:30:58',NULL,NULL),('c0ba08db-eb81-4ceb-bfc8-abbe714ccd66','41','793bc200-73cc-4d88-b168-8fbc6d014840',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-07 17:11:03','2026-10-07 17:11:03',NULL,NULL),('c5bb0ed0-0f8a-49d7-9f6a-fed18eaee53c','69','ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 17:34:37','2026-10-14 17:34:37',NULL,NULL),('c6ab7040-92a0-4b3b-92c0-4df17ba38b88','57','d5925f5c-5bdb-4d34-895f-6cac40a9be7f',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:37:08','2026-10-14 10:37:08',NULL,NULL),('cd517ce1-8f58-42ab-bd9f-94bd329b83a8','77','68dc44cd-8dda-4e86-be4c-b8c228da89b4',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-15 15:48:48','2026-10-15 15:48:48',NULL,NULL),('d0fbbb81-5b48-4beb-abb7-5a7864bdea88','94','7f7da454-3ef2-413f-9c1d-99f868008536',1110.00,1,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 15:37:22','2026-10-27 15:37:22',NULL,NULL),('d41e9347-6715-4e38-ac65-fd4d74858816','96','eb4fefb9-aa35-42ad-bb9d-0411fd4dde39',10.00,1,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 15:47:40','2026-10-27 15:47:40',NULL,NULL),('d459768e-651e-4c4f-9216-c38b1af7568f','58','f7343c12-59cf-4ed2-8412-b100ecd83050',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:37:45','2026-10-14 10:37:45',NULL,NULL),('d5daf02b-d086-4ffc-85f1-a4b0f6bae03c','52','045e05ee-79de-4f7b-8f9e-5d3e81b159b9',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:25:36','2026-10-14 10:25:36',NULL,NULL),('d9728cb9-7ca6-402e-879d-45520f6d5d20','49','9b60556f-f7bf-442a-bd28-812410ad43ab',1101.00,1,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-12 18:15:29','2026-10-12 18:15:29',NULL,NULL),('e91f43b6-f2b6-45f0-a1df-93ca7f201a64','42','b88bab80-6999-4fb8-975d-2c8f0694ccb8',1110.00,1,199.80,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-09 17:47:49','2026-10-09 17:47:49',NULL,NULL),('ea4c698f-03f3-4204-a74f-001bddb458fc','79','2f018e52-fdb8-4f46-9553-60eea6807e89',1110.00,1,199.80,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-15 17:49:29','2026-10-15 17:49:29',NULL,NULL),('eac359f8-b766-4ff9-83a8-44659abc8b1b','68','d662278a-b37c-4b0c-adae-01ce044bc49d',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 16:41:46','2026-10-14 16:41:46',NULL,NULL),('eb4cff43-b283-4374-8725-d3c7baf13857','43','3340ac66-4cb5-47fd-abbb-945c7265642a',10.00,1,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-12 10:41:40','2026-10-12 10:41:40',NULL,NULL),('f0524bbc-f6fc-4ee6-b323-671cb03a9fb6','92','e3421053-1718-494d-b96f-ae231ced63af',10.00,1,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-27 14:51:20','2026-10-27 14:51:20',NULL,NULL),('faab3d72-9c0a-4cdf-bdbc-1db7cd66c37f','54','5f45385f-3e6e-433b-b1de-2f4b56143e03',1101.00,1,198.18,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,'2026-10-14 10:33:25','2026-10-14 10:33:25',NULL,NULL);
/*!40000 ALTER TABLE `booking_details_amounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_extra_services`
--

DROP TABLE IF EXISTS `booking_extra_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_extra_services` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serviceman_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'custom/external work ka naam',
  `price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `quantity` int NOT NULL DEFAULT '1',
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'custom' COMMENT 'custom | external',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_extra_services_booking_id_index` (`booking_id`),
  KEY `booking_extra_services_serviceman_id_index` (`serviceman_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_extra_services`
--

LOCK TABLES `booking_extra_services` WRITE;
/*!40000 ALTER TABLE `booking_extra_services` DISABLE KEYS */;
INSERT INTO `booking_extra_services` VALUES ('111ffa33-0a00-43b5-9f65-12bf4371948e','7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62','sm-0001-0001-0001-000000000001','Ceiling Fan Installation',449.00,1,'external','2026-10-12 11:45:43','2026-10-12 11:45:43'),('56f0f7cd-79c2-4039-b32d-4901673799b2','de1f2f03-b0e8-4f30-9ea5-1347f479359e','sm-0001-0001-0001-000000000001','Emergency Fan Repair',349.00,1,'external','2026-10-13 16:47:24','2026-10-13 16:47:24'),('72c89632-491e-4ec3-8cd1-18498fa54bfe','de1f2f03-b0e8-4f30-9ea5-1347f479359e','sm-0001-0001-0001-000000000001','Emergency Fan Repair',349.00,1,'external','2026-10-13 16:47:04','2026-10-13 16:47:04');
/*!40000 ALTER TABLE `booking_extra_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_ignores`
--

DROP TABLE IF EXISTS `booking_ignores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_ignores` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_ignores_booking_id_index` (`booking_id`),
  KEY `booking_ignores_provider_id_index` (`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_ignores`
--

LOCK TABLES `booking_ignores` WRITE;
/*!40000 ALTER TABLE `booking_ignores` DISABLE KEYS */;
INSERT INTO `booking_ignores` VALUES (2,'0f68ead5-e564-46ee-8eab-3acded861f93','prvd-0001-0001-0001-000000000001','2026-10-14 14:11:02','2026-10-14 14:11:02');
/*!40000 ALTER TABLE `booking_ignores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_offline_payments`
--

DROP TABLE IF EXISTS `booking_offline_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_offline_payments` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `offline_payment_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `customer_information` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `payment_status` enum('pending','denied','approved') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'approved',
  `denied_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_offline_payments`
--

LOCK TABLES `booking_offline_payments` WRITE;
/*!40000 ALTER TABLE `booking_offline_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_offline_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_partial_payments`
--

DROP TABLE IF EXISTS `booking_partial_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_partial_payments` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paid_with` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paid_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `due_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_partial_payments`
--

LOCK TABLES `booking_partial_payments` WRITE;
/*!40000 ALTER TABLE `booking_partial_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_partial_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_rechecks`
--

DROP TABLE IF EXISTS `booking_rechecks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_rechecks` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serviceman_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'jo serviceman pehle kaam kar gaya tha',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'requested',
  `reason` text COLLATE utf8mb4_unicode_ci COMMENT 'customer ki problem',
  `serviceman_note` text COLLATE utf8mb4_unicode_ci COMMENT 'recheck ke baad serviceman ki report',
  `requested_at` timestamp NULL DEFAULT NULL,
  `due_at` timestamp NULL DEFAULT NULL COMMENT '15 din ka deadline',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_rechecks_booking_id_index` (`booking_id`),
  KEY `booking_rechecks_customer_id_index` (`customer_id`),
  KEY `booking_rechecks_provider_id_index` (`provider_id`),
  KEY `booking_rechecks_serviceman_id_index` (`serviceman_id`),
  KEY `booking_rechecks_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_rechecks`
--

LOCK TABLES `booking_rechecks` WRITE;
/*!40000 ALTER TABLE `booking_rechecks` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_rechecks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_repeat_details`
--

DROP TABLE IF EXISTS `booking_repeat_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_repeat_details` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_repeat_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_details_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_cost` decimal(24,3) NOT NULL DEFAULT '0.000',
  `quantity` int NOT NULL DEFAULT '1',
  `discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `tax_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_cost` decimal(24,3) NOT NULL DEFAULT '0.000',
  `campaign_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `overall_coupon_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_repeat_details`
--

LOCK TABLES `booking_repeat_details` WRITE;
/*!40000 ALTER TABLE `booking_repeat_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_repeat_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_repeat_histories`
--

DROP TABLE IF EXISTS `booking_repeat_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_repeat_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_repeat_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_repeat_details_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `readable_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_quantity` int DEFAULT NULL,
  `new_quantity` int DEFAULT NULL,
  `is_multiple` tinyint NOT NULL DEFAULT '0',
  `total_booking_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_tax_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `extra_fee` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_referral_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `log_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_repeat_histories`
--

LOCK TABLES `booking_repeat_histories` WRITE;
/*!40000 ALTER TABLE `booking_repeat_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_repeat_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_repeats`
--

DROP TABLE IF EXISTS `booking_repeats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_repeats` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `readable_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_details_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serviceman_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `service_schedule` datetime DEFAULT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `total_booking_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_tax_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_campaign_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_coupon_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `removed_coupon_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `additional_charge` decimal(24,3) NOT NULL DEFAULT '0.000',
  `additional_tax_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `additional_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `additional_campaign_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `extra_fee` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_referral_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `coupon_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verified` tinyint NOT NULL DEFAULT '0',
  `is_reassign` tinyint NOT NULL DEFAULT '0',
  `evidence_photos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `booking_otp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_address_location` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `service_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer' COMMENT 'customer,provider',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `auto_assigned` tinyint(1) NOT NULL DEFAULT '0',
  `auto_assign_expires_at` timestamp NULL DEFAULT NULL,
  `assigned_provider_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serviceman_assign_expires_at` timestamp NULL DEFAULT NULL,
  `start_otp` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_otp_generated_at` timestamp NULL DEFAULT NULL,
  `serviceman_reached_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_repeats`
--

LOCK TABLES `booking_repeats` WRITE;
/*!40000 ALTER TABLE `booking_repeats` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_repeats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_schedule_histories`
--

DROP TABLE IF EXISTS `booking_schedule_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_schedule_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `changed_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `schedule` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_guest` tinyint(1) NOT NULL DEFAULT '0',
  `booking_repeat_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_schedule_histories`
--

LOCK TABLES `booking_schedule_histories` WRITE;
/*!40000 ALTER TABLE `booking_schedule_histories` DISABLE KEYS */;
INSERT INTO `booking_schedule_histories` VALUES (1,'6fe2ffa1-c8c4-4575-85a8-f2e3f1bfb1ca','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-09-22 10:57:10','2026-09-22 18:25:21','2026-09-22 18:25:21',0,NULL),(2,'0978aaa3-bde3-4438-a245-b9c7dbebfd62','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-09-26 13:31:12','2026-09-26 20:59:22','2026-09-26 20:59:22',0,NULL),(3,'3304fbdd-50cd-4f25-b89a-b58f5fbc3a15','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-09-28 18:38:33','2026-09-29 02:08:12','2026-09-29 02:08:12',0,NULL),(4,'266d8d8f-6d7e-4a24-b55b-cc1a75a950f0','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-03 18:00:00','2026-09-30 22:57:06','2026-09-30 22:57:06',0,NULL),(5,'3e512024-7e3b-4b0d-8500-f826924f65b2','cust-0001-0001-0001-000000000001','2026-10-03 01:59:38','2026-10-02 18:29:40','2026-10-02 18:29:40',0,NULL),(6,'f8a2fc22-79f2-4333-96e9-7e564a3f9246','cust-0001-0001-0001-000000000001','2026-10-03 02:05:10','2026-10-02 18:35:12','2026-10-02 18:35:12',0,NULL),(7,'52c8ec66-d962-40f5-84ad-4b4cd73c8631','cust-0001-0001-0001-000000000001','2026-10-03 02:09:17','2026-10-02 18:39:19','2026-10-02 18:39:19',0,NULL),(8,'7f4ba9ec-0cf5-4671-b725-89160062b3f2','cust-0001-0001-0001-000000000001','2026-10-03 02:17:03','2026-10-02 18:47:06','2026-10-02 18:47:06',0,NULL),(9,'22b0c62f-5eb2-44c7-9390-7278813ce022','cust-0001-0001-0001-000000000001','2026-10-03 12:00:00','2026-10-02 22:20:31','2026-10-02 22:20:31',0,NULL),(25,'793bc200-73cc-4d88-b168-8fbc6d014840','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-07 17:42:52','2026-10-07 17:11:03','2026-10-07 17:11:03',0,NULL),(26,'b88bab80-6999-4fb8-975d-2c8f0694ccb8','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-09 18:19:33','2026-10-09 17:47:49','2026-10-09 17:47:49',0,NULL),(27,'3340ac66-4cb5-47fd-abbb-945c7265642a','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-12 11:12:24','2026-10-12 10:41:40','2026-10-12 10:41:40',0,NULL),(28,'7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-12 11:17:20','2026-10-12 10:45:44','2026-10-12 10:45:44',0,NULL),(31,'92960767-886f-457e-9ca1-dd880dfed02c','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-12 14:44:45','2026-10-12 14:12:51','2026-10-12 14:12:51',0,NULL),(32,'9b60556f-f7bf-442a-bd28-812410ad43ab','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-12 18:47:23','2026-10-12 18:15:29','2026-10-12 18:15:29',0,NULL),(33,'de1f2f03-b0e8-4f30-9ea5-1347f479359e','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-13 10:35:58','2026-10-13 10:04:05','2026-10-13 10:04:05',0,NULL),(34,'1ad4108d-50b7-4087-ae27-3a8c959c4247','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-13 18:37:51','2026-10-13 18:06:00','2026-10-13 18:06:00',0,NULL),(35,'045e05ee-79de-4f7b-8f9e-5d3e81b159b9','6265773a-d7cd-4fe1-8325-cf39cf3a2ea2','1970-01-01 05:00:00','2026-10-14 10:25:36','2026-10-14 10:25:36',1,NULL),(36,'7f3678b6-f9f3-42e5-a46d-5ad9ea81a162','44e6582d-b02a-4d6b-bfeb-5aa389e529cf','1970-01-01 05:00:00','2026-10-14 10:30:58','2026-10-14 10:30:58',1,NULL),(37,'5f45385f-3e6e-433b-b1de-2f4b56143e03','1f11dec2-cc68-4c71-808e-7a7ce8e2373f','1970-01-01 05:00:00','2026-10-14 10:33:25','2026-10-14 10:33:25',1,NULL),(38,'bac3a7c1-d2b8-4e37-9901-61a4e8216c9a','d1ac4acb-2d40-444e-8d75-345ca36b30f4','1970-01-01 05:00:00','2026-10-14 10:34:43','2026-10-14 10:34:43',1,NULL),(39,'bc86c09e-6a09-4bc8-8018-0b0528d3fcd4','0b0a510f-61a2-49a8-af78-1e7a487938a4','1970-01-01 05:00:00','2026-10-14 10:36:56','2026-10-14 10:36:56',1,NULL),(40,'d5925f5c-5bdb-4d34-895f-6cac40a9be7f','9b6c8600-396a-4606-88d9-a1e581d4ebbc','1970-01-01 05:00:00','2026-10-14 10:37:08','2026-10-14 10:37:08',1,NULL),(41,'f7343c12-59cf-4ed2-8412-b100ecd83050','f44a28fa-6eb1-4a0b-aa32-602d7be66896','1970-01-01 05:00:00','2026-10-14 10:37:45','2026-10-14 10:37:45',1,NULL),(42,'e90e21ac-aed6-45d4-b9b4-b4240f1da37d','3508fb57-9ac6-4177-946a-334d23f19a13','1970-01-01 05:00:00','2026-10-14 10:38:11','2026-10-14 10:38:11',1,NULL),(43,'0d5bfd23-a8c9-4793-8bc4-40535c29c9ee','e417b5a9-e087-4a52-aaa0-6beb7df95559','1970-01-01 05:00:00','2026-10-14 10:38:42','2026-10-14 10:38:42',1,NULL),(44,'4eb7f298-418b-45cd-b3d9-bb05329fbf50','8fb5c7e3-da6a-477e-88ef-2003c4bcb790','1970-01-01 05:00:00','2026-10-14 10:39:21','2026-10-14 10:39:21',1,NULL),(45,'0f68ead5-e564-46ee-8eab-3acded861f93','c05d2ca3-4881-4060-955b-c4e48793798b','1970-01-01 05:00:00','2026-10-14 10:43:50','2026-10-14 10:43:50',1,NULL),(46,'09aa1dcb-32ec-4230-9ef4-c71fed46410e','e1de451e-bad5-4468-801a-25346e13730a','1970-01-01 05:00:00','2026-10-14 10:47:02','2026-10-14 10:47:02',1,NULL),(47,'a7664860-8d72-4543-99ac-a449b68f9249','a367bd15-4c46-45a5-9e01-43d6d78f3976','1970-01-01 05:00:00','2026-10-14 10:51:20','2026-10-14 10:51:20',1,NULL),(48,'64b578a9-e217-4317-81db-6cce9704ba6a','0b533d1a-2e20-4f76-bd35-6eb17bc845ed','1970-01-01 05:00:00','2026-10-14 10:54:22','2026-10-14 10:54:22',1,NULL),(49,'cb068c74-9139-43a0-bd6b-19f297d537b7','5502f459-26c8-466b-9e04-4c0dbf41445e','1970-01-01 05:00:00','2026-10-14 10:55:49','2026-10-14 10:55:49',1,NULL),(50,'d23f021f-76e8-46cb-886b-e629552fe499','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-14 15:01:52','2026-10-14 14:30:03','2026-10-14 14:30:03',0,NULL),(51,'d662278a-b37c-4b0c-adae-01ce044bc49d','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-14 17:13:34','2026-10-14 16:41:46','2026-10-14 16:41:46',0,NULL),(52,'ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-14 18:06:29','2026-10-14 17:34:37','2026-10-14 17:34:37',0,NULL),(53,'b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-14 18:51:09','2026-10-14 18:19:14','2026-10-14 18:19:14',0,NULL),(54,'44b8a2b5-a07e-407d-864c-ad75d6bd7eb9','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-15 10:49:00','2026-10-15 10:17:10','2026-10-15 10:17:10',0,NULL),(55,'dbca7d1b-7afb-4bed-9bdc-bae32d87c53c','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-15 11:22:33','2026-10-15 10:50:41','2026-10-15 10:50:41',0,NULL),(56,'b3b5a47b-29dd-4dd3-babd-7397e8935a44','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-15 12:23:07','2026-10-15 11:51:10','2026-10-15 11:51:10',0,NULL),(57,'e3948edf-bb94-4b2e-aae3-347ea82ddeb3','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-15 12:45:31','2026-10-15 12:16:21','2026-10-15 12:16:21',0,NULL),(58,'c288a76f-082e-41b1-8bd6-f21ae91729b0','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-15 13:07:28','2026-10-15 12:36:34','2026-10-15 12:36:34',0,NULL),(59,'f85b4243-7dbe-4b19-b044-ef1c99b7abb6','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-15 15:21:41','2026-10-15 14:49:45','2026-10-15 14:49:45',0,NULL),(60,'68dc44cd-8dda-4e86-be4c-b8c228da89b4','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-15 16:20:41','2026-10-15 15:48:48','2026-10-15 15:48:48',0,NULL),(61,'ee5de3cc-d7a0-4932-8320-c564d8dae66b','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-15 18:06:23','2026-10-15 17:34:28','2026-10-15 17:34:28',0,NULL),(62,'2f018e52-fdb8-4f46-9553-60eea6807e89','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-15 18:21:24','2026-10-15 17:49:29','2026-10-15 17:49:29',0,NULL),(63,'0123f3e2-f818-46c7-aca2-d229fb029299','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-16 10:22:14','2026-10-16 09:50:26','2026-10-16 09:50:26',0,NULL),(64,'d9ac8ce7-35be-45b6-a83a-dcee2fc0aaf2','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-18 20:38:13','2026-10-18 20:06:51','2026-10-18 20:06:51',0,NULL),(65,'03009368-b8e9-4122-845c-35058d02a231','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-18 20:44:43','2026-10-18 20:12:55','2026-10-18 20:12:55',0,NULL),(66,'2e667db0-22d4-4f2c-a3f3-fd6edc0ac096','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-18 20:47:42','2026-10-18 20:15:49','2026-10-18 20:15:49',0,NULL),(67,'6e5eebe2-d583-4ff4-a801-198228365253','31f1bff9-432d-48ab-8e12-dcfc38d46069','2026-10-18 21:22:23','2026-10-18 20:50:30','2026-10-18 20:50:30',0,NULL),(71,'2e19ecfd-f3de-45b2-b22e-42f3add59ebe','cust-0001-0001-0001-000000000001','2026-10-27 12:39:14','2026-10-27 12:07:19','2026-10-27 12:07:19',0,NULL),(72,'3dbdd63f-a1a8-4969-97bd-456b677e593c','cust-0001-0001-0001-000000000001','2026-10-27 12:47:50','2026-10-27 12:15:54','2026-10-27 12:15:54',0,NULL),(73,'1a71cd0f-8b05-4b13-9f7c-ae84a2cf7bff','cust-0001-0001-0001-000000000001','2026-10-27 12:53:00','2026-10-27 12:21:04','2026-10-27 12:21:04',0,NULL),(74,'b5814625-ca70-4c33-9549-46fd4e0fd52e','cust-0001-0001-0001-000000000001','2026-10-27 13:00:28','2026-10-27 12:28:32','2026-10-27 12:28:32',0,NULL),(75,'e3421053-1718-494d-b96f-ae231ced63af','cust-0001-0001-0001-000000000001','2026-10-27 15:23:17','2026-10-27 14:51:20','2026-10-27 14:51:20',0,NULL),(76,'4a186688-74fb-45be-86ba-5ac62d7ea342','cust-0001-0001-0001-000000000001','2026-10-27 15:52:50','2026-10-27 15:20:56','2026-10-27 15:20:56',0,NULL),(77,'7f7da454-3ef2-413f-9c1d-99f868008536','cust-0001-0001-0001-000000000001','2026-10-27 16:09:15','2026-10-27 15:37:22','2026-10-27 15:37:22',0,NULL),(78,'32982b71-73c9-490f-8ad3-dc9733458339','cust-0001-0001-0001-000000000001','2026-10-27 16:10:23','2026-10-27 15:38:32','2026-10-27 15:38:32',0,NULL),(79,'eb4fefb9-aa35-42ad-bb9d-0411fd4dde39','cust-0001-0001-0001-000000000001','2026-10-27 16:19:31','2026-10-27 15:47:40','2026-10-27 15:47:40',0,NULL),(80,'b6242049-0682-4e0d-982f-c9de3f4e7ef9','cust-0001-0001-0001-000000000001','2026-10-27 16:26:13','2026-10-27 15:54:17','2026-10-27 15:54:17',0,NULL),(81,'2033219c-7431-4ac6-a51f-264abfed80eb','cust-0001-0001-0001-000000000001','2026-10-27 16:34:59','2026-10-27 16:03:04','2026-10-27 16:03:04',0,NULL),(82,'031a9851-64e3-4561-a94d-cc0b0070638d','cust-0001-0001-0001-000000000001','2026-10-27 17:33:11','2026-10-27 17:01:17','2026-10-27 17:01:17',0,NULL),(83,'e27c6207-9e5d-4549-b181-73451ad964d4','cust-0001-0001-0001-000000000001','2026-10-27 18:00:27','2026-10-27 17:28:31','2026-10-27 17:28:31',0,NULL);
/*!40000 ALTER TABLE `booking_schedule_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_servicemen`
--

DROP TABLE IF EXISTS `booking_servicemen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_servicemen` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serviceman_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `expires_at` timestamp NULL DEFAULT NULL COMMENT 'is slot ki accept deadline',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `booking_servicemen_booking_id_serviceman_id_unique` (`booking_id`,`serviceman_id`),
  KEY `booking_servicemen_booking_id_index` (`booking_id`),
  KEY `booking_servicemen_serviceman_id_index` (`serviceman_id`)
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_servicemen`
--

LOCK TABLES `booking_servicemen` WRITE;
/*!40000 ALTER TABLE `booking_servicemen` DISABLE KEYS */;
INSERT INTO `booking_servicemen` VALUES (23,'793bc200-73cc-4d88-b168-8fbc6d014840','sm-0001-0001-0001-000000000001','expired','2026-10-23 08:02:29','2026-10-07 17:11:03','2026-10-23 10:37:04'),(24,'793bc200-73cc-4d88-b168-8fbc6d014840','sm-0001-0001-0001-000000000002','expired','2026-10-23 08:02:29','2026-10-07 17:11:39','2026-10-23 10:37:04'),(25,'b88bab80-6999-4fb8-975d-2c8f0694ccb8','sm-0001-0001-0001-000000000001','expired','2026-10-13 16:22:07','2026-10-09 17:47:48','2026-10-13 16:22:36'),(26,'b88bab80-6999-4fb8-975d-2c8f0694ccb8','sm-0001-0001-0001-000000000002','expired','2026-10-09 17:49:11','2026-10-09 17:48:41','2026-10-09 17:49:13'),(27,'3340ac66-4cb5-47fd-abbb-945c7265642a','sm-0001-0001-0001-000000000003','expired','2026-10-13 16:21:39','2026-10-12 10:41:40','2026-10-13 16:22:06'),(28,'3340ac66-4cb5-47fd-abbb-945c7265642a','sm-0001-0001-0001-000000000004','expired','2026-10-12 10:46:02','2026-10-12 10:44:02','2026-10-12 10:46:03'),(29,'7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62','sm-0001-0001-0001-000000000001','accepted','2026-10-12 11:45:04','2026-10-12 10:45:44','2026-10-12 11:44:56'),(30,'7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62','sm-0001-0001-0001-000000000002','expired','2026-10-12 10:47:03','2026-10-12 10:46:33','2026-10-12 10:47:04'),(31,'6748cb87-ef95-404b-a4af-c4d9fdb6117a','sm-0001-0001-0001-000000000001','expired','2026-10-12 11:54:27','2026-10-12 11:53:57','2026-10-12 11:54:34'),(32,'6748cb87-ef95-404b-a4af-c4d9fdb6117a','sm-0001-0001-0001-000000000002','expired','2026-10-12 11:55:04','2026-10-12 11:54:34','2026-10-12 11:55:05'),(33,'47346d56-1d95-4991-a826-79cff24ece96','sm-0001-0001-0001-000000000001','expired','2026-10-12 12:18:24','2026-10-12 12:17:54','2026-10-12 12:18:34'),(34,'92960767-886f-457e-9ca1-dd880dfed02c','sm-0001-0001-0001-000000000001','accepted','2026-10-12 14:14:34','2026-10-12 14:12:51','2026-10-12 14:14:28'),(35,'92960767-886f-457e-9ca1-dd880dfed02c','sm-0001-0001-0001-000000000002','expired','2026-10-12 14:14:03','2026-10-12 14:13:33','2026-10-12 14:14:04'),(36,'9b60556f-f7bf-442a-bd28-812410ad43ab','sm-0001-0001-0001-000000000001','accepted','2026-10-12 18:17:50','2026-10-12 18:15:29','2026-10-12 18:17:25'),(37,'9b60556f-f7bf-442a-bd28-812410ad43ab','sm-0001-0001-0001-000000000002','expired','2026-10-12 18:16:34','2026-10-12 18:16:04','2026-10-12 18:17:05'),(44,'de1f2f03-b0e8-4f30-9ea5-1347f479359e','sm-0001-0001-0001-000000000001','accepted','2026-10-13 14:17:06','2026-10-13 10:04:05','2026-10-13 14:16:51'),(45,'de1f2f03-b0e8-4f30-9ea5-1347f479359e','sm-0001-0001-0001-000000000002','expired','2026-10-13 10:33:07','2026-10-13 10:32:37','2026-10-13 10:33:35'),(48,'1ad4108d-50b7-4087-ae27-3a8c959c4247','sm-0001-0001-0001-000000000001','expired','2026-10-23 08:02:29','2026-10-14 09:53:29','2026-10-23 10:37:04'),(49,'1ad4108d-50b7-4087-ae27-3a8c959c4247','sm-0001-0001-0001-000000000002','expired','2026-10-23 08:02:29','2026-10-14 10:25:34','2026-10-23 10:37:04'),(50,'045e05ee-79de-4f7b-8f9e-5d3e81b159b9','sm-0001-0001-0001-000000000001','expired','2026-10-23 08:02:29','2026-10-14 10:25:36','2026-10-23 10:37:04'),(51,'045e05ee-79de-4f7b-8f9e-5d3e81b159b9','sm-0001-0001-0001-000000000002','expired','2026-10-23 08:02:29','2026-10-14 10:26:06','2026-10-23 10:37:04'),(52,'7f3678b6-f9f3-42e5-a46d-5ad9ea81a162','sm-0001-0001-0001-000000000001','expired','2026-10-14 10:31:28','2026-10-14 10:30:58','2026-10-14 10:31:44'),(53,'7f3678b6-f9f3-42e5-a46d-5ad9ea81a162','sm-0001-0001-0001-000000000002','expired','2026-10-14 10:32:14','2026-10-14 10:31:44','2026-10-14 10:32:38'),(54,'5f45385f-3e6e-433b-b1de-2f4b56143e03','sm-0001-0001-0001-000000000001','expired','2026-10-23 08:02:29','2026-10-14 10:33:25','2026-10-23 10:37:04'),(55,'5f45385f-3e6e-433b-b1de-2f4b56143e03','sm-0001-0001-0001-000000000002','expired','2026-10-23 08:02:29','2026-10-14 10:34:02','2026-10-23 10:37:04'),(56,'bac3a7c1-d2b8-4e37-9901-61a4e8216c9a','sm-0001-0001-0001-000000000001','expired','2026-10-14 10:35:12','2026-10-14 10:34:42','2026-10-14 10:35:34'),(57,'bac3a7c1-d2b8-4e37-9901-61a4e8216c9a','sm-0001-0001-0001-000000000002','expired','2026-10-14 10:36:04','2026-10-14 10:35:34','2026-10-14 10:36:04'),(58,'bc86c09e-6a09-4bc8-8018-0b0528d3fcd4','sm-0001-0001-0001-000000000001','expired','2026-10-14 10:37:26','2026-10-14 10:36:56','2026-10-14 10:37:34'),(59,'d5925f5c-5bdb-4d34-895f-6cac40a9be7f','sm-0001-0001-0001-000000000001','expired','2026-10-14 10:37:38','2026-10-14 10:37:08','2026-10-14 10:38:05'),(60,'bc86c09e-6a09-4bc8-8018-0b0528d3fcd4','sm-0001-0001-0001-000000000002','expired','2026-10-14 10:38:04','2026-10-14 10:37:34','2026-10-14 10:38:05'),(61,'f7343c12-59cf-4ed2-8412-b100ecd83050','sm-0001-0001-0001-000000000001','expired','2026-10-14 10:38:15','2026-10-14 10:37:45','2026-10-14 10:38:35'),(62,'d5925f5c-5bdb-4d34-895f-6cac40a9be7f','sm-0001-0001-0001-000000000002','expired','2026-10-14 10:38:35','2026-10-14 10:38:05','2026-10-14 10:38:35'),(63,'e90e21ac-aed6-45d4-b9b4-b4240f1da37d','sm-0001-0001-0001-000000000001','expired','2026-10-14 10:38:41','2026-10-14 10:38:11','2026-10-14 10:39:06'),(64,'f7343c12-59cf-4ed2-8412-b100ecd83050','sm-0001-0001-0001-000000000002','expired','2026-10-14 10:39:05','2026-10-14 10:38:35','2026-10-14 10:39:06'),(65,'0d5bfd23-a8c9-4793-8bc4-40535c29c9ee','sm-0001-0001-0001-000000000001','expired','2026-10-23 08:02:29','2026-10-14 10:38:42','2026-10-23 10:37:04'),(66,'e90e21ac-aed6-45d4-b9b4-b4240f1da37d','sm-0001-0001-0001-000000000002','expired','2026-10-14 10:39:36','2026-10-14 10:39:06','2026-10-14 10:39:36'),(67,'4eb7f298-418b-45cd-b3d9-bb05329fbf50','sm-0001-0001-0001-000000000001','expired','2026-10-23 08:02:29','2026-10-14 10:39:21','2026-10-23 10:37:04'),(68,'0d5bfd23-a8c9-4793-8bc4-40535c29c9ee','sm-0001-0001-0001-000000000002','expired','2026-10-23 08:02:29','2026-10-14 10:39:36','2026-10-23 10:37:04'),(69,'4eb7f298-418b-45cd-b3d9-bb05329fbf50','sm-0001-0001-0001-000000000002','expired','2026-10-23 08:02:29','2026-10-14 10:40:03','2026-10-23 10:37:04'),(70,'0f68ead5-e564-46ee-8eab-3acded861f93','sm-0001-0001-0001-000000000001','expired','2026-10-14 10:44:20','2026-10-14 10:43:50','2026-10-14 10:44:36'),(71,'0f68ead5-e564-46ee-8eab-3acded861f93','sm-0001-0001-0001-000000000002','expired','2026-10-14 10:45:06','2026-10-14 10:44:36','2026-10-14 10:45:35'),(72,'09aa1dcb-32ec-4230-9ef4-c71fed46410e','sm-0001-0001-0001-000000000001','accepted','2026-10-14 14:01:21','2026-10-14 10:47:02','2026-10-14 14:00:51'),(73,'09aa1dcb-32ec-4230-9ef4-c71fed46410e','sm-0001-0001-0001-000000000002','expired','2026-10-14 10:48:26','2026-10-14 10:47:56','2026-10-14 10:48:37'),(74,'a7664860-8d72-4543-99ac-a449b68f9249','sm-0001-0001-0001-000000000001','expired','2026-10-14 10:51:50','2026-10-14 10:51:20','2026-10-14 10:52:04'),(75,'a7664860-8d72-4543-99ac-a449b68f9249','sm-0001-0001-0001-000000000002','expired','2026-10-14 10:52:34','2026-10-14 10:52:04','2026-10-14 10:52:35'),(76,'64b578a9-e217-4317-81db-6cce9704ba6a','sm-0001-0001-0001-000000000001','expired','2026-10-23 08:02:29','2026-10-14 10:54:22','2026-10-23 10:37:04'),(77,'64b578a9-e217-4317-81db-6cce9704ba6a','sm-0001-0001-0001-000000000002','expired','2026-10-23 08:02:29','2026-10-14 10:55:06','2026-10-23 10:37:05'),(78,'cb068c74-9139-43a0-bd6b-19f297d537b7','sm-0001-0001-0001-000000000001','expired','2026-10-14 10:56:19','2026-10-14 10:55:49','2026-10-14 10:56:24'),(79,'cb068c74-9139-43a0-bd6b-19f297d537b7','sm-0001-0001-0001-000000000002','expired','2026-10-14 10:56:54','2026-10-14 10:56:24','2026-10-14 10:56:55'),(80,'d23f021f-76e8-46cb-886b-e629552fe499','sm-0001-0001-0001-000000000001','expired','2026-10-14 14:30:33','2026-10-14 14:30:03','2026-10-14 14:30:39'),(81,'d23f021f-76e8-46cb-886b-e629552fe499','sm-0001-0001-0001-000000000002','expired','2026-10-14 14:31:10','2026-10-14 14:30:40','2026-10-14 14:31:11'),(82,'d662278a-b37c-4b0c-adae-01ce044bc49d','sm-0001-0001-0001-000000000001','expired','2026-10-14 16:42:16','2026-10-14 16:41:46','2026-10-14 16:42:43'),(83,'d662278a-b37c-4b0c-adae-01ce044bc49d','sm-0001-0001-0001-000000000002','expired','2026-10-14 16:43:13','2026-10-14 16:42:43','2026-10-14 16:43:13'),(84,'ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc','sm-0001-0001-0001-000000000001','expired','2026-10-14 17:35:07','2026-10-14 17:34:37','2026-10-14 17:35:13'),(85,'ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc','sm-0001-0001-0001-000000000002','expired','2026-10-14 17:35:43','2026-10-14 17:35:13','2026-10-14 17:35:43'),(86,'b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4','sm-0001-0001-0001-000000000001','expired','2026-10-14 18:19:43','2026-10-14 18:19:13','2026-10-14 18:20:06'),(87,'b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4','sm-0001-0001-0001-000000000002','expired','2026-10-14 18:20:37','2026-10-14 18:20:07','2026-10-14 18:20:37'),(88,'44b8a2b5-a07e-407d-864c-ad75d6bd7eb9','sm-0001-0001-0001-000000000001','expired','2026-10-23 08:02:29','2026-10-15 10:17:10','2026-10-23 10:37:05'),(89,'44b8a2b5-a07e-407d-864c-ad75d6bd7eb9','sm-0001-0001-0001-000000000002','expired','2026-10-23 08:02:29','2026-10-15 10:17:41','2026-10-23 10:37:05'),(90,'dbca7d1b-7afb-4bed-9bdc-bae32d87c53c','sm-0001-0001-0001-000000000001','expired','2026-10-15 10:52:41','2026-10-15 10:50:41','2026-10-15 10:53:04'),(91,'dbca7d1b-7afb-4bed-9bdc-bae32d87c53c','sm-0001-0001-0001-000000000002','expired','2026-10-15 10:55:04','2026-10-15 10:53:04','2026-10-15 10:55:04'),(92,'b3b5a47b-29dd-4dd3-babd-7397e8935a44','sm-0001-0001-0001-000000000001','rejected','2026-10-15 11:53:10','2026-10-15 11:51:10','2026-10-15 11:51:37'),(93,'b3b5a47b-29dd-4dd3-babd-7397e8935a44','sm-0001-0001-0001-000000000002','expired','2026-10-15 11:53:38','2026-10-15 11:51:38','2026-10-15 11:53:42'),(94,'e3948edf-bb94-4b2e-aae3-347ea82ddeb3','sm-0001-0001-0001-000000000001','expired','2026-10-15 12:18:21','2026-10-15 12:16:21','2026-10-15 12:18:49'),(95,'e3948edf-bb94-4b2e-aae3-347ea82ddeb3','sm-0001-0001-0001-000000000002','expired','2026-10-15 12:20:50','2026-10-15 12:18:50','2026-10-15 12:21:15'),(96,'c288a76f-082e-41b1-8bd6-f21ae91729b0','sm-0001-0001-0001-000000000001','rejected','2026-10-15 12:38:34','2026-10-15 12:36:34','2026-10-15 12:37:15'),(97,'c288a76f-082e-41b1-8bd6-f21ae91729b0','sm-0001-0001-0001-000000000002','expired','2026-10-15 12:39:15','2026-10-15 12:37:15','2026-10-15 12:39:23'),(98,'f85b4243-7dbe-4b19-b044-ef1c99b7abb6','sm-0001-0001-0001-000000000001','rejected','2026-10-15 14:51:45','2026-10-15 14:49:45','2026-10-15 14:51:00'),(99,'f85b4243-7dbe-4b19-b044-ef1c99b7abb6','sm-0001-0001-0001-000000000002','expired','2026-10-15 14:53:00','2026-10-15 14:51:00','2026-10-15 14:53:11'),(100,'68dc44cd-8dda-4e86-be4c-b8c228da89b4','sm-0001-0001-0001-000000000001','expired','2026-10-23 08:02:29','2026-10-15 15:48:48','2026-10-23 10:37:05'),(101,'68dc44cd-8dda-4e86-be4c-b8c228da89b4','sm-0001-0001-0001-000000000002','expired','2026-10-23 08:02:29','2026-10-15 15:50:54','2026-10-23 10:37:05'),(102,'ee5de3cc-d7a0-4932-8320-c564d8dae66b','sm-0001-0001-0001-000000000001','rejected','2026-10-15 17:36:28','2026-10-15 17:34:28','2026-10-15 17:35:12'),(103,'ee5de3cc-d7a0-4932-8320-c564d8dae66b','sm-0001-0001-0001-000000000002','expired','2026-10-15 17:37:12','2026-10-15 17:35:12','2026-10-15 17:37:36'),(104,'2f018e52-fdb8-4f46-9553-60eea6807e89','sm-0001-0001-0001-000000000001','accepted',NULL,'2026-10-15 17:49:29','2026-10-16 10:30:51'),(105,'2f018e52-fdb8-4f46-9553-60eea6807e89','sm-0001-0001-0001-000000000002','rejected','2026-10-15 17:51:29','2026-10-15 17:49:58','2026-10-15 17:52:35'),(106,'0123f3e2-f818-46c7-aca2-d229fb029299','sm-0001-0001-0001-000000000001','accepted',NULL,'2026-10-16 09:50:26','2026-10-16 10:30:41'),(107,'0123f3e2-f818-46c7-aca2-d229fb029299','sm-0001-0001-0001-000000000002','expired','2026-10-16 09:54:43','2026-10-16 09:52:43','2026-10-16 09:54:52'),(108,'d9ac8ce7-35be-45b6-a83a-dcee2fc0aaf2','sm-0001-0001-0001-000000000001','accepted','2026-10-18 20:08:51','2026-10-18 20:06:51','2026-10-18 20:07:30'),(109,'03009368-b8e9-4122-845c-35058d02a231','sm-0001-0001-0001-000000000001','expired','2026-10-23 08:02:29','2026-10-18 20:12:55','2026-10-23 10:37:05'),(110,'03009368-b8e9-4122-845c-35058d02a231','sm-0001-0001-0001-000000000002','expired','2026-10-23 08:02:29','2026-10-18 20:15:05','2026-10-23 10:37:05'),(111,'2e667db0-22d4-4f2c-a3f3-fd6edc0ac096','sm-0001-0001-0001-000000000001','accepted','2026-10-18 20:17:49','2026-10-18 20:15:49','2026-10-18 20:16:24'),(112,'6e5eebe2-d583-4ff4-a801-198228365253','sm-0001-0001-0001-000000000001','accepted','2026-10-18 20:52:30','2026-10-18 20:50:30','2026-10-18 20:51:21'),(117,'3340ac66-4cb5-47fd-abbb-945c7265642a','sm-0001-0001-0001-000000000001','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(118,'3340ac66-4cb5-47fd-abbb-945c7265642a','sm-0001-0001-0001-000000000002','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(119,'ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(120,'f85b4243-7dbe-4b19-b044-ef1c99b7abb6','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(121,'f7343c12-59cf-4ed2-8412-b100ecd83050','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(122,'ee5de3cc-d7a0-4932-8320-c564d8dae66b','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(123,'e90e21ac-aed6-45d4-b9b4-b4240f1da37d','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(124,'e3948edf-bb94-4b2e-aae3-347ea82ddeb3','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(125,'dbca7d1b-7afb-4bed-9bdc-bae32d87c53c','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(126,'d662278a-b37c-4b0c-adae-01ce044bc49d','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(127,'d5925f5c-5bdb-4d34-895f-6cac40a9be7f','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(128,'d23f021f-76e8-46cb-886b-e629552fe499','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(129,'cb068c74-9139-43a0-bd6b-19f297d537b7','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(130,'c288a76f-082e-41b1-8bd6-f21ae91729b0','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(131,'bc86c09e-6a09-4bc8-8018-0b0528d3fcd4','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(132,'bac3a7c1-d2b8-4e37-9901-61a4e8216c9a','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(133,'b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(134,'b88bab80-6999-4fb8-975d-2c8f0694ccb8','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(135,'b3b5a47b-29dd-4dd3-babd-7397e8935a44','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(136,'a7664860-8d72-4543-99ac-a449b68f9249','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(137,'7f3678b6-f9f3-42e5-a46d-5ad9ea81a162','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(138,'793bc200-73cc-4d88-b168-8fbc6d014840','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(139,'68dc44cd-8dda-4e86-be4c-b8c228da89b4','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(140,'64b578a9-e217-4317-81db-6cce9704ba6a','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(141,'5f45385f-3e6e-433b-b1de-2f4b56143e03','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(142,'4eb7f298-418b-45cd-b3d9-bb05329fbf50','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(143,'44b8a2b5-a07e-407d-864c-ad75d6bd7eb9','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(144,'1ad4108d-50b7-4087-ae27-3a8c959c4247','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(145,'0f68ead5-e564-46ee-8eab-3acded861f93','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(146,'0d5bfd23-a8c9-4793-8bc4-40535c29c9ee','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:05'),(147,'045e05ee-79de-4f7b-8f9e-5d3e81b159b9','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(148,'03009368-b8e9-4122-845c-35058d02a231','sm-0001-0001-0001-000000000003','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(149,'ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(150,'f85b4243-7dbe-4b19-b044-ef1c99b7abb6','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(151,'f7343c12-59cf-4ed2-8412-b100ecd83050','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(152,'ee5de3cc-d7a0-4932-8320-c564d8dae66b','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(153,'e90e21ac-aed6-45d4-b9b4-b4240f1da37d','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(154,'e3948edf-bb94-4b2e-aae3-347ea82ddeb3','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(155,'dbca7d1b-7afb-4bed-9bdc-bae32d87c53c','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(156,'d662278a-b37c-4b0c-adae-01ce044bc49d','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(157,'d5925f5c-5bdb-4d34-895f-6cac40a9be7f','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(158,'d23f021f-76e8-46cb-886b-e629552fe499','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(159,'cb068c74-9139-43a0-bd6b-19f297d537b7','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(160,'c288a76f-082e-41b1-8bd6-f21ae91729b0','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(161,'bc86c09e-6a09-4bc8-8018-0b0528d3fcd4','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(162,'bac3a7c1-d2b8-4e37-9901-61a4e8216c9a','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(163,'b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(164,'b88bab80-6999-4fb8-975d-2c8f0694ccb8','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(165,'b3b5a47b-29dd-4dd3-babd-7397e8935a44','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(166,'a7664860-8d72-4543-99ac-a449b68f9249','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(167,'7f3678b6-f9f3-42e5-a46d-5ad9ea81a162','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(168,'793bc200-73cc-4d88-b168-8fbc6d014840','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(169,'68dc44cd-8dda-4e86-be4c-b8c228da89b4','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(170,'64b578a9-e217-4317-81db-6cce9704ba6a','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(171,'5f45385f-3e6e-433b-b1de-2f4b56143e03','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(172,'4eb7f298-418b-45cd-b3d9-bb05329fbf50','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(173,'44b8a2b5-a07e-407d-864c-ad75d6bd7eb9','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(174,'1ad4108d-50b7-4087-ae27-3a8c959c4247','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(175,'0f68ead5-e564-46ee-8eab-3acded861f93','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(176,'0d5bfd23-a8c9-4793-8bc4-40535c29c9ee','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(177,'045e05ee-79de-4f7b-8f9e-5d3e81b159b9','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(178,'03009368-b8e9-4122-845c-35058d02a231','sm-0001-0001-0001-000000000004','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(179,'ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(180,'f85b4243-7dbe-4b19-b044-ef1c99b7abb6','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(181,'f7343c12-59cf-4ed2-8412-b100ecd83050','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(182,'ee5de3cc-d7a0-4932-8320-c564d8dae66b','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(183,'e90e21ac-aed6-45d4-b9b4-b4240f1da37d','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(184,'e3948edf-bb94-4b2e-aae3-347ea82ddeb3','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(185,'dbca7d1b-7afb-4bed-9bdc-bae32d87c53c','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(186,'d662278a-b37c-4b0c-adae-01ce044bc49d','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(187,'d5925f5c-5bdb-4d34-895f-6cac40a9be7f','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:32'),(188,'d23f021f-76e8-46cb-886b-e629552fe499','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:33'),(189,'cb068c74-9139-43a0-bd6b-19f297d537b7','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:33'),(190,'c288a76f-082e-41b1-8bd6-f21ae91729b0','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:33'),(191,'bc86c09e-6a09-4bc8-8018-0b0528d3fcd4','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:33'),(192,'bac3a7c1-d2b8-4e37-9901-61a4e8216c9a','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:33'),(193,'b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:33'),(194,'b88bab80-6999-4fb8-975d-2c8f0694ccb8','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:33'),(195,'b3b5a47b-29dd-4dd3-babd-7397e8935a44','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:33'),(196,'a7664860-8d72-4543-99ac-a449b68f9249','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:37:33'),(197,'7f3678b6-f9f3-42e5-a46d-5ad9ea81a162','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(198,'793bc200-73cc-4d88-b168-8fbc6d014840','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(199,'68dc44cd-8dda-4e86-be4c-b8c228da89b4','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(200,'64b578a9-e217-4317-81db-6cce9704ba6a','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(201,'5f45385f-3e6e-433b-b1de-2f4b56143e03','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(202,'4eb7f298-418b-45cd-b3d9-bb05329fbf50','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(203,'44b8a2b5-a07e-407d-864c-ad75d6bd7eb9','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(204,'3340ac66-4cb5-47fd-abbb-945c7265642a','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(205,'1ad4108d-50b7-4087-ae27-3a8c959c4247','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(206,'0f68ead5-e564-46ee-8eab-3acded861f93','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(207,'0d5bfd23-a8c9-4793-8bc4-40535c29c9ee','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(208,'045e05ee-79de-4f7b-8f9e-5d3e81b159b9','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(209,'03009368-b8e9-4122-845c-35058d02a231','sm-0001-0001-0001-000000000005','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(210,'ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(211,'f85b4243-7dbe-4b19-b044-ef1c99b7abb6','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(212,'f7343c12-59cf-4ed2-8412-b100ecd83050','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(213,'ee5de3cc-d7a0-4932-8320-c564d8dae66b','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(214,'e90e21ac-aed6-45d4-b9b4-b4240f1da37d','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(215,'e3948edf-bb94-4b2e-aae3-347ea82ddeb3','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(216,'dbca7d1b-7afb-4bed-9bdc-bae32d87c53c','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(217,'d662278a-b37c-4b0c-adae-01ce044bc49d','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(218,'d5925f5c-5bdb-4d34-895f-6cac40a9be7f','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(219,'d23f021f-76e8-46cb-886b-e629552fe499','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(220,'cb068c74-9139-43a0-bd6b-19f297d537b7','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(221,'c288a76f-082e-41b1-8bd6-f21ae91729b0','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(222,'bc86c09e-6a09-4bc8-8018-0b0528d3fcd4','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(223,'bac3a7c1-d2b8-4e37-9901-61a4e8216c9a','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(224,'b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(225,'b88bab80-6999-4fb8-975d-2c8f0694ccb8','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(226,'b3b5a47b-29dd-4dd3-babd-7397e8935a44','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(227,'a7664860-8d72-4543-99ac-a449b68f9249','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(228,'7f3678b6-f9f3-42e5-a46d-5ad9ea81a162','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(229,'793bc200-73cc-4d88-b168-8fbc6d014840','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(230,'68dc44cd-8dda-4e86-be4c-b8c228da89b4','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(231,'64b578a9-e217-4317-81db-6cce9704ba6a','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(232,'5f45385f-3e6e-433b-b1de-2f4b56143e03','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(233,'4eb7f298-418b-45cd-b3d9-bb05329fbf50','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(234,'44b8a2b5-a07e-407d-864c-ad75d6bd7eb9','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(235,'3340ac66-4cb5-47fd-abbb-945c7265642a','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(236,'1ad4108d-50b7-4087-ae27-3a8c959c4247','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(237,'0f68ead5-e564-46ee-8eab-3acded861f93','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(238,'0d5bfd23-a8c9-4793-8bc4-40535c29c9ee','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(239,'045e05ee-79de-4f7b-8f9e-5d3e81b159b9','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(240,'03009368-b8e9-4122-845c-35058d02a231','sm-0001-0001-0001-000000000006','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(241,'ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(242,'f85b4243-7dbe-4b19-b044-ef1c99b7abb6','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(243,'f7343c12-59cf-4ed2-8412-b100ecd83050','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(244,'ee5de3cc-d7a0-4932-8320-c564d8dae66b','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(245,'e90e21ac-aed6-45d4-b9b4-b4240f1da37d','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(246,'e3948edf-bb94-4b2e-aae3-347ea82ddeb3','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:03'),(247,'dbca7d1b-7afb-4bed-9bdc-bae32d87c53c','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(248,'d662278a-b37c-4b0c-adae-01ce044bc49d','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(249,'d5925f5c-5bdb-4d34-895f-6cac40a9be7f','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(250,'d23f021f-76e8-46cb-886b-e629552fe499','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(251,'cb068c74-9139-43a0-bd6b-19f297d537b7','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(252,'c288a76f-082e-41b1-8bd6-f21ae91729b0','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(253,'bc86c09e-6a09-4bc8-8018-0b0528d3fcd4','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(254,'bac3a7c1-d2b8-4e37-9901-61a4e8216c9a','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(255,'b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(256,'b88bab80-6999-4fb8-975d-2c8f0694ccb8','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(257,'b3b5a47b-29dd-4dd3-babd-7397e8935a44','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(258,'a7664860-8d72-4543-99ac-a449b68f9249','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(259,'7f3678b6-f9f3-42e5-a46d-5ad9ea81a162','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(260,'793bc200-73cc-4d88-b168-8fbc6d014840','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(261,'68dc44cd-8dda-4e86-be4c-b8c228da89b4','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(262,'64b578a9-e217-4317-81db-6cce9704ba6a','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(263,'5f45385f-3e6e-433b-b1de-2f4b56143e03','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(264,'4eb7f298-418b-45cd-b3d9-bb05329fbf50','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(265,'44b8a2b5-a07e-407d-864c-ad75d6bd7eb9','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(266,'3340ac66-4cb5-47fd-abbb-945c7265642a','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(267,'1ad4108d-50b7-4087-ae27-3a8c959c4247','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(268,'0f68ead5-e564-46ee-8eab-3acded861f93','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(269,'0d5bfd23-a8c9-4793-8bc4-40535c29c9ee','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(270,'045e05ee-79de-4f7b-8f9e-5d3e81b159b9','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(271,'03009368-b8e9-4122-845c-35058d02a231','sm-0001-0001-0001-000000000007','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(272,'ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(273,'f85b4243-7dbe-4b19-b044-ef1c99b7abb6','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(274,'f7343c12-59cf-4ed2-8412-b100ecd83050','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(275,'ee5de3cc-d7a0-4932-8320-c564d8dae66b','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(276,'e90e21ac-aed6-45d4-b9b4-b4240f1da37d','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(277,'e3948edf-bb94-4b2e-aae3-347ea82ddeb3','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(278,'dbca7d1b-7afb-4bed-9bdc-bae32d87c53c','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(279,'d662278a-b37c-4b0c-adae-01ce044bc49d','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(280,'d5925f5c-5bdb-4d34-895f-6cac40a9be7f','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(281,'d23f021f-76e8-46cb-886b-e629552fe499','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(282,'cb068c74-9139-43a0-bd6b-19f297d537b7','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(283,'c288a76f-082e-41b1-8bd6-f21ae91729b0','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(284,'bc86c09e-6a09-4bc8-8018-0b0528d3fcd4','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(285,'bac3a7c1-d2b8-4e37-9901-61a4e8216c9a','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(286,'b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(287,'b88bab80-6999-4fb8-975d-2c8f0694ccb8','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(288,'b3b5a47b-29dd-4dd3-babd-7397e8935a44','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(289,'a7664860-8d72-4543-99ac-a449b68f9249','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(290,'7f3678b6-f9f3-42e5-a46d-5ad9ea81a162','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(291,'793bc200-73cc-4d88-b168-8fbc6d014840','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(292,'68dc44cd-8dda-4e86-be4c-b8c228da89b4','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(293,'64b578a9-e217-4317-81db-6cce9704ba6a','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(294,'5f45385f-3e6e-433b-b1de-2f4b56143e03','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(295,'4eb7f298-418b-45cd-b3d9-bb05329fbf50','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(296,'44b8a2b5-a07e-407d-864c-ad75d6bd7eb9','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:38:33'),(297,'3340ac66-4cb5-47fd-abbb-945c7265642a','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:39:03'),(298,'1ad4108d-50b7-4087-ae27-3a8c959c4247','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:39:03'),(299,'0f68ead5-e564-46ee-8eab-3acded861f93','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:39:03'),(300,'0d5bfd23-a8c9-4793-8bc4-40535c29c9ee','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:39:03'),(301,'045e05ee-79de-4f7b-8f9e-5d3e81b159b9','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:39:03'),(302,'03009368-b8e9-4122-845c-35058d02a231','sm-0001-0001-0001-000000000008','expired','2026-10-23 10:18:08','2026-10-22 10:18:08','2026-10-23 10:39:03'),(310,'1a71cd0f-8b05-4b13-9f7c-ae84a2cf7bff','sm-0001-0001-0001-000000000001','expired','2026-10-27 12:25:03','2026-10-27 12:22:33','2026-10-27 12:25:03'),(311,'1a71cd0f-8b05-4b13-9f7c-ae84a2cf7bff','sm-0001-0001-0001-000000000002','expired','2026-10-27 12:25:03','2026-10-27 12:22:49','2026-10-27 12:25:03'),(312,'b5814625-ca70-4c33-9549-46fd4e0fd52e','sm-0001-0001-0001-000000000001','accepted','2026-10-27 12:29:32','2026-10-27 12:28:32','2026-10-27 12:28:51'),(313,'e3421053-1718-494d-b96f-ae231ced63af','sm-0001-0001-0001-000000000001','accepted','2026-10-27 14:52:20','2026-10-27 14:51:20','2026-10-27 14:51:59'),(314,'4a186688-74fb-45be-86ba-5ac62d7ea342','sm-0001-0001-0001-000000000001','rejected','2026-10-27 15:23:18','2026-10-27 15:20:56','2026-10-27 15:23:19'),(315,'32982b71-73c9-490f-8ad3-dc9733458339','sm-0001-0001-0001-000000000001','accepted','2026-10-27 15:42:59','2026-10-27 15:38:32','2026-10-27 15:42:59'),(316,'eb4fefb9-aa35-42ad-bb9d-0411fd4dde39','sm-0001-0001-0001-000000000001','expired','2026-10-27 15:50:05','2026-10-27 15:47:40','2026-10-27 15:50:08'),(317,'b6242049-0682-4e0d-982f-c9de3f4e7ef9','sm-0001-0001-0001-000000000001','expired','2026-10-27 15:56:34','2026-10-27 15:54:17','2026-10-27 15:56:34'),(318,'2033219c-7431-4ac6-a51f-264abfed80eb','sm-0001-0001-0001-000000000001','expired','2026-10-27 16:06:09','2026-10-27 16:03:04','2026-10-27 16:06:38'),(319,'2033219c-7431-4ac6-a51f-264abfed80eb','sm-0001-0001-0001-000000000002','expired','2026-10-27 16:06:09','2026-10-27 16:04:08','2026-10-27 16:06:38'),(320,'031a9851-64e3-4561-a94d-cc0b0070638d','sm-0001-0001-0001-000000000001','accepted','2026-10-27 17:02:17','2026-10-27 17:01:17','2026-10-27 17:01:58');
/*!40000 ALTER TABLE `booking_servicemen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_status_histories`
--

DROP TABLE IF EXISTS `booking_status_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_status_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `changed_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_guest` tinyint(1) NOT NULL DEFAULT '0',
  `booking_repeat_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_status_histories_booking_id_index` (`booking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_status_histories`
--

LOCK TABLES `booking_status_histories` WRITE;
/*!40000 ALTER TABLE `booking_status_histories` DISABLE KEYS */;
INSERT INTO `booking_status_histories` VALUES (1,'bkg-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','accepted','2026-08-27 15:45:55','2026-09-12 15:45:55',0,NULL),(2,'bkg-0001-0001-0001-000000000001','sman-0001-0001-0001-000000000001','ongoing','2026-08-28 15:45:55','2026-09-12 15:45:55',0,NULL),(3,'bkg-0001-0001-0001-000000000001','sman-0001-0001-0001-000000000001','completed','2026-08-28 15:45:55','2026-09-12 15:45:55',0,NULL),(4,'bkg-0001-0001-0001-000000000007','prvd-0001-0001-0001-000000000004','accepted','2026-09-12 13:45:55','2026-09-12 15:45:55',0,NULL),(5,'bkg-0001-0001-0001-000000000007','sman-0001-0001-0001-000000000007','ongoing','2026-09-12 14:45:55','2026-09-12 15:45:55',0,NULL),(6,'bkg-0001-0001-0001-000000000013','prvd-0001-0001-0001-000000000003','canceled','2026-09-07 15:45:55','2026-09-12 15:45:55',0,NULL),(7,'31f1bff9-432d-48ab-8e12-dcfc38d46069','6fe2ffa1-c8c4-4575-85a8-f2e3f1bfb1ca','pending','2026-09-22 18:25:21','2026-09-22 18:25:21',0,NULL),(8,'31f1bff9-432d-48ab-8e12-dcfc38d46069','0978aaa3-bde3-4438-a245-b9c7dbebfd62','pending','2026-09-26 20:59:22','2026-09-26 20:59:22',0,NULL),(9,'31f1bff9-432d-48ab-8e12-dcfc38d46069','3304fbdd-50cd-4f25-b89a-b58f5fbc3a15','pending','2026-09-29 02:08:12','2026-09-29 02:08:12',0,NULL),(10,'31f1bff9-432d-48ab-8e12-dcfc38d46069','266d8d8f-6d7e-4a24-b55b-cc1a75a950f0','pending','2026-09-30 22:57:06','2026-09-30 22:57:06',0,NULL),(11,'bkg-0001-0001-0001-000000000009','prvd-0001-0001-0001-000000000001','accepted','2026-10-02 02:11:27','2026-10-02 02:11:27',0,NULL),(12,'cust-0001-0001-0001-000000000001','3e512024-7e3b-4b0d-8500-f826924f65b2','pending','2026-10-02 18:29:40','2026-10-02 18:29:40',0,NULL),(13,'cust-0001-0001-0001-000000000001','f8a2fc22-79f2-4333-96e9-7e564a3f9246','accepted','2026-10-02 18:35:12','2026-10-02 18:35:12',0,NULL),(14,'cust-0001-0001-0001-000000000001','52c8ec66-d962-40f5-84ad-4b4cd73c8631','accepted','2026-10-02 18:39:19','2026-10-02 18:39:19',0,NULL),(15,'cust-0001-0001-0001-000000000001','7f4ba9ec-0cf5-4671-b725-89160062b3f2','accepted','2026-10-02 18:47:06','2026-10-02 18:47:06',0,NULL),(19,'cust-0001-0001-0001-000000000001','22b0c62f-5eb2-44c7-9390-7278813ce022','pending','2026-10-02 22:20:31','2026-10-02 22:20:31',0,NULL),(20,'cust-0001-0001-0001-000000000001','2ea62181-8702-4158-bdb0-8a74cce1203a','accepted','2026-10-02 22:25:39','2026-10-02 22:25:39',0,NULL),(24,'cust-0001-0001-0001-000000000001','606628a7-c19a-41ac-9a7b-163163c40528','accepted','2026-10-02 22:36:09','2026-10-02 22:36:09',0,NULL),(25,'cust-0001-0001-0001-000000000001','0eda6604-5c2f-4362-8122-de554991eb70','accepted','2026-10-02 22:43:16','2026-10-02 22:43:16',0,NULL),(27,'cust-0001-0001-0001-000000000001','94f2301e-6023-4da6-a795-2e8c67a86b4a','accepted','2026-10-02 22:44:42','2026-10-02 22:44:42',0,NULL),(28,'cust-0001-0001-0001-000000000001','e87d0806-de1f-4e7f-af54-4b913a78a863','accepted','2026-10-02 22:46:48','2026-10-02 22:46:48',0,NULL),(29,'cust-0001-0001-0001-000000000001','51171495-3bc0-4127-89af-a7ee7a0ab060','accepted','2026-10-02 23:14:49','2026-10-02 23:14:49',0,NULL),(30,'cust-0001-0001-0001-000000000001','2c6a23af-2899-4b0d-8478-193150e36b13','accepted','2026-10-03 00:21:36','2026-10-03 00:21:36',0,NULL),(31,'cust-0001-0001-0001-000000000001','13d5e767-e056-43d6-9c1a-8980b5e0ca76','accepted','2026-10-03 00:22:46','2026-10-03 00:22:46',0,NULL),(35,'cust-0001-0001-0001-000000000001','65b10a74-87ba-4d68-aa19-37ee5f2d70ef','accepted','2026-10-03 01:54:34','2026-10-03 01:54:34',0,NULL),(36,'cust-0001-0001-0001-000000000001','32f4cfde-63fa-4dd6-b61b-ebe18b386c16','accepted','2026-10-03 01:55:42','2026-10-03 01:55:42',0,NULL),(38,'cust-0001-0001-0001-000000000001','7c283a37-52ed-4cf7-98c3-d5dc5f96fd47','pending','2026-10-03 04:38:19','2026-10-03 04:38:19',0,NULL),(39,'cust-0001-0001-0001-000000000001','a74c45ae-898d-4baf-9834-ebf707676fe5','accepted','2026-10-03 04:42:45','2026-10-03 04:42:45',0,NULL),(40,'cust-0001-0001-0001-000000000001','b28e789d-81b8-44dc-a4f8-a15b0d576f62','pending','2026-10-03 04:44:40','2026-10-03 04:44:40',0,NULL),(41,'cust-0001-0001-0001-000000000001','d47f0738-a79b-4abe-a94a-0a87a9aba0d0','accepted','2026-10-03 20:28:52','2026-10-03 20:28:52',0,NULL),(45,'cust-0001-0001-0001-000000000001','df2a93b3-02b3-42aa-920a-ed1a3703e8e9','accepted','2026-10-03 20:31:06','2026-10-03 20:31:06',0,NULL),(49,'0978aaa3-bde3-4438-a245-b9c7dbebfd62','prvd-0001-0001-0001-000000000001','accepted','2026-10-04 07:06:28','2026-10-04 07:06:28',0,NULL),(50,'266d8d8f-6d7e-4a24-b55b-cc1a75a950f0','31f1bff9-432d-48ab-8e12-dcfc38d46069','canceled','2026-10-05 03:22:50','2026-10-05 03:22:50',0,NULL),(51,'0978aaa3-bde3-4438-a245-b9c7dbebfd62','prvd-0001-0001-0001-000000000001','ongoing','2026-10-07 14:30:10','2026-10-07 14:30:10',0,NULL),(52,'0978aaa3-bde3-4438-a245-b9c7dbebfd62','sman-0001-0001-0001-000000000001','completed','2026-10-07 14:32:40','2026-10-07 14:32:40',0,NULL),(53,'31f1bff9-432d-48ab-8e12-dcfc38d46069','793bc200-73cc-4d88-b168-8fbc6d014840','accepted','2026-10-07 17:11:03','2026-10-07 17:11:03',0,NULL),(54,'b88bab80-6999-4fb8-975d-2c8f0694ccb8','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-09 17:47:49','2026-10-09 17:47:49',0,NULL),(55,'3340ac66-4cb5-47fd-abbb-945c7265642a','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-12 10:41:40','2026-10-12 10:41:40',0,NULL),(56,'7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-12 10:45:44','2026-10-12 10:45:44',0,NULL),(57,'7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62','sman-0001-0001-0001-000000000001','accepted','2026-10-12 11:44:57','2026-10-12 11:44:57',0,NULL),(60,'92960767-886f-457e-9ca1-dd880dfed02c','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-12 14:12:51','2026-10-12 14:12:51',0,NULL),(61,'92960767-886f-457e-9ca1-dd880dfed02c','sman-0001-0001-0001-000000000001','accepted','2026-10-12 14:14:28','2026-10-12 14:14:28',0,NULL),(62,'92960767-886f-457e-9ca1-dd880dfed02c','sman-0001-0001-0001-000000000001','ongoing','2026-10-12 15:21:04','2026-10-12 15:21:04',0,NULL),(63,'92960767-886f-457e-9ca1-dd880dfed02c','sman-0001-0001-0001-000000000001','completed','2026-10-12 15:21:32','2026-10-12 15:21:32',0,NULL),(64,'9b60556f-f7bf-442a-bd28-812410ad43ab','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-12 18:15:29','2026-10-12 18:15:29',0,NULL),(65,'9b60556f-f7bf-442a-bd28-812410ad43ab','sman-0001-0001-0001-000000000001','accepted','2026-10-12 18:17:25','2026-10-12 18:17:25',0,NULL),(66,'de1f2f03-b0e8-4f30-9ea5-1347f479359e','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-13 10:04:05','2026-10-13 10:04:05',0,NULL),(67,'de1f2f03-b0e8-4f30-9ea5-1347f479359e','sman-0001-0001-0001-000000000001','accepted','2026-10-13 14:16:52','2026-10-13 14:16:52',0,NULL),(68,'3164cc17-5142-4fec-9ad8-0d8630191ca6','8be51d97-6fe0-4d46-a9c6-d77b4d2386f5','canceled','2026-10-13 15:38:24','2026-10-13 15:38:24',0,NULL),(69,'1ad4108d-50b7-4087-ae27-3a8c959c4247','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-13 18:06:00','2026-10-13 18:06:00',0,NULL),(70,'045e05ee-79de-4f7b-8f9e-5d3e81b159b9','6265773a-d7cd-4fe1-8325-cf39cf3a2ea2','accepted','2026-10-14 10:25:36','2026-10-14 10:25:36',1,NULL),(71,'7f3678b6-f9f3-42e5-a46d-5ad9ea81a162','44e6582d-b02a-4d6b-bfeb-5aa389e529cf','accepted','2026-10-14 10:30:58','2026-10-14 10:30:58',1,NULL),(72,'5f45385f-3e6e-433b-b1de-2f4b56143e03','1f11dec2-cc68-4c71-808e-7a7ce8e2373f','accepted','2026-10-14 10:33:25','2026-10-14 10:33:25',1,NULL),(73,'bac3a7c1-d2b8-4e37-9901-61a4e8216c9a','d1ac4acb-2d40-444e-8d75-345ca36b30f4','accepted','2026-10-14 10:34:43','2026-10-14 10:34:43',1,NULL),(74,'bc86c09e-6a09-4bc8-8018-0b0528d3fcd4','0b0a510f-61a2-49a8-af78-1e7a487938a4','accepted','2026-10-14 10:36:56','2026-10-14 10:36:56',1,NULL),(75,'d5925f5c-5bdb-4d34-895f-6cac40a9be7f','9b6c8600-396a-4606-88d9-a1e581d4ebbc','accepted','2026-10-14 10:37:08','2026-10-14 10:37:08',1,NULL),(76,'f7343c12-59cf-4ed2-8412-b100ecd83050','f44a28fa-6eb1-4a0b-aa32-602d7be66896','accepted','2026-10-14 10:37:45','2026-10-14 10:37:45',1,NULL),(77,'e90e21ac-aed6-45d4-b9b4-b4240f1da37d','3508fb57-9ac6-4177-946a-334d23f19a13','accepted','2026-10-14 10:38:11','2026-10-14 10:38:11',1,NULL),(78,'0d5bfd23-a8c9-4793-8bc4-40535c29c9ee','e417b5a9-e087-4a52-aaa0-6beb7df95559','accepted','2026-10-14 10:38:42','2026-10-14 10:38:42',1,NULL),(79,'4eb7f298-418b-45cd-b3d9-bb05329fbf50','8fb5c7e3-da6a-477e-88ef-2003c4bcb790','accepted','2026-10-14 10:39:21','2026-10-14 10:39:21',1,NULL),(80,'0f68ead5-e564-46ee-8eab-3acded861f93','c05d2ca3-4881-4060-955b-c4e48793798b','accepted','2026-10-14 10:43:50','2026-10-14 10:43:50',1,NULL),(81,'09aa1dcb-32ec-4230-9ef4-c71fed46410e','e1de451e-bad5-4468-801a-25346e13730a','accepted','2026-10-14 10:47:02','2026-10-14 10:47:02',1,NULL),(82,'a7664860-8d72-4543-99ac-a449b68f9249','a367bd15-4c46-45a5-9e01-43d6d78f3976','accepted','2026-10-14 10:51:20','2026-10-14 10:51:20',1,NULL),(83,'64b578a9-e217-4317-81db-6cce9704ba6a','0b533d1a-2e20-4f76-bd35-6eb17bc845ed','accepted','2026-10-14 10:54:22','2026-10-14 10:54:22',1,NULL),(84,'cb068c74-9139-43a0-bd6b-19f297d537b7','5502f459-26c8-466b-9e04-4c0dbf41445e','accepted','2026-10-14 10:55:49','2026-10-14 10:55:49',1,NULL),(85,'09aa1dcb-32ec-4230-9ef4-c71fed46410e','sman-0001-0001-0001-000000000001','accepted','2026-10-14 14:00:51','2026-10-14 14:00:51',0,NULL),(86,'09aa1dcb-32ec-4230-9ef4-c71fed46410e','sman-0001-0001-0001-000000000001','ongoing','2026-10-14 14:05:15','2026-10-14 14:05:15',0,NULL),(87,'09aa1dcb-32ec-4230-9ef4-c71fed46410e','sman-0001-0001-0001-000000000001','completed','2026-10-14 14:05:52','2026-10-14 14:05:52',0,NULL),(88,'d23f021f-76e8-46cb-886b-e629552fe499','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-14 14:30:03','2026-10-14 14:30:03',0,NULL),(89,'d662278a-b37c-4b0c-adae-01ce044bc49d','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-14 16:41:46','2026-10-14 16:41:46',0,NULL),(90,'ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-14 17:34:37','2026-10-14 17:34:37',0,NULL),(91,'b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-14 18:19:14','2026-10-14 18:19:14',0,NULL),(92,'44b8a2b5-a07e-407d-864c-ad75d6bd7eb9','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-15 10:17:10','2026-10-15 10:17:10',0,NULL),(93,'dbca7d1b-7afb-4bed-9bdc-bae32d87c53c','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-15 10:50:41','2026-10-15 10:50:41',0,NULL),(94,'b3b5a47b-29dd-4dd3-babd-7397e8935a44','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-15 11:51:10','2026-10-15 11:51:10',0,NULL),(95,'e3948edf-bb94-4b2e-aae3-347ea82ddeb3','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-15 12:16:21','2026-10-15 12:16:21',0,NULL),(96,'c288a76f-082e-41b1-8bd6-f21ae91729b0','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-15 12:36:34','2026-10-15 12:36:34',0,NULL),(97,'f85b4243-7dbe-4b19-b044-ef1c99b7abb6','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-15 14:49:45','2026-10-15 14:49:45',0,NULL),(98,'68dc44cd-8dda-4e86-be4c-b8c228da89b4','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-15 15:48:48','2026-10-15 15:48:48',0,NULL),(99,'ee5de3cc-d7a0-4932-8320-c564d8dae66b','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-15 17:34:28','2026-10-15 17:34:28',0,NULL),(100,'2f018e52-fdb8-4f46-9553-60eea6807e89','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-15 17:49:29','2026-10-15 17:49:29',0,NULL),(101,'0123f3e2-f818-46c7-aca2-d229fb029299','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-16 09:50:26','2026-10-16 09:50:26',0,NULL),(102,'0123f3e2-f818-46c7-aca2-d229fb029299','sman-0001-0001-0001-000000000001','accepted','2026-10-16 10:30:41','2026-10-16 10:30:41',0,NULL),(103,'2f018e52-fdb8-4f46-9553-60eea6807e89','sman-0001-0001-0001-000000000001','accepted','2026-10-16 10:30:51','2026-10-16 10:30:51',0,NULL),(104,'7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62','sman-0001-0001-0001-000000000001','ongoing','2026-10-16 10:37:54','2026-10-16 10:37:54',0,NULL),(105,'7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62','sman-0001-0001-0001-000000000001','completed','2026-10-16 10:39:57','2026-10-16 10:39:57',0,NULL),(106,'d9ac8ce7-35be-45b6-a83a-dcee2fc0aaf2','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-18 20:06:51','2026-10-18 20:06:51',0,NULL),(107,'d9ac8ce7-35be-45b6-a83a-dcee2fc0aaf2','sman-0001-0001-0001-000000000001','accepted','2026-10-18 20:07:30','2026-10-18 20:07:30',0,NULL),(108,'03009368-b8e9-4122-845c-35058d02a231','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-18 20:12:55','2026-10-18 20:12:55',0,NULL),(109,'2e667db0-22d4-4f2c-a3f3-fd6edc0ac096','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-18 20:15:49','2026-10-18 20:15:49',0,NULL),(110,'2e667db0-22d4-4f2c-a3f3-fd6edc0ac096','sman-0001-0001-0001-000000000001','accepted','2026-10-18 20:16:24','2026-10-18 20:16:24',0,NULL),(111,'2e667db0-22d4-4f2c-a3f3-fd6edc0ac096','sman-0001-0001-0001-000000000001','ongoing','2026-10-18 20:18:11','2026-10-18 20:18:11',0,NULL),(112,'2e667db0-22d4-4f2c-a3f3-fd6edc0ac096','sman-0001-0001-0001-000000000001','completed','2026-10-18 20:19:54','2026-10-18 20:19:54',0,NULL),(113,'6e5eebe2-d583-4ff4-a801-198228365253','31f1bff9-432d-48ab-8e12-dcfc38d46069','accepted','2026-10-18 20:50:30','2026-10-18 20:50:30',0,NULL),(114,'6e5eebe2-d583-4ff4-a801-198228365253','sman-0001-0001-0001-000000000001','accepted','2026-10-18 20:51:21','2026-10-18 20:51:21',0,NULL),(115,'6e5eebe2-d583-4ff4-a801-198228365253','sman-0001-0001-0001-000000000001','ongoing','2026-10-18 20:52:54','2026-10-18 20:52:54',0,NULL),(123,'1a71cd0f-8b05-4b13-9f7c-ae84a2cf7bff','cust-0001-0001-0001-000000000001','accepted','2026-10-27 12:21:04','2026-10-27 12:21:04',0,NULL),(124,'b5814625-ca70-4c33-9549-46fd4e0fd52e','cust-0001-0001-0001-000000000001','accepted','2026-10-27 12:28:32','2026-10-27 12:28:32',0,NULL),(125,'b5814625-ca70-4c33-9549-46fd4e0fd52e','sman-0001-0001-0001-000000000001','accepted','2026-10-27 12:28:51','2026-10-27 12:28:51',0,NULL),(126,'e3421053-1718-494d-b96f-ae231ced63af','cust-0001-0001-0001-000000000001','accepted','2026-10-27 14:51:20','2026-10-27 14:51:20',0,NULL),(127,'e3421053-1718-494d-b96f-ae231ced63af','sman-0001-0001-0001-000000000001','accepted','2026-10-27 14:51:59','2026-10-27 14:51:59',0,NULL),(128,'e3421053-1718-494d-b96f-ae231ced63af','sman-0001-0001-0001-000000000001','ongoing','2026-10-27 15:19:44','2026-10-27 15:19:44',0,NULL),(129,'4a186688-74fb-45be-86ba-5ac62d7ea342','cust-0001-0001-0001-000000000001','accepted','2026-10-27 15:20:56','2026-10-27 15:20:56',0,NULL),(130,'7f7da454-3ef2-413f-9c1d-99f868008536','cust-0001-0001-0001-000000000001','accepted','2026-10-27 15:37:22','2026-10-27 15:37:22',0,NULL),(131,'7f7da454-3ef2-413f-9c1d-99f868008536','cust-0001-0001-0001-000000000001','canceled','2026-10-27 15:38:00','2026-10-27 15:38:00',0,NULL),(132,'32982b71-73c9-490f-8ad3-dc9733458339','cust-0001-0001-0001-000000000001','accepted','2026-10-27 15:38:32','2026-10-27 15:38:32',0,NULL),(133,'32982b71-73c9-490f-8ad3-dc9733458339','prvd-0001-0001-0001-000000000001','accepted','2026-10-27 15:42:59','2026-10-27 15:42:59',0,NULL),(134,'eb4fefb9-aa35-42ad-bb9d-0411fd4dde39','cust-0001-0001-0001-000000000001','accepted','2026-10-27 15:47:40','2026-10-27 15:47:40',0,NULL),(135,'b6242049-0682-4e0d-982f-c9de3f4e7ef9','cust-0001-0001-0001-000000000001','accepted','2026-10-27 15:54:17','2026-10-27 15:54:17',0,NULL),(136,'2033219c-7431-4ac6-a51f-264abfed80eb','cust-0001-0001-0001-000000000001','accepted','2026-10-27 16:03:04','2026-10-27 16:03:04',0,NULL),(137,'031a9851-64e3-4561-a94d-cc0b0070638d','cust-0001-0001-0001-000000000001','accepted','2026-10-27 17:01:17','2026-10-27 17:01:17',0,NULL),(138,'031a9851-64e3-4561-a94d-cc0b0070638d','sman-0001-0001-0001-000000000001','accepted','2026-10-27 17:01:58','2026-10-27 17:01:58',0,NULL),(139,'e27c6207-9e5d-4549-b181-73451ad964d4','cust-0001-0001-0001-000000000001','accepted','2026-10-27 17:28:31','2026-10-27 17:28:31',0,NULL);
/*!40000 ALTER TABLE `booking_status_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `readable_id` bigint NOT NULL,
  `customer_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_booking_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_tax_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `service_schedule` datetime DEFAULT NULL,
  `service_address_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serviceman_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferred_serviceman_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'customer book-again: pehle isi serviceman ko request bhejni hai',
  `total_campaign_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_coupon_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `coupon_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_checked` tinyint(1) NOT NULL DEFAULT '0',
  `additional_charge` decimal(24,2) NOT NULL DEFAULT '0.00',
  `additional_tax_amount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `additional_discount_amount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `additional_campaign_discount_amount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `removed_coupon_amount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `evidence_photos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `booking_otp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_guest` tinyint(1) NOT NULL DEFAULT '0',
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `extra_fee` decimal(24,3) NOT NULL DEFAULT '0.000',
  `total_referral_discount_amount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `is_repeated` tinyint NOT NULL DEFAULT '0',
  `assigned_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer' COMMENT 'customer,provider',
  `service_address_location` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `auto_assigned` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = booking is going through auto-assign flow',
  `auto_assign_expires_at` timestamp NULL DEFAULT NULL COMMENT 'current provider timer deadline',
  `assigned_provider_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'provider who finally accepted the auto-assigned booking',
  `serviceman_assign_expires_at` timestamp NULL DEFAULT NULL COMMENT 'current serviceman timer deadline',
  `serviceman_cancel_blocked` json DEFAULT NULL,
  `cancelled_by_serviceman_at` timestamp NULL DEFAULT NULL,
  `assignment_mode` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'auto | provider_manual',
  `serviceman_assign_customer_notified` tinyint NOT NULL DEFAULT '0' COMMENT '0|1',
  `serviceman_assign_provider_notified` tinyint NOT NULL DEFAULT '0',
  `start_otp` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'serviceman arrival OTP (start ke liye)',
  `start_otp_generated_at` timestamp NULL DEFAULT NULL,
  `serviceman_reached_at` timestamp NULL DEFAULT NULL,
  `is_re_service` tinyint NOT NULL DEFAULT '0' COMMENT '1 = unsatisfied flow se bani free re-service booking',
  `re_service_of` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'original booking jisme customer unsatisfied hua',
  PRIMARY KEY (`id`),
  KEY `bookings_customer_id_index` (`customer_id`),
  KEY `bookings_provider_id_index` (`provider_id`),
  KEY `bookings_serviceman_id_index` (`serviceman_id`),
  KEY `bookings_booking_status_index` (`booking_status`),
  KEY `bookings_zone_sub_category_index` (`zone_id`,`sub_category_id`),
  KEY `bookings_readable_id_index` (`readable_id`),
  KEY `bookings_transaction_id_index` (`transaction_id`),
  KEY `bookings_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES ('0123f3e2-f818-46c7-aca2-d229fb029299',1062,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','accepted',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-16 10:22:14','75','2026-10-16 09:50:26','2026-10-16 10:30:41','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'622892',0,0,0.000,0.00,0,NULL,'customer','{\"id\":75,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-16T04:50:26.000000Z\",\"updated_at\":\"2026-10-16T04:50:26.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"sa\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,1,NULL,NULL,NULL,0,NULL),('03009368-b8e9-4122-845c-35058d02a231',1064,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-18 20:44:43','77','2026-10-18 20:12:55','2026-10-18 20:20:03','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'882547',0,0,0.000,0.00,0,NULL,'customer','{\"id\":77,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-18T15:12:55.000000Z\",\"updated_at\":\"2026-10-18T15:12:55.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"ne\",\"floor\":\"en\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('031a9851-64e3-4561-a94d-cc0b0070638d',1076,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49','accepted',0,'cash_after_service','cash-payment',10.000,0.000,0.000,'2026-10-27 17:33:11','98','2026-10-27 17:01:16','2026-10-27 17:01:58','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'188194',0,0,0.000,0.00,0,NULL,'customer','{\"id\":98,\"user_id\":null,\"lat\":\"26.8381\",\"lon\":\"80.9346001\",\"city\":\"Lucknow\",\"street\":\"Station road\",\"zip_code\":\"226027\",\"country\":\"India\",\"address\":\"Lucknow, Uttar Pradesh, 226027, India\",\"created_at\":\"2026-10-27T12:01:16.000000Z\",\"updated_at\":\"2026-10-27T12:01:16.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Rahul Verma\",\"contact_person_number\":\"+919123456780\",\"address_label\":\"home\",\"zone_id\":\"6b1c8733-b0ff-4c65-a745-1f46419adc49\",\"is_guest\":0,\"house\":\"sasa\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,1,NULL,NULL,NULL,0,NULL),('045e05ee-79de-4f7b-8f9e-5d3e81b159b9',1034,'6265773a-d7cd-4fe1-8325-cf39cf3a2ea2','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','47','2026-10-14 10:25:35','2026-10-14 10:26:37','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'306270',1,0,0.000,0.00,0,NULL,'customer','{\"id\":47,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Live Test Street, Karnal\",\"created_at\":\"2026-10-14T05:25:35.000000Z\",\"updated_at\":\"2026-10-14T05:25:35.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"Live Test\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('0978aaa3-bde3-4438-a245-b9c7dbebfd62',1022,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','completed',1,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-09-26 13:31:12','15','2026-09-26 20:59:22','2026-10-07 14:32:40','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,'[{\"image\":\"2026-10-07-6ac611b7d6941.webp\",\"storage\":\"public\"}]','373934',0,0,0.000,0.00,0,NULL,'customer','{\"id\":15,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"\",\"zip_code\":\"\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-09-26T07:59:22.000000Z\",\"updated_at\":\"2026-09-26T07:59:22.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"\",\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('09aa1dcb-32ec-4230-9ef4-c71fed46410e',1045,'e1de451e-bad5-4468-801a-25346e13730a','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','completed',1,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','58','2026-10-14 10:47:02','2026-10-14 14:05:52','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,'[]','315805',1,0,0.000,0.00,0,NULL,'customer','{\"id\":58,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Fresh Test\",\"created_at\":\"2026-10-14T05:47:02.000000Z\",\"updated_at\":\"2026-10-14T05:47:02.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"FT\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'provider_manual',1,1,'858154','2026-10-14 14:04:18','2026-10-14 14:04:18',0,NULL),('0d5bfd23-a8c9-4793-8bc4-40535c29c9ee',1042,'e417b5a9-e087-4a52-aaa0-6beb7df95559','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','55','2026-10-14 10:38:42','2026-10-14 10:40:33','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'682861',1,0,0.000,0.00,0,NULL,'customer','{\"id\":55,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Fresh Test\",\"created_at\":\"2026-10-14T05:38:42.000000Z\",\"updated_at\":\"2026-10-14T05:38:42.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"FT\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('0f68ead5-e564-46ee-8eab-3acded861f93',1044,'c05d2ca3-4881-4060-955b-c4e48793798b',NULL,'c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','57','2026-10-14 10:43:50','2026-10-14 14:11:02','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'538792',1,0,0.000,0.00,0,NULL,'customer','{\"id\":57,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Fresh Test\",\"created_at\":\"2026-10-14T05:43:50.000000Z\",\"updated_at\":\"2026-10-14T05:43:50.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"FT\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('1a71cd0f-8b05-4b13-9f7c-ae84a2cf7bff',1067,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49','pending',0,'cash_after_service','cash-payment',4128.820,629.820,0.000,'2026-10-27 12:53:00','89','2026-10-27 12:21:04','2026-10-27 12:25:03','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'552422',0,0,0.000,0.00,0,NULL,'customer','{\"id\":89,\"user_id\":null,\"lat\":\"26.8381\",\"lon\":\"80.9346001\",\"city\":\"Lucknow\",\"street\":\"Station road\",\"zip_code\":\"226027\",\"country\":\"India\",\"address\":\"Lucknow, Uttar Pradesh, 226027, India\",\"created_at\":\"2026-10-27T07:21:04.000000Z\",\"updated_at\":\"2026-10-27T07:21:04.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Rahul Verma\",\"contact_person_number\":\"+919123456780\",\"address_label\":\"home\",\"zone_id\":\"6b1c8733-b0ff-4c65-a745-1f46419adc49\",\"is_guest\":0,\"house\":\"aa\",\"floor\":\"aa\"}',0,NULL,NULL,NULL,NULL,NULL,'manual_required',1,1,NULL,NULL,NULL,0,NULL),('1ad4108d-50b7-4087-ae27-3a8c959c4247',1033,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-13 18:37:51','46','2026-10-13 18:06:00','2026-10-14 10:26:06','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'373825',0,0,0.000,0.00,0,NULL,'customer','{\"id\":46,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-13T13:06:00.000000Z\",\"updated_at\":\"2026-10-13T13:06:00.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"sd\",\"floor\":\"d\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('2033219c-7431-4ac6-a51f-264abfed80eb',1075,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49','pending',0,'cash_after_service','cash-payment',2948.820,449.820,0.000,'2026-10-27 16:34:59','97','2026-10-27 16:03:03','2026-10-27 16:06:38','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'775734',0,0,0.000,0.00,0,NULL,'customer','{\"id\":97,\"user_id\":null,\"lat\":\"26.8381\",\"lon\":\"80.9346001\",\"city\":\"Lucknow\",\"street\":\"Station road\",\"zip_code\":\"226027\",\"country\":\"India\",\"address\":\"Lucknow, Uttar Pradesh, 226027, India\",\"created_at\":\"2026-10-27T11:03:03.000000Z\",\"updated_at\":\"2026-10-27T11:03:03.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Rahul Verma\",\"contact_person_number\":\"+919123456780\",\"address_label\":\"home\",\"zone_id\":\"6b1c8733-b0ff-4c65-a745-1f46419adc49\",\"is_guest\":0,\"house\":\"sasa\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'manual_required',1,1,NULL,NULL,NULL,0,NULL),('266d8d8f-6d7e-4a24-b55b-cc1a75a950f0',1024,'31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,'a1614dbe-4732-11ee-9702-dee6e8d77be4','canceled',0,'cash_after_service','cash-payment',2948.820,449.820,0.000,'2026-10-03 18:00:00','17','2026-09-30 22:57:06','2026-10-05 03:22:50','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'460293',0,0,0.000,0.00,0,NULL,'customer','{\"id\":17,\"user_id\":null,\"lat\":\"27.176564035436\",\"lon\":\"78.0085409431095\",\"city\":\"Agra\",\"street\":\"\",\"zip_code\":\"280001\",\"country\":\"India\",\"address\":\"Agra, Uttar Pradesh, 280001, India\",\"created_at\":\"2026-09-30T09:57:06.000000Z\",\"updated_at\":\"2026-09-30T09:57:06.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"a1614dbe-4732-11ee-9702-dee6e8d77be4\",\"is_guest\":0,\"house\":\"\",\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('2e667db0-22d4-4f2c-a3f3-fd6edc0ac096',1065,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','completed',1,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-18 20:47:42','78','2026-10-18 20:15:49','2026-10-18 20:19:54','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,'[{\"image\":\"2026-10-18-6ad4e39a70d16.webp\",\"storage\":\"public\"}]','107192',0,0,0.000,0.00,0,NULL,'customer','{\"id\":78,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-18T15:15:49.000000Z\",\"updated_at\":\"2026-10-18T15:15:49.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"ne\",\"floor\":\"en\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,1,'774997','2026-10-18 20:16:57','2026-10-18 20:16:57',0,NULL),('2f018e52-fdb8-4f46-9553-60eea6807e89',1061,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','accepted',0,'cash_after_service','cash-payment',1309.800,199.800,0.000,'2026-10-15 18:21:24','74','2026-10-15 17:49:29','2026-10-16 10:30:51','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'817360',0,0,0.000,0.00,0,NULL,'customer','{\"id\":74,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-15T12:49:29.000000Z\",\"updated_at\":\"2026-10-15T12:49:29.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,1,NULL,NULL,NULL,0,NULL),('3164cc17-5142-4fec-9ad8-0d8630191ca6',1030,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','canceled',1,'cash_after_service',NULL,0.000,0.000,0.000,'2026-10-12 16:32:55','41','2026-10-12 16:32:55','2026-10-13 15:38:24','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0,0,0.000,0.00,0,NULL,'customer','{\"id\":41,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-12T09:12:51.000000Z\",\"updated_at\":\"2026-10-12T09:12:51.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"\",\"floor\":\"\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,0,NULL,NULL,NULL,1,'92960767-886f-457e-9ca1-dd880dfed02c'),('32982b71-73c9-490f-8ad3-dc9733458339',1072,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49','accepted',0,'cash_after_service','cash-payment',10.000,0.000,0.000,'2026-10-27 16:10:23','94','2026-10-27 15:38:32','2026-10-27 15:42:59','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'710634',0,0,0.000,0.00,0,NULL,'customer','{\"id\":94,\"user_id\":null,\"lat\":\"26.8381\",\"lon\":\"80.9346001\",\"city\":\"Lucknow\",\"street\":\"Station road\",\"zip_code\":\"226027\",\"country\":\"India\",\"address\":\"Lucknow, Uttar Pradesh, 226027, India\",\"created_at\":\"2026-10-27T10:38:31.000000Z\",\"updated_at\":\"2026-10-27T10:38:31.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Rahul Verma\",\"contact_person_number\":\"+919123456780\",\"address_label\":\"home\",\"zone_id\":\"6b1c8733-b0ff-4c65-a745-1f46419adc49\",\"is_guest\":0,\"house\":\"sasa\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'manual_required',1,1,NULL,NULL,NULL,0,NULL),('3304fbdd-50cd-4f25-b89a-b58f5fbc3a15',1023,'31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,'a1614dbe-4732-11ee-9702-dee6e8d77be4','pending',0,'cash_after_service','cash-payment',2948.820,449.820,0.000,'2026-09-28 18:38:33','16','2026-09-29 02:08:12','2026-09-29 02:08:12','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'446317',0,0,0.000,0.00,0,NULL,'customer','{\"id\":16,\"user_id\":null,\"lat\":\"11.3304967175155\",\"lon\":\"78.60833548989203\",\"city\":\"\",\"street\":\"\",\"zip_code\":\"\",\"country\":\"India\",\"address\":\"Tamil Nadu, India\",\"created_at\":\"2026-09-28T13:08:12.000000Z\",\"updated_at\":\"2026-09-28T13:08:12.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"a1614dbe-4732-11ee-9702-dee6e8d77be4\",\"is_guest\":0,\"house\":\"\",\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('3340ac66-4cb5-47fd-abbb-945c7265642a',1027,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000002','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',10.000,0.000,0.000,'2026-10-12 11:12:24','37','2026-10-12 10:41:39','2026-10-13 16:22:06','bc250cc5-990b-4864-aac1-c8dde7b63427','8a904eea-a4ce-4482-8100-abd9f8cd8a69',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'226285',0,0,0.000,0.00,0,NULL,'customer','{\"id\":37,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-12T05:41:39.000000Z\",\"updated_at\":\"2026-10-12T05:41:39.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('44b8a2b5-a07e-407d-864c-ad75d6bd7eb9',1053,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-15 10:49:00','66','2026-10-15 10:17:10','2026-10-15 10:18:13','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'470464',0,0,0.000,0.00,0,NULL,'customer','{\"id\":66,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-15T05:17:10.000000Z\",\"updated_at\":\"2026-10-15T05:17:10.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('4a186688-74fb-45be-86ba-5ac62d7ea342',1070,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49','pending',0,'cash_after_service','cash-payment',10.000,0.000,0.000,'2026-10-27 15:52:50','92','2026-10-27 15:20:55','2026-10-27 15:23:19','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'239602',0,0,0.000,0.00,0,NULL,'customer','{\"id\":92,\"user_id\":null,\"lat\":\"26.8381\",\"lon\":\"80.9346001\",\"city\":\"Lucknow\",\"street\":\"Station road\",\"zip_code\":\"226027\",\"country\":\"India\",\"address\":\"Lucknow, Uttar Pradesh, 226027, India\",\"created_at\":\"2026-10-27T10:20:54.000000Z\",\"updated_at\":\"2026-10-27T10:20:54.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Rahul Verma\",\"contact_person_number\":\"+919123456780\",\"address_label\":\"home\",\"zone_id\":\"6b1c8733-b0ff-4c65-a745-1f46419adc49\",\"is_guest\":0,\"house\":\"se\",\"floor\":\"se\"}',0,NULL,NULL,NULL,NULL,NULL,'manual_required',1,1,NULL,NULL,NULL,0,NULL),('4eb7f298-418b-45cd-b3d9-bb05329fbf50',1043,'8fb5c7e3-da6a-477e-88ef-2003c4bcb790','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','56','2026-10-14 10:39:21','2026-10-14 14:11:41','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'913555',1,0,0.000,0.00,0,NULL,'customer','{\"id\":56,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Fresh Test\",\"created_at\":\"2026-10-14T05:39:21.000000Z\",\"updated_at\":\"2026-10-14T05:39:21.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"FT\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('5f45385f-3e6e-433b-b1de-2f4b56143e03',1036,'1f11dec2-cc68-4c71-808e-7a7ce8e2373f','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','49','2026-10-14 10:33:25','2026-10-14 10:34:33','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'178386',1,0,0.000,0.00,0,NULL,'customer','{\"id\":49,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Live Test Street, Karnal\",\"created_at\":\"2026-10-14T05:33:25.000000Z\",\"updated_at\":\"2026-10-14T05:33:25.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"Live Test\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('64b578a9-e217-4317-81db-6cce9704ba6a',1047,'0b533d1a-2e20-4f76-bd35-6eb17bc845ed','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','60','2026-10-14 10:54:22','2026-10-23 10:37:05','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'243884',1,0,0.000,0.00,0,NULL,'customer','{\"id\":60,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Fresh Test\",\"created_at\":\"2026-10-14T05:54:21.000000Z\",\"updated_at\":\"2026-10-14T05:54:21.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"FT\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'manual_required',1,1,NULL,NULL,NULL,0,NULL),('68dc44cd-8dda-4e86-be4c-b8c228da89b4',1059,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-15 16:20:41','72','2026-10-15 15:48:48','2026-10-15 15:53:16','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'711872',0,0,0.000,0.00,0,NULL,'customer','{\"id\":72,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-15T10:48:48.000000Z\",\"updated_at\":\"2026-10-15T10:48:48.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('6e5eebe2-d583-4ff4-a801-198228365253',1066,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','ongoing',0,'cash_after_service','cash-payment',2400.180,198.180,0.000,'2026-10-18 21:22:23','79','2026-10-18 20:50:30','2026-10-19 13:18:05','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,1101.00,0.00,0.00,0.00,0.00,'[]','595427',0,0,0.000,0.00,0,NULL,'customer','{\"id\":79,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-18T15:50:30.000000Z\",\"updated_at\":\"2026-10-18T15:50:30.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"new\",\"floor\":\"new\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,1,'776065','2026-10-18 20:51:52','2026-10-18 20:51:52',0,NULL),('6fe2ffa1-c8c4-4575-85a8-f2e3f1bfb1ca',1021,'31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,'a1614dbe-4732-11ee-9702-dee6e8d77be4','pending',0,'cash_after_service','cash-payment',2948.820,449.820,0.000,'2026-09-22 10:57:10','14','2026-09-22 18:25:21','2026-09-22 18:25:21','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'400916',0,0,0.000,0.00,0,NULL,'customer','{\"id\":14,\"user_id\":null,\"lat\":\"27.177880644613197\",\"lon\":\"78.00970967976555\",\"city\":\"Agra\",\"street\":\"\",\"zip_code\":\"280001\",\"country\":\"India\",\"address\":\"Subhash Bazaar, Shahganj, Agra, Uttar Pradesh, 280001, India\",\"created_at\":\"2026-09-22T05:25:21.000000Z\",\"updated_at\":\"2026-09-22T05:25:21.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"a1614dbe-4732-11ee-9702-dee6e8d77be4\",\"is_guest\":0,\"house\":\"\",\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('793bc200-73cc-4d88-b168-8fbc6d014840',1025,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-07 17:42:52','35','2026-10-07 17:11:03','2026-10-07 17:12:24','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'145256',0,0,0.000,0.00,0,NULL,'customer','{\"id\":35,\"user_id\":null,\"lat\":\"28.614749472732026\",\"lon\":\"77.20959410960275\",\"city\":\"New Delhi\",\"street\":\"\",\"zip_code\":\"\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-07T12:11:03.000000Z\",\"updated_at\":\"2026-10-07T12:11:03.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"\",\"floor\":\"\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',0,0,NULL,NULL,NULL,0,NULL),('7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62',1028,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','completed',1,'cash_after_service','cash-payment',1748.180,198.180,0.000,'2026-10-12 11:17:20','38','2026-10-12 10:45:44','2026-10-16 10:39:57','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,449.00,0.00,0.00,0.00,0.00,'[{\"image\":\"2026-10-16-6ad1b8ad61be0.webp\",\"storage\":\"public\"}]','837329',0,0,0.000,0.00,0,NULL,'customer','{\"id\":38,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-12T05:45:44.000000Z\",\"updated_at\":\"2026-10-12T05:45:44.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,0,'664971','2026-10-16 10:36:36','2026-10-16 10:36:36',0,NULL),('7f3678b6-f9f3-42e5-a46d-5ad9ea81a162',1035,'44e6582d-b02a-4d6b-bfeb-5aa389e529cf','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','48','2026-10-14 10:30:58','2026-10-14 10:32:38','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'942128',1,0,0.000,0.00,0,NULL,'customer','{\"id\":48,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Live Test Street, Karnal\",\"created_at\":\"2026-10-14T05:30:58.000000Z\",\"updated_at\":\"2026-10-14T05:30:58.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"Live Test\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('7f7da454-3ef2-413f-9c1d-99f868008536',1071,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000002','6b1c8733-b0ff-4c65-a745-1f46419adc49','canceled',0,'cash_after_service','cash-payment',1110.000,0.000,0.000,'2026-10-27 16:09:15','93','2026-10-27 15:37:21','2026-10-27 15:38:00','bc250cc5-990b-4864-aac1-c8dde7b63427','8a904eea-a4ce-4482-8100-abd9f8cd8a69',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'222312',0,0,0.000,0.00,0,NULL,'customer','{\"id\":93,\"user_id\":null,\"lat\":\"26.8381\",\"lon\":\"80.9346001\",\"city\":\"Lucknow\",\"street\":\"Station road\",\"zip_code\":\"226027\",\"country\":\"India\",\"address\":\"Lucknow, Uttar Pradesh, 226027, India\",\"created_at\":\"2026-10-27T10:37:20.000000Z\",\"updated_at\":\"2026-10-27T10:37:20.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Rahul Verma\",\"contact_person_number\":\"+919123456780\",\"address_label\":\"home\",\"zone_id\":\"6b1c8733-b0ff-4c65-a745-1f46419adc49\",\"is_guest\":0,\"house\":\"sasa\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'manual_required',0,0,NULL,NULL,NULL,0,NULL),('92960767-886f-457e-9ca1-dd880dfed02c',1029,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','completed',1,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-12 14:44:45','41','2026-10-12 14:12:51','2026-10-12 15:21:32','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,'[{\"image\":\"2026-10-12-6accb4abd2c97.webp\",\"storage\":\"public\"}]','107575',0,0,0.000,0.00,0,NULL,'customer','{\"id\":41,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-12T09:12:51.000000Z\",\"updated_at\":\"2026-10-12T09:12:51.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"\",\"floor\":\"\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,0,'970832','2026-10-12 15:19:43','2026-10-12 15:19:43',0,NULL),('9b60556f-f7bf-442a-bd28-812410ad43ab',1031,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','accepted',0,'cash_after_service','cash-payment',1101.000,0.000,0.000,'2026-10-12 18:47:23','42','2026-10-12 18:15:29','2026-10-12 18:17:25','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'308825',0,0,0.000,0.00,0,NULL,'provider','{\"id\":42,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"\",\"street\":\"\",\"zip_code\":\"\",\"country\":\"\",\"address\":\"\",\"created_at\":\"2026-10-12T13:15:29.000000Z\",\"updated_at\":\"2026-10-12T13:15:29.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":null,\"is_guest\":0,\"house\":\"\",\"floor\":\"\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,0,NULL,NULL,NULL,0,NULL),('a7664860-8d72-4543-99ac-a449b68f9249',1046,'a367bd15-4c46-45a5-9e01-43d6d78f3976','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','59','2026-10-14 10:51:20','2026-10-14 13:56:28','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'356706',1,0,0.000,0.00,0,NULL,'customer','{\"id\":59,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Fresh Test\",\"created_at\":\"2026-10-14T05:51:20.000000Z\",\"updated_at\":\"2026-10-14T05:51:20.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"FT\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('b3b5a47b-29dd-4dd3-babd-7397e8935a44',1055,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-15 12:23:07','68','2026-10-15 11:51:10','2026-10-15 11:51:38','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'677606',0,0,0.000,0.00,0,NULL,'customer','{\"id\":68,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-15T06:51:10.000000Z\",\"updated_at\":\"2026-10-15T06:51:10.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,'2026-10-15 11:53:38',NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('b5814625-ca70-4c33-9549-46fd4e0fd52e',1068,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49','accepted',0,'cash_after_service','cash-payment',2948.820,449.820,0.000,'2026-10-27 13:00:28','90','2026-10-27 12:28:32','2026-10-27 13:19:00','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'376417',0,0,0.000,0.00,0,NULL,'customer','{\"id\":90,\"user_id\":null,\"lat\":\"26.8381\",\"lon\":\"80.9346001\",\"city\":\"Lucknow\",\"street\":\"Station road\",\"zip_code\":\"226027\",\"country\":\"India\",\"address\":\"Lucknow, Uttar Pradesh, 226027, India\",\"created_at\":\"2026-10-27T07:28:32.000000Z\",\"updated_at\":\"2026-10-27T07:28:32.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Rahul Verma\",\"contact_person_number\":\"+919123456780\",\"address_label\":\"home\",\"zone_id\":\"6b1c8733-b0ff-4c65-a745-1f46419adc49\",\"is_guest\":0,\"house\":\"aa\",\"floor\":\"aa\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,1,'877241','2026-10-27 13:19:00','2026-10-27 13:19:00',0,NULL),('b6242049-0682-4e0d-982f-c9de3f4e7ef9',1074,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49','pending',0,'cash_after_service','cash-payment',10.000,0.000,0.000,'2026-10-27 16:26:13','96','2026-10-27 15:54:17','2026-10-27 15:56:34','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'612453',0,0,0.000,0.00,0,NULL,'customer','{\"id\":96,\"user_id\":null,\"lat\":\"26.8381\",\"lon\":\"80.9346001\",\"city\":\"Lucknow\",\"street\":\"Station road\",\"zip_code\":\"226027\",\"country\":\"India\",\"address\":\"Lucknow, Uttar Pradesh, 226027, India\",\"created_at\":\"2026-10-27T10:54:17.000000Z\",\"updated_at\":\"2026-10-27T10:54:17.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Rahul Verma\",\"contact_person_number\":\"+919123456780\",\"address_label\":\"home\",\"zone_id\":\"6b1c8733-b0ff-4c65-a745-1f46419adc49\",\"is_guest\":0,\"house\":\"sasa\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'manual_required',1,1,NULL,NULL,NULL,0,NULL),('b88bab80-6999-4fb8-975d-2c8f0694ccb8',1026,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1309.800,199.800,0.000,'2026-10-09 18:19:33','36','2026-10-09 17:47:47','2026-10-13 16:22:36','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'651236',0,0,0.000,0.00,0,NULL,'customer','{\"id\":36,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"\",\"zip_code\":\"we\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-09T12:47:47.000000Z\",\"updated_at\":\"2026-10-09T12:47:47.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"\",\"floor\":\"\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4',1052,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-14 18:51:09','65','2026-10-14 18:19:13','2026-10-14 18:20:37','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'484595',0,0,0.000,0.00,0,NULL,'customer','{\"id\":65,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-14T13:19:13.000000Z\",\"updated_at\":\"2026-10-14T13:19:13.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('bac3a7c1-d2b8-4e37-9901-61a4e8216c9a',1037,'d1ac4acb-2d40-444e-8d75-345ca36b30f4','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','50','2026-10-14 10:34:42','2026-10-14 10:36:04','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'808927',1,0,0.000,0.00,0,NULL,'customer','{\"id\":50,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Live Test Street, Karnal\",\"created_at\":\"2026-10-14T05:34:42.000000Z\",\"updated_at\":\"2026-10-14T05:34:42.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"Live Test\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('bc86c09e-6a09-4bc8-8018-0b0528d3fcd4',1038,'0b0a510f-61a2-49a8-af78-1e7a487938a4','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','51','2026-10-14 10:36:56','2026-10-14 10:38:05','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'450283',1,0,0.000,0.00,0,NULL,'customer','{\"id\":51,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Fresh Test\",\"created_at\":\"2026-10-14T05:36:56.000000Z\",\"updated_at\":\"2026-10-14T05:36:56.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"FT\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000001',1001,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'cash_after_service',NULL,2499.000,449.820,0.000,'2026-08-28 15:45:55','1','2026-08-27 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,'5678',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000002',1002,'cust-0001-0001-0001-000000000002','prvd-0001-0001-0001-000000000003','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'stripe',NULL,399.000,71.820,0.000,'2026-08-29 15:45:55','2','2026-08-28 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000009','sm-0001-0001-0001-000000000005',NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,'1234',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000003',1003,'cust-0001-0001-0001-000000000003','prvd-0001-0001-0001-000000000004','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'cash_after_service',NULL,499.000,89.820,0.000,'2026-08-31 15:45:55','3','2026-08-30 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000008','cat-0002-0001-0001-000000000014','sm-0001-0001-0001-000000000007',NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,'9012',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000004',1004,'cust-0001-0001-0001-000000000005','prvd-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'cash_after_service',NULL,1499.000,269.820,200.000,'2026-09-02 15:45:55','5','2026-09-01 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001','sm-0001-0001-0001-000000000002',NULL,0.000,200.000,'WELCOME200',1,0.00,0.00,0.00,0.00,0.00,NULL,'3456',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000005',1005,'cust-0001-0001-0001-000000000007','prvd-0001-0001-0001-000000000002','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'paystack',NULL,899.000,161.820,0.000,'2026-09-04 15:45:55','7','2026-09-03 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000002','cat-0002-0001-0001-000000000005','sm-0001-0001-0001-000000000003',NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,'7890',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000006',1006,'cust-0001-0001-0001-000000000008','prvd-0001-0001-0001-000000000005','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'cash_after_service',NULL,1999.000,359.820,0.000,'2026-09-05 15:45:55','8','2026-09-04 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000008','cat-0002-0001-0001-000000000013','sm-0001-0001-0001-000000000008',NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,'2345',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000007',1007,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000004','a1614dbe-4732-11ee-9702-dee6e8d77be4','ongoing',0,'cash_after_service',NULL,299.000,53.820,0.000,'2026-09-12 15:45:55','1','2026-09-12 13:45:55','2026-10-19 12:48:06','cat-0001-0001-0001-000000000002','cat-0002-0001-0001-000000000005','sm-0001-0001-0001-000000000007',NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,'4567',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000008',1008,'cust-0001-0001-0001-000000000004','prvd-0001-0001-0001-000000000003','a1614dbe-4732-11ee-9702-dee6e8d77be4','ongoing',1,'razor_pay',NULL,1499.000,269.820,0.000,'2026-09-12 15:45:55','4','2026-09-12 14:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000008','cat-0002-0001-0001-000000000012','sm-0001-0001-0001-000000000006',NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,'8901',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000009',1009,'cust-0001-0001-0001-000000000006','prvd-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4','accepted',0,'cash_after_service',NULL,799.000,143.820,0.000,'2026-09-13 15:45:55','6','2026-09-12 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000003',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0,0,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000010',1010,'cust-0001-0001-0001-000000000009','prvd-0001-0001-0001-000000000005','a1614dbe-4732-11ee-9702-dee6e8d77be4','accepted',0,'cash_after_service',NULL,499.000,89.820,0.000,'2026-09-13 15:45:55',NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000008','cat-0002-0001-0001-000000000014',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0,0,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000011',1011,'cust-0001-0001-0001-000000000010','prvd-0001-0001-0001-000000000002','a1614dbe-4732-11ee-9702-dee6e8d77be4','pending',0,'cash_after_service',NULL,1999.000,359.820,0.000,'2026-09-14 15:45:55',NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0,0,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000012',1012,'cust-0001-0001-0001-000000000003','prvd-0001-0001-0001-000000000004','a1614dbe-4732-11ee-9702-dee6e8d77be4','pending',0,'cash_after_service',NULL,1199.000,215.820,0.000,'2026-09-15 15:45:55','3','2026-09-12 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000007',NULL,NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0,0,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000013',1013,'cust-0001-0001-0001-000000000007','prvd-0001-0001-0001-000000000003','a1614dbe-4732-11ee-9702-dee6e8d77be4','canceled',0,'cash_after_service',NULL,1799.000,323.820,0.000,'2026-09-07 15:45:55','7','2026-09-05 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000008','cat-0002-0001-0001-000000000012',NULL,NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0,0,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000014',1014,'cust-0001-0001-0001-000000000002','prvd-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4','canceled',0,'cash_after_service',NULL,599.000,107.820,0.000,'2026-09-09 15:45:55','2','2026-09-07 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,NULL,0,0,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000015',1015,'cust-0001-0001-0001-000000000005','prvd-0001-0001-0001-000000000004','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'cash_after_service',NULL,199.000,35.820,0.000,'2026-08-23 15:45:55','5','2026-08-22 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000002','cat-0002-0001-0001-000000000007','sm-0001-0001-0001-000000000007',NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,'6789',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000016',1016,'cust-0001-0001-0001-000000000010','prvd-0001-0001-0001-000000000005','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'flutterwave',NULL,1200.000,216.000,0.000,'2026-08-21 15:45:55',NULL,'2026-08-20 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000008','cat-0002-0001-0001-000000000013','sm-0001-0001-0001-000000000008',NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,'1357',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000017',1017,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000002','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'cash_after_service',NULL,699.000,125.820,100.000,'2026-08-18 15:45:55','1','2026-08-17 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000002','cat-0002-0001-0001-000000000007','sm-0001-0001-0001-000000000004',NULL,0.000,100.000,'SAVE100',1,0.00,0.00,0.00,0.00,0.00,NULL,'2468',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000018',1018,'cust-0001-0001-0001-000000000008','prvd-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'ssl_commerz',NULL,3499.000,629.820,0.000,'2026-08-15 15:45:55','8','2026-08-14 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,'3579',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000019',1019,'cust-0001-0001-0001-000000000004','prvd-0001-0001-0001-000000000003','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'cash_after_service',NULL,299.000,53.820,0.000,'2026-08-13 15:45:55','4','2026-08-12 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000010','sm-0001-0001-0001-000000000005',NULL,0.000,0.000,NULL,1,0.00,0.00,0.00,0.00,0.00,NULL,'4680',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('bkg-0001-0001-0001-000000000020',1020,'cust-0001-0001-0001-000000000006','prvd-0001-0001-0001-000000000004','a1614dbe-4732-11ee-9702-dee6e8d77be4','completed',1,'paystack',NULL,2799.000,503.820,300.000,'2026-08-11 15:45:55','6','2026-08-10 15:45:55','2026-09-12 15:45:55','cat-0001-0001-0001-000000000007',NULL,'sm-0001-0001-0001-000000000007',NULL,0.000,300.000,'PEST300',1,0.00,0.00,0.00,0.00,0.00,NULL,'5791',0,1,0.000,0.00,0,NULL,'customer',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,0,NULL),('c288a76f-082e-41b1-8bd6-f21ae91729b0',1057,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-15 13:07:28','70','2026-10-15 12:36:34','2026-10-15 12:37:15','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'107493',0,0,0.000,0.00,0,NULL,'customer','{\"id\":70,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-15T07:36:34.000000Z\",\"updated_at\":\"2026-10-15T07:36:34.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,'2026-10-15 12:39:15',NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('cb068c74-9139-43a0-bd6b-19f297d537b7',1048,'5502f459-26c8-466b-9e04-4c0dbf41445e','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','61','2026-10-14 10:55:49','2026-10-14 13:39:59','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'817464',1,0,0.000,0.00,0,NULL,'customer','{\"id\":61,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Fresh Test\",\"created_at\":\"2026-10-14T05:55:49.000000Z\",\"updated_at\":\"2026-10-14T05:55:49.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"FT\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('d23f021f-76e8-46cb-886b-e629552fe499',1049,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-14 15:01:52','62','2026-10-14 14:30:03','2026-10-14 14:31:12','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'436926',0,0,0.000,0.00,0,NULL,'customer','{\"id\":62,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-14T09:30:03.000000Z\",\"updated_at\":\"2026-10-14T09:30:03.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('d5925f5c-5bdb-4d34-895f-6cac40a9be7f',1039,'9b6c8600-396a-4606-88d9-a1e581d4ebbc','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','52','2026-10-14 10:37:08','2026-10-14 10:38:35','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'593206',1,0,0.000,0.00,0,NULL,'customer','{\"id\":52,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Fresh Test\",\"created_at\":\"2026-10-14T05:37:08.000000Z\",\"updated_at\":\"2026-10-14T05:37:08.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"FT\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('d662278a-b37c-4b0c-adae-01ce044bc49d',1050,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-14 17:13:34','63','2026-10-14 16:41:45','2026-10-14 16:43:13','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'774371',0,0,0.000,0.00,0,NULL,'customer','{\"id\":63,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-14T11:41:45.000000Z\",\"updated_at\":\"2026-10-14T11:41:45.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('d9ac8ce7-35be-45b6-a83a-dcee2fc0aaf2',1063,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','accepted',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-18 20:38:13','76','2026-10-18 20:06:51','2026-10-18 20:14:37','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'560853',0,0,0.000,0.00,0,NULL,'customer','{\"id\":76,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-18T15:06:51.000000Z\",\"updated_at\":\"2026-10-18T15:06:51.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"ne\",\"floor\":\"en\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,1,'840461','2026-10-18 20:14:37','2026-10-18 20:14:37',0,NULL),('dbca7d1b-7afb-4bed-9bdc-bae32d87c53c',1054,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1192.980,181.980,0.000,'2026-10-15 11:22:33','67','2026-10-15 10:50:41','2026-10-15 10:55:04','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'176997',0,0,0.000,0.00,0,NULL,'customer','{\"id\":67,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-15T05:50:41.000000Z\",\"updated_at\":\"2026-10-15T05:50:41.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"gf\",\"floor\":\"fg\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('de1f2f03-b0e8-4f30-9ea5-1347f479359e',1032,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','accepted',0,'cash_after_service','cash-payment',1799.000,0.000,0.000,'2026-10-13 10:35:58','43','2026-10-13 10:04:04','2026-10-13 16:47:24','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','sm-0001-0001-0001-000000000001','sm-0001-0001-0001-000000000001',0.000,0.000,NULL,0,698.00,0.00,0.00,0.00,0.00,NULL,'477943',0,0,0.000,0.00,0,NULL,'customer','{\"id\":43,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-13T05:04:04.000000Z\",\"updated_at\":\"2026-10-13T05:04:04.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"gf\",\"floor\":\"fg\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,0,'277024','2026-10-13 15:59:07','2026-10-13 15:59:07',0,NULL),('e27c6207-9e5d-4549-b181-73451ad964d4',1077,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000002','6b1c8733-b0ff-4c65-a745-1f46419adc49','pending',0,'cash_after_service','cash-payment',1110.000,0.000,0.000,'2026-10-27 18:00:27','99','2026-10-27 17:28:31','2026-10-27 17:28:31','bc250cc5-990b-4864-aac1-c8dde7b63427','8a904eea-a4ce-4482-8100-abd9f8cd8a69',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'928047',0,0,0.000,0.00,0,NULL,'customer','{\"id\":99,\"user_id\":null,\"lat\":\"26.8381\",\"lon\":\"80.9346001\",\"city\":\"Lucknow\",\"street\":\"Station road\",\"zip_code\":\"226027\",\"country\":\"India\",\"address\":\"Lucknow, Uttar Pradesh, 226027, India\",\"created_at\":\"2026-10-27T12:28:31.000000Z\",\"updated_at\":\"2026-10-27T12:28:31.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Rahul Verma\",\"contact_person_number\":\"+919123456780\",\"address_label\":\"home\",\"zone_id\":\"6b1c8733-b0ff-4c65-a745-1f46419adc49\",\"is_guest\":0,\"house\":\"sa\",\"floor\":\"\"}',0,NULL,NULL,NULL,NULL,NULL,'manual_required',0,0,NULL,NULL,NULL,0,NULL),('e3421053-1718-494d-b96f-ae231ced63af',1069,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49','ongoing',0,'cash_after_service','cash-payment',10.000,0.000,0.000,'2026-10-27 15:23:17','91','2026-10-27 14:51:20','2026-10-27 15:19:44','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001','sm-0001-0001-0001-000000000001',NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,'[]','125277',0,0,0.000,0.00,0,NULL,'customer','{\"id\":91,\"user_id\":null,\"lat\":\"26.8381\",\"lon\":\"80.9346001\",\"city\":\"Lucknow\",\"street\":\"Station road\",\"zip_code\":\"226027\",\"country\":\"India\",\"address\":\"Lucknow, Uttar Pradesh, 226027, India\",\"created_at\":\"2026-10-27T09:51:20.000000Z\",\"updated_at\":\"2026-10-27T09:51:20.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Rahul Verma\",\"contact_person_number\":\"+919123456780\",\"address_label\":\"home\",\"zone_id\":\"6b1c8733-b0ff-4c65-a745-1f46419adc49\",\"is_guest\":0,\"house\":\"se\",\"floor\":\"se\"}',0,NULL,NULL,NULL,NULL,NULL,'auto',1,1,'397473','2026-10-27 15:17:43','2026-10-27 15:17:43',0,NULL),('e3948edf-bb94-4b2e-aae3-347ea82ddeb3',1056,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-15 12:45:31','69','2026-10-15 12:16:21','2026-10-15 12:21:15','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'253940',0,0,0.000,0.00,0,NULL,'customer','{\"id\":69,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-15T07:16:21.000000Z\",\"updated_at\":\"2026-10-15T07:16:21.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('e90e21ac-aed6-45d4-b9b4-b4240f1da37d',1041,'3508fb57-9ac6-4177-946a-334d23f19a13','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','54','2026-10-14 10:38:11','2026-10-14 10:39:36','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'683657',1,0,0.000,0.00,0,NULL,'customer','{\"id\":54,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Fresh Test\",\"created_at\":\"2026-10-14T05:38:11.000000Z\",\"updated_at\":\"2026-10-14T05:38:11.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"FT\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('eb4fefb9-aa35-42ad-bb9d-0411fd4dde39',1073,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49','pending',0,'cash_after_service','cash-payment',10.000,0.000,0.000,'2026-10-27 16:19:31','95','2026-10-27 15:47:40','2026-10-27 15:50:08','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'588820',0,0,0.000,0.00,0,NULL,'customer','{\"id\":95,\"user_id\":null,\"lat\":\"26.8381\",\"lon\":\"80.9346001\",\"city\":\"Lucknow\",\"street\":\"Station road\",\"zip_code\":\"226027\",\"country\":\"India\",\"address\":\"Lucknow, Uttar Pradesh, 226027, India\",\"created_at\":\"2026-10-27T10:47:40.000000Z\",\"updated_at\":\"2026-10-27T10:47:40.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Rahul Verma\",\"contact_person_number\":\"+919123456780\",\"address_label\":\"home\",\"zone_id\":\"6b1c8733-b0ff-4c65-a745-1f46419adc49\",\"is_guest\":0,\"house\":\"sasa\",\"floor\":\"as\"}',0,NULL,NULL,NULL,NULL,NULL,'manual_required',1,1,NULL,NULL,NULL,0,NULL),('ee5de3cc-d7a0-4932-8320-c564d8dae66b',1060,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-15 18:06:23','73','2026-10-15 17:34:27','2026-10-15 17:35:12','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'140740',0,0,0.000,0.00,0,NULL,'customer','{\"id\":73,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-15T12:34:27.000000Z\",\"updated_at\":\"2026-10-15T12:34:27.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,'2026-10-15 17:37:12',NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('f7343c12-59cf-4ed2-8412-b100ecd83050',1040,'f44a28fa-6eb1-4a0b-aa32-602d7be66896','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'1970-01-01 05:00:00','53','2026-10-14 10:37:45','2026-10-14 10:39:06','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'563523',1,0,0.000,0.00,0,NULL,'customer','{\"id\":53,\"user_id\":null,\"lat\":\"28.830897557796\",\"lon\":\"76.807617484353\",\"city\":null,\"street\":\"\",\"zip_code\":null,\"country\":null,\"address\":\"Fresh Test\",\"created_at\":\"2026-10-14T05:37:45.000000Z\",\"updated_at\":\"2026-10-14T05:37:45.000000Z\",\"address_type\":\"service\",\"contact_person_name\":\"FT\",\"contact_person_number\":\"9876543210\",\"address_label\":\"Home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":1,\"house\":null,\"floor\":null}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,0,NULL,NULL,NULL,0,NULL),('f85b4243-7dbe-4b19-b044-ef1c99b7abb6',1058,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-15 15:21:41','71','2026-10-15 14:49:45','2026-10-15 14:51:00','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'538123',0,0,0.000,0.00,0,NULL,'customer','{\"id\":71,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-15T09:49:45.000000Z\",\"updated_at\":\"2026-10-15T09:49:45.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"as\"}',0,NULL,NULL,'2026-10-15 14:53:00',NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL),('ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc',1051,'31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','pending',0,'cash_after_service','cash-payment',1299.180,198.180,0.000,'2026-10-14 18:06:29','64','2026-10-14 17:34:37','2026-10-14 17:35:43','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',NULL,NULL,0.000,0.000,NULL,0,0.00,0.00,0.00,0.00,0.00,NULL,'717867',0,0,0.000,0.00,0,NULL,'customer','{\"id\":64,\"user_id\":null,\"lat\":\"28.6138954\",\"lon\":\"77.2090057\",\"city\":\"New Delhi\",\"street\":\"Kartavya Path\",\"zip_code\":\"110004\",\"country\":\"India\",\"address\":\"New Delhi, Delhi, India\",\"created_at\":\"2026-10-14T12:34:37.000000Z\",\"updated_at\":\"2026-10-14T12:34:37.000000Z\",\"address_type\":\"others\",\"contact_person_name\":\"Jass singh\",\"contact_person_number\":\"+916304642321\",\"address_label\":\"home\",\"zone_id\":\"c00ed508-2bf3-43c3-b95c-8e880de67168\",\"is_guest\":0,\"house\":\"as\",\"floor\":\"\"}',0,NULL,NULL,NULL,NULL,NULL,'zone_pending',1,1,NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_page_settings`
--

DROP TABLE IF EXISTS `business_page_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_page_settings` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `business_page_settings_page_key_unique` (`page_key`),
  UNIQUE KEY `business_page_settings_title_unique` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_page_settings`
--

LOCK TABLES `business_page_settings` WRITE;
/*!40000 ALTER TABLE `business_page_settings` DISABLE KEYS */;
INSERT INTO `business_page_settings` VALUES ('0b1bab0b-c404-4027-bffc-6f6ddda9a880','about-us','about us','<p>Test About Us</p>',NULL,1,1,'2025-08-23 16:10:54','2025-08-23 16:10:54'),('1fe7b0bb-902b-40c3-8a12-319ab461c424','terms-and-conditions','terms and conditions','<p>Test Terms & Conditions</p>',NULL,1,1,'2025-08-23 16:10:54','2025-08-23 16:10:54'),('390bda7b-bac1-454f-be34-9c1642003948','privacy-policy','privacy policy','<p>Test Privacy Policy</p>',NULL,1,1,'2025-08-23 16:10:54','2025-08-23 16:10:54'),('79a111bc-8b84-46b8-96e9-aa17352db185','cancellation-policy','cancellation policy','<p>Test Cancellation Policy</p>',NULL,1,1,'2025-08-23 16:10:54','2025-08-23 16:10:54'),('a59cb2a5-58fb-42e8-b4f3-1726da610eb3','refund-policy','refund policy','<p>Test Refund Policy</p>',NULL,1,1,'2025-08-23 16:10:54','2025-08-23 16:10:54');
/*!40000 ALTER TABLE `business_page_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_settings`
--

DROP TABLE IF EXISTS `business_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_settings` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:guid)',
  `key_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `test_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `settings_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'live',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_settings`
--

LOCK TABLES `business_settings` WRITE;
/*!40000 ALTER TABLE `business_settings` DISABLE KEYS */;
INSERT INTO `business_settings` VALUES ('0098459d-9115-4c58-a6f8-becc65d3cb97','service_section_image','\"2023-08-31-64ef2e45070e7.png\"','\"2023-08-31-64ef2e45070e7.png\"','landing_images','live',0,'2022-10-03 17:37:21','2023-08-30 18:55:49'),('01b2c108-18fe-4ad0-8693-04be1bfa59aa','cancellation_policy','\"<p>Demo cancellation policy<\\/p>\"',NULL,'pages_setup','live',1,'2022-08-06 03:54:38','2024-10-08 12:42:37'),('03840466-ae1f-429f-90f1-6b724953f4e4','referral_discount_validity','0','0','customer_config','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('053c7a7b-75f0-4e01-9961-5e81fdd001f6','email_verification','1','1','service_setup','live',1,'2022-07-21 11:59:22','2022-08-13 07:35:03'),('078c60ff-a05f-4386-88c4-9b48e98dc7dd','releans','{\"gateway\":\"releans\",\"mode\":\"live\",\"status\":\"1\",\"api_key\":\"data\",\"from\":\"data\",\"otp_template\":\"data\"}','{\"gateway\":\"releans\",\"mode\":\"live\",\"status\":\"1\",\"api_key\":\"data\",\"from\":\"data\",\"otp_template\":\"data\"}','sms_config','live',1,'2022-06-08 06:44:58','2022-10-04 16:26:11'),('08aa2f9f-e830-4190-87a0-1d57267ab023','booking_edit_service_quantity_increase','{\"booking_edit_service_quantity_increase_status\":\"1\",\"booking_edit_service_quantity_increase_message\":\"Booking Edit Service Quantity Increase\"}','{\"booking_edit_service_quantity_increase_status\":\"1\",\"booking_edit_service_quantity_increase_message\":\"Booking Edit Service Quantity Increase\"}','serviceman_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('0a2e5ef2-4e4e-40b1-8ea6-9455a3549891','forget_password_verification_method','\"email\"','\"email\"','business_information','live',1,'2023-05-29 16:22:38','2023-05-29 16:22:38'),('0b0ac068-a661-4e13-ab25-858b9f9bab9d','currency_code','\"INR\"','\"INR\"','business_information','live',1,'2022-06-14 09:39:24','2026-10-05 04:49:00'),('0bb540c9-9ec6-4977-9284-be250d5b2fc5','maintenance_message_setup','{\"business_number\":1,\"business_email\":1,\"maintenance_message\":\"We are Cooking Up Something Special!\",\"message_body\":\"Sorry for the inconvenience! We are currently undergoing scheduled maintenance to improve our services. We will be back shortly. Thank you for your patience.\"}',NULL,'maintenance_mode','live',1,'2024-08-25 14:24:01','2024-08-25 14:24:01'),('0c1bcdd4-d93e-4b4a-9ef9-4b5a15153bdb','bidding_post_validity','\"3\"','\"3\"','bidding_system','live',1,'2023-08-30 13:09:23','2026-10-03 04:44:01'),('0d08217a-f52d-4ce2-a63c-88cd1445193f','provider_can_cancel_booking','\"0\"','\"0\"','provider_config','live',0,'2022-07-20 06:04:17','2023-08-30 13:09:23'),('0d4fea8e-aafd-4fc1-8698-0069e2005b72','booking_notification_type','\"firebase\"','\"firebase\"','business_information','live',1,'2024-10-08 12:42:37','2026-10-08 14:48:23'),('0d9bcbac-b423-4052-914a-ede9e7a19197','booking_notification','\"1\"','\"1\"','business_information','live',1,'2024-10-08 12:42:37','2026-10-05 04:49:02'),('0e2d1635-6f80-4ea0-876b-11f09f16abb8','referral_earning','{\"referral_earning_status\":\"1\",\"referral_earning_message\":\"Refferal Earning\"}','{\"referral_earning_status\":\"1\",\"referral_earning_message\":\"Refferal Earning\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('0f993fad-b7ba-4fdc-b394-5c34fd37ed68','widthdraw_request_deny','{\"widthdraw_request_deny_status\":\"1\",\"widthdraw_request_deny_message\":\"Withdraw Request Deny\"}','{\"widthdraw_request_deny_status\":\"1\",\"widthdraw_request_deny_message\":\"Withdraw Request Deny\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('11c73e6c-f776-49f5-8857-f46fd08f5bcd','additional_charge_fee_amount','\"0\"','\"0\"','booking_setup','live',1,'2023-08-30 13:09:23','2026-10-03 04:52:11'),('11d4f10d-2881-4c7d-baa6-e00ff603bc4b','social_media','[{\"id\":\"c96083cd-cbb0-415b-a215-b77da4c293c9\",\"media\":\"facebook\",\"link\":\"https:\\/\\/www.facebook.com\",\"status\":1},{\"id\":\"8cc641e5-019d-4760-b912-efa39d937635\",\"media\":\"instagram\",\"link\":\"https:\\/\\/www.instagram.com\",\"status\":1},{\"id\":\"0f104f7c-f0cb-4933-b35b-c04f829a682d\",\"media\":\"linkedin\",\"link\":\"https:\\/\\/www.linkedin.com\",\"status\":1},{\"id\":\"793d22b1-aa6a-48c3-a654-47dc799532a7\",\"media\":\"youtube\",\"link\":\"https:\\/\\/www.youtube.com\",\"status\":1}]','[{\"id\":\"c96083cd-cbb0-415b-a215-b77da4c293c9\",\"media\":\"facebook\",\"link\":\"https:\\/\\/www.facebook.com\"},{\"id\":\"8cc641e5-019d-4760-b912-efa39d937635\",\"media\":\"instagram\",\"link\":\"https:\\/\\/www.instagram.com\"},{\"id\":\"0f104f7c-f0cb-4933-b35b-c04f829a682d\",\"media\":\"linkedin\",\"link\":\"https:\\/\\/www.linkedin.com\"},{\"id\":\"793d22b1-aa6a-48c3-a654-47dc799532a7\",\"media\":\"youtube\",\"link\":\"https:\\/\\/www.youtube.com\"}]','landing_social_media','live',0,'2023-08-30 19:27:38','2025-08-23 16:10:54'),('11dddc2e-2b89-4bcc-9d48-1d3071dc37d6','booking_complete','{\"booking_complete_status\":\"1\",\"booking_complete_message\":\"Booking Complete\"}','{\"booking_complete_status\":\"1\",\"booking_complete_message\":\"Booking Complete\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('14290db3-1876-44a3-a70d-1410d753d673','campaign_cost_bearer','{\"bearer\":\"provider\",\"admin_percentage\":0,\"provider_percentage\":100,\"type\":\"campaign\"}','{\"bearer\":\"provider\",\"admin_percentage\":0,\"provider_percentage\":100,\"type\":\"campaign\"}','promotional_setup','live',1,'2023-01-22 17:33:48','2023-01-22 17:33:48'),('14eaf75b-68f2-412b-8062-189cff9582cc','app_url_appstore','\"\\/\"','\"\\/\"','landing_button_and_links','live',1,'2022-10-03 16:00:01','2022-10-04 16:22:24'),('16212625-a1cb-428e-b201-1975495a32cc','provider_self_registration','\"0\"','\"0\"','provider_config','live',0,'2022-07-21 11:59:22','2023-08-30 13:09:23'),('16ee9973-8d7f-4984-9357-3490fdb8fe04','otp','{\"otp_status\":\"1\",\"otp_message\":\"Confirmation OTP\"}','{\"otp_status\":\"1\",\"otp_message\":\"Confirmation OTP\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('18ff5091-1416-4b68-8a11-4a4db54d94bc','rating_review','{\"push_notification_rating_review\":\"1\",\"email_rating_review\":\"1\"}','{\"push_notification_rating_review\":\"1\",\"email_rating_review\":\"1\"}','notification_settings','live',1,'2022-06-06 12:41:28','2022-08-16 07:43:35'),('193e005b-a715-4f6f-97cc-2554377b1f28','app_url_playstore','\"\\/\"','\"\\/\"','landing_button_and_links','live',1,'2022-10-03 16:00:01','2022-10-04 16:22:24'),('1a4ff5aa-2956-458d-96e6-e0847635910c','referral_earning_first_booking','{\"referral_earning_first_booking_status\":\"1\",\"referral_earning_first_booking_message\":\"Referral Earning First Booking\"}','{\"referral_earning_first_booking_status\":\"1\",\"referral_earning_first_booking_message\":\"Referral Earning First Booking\"}','customer_notification','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('1acfd678-38f4-4aab-8431-7f066e8de7f2','phone_verification','0','0','service_setup','live',1,'2023-05-29 16:22:38','2023-05-29 16:22:38'),('1bb8c72b-20b2-4b89-82d3-c2ead7cf0675','serviceman_can_edit_booking','0','0','serviceman_config','live',1,'2023-08-30 13:09:23','2023-08-30 13:09:23'),('1bc292a4-4244-4eb2-8760-5c0bd4d5e236','default_commission','\"20\"','\"20\"','business_information','live',1,'2022-08-18 09:14:58','2022-08-24 02:53:43'),('1bfbbb5c-5786-491e-89ed-d366b2a84e30','customer_notification_for_provider_bid_withdraw','{\"customer_notification_for_provider_bid_withdraw_status\":\"1\",\"customer_notification_for_provider_bid_withdraw_message\":\"Customer notification for provider bid withdraw\"}','{\"customer_notification_for_provider_bid_withdraw_status\":\"1\",\"customer_notification_for_provider_bid_withdraw_message\":\"Customer notification for provider bid withdraw\"}','customer_notification','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('1c7e7c69-dd9d-4e7b-9379-b5314bb6ec58','testimonial','[{\"id\":\"94f7a473-e9fb-48ec-8bd3-46a0229b3aef\",\"name\":\"Mike\",\"designation\":\"Designer\",\"review\":\"Thank you! That was very helpful! The Service men were very professionals & very caution about safety\",\"image\":\"2023-08-31-64ef36f7190ba.png\"}]','[{\"id\":\"94f7a473-e9fb-48ec-8bd3-46a0229b3aef\",\"name\":\"Mike\",\"designation\":\"Designer\",\"review\":\"Thank you! That was very helpful! The Service men were very professionals & very caution about safety\",\"image\":\"2023-08-31-64ef36f7190ba.png\"}]','landing_testimonial','live',1,'2022-10-03 16:54:42','2023-08-30 19:33:13'),('1cbe46a3-9f79-47e1-af47-0868c3da2727','booking_edit_service_quantity_decrease','{\"booking_edit_service_quantity_decrease_status\":\"1\",\"booking_edit_service_quantity_decrease_message\":\"Booking Edit Service Quantity Decrease\"}','{\"booking_edit_service_quantity_decrease_status\":\"1\",\"booking_edit_service_quantity_decrease_message\":\"Booking Edit Service Quantity Decrease\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('1e8316f2-660a-44c5-b24c-97320ae212d0','booking_service_complete','{\"booking_service_complete_status\":\"1\",\"booking_service_complete_message\":\"Booking Service successfully complete done\"}','{\"booking_service_complete_status\":\"1\",\"booking_service_complete_message\":\"Booking Service successfully complete done\"}','notification_messages','live',1,'2022-06-06 12:41:28','2022-09-14 17:44:04'),('213899ba-989e-437d-8377-b12e24788e28','initial_search_radius','\"7\"',NULL,'location_search','live',1,'2026-10-09 14:13:01','2026-10-09 14:13:01'),('26b9dcd8-b8cd-4cc0-9ab4-2705993c31a4','booking_cancel','{\"booking_cancel_status\":\"1\",\"booking_cancel_message\":\"Booking Cancel\"}','{\"booking_cancel_status\":\"1\",\"booking_cancel_message\":\"Booking Cancel\"}','serviceman_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('27663114-d661-4eab-9eb5-6852bb3b7c7c','booking_edit_service_remove','{\"booking_edit_service_remove_status\":\"1\",\"booking_edit_service_remove_message\":\"Booking Edit Service Remove\"}','{\"booking_edit_service_remove_status\":\"1\",\"booking_edit_service_remove_message\":\"Booking Edit Service Remove\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('2b0ce7e1-ba62-437c-9f5b-cd9ccd12ea1d','booking_accepted','{\"booking_accepted_status\":\"1\",\"booking_accepted_message\":\"Booking Accepted\"}','{\"booking_accepted_status\":\"1\",\"booking_accepted_message\":\"Booking Accepted\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('2c0c6614-1990-4f6f-9c2d-c4481b8c18ff','service_complete_photo_evidence','1','1','booking_setup','live',1,'2023-08-30 13:09:23','2026-10-03 04:53:00'),('2dd9ca52-ebd2-45b4-9d38-30a6a16b44ca','top_title','\"Customer Statisfaciton is our main moto\"','\"Customer Statisfaciton is our main moto\"','landing_text_setup','live',0,'2022-10-03 15:36:11','2022-10-03 15:36:11'),('2dfa523c-65b0-478b-aa31-cf024151e8d9','serviceman_assign','{\"serviceman_assign_status\":\"1\",\"serviceman_assign_message\":\"Serviceman Assign\"}','{\"serviceman_assign_status\":\"1\",\"serviceman_assign_message\":\"Serviceman Assign\"}','serviceman_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('303e1187-edf1-4e6c-9a0e-e5f57efe3013','booking_otp','0','0','booking_setup','live',1,'2023-08-30 13:09:23','2023-08-30 13:09:23'),('30d0ed00-b027-45bb-aaee-ae5982e8c97b','add_to_fund_wallet','0','0','customer_config','live',1,'2023-12-28 14:00:58','2023-12-28 14:00:58'),('31c5e759-3d31-4522-8ed7-2a067c623c68','booking_place','{\"booking_place_status\":\"1\",\"booking_place_message\":\"Booking Service successfully placed\"}','{\"booking_place_status\":\"1\",\"booking_place_message\":\"Booking Service successfully placed\"}','notification_messages','live',1,'2022-06-06 12:41:28','2022-10-04 16:23:49'),('330878fe-66b8-4c86-b9f3-c69d7b7ab394','partial_payment','0','0','service_setup','live',1,'2023-08-30 13:09:23','2023-08-30 13:09:23'),('34330d75-7e42-4a2d-98a2-955e7f2eceee','create_user_account_from_guest_info','\"0\"','\"0\"','business_information','live',1,'2026-10-05 04:49:02','2026-10-05 04:49:02'),('35fdbc13-5505-4f08-a480-9a7922fde375','senang_pay','{\"gateway\":\"senang_pay\",\"mode\":\"live\",\"status\":\"0\",\"callback_url\":\"https:\\/\\/url\\/return-senang-pay\",\"secret_key\":\"data\",\"merchant_id\":\"data\"}','{\"gateway\":\"senang_pay\",\"mode\":\"live\",\"status\":\"0\",\"callback_url\":\"https:\\/\\/url\\/return-senang-pay\",\"secret_key\":\"data\",\"merchant_id\":\"data\"}','payment_config','live',0,'2022-06-09 07:21:16','2022-10-04 16:28:53'),('382abfc4-4742-4080-9f17-350bbc57d813','booking_cancel','{\"booking_cancel_status\":\"0\",\"booking_cancel_message\":\"Booking Cancel Successfully\"}','{\"booking_cancel_status\":\"0\",\"booking_cancel_message\":\"Booking Cancel Successfully\"}','notification_messages','live',0,'2022-06-06 12:41:28','2022-09-14 20:11:36'),('38c100f5-dc8c-4cf0-af94-855b607f6504','min_payable_amount','0','0','provider_config','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('3a9cf40c-c7ec-481c-8a79-5f33b154a561','email_config','{\"party_name\":\"email_config\",\"mailer_name\":\"Gmail\",\"host\":\"smtp.gmail.com\",\"driver\":\"smtp\",\"port\":\"587\",\"user_name\":\"ijaspreetsiingh@gmail.com\",\"email_id\":\"ijaspreetsiingh@gmail.com\",\"encryption\":\"tls\",\"password\":\"qwsz uxie rbyh fgzb\"}','{\"party_name\":\"email_config\",\"mailer_name\":\"Gmail\",\"host\":\"smtp.gmail.com\",\"driver\":\"smtp\",\"port\":\"587\",\"user_name\":\"ijaspreetsiingh@gmail.com\",\"email_id\":\"ijaspreetsiingh@gmail.com\",\"encryption\":\"tls\",\"password\":\"qwsz uxie rbyh fgzb\"}','email_config','live',1,'2022-06-07 12:32:47','2026-09-25 18:35:38'),('3b0b4644-9ba9-48e9-8622-59426198e3b9','time_zone','\"Indian\\/Kerguelen\"','\"Indian\\/Kerguelen\"','business_information','live',1,'2022-06-14 09:39:24','2026-10-05 04:49:01'),('3cee349b-0095-4eec-8da3-5db955242f7b','s3_storage_credentials','\"{\\\"key\\\":\\\"\\\",\\\"secret\\\":\\\"\\\",\\\"region\\\":\\\"\\\",\\\"bucket\\\":\\\"\\\",\\\"url\\\":\\\"\\\",\\\"endpoint\\\":\\\"\\\",\\\"path\\\":\\\"\\\"}\"','\"{\\\"key\\\":\\\"\\\",\\\"secret_credential\\\":\\\"\\\",\\\"region\\\":\\\"\\\",\\\"bucket\\\":\\\"\\\",\\\"url\\\":\\\"\\\",\\\"endpoint\\\":\\\"\\\",\\\"path\\\":\\\"\\\"}\"','storage_settings','live',1,'2024-07-07 16:15:01','2024-07-07 16:15:01'),('3d51e47f-da99-4757-8392-4d6ab9e37fc3','refund','{\"refund_status\":\"1\",\"refund_message\":\"Refund\"}','{\"refund_status\":\"1\",\"refund_message\":\"Refund\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('3d8dfac5-f187-45ee-a3ba-17fa75224bab','booking_edit_service_quantity_increase','{\"booking_edit_service_quantity_increase_status\":\"1\",\"booking_edit_service_quantity_increase_message\":\"Booking Edit Service Quantity Increase\"}','{\"booking_edit_service_quantity_increase_status\":\"1\",\"booking_edit_service_quantity_increase_message\":\"Booking Edit Service Quantity Increase\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('3dd386b8-066c-48c3-af22-f3f197347ea3','customer_wallet','0','0','customer_config','live',1,'2023-02-23 00:25:16','2023-02-23 00:25:16'),('3e0fe0fa-e697-437e-a0a9-9ff4316f4d39','about_us_description','\"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,\"','\"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,\"','landing_text_setup','live',0,'2022-10-03 15:36:11','2022-10-03 15:36:11'),('3e1a01ef-ec49-40a7-93b1-a15499028e32','bidding_status','0','0','bidding_system','live',1,'2023-08-30 13:09:23','2023-08-30 13:09:23'),('3e4c8b9f-28a2-4f72-b3b5-8b5808121dc8','recaptcha','{\"party_name\":\"recaptcha\",\"status\":\"0\",\"site_key\":\"apikey\",\"secret_key\":\"apikey\"}','{\"party_name\":\"recaptcha\",\"status\":\"0\",\"site_key\":\"apikey\",\"secret_key\":\"apikey\"}','third_party','live',0,'2022-07-25 10:57:25','2022-10-04 16:24:50'),('4007291b-5078-42ba-9051-fe9c991b9b2f','mid_title','\"SERVICE WE PROVIDE FOR YOU\"','\"SERVICE WE PROVIDE FOR YOU\"','landing_text_setup','live',0,'2022-10-03 15:36:11','2022-10-03 15:36:11'),('43c89209-172b-47a1-851a-efb90f848aa0','top_image_1','\"2023-08-31-64ef29058d28b.png\"','\"2023-08-31-64ef29058d28b.png\"','landing_images','live',0,'2022-10-03 16:06:10','2023-08-30 18:33:25'),('44644479-9e84-48de-991f-4cd3aded03ff','address_latitude','\"23.815019248268392\"','\"23.815019248268392\"','business_information','live',1,'2026-10-05 04:49:04','2026-10-05 04:49:04'),('45721749-c637-498c-ad0b-5d369a2d6425','cookies_text','\"test\"','\"test\"','business_information','live',1,'2023-02-23 00:25:16','2026-10-05 04:49:01'),('45825020-d72d-4d7c-8444-72b790507705','referral_discount_validity_type','\"day\"','\"day\"','customer_config','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('47817d69-8ec9-4730-b81f-838c4fc9d533','top_image_3','\"2023-08-31-64ef2a3b9f089.png\"','\"2023-08-31-64ef2a3b9f089.png\"','landing_images','live',0,'2022-10-03 16:06:15','2023-08-30 18:38:35'),('47cbf32d-06bf-40ae-980c-3053e7f1a4ad','ongoing_booking','{\"ongoing_booking_status\":\"1\",\"ongoing_booking_message\":\"Ongoing Booking\"}','{\"ongoing_booking_status\":\"1\",\"ongoing_booking_message\":\"Ongoing Booking\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('49146edb-2e7a-4280-ac19-de35c2f894f9','min_booking_amount','\"0\"','\"0\"','booking_setup','live',1,'2023-08-30 13:09:23','2026-10-03 04:44:01'),('49697d57-c686-4d30-9398-9c5533595b7f','provider_bid_request_denied','{\"provider_bid_request_denied_status\":\"1\",\"provider_bid_request_denied_message\":\"Provider Bid Request Denied\"}','{\"provider_bid_request_denied_status\":\"1\",\"provider_bid_request_denied_message\":\"Provider Bid Request Denied\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('4ad0c0ce-157c-46b2-b93d-261ca4f1a575','top_image_4','\"2023-08-31-64ef2a53b2182.png\"','\"2023-08-31-64ef2a53b2182.png\"','landing_images','live',0,'2022-10-03 16:07:26','2023-08-30 18:38:59'),('4cdc5c2e-054d-485b-a906-f0c6032880db','subscription','{\"push_notification_subscription\":\"1\",\"email_subscription\":\"1\"}','{\"push_notification_subscription\":\"1\",\"email_subscription\":\"1\"}','notification_settings','live',1,'2022-06-06 12:41:28','2022-08-16 07:43:35'),('4d69c64d-7956-4fd5-bdc0-59062152899d','max_booking_amount','\"100000\"','\"100000\"','booking_setup','live',1,'2023-08-30 13:09:23','2026-10-03 04:44:01'),('4dc4001c-2294-4ccf-8f02-8e6457cb260e','provider_suspend','{\"provider_suspend_status\":\"1\",\"provider_suspend_message\":\"Provider Suspend\"}','{\"provider_suspend_status\":\"1\",\"provider_suspend_message\":\"Provider Suspend\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('4dcb5aae-3a76-4754-b23a-286726a60d61','business_logo','\"jass-logo-20260924.png\"','\"2023-08-31-64ef387568527.png\"','business_information','live',1,'2022-06-14 09:39:24','2023-08-30 19:39:17'),('4ddd1410-e290-4e3f-a66c-ee70f86368db','bottom_title','\"GET ALL UPDATES & EXCITING NEWS\"','\"GET ALL UPDATES & EXCITING NEWS\"','landing_text_setup','live',0,'2022-10-03 15:36:11','2022-10-03 16:14:45'),('4e1af097-855e-43b8-ae10-0a0039039706','booking_accepted','{\"booking_accepted_status\":\"0\",\"booking_accepted_message\":\"Booking Service successfully complete done\"}','{\"booking_accepted_status\":\"0\",\"booking_accepted_message\":\"Booking Service successfully complete done\"}','notification_messages','live',0,'2022-06-06 12:41:28','2022-10-04 16:23:59'),('4e6fda04-d5b3-4ddd-a086-3c6567346e5c','tnc_update','{\"push_notification_tnc_update\":\"0\",\"email_tnc_update\":0}','{\"push_notification_tnc_update\":\"0\",\"email_tnc_update\":0}','notification_settings','live',1,'2022-06-06 12:41:28','2022-10-04 16:23:28'),('4e816e5e-ea8d-4d0e-bb57-5015c57be62a','system_language','[{\"id\":1,\"name\":\"english\",\"direction\":\"ltr\",\"code\":\"en\",\"status\":1,\"default\":true}]','[{\"id\":1,\"name\":\"english\",\"direction\":\"ltr\",\"code\":\"en\",\"status\":1,\"default\":true}]','business_information','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('514c7284-cab8-42a2-9f48-82e779d7afdd','direct_provider_booking','1','1','business_information','live',1,'2023-08-30 19:38:42','2026-10-03 04:44:01'),('539b1d42-0730-418d-83b0-46911e42cc39','privacy_policy','\"\\\"<p>Demo privacy policy<\\/p>\\\"\"',NULL,'pages_setup','live',1,'2022-08-06 04:00:09','2022-09-08 14:37:37'),('54b42ef4-2f17-4424-aebc-7e5490b97557','bottom_description','\"Subcribe to out newsletters to receive all the latest activty we provide for you\"','\"Subcribe to out newsletters to receive all the latest activty we provide for you\"','landing_text_setup','live',0,'2022-10-03 15:36:11','2022-10-03 16:14:45'),('54b77f94-c818-41cc-afff-9200213a541f','booking_edit_service_remove','{\"booking_edit_service_remove_status\":\"1\",\"booking_edit_service_remove_message\":\"Booking Edit Service Remove\"}','{\"booking_edit_service_remove_status\":\"1\",\"booking_edit_service_remove_message\":\"Booking Edit Service Remove\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('55f5fcbb-35db-4a57-b962-908cbc174ddf','provider_can_reply_review','1',NULL,'provider_config','live',1,'2024-10-08 12:42:37','2024-10-08 12:42:37'),('5675c00e-9686-4032-96f9-ce4631b9960a','speciality','[{\"id\":\"c3392f65-51ea-460a-b503-41a6e986971e\",\"title\":\"Speciality\",\"description\":\"Speciality description\",\"image\":\"2023-08-31-64ef3bcbbeb55.png\"}]','[{\"id\":\"c3392f65-51ea-460a-b503-41a6e986971e\",\"title\":\"Speciality\",\"description\":\"Speciality description\",\"image\":\"2023-08-31-64ef3bcbbeb55.png\"}]','landing_speciality','live',1,'2022-10-03 18:13:41','2023-08-30 19:53:45'),('57b3d923-139a-430b-a7b8-2c0797110cfd','sms_verification','1','1','service_setup','live',1,'2022-07-21 11:59:22','2022-08-13 07:35:03'),('5961e8be-4f8a-413b-a041-4aad8a4b0f59','email_config_status','1','1','email_config','live',1,'2024-07-13 10:35:13','2024-07-13 10:35:13'),('59d855e6-06ad-487a-9ca1-bbd8d3db2dfa','stripe','{\"gateway\":\"stripe\",\"mode\":\"test\",\"status\":\"1\",\"api_key\":\"data\",\"published_key\":\"data\"}','{\"gateway\":\"stripe\",\"mode\":\"test\",\"status\":\"1\",\"api_key\":\"data\",\"published_key\":\"data\"}','payment_config','test',1,'2022-06-09 05:41:48','2022-10-04 16:28:57'),('59f6e3d4-382f-47e6-b973-2c1cb2054016','digital_payment','1','1','service_setup','live',1,'2023-05-29 16:22:38','2023-05-29 16:22:38'),('5b7601e2-d34f-45ac-9f69-6b01585c5001','advertisement_resumed','{\"advertisement_resumed_status\":\"1\",\"advertisement_resumed_message\":\"Advertisement Resumed\"}','{\"advertisement_resumed_status\":\"1\",\"advertisement_resumed_message\":\"Advertisement Resumed\"}','provider_notification','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('5d8972d5-ae9b-47cd-b76c-011923ea8e54','booking_edit_service_remove','{\"booking_edit_service_remove_status\":\"1\",\"booking_edit_service_remove_message\":\"Booking Edit Service Remove\"}','{\"booking_edit_service_remove_status\":\"1\",\"booking_edit_service_remove_message\":\"Booking Edit Service Remove\"}','serviceman_notification','live',1,'2023-12-28 14:00:58','2023-12-28 14:00:58'),('5e470acd-7935-4394-ab56-008fdeb65029','third_party','{\"party_name\":\"push_notification\",\"server_key\":\"56789fghjk\"}','{\"party_name\":\"push_notification\",\"server_key\":\"56789fghjk\"}','third_party','live',1,'2022-06-08 10:57:43','2022-06-08 10:57:43'),('6170b133-2556-4eb0-b5bf-3352566e5c83','booking_ongoing','{\"booking_ongoing_status\":\"0\",\"booking_ongoing_message\":\"Booking Service successfully complete done\"}','{\"booking_ongoing_status\":\"0\",\"booking_ongoing_message\":\"Booking Service successfully complete done\"}','notification_messages','live',0,'2022-10-04 16:24:02','2022-10-04 16:24:02'),('63eb11ab-b34d-4bfc-a55f-e807c1974f41','advertisement_denied','{\"advertisement_denied_status\":\"1\",\"advertisement_denied_message\":\"Advertisement Denied\"}','{\"advertisement_denied_status\":\"1\",\"advertisement_denied_message\":\"Advertisement Denied\"}','provider_notification','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('65e9c5de-c37d-4dc8-bc6a-011784784176','partial_payment_combinator','\"all\"','\"all\"','service_setup','live',1,'2023-08-30 13:09:23','2023-08-30 13:09:23'),('668cdb3b-63a4-4ad4-ac35-407c811576b6','flutterwave','{\"gateway\":\"flutterwave\",\"mode\":\"test\",\"status\":\"1\",\"secret_key\":\"data\",\"public_key\":\"data\",\"hash\":\"data\"}','{\"gateway\":\"flutterwave\",\"mode\":\"test\",\"status\":\"1\",\"secret_key\":\"data\",\"public_key\":\"data\",\"hash\":\"data\"}','payment_config','test',1,'2022-09-03 08:47:46','2022-10-04 16:29:07'),('694b2b7f-24a9-43b7-abaa-f73736e5873d','serviceman_assign','{\"serviceman_assign_status\":\"1\",\"serviceman_assign_message\":\"Serviceman Assign\"}','{\"serviceman_assign_status\":\"1\",\"serviceman_assign_message\":\"Serviceman Assign\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('698dadfe-91b6-4b1b-9799-c6620f4bb0dc','booking_edit_service_quantity_increase','{\"booking_edit_service_quantity_increase_status\":\"1\",\"booking_edit_service_quantity_increase_message\":\"Booking Edit Service Quantity Increase\"}','{\"booking_edit_service_quantity_increase_status\":\"1\",\"booking_edit_service_quantity_increase_message\":\"Booking Edit Service Quantity Increase\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('6a46c913-5d22-48bb-85ba-161defad284e','add_fund_wallet_bonus','{\"add_fund_wallet_bonus_status\":\"1\",\"add_fund_wallet_bonus_message\":\"Add Fund Wallet Bonus\"}','{\"add_fund_wallet_bonus_status\":\"1\",\"add_fund_wallet_bonus_message\":\"Add Fund Wallet Bonus\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('6b208b3b-b474-4010-ab1c-57a708ef1a0d','customer_notification_for_provider_bid_offer','{\"customer_notification_for_provider_bid_offer_status\":\"1\",\"customer_notification_for_provider_bid_offer_message\":\"customer notification for provider bid offer\"}','{\"customer_notification_for_provider_bid_offer_status\":\"1\",\"customer_notification_for_provider_bid_offer_message\":\"customer notification for provider bid offer\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('6c8aa862-cd24-489c-bcc7-b5d0361c6b18','advanced_booking_restriction_value','\"2\"','\"2\"','booking_setup','live',1,'2024-05-20 14:36:21','2026-10-03 04:44:01'),('6d3c9600-0fd9-4ebe-a740-22c21c90f619','pp_update','{\"push_notification_pp_update\":\"0\",\"email_pp_update\":0}','{\"push_notification_pp_update\":\"0\",\"email_pp_update\":0}','notification_settings','live',1,'2022-06-06 12:41:28','2022-10-04 16:23:30'),('6f654cb0-3fda-47ff-9084-e2f5db1fcc94','referral_based_new_user_discount','0','0','customer_config','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('6fcf21de-e1c8-4bd4-ab2c-dff708e79277','currency_symbol_position','\"left\"','\"left\"','business_information','live',1,'2022-06-14 09:39:24','2022-09-14 06:07:12'),('7014ab21-7c89-4f6f-9e63-05806292802f','customer_loyalty_point','0','0','customer_config','live',1,'2023-02-23 00:25:16','2023-02-23 00:25:16'),('72189cb6-4608-4311-8b0c-25ef39265566','advertisement_approved','{\"advertisement_approved_status\":\"1\",\"advertisement_approved_message\":\"Advertisement Approved\"}','{\"advertisement_approved_status\":\"1\",\"advertisement_approved_message\":\"Advertisement Approved\"}','provider_notification','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('73a38ec7-5b60-402f-a17b-6e308c1b3cf7','provider_can_edit_booking','0','0','provider_config','live',1,'2023-08-30 13:09:23','2023-08-30 13:09:23'),('749dc8fa-b2f0-4236-a400-f52fe3b8193b','refund_policy','\"<p>Demo refund policy<\\/p>\"',NULL,'pages_setup','live',1,'2022-08-06 04:02:38','2022-09-08 14:37:27'),('78f9c6d0-7c92-4fcc-92d0-cb1fa00d0357','show_zone_reminder','1',NULL,'location_search','live',1,'2026-10-09 14:13:01','2026-10-09 14:13:01'),('790b2df0-f099-48b2-999e-b74d48a2fe07','ongoing_booking','{\"ongoing_booking_status\":\"1\",\"ongoing_booking_message\":\"Ongoing Booking\"}','{\"ongoing_booking_status\":\"1\",\"ongoing_booking_message\":\"Ongoing Booking\"}','serviceman_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('7a097aeb-c48d-4243-9217-85baf4dfdb0d','advertisement_created_by_admin','{\"advertisement_created_by_admin_status\":\"1\",\"advertisement_created_by_admin_message\":\"Advertisement Created By Admin\"}','{\"advertisement_created_by_admin_status\":\"1\",\"advertisement_created_by_admin_message\":\"Advertisement Created By Admin\"}','provider_notification','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('7a2d5afd-8957-41c2-8269-14cdce19f432','privacy_and_policy_update','{\"privacy_and_policy_update_status\":\"1\",\"privacy_and_policy_update_message\":\"Privacy And Policy Update\"}','{\"privacy_and_policy_update_status\":\"1\",\"privacy_and_policy_update_message\":\"Privacy And Policy Update\"}','serviceman_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('7a834fe4-6d3e-48c9-a707-aa8f4e849375','header_background','\"#e3f2fc\"','\"#e3f2fc\"','landing_background','live',0,'2023-08-30 19:23:47','2023-08-30 19:23:47'),('7be92742-c947-4786-ae8c-848798da7b08','referral_discount_amount','0','0','customer_config','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('7d347217-930c-4e03-a696-063fd2c80baa','maintenance_system_setup','[]',NULL,'maintenance_mode','live',1,'2024-08-25 14:24:01','2024-08-25 14:24:01'),('7eb3ac41-7c85-4877-8eae-6580c2ad6daa','subscription_vat','0','0','subscription_Setting','live',1,'2024-07-09 18:57:16','2024-07-09 18:57:16'),('7f266d17-6867-499f-bad6-9a8b55ab3ff1','order','{\"push_notification_order\":\"1\",\"email_order\":\"1\"}','{\"push_notification_order\":\"1\",\"email_order\":\"1\"}','notification_settings','live',1,'2022-06-06 12:41:28','2022-07-23 07:08:34'),('7fe3d581-d7c3-46e1-b804-c97efefcfeba','suspend_on_exceed_cash_limit_provider','0','0','provider_config','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('815f1823-9a67-4248-a62c-17eed4388745','service_request_deny','{\"service_request_deny_status\":\"1\",\"service_request_deny_message\":\"Service Request Reject\"}','{\"service_request_deny_status\":\"1\",\"service_request_deny_message\":\"Service Request Reject\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('81fa30e8-24d5-485b-90fc-a4995718b91e','footer_background','\"#001f35\"','\"#001f35\"','landing_background','live',0,'2023-08-30 19:23:47','2023-08-30 19:24:38'),('843ace86-ec16-46fa-8260-ba1d1e4e0eff','maintenance_mode','0',NULL,'maintenance_mode','live',1,'2024-08-25 14:24:01','2024-08-25 14:24:01'),('848492c2-b2c9-4fed-b486-77db4ff141ae','msg91','{\"gateway\":\"msg91\",\"mode\":\"live\",\"status\":\"0\",\"template_id\":\"data\",\"auth_key\":\"data\"}','{\"gateway\":\"msg91\",\"mode\":\"live\",\"status\":\"0\",\"template_id\":\"data\",\"auth_key\":\"data\"}','sms_config','live',0,'2022-06-08 09:06:49','2022-10-04 16:26:16'),('85dc4d4a-d25c-492f-b030-17723bcbf95b','booking_place','{\"booking_place_status\":\"1\",\"booking_place_message\":\"Booking Place\"}','{\"booking_place_status\":\"1\",\"booking_place_message\":\"Booking Place\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('873986dd-541b-4648-bd32-edac7504143e','nexmo','{\"gateway\":\"nexmo\",\"mode\":\"live\",\"status\":\"0\",\"api_key\":\"data\",\"api_secret\":\"data\",\"token\":\"data\",\"from\":\"data\",\"otp_template\":\"data\"}','{\"gateway\":\"nexmo\",\"mode\":\"live\",\"status\":\"0\",\"api_key\":\"data\",\"api_secret\":\"data\",\"token\":\"data\",\"from\":\"data\",\"otp_template\":\"data\"}','sms_config','live',0,'2022-06-08 07:19:18','2022-10-04 16:26:27'),('894ed562-3c8f-4ff6-9e92-5c524c2e4802','advanced_booking_restriction_type','\"hour\"','\"hour\"','booking_setup','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('89969f42-1340-4e1e-9d78-153495bf5c5f','firebase_otp_verification','{\"party_name\":\"firebase_otp_verification\",\"status\":\"0\",\"web_api_key\":\"\"}',NULL,'third_party','live',0,'2024-08-25 14:24:01','2026-09-22 02:29:37'),('89d237b1-861e-4066-9cb6-c9adfd672726','schedule_booking','1','1','booking_setup','live',1,'2022-07-20 06:04:14','2026-10-03 04:44:01'),('8c296af0-65c5-43f9-aa4a-854cbbf19148','pagination_limit','\"20\"','\"20\"','business_information','live',1,'2022-09-05 10:06:02','2022-10-04 16:21:24'),('8d6b0e16-f753-4833-8f79-7d049a50deb7','registration_description','\"Become e provider & Start your own business online with on demand service platform\"','\"Become e provider & Start your own business online with on demand service platform\"','landing_text_setup','live',0,'2022-10-03 15:36:11','2022-10-03 15:36:11'),('8dddf0eb-2021-4d16-9d84-687603f71285','coupon_cost_bearer','{\"bearer\":\"provider\",\"admin_percentage\":0,\"provider_percentage\":100,\"type\":\"coupon\"}','{\"bearer\":\"provider\",\"admin_percentage\":0,\"provider_percentage\":100,\"type\":\"coupon\"}','promotional_setup','live',1,'2023-01-22 17:33:48','2023-01-22 17:33:48'),('8e6dfa1d-1b51-456e-a35a-ae58eb81baee','additional_charge_label_name',NULL,NULL,'booking_setup','live',1,'2023-08-30 13:09:23','2023-08-30 13:09:23'),('8fa88ebf-5aac-4ea5-b87d-aff994f77d0e','provider_self_delete','1','1','provider_config','live',1,'2023-11-28 15:33:20','2023-11-28 15:33:20'),('916547ea-8840-4616-9b52-78f6159b1ca6','schedule_booking_time_restriction','0','0','booking_setup','live',1,'2024-05-20 14:36:21','2026-10-03 04:44:01'),('92043fa7-f54f-4733-9dbf-3719970a5b62','paytm','{\"gateway\":\"paytm\",\"mode\":\"test\",\"status\":\"1\",\"merchant_key\":\"data\",\"merchant_id\":\"data\",\"merchant_website_link\":\"data\"}','{\"gateway\":\"paytm\",\"mode\":\"test\",\"status\":\"1\",\"merchant_key\":\"data\",\"merchant_id\":\"data\",\"merchant_website_link\":\"data\"}','payment_config','test',1,'2022-06-09 07:21:49','2022-10-04 16:29:15'),('925c9c9e-d2a4-41bc-b9d2-ff16fed80ce3','body_background','\"#fcfcfc\"','\"#fcfcfc\"','landing_background','live',0,'2023-08-30 19:23:47','2023-08-30 19:25:22'),('9288358a-cab7-4c5c-b342-75b7ab17c29a','business_phone','\"+91000000\"','\"+91000000\"','business_information','live',1,'2022-06-14 09:39:24','2026-10-05 04:49:00'),('92ba62c6-17e3-4f30-a99b-0ee6dfe46628','booking_edit_service_quantity_decrease','{\"booking_edit_service_quantity_decrease_status\":\"1\",\"booking_edit_service_quantity_decrease_message\":\"Booking Edit Service Quantity Decrease\"}','{\"booking_edit_service_quantity_decrease_status\":\"1\",\"booking_edit_service_quantity_decrease_message\":\"Booking Edit Service Quantity Decrease\"}','serviceman_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('93670ab4-e54d-46ea-a8ed-101cb968208e','about_us_title','\"WHO WE ARE\"','\"WHO WE ARE\"','landing_text_setup','live',0,'2022-10-03 15:36:11','2022-10-03 15:36:11'),('94f715e7-164d-4e05-bb64-e3547d94a5e4','business_address','\"india\"','\"india\"','business_information','live',1,'2022-06-14 09:39:24','2026-10-05 04:49:00'),('96b1caa6-c369-423d-87c2-336cc5839519','max_search_attempts','\"6\"',NULL,'location_search','live',1,'2026-10-09 14:13:01','2026-10-09 14:13:01'),('973e0fe3-b6ff-4156-aa9a-78e52e069527','booking','{\"push_notification_booking\":1,\"email_booking\":1}','{\"push_notification_booking\":\"0\",\"email_booking\":0}','notification_settings','live',1,'2022-07-28 04:31:15','2024-10-08 12:42:37'),('98a973f9-0ec8-4fe5-b31d-d04c045bab41','referral_value_per_currency_unit','0','0','customer_config','live',1,'2023-02-23 00:25:16','2023-02-23 00:25:16'),('98e2f206-5314-4fc6-9625-95568bbc2771','serviceman_can_cancel_booking','0','0','serviceman_config','live',1,'2023-08-30 13:09:23','2023-08-30 13:09:23'),('998b0da0-268b-4354-8855-a40f266a2c84','referral_code_used','{\"referral_code_used_status\":\"1\",\"referral_code_used_message\":\"Referral code used\"}','{\"referral_code_used_status\":\"1\",\"referral_code_used_message\":\"Referral code used\"}','customer_notification','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('9a961fd3-b032-4260-a9dd-93ad7c0b76b8','paystack','{\"gateway\":\"paystack\",\"mode\":\"test\",\"status\":\"1\",\"callback_url\":\"https:\\/\\/api.paystack.co\",\"public_key\":\"data\",\"secret_key\":\"data\",\"merchant_email\":\"data\"}','{\"gateway\":\"paystack\",\"mode\":\"test\",\"status\":\"1\",\"callback_url\":\"https:\\/\\/api.paystack.co\",\"public_key\":\"data\",\"secret_key\":\"data\",\"merchant_email\":\"data\"}','payment_config','test',1,'2022-06-09 06:12:45','2022-10-04 16:29:25'),('9ba99828-e514-4b9a-89f7-a07daad49b2c','free_trial_period','7','7','subscription_Setting','live',1,'2024-07-09 18:57:16','2024-07-09 18:57:16'),('9ec59242-4fd2-4f54-898c-4b4c60270ecd','business_favicon','\"jass-favicon-20260924.png\"','\"2022-10-04-633bfb21640b9.png\"','business_information','live',1,'2022-06-14 09:39:24','2022-10-04 16:21:37'),('9f9f1855-6566-49d4-8ca8-f033a8a2c107','add_fund_wallet','{\"add_fund_wallet_status\":\"1\",\"add_fund_wallet_message\":\"Add Fund Wallet\"}','{\"add_fund_wallet_status\":\"1\",\"add_fund_wallet_message\":\"Add Fund Wallet\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('9ff4b51f-0edd-4a33-ab15-bc79f7542ecd','about_us','\"<p>hello world hero greatth weh fvaaafawefdsdsdsd<\\/p>\"',NULL,'pages_setup','live',1,'2022-08-04 13:04:19','2022-10-04 11:57:25'),('a0910af1-fee3-4527-957b-e46b40ad5ed2','bid_offers_visibility_for_providers','0','0','bidding_system','live',1,'2023-08-30 13:09:23','2023-08-30 13:09:23'),('a2a8333f-0e93-423c-9983-89357eec728a','service_at_provider_place','0','0','provider_config','live',1,'2025-04-19 16:16:25','2025-04-19 16:16:25'),('a38599a7-fb8f-4f3c-a955-b975cdd8fae5','customer_referral_earning','0','0','customer_config','live',1,'2023-02-23 00:25:16','2023-02-23 00:25:16'),('a6cd4791-0276-4fa4-b2a1-13d3d5a8f232','twilio','{\"gateway\":\"twilio\",\"mode\":\"live\",\"status\":\"0\",\"sid\":\"data\",\"messaging_service_sid\":\"data\",\"token\":\"data\",\"from\":\"data\",\"otp_template\":\"data\"}','{\"gateway\":\"twilio\",\"mode\":\"live\",\"status\":\"0\",\"sid\":\"data\",\"messaging_service_sid\":\"data\",\"token\":\"data\",\"from\":\"data\",\"otp_template\":\"data\"}','sms_config','live',0,'2022-06-08 07:03:02','2022-10-04 16:26:39'),('a827df9b-74a4-4944-8804-835026450c92','privacy_and_policy_update',NULL,NULL,'pages_setup','live',1,'2024-10-08 12:42:37','2024-10-08 12:42:37'),('a8c1f49a-be3b-4609-8242-37142ff05acd','currency_decimal_point','\"2\"','\"2\"','business_information','live',1,'2022-06-14 09:39:24','2022-10-04 16:21:24'),('a9c93141-a7c9-473b-ac46-b3dadc7b067f','razor_pay','{\"gateway\":\"razor_pay\",\"mode\":\"live\",\"status\":\"1\",\"api_key\":\"data\",\"api_secret\":\"data\"}','{\"gateway\":\"razor_pay\",\"mode\":\"live\",\"status\":\"1\",\"api_key\":\"data\",\"api_secret\":\"data\"}','payment_config','live',1,'2022-06-09 07:46:29','2022-10-04 16:29:32'),('aa47f328-82a9-4b97-aec7-155c10b4d9af','invoice_template','\"template_3\"','\"template_3\"','business_information','live',1,'2026-10-16 17:50:34','2026-10-16 17:50:34'),('ab04b341-d3ae-4c45-9e35-813dd01f22b6','max_cash_in_hand_limit_provider','0','0','provider_config','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('aba6da13-a238-4042-97f6-78972dccfdd0','instant_booking','1','1','booking_setup','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('adfb686d-0fbf-408c-b325-dbdabb0d408f','max_search_radius','\"30\"',NULL,'location_search','live',1,'2026-10-09 14:13:01','2026-10-09 14:13:01'),('ae03b974-b953-4c6d-98c4-6eb0f231d16d','customized_booking_request_delete','{\"customized_booking_request_delete_status\":\"1\",\"customized_booking_request_delete_message\":\"Customized Booking Request Delete\"}','{\"customized_booking_request_delete_status\":\"1\",\"customized_booking_request_delete_message\":\"Customized Booking Request Delete\"}','customer_notification','live',1,'2024-03-13 09:19:39','2024-03-13 09:19:39'),('af729332-d8ec-4822-854a-5f54e10a9061','sslcommerz','{\"gateway\":\"sslcommerz\",\"mode\":\"test\",\"status\":\"1\",\"store_id\":\"data\",\"store_password\":\"data\"}','{\"gateway\":\"sslcommerz\",\"mode\":\"test\",\"status\":\"1\",\"store_id\":\"data\",\"store_password\":\"data\"}','payment_config','test',1,'2022-06-09 03:19:38','2022-10-04 16:29:39'),('afba0ef3-7b60-4638-b2c0-2dac02f2119e','booking_schedule_time_change','{\"booking_schedule_time_change_status\":\"1\",\"booking_schedule_time_change_message\":\"Booking schedule time change\"}','{\"booking_schedule_time_change_status\":\"1\",\"booking_schedule_time_change_message\":\"Booking schedule time change\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('afe56fb4-02b6-4cc7-bec8-752012dd2c87','provider_commision','1','1','provider_config','live',1,'2024-07-09 13:20:42','2024-07-09 13:20:42'),('aff0213c-bcb2-42e0-98bb-295262683ccf','booking_edit_service_add','{\"booking_edit_service_add_status\":\"1\",\"booking_edit_service_add_message\":\"Booking Edit Service Add\"}','{\"booking_edit_service_add_status\":\"1\",\"booking_edit_service_add_message\":\"Booking Edit Service Add\"}','serviceman_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('b004a67d-df30-4a85-9ec0-54774cc2e616','min_loyalty_point_to_transfer','0','0','customer_config','live',1,'2023-02-23 00:25:16','2023-02-23 00:25:16'),('b0bf5be1-183a-4dbe-86f6-bd3ff2b9c68a','push_notification','{\"party_name\":\"push_notification\",\"service_file_content\":\"{\\n  \\\"type\\\": \\\"service_account\\\",\\n  \\\"project_id\\\": \\\"newcompany-ebf01\\\",\\n  \\\"private_key_id\\\": \\\"973b885d45272a53f98b9367268f8026a2d06af5\\\",\\n  \\\"private_key\\\": \\\"-----BEGIN PRIVATE KEY-----\\\\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDCFhen6cMW41J8\\\\n5QC5xIs5kg7QWTcNyUQpc4onQck6i99RPtM47fB2VjMGUiCrc6tSp7W9\\/PwoLpBN\\\\n9jGx5sG17onxzgiKI6Au1hqlJvMZlx6C7pn5QTDueYyMQ7kMfVEWQGNmzfGN3DSs\\\\npACsdVOd5EGVj\\/y4y+Ghin9dXDhmWw4OvdRtXgEZrOldW9pVNbhXSqUzps1J4+UC\\\\nUBQNQdv6FB5RfvYljcNEoezpepdq3UpWd0EcqY8W3t8WC3j5cW8L3khoUZ8rnnCR\\\\n5ntzJkRMzTUz0A58o7gAnfvcnlb8Tu5ruH2RbQXQbLfXz3czHnsrYGrn13wmNLnH\\\\nZ64EllvpAgMBAAECggEAIRD9f8SSUcxx6chkOsITDEBnmLSSbh1bqQo\\/v9dz7q8U\\\\n4XUoLFtRa\\/\\/cmpeUbFF9H0xmaNN4rGneeQHYTpxnZVUaGGHHT62pJUGh8YA0y6fU\\\\n8W6wOeiS6xY3TVBebxPMpFNc\\/A9bN5WMPduFJ9ynXc+dItuQrXVC4DBF6cSD8WAG\\\\nrDL\\/7SRii0nmXa5CFzgYdJ9qpxTd1SoCSyDRFL+RwMu8j0AOaLvBCsHhfhXW+QqQ\\\\nIxtrcCwdKeBuRv5gxhDrhySrHIrjJ3Y+tYSKjAbsdInkxSijnKEI1amxRKCo4hCg\\\\nOv2dInFtYAlXc\\/T7QQ+lWMhjQITR3KukKYolmtn0twKBgQD2W\\/BvXW5lWKhQaLdP\\\\nj2iqx\\/wwZj3ftlP\\/0GrkIEJ7H7CvcIip1qwQAoBvR+zypTvVSlP5z0aCRVyDdWui\\\\nDuNstMKup9Gvm6GFfylKz+me7vom1y1gXrtT0yV7cC7Oc5JRkbAEcGWDVWUi0REI\\\\nr4wHZafQgKVQSn68b0hkZQSGqwKBgQDJrnn7DW4BQz+8citfwrxhZtGncyptzJwp\\\\noZLq5nWvgoeJRNgiCL3qRfM3fuy8N+bg33BWdJeashWkcqCxdBr9Zdt6LPK4GogE\\\\nYSKBnfD2ON5Lixy0\\/S++TVnlCOV8KNF4XvXdSaT7VWxQxmYKUZGj8fpQNgOnUxKi\\\\nE3sZOQv3uwKBgG6mDpBGO34jWr16utJuC8mgtsEaOrIO1x1vg4Lghlt8eUPi3E7D\\\\nz1YFeaABgwfcdMowbxUlJnr+IjYc9\\/G6lCTP7xy43THtSZeG7IngZgJvPUVSodvF\\\\n0Icur4gIc81gFRizwYXM4ZsiMKF5mxf2mIL+AmhgT1+HhfKmXLJSuLyvAoGBALpy\\\\nC95lOe785m0l9qceddxtmx\\/8PZsn7q4l6pYx21YXi4kBFfXQsxFi\\/UeulNgjrdLx\\\\nfP7P5l9ihtNyDNBAD7t2cIHwD6rXDCtQSQAerOZTCF46Cp3e+kYpaBNuOAiiC5QF\\\\n5bFfJaAcBnheEXM0mTlAuDFy3cnP6IfhDonwzPmFAoGBAKoWT4a7e7E59a8n7UfC\\\\nbwdRjr6W91d6oANod+WiEdXi5DFc00e\\/8fc356DL3z4U7WS8nvXMRuFocihuL+4h\\\\ncXsx+jQe33\\/ihj2JUS0qAxO1gxYI+SKqcbs7gGAVQRZ8ZOewgcVvRUkgB8XaLTdi\\\\nZcgirK45\\/P3ihq87zjvsDdWZ\\\\n-----END PRIVATE KEY-----\\\\n\\\",\\n  \\\"client_email\\\": \\\"firebase-adminsdk-fbsvc@newcompany-ebf01.iam.gserviceaccount.com\\\",\\n  \\\"client_id\\\": \\\"117531484652133101616\\\",\\n  \\\"auth_uri\\\": \\\"https:\\/\\/accounts.google.com\\/o\\/oauth2\\/auth\\\",\\n  \\\"token_uri\\\": \\\"https:\\/\\/oauth2.googleapis.com\\/token\\\",\\n  \\\"auth_provider_x509_cert_url\\\": \\\"https:\\/\\/www.googleapis.com\\/oauth2\\/v1\\/certs\\\",\\n  \\\"client_x509_cert_url\\\": \\\"https:\\/\\/www.googleapis.com\\/robot\\/v1\\/metadata\\/x509\\/firebase-adminsdk-fbsvc%40newcompany-ebf01.iam.gserviceaccount.com\\\",\\n  \\\"universe_domain\\\": \\\"googleapis.com\\\"\\n}\\n\"}','{\"party_name\":\"push_notification\",\"server_key\":\"apikey\",\"service_file_content\":\"{\\n  \\\"project_info\\\": {\\n    \\\"project_number\\\": \\\"418974405325\\\",\\n    \\\"project_id\\\": \\\"newcompany-ebf01\\\",\\n    \\\"storage_bucket\\\": \\\"newcompany-ebf01.firebasestorage.app\\\"\\n  },\\n  \\\"client\\\": [\\n    {\\n      \\\"client_info\\\": {\\n        \\\"mobilesdk_app_id\\\": \\\"1:418974405325:android:4b1835837c5cc32d3b0f84\\\",\\n        \\\"android_client_info\\\": {\\n          \\\"package_name\\\": \\\"com.jassdbx.jassods\\\"\\n        }\\n      },\\n      \\\"oauth_client\\\": [],\\n      \\\"api_key\\\": [\\n        {\\n          \\\"current_key\\\": \\\"AIzaSyD8PuTDJaGxlkl9vtZxzGHMpIbyGTXep7A\\\"\\n        }\\n      ],\\n      \\\"services\\\": {\\n        \\\"appinvite_service\\\": {\\n          \\\"other_platform_oauth_client\\\": []\\n        }\\n      }\\n    }\\n  ],\\n  \\\"configuration_version\\\": \\\"1\\\"\\n}\"}','third_party','live',1,'2022-07-16 04:56:01','2026-10-08 12:52:10'),('b9525ca3-9c9e-432c-a2bb-a9f41c8a6b68','time_format','\"12\"','\"12\"','business_information','live',1,'2022-06-14 09:39:24','2026-10-05 04:49:01'),('ba08f7c0-a233-43f5-a801-cd727e3e7de9','admin_order_notification','1','1','service_setup','live',1,'2022-07-20 06:04:23','2022-08-13 07:35:03'),('bb1b788c-fb60-468f-a636-68b6c84326cd','repeat_booking','1','1','booking_setup','live',1,'2024-11-19 15:53:49','2026-10-03 04:44:01'),('bb1f5b40-88b8-45ac-a28e-53c32bd5c4de','deadline_warning_message','\"Your subscription ending soon. Please  renew to continue access\"','\"Your subscription ending soon. Please  renew to continue access\"','subscription_Setting','live',1,'2024-07-09 18:57:16','2024-07-09 18:57:16'),('bbfd087c-eaa5-4868-8a69-3be87720ae86','top_description','\"LARGEST BOOKING SERVICE PLATEFORM\"','\"LARGEST BOOKING SERVICE PLATEFORM\"','landing_text_setup','live',0,'2022-10-03 15:36:11','2022-10-03 15:36:11'),('bc4ed6e1-2c7e-4c95-8c7f-fe547a317c1e','about_us_image','\"2023-08-31-64ef2c4244964.png\"','\"2023-08-31-64ef2c4244964.png\"','landing_images','live',0,'2022-10-03 17:37:45','2023-08-30 18:47:14'),('bd122993-e4d6-427a-be42-713b3e9612a3','booking_cancel','{\"booking_cancel_status\":\"1\",\"booking_cancel_message\":\"Booking Cancel\"}','{\"booking_cancel_status\":\"1\",\"booking_cancel_message\":\"Booking Cancel\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('bde4ffab-e63d-435d-8854-46e4cfa49daf','booking_edit_service_add','{\"booking_edit_service_add_status\":\"1\",\"booking_edit_service_add_message\":\"Booking Edit Service Add\"}','{\"booking_edit_service_add_status\":\"1\",\"booking_edit_service_add_message\":\"Booking Edit Service Add\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('be65566f-dbbd-4f9c-b451-e93101d195c0','maintenance_duration_setup','{\"maintenance_duration\":\"until_change\",\"start_date\":null,\"end_date\":null}',NULL,'maintenance_mode','live',1,'2024-08-25 14:24:01','2024-08-25 14:24:01'),('be927e91-0b1f-44b1-9ad8-73022910f717','new_service_request_arrived','{\"new_service_request_arrived_status\":\"1\",\"new_service_request_arrived_message\":\"New Service Request Arrived\"}','{\"new_service_request_arrived_status\":\"1\",\"new_service_request_arrived_message\":\"New Service Request Arrived\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('bef3c996-55b2-4371-8fe0-7204931d7478','usage_time','70','70','subscription_Setting','live',1,'2024-07-09 18:57:16','2024-07-09 18:57:16'),('bf085f4a-1f5d-4ff2-b4de-2038ef70ad79','serviceman_assign','{\"serviceman_assign_status\":\"1\",\"serviceman_assign_message\":\"Serviceman Assign\"}','{\"serviceman_assign_status\":\"1\",\"serviceman_assign_message\":\"Serviceman Assign\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('bf12c77c-5274-408c-aa5f-f056db9ac3b8','provider_suspension_remove','{\"provider_suspension_remove_status\":\"1\",\"provider_suspension_remove_message\":\"Provider Suspension removed\"}','{\"provider_suspension_remove_status\":\"1\",\"provider_suspension_remove_message\":\"Provider Suspension removed\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('bf2b55c8-3ba0-4087-97b9-af101a5258d1','guest_checkout','\"0\"','\"0\"','service_setup','live',1,'2023-08-30 13:09:23','2026-10-05 04:49:03'),('c355057d-d056-40a6-a541-a597acca44b3','cross_zone_fallback_enabled','1','0','booking_setup','live',1,'2026-10-03 02:28:42','2026-10-27 05:40:49'),('c58ecce7-598f-4568-aa15-d875dfa12232','terms_and_conditions','\"<p>Demo terms and conditions<\\/p>\"',NULL,'pages_setup','live',1,'2022-08-06 04:02:24','2024-10-08 12:42:37'),('c5d7ea4e-d51b-408f-8e57-58186d7d62f6','booking_edit_service_add','{\"booking_edit_service_add_status\":\"1\",\"booking_edit_service_add_message\":\"Booking Edit Service Add\"}','{\"booking_edit_service_add_status\":\"1\",\"booking_edit_service_add_message\":\"Booking Edit Service Add\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('c6331403-a1cd-4899-8d68-24a2ac323499','offline_payment_approved','{\"offline_payment_approved_status\":\"1\",\"offline_payment_approved_message\":\"Offline Payment Approved\"}','{\"offline_payment_approved_status\":\"1\",\"offline_payment_approved_message\":\"Offline Payment Approved\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('c68a9f47-7504-4fc9-b4f6-6a5aa274e4b8','business_name','\"Jass Booking\"','\"Jass Booking\"','business_information','live',1,'2022-06-14 09:39:24','2022-10-04 16:19:55'),('c813153a-20cd-4d16-be50-6c563904abde','show_popup_on_location_change','1',NULL,'location_search','live',1,'2026-10-09 14:13:01','2026-10-09 14:13:01'),('c8dd2bcf-44e5-41e4-a121-fe4cc6f44e33','discount_cost_bearer','{\"bearer\":\"provider\",\"admin_percentage\":0,\"provider_percentage\":100,\"type\":\"discount\"}','{\"bearer\":\"provider\",\"admin_percentage\":0,\"provider_percentage\":100,\"type\":\"coupon\"}','promotional_setup','live',1,'2023-01-22 17:33:48','2023-01-22 17:33:48'),('cc84f94d-743d-4551-8981-2fec5a750e93','booking_complete','{\"booking_complete_status\":\"1\",\"booking_complete_message\":\"Booking Complete\"}','{\"booking_complete_status\":\"1\",\"booking_complete_message\":\"Booking Complete\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('cccc6210-ceb8-431a-a676-e4ad322ef32d','loyalty_point','{\"loyalty_point_status\":\"1\",\"loyalty_point_message\":\"Loyalty Point\"}','{\"loyalty_point_status\":\"1\",\"loyalty_point_message\":\"Loyalty Point\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('cd0a7610-8c1a-49b1-a007-44560f69b7d8','storage_connection_type','\"local\"','\"local\"','storage_settings','live',1,'2024-07-07 16:15:01','2024-07-07 16:15:01'),('cd206dd3-6d91-4608-8bc5-9be80cbf2e42','top_sub_title','\"Get all services from one App.\"','\"Get all services from one App.\"','landing_text_setup','live',0,'2022-10-03 15:36:11','2022-10-03 15:36:11'),('cfb57339-dc26-48f0-9815-896aebee243f','features','[{\"id\":\"54fc434a-b953-4b90-97e7-c6d7fae28f41\",\"title\":\"GET YOUR SERVICE 24\\/7\",\"sub_title\":\"Visit our app and select your location to see available services near you\",\"image_1\":\"2023-08-31-64ef2e92e47c3.png\",\"image_2\":\"2023-08-31-64ef2e92e8b41.png\"}]','[{\"id\":\"54fc434a-b953-4b90-97e7-c6d7fae28f41\",\"title\":\"GET YOUR SERVICE 24\\/7\",\"sub_title\":\"Visit our app and select your location to see available services near you\",\"image_1\":\"2023-08-31-64ef2e92e47c3.png\",\"image_2\":\"2023-08-31-64ef2e92e8b41.png\"}]','landing_features','live',1,'2022-10-03 17:26:57','2023-08-30 18:58:36'),('d0c18642-cfa4-4178-8e25-a3a58a6cdff3','admin_payable','{\"admin_payable_status\":\"1\",\"admin_payable_message\":\"Admin Payable\"}','{\"admin_payable_status\":\"1\",\"admin_payable_message\":\"Admin Payable\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('d1deffc6-55cd-4d78-a1ef-bff6419e32b3','cross_zone_distance_limit','\"50\"','\"50\"','booking_setup','live',1,'2026-10-03 02:28:43','2026-10-03 04:52:11'),('d27c7746-520f-470d-a3e0-6ac0b427ae61','registration_title','\"REGISTER AS PROVIDER\"','\"REGISTER AS PROVIDER\"','landing_text_setup','live',0,'2022-10-03 15:36:11','2022-10-03 15:36:11'),('d2b531d9-4cf1-4f7c-b96f-395856f5003d','google_map','{\"party_name\":\"google_map\",\"map_api_key_client\":\"apikey\",\"map_api_key_server\":\"apikey\"}','{\"party_name\":\"google_map\",\"map_api_key_client\":\"apikey\",\"map_api_key_server\":\"apikey\"}','third_party','live',0,'2022-09-14 19:49:51','2022-10-04 16:24:39'),('d3ed9c30-4ce1-4c43-8016-e3a51cd74206','booking_schedule_time_change','{\"booking_schedule_time_change_status\":\"1\",\"booking_schedule_time_change_message\":\"Booking Schedule Time Change\"}','{\"booking_schedule_time_change_status\":\"1\",\"booking_schedule_time_change_message\":\"Booking Schedule Time Change\"}','serviceman_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('d42c3f11-c43f-48ab-849e-b950d90aea3d','widthdraw_request_approve','{\"widthdraw_request_approve_status\":\"1\",\"widthdraw_request_approve_message\":\"Withdraw Request Approve\"}','{\"widthdraw_request_approve_status\":\"1\",\"widthdraw_request_approve_message\":\"Withdraw Request Approve\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('d5ff36a8-634b-42a1-ab49-08375eeb21ac','footer_text','\"All rights reserved By @ jass\"','\"All rights reserved By @ jass\"','business_information','live',1,'2022-09-05 10:06:02','2026-10-05 04:49:01'),('d683b185-6f67-4cd0-94f7-14d85f8da03a','booking_additional_charge','0','0','booking_setup','live',1,'2023-08-30 13:09:23','2023-08-30 13:09:23'),('d8a4c244-0e6c-4511-a156-93db22a66b7e','phone_number_visibility_for_chatting','\"0\"','\"0\"','business_information','live',1,'2023-02-23 00:25:16','2023-08-30 19:38:42'),('d9ecd0f6-aa05-42fe-b539-990618fca55f','booking_edit_service_quantity_decrease','{\"booking_edit_service_quantity_decrease_status\":\"1\",\"booking_edit_service_quantity_decrease_message\":\"Booking Edit Service Quantity Decrease\"}','{\"booking_edit_service_quantity_decrease_status\":\"1\",\"booking_edit_service_quantity_decrease_message\":\"Booking Edit Service Quantity Decrease\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('db386429-6982-4f46-82f9-08ec70f13f57','maximum_withdraw_amount','\"1\"','\"1\"','business_information','live',1,'2023-01-22 17:33:48','2023-08-30 19:38:42'),('dbd7d22a-299e-49be-869e-efdcaf8ee7e4','web_url','\"\\/\"','\"\\/\"','landing_button_and_links','live',1,'2022-10-03 16:00:01','2022-10-04 16:22:24'),('dbf71089-a769-4025-b971-307c08a6b455','service_man_can_cancel_booking','\"0\"','\"0\"','service_setup','live',0,'2022-07-20 06:04:21','2022-10-04 16:00:21'),('dcb1d44b-f536-43ab-80f8-ea115f008abe','advertisement_paused','{\"advertisement_paused_status\":\"1\",\"advertisement_paused_message\":\"Advertisement Paused\"}','{\"advertisement_paused_status\":\"1\",\"advertisement_paused_message\":\"Advertisement Paused\"}','provider_notification','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('e28b7af4-2284-40bf-b28b-84baad4dc1a7','top_image_2','\"2023-08-31-64ef2a26b54e0.png\"','\"2023-08-31-64ef2a26b54e0.png\"','landing_images','live',0,'2022-10-03 16:06:00','2023-08-30 18:38:14'),('e2bcae59-8095-4b14-8faf-ebe4a1a867cb','booking_ongoing','{\"booking_ongoing_status\":\"1\",\"booking_ongoing_message\":\"Booking Ongoing\"}','{\"booking_ongoing_status\":\"1\",\"booking_ongoing_message\":\"Booking Ongoing\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('e5362c47-db82-4437-86d8-626bfa78e264','booking_complete','{\"booking_complete_status\":\"1\",\"booking_complete_message\":\"Booking Complete\"}','{\"booking_complete_status\":\"1\",\"booking_complete_message\":\"Booking Complete\"}','serviceman_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('e79f70a2-7580-422c-9d07-8dc47e3961bc','free_trial_type','\"day\"','\"day\"','subscription_Setting','live',1,'2024-07-09 18:57:16','2024-07-09 18:57:16'),('e80a7c3d-9371-4959-8463-c67973a42e56','business_email','\"email@tech.com\"','\"email@tech.com\"','business_information','live',1,'2022-06-14 09:39:24','2022-10-04 16:21:24'),('e82e188c-d7de-478b-a83b-26c086b0576d','2factor','{\"gateway\":\"2factor\",\"mode\":\"live\",\"status\":\"0\",\"api_key\":\"data\"}','{\"gateway\":\"2factor\",\"mode\":\"live\",\"status\":\"0\",\"api_key\":\"data\"}','sms_config','live',0,'2022-06-08 08:56:14','2022-10-04 16:26:44'),('e83290d3-d06b-47dd-b83c-5c8876ed0bd0','apple_login','{\"party_name\":\"apple_login\",\"status\":0,\"client_id\":null,\"team_id\":null,\"key_id\":null,\"service_file\":null}','{\"party_name\":\"apple_login\",\"status\":0,\"client_id\":null,\"team_id\":null,\"key_id\":null,\"service_file\":null}','third_party','live',1,'2023-08-30 13:09:23','2023-08-30 13:09:23'),('e8b657f1-6218-4b73-8e66-118fa4b6186c','address_longitude','\"23.750568449167137\"','\"23.750568449167137\"','business_information','live',1,'2026-10-05 04:49:04','2026-10-05 04:49:04'),('e9cd982f-65cf-4afc-923b-84383e77080f','radius_increment_step','\"3\"',NULL,'location_search','live',1,'2026-10-09 14:13:01','2026-10-09 14:13:01'),('ea0c3ccd-6db7-4b34-8f21-d0eb637cc47c','minimum_withdraw_amount','\"1\"','\"1\"','business_information','live',1,'2023-01-22 17:33:48','2023-08-30 19:38:42'),('ea71998b-2399-44cc-8949-1786e753eb9c','country_code','\"IN\"','\"IN\"','business_information','live',1,'2022-06-14 09:39:24','2026-10-05 04:49:00'),('eb2430a8-8d49-4bbe-b19d-1de8bd80be64','cash_after_service','1','1','service_setup','live',1,'2023-05-29 16:22:38','2023-05-29 16:22:38'),('eb38f917-771c-48b8-8f65-dad3394a2b1b','schedule_booking','1','1','booking_setup','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('eb59a509-e7c2-499b-9c44-57554cbfe015','language_code','[\"Bengali\",\"English\",\"Arabic\",\"Abkhaz\",\"Afar\",\"Akan\",\"Albanian\",\"Amharic\"]','[\"Bengali\",\"English\",\"Arabic\",\"Abkhaz\",\"Afar\",\"Akan\",\"Albanian\",\"Amharic\"]','business_information','live',1,'2022-06-14 09:39:24','2022-07-23 07:26:01'),('ee36e0ac-f41f-4e14-a77c-54e933939a72','referral_discount_type','\"flat\"','\"flat\"','customer_config','live',1,'2024-05-20 14:36:21','2024-05-20 14:36:21'),('eeca1881-9a28-4be9-9c27-95f4e84e6aca','loyalty_point_value_per_currency_unit','0','0','customer_config','live',1,'2023-02-23 00:25:16','2023-02-23 00:25:16'),('f290631d-bf48-45a8-90fc-98060f71d828','booking_accepted','{\"booking_accepted_status\":\"1\",\"booking_accepted_message\":\"Booking Accepted\"}','{\"booking_accepted_status\":\"1\",\"booking_accepted_message\":\"Booking Accepted\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('f4dd708c-4430-4bf1-8f10-797619fbdb7e','provider_subscription','0','0','provider_config','live',1,'2024-07-09 13:20:42','2024-07-09 13:20:42'),('f82d1978-8ab9-4ad3-a84f-050faa17436f','service_request_approve','{\"service_request_approve_status\":\"1\",\"service_request_approve_message\":\"Service Request Review\"}','{\"service_request_approve_status\":\"1\",\"service_request_approve_message\":\"Service Request Review\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('f99e20b3-dfb1-431f-891b-7d78c413e964','booking_refund','{\"booking_refund_status\":1,\"booking_refund_message\":\"Booking Refund Successfully\"}','{\"booking_refund_status\":1,\"booking_refund_message\":\"Booking Refund Successfully\"}','notification_messages','live',1,'2022-06-06 12:41:28','2022-09-05 15:17:05'),('fb2792f7-d2f9-4560-83e0-61a8ed5d4aed','booking_cancel','{\"booking_cancel_status\":\"1\",\"booking_cancel_message\":\"Booking Cancel\"}','{\"booking_cancel_status\":\"1\",\"booking_cancel_message\":\"Booking Cancel\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('fc50433d-6dff-4a85-adaa-9bf1a27fc9ad','customized_booking_request','{\"customized_booking_request_status\":\"1\",\"customized_booking_request_message\":\"Customized Booking Request\"}','{\"customized_booking_request_status\":\"1\",\"customized_booking_request_message\":\"Customized Booking Request\"}','customer_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('fc7e71f7-c5d1-4c8a-aec4-ccbee608314d','deadline_warning','5','5','subscription_Setting','live',1,'2024-07-09 18:57:16','2024-07-09 18:57:16'),('fc9ca7b4-4f21-4d45-a0cb-04693ebee4dc','provider_section_image','\"2022-10-04-633bfb7cc79de.png\"','\"2022-10-04-633bfb7cc79de.png\"','landing_images','live',0,'2022-10-03 17:17:01','2022-10-04 16:23:08'),('fccca07e-50a5-4a6e-b509-5840a14fbc03','booking_schedule_time_change','{\"booking_schedule_time_change_status\":\"1\",\"booking_schedule_time_change_message\":\"Booking schedule time change\"}','{\"booking_schedule_time_change_status\":\"1\",\"booking_schedule_time_change_message\":\"Booking schedule time change\"}','provider_notification','live',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('fe386570-fee3-46bd-a9eb-1b34be33b7d6','loyalty_point_percentage_per_booking','0','0','customer_config','live',1,'2023-02-23 00:25:16','2023-02-23 00:25:16');
/*!40000 ALTER TABLE `business_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calls`
--

DROP TABLE IF EXISTS `calls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calls` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `caller_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `callee_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `call_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'voice',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ringing',
  `ring_expires_at` timestamp NULL DEFAULT NULL,
  `answered_at` timestamp NULL DEFAULT NULL,
  `ended_at` timestamp NULL DEFAULT NULL,
  `duration` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calls_caller_id_index` (`caller_id`),
  KEY `calls_callee_id_index` (`callee_id`),
  KEY `calls_status_index` (`status`),
  KEY `calls_booking_id_index` (`booking_id`),
  KEY `calls_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calls`
--

LOCK TABLES `calls` WRITE;
/*!40000 ALTER TABLE `calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `calls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover_image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `thumbnail` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `discount_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns`
--

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_cost` decimal(24,2) NOT NULL DEFAULT '0.00',
  `quantity` int NOT NULL DEFAULT '1',
  `discount_amount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `coupon_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_discount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `campaign_discount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `total_cost` decimal(24,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_guest` tinyint(1) NOT NULL DEFAULT '0',
  `coupon_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES ('535937c4-51f6-4f47-badc-d5693071b460','667d9bb6-672b-4c13-86eb-ba2c5bca6664',NULL,'99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5','bc250cc5-990b-4864-aac1-c8dde7b63427','8a904eea-a4ce-4482-8100-abd9f8cd8a69','new',1110.00,1,0.00,NULL,0.00,0.00,0.00,1110.00,'2026-10-13 16:44:47','2026-10-13 16:44:47',1,'0'),('e6575d27-18e0-4e3c-9b55-105f8daaa77e','6338def3-8c22-4433-b00d-e515f661fd80',NULL,'99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5','bc250cc5-990b-4864-aac1-c8dde7b63427','8a904eea-a4ce-4482-8100-abd9f8cd8a69','new',1110.00,1,0.00,NULL,0.00,0.00,0.00,1110.00,'2026-10-13 17:43:59','2026-10-13 17:43:59',1,'0');
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int unsigned NOT NULL DEFAULT '1',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('8a904eea-a4ce-4482-8100-abd9f8cd8a69','bc250cc5-990b-4864-aac1-c8dde7b63427','Door Work','door-work','2026-10-04-6ac1fc77334b6.webp',2,'new',1,0,'2026-10-04 20:12:55','2026-10-04 20:12:55'),('bc250cc5-990b-4864-aac1-c8dde7b63427','0','Carpentry','carpentry','2026-10-04-6ac1fc240d4db.webp',1,NULL,1,1,'2026-10-04 20:11:32','2026-10-04 20:11:54'),('cat-0001-0001-0001-000000000001','0','Home Cleaning','home-cleaning','2023-08-31-64ef394fcd699.png',1,'Professional home cleaning services',1,1,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0001-0001-0001-000000000002','0','Plumbing','plumbing','2023-08-31-64ef394fcd699.png',1,'Expert plumbing repair and installation',1,1,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0001-0001-0001-000000000003','0','Electrical','electrical','2023-08-31-64ef394fcd699.png',1,'Electrical repair and installation services',1,1,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0001-0001-0001-000000000005','0','Painting','painting','2023-08-31-64ef394fcd699.png',1,'Interior and exterior painting',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0001-0001-0001-000000000006','0','Appliance Repair','appliance-repair','2023-08-31-64ef394fcd699.png',1,'Home appliance repair services',1,1,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0001-0001-0001-000000000007','0','Pest Control','pest-control','2023-08-31-64ef394fcd699.png',1,'Termite cockroach and pest control',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0001-0001-0001-000000000008','0','AC Repair','ac-repair','2023-08-31-64ef394fcd699.png',1,'AC installation servicing and repair',1,1,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000001','cat-0001-0001-0001-000000000001','Deep Cleaning','deep-cleaning','2023-08-31-64ef3983e4faa.png',2,'Thorough deep cleaning for your home',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000002','cat-0001-0001-0001-000000000001','Regular Cleaning','regular-cleaning','2023-08-31-64ef3983e4faa.png',2,'Daily and weekly cleaning services',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000003','cat-0001-0001-0001-000000000001','Sofa Cleaning','sofa-cleaning','2023-08-31-64ef3983e4faa.png',2,'Professional sofa and upholstery cleaning',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000004','cat-0001-0001-0001-000000000001','Carpet Cleaning','carpet-cleaning','2023-08-31-64ef3983e4faa.png',2,'Carpet and rug cleaning',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000005','cat-0001-0001-0001-000000000002','Pipe Leakage Repair','pipe-leakage-repair','2023-08-31-64ef3983e4faa.png',2,'Fix pipe leaks and burst pipes',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000006','cat-0001-0001-0001-000000000002','Toilet Repair','toilet-repair','2023-08-31-64ef3983e4faa.png',2,'Toilet installation and repair',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000007','cat-0001-0001-0001-000000000002','Tap and Faucet','tap-faucet','2023-08-31-64ef3983e4faa.png',2,'Tap and faucet repair or replacement',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000008','cat-0001-0001-0001-000000000002','Water Tank Cleaning','water-tank-cleaning','2023-08-31-64ef3983e4faa.png',2,'Water tank cleaning and sanitization',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000009','cat-0001-0001-0001-000000000003','Fan Installation','fan-installation','2023-08-31-64ef3983e4faa.png',2,'Ceiling and exhaust fan installation',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000010','cat-0001-0001-0001-000000000003','Switch and Socket Repair','switch-socket-repair','2023-08-31-64ef3983e4faa.png',2,'Switch and socket repair or replacement',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000011','cat-0001-0001-0001-000000000003','Wiring Work','wiring-work','2023-08-31-64ef3983e4faa.png',2,'Complete house wiring and rewiring',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000012','cat-0001-0001-0001-000000000008','AC Installation','ac-installation','2023-08-31-64ef3983e4faa.png',2,'Split and window AC installation',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000013','cat-0001-0001-0001-000000000008','AC Gas Refill','ac-gas-refill','2023-08-31-64ef3983e4faa.png',2,'AC gas charging and refill',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('cat-0002-0001-0001-000000000014','cat-0001-0001-0001-000000000008','AC Servicing','ac-servicing','2023-08-31-64ef3983e4faa.png',2,'AC general servicing and cleaning',1,0,'2026-09-12 15:45:55','2026-09-12 15:45:55');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_position_bak`
--

DROP TABLE IF EXISTS `categories_position_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories_position_bak` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int unsigned NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_position_bak`
--

LOCK TABLES `categories_position_bak` WRITE;
/*!40000 ALTER TABLE `categories_position_bak` DISABLE KEYS */;
INSERT INTO `categories_position_bak` VALUES ('cat-0001-0001-0001-000000000001','home-cleaning',1),('cat-0001-0001-0001-000000000002','plumbing',2),('cat-0001-0001-0001-000000000003','electrical',3),('cat-0001-0001-0001-000000000004','carpentry',4),('cat-0001-0001-0001-000000000005','painting',5),('cat-0001-0001-0001-000000000006','appliance-repair',6),('cat-0001-0001-0001-000000000007','pest-control',7),('cat-0001-0001-0001-000000000008','ac-repair',8),('cat-0002-0001-0001-000000000001','deep-cleaning',1),('cat-0002-0001-0001-000000000002','regular-cleaning',2),('cat-0002-0001-0001-000000000003','sofa-cleaning',3),('cat-0002-0001-0001-000000000004','carpet-cleaning',4),('cat-0002-0001-0001-000000000005','pipe-leakage-repair',1),('cat-0002-0001-0001-000000000006','toilet-repair',2),('cat-0002-0001-0001-000000000007','tap-faucet',3),('cat-0002-0001-0001-000000000008','water-tank-cleaning',4),('cat-0002-0001-0001-000000000009','fan-installation',1),('cat-0002-0001-0001-000000000010','switch-socket-repair',2),('cat-0002-0001-0001-000000000011','wiring-work',3),('cat-0002-0001-0001-000000000012','ac-installation',1),('cat-0002-0001-0001-000000000013','ac-gas-refill',2),('cat-0002-0001-0001-000000000014','ac-servicing',3);
/*!40000 ALTER TABLE `categories_position_bak` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_zone`
--

DROP TABLE IF EXISTS `category_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_zone` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_zone`
--

LOCK TABLES `category_zone` WRITE;
/*!40000 ALTER TABLE `category_zone` DISABLE KEYS */;
INSERT INTO `category_zone` VALUES (2,'cat-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(3,'cat-0001-0001-0001-000000000002','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(4,'cat-0001-0001-0001-000000000003','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(6,'cat-0001-0001-0001-000000000005','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(7,'cat-0001-0001-0001-000000000006','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(8,'cat-0001-0001-0001-000000000007','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(9,'cat-0001-0001-0001-000000000008','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(10,'cat-0002-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(11,'cat-0002-0001-0001-000000000002','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(12,'cat-0002-0001-0001-000000000003','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(13,'cat-0002-0001-0001-000000000005','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(14,'cat-0002-0001-0001-000000000007','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(15,'cat-0002-0001-0001-000000000009','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(16,'cat-0002-0001-0001-000000000010','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(17,'cat-0002-0001-0001-000000000012','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(18,'cat-0002-0001-0001-000000000013','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(19,'cat-0002-0001-0001-000000000014','a1614dbe-4732-11ee-9702-dee6e8d77be4','2026-09-12 15:45:55','2026-09-12 15:45:55'),(20,'cat-0002-0001-0001-000000000013','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(21,'cat-0002-0001-0001-000000000012','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(22,'cat-0001-0001-0001-000000000008','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(23,'cat-0002-0001-0001-000000000014','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(24,'cat-0001-0001-0001-000000000006','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(26,'cat-0002-0001-0001-000000000004','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(27,'cat-0002-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(28,'cat-0001-0001-0001-000000000003','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(29,'cat-0002-0001-0001-000000000009','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(30,'cat-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(31,'cat-0001-0001-0001-000000000005','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(32,'cat-0001-0001-0001-000000000007','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(33,'cat-0002-0001-0001-000000000005','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(34,'cat-0001-0001-0001-000000000002','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(35,'cat-0002-0001-0001-000000000002','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(36,'cat-0002-0001-0001-000000000003','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(37,'cat-0002-0001-0001-000000000010','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(38,'cat-0002-0001-0001-000000000007','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(39,'cat-0002-0001-0001-000000000006','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(40,'cat-0002-0001-0001-000000000008','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(41,'cat-0002-0001-0001-000000000011','c00ed508-2bf3-43c3-b95c-8e880de67168','2026-09-15 08:31:07','2026-09-15 08:31:07'),(44,'bc250cc5-990b-4864-aac1-c8dde7b63427','6b1c8733-b0ff-4c65-a745-1f46419adc49',NULL,NULL);
/*!40000 ALTER TABLE `category_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_conversations`
--

DROP TABLE IF EXISTS `channel_conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_conversations` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_conversations`
--

LOCK TABLES `channel_conversations` WRITE;
/*!40000 ALTER TABLE `channel_conversations` DISABLE KEYS */;
INSERT INTO `channel_conversations` VALUES ('1842ca73-3b87-4cdf-a652-fa5c73efcf66','699a7b16-ac4f-4c33-9bcf-d37fdd9bfabd','hi','sman-0001-0001-0001-000000000001',NULL,'2026-09-29 18:22:47','2026-09-29 18:22:47'),('5c7eb484-23e4-4410-8a79-0329fafb5bcb','67cca719-cdfe-4cca-8251-1652a79a6d81','hi','prvd-0001-0001-0001-000000000001',NULL,'2026-10-07 11:52:26','2026-10-07 11:52:26'),('6c628b75-8c74-403c-b950-8015fea5b27c','699a7b16-ac4f-4c33-9bcf-d37fdd9bfabd','hi','sman-0001-0001-0001-000000000001',NULL,'2026-09-14 19:25:05','2026-09-14 19:25:05');
/*!40000 ALTER TABLE `channel_conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_lists`
--

DROP TABLE IF EXISTS `channel_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_lists` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:guid)',
  `reference_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_lists`
--

LOCK TABLES `channel_lists` WRITE;
/*!40000 ALTER TABLE `channel_lists` DISABLE KEYS */;
INSERT INTO `channel_lists` VALUES ('3a38e668-058c-4ea5-8702-133f89f00b9e','','support',NULL,'2026-10-22 17:22:01','2026-10-22 17:22:01'),('67cca719-cdfe-4cca-8251-1652a79a6d81','0978aaa3-bde3-4438-a245-b9c7dbebfd62','booking_id',NULL,'2026-10-07 11:52:12','2026-10-07 11:52:26'),('699a7b16-ac4f-4c33-9bcf-d37fdd9bfabd','','support',NULL,'2026-09-14 02:09:18','2026-09-29 18:22:47'),('9e2d421a-78b3-4dfe-b1a0-d11a750407d2','','support',NULL,'2026-10-23 12:44:33','2026-10-23 12:44:33'),('aaef61c0-c8a0-4e2f-b95c-fede30d6a5ca','','support',NULL,'2026-09-22 23:01:29','2026-09-22 23:01:29'),('dea2017e-508e-4e1b-8a2d-a9bed377dc34','','support',NULL,'2026-09-17 23:46:22','2026-09-17 23:46:22'),('e130f62c-2768-4b1a-9f5e-43c768c0ed77','','support',NULL,'2026-10-22 17:22:01','2026-10-22 17:22:01');
/*!40000 ALTER TABLE `channel_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_users`
--

DROP TABLE IF EXISTS `channel_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_users` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_users`
--

LOCK TABLES `channel_users` WRITE;
/*!40000 ALTER TABLE `channel_users` DISABLE KEYS */;
INSERT INTO `channel_users` VALUES ('09fc13ad-ea83-42e3-8dc5-bfbead07b60c','dea2017e-508e-4e1b-8a2d-a9bed377dc34','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,'2026-09-17 23:46:23','2026-10-07 15:32:48',1),('1a002497-63d8-4eac-9bff-63bc56be20e1','e130f62c-2768-4b1a-9f5e-43c768c0ed77','prvd-0001-0001-0001-000000000001',NULL,'2026-10-22 17:22:01','2026-10-22 17:22:01',0),('281eccbf-12f7-4359-97ea-f4b3bec6984e','9e2d421a-78b3-4dfe-b1a0-d11a750407d2','sman-0001-0001-0001-000000000001',NULL,'2026-10-23 12:44:33','2026-10-23 12:44:33',0),('332669cb-d75c-43e5-80b3-1f3da3f9a528','3a38e668-058c-4ea5-8702-133f89f00b9e','prvd-0001-0001-0001-000000000001',NULL,'2026-10-22 17:22:01','2026-10-22 17:22:01',0),('4454c0f7-289e-4788-b2b0-5e7eaabfaf86','67cca719-cdfe-4cca-8251-1652a79a6d81','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,'2026-10-07 11:52:12','2026-10-07 15:31:45',1),('47874813-c691-4cb7-909a-3e91947431c8','e130f62c-2768-4b1a-9f5e-43c768c0ed77','0eb668a3-bef8-41e8-a539-a005a1037075',NULL,'2026-10-22 17:22:01','2026-10-22 17:22:01',0),('51935ab4-f10a-4cfb-8236-a649b3155cce','9e2d421a-78b3-4dfe-b1a0-d11a750407d2','0eb668a3-bef8-41e8-a539-a005a1037075',NULL,'2026-10-23 12:44:33','2026-10-23 12:44:33',0),('85cadc4b-572b-4bdc-ae5f-170e4398a566','dea2017e-508e-4e1b-8a2d-a9bed377dc34','8be51d97-6fe0-4d46-a9c6-d77b4d2386f5',NULL,'2026-09-17 23:46:23','2026-10-17 13:51:47',1),('8fe60ddb-9bec-4d33-8871-1a575ab903e8','67cca719-cdfe-4cca-8251-1652a79a6d81','prvd-0001-0001-0001-000000000001',NULL,'2026-10-07 11:52:12','2026-10-07 14:25:29',1),('b31b938a-6a52-49af-8378-d0b7a96f1123','aaef61c0-c8a0-4e2f-b95c-fede30d6a5ca','8be51d97-6fe0-4d46-a9c6-d77b4d2386f5',NULL,'2026-09-22 23:01:29','2026-10-13 12:47:02',1),('c0daeca1-54b7-47c8-a03a-114d1a832177','3a38e668-058c-4ea5-8702-133f89f00b9e','0eb668a3-bef8-41e8-a539-a005a1037075',NULL,'2026-10-22 17:22:01','2026-10-22 17:22:01',0),('dc2a5be2-0d3c-430e-9d5a-68a3ac5c18f2','699a7b16-ac4f-4c33-9bcf-d37fdd9bfabd','sman-0001-0001-0001-000000000001',NULL,'2026-09-14 02:09:18','2026-10-01 20:29:57',1),('e3cd3495-6ee9-4441-b765-d2d7c0674580','aaef61c0-c8a0-4e2f-b95c-fede30d6a5ca','prvd-0001-0001-0001-000000000001',NULL,'2026-09-22 23:01:29','2026-10-07 16:46:34',1),('ea4ed8b7-b96e-4a19-aa5e-8216839bcc76','699a7b16-ac4f-4c33-9bcf-d37fdd9bfabd','8be51d97-6fe0-4d46-a9c6-d77b4d2386f5',NULL,'2026-09-14 02:09:18','2026-09-29 18:22:47',0);
/*!40000 ALTER TABLE `channel_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversation_files`
--

DROP TABLE IF EXISTS `conversation_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversation_files` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversation_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stored_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation_files`
--

LOCK TABLES `conversation_files` WRITE;
/*!40000 ALTER TABLE `conversation_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversation_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon_customers`
--

DROP TABLE IF EXISTS `coupon_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_customers` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_customers`
--

LOCK TABLES `coupon_customers` WRITE;
/*!40000 ALTER TABLE `coupon_customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupon_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cron_jobs`
--

DROP TABLE IF EXISTS `cron_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cron_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_mail_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_mail_day` int NOT NULL DEFAULT '1',
  `activity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `php_file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `command` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cron_jobs`
--

LOCK TABLES `cron_jobs` WRITE;
/*!40000 ALTER TABLE `cron_jobs` DISABLE KEYS */;
INSERT INTO `cron_jobs` VALUES (1,'Subscription renewal reminder mail',NULL,1,NULL,NULL,NULL,0,'2024-10-08 12:42:37','2024-10-08 12:42:37','subscription_renewal_reminder'),(2,'Free Trial End Mail',NULL,1,NULL,NULL,NULL,0,'2024-10-08 12:42:37','2024-10-08 12:42:37','free_trial_end'),(3,'Subscription Time End Mail',NULL,1,NULL,NULL,NULL,0,'2024-10-08 12:42:37','2024-10-08 12:42:37','subscription_time_end');
/*!40000 ALTER TABLE `cron_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_settings`
--

DROP TABLE IF EXISTS `data_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_settings` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_settings`
--

LOCK TABLES `data_settings` WRITE;
/*!40000 ALTER TABLE `data_settings` DISABLE KEYS */;
INSERT INTO `data_settings` VALUES ('0689bba0-0de2-4820-902a-5b4840af7fe9','bottom_title','GET ALL UPDATES & EXCITING NEWS','landing_text_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('11c9071f-70e2-412b-ba73-73da0ae9f7cb','refund_policy','<p>Test Refund Policy</p>','pages_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('201cb409-8aab-479c-a8f4-fd5b545ab03c','newsletter_title','GET ALL UPDATES & EXCITING NEWS','landing_text_setup',1,'2025-04-19 16:16:25','2025-04-19 16:16:25'),('2787bb42-2e6a-43a4-81f1-7aee084f7083','bottom_description','Subcribe to out newsletters to receive all the latest activty we provide for you','landing_text_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('42a986a9-831b-4789-9ae4-26b8284a2017','top_title','Customer Statisfaciton is our main moto','landing_text_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('514e21aa-ae56-447e-9f9d-a34d4995bb9e','cancellation_policy','<p>Test Cancellation Policy</p>','pages_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('7f249215-5ee0-4a39-872e-3b3bd2634278','about_us','<p>Test About Us</p>','pages_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('875a27cc-5456-4573-a4af-cdf9d2e15c16','registration_title','REGISTER AS PROVIDER','landing_text_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('95b1d2d7-b656-4ea6-9347-79909a94e7dd','registration_description','Become e provider & Start your own business online with on demand service platform','landing_text_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('af772e44-2cea-4396-bb82-9dbc13eb8691','top_sub_title','Get all services from one App.','landing_text_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('c1f90ba8-3432-4478-8f35-7c992fa10aaf','privacy_policy','<p>Test Privacy Policy</p>','pages_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('c60d816a-3100-4d3e-8aba-013a0ef13639','about_us_description','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,','landing_text_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('cc560bd2-5558-430f-8f48-cfde9048b77f','newsletter_description','Subscribe to out newsletters to receive all the latest activity we provide for you','landing_text_setup',1,'2025-04-19 16:16:25','2025-04-19 16:16:25'),('f4df4ad8-96be-4f99-a14e-6dc7c82035f8','top_description','LARGEST BOOKING SERVICE PLATEFORM','landing_text_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('f4e72cf5-7e3f-40e0-a7b0-1185c62a65fa','about_us_title','WHO WE ARE','landing_text_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('f64ffa14-fb1c-47e6-8736-0da45af39785','terms_and_conditions','<p>Test Terms & Conditions</p>','pages_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21'),('f6516965-15da-4fd6-805d-7788c0121a5f','mid_title','SERVICE WE PROVIDE FOR YOU','landing_text_setup',1,'2023-11-28 15:33:21','2023-11-28 15:33:21');
/*!40000 ALTER TABLE `data_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount_types`
--

DROP TABLE IF EXISTS `discount_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `discount_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_wise_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount_types`
--

LOCK TABLES `discount_types` WRITE;
/*!40000 ALTER TABLE `discount_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `discount_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `discount_amount_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'percent',
  `min_purchase` decimal(24,3) NOT NULL DEFAULT '0.000',
  `max_discount_amount` decimal(24,3) NOT NULL DEFAULT '0.000',
  `limit_per_user` int NOT NULL DEFAULT '0',
  `promotion_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'discount',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `start_date` date NOT NULL DEFAULT '2022-04-04',
  `end_date` date NOT NULL DEFAULT '2022-04-04',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_role_accesses`
--

DROP TABLE IF EXISTS `employee_role_accesses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_role_accesses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `can_view` tinyint NOT NULL DEFAULT '1',
  `can_add` tinyint NOT NULL DEFAULT '0',
  `can_update` tinyint NOT NULL DEFAULT '0',
  `can_delete` tinyint NOT NULL DEFAULT '0',
  `can_export` tinyint NOT NULL DEFAULT '0',
  `can_manage_status` tinyint NOT NULL DEFAULT '0',
  `can_approve_or_deny` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `can_assign_serviceman` tinyint NOT NULL DEFAULT '0',
  `can_give_feedback` tinyint NOT NULL DEFAULT '0',
  `can_take_backup` tinyint NOT NULL DEFAULT '0',
  `can_change_status` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_role_accesses`
--

LOCK TABLES `employee_role_accesses` WRITE;
/*!40000 ALTER TABLE `employee_role_accesses` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_role_accesses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_role_sections`
--

DROP TABLE IF EXISTS `employee_role_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_role_sections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_role_sections`
--

LOCK TABLES `employee_role_sections` WRITE;
/*!40000 ALTER TABLE `employee_role_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_role_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `error_logs`
--

DROP TABLE IF EXISTS `error_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `error_logs` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_code` int DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hit_counts` int NOT NULL DEFAULT '0',
  `redirect_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `error_logs`
--

LOCK TABLES `error_logs` WRITE;
/*!40000 ALTER TABLE `error_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `error_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs`
--

LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
INSERT INTO `faqs` VALUES ('1bcb0f5d-34e2-4bdf-bb9c-b7a6260c555f','hi','no','svc-0001-0001-0001-000000000001',1,'2026-09-17 23:57:53','2026-09-17 23:57:53'),('85f3adf4-fcd7-46f9-90d3-01bc9353c686','hi','no','svc-0001-0001-0001-000000000001',1,'2026-09-17 23:57:53','2026-09-17 23:57:53'),('c82aee8c-a9d5-41f9-aaa3-d8310368bc7d','hi','no','svc-0001-0001-0001-000000000001',1,'2026-09-17 23:57:50','2026-09-17 23:57:50');
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite_providers`
--

DROP TABLE IF EXISTS `favorite_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite_providers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite_providers`
--

LOCK TABLES `favorite_providers` WRITE;
/*!40000 ALTER TABLE `favorite_providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorite_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite_services`
--

DROP TABLE IF EXISTS `favorite_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite_services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite_services`
--

LOCK TABLES `favorite_services` WRITE;
/*!40000 ALTER TABLE `favorite_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorite_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guests`
--

DROP TABLE IF EXISTS `guests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guests` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guest_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `current_language_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guests`
--

LOCK TABLES `guests` WRITE;
/*!40000 ALTER TABLE `guests` DISABLE KEYS */;
INSERT INTO `guests` VALUES ('000c30fe-4193-4a6c-88c8-26f1ec403250','18a2a9e0-c5fc-11f1-ac03-37b626f924f1','172.18.0.1','2026-10-18 19:45:50','2026-10-18 19:45:50','en'),('008ad2eb-e288-497a-a733-abf89050c9e7',NULL,'172.18.0.1','2026-09-15 18:00:57','2026-09-15 18:00:57','en'),('008b5170-2743-4dc3-a2dd-c23336bed745',NULL,'172.18.0.1','2026-09-24 23:30:17','2026-09-24 23:30:17','en'),('01227081-354e-43df-8acf-9e56744b4516',NULL,'172.18.0.1','2026-09-18 20:03:43','2026-09-18 20:03:43','en'),('01ad4329-61fd-44b8-baa7-7cd4d5fe5dee',NULL,'172.18.0.1','2026-10-02 00:37:22','2026-10-02 00:37:22','en'),('01b67c36-2ca5-46da-850e-5098cc6c8c22',NULL,'172.18.0.1','2026-09-28 22:54:51','2026-09-28 22:54:51','en'),('01f5c1fb-35a3-400c-b7d2-09dfc6ea0fef',NULL,'172.18.0.1','2026-09-18 18:43:59','2026-09-18 18:43:59','en'),('023f7728-0cbe-430c-8335-2ad58e68da7c',NULL,'172.18.0.1','2026-10-01 01:14:16','2026-10-01 01:14:16','en'),('0247bc1c-b991-459a-a9d9-a00b0997e840',NULL,'172.18.0.1','2026-09-24 23:31:10','2026-09-24 23:31:10','en'),('02624cec-179a-4547-ac43-0d12b17c79a2',NULL,'172.18.0.1','2026-09-17 20:41:46','2026-09-17 20:41:46','en'),('02897dd5-8af3-495f-85f8-1c60ad403c0e',NULL,'172.18.0.1','2026-09-15 22:53:19','2026-09-15 22:53:19','en'),('02c25472-a215-41bd-a97a-8ea28c8cb1ce','22ba5cd0-bcb4-11f1-8309-9b372e7bac32','172.18.0.1','2026-09-30 22:52:21','2026-09-30 22:52:21','en'),('02e95b1a-c91e-445d-a9ab-c34ef7636b1e',NULL,'172.18.0.1','2026-10-04 07:07:51','2026-10-04 07:07:51','en'),('030f374c-d94a-43f8-9a3a-efdb0cbc7a4b',NULL,'172.18.0.1','2026-10-01 01:54:14','2026-10-01 01:54:14','en'),('033d3104-4da4-4072-8213-4ccae421e9c5',NULL,'172.18.0.1','2026-09-22 17:59:07','2026-09-22 17:59:07','en'),('0376135e-5796-4701-8f43-a1936c8c0fba',NULL,'172.18.0.1','2026-09-28 22:52:20','2026-09-28 22:52:20','en'),('0415a3eb-eee6-45b7-97d6-5c82efeaa3e4',NULL,'172.18.0.1','2026-09-17 00:59:00','2026-09-17 00:59:00','en'),('044131d8-424e-44ee-8b56-18f220a4bc74',NULL,'172.18.0.1','2026-10-01 01:50:55','2026-10-01 01:50:55','en'),('049ed449-bb06-415a-bb83-be48f20b30d0',NULL,'172.18.0.1','2026-09-16 20:01:29','2026-09-16 20:01:29','en'),('04cb3fd0-da0c-45fa-aafe-5159cfd8fc8f',NULL,'172.18.0.1','2026-10-18 18:17:07','2026-10-18 18:17:07','en'),('04d57223-cab7-4eff-a148-9fbd606443aa',NULL,'172.18.0.1','2026-09-30 20:16:31','2026-09-30 20:16:31','en'),('04e49f82-656d-491c-b292-daddb13bce49',NULL,'172.18.0.1','2026-09-24 23:27:12','2026-09-24 23:27:12','en'),('04e73bb2-4577-4013-8c0a-2c9e4ff320ba',NULL,'172.18.0.1','2026-10-02 20:14:28','2026-10-02 20:14:28','en'),('04e8816c-8bb6-4c50-ab7a-10c95d7688b4',NULL,'172.18.0.1','2026-09-24 20:37:59','2026-09-24 20:37:59','en'),('051b5ef2-a181-476e-92cb-6e3e3d9b93cf',NULL,'172.18.0.1','2026-10-01 01:50:35','2026-10-01 01:50:35','en'),('0553e49e-939d-41b5-a150-b34a17efed01',NULL,'172.18.0.1','2026-10-01 02:00:13','2026-10-01 02:00:13','en'),('063f7105-6a7b-4ea2-ad4d-791cd13e71b3',NULL,'172.18.0.1','2026-10-01 23:09:28','2026-10-01 23:09:28','en'),('06684f62-12de-4bb3-a494-14d3c821f346',NULL,'172.18.0.1','2026-09-25 19:06:40','2026-09-25 19:06:40','en'),('06b815c6-c47b-46e2-a2f9-a764f3abf7b9',NULL,'172.18.0.1','2026-09-17 23:09:41','2026-09-17 23:09:41','en'),('070dedab-1e2b-40f6-bf4d-15606c2de6ef',NULL,'172.18.0.1','2026-10-01 02:06:46','2026-10-01 02:06:46','en'),('072ed8e6-5f33-4aac-a9cf-116d13fffeb4',NULL,'172.18.0.1','2026-09-15 01:10:41','2026-09-15 01:10:41','en'),('0737943b-c5e3-4c1a-9692-9626ddf47166',NULL,'172.18.0.1','2026-09-24 22:08:11','2026-09-24 22:08:11','en'),('079a8d13-97aa-4942-b3cf-3b00207336fc',NULL,'172.18.0.1','2026-10-08 16:41:44','2026-10-08 16:41:44','en'),('097a2dcf-e9c6-4689-a9bc-596de569c0e2',NULL,'172.18.0.1','2026-10-01 01:04:53','2026-10-01 01:04:53','en'),('0988cdf0-7708-4cdb-8d8f-9a97190e4fb1',NULL,'172.18.0.1','2026-09-16 00:55:29','2026-09-16 00:55:29','en'),('0998ec8a-61a2-43e4-9eb6-fb4459eb3cd8',NULL,'172.18.0.1','2026-10-01 23:17:13','2026-10-01 23:17:13','en'),('09acabf4-470c-413a-94d6-8a654aba4fbb',NULL,'172.18.0.1','2026-10-02 00:04:35','2026-10-02 00:04:35','en'),('0ab861a1-23c8-47fd-83e4-851a7be875c7',NULL,'172.18.0.1','2026-09-18 22:16:55','2026-09-18 22:16:55','en'),('0af52f36-5f70-4c4c-9cf1-060da332aa96',NULL,'172.18.0.1','2026-09-17 01:19:42','2026-09-17 01:19:42','en'),('0bab5f74-502a-497b-8372-080b79fb19e0',NULL,'172.18.0.1','2026-09-17 02:13:52','2026-09-17 02:13:52','en'),('0beabe0b-3d96-4157-a57e-78cff8596415',NULL,'172.18.0.1','2026-09-28 22:51:23','2026-09-28 22:51:23','en'),('0c126974-a5d0-45cd-b287-aeedcfce9777',NULL,'172.18.0.1','2026-10-27 12:01:58','2026-10-27 12:01:58','en'),('0c1facba-3bea-49cd-9234-fc2e8d88e1f9','9b6c8600-396a-4606-88d9-a1e581d4ebbc','172.18.0.8','2026-10-14 10:37:08','2026-10-14 10:37:08','en'),('0c9a6599-dcf2-4f46-b61d-f550c04e6609',NULL,'172.18.0.1','2026-09-17 22:50:31','2026-09-17 22:50:31','en'),('0cb83572-d541-4a33-8c2c-c28c0b8ac277',NULL,'172.18.0.1','2026-09-18 18:09:46','2026-09-18 18:09:46','en'),('0d2e8aa1-ce97-457b-a7c9-4f299c2bcfe9',NULL,'172.18.0.1','2026-09-15 20:40:22','2026-09-15 20:40:22','en'),('0d7955b8-eabb-4b93-bcd3-cf622f5a3285',NULL,'172.18.0.1','2026-09-24 23:24:18','2026-09-24 23:24:18','en'),('0d7fa7f8-d75f-4be6-9d4c-849568cc374c',NULL,'172.18.0.1','2026-09-15 18:43:40','2026-09-15 18:43:40','en'),('0d90cb2b-6200-467e-a0fb-8e765eeecdea',NULL,'172.18.0.1','2026-09-30 01:01:54','2026-09-30 01:01:54','en'),('0dd961c2-4ef1-42f9-a7cb-7993f04df0ac','3508fb57-9ac6-4177-946a-334d23f19a13','172.18.0.8','2026-10-14 10:38:11','2026-10-14 10:38:11','en'),('0e286213-7d02-4d5f-9841-058a0043de06',NULL,'172.18.0.1','2026-09-24 23:27:18','2026-09-24 23:27:18','en'),('0e813a79-b196-4ad0-88ff-872c913b1a01',NULL,'172.18.0.1','2026-09-14 18:13:40','2026-09-14 18:13:40','en'),('0f160816-497b-49ff-8afa-bb02dded414e',NULL,'172.18.0.1','2026-09-19 02:05:35','2026-09-19 02:05:35','en'),('0f16c64d-dbe0-404b-a101-533796c6862f','18a2a9e0-c5fc-11f1-ac03-37b626f924f1','172.18.0.1','2026-10-18 15:45:13','2026-10-18 15:45:13','en'),('0f650f6f-5dea-45bd-ac12-c790c44d2533',NULL,'172.18.0.1','2026-09-24 23:34:27','2026-09-24 23:34:27','en'),('0fd8f997-66ec-40d5-bda9-1c3abada1b4b',NULL,'172.18.0.1','2026-09-24 23:31:17','2026-09-24 23:31:17','en'),('101e678f-4611-459f-8dc2-f357cb708169',NULL,'172.18.0.1','2026-09-16 00:24:23','2026-09-16 00:24:23','en'),('10bcaddd-84c3-4272-8982-2ae25800b5d7',NULL,'172.18.0.1','2026-09-15 18:43:26','2026-09-15 18:43:26','en'),('10e3d414-cb89-4971-b1a3-4297fa0ef34d',NULL,'172.18.0.1','2026-10-08 17:05:39','2026-10-08 17:05:39','en'),('113d1d9f-2405-4e8f-9dfa-e98876f28a6e',NULL,'172.18.0.1','2026-09-30 01:03:20','2026-09-30 01:03:20','en'),('1149fcb7-e20c-4809-85ba-692d29748d58',NULL,'172.18.0.1','2026-09-17 18:33:23','2026-09-17 18:33:23','en'),('118661ff-edff-4d86-bfb2-cdf4a574f589',NULL,'172.18.0.1','2026-09-17 23:30:46','2026-09-17 23:30:46','en'),('11ae3f84-fbb3-4737-a6dc-50b526f02bf7',NULL,'172.18.0.1','2026-09-18 02:05:14','2026-09-18 02:05:14','en'),('11c9b991-ad9e-416f-b58c-ae9d65591c04',NULL,'172.18.0.1','2026-09-30 20:16:28','2026-09-30 20:16:28','en'),('12ba712a-3fd7-4ada-bc1b-e9bc1eae916e',NULL,'172.18.0.1','2026-09-25 01:41:53','2026-09-25 01:41:53','en'),('12c116b6-f2f4-4bd2-bc24-1824841f98cc',NULL,'172.18.0.1','2026-10-01 01:35:44','2026-10-01 01:35:44','en'),('12dec096-4a6e-4c7b-8a70-674673f764e8',NULL,'172.18.0.1','2026-09-22 01:17:26','2026-09-22 01:17:26','en'),('12e14ebd-736c-48e6-af01-e52784deaac4',NULL,'172.18.0.1','2026-09-17 20:02:27','2026-09-17 20:02:27','en'),('133c4246-bd34-4ad6-aecb-ba934fa2cda2',NULL,'172.18.0.1','2026-09-30 22:49:06','2026-09-30 22:49:06','en'),('1352dea8-25b7-41d6-8524-cba464de7599',NULL,'172.18.0.1','2026-09-24 23:04:36','2026-09-24 23:04:36','en'),('148f6b7f-41d1-4d20-aeac-54015d2722b0',NULL,'172.18.0.1','2026-09-16 19:41:26','2026-09-16 19:41:26','en'),('14de858a-594b-41fd-8101-6f6561410b10',NULL,'172.18.0.1','2026-09-18 01:48:24','2026-09-18 01:48:24','en'),('1501df7f-a4e9-40ef-b35e-ed75aea2781d',NULL,'172.18.0.1','2026-09-17 20:30:01','2026-09-17 20:30:01','en'),('153fb762-45b9-43d6-af3c-a42af29838f2',NULL,'172.18.0.1','2026-10-26 12:49:42','2026-10-26 12:49:42','en'),('154bf71e-c2e5-40c8-af06-324e770c8b97',NULL,'172.18.0.1','2026-09-17 01:49:35','2026-09-17 01:49:35','en'),('1593bac3-5e90-417b-94cf-8bb5db5a01eb',NULL,'172.18.0.1','2026-09-17 23:09:44','2026-09-17 23:09:44','en'),('15d56978-100d-4d6e-9c04-c54ea263a2b9',NULL,'172.18.0.1','2026-10-01 01:54:18','2026-10-01 01:54:18','en'),('15ed0977-9047-4eab-9974-4eeab6bd3e7a','6338def3-8c22-4433-b00d-e515f661fd80','172.18.0.7','2026-10-13 17:43:59','2026-10-13 17:43:59','en'),('16109797-96a8-4427-9df8-271c10a5b9bc',NULL,'172.18.0.1','2026-10-01 02:17:18','2026-10-01 02:17:18','en'),('1640543a-14b0-463b-9e56-f0ca32d82572',NULL,'172.18.0.1','2026-10-08 17:00:30','2026-10-08 17:00:30','en'),('169240d7-de55-4ead-802f-1958a74979f2',NULL,'172.18.0.1','2026-10-09 15:20:27','2026-10-09 15:20:27','en'),('1710236c-2c9d-4efc-82c6-bd6376529565',NULL,'172.18.0.1','2026-10-04 22:59:37','2026-10-04 22:59:37','en'),('17539198-afad-4df4-836a-8954ec1d772e',NULL,'172.18.0.1','2026-09-21 23:32:37','2026-09-21 23:32:37','en'),('17ba15ce-3d4b-40b8-9e40-fd9e1c9e86ca',NULL,'172.18.0.1','2026-09-16 19:41:30','2026-09-16 19:41:30','en'),('17c85ec4-3267-43db-8bae-4682542e8117',NULL,'192.168.50.57','2024-11-19 15:49:22','2024-11-19 15:49:22','en'),('17e75c72-d2a0-40d6-9d50-c8bcd58e8fb0',NULL,'172.18.0.1','2026-10-01 01:19:15','2026-10-01 01:19:15','en'),('182ecba7-3825-4ea3-8a3b-818aebcf1295',NULL,'172.18.0.1','2026-09-16 02:13:24','2026-09-16 02:13:24','en'),('1837876c-0b9c-4aed-93ba-a998d22a1729',NULL,'172.18.0.1','2026-09-18 02:28:04','2026-09-18 02:28:04','en'),('183c481c-4bde-4b29-bc2f-3694a1fc3459',NULL,'172.18.0.1','2026-09-17 00:34:49','2026-09-17 00:34:49','en'),('18789758-11ec-42e2-81de-29a9caacbb8a',NULL,'172.18.0.1','2026-09-28 22:51:36','2026-09-28 22:51:36','en'),('1922d529-f675-4a5b-846f-144d56382dcb',NULL,'172.18.0.1','2026-09-24 22:40:59','2026-09-24 22:40:59','en'),('194f20ad-308c-4ca8-9684-d30c611a87f6',NULL,'172.18.0.1','2026-09-16 19:43:04','2026-09-16 19:43:04','en'),('1aaa42d7-bd36-459e-8acb-292de4d07c0f',NULL,'172.18.0.1','2026-09-18 23:29:25','2026-09-18 23:29:25','en'),('1ab4774c-20af-4390-96dc-f88a571e5294',NULL,'172.18.0.1','2026-09-17 22:49:25','2026-09-17 22:49:25','en'),('1afcdcc9-fbf2-4c44-b7b3-d228bb5cb57b',NULL,'172.18.0.1','2026-09-22 17:59:08','2026-09-22 17:59:08','en'),('1b1dd341-4242-4c05-b6e3-4c8ab29d1422',NULL,'172.18.0.1','2026-09-30 20:19:49','2026-09-30 20:19:49','en'),('1b2ab7c4-180b-48a0-875e-85d614b702bc',NULL,'172.18.0.1','2026-10-12 10:23:01','2026-10-12 10:23:01','en'),('1b2f878c-f15d-4e43-b1cb-f7005b19518a',NULL,'172.18.0.1','2026-09-17 22:49:45','2026-09-17 22:49:45','en'),('1b67c3e0-f771-4783-8cb0-cfca2582a0f8',NULL,'172.18.0.1','2026-09-16 19:42:58','2026-09-16 19:42:58','en'),('1b689e1a-1243-4050-9f78-f70e8acaaca5',NULL,'172.18.0.1','2026-09-18 00:38:46','2026-09-18 00:38:46','en'),('1b9fbb6f-09e4-4033-95f7-5f206c2012b1',NULL,'172.18.0.1','2026-10-02 01:14:18','2026-10-02 01:14:18','en'),('1ba4ddce-07d2-4b9a-8598-91eb7b30b7fe',NULL,'172.18.0.1','2026-10-09 15:29:11','2026-10-09 15:29:11','en'),('1c169f52-5bc4-4512-8ef5-9eda224eef19',NULL,'172.18.0.1','2026-09-30 22:50:00','2026-09-30 22:50:00','en'),('1c4a6ad5-1b85-4860-b708-87f7cf2f05cc',NULL,'172.18.0.1','2026-09-26 20:57:49','2026-09-26 20:57:49','en'),('1c597fbc-1e84-4029-848b-71a8a1e08123',NULL,'172.18.0.1','2026-09-24 22:58:39','2026-09-24 22:58:39','en'),('1c918d6c-8398-4e36-9f5d-60af58bbd624',NULL,'172.18.0.1','2026-09-16 18:28:23','2026-09-16 18:28:23','en'),('1cc08c8d-c432-4d47-b93a-a29057a001ea',NULL,'172.18.0.1','2026-10-01 18:07:52','2026-10-01 18:07:52','en'),('1d209d9d-f839-4833-8496-50dd580cd3c9',NULL,'172.18.0.1','2026-09-30 01:52:42','2026-09-30 01:52:42','en'),('1d5970f2-3f0d-45ef-bc2c-6c12c3cf015e',NULL,'172.18.0.1','2026-09-16 18:29:20','2026-09-16 18:29:20','en'),('1d6fab1b-eeec-4bed-a6fe-87bec4770a19',NULL,'172.18.0.1','2026-09-30 01:53:02','2026-09-30 01:53:02','en'),('1daf41a4-1b18-42dd-b87a-7322b6ad1a9e',NULL,'172.18.0.1','2026-10-18 17:23:35','2026-10-18 17:23:35','en'),('1db9f06c-8f2f-4216-94be-228e75fa42b1',NULL,'172.18.0.1','2026-09-18 18:07:54','2026-09-18 18:07:54','en'),('1dd17120-7818-4fe5-8f9b-4c629c096240',NULL,'172.18.0.1','2026-10-08 17:39:15','2026-10-08 17:39:15','en'),('1df9aa15-9a25-4904-913f-6237ebe0e9fc',NULL,'172.18.0.1','2026-09-15 01:14:11','2026-09-15 01:14:11','en'),('1e49019e-20e3-4c7d-bda6-8639504946ff',NULL,'172.18.0.1','2026-10-08 16:59:13','2026-10-08 16:59:13','en'),('1f0558bf-31c3-46f0-b125-b676bd17ed39',NULL,'172.18.0.1','2026-09-30 01:53:01','2026-09-30 01:53:01','en'),('1f315909-86e6-4c25-b472-b8339d8abb9e',NULL,'172.18.0.1','2026-10-09 15:50:30','2026-10-09 15:50:30','en'),('1fc7411b-4010-4390-a294-75444e543559',NULL,'172.18.0.1','2026-09-16 19:43:57','2026-09-16 19:43:57','en'),('1feb2412-6c00-4307-929e-181f8f0b95ff',NULL,'172.18.0.1','2026-09-17 01:08:22','2026-09-17 01:08:22','en'),('207ee303-22b0-40b0-bb79-c2c15fcdff1b',NULL,'172.18.0.1','2026-09-29 23:49:40','2026-09-29 23:49:40','en'),('20ac4101-95de-4f39-9d1c-fbb9de09c80f',NULL,'172.18.0.1','2026-09-24 20:47:14','2026-09-24 20:47:14','en'),('20adda03-7208-4f4d-bd2a-e262c038979d',NULL,'172.18.0.1','2026-10-01 23:05:51','2026-10-01 23:05:51','en'),('20c2a7ef-be2e-4cb2-8c07-6552dec937a5',NULL,'172.18.0.1','2026-09-16 20:38:34','2026-09-16 20:38:34','en'),('2106d5a5-c600-4500-9f4e-1386dd5c0cfb',NULL,'172.18.0.1','2026-09-28 23:01:18','2026-09-28 23:01:18','en'),('210c8c4d-a9dc-45a6-a8f8-0239b70eade1',NULL,'172.18.0.1','2026-09-17 02:12:00','2026-09-17 02:12:00','en'),('21499b33-7751-49bd-814c-d3b3be87cef8',NULL,'172.18.0.1','2026-09-30 01:47:18','2026-09-30 01:47:18','en'),('21696e36-984a-4698-a59b-5ec8f2d4c505',NULL,'172.18.0.1','2026-10-26 10:31:07','2026-10-26 10:31:07','en'),('22514b77-a32a-474b-b85a-80c8f03bde2f','6e15f780-d0fe-11f1-8fc9-ad06dd1f1198','172.18.0.1','2026-10-26 14:41:40','2026-10-26 14:41:40','en'),('227f82e7-251b-4c09-bd13-aae5af84d81f',NULL,'172.18.0.1','2026-09-16 00:34:18','2026-09-16 00:34:18','en'),('23541803-e6d7-4313-92bc-a851b643a711',NULL,'172.18.0.1','2026-09-30 01:03:18','2026-09-30 01:03:18','en'),('23babd4c-bf9f-4efa-be70-c2266a12ab23',NULL,'172.18.0.1','2026-10-01 02:06:47','2026-10-01 02:06:47','en'),('2447590a-c2f1-4276-aa54-91ccd91ec388',NULL,'172.18.0.1','2026-09-22 23:20:47','2026-09-22 23:20:47','en'),('245025e6-5eac-45c0-9ad0-0858e07d22c5',NULL,'172.18.0.1','2026-09-16 18:29:35','2026-09-16 18:29:35','en'),('24bed1a4-8174-4a52-a73d-58200d7e272c',NULL,'172.18.0.1','2026-09-16 02:27:21','2026-09-16 02:27:21','en'),('25075178-4caf-455f-95cf-9afbe4fe8726',NULL,'172.18.0.1','2026-09-30 22:49:16','2026-09-30 22:49:16','en'),('253b2019-c323-4856-97f9-f7584dab1834',NULL,'172.18.0.1','2026-09-24 22:52:17','2026-09-24 22:52:17','en'),('25848e77-8058-432e-a7ae-776ac6e18674',NULL,'172.18.0.1','2026-09-18 01:47:25','2026-09-18 01:47:25','en'),('2598b789-2db8-4702-9381-51229d21c032',NULL,'172.18.0.1','2026-09-17 02:25:13','2026-09-17 02:25:13','en'),('25a7267c-394d-4847-9b17-1828dd0af5d2',NULL,'172.18.0.1','2026-09-19 02:01:00','2026-09-19 02:01:00','en'),('25e7cdd5-1fb3-430c-8e9b-9617e6973127',NULL,'172.18.0.1','2026-09-18 01:49:03','2026-09-18 01:49:03','en'),('25fb54df-0da7-4467-9cfb-c02b1143c238',NULL,'172.18.0.1','2026-09-18 23:29:08','2026-09-18 23:29:08','en'),('263da7ae-4ab1-4e15-9ce2-51c9bfdb62cc',NULL,'172.18.0.1','2026-09-24 23:55:59','2026-09-24 23:55:59','en'),('2655b33c-acf4-44a1-b770-8e36d711b3e8',NULL,'172.18.0.1','2026-09-28 22:59:35','2026-09-28 22:59:35','en'),('26915e0f-2a65-4cb1-a2fe-216b44d5e2ca',NULL,'172.18.0.1','2026-09-17 01:52:04','2026-09-17 01:52:04','en'),('270ddb8c-1d53-46b1-bb4c-80010c45c00a','5d22f46b-3fc5-4e24-ba89-9758a3ed2f55','172.18.0.1','2026-10-12 12:16:49','2026-10-12 12:16:49','en'),('27c4a2d3-587e-4fed-938f-e6c85a143365',NULL,'172.18.0.1','2026-09-30 19:51:20','2026-09-30 19:51:20','en'),('27cac1d6-83c0-45a2-8602-6b67aaf7d974',NULL,'172.18.0.1','2026-09-17 23:10:45','2026-09-17 23:10:45','en'),('27ef27d7-fe3c-420d-9d1b-3f0e4c5f3ad3',NULL,'172.18.0.1','2026-10-01 02:01:44','2026-10-01 02:01:44','en'),('27fd410c-d92b-470e-b82b-d5b2e127776d',NULL,'172.18.0.1','2026-09-30 02:25:34','2026-09-30 02:25:34','en'),('2839326e-b789-472d-9263-6f16d04647f3',NULL,'172.18.0.1','2026-09-17 02:22:30','2026-09-17 02:22:30','en'),('28685f5c-915f-438b-9d75-755657b760e3',NULL,'172.18.0.1','2026-09-26 20:51:57','2026-09-26 20:51:57','en'),('2893b3c9-97b3-437f-a55d-1e6fe5035652',NULL,'172.18.0.1','2026-09-18 18:43:01','2026-09-18 18:43:01','en'),('28f12d7b-1d61-4d3e-9ed2-f4e9e469039d',NULL,'172.18.0.1','2026-09-24 22:04:56','2026-09-24 22:04:56','en'),('290a5d39-618d-4856-ae18-f6280d5caa1e',NULL,'172.18.0.1','2026-10-01 02:19:05','2026-10-01 02:19:05','en'),('29a888cc-e1ec-4264-a332-31a2fd31ba8c',NULL,'172.18.0.1','2026-10-01 23:27:53','2026-10-01 23:27:53','en'),('2a17df73-47dc-4a58-a8c1-7e96449d05da',NULL,'172.18.0.1','2026-10-08 16:59:13','2026-10-08 16:59:13','en'),('2a38aa21-e6bf-4e40-a818-a37aa55a890a',NULL,'172.18.0.1','2026-09-18 01:47:20','2026-09-18 01:47:20','en'),('2a8334a1-9077-494a-9c22-35c25d064efc',NULL,'172.18.0.1','2026-09-30 00:05:55','2026-09-30 00:05:55','en'),('2a8edfd6-b6bc-4114-862d-54a3f6eea5fc',NULL,'172.18.0.1','2026-09-24 22:08:08','2026-09-24 22:08:08','en'),('2a97efbf-56b6-42f4-83a4-52f231d1f1e1',NULL,'172.18.0.1','2026-09-17 20:04:03','2026-09-17 20:04:03','en'),('2b751953-ebab-422f-b6bb-9efcfdc4712d',NULL,'172.18.0.1','2026-10-01 02:14:19','2026-10-01 02:14:19','en'),('2b8e6e24-e1b5-4975-b95e-bcd775f09629',NULL,'172.18.0.1','2026-09-16 01:28:56','2026-09-16 01:28:56','en'),('2bd0fb74-9224-4ade-a166-1e77aa0fcdad',NULL,'172.18.0.1','2026-09-24 23:07:06','2026-09-24 23:07:06','en'),('2c398c3e-c7db-4cd4-8dee-54c341b33bcb',NULL,'172.18.0.1','2026-09-24 22:04:59','2026-09-24 22:04:59','en'),('2cf570a5-096b-4f63-81cb-52b3b0b86e52',NULL,'172.18.0.1','2026-09-17 18:34:48','2026-09-17 18:34:48','en'),('2cf8bb24-e775-4e5a-acd8-f0bac36167d9','e417b5a9-e087-4a52-aaa0-6beb7df95559','172.18.0.8','2026-10-14 10:38:42','2026-10-14 10:38:42','en'),('2d007bd7-f3d5-4be8-a7f3-392e43b0a2de',NULL,'172.18.0.1','2026-10-26 16:06:49','2026-10-26 16:06:49','en'),('2d4221f9-ee9f-41a0-a9ed-f9313d0b2f44',NULL,'172.18.0.1','2026-10-18 16:18:27','2026-10-18 16:18:27','en'),('2dbc97cc-dc93-42eb-9676-f9b2f49636be',NULL,'172.18.0.1','2026-09-18 20:07:41','2026-09-18 20:07:41','en'),('2dc74079-5938-4573-9f6d-0b1287602da1',NULL,'172.18.0.1','2026-10-18 17:50:11','2026-10-18 17:50:11','en'),('2e0df82c-4007-4723-b7d6-cafd630f6bb2',NULL,'172.18.0.1','2026-10-02 01:05:00','2026-10-02 01:05:00','en'),('2e85babf-9897-4d51-8d62-a911470d621b',NULL,'172.18.0.1','2026-09-29 23:55:33','2026-09-29 23:55:33','en'),('2e8eea87-86f0-49b5-bf07-ea32dd13da81',NULL,'172.18.0.1','2026-09-30 00:40:18','2026-09-30 00:40:18','en'),('2faca74e-9b74-45f6-8169-7a06c5cc04a4',NULL,'172.18.0.1','2026-09-16 02:14:26','2026-09-16 02:14:26','en'),('2fcd2bf4-7fd4-4336-9095-64eec67cb8ec',NULL,'172.18.0.1','2026-10-02 01:05:03','2026-10-02 01:05:03','en'),('2ff49ead-f3cc-476b-90bf-2237b275c526',NULL,'172.18.0.1','2026-09-17 22:50:40','2026-09-17 22:50:40','en'),('301ee9b7-579c-4564-8e31-7280b3040b43',NULL,'172.18.0.1','2026-09-16 20:01:00','2026-09-16 20:01:00','en'),('302263cd-0964-46a7-9219-a988bc66f588',NULL,'172.18.0.1','2026-09-22 00:13:09','2026-09-22 00:13:09','en'),('30280dc5-e116-446a-9d0d-23dd5b3cb0dc',NULL,'172.18.0.1','2026-09-24 23:31:17','2026-09-24 23:31:17','en'),('304d170b-fc5c-4ea7-bdda-9e00cd029a13',NULL,'172.18.0.1','2026-09-17 02:10:06','2026-09-17 02:10:06','en'),('305bbf4d-4954-4bf5-bc19-8e62eb6a2890',NULL,'172.18.0.1','2026-09-17 01:21:20','2026-09-17 01:21:20','en'),('30673495-e810-46b6-aff6-0ff6f82fa819',NULL,'172.18.0.1','2026-09-18 01:09:07','2026-09-18 01:09:07','en'),('3071c4e4-6632-46a0-bf84-b911f007f83d',NULL,'172.18.0.1','2026-09-17 02:12:09','2026-09-17 02:12:09','en'),('30b5dcaf-e6b7-4c39-a2c1-60fc1825308d',NULL,'172.18.0.1','2026-09-18 20:05:11','2026-09-18 20:05:11','en'),('30c2c3b4-6716-4f22-b648-e124a3ad00c5',NULL,'172.18.0.1','2026-10-01 01:05:49','2026-10-01 01:05:49','en'),('30c61609-84ec-4c1e-93a9-c57eceb45e48',NULL,'172.18.0.1','2026-09-17 20:41:36','2026-09-17 20:41:36','en'),('3115474c-986e-4577-967a-0de109d282c3',NULL,'172.18.0.1','2026-09-18 22:17:14','2026-09-18 22:17:14','en'),('313f101f-26bf-449a-ac9a-07d4c28bff48',NULL,'172.18.0.1','2026-09-15 19:56:26','2026-09-15 19:56:26','en'),('31563793-2a79-484c-a7c8-31c0a5715285',NULL,'172.18.0.1','2026-10-18 15:31:25','2026-10-18 15:31:25','en'),('31d2b528-845c-4f49-a260-9d0122aed2ea','5d22f46b-3fc5-4e24-ba89-9758a3ed2f55','172.18.0.1','2026-10-12 11:47:42','2026-10-12 11:47:42','en'),('31d87ac1-0d40-4a01-ac2b-7982f93b60e0',NULL,'172.18.0.1','2026-10-01 01:51:04','2026-10-01 01:51:04','en'),('31eaf471-9b00-49b5-b861-89d9274b3b25',NULL,'172.18.0.1','2026-09-26 20:52:26','2026-09-26 20:52:26','en'),('31efb9d6-7fd1-4f21-8b33-c1db2c4c42a4',NULL,'172.18.0.1','2026-09-18 22:19:19','2026-09-18 22:19:19','en'),('326479d6-a3d8-4bed-acbe-ae81b4935277',NULL,'172.18.0.1','2026-09-16 19:34:09','2026-09-16 19:34:09','en'),('32692c8e-c1b4-438b-8ff2-0cceb873f47b',NULL,'172.18.0.1','2026-09-30 19:51:26','2026-09-30 19:51:26','en'),('3272d16a-866e-4b2e-88f7-78fa80b37e08',NULL,'172.18.0.1','2026-09-18 02:05:18','2026-09-18 02:05:18','en'),('3282891c-df38-4c5d-8914-ce475ddd22a5',NULL,'172.18.0.1','2026-09-24 22:17:11','2026-09-24 22:17:11','en'),('329839e3-e633-415d-85f8-b77f03ef4e98',NULL,'172.18.0.1','2026-09-17 22:50:04','2026-09-17 22:50:04','en'),('32c5f852-3884-412b-84e1-c4d65aba2c17',NULL,'172.18.0.1','2026-09-24 23:39:00','2026-09-24 23:39:00','en'),('330843f9-a8f1-4b40-8631-abedcb519d10',NULL,'172.18.0.1','2026-09-17 02:12:54','2026-09-17 02:12:54','en'),('33c6877c-0e87-4b39-8bb4-72dd7a94722f',NULL,'172.18.0.1','2026-09-24 23:00:14','2026-09-24 23:00:14','en'),('34434198-4462-4080-8bce-1b2cc8101e1b',NULL,'172.18.0.1','2026-09-22 00:59:17','2026-09-22 00:59:17','en'),('346f23b3-19f3-4082-a532-0d325ab240dc',NULL,'172.18.0.1','2026-09-18 18:09:42','2026-09-18 18:09:42','en'),('351a5d91-08ed-4109-bd81-cd845c2aa4b9',NULL,'172.18.0.1','2026-10-01 02:14:24','2026-10-01 02:14:24','en'),('35411071-6f73-43bf-bf08-f138665d2b5a',NULL,'172.18.0.1','2026-09-16 20:38:32','2026-09-16 20:38:32','en'),('3554f32d-bdeb-45b4-81db-9924e6ca51dc',NULL,'172.18.0.1','2026-09-24 22:09:28','2026-09-24 22:09:28','en'),('355b771a-e47e-4197-a1d7-82a562775f91',NULL,'172.18.0.1','2026-09-30 01:47:22','2026-09-30 01:47:22','en'),('35b55585-525b-4436-92be-b4510260085d',NULL,'172.18.0.1','2026-10-01 23:57:50','2026-10-01 23:57:50','en'),('35babea7-3f33-49f6-8629-93443e9fff6a',NULL,'172.18.0.1','2026-10-01 23:09:26','2026-10-01 23:09:26','en'),('35c4bf05-feca-41f7-92cc-99c7a74fbe3e',NULL,'172.18.0.1','2026-09-18 02:29:08','2026-09-18 02:29:08','en'),('35fed2c5-2e05-4854-ae01-585baebda404',NULL,'172.18.0.1','2026-09-26 20:57:44','2026-09-26 20:57:44','en'),('37da9fa2-54d5-4b11-b6d5-600b1973cfe5',NULL,'172.18.0.1','2026-10-01 02:01:42','2026-10-01 02:01:42','en'),('382ae654-0263-4ab2-990f-a32976037526',NULL,'172.18.0.1','2026-09-24 20:51:56','2026-09-24 20:51:56','en'),('38419e36-faa5-4762-84af-f1b64c617201',NULL,'172.18.0.1','2026-10-09 17:38:26','2026-10-09 17:38:26','en'),('385b1aef-8d7a-4187-8a46-9e11410ffd3e',NULL,'172.18.0.1','2026-09-14 18:17:52','2026-09-14 18:17:52','en'),('3938922b-b781-47ed-b950-945d1844f341',NULL,'172.18.0.1','2026-09-24 22:02:20','2026-09-24 22:02:20','en'),('393917d4-c47e-4c19-a7a0-f9f8fcba0e37',NULL,'172.18.0.1','2026-09-17 01:13:48','2026-09-17 01:13:48','en'),('39a6b22c-2052-4676-8d3c-92bfc83cab7c',NULL,'172.18.0.1','2026-10-04 23:00:06','2026-10-04 23:00:06','en'),('39acb5bc-179a-49de-a4d5-fdac75345a18',NULL,'172.18.0.1','2026-09-21 22:48:38','2026-09-21 22:48:38','en'),('39ca8e5a-354e-461b-ae0e-aaa18957f5c0',NULL,'172.18.0.1','2026-10-01 01:21:08','2026-10-01 01:21:08','en'),('39f9e588-3765-40a0-a542-b058d25d9024',NULL,'172.18.0.1','2026-10-01 23:58:30','2026-10-01 23:58:30','en'),('3a6deaa2-f5dd-49a2-9526-7dbf9aaa843b',NULL,'172.18.0.1','2026-09-18 23:19:42','2026-09-18 23:19:42','en'),('3a8f610d-f5f8-4c75-9484-a7355af083bd',NULL,'172.18.0.1','2026-09-30 00:37:56','2026-09-30 00:37:56','en'),('3b0141e2-5b56-486f-8c19-ac4402bd0b84',NULL,'172.18.0.1','2026-09-17 19:08:40','2026-09-17 19:08:40','en'),('3b50ee3d-0b7e-47a3-848b-43e9d18244ec',NULL,'172.18.0.1','2026-09-25 01:41:52','2026-09-25 01:41:52','en'),('3b88c8d0-c1f2-4523-905a-c58c80c45973',NULL,'172.18.0.1','2026-09-22 00:13:10','2026-09-22 00:13:10','en'),('3bfbde28-99a7-440d-aae0-be016551986b',NULL,'172.18.0.1','2026-09-17 18:31:11','2026-09-17 18:31:11','en'),('3c023218-3a8f-4743-8046-e43e42236ac6',NULL,'172.18.0.1','2026-09-17 20:02:28','2026-09-17 20:02:28','en'),('3ce3bd00-929c-45b0-aa9e-8b805b0105d4','18a2a9e0-c5fc-11f1-ac03-37b626f924f1','172.18.0.1','2026-10-18 17:23:55','2026-10-18 17:23:55','en'),('3d3bff06-0e9a-44db-8cf3-d5a8bd7c48e6',NULL,'172.18.0.1','2026-09-24 22:25:04','2026-09-24 22:25:04','en'),('3d47c357-181a-4bd8-9a2f-98004a8a84d5',NULL,'172.18.0.1','2026-09-24 23:27:10','2026-09-24 23:27:10','en'),('3e501973-0a22-41de-aacb-c56c818b65c5',NULL,'172.18.0.1','2026-09-17 02:08:44','2026-09-17 02:08:44','en'),('3eb7db06-a5db-4e8a-8639-93f910b06d14',NULL,'172.18.0.1','2026-09-24 22:50:30','2026-09-24 22:50:30','en'),('3ee4a85a-3752-4204-8da9-d80c9f590b03',NULL,'172.18.0.1','2026-09-24 23:27:10','2026-09-24 23:27:10','en'),('3f699148-3a7b-4bc5-b583-7606a266499b',NULL,'172.18.0.1','2026-09-15 22:17:32','2026-09-15 22:17:32','en'),('3fd95aa7-10e7-49fd-b5c1-68b43d296026',NULL,'172.18.0.1','2026-09-16 00:24:29','2026-09-16 00:24:29','en'),('3ff7887a-5db9-45e5-99db-91fb9b7dcac2',NULL,'172.18.0.1','2026-09-16 02:13:35','2026-09-16 02:13:35','en'),('40fd9666-9285-4e7f-93e3-6d7ca9f8d704',NULL,'172.18.0.1','2026-10-01 01:50:35','2026-10-01 01:50:35','en'),('419b192b-6a8e-49f5-a504-4b3c24fbfab3',NULL,'172.18.0.1','2026-09-16 19:57:32','2026-09-16 19:57:32','en'),('41f3fac6-6081-4382-b001-6fe7ffd7c5f0',NULL,'172.18.0.1','2026-09-24 23:55:59','2026-09-24 23:55:59','en'),('423abe78-19df-4b1c-abcd-9c9093410cb5',NULL,'172.18.0.1','2026-10-01 18:30:18','2026-10-01 18:30:18','en'),('42bba0b2-0ee7-4636-a96b-115e53823983',NULL,'172.18.0.1','2026-09-17 01:21:18','2026-09-17 01:21:18','en'),('42e3f7ca-5689-4661-b0c9-e0d4ec8444c2',NULL,'172.18.0.1','2026-09-17 23:27:48','2026-09-17 23:27:48','en'),('42f02f90-e60a-4b50-b9fb-56b32b38e125',NULL,'172.18.0.1','2026-10-08 16:59:59','2026-10-08 16:59:59','en'),('42f78b2c-1b9b-4341-9cea-d81c3ad3dba1',NULL,'172.18.0.1','2026-09-16 01:50:05','2026-09-16 01:50:05','en'),('434522c3-87ef-4329-a7b3-279049ab41c8',NULL,'172.18.0.1','2026-09-25 19:29:50','2026-09-25 19:29:50','en'),('439c7ba3-f663-4a77-8b24-0677e9925e45',NULL,'172.18.0.1','2026-09-24 22:22:28','2026-09-24 22:22:28','en'),('43b8636c-6a4a-4ebf-bea5-e4bbfbf45c6d',NULL,'172.18.0.1','2026-09-22 17:59:17','2026-09-22 17:59:17','en'),('43d633bc-eb6d-42ed-a371-132661d32bba',NULL,'172.18.0.1','2026-09-24 22:43:04','2026-09-24 22:43:04','en'),('4526b844-5ecd-400a-aab9-d1621bb9bd06',NULL,'172.18.0.1','2026-10-01 02:17:15','2026-10-01 02:17:15','en'),('45ac86fd-8ab7-489b-b375-8aa0f6978b59',NULL,'172.18.0.1','2026-09-18 20:03:22','2026-09-18 20:03:22','en'),('46bb50dc-c85c-418b-8f46-8d7465ebbcfd',NULL,'172.18.0.1','2026-09-24 23:22:20','2026-09-24 23:22:20','en'),('4726d318-05ed-487b-a442-3f40b7900b94',NULL,'172.18.0.1','2026-10-09 15:29:13','2026-10-09 15:29:13','en'),('473fc45e-6e3a-4fe2-9253-a018c8cde428',NULL,'172.18.0.1','2026-09-30 01:03:14','2026-09-30 01:03:14','en'),('47527607-4d7b-4db3-bb1d-64ed9d03f3f8',NULL,'172.18.0.1','2026-10-13 17:50:59','2026-10-13 17:50:59','en'),('4828dc5e-be84-4f43-97e3-33ebe2485adb',NULL,'172.18.0.1','2026-09-18 01:47:38','2026-09-18 01:47:38','en'),('482b59df-35f3-41e3-90e4-aa5ba5b7d774',NULL,'172.18.0.1','2026-10-01 17:59:57','2026-10-01 17:59:57','en'),('4869aaf6-0927-4da6-ae9b-cb7fd41266df',NULL,'172.18.0.1','2026-09-15 23:21:11','2026-09-15 23:21:11','en'),('48eb9dcc-5145-49a1-b86e-b9937dfc900d','d1ac4acb-2d40-444e-8d75-345ca36b30f4','172.18.0.8','2026-10-14 10:34:42','2026-10-14 10:34:42','en'),('49079250-1e43-4fb3-9dcb-a50e4efaa2ce',NULL,'172.18.0.1','2026-09-24 23:16:14','2026-09-24 23:16:14','en'),('49359fe0-08b1-4956-bd28-f941235638e4',NULL,'172.18.0.1','2026-09-29 23:49:45','2026-09-29 23:49:45','en'),('49768f17-dfdd-43e1-84f0-64613d13406e',NULL,'172.18.0.1','2026-09-24 23:06:10','2026-09-24 23:06:10','en'),('49c1f8e9-f635-4593-bb60-ff5bce808ce0',NULL,'172.18.0.1','2026-09-16 22:29:55','2026-09-16 22:29:55','en'),('49ce61b8-6090-4773-9302-5627be953ddf',NULL,'172.18.0.1','2026-10-09 14:55:25','2026-10-09 14:55:25','en'),('49ee89ba-e11d-4d33-8fd8-c09500c0d978',NULL,'172.18.0.1','2026-09-17 01:22:03','2026-09-17 01:22:03','en'),('4a41b9bd-1cc0-4726-a630-5b78878fbc41',NULL,'172.18.0.1','2026-09-16 22:48:00','2026-09-16 22:48:00','en'),('4a77877b-0bfd-41e9-bf98-ec572355c833',NULL,'172.18.0.1','2026-09-16 02:08:58','2026-09-16 02:08:58','en'),('4ad7584b-6762-4e9e-9f83-222610e5c09f',NULL,'172.18.0.1','2026-09-17 02:25:51','2026-09-17 02:25:51','en'),('4b02a404-c02b-42fd-9136-475a398dcedd',NULL,'172.18.0.1','2026-10-02 01:10:24','2026-10-02 01:10:24','en'),('4b150c89-ee8e-4a60-94e3-6f14ce4568bd',NULL,'172.18.0.1','2026-09-19 00:27:09','2026-09-19 00:27:09','en'),('4b3f3b7e-f91d-4f49-b003-4d2eb6dee263',NULL,'172.18.0.1','2026-09-24 22:04:52','2026-09-24 22:04:52','en'),('4c4dd7af-b8ac-4d3b-a321-29e49f0f59d7',NULL,'172.18.0.1','2026-09-25 19:27:12','2026-09-25 19:27:12','en'),('4d07069f-2e4b-41e9-af9a-a1c5b507eefe',NULL,'172.18.0.1','2026-10-18 18:06:35','2026-10-18 18:06:35','en'),('4d93dcd8-6640-4ef1-af3f-ae7e5b68c272',NULL,'172.18.0.1','2026-09-16 00:28:08','2026-09-16 00:28:08','en'),('4dd1544b-3fd0-4ad2-aa67-2d4f56efa643','18a2a9e0-c5fc-11f1-ac03-37b626f924f1','172.18.0.1','2026-10-18 17:35:44','2026-10-18 17:35:44','en'),('4e12da77-bda0-462d-bafe-4f74ac2cf2d2',NULL,'172.18.0.1','2026-09-16 01:37:09','2026-09-16 01:37:09','en'),('4e90afd4-b4f7-44c1-aae6-2cf6d82d95cd',NULL,'172.18.0.1','2026-09-18 22:48:37','2026-09-18 22:48:37','en'),('4ea25121-b204-475d-ae00-a40f9ef4375c',NULL,'172.18.0.1','2026-10-02 00:32:21','2026-10-02 00:32:21','en'),('4ec71655-6bca-4d02-9996-b7d4b2fc7cd3',NULL,'172.18.0.1','2026-09-21 23:32:39','2026-09-21 23:32:39','en'),('4f59d4cb-9fe0-41e0-81c6-823d25aad409',NULL,'172.18.0.1','2026-09-15 20:16:30','2026-09-15 20:16:30','en'),('4fb98760-284b-496c-8d46-120fb09f32f6',NULL,'172.18.0.1','2026-09-15 02:17:17','2026-09-15 02:17:17','hi'),('4fd37dda-5357-4487-a814-112b33bd0d6a',NULL,'172.18.0.1','2026-09-19 01:07:23','2026-09-19 01:07:23','en'),('4fdd4209-bd57-48ab-bf34-8032ec1a9924',NULL,'172.18.0.1','2026-10-02 00:37:26','2026-10-02 00:37:26','en'),('4fde9c92-f614-4f38-9509-b9e5a65e4544',NULL,'172.18.0.1','2026-10-04 22:59:35','2026-10-04 22:59:35','en'),('5018c71a-76a3-4c3b-b16f-9d3068e807c8',NULL,'172.18.0.1','2026-09-24 23:01:38','2026-09-24 23:01:38','en'),('501c6d8a-ef8f-4daa-bc60-94f1de68fe64',NULL,'172.18.0.1','2026-10-01 02:21:57','2026-10-01 02:21:57','en'),('5065e2ee-fdc0-4fbd-a887-5291ac61a1a9',NULL,'172.18.0.1','2026-09-18 20:33:37','2026-09-18 20:33:37','en'),('5068b6c1-fa44-4430-8f6a-4cf16fbfdc41',NULL,'172.18.0.1','2026-09-22 17:59:21','2026-09-22 17:59:21','en'),('512e291b-fc2b-49fe-ab46-d1ea00ebbced',NULL,'172.18.0.1','2026-09-24 23:16:32','2026-09-24 23:16:32','en'),('5140adac-cb36-477c-8b99-f769a750c4ef',NULL,'172.18.0.1','2026-09-16 01:47:55','2026-09-16 01:47:55','en'),('51477aaf-f136-4f91-a22d-86076aa086c3',NULL,'172.18.0.1','2026-09-18 02:28:58','2026-09-18 02:28:58','en'),('51a12c2c-7b87-49a4-8dda-3b9710b6ff44',NULL,'172.18.0.1','2026-09-17 02:12:05','2026-09-17 02:12:05','en'),('520b455c-09a8-4877-ac60-79c3166f7572',NULL,'172.18.0.1','2026-09-22 00:33:58','2026-09-22 00:33:58','en'),('5217936f-b886-407a-82c8-1b066cf0a24e',NULL,'172.18.0.1','2026-09-16 01:51:36','2026-09-16 01:51:36','en'),('526fe846-2075-42e3-a7aa-d7c89a11a88a',NULL,'172.18.0.1','2026-09-18 20:36:23','2026-09-18 20:36:23','en'),('5303462f-0393-4a61-b11d-ad853ce0f307',NULL,'172.18.0.1','2026-09-17 20:42:18','2026-09-17 20:42:18','en'),('530f3fc3-c1db-4d1c-8749-c4b7eb911fb3',NULL,'172.18.0.1','2026-09-18 01:09:09','2026-09-18 01:09:09','en'),('533cc6f6-ef83-40c4-95fc-7850b60e93ae',NULL,'172.18.0.1','2026-10-01 18:07:50','2026-10-01 18:07:50','en'),('53587d06-bb6b-4c69-a0a7-4fc5b570f11e',NULL,'172.18.0.1','2026-10-08 17:00:01','2026-10-08 17:00:01','en'),('536d798e-5925-49ac-8f98-af3f3291f24b','667d9bb6-672b-4c13-86eb-ba2c5bca6664','172.18.0.7','2026-10-13 16:44:47','2026-10-13 16:44:47','en'),('53c7b93f-4836-4728-a901-a1420068275b',NULL,'172.18.0.1','2026-09-17 19:08:49','2026-09-17 19:08:49','en'),('53d944b3-5323-41bd-85c7-1601dec567f5',NULL,'172.18.0.1','2026-09-29 23:50:51','2026-09-29 23:50:51','en'),('548b010c-4bdd-4d1d-849e-f5cad479971e',NULL,'172.18.0.1','2026-09-17 00:58:24','2026-09-17 00:58:24','en'),('54b01253-ef4f-4db9-b414-667c9b2d7ed4','8fb5c7e3-da6a-477e-88ef-2003c4bcb790','172.18.0.8','2026-10-14 10:39:20','2026-10-14 10:39:20','en'),('55823e52-4d0e-4fc5-9473-9b0c13057df0',NULL,'172.18.0.1','2026-09-30 01:52:47','2026-09-30 01:52:47','en'),('55ca6301-593e-44fa-bd04-1dcb472930aa',NULL,'172.18.0.1','2026-10-01 01:35:32','2026-10-01 01:35:32','en'),('55f59ceb-c9b2-4bfc-945d-7db322fe3cb9',NULL,'172.18.0.1','2026-09-17 01:22:01','2026-09-17 01:22:01','en'),('562c5121-8a6c-4e83-ad54-231c29658851',NULL,'172.18.0.1','2026-09-24 23:56:01','2026-09-24 23:56:01','en'),('56766709-cc83-4bdb-8cb6-7cdaf78c19d9',NULL,'172.18.0.1','2026-09-25 19:24:29','2026-09-25 19:24:29','en'),('56fffdf9-7200-414e-bdfc-d23f60f0ad7a',NULL,'172.18.0.1','2026-09-24 22:22:26','2026-09-24 22:22:26','en'),('5740d3ae-311a-4a39-b629-b2ef4b7fcaa9',NULL,'172.18.0.1','2026-10-02 00:04:30','2026-10-02 00:04:30','en'),('57b9e42b-6e11-4494-9df3-04102bf8b6a6',NULL,'172.18.0.1','2026-09-26 20:51:57','2026-09-26 20:51:57','en'),('57fe9cad-cb9f-4c2b-8840-05f7f92b6ebf',NULL,'172.18.0.1','2026-09-24 22:37:29','2026-09-24 22:37:29','en'),('580f9d02-0d86-4791-a68e-4b88347dd8ee',NULL,'172.18.0.1','2026-09-24 23:06:09','2026-09-24 23:06:09','en'),('583561ed-ef6c-48d6-bf91-08f98248520a',NULL,'172.18.0.1','2026-09-17 02:25:53','2026-09-17 02:25:53','en'),('584554b5-7f8b-4899-bd7a-f779b4fe1107',NULL,'172.18.0.1','2026-09-17 01:47:29','2026-09-17 01:47:29','en'),('58c9741e-74ca-49b1-b3e1-d8d07de82f5a',NULL,'172.18.0.1','2026-10-01 01:35:03','2026-10-01 01:35:03','en'),('59a873ab-db6b-42a5-99f4-27e31c0adae7',NULL,'172.18.0.1','2026-10-09 17:29:54','2026-10-09 17:29:54','en'),('59b1b8f5-1f2d-492d-9ccd-c250879bf5c8','f44a28fa-6eb1-4a0b-aa32-602d7be66896','172.18.0.8','2026-10-14 10:37:45','2026-10-14 10:37:45','en'),('59debedd-a87b-43fb-9f55-36ad03cfade3',NULL,'172.18.0.1','2026-09-18 20:03:24','2026-09-18 20:03:24','en'),('5a15815b-6fdc-4c30-a0d9-dd660cfcbf5f',NULL,'172.18.0.1','2026-09-17 19:07:53','2026-09-17 19:07:53','en'),('5a47c7b4-8805-4123-9523-5b40c185db3f',NULL,'172.18.0.1','2026-10-01 01:52:26','2026-10-01 01:52:26','en'),('5a506b8d-fbf2-4ea7-948e-1c0f654fc88f',NULL,'172.18.0.1','2026-09-15 20:12:21','2026-09-15 20:12:21','en'),('5a56458c-1ec3-4c2e-a49c-0e52648b4dc5',NULL,'172.18.0.1','2026-10-01 18:00:30','2026-10-01 18:00:30','en'),('5a671df1-a66d-420b-8239-7f715169862d',NULL,'172.18.0.1','2026-10-01 23:09:27','2026-10-01 23:09:27','en'),('5a9e339e-60d5-4572-a353-1a34d952cf9e',NULL,'172.18.0.1','2026-09-16 01:36:34','2026-09-16 01:36:34','en'),('5ac7e093-0daa-4088-ae62-aa49f68770fb',NULL,'172.18.0.1','2026-10-02 00:32:14','2026-10-02 00:32:14','en'),('5adeb0a0-0452-4564-8016-337ad1c0ff83','6265773a-d7cd-4fe1-8325-cf39cf3a2ea2','172.18.0.8','2026-10-14 10:25:35','2026-10-14 10:25:35','en'),('5b2b17e6-c3a2-422c-8d8e-2fd0ba677c01',NULL,'172.18.0.1','2026-09-17 19:07:13','2026-09-17 19:07:13','en'),('5b4dc389-b5aa-4003-bc3e-128445cb339e',NULL,'172.18.0.1','2026-10-01 01:40:00','2026-10-01 01:40:00','en'),('5b74a060-ab55-4d83-a332-ac818be078c9',NULL,'172.18.0.1','2026-09-18 01:10:56','2026-09-18 01:10:56','en'),('5c18451c-5c1d-4213-8f74-eb566a7a1dda',NULL,'172.18.0.1','2026-09-29 23:49:47','2026-09-29 23:49:47','en'),('5c608e02-9e3c-4781-ac4b-deb609172f77',NULL,'172.18.0.1','2026-10-01 02:06:43','2026-10-01 02:06:43','en'),('5cb77202-c763-44d4-9684-cb9f58ac8c5f',NULL,'172.18.0.1','2026-09-25 19:27:13','2026-09-25 19:27:13','en'),('5d22f46b-3fc5-4e24-ba89-9758a3ed2f55',NULL,'172.18.0.1','2026-10-12 10:23:03','2026-10-12 10:23:03','en'),('5d68ac28-0d86-49e5-b9f8-0dcd3006862c',NULL,'172.18.0.1','2026-09-16 01:50:07','2026-09-16 01:50:07','en'),('5d786a97-43dd-4905-8d2a-580d15fb8dd4',NULL,'172.18.0.1','2026-10-02 01:10:30','2026-10-02 01:10:30','en'),('5e532398-aad7-4b20-baf8-44eea99f7b2a',NULL,'172.18.0.1','2026-10-18 15:39:47','2026-10-18 15:39:47','en'),('5e589532-0f7f-4c58-b071-55dd87ff841c','44e6582d-b02a-4d6b-bfeb-5aa389e529cf','172.18.0.8','2026-10-14 10:30:57','2026-10-14 10:30:57','en'),('5e6b4305-9805-44a4-80bf-a97dd8f9746c',NULL,'172.18.0.1','2026-09-22 00:19:50','2026-09-22 00:19:50','en'),('5ea784a1-5671-4915-a1b5-eb1a0e53cd32',NULL,'172.18.0.1','2026-09-17 20:02:52','2026-09-17 20:02:52','en'),('5ede715e-0c1a-4466-b09e-2e5dad35a324',NULL,'172.18.0.1','2026-09-15 20:14:03','2026-09-15 20:14:03','en'),('5f0206d5-375b-424d-bbaf-f76878f0942c',NULL,'172.18.0.1','2026-09-16 01:48:21','2026-09-16 01:48:21','en'),('5f774cb0-18b4-4224-8345-77338df43fa7',NULL,'172.18.0.1','2026-10-01 01:12:25','2026-10-01 01:12:25','en'),('5fb1e1ce-31bb-47ed-adc3-7eec186a1782',NULL,'172.18.0.1','2026-10-12 12:23:42','2026-10-12 12:23:42','en'),('5fec7941-3b94-497b-b379-758372c4ac4a',NULL,'172.18.0.1','2026-09-30 01:48:34','2026-09-30 01:48:34','en'),('601806e5-37dd-4289-9672-d16518ca48bf',NULL,'172.18.0.1','2026-10-01 01:12:24','2026-10-01 01:12:24','en'),('602d6916-aafa-42a4-9134-fdd5dc306bae',NULL,'172.18.0.1','2026-09-22 18:29:57','2026-09-22 18:29:57','en'),('604e81c2-8261-463b-97b2-3da0a665a298',NULL,'172.18.0.1','2026-09-17 01:08:54','2026-09-17 01:08:54','en'),('605671f2-14ae-401f-8005-af37f4d48850',NULL,'172.18.0.1','2026-09-15 00:56:58','2026-09-15 00:56:58','en'),('608b851e-a250-443d-ab25-6454cee51bb3',NULL,'172.18.0.1','2026-09-15 22:53:17','2026-09-15 22:53:17','en'),('60a821df-b7a8-4e99-ab59-e57d1091fcf7','a367bd15-4c46-45a5-9e01-43d6d78f3976','172.18.0.8','2026-10-14 10:51:20','2026-10-14 10:51:20','en'),('6264ac6e-fba5-4251-bf54-23cb6aa57263','0b0a510f-61a2-49a8-af78-1e7a487938a4','172.18.0.8','2026-10-14 10:36:56','2026-10-14 10:36:56','en'),('626ec5cd-9c64-4f1e-9868-d8a7486aab4f',NULL,'172.18.0.1','2026-09-22 17:57:31','2026-09-22 17:57:31','en'),('62b8d768-0500-4d38-a869-fe0123cc9b1a',NULL,'172.18.0.1','2026-09-17 01:08:51','2026-09-17 01:08:51','en'),('62bfaed1-ac55-434a-ba9f-cf2e9002e49c',NULL,'172.18.0.1','2026-09-24 22:33:28','2026-09-24 22:33:28','en'),('63231547-36d0-4786-9a9f-df92a12e2f57',NULL,'172.18.0.1','2026-09-16 22:27:55','2026-09-16 22:27:55','en'),('63527e0f-071c-456f-b888-848b606bbb40',NULL,'172.18.0.1','2026-10-01 01:21:06','2026-10-01 01:21:06','en'),('63617c99-a847-4846-a2c1-ce8ef2c0be27',NULL,'172.18.0.1','2026-09-19 02:00:42','2026-09-19 02:00:42','en'),('6363dfb4-d4a5-428f-9106-e8bd24cfe53b',NULL,'172.18.0.1','2026-09-17 20:39:50','2026-09-17 20:39:50','en'),('641a4fbb-2b37-47b9-92ee-e298a174d585',NULL,'172.18.0.1','2026-09-18 23:18:11','2026-09-18 23:18:11','en'),('64262bfa-7e79-41b8-8d5b-cd2fc1a17b66',NULL,'172.18.0.1','2026-09-17 01:19:46','2026-09-17 01:19:46','en'),('646a49e6-6d31-45fb-b881-a2d73edb6022',NULL,'172.18.0.1','2026-09-16 20:07:41','2026-09-16 20:07:41','en'),('647f9820-cf59-4586-8238-ddbf708a3f8c',NULL,'172.18.0.1','2026-09-24 23:30:15','2026-09-24 23:30:15','en'),('64d63849-263d-46aa-b2c3-7cb59830095f',NULL,'172.18.0.1','2026-09-17 20:40:22','2026-09-17 20:40:22','en'),('64f7d7ad-a427-419d-ba9e-67872e13cc86','6e15f780-d0fe-11f1-8fc9-ad06dd1f1198','172.18.0.1','2026-10-27 11:59:40','2026-10-27 11:59:40','en'),('65115902-3ceb-470b-a90b-24a66329c5b6',NULL,'172.18.0.1','2026-10-26 11:24:56','2026-10-26 11:24:56','en'),('651ff733-8207-42a0-a36f-0052b38f7a17',NULL,'172.18.0.1','2026-10-02 00:18:28','2026-10-02 00:18:28','en'),('65314611-26da-44be-9da2-351a9e307181',NULL,'172.18.0.1','2026-09-16 02:08:58','2026-09-16 02:08:58','en'),('662d0bae-82ee-46fb-9e4c-bb3fbafedb1e',NULL,'172.18.0.1','2026-10-02 00:32:19','2026-10-02 00:32:19','en'),('66818596-8d19-40f1-a49f-010242358bb3',NULL,'172.18.0.1','2026-09-24 22:02:23','2026-09-24 22:02:23','en'),('66c3b448-f2d0-4d17-8056-353e93a14228',NULL,'172.18.0.1','2026-09-25 19:01:41','2026-09-25 19:01:41','en'),('6704af37-3415-4a2c-9bbb-297c4793e10a',NULL,'172.18.0.1','2026-10-01 01:54:15','2026-10-01 01:54:15','en'),('6704b558-32eb-4151-b048-5dde3c5f0689',NULL,'172.18.0.1','2026-09-18 20:36:25','2026-09-18 20:36:25','en'),('67087f5c-6af8-470b-8ce3-a9e39b3d88a2',NULL,'172.18.0.1','2026-09-25 19:19:49','2026-09-25 19:19:49','en'),('671059fb-3ca2-40cb-802e-f00eab2f26fa',NULL,'172.18.0.1','2026-09-15 18:43:27','2026-09-15 18:43:27','en'),('671cad63-2565-48ab-8788-6bca8f188be3',NULL,'172.18.0.1','2026-09-24 23:30:16','2026-09-24 23:30:16','en'),('67498944-b183-4726-af4a-68518e0898ba',NULL,'172.18.0.1','2026-09-18 20:36:25','2026-09-18 20:36:25','en'),('679ab04f-0e8f-4db4-a946-91781d108e7f',NULL,'172.18.0.1','2026-09-21 22:41:38','2026-09-21 22:41:38','en'),('67b0c9d0-3ad2-4e85-8172-bcb80adc1ea0',NULL,'172.18.0.1','2026-10-08 17:15:02','2026-10-08 17:15:02','en'),('68210636-bd8d-4ccb-ab44-e9e338cd799a',NULL,'172.18.0.1','2026-09-18 02:30:07','2026-09-18 02:30:07','en'),('68316c4e-3d7f-436f-b405-47e1638a6a65',NULL,'172.18.0.1','2026-10-26 15:51:59','2026-10-26 15:51:59','en'),('6835e327-5964-438d-8767-e7acd604135a',NULL,'172.18.0.1','2026-09-16 20:08:13','2026-09-16 20:08:13','en'),('6866b65b-90de-4589-a1c5-544b639b9211',NULL,'172.18.0.1','2026-09-17 01:19:40','2026-09-17 01:19:40','en'),('689cf669-d187-4dfd-acba-88108649dd3f',NULL,'172.18.0.1','2026-09-17 23:28:25','2026-09-17 23:28:25','en'),('68a922c1-4772-4eb2-8d64-a5908a1f99dd',NULL,'172.18.0.1','2026-09-18 18:08:01','2026-09-18 18:08:01','en'),('68fcc61b-bb30-4fe8-8afb-961d10c50c14',NULL,'172.18.0.1','2026-10-26 17:46:28','2026-10-26 17:46:28','en'),('6948faff-9af2-4246-86d3-30127add0303',NULL,'172.18.0.1','2026-10-09 17:07:02','2026-10-09 17:07:02','en'),('6959bd28-f3db-44d6-b9b5-0cd071432ca2',NULL,'172.18.0.1','2026-09-16 01:29:01','2026-09-16 01:29:01','en'),('69643468-425c-42f0-a74d-3deee09f0022',NULL,'172.18.0.1','2026-09-24 20:24:53','2026-09-24 20:24:53','en'),('69ea25b2-674a-432a-a85f-bc1066d87a75',NULL,'172.18.0.1','2026-10-18 19:20:16','2026-10-18 19:20:16','en'),('6a2b7595-a0c1-4522-8ab6-d17c5973a6da',NULL,'172.18.0.1','2026-09-24 22:41:00','2026-09-24 22:41:00','en'),('6a320e19-5eaf-4484-832b-879bf96132dd',NULL,'172.18.0.1','2026-09-15 19:05:50','2026-09-15 19:05:50','en'),('6a445b25-97b2-48bc-a080-621bd20bafb9',NULL,'172.18.0.1','2026-09-19 01:57:53','2026-09-19 01:57:53','en'),('6a8897b7-0c0a-48a6-8910-3562afb910cc',NULL,'172.18.0.1','2026-09-19 02:03:50','2026-09-19 02:03:50','en'),('6ab4011c-8eb4-4a86-aa1c-e96a4e1057a4',NULL,'172.18.0.1','2026-09-16 00:25:22','2026-09-16 00:25:22','en'),('6adc096f-79c0-4e74-bb53-735c6db09f98',NULL,'172.18.0.1','2026-10-01 02:00:18','2026-10-01 02:00:18','en'),('6adde882-29a3-4f73-9bd1-59c507f3fc96',NULL,'172.18.0.1','2026-09-19 01:07:03','2026-09-19 01:07:03','en'),('6b26f36e-44e8-4947-bc0d-bbe750bd828c',NULL,'172.18.0.1','2026-09-15 18:00:59','2026-09-15 18:00:59','en'),('6b2e0d90-a165-4fd5-b9f4-55048742faf1',NULL,'172.18.0.1','2026-09-16 18:28:42','2026-09-16 18:28:42','en'),('6b648cfd-67f9-4480-a067-b714a75e633a',NULL,'172.18.0.1','2026-09-15 20:12:46','2026-09-15 20:12:46','en'),('6b9907d2-647d-4608-912b-c915673737d3',NULL,'172.18.0.1','2026-09-17 01:49:36','2026-09-17 01:49:36','en'),('6ba293b9-5b03-46f2-8382-0d94426d6a0e',NULL,'172.18.0.1','2026-09-25 18:38:33','2026-09-25 18:38:33','en'),('6c3557ac-d3e3-4cea-aa94-873ed641fb84',NULL,'172.18.0.1','2026-09-17 01:28:33','2026-09-17 01:28:33','en'),('6c5727da-dcb9-4af5-95f8-a96e131ef37e',NULL,'172.18.0.1','2026-09-18 20:35:33','2026-09-18 20:35:33','en'),('6c6d649d-2811-48c4-8e2d-5076d07f6a74',NULL,'172.18.0.1','2026-10-09 17:38:23','2026-10-09 17:38:23','en'),('6c902f05-346b-4dc1-a437-420a2bb61e06',NULL,'172.18.0.1','2026-09-17 02:08:42','2026-09-17 02:08:42','en'),('6cd8e9e0-8c47-42a0-ba5a-506b0e370761',NULL,'172.18.0.1','2026-09-16 00:25:20','2026-09-16 00:25:20','en'),('6ceaa547-27f6-42c5-94ee-0c4d8556f0a3',NULL,'172.18.0.1','2026-09-17 23:31:17','2026-09-17 23:31:17','en'),('6d0e2abd-1229-4e15-a497-5013e2be1701',NULL,'172.18.0.1','2026-09-24 20:37:59','2026-09-24 20:37:59','en'),('6d6367e6-7640-4b1a-b76a-f14a49fb4547',NULL,'172.18.0.1','2026-10-02 20:14:19','2026-10-02 20:14:19','en'),('6d7ef387-71a2-4335-98de-db41193c20f1',NULL,'172.18.0.1','2026-09-18 20:04:12','2026-09-18 20:04:12','en'),('6d91c748-949c-4d68-a707-77a29cc20d57',NULL,'172.18.0.1','2026-09-21 23:28:35','2026-09-21 23:28:35','en'),('6e8b378e-2c98-4294-a0d9-2f7c1a9f9425',NULL,'172.18.0.1','2026-09-24 23:34:26','2026-09-24 23:34:26','en'),('6ec5ee23-0019-4e03-b1ac-5cbd14c271d2',NULL,'172.18.0.1','2026-09-17 23:27:46','2026-09-17 23:27:46','en'),('6f009945-0608-457b-98fb-9e8ca39b370f',NULL,'172.18.0.1','2026-09-16 20:01:43','2026-09-16 20:01:43','en'),('6f3aad2d-d2b1-41bf-a7c4-ad666a91d815',NULL,'172.18.0.1','2026-10-02 01:14:16','2026-10-02 01:14:16','en'),('6f48c5c2-fc21-4ac3-9189-480daae721ec',NULL,'172.18.0.1','2026-10-01 01:38:02','2026-10-01 01:38:02','en'),('6f6a51bc-e197-4d39-b318-5202ec1d27ff',NULL,'172.18.0.1','2026-09-15 19:05:51','2026-09-15 19:05:51','en'),('6f705460-167c-4753-b883-2f8b2c28cf08',NULL,'172.18.0.1','2026-09-16 18:29:43','2026-09-16 18:29:43','en'),('6f9338d2-7c5d-4be6-a5b5-4afc5aca0ea2',NULL,'172.18.0.1','2026-09-15 20:40:22','2026-09-15 20:40:22','en'),('6f9e9853-557b-403c-b0c2-0bbcfac29582',NULL,'172.18.0.1','2026-09-28 22:51:27','2026-09-28 22:51:27','en'),('6ffd6b23-257a-45b9-8b76-40cfc5d3ef52',NULL,'172.18.0.1','2026-09-18 18:03:14','2026-09-18 18:03:14','en'),('700b7027-c71e-47d6-88c5-53e75399e109',NULL,'172.18.0.1','2026-09-24 23:07:30','2026-09-24 23:07:30','en'),('71004360-5c6b-45ab-97fb-0e1e88aa10fd',NULL,'172.18.0.1','2026-09-30 00:40:28','2026-09-30 00:40:28','en'),('713778c1-9e58-46eb-b71a-6560adaaec86',NULL,'172.18.0.1','2026-09-19 02:03:31','2026-09-19 02:03:31','en'),('717440e8-9b20-42a8-9cf9-187c0a89edfb',NULL,'172.18.0.1','2026-09-18 20:35:35','2026-09-18 20:35:35','en'),('71f2412f-e852-4190-b447-193f38189eab',NULL,'172.18.0.1','2026-09-28 23:01:20','2026-09-28 23:01:20','en'),('725469a8-9078-4477-b407-fb4ee76a728a',NULL,'172.18.0.1','2026-09-24 22:58:39','2026-09-24 22:58:39','en'),('72b7bda0-4795-43d8-bebd-60fa17c61efd',NULL,'172.18.0.1','2026-09-18 20:35:32','2026-09-18 20:35:32','en'),('73e1b897-1c7d-45f5-9ea2-cafda24e67d2',NULL,'172.18.0.1','2026-09-16 20:07:28','2026-09-16 20:07:28','en'),('73efc362-0ac1-495d-bf95-4c03b9d38f90',NULL,'172.18.0.1','2026-10-02 01:12:28','2026-10-02 01:12:28','en'),('74639cde-4f4a-46cf-b9ef-895a9f3fa868',NULL,'172.18.0.1','2026-09-30 00:05:51','2026-09-30 00:05:51','en'),('74cd2570-eb1a-499b-a4e3-de94fbb02d5c',NULL,'172.18.0.1','2026-10-01 01:16:00','2026-10-01 01:16:00','en'),('74f3dddc-0336-43e4-9792-11ba3878d075',NULL,'172.18.0.1','2026-09-17 00:34:48','2026-09-17 00:34:48','en'),('7606f4ad-4dbf-45b9-8eeb-f658836cf288',NULL,'172.18.0.1','2026-09-24 23:39:01','2026-09-24 23:39:01','en'),('76887d7b-7dc2-4b04-8877-ba4c02bfa6f6',NULL,'172.18.0.1','2026-10-01 23:57:54','2026-10-01 23:57:54','en'),('76ced231-6638-4ee8-aeb5-9eb8397df180',NULL,'172.18.0.1','2026-09-19 01:13:43','2026-09-19 01:13:43','en'),('77873cb5-7952-449f-8765-e796b47d7da8',NULL,'172.18.0.1','2026-10-01 23:27:33','2026-10-01 23:27:33','en'),('77edb8cc-76fc-4246-83f8-800ce32f93b6',NULL,'172.18.0.1','2026-09-22 17:51:35','2026-09-22 17:51:35','en'),('7841364c-ad17-4efe-bdb7-34943e88d6aa',NULL,'172.18.0.1','2026-09-18 01:09:28','2026-09-18 01:09:28','en'),('785a870c-27a0-4aa8-bc91-b617753eb202',NULL,'172.18.0.1','2026-10-01 01:04:56','2026-10-01 01:04:56','en'),('786b7724-91d3-4b5f-86f2-661af5768544',NULL,'172.18.0.1','2026-09-24 22:50:31','2026-09-24 22:50:31','en'),('78828188-67a5-43d9-a5d8-8829ab777d8e',NULL,'172.18.0.1','2026-09-17 20:38:52','2026-09-17 20:38:52','en'),('78a693d6-3357-4ea9-afba-1dbcf30942d2',NULL,'172.18.0.1','2026-09-17 01:11:00','2026-09-17 01:11:00','en'),('78b64d44-f57c-4192-a64a-c00c021fac44',NULL,'172.18.0.1','2026-10-01 23:05:43','2026-10-01 23:05:43','en'),('7948ce6f-49f3-46fc-8b2f-556c55c42212',NULL,'172.18.0.1','2026-09-22 23:20:49','2026-09-22 23:20:49','en'),('794dba19-f787-4137-b1d8-1d6e3608fdc8',NULL,'172.18.0.1','2026-09-17 00:58:27','2026-09-17 00:58:27','en'),('796b6236-1f6b-4a85-8e01-8fd562ab5d02',NULL,'172.18.0.1','2026-09-25 19:06:40','2026-09-25 19:06:40','en'),('7979f6bc-bd06-4ba2-8817-4a1fb614693c',NULL,'172.18.0.1','2026-10-18 17:59:19','2026-10-18 17:59:19','en'),('7994fded-cbcf-432d-8c6b-946b6f972f72',NULL,'172.18.0.1','2026-09-16 01:50:21','2026-09-16 01:50:21','en'),('79c21d18-6868-477e-9775-ba304beb10c2',NULL,'172.18.0.1','2026-10-02 01:14:21','2026-10-02 01:14:21','en'),('7a4bddb4-fa33-4bf5-9f86-3aedee155f37',NULL,'172.18.0.1','2026-09-24 20:24:54','2026-09-24 20:24:54','en'),('7a7d6599-498b-44cf-be09-a0060f474df1',NULL,'172.18.0.1','2026-10-08 17:15:03','2026-10-08 17:15:03','en'),('7a929cb3-756c-4e2b-bccf-b938425c4665',NULL,'172.18.0.1','2026-09-17 23:28:07','2026-09-17 23:28:07','en'),('7b2b3f30-3d06-4a6f-ac11-aea77adc818b',NULL,'172.18.0.1','2026-10-02 01:10:30','2026-10-02 01:10:30','en'),('7b2e5227-6fe7-4b80-b759-afed3eddc15e',NULL,'172.18.0.1','2026-10-01 01:19:16','2026-10-01 01:19:16','en'),('7b48eb4b-5655-4125-ac5c-6005a3609f35',NULL,'172.18.0.1','2026-09-17 20:37:28','2026-09-17 20:37:28','en'),('7b5eb338-72e1-4a23-a093-5905fc5858a2','51fe5050-bc9b-11f1-b9ca-33a8614b4b6f','172.18.0.1','2026-09-30 19:52:34','2026-09-30 19:52:34','en'),('7bb38359-9962-42fb-8bf0-5bbef1beac23',NULL,'172.18.0.1','2026-10-18 17:28:52','2026-10-18 17:28:52','en'),('7bca52d0-4394-42ed-aeab-3583ecd688fe',NULL,'172.18.0.1','2026-09-17 01:52:19','2026-09-17 01:52:19','en'),('7be915ad-b72a-4b1f-b807-2676320a3586',NULL,'172.18.0.1','2026-09-28 22:53:56','2026-09-28 22:53:56','en'),('7c597a70-132f-4f33-a2c0-594a5689cfa7',NULL,'172.18.0.1','2026-09-17 18:33:20','2026-09-17 18:33:20','en'),('7c5c797b-3594-466d-871e-05bb73a1fcad',NULL,'172.18.0.1','2026-09-16 01:50:18','2026-09-16 01:50:18','en'),('7d5e8793-08a4-48d8-898d-3e3ca2b4c8d2',NULL,'172.18.0.1','2026-09-18 20:07:33','2026-09-18 20:07:33','en'),('7eb7e070-79d7-4d2c-9e0e-fdc97c8527e2',NULL,'172.18.0.1','2026-10-01 02:19:12','2026-10-01 02:19:12','en'),('7ec09fcb-a16a-4c8e-a110-e13cfbfcae01',NULL,'172.18.0.1','2026-09-15 01:14:10','2026-09-15 01:14:10','en'),('7ec6d744-56e9-4625-a708-73070578388a',NULL,'172.18.0.1','2026-10-18 19:37:17','2026-10-18 19:37:17','en'),('7ecb08dd-dc1c-4ba0-a84c-7eb1e643b438',NULL,'172.18.0.1','2026-09-21 23:32:38','2026-09-21 23:32:38','en'),('7ed38ac2-50cc-446b-9408-4530afc1e4b8',NULL,'172.18.0.1','2026-09-16 20:01:32','2026-09-16 20:01:32','en'),('7eda4b7d-0316-4388-80f1-2d45d9b3f7d0',NULL,'172.18.0.1','2026-09-16 00:55:17','2026-09-16 00:55:17','en'),('7f12a73b-92f2-428c-b6c5-e31f83360068',NULL,'172.18.0.1','2026-09-16 18:27:44','2026-09-16 18:27:44','en'),('7f16caa0-73aa-45be-a1eb-bd4a6dac9823',NULL,'172.18.0.1','2026-09-18 19:25:35','2026-09-18 19:25:35','en'),('7f432934-e116-4eea-9125-ccd566423201',NULL,'172.18.0.1','2026-10-01 02:00:11','2026-10-01 02:00:11','en'),('7f445e92-31fc-4440-b117-93321ad6c36b',NULL,'172.18.0.1','2026-10-18 19:27:21','2026-10-18 19:27:21','en'),('7f4f23d6-3029-43bd-b0dd-2c2da09e97f1',NULL,'172.18.0.1','2026-09-30 01:47:22','2026-09-30 01:47:22','en'),('7f50b7c4-88ff-4853-a6d4-2f1cf2187db7',NULL,'172.18.0.1','2026-10-01 18:30:25','2026-10-01 18:30:25','en'),('7f7ac18a-39ea-4ada-aa81-53053de8ff75',NULL,'172.18.0.1','2026-10-02 01:05:02','2026-10-02 01:05:02','en'),('808a5b9c-1915-4b67-8336-4baf6240e50b',NULL,'172.18.0.1','2026-10-18 15:53:46','2026-10-18 15:53:46','en'),('80e6ecfe-6dc0-46a4-a188-25170f1b19ff',NULL,'172.18.0.1','2026-09-16 20:41:50','2026-09-16 20:41:50','en'),('80f37d4c-3971-4646-910d-ded7f8ec6a29',NULL,'172.18.0.1','2026-09-19 02:04:47','2026-09-19 02:04:47','en'),('81b6f4b9-e649-45f2-8cf3-75709cd0cf4f',NULL,'172.18.0.1','2026-09-16 22:28:25','2026-09-16 22:28:25','en'),('81cbd513-3c56-4459-b99b-81a6758957c7',NULL,'172.18.0.1','2026-10-02 01:24:01','2026-10-02 01:24:01','en'),('82e8e388-3854-4691-abf0-33a2aa67514d',NULL,'172.18.0.1','2026-09-17 22:52:19','2026-09-17 22:52:19','en'),('830c0ed5-bc65-4f15-abb0-6613fe4fc6bf',NULL,'172.18.0.1','2026-09-16 00:49:34','2026-09-16 00:49:34','en'),('83b31671-0a76-41c1-b5db-2b4161c6438e',NULL,'172.18.0.1','2026-09-18 02:29:15','2026-09-18 02:29:15','en'),('83b9d2b2-5fad-45da-9632-3a49f5a71ac4',NULL,'172.18.0.1','2026-09-25 19:29:47','2026-09-25 19:29:47','en'),('846a3b2b-5e8a-4964-a9a8-7a8e1c6cd8c0',NULL,'172.18.0.1','2026-10-01 23:09:42','2026-10-01 23:09:42','en'),('8474f72e-0ec7-4a0c-b8e4-fdf778410c22',NULL,'172.18.0.1','2026-09-15 23:21:32','2026-09-15 23:21:32','en'),('849879ae-d14a-4c69-b5e1-5163fdc04b65',NULL,'172.18.0.1','2026-09-16 20:08:23','2026-09-16 20:08:23','en'),('84e84a2c-6ac2-4dd4-9b52-665c02cff6ea','1f11dec2-cc68-4c71-808e-7a7ce8e2373f','172.18.0.8','2026-10-14 10:33:25','2026-10-14 10:33:25','en'),('85181155-3434-460b-8439-b32a819fd2f8',NULL,'172.18.0.1','2026-09-30 01:52:50','2026-09-30 01:52:50','en'),('8551a516-c4d6-41e2-8155-59bc217293a3',NULL,'172.18.0.1','2026-09-17 19:08:49','2026-09-17 19:08:49','en'),('85ac42bc-abb1-4ae7-919e-7df91eb2f8a4',NULL,'172.18.0.1','2026-09-30 00:37:56','2026-09-30 00:37:56','en'),('869b84e4-a331-422a-b1dc-87be8a00ee29',NULL,'172.18.0.1','2026-09-15 02:17:22','2026-09-15 02:17:22','en'),('86df6ba2-1d5b-41b5-b5c9-160c755bd417',NULL,'172.18.0.1','2026-09-15 01:33:36','2026-09-15 01:33:36','en'),('87131a04-113f-40f8-8f4b-64b11fe95ce2',NULL,'172.18.0.1','2026-09-30 00:37:56','2026-09-30 00:37:56','en'),('87145e9d-a15e-4872-bfaf-15166d6f6402',NULL,'172.18.0.1','2026-09-22 19:37:40','2026-09-22 19:37:40','en'),('872cdef7-1fd3-411f-8037-db8d24dc22b3',NULL,'172.18.0.1','2026-10-01 02:02:39','2026-10-01 02:02:39','en'),('8730612e-98bf-461e-9a23-1ccc6b88cb93',NULL,'172.18.0.1','2026-09-18 20:07:37','2026-09-18 20:07:37','en'),('87b27bd8-a79a-4117-956a-42347fb29379',NULL,'172.18.0.1','2026-09-25 01:36:45','2026-09-25 01:36:45','en'),('8816c161-b9cb-4dee-81a1-e57660bb717f',NULL,'172.18.0.1','2026-09-30 00:05:54','2026-09-30 00:05:54','en'),('881fd5c1-5bf2-4564-ab90-05ea83147747',NULL,'172.18.0.1','2026-09-16 22:48:01','2026-09-16 22:48:01','en'),('883f6d61-ee00-419b-8d02-902e7d9eb370',NULL,'172.18.0.1','2026-09-17 01:10:49','2026-09-17 01:10:49','en'),('886878b2-be5b-4fa5-a105-2aee963d6015',NULL,'172.18.0.1','2026-09-16 00:52:50','2026-09-16 00:52:50','en'),('88c47e50-bd16-40c4-bbb3-debca64077e4','0b533d1a-2e20-4f76-bd35-6eb17bc845ed','172.18.0.8','2026-10-14 10:54:21','2026-10-14 10:54:21','en'),('89fc3447-23f9-49c9-9da5-487f0563f7dd',NULL,'172.18.0.1','2026-09-30 22:48:59','2026-09-30 22:48:59','en'),('89fe99da-18e7-4406-b3a3-7b586931c5e3','74546110-bbf3-11f1-896a-3509cd30c05d','172.18.0.1','2026-09-30 02:25:51','2026-09-30 02:25:51','en'),('8a1e5e16-547c-41fa-aaf4-abc609ff3c43',NULL,'172.18.0.1','2026-10-01 01:50:30','2026-10-01 01:50:30','en'),('8a56289d-ac10-4abf-841f-2f64dac2066b',NULL,'172.18.0.1','2026-09-22 00:19:50','2026-09-22 00:19:50','en'),('8a5bb796-ed39-4a19-bf6a-4719a21beefd',NULL,'172.18.0.1','2026-09-16 19:43:56','2026-09-16 19:43:56','en'),('8afa8834-026a-4eef-935c-825cc4cf45d3',NULL,'172.18.0.1','2026-10-01 23:26:44','2026-10-01 23:26:44','en'),('8aff6590-d4f9-48bb-90c5-5cca21e71423',NULL,'172.18.0.1','2026-09-15 22:15:37','2026-09-15 22:15:37','en'),('8b38f855-c4b3-4e1b-a5c6-0c86f31aae4f',NULL,'172.18.0.1','2026-10-01 23:31:26','2026-10-01 23:31:26','en'),('8c1461ef-0de1-4e29-ade6-c698b4c57c97',NULL,'172.18.0.1','2026-09-16 20:08:22','2026-09-16 20:08:22','en'),('8c3fbbdb-0f55-4503-b08d-7a85a5c11e30',NULL,'172.18.0.1','2026-10-01 02:10:31','2026-10-01 02:10:31','en'),('8c560a52-81c5-49fb-9e50-6cebd3e89b7c',NULL,'172.18.0.1','2026-09-30 19:51:20','2026-09-30 19:51:20','en'),('8cb0ea01-9e3b-43b9-9e77-75711ff17ad8','74546110-bbf3-11f1-896a-3509cd30c05d','172.18.0.1','2026-09-30 01:05:12','2026-09-30 01:05:12','en'),('8cf65749-ae16-4e2a-ab29-329c3ced9733',NULL,'172.18.0.1','2026-10-04 07:08:21','2026-10-04 07:08:21','en'),('8d2c0a0b-476f-4c1b-b0f2-278d3974c8f8',NULL,'172.18.0.1','2026-09-17 01:27:34','2026-09-17 01:27:34','en'),('8dca9a08-33aa-4470-a45a-13569b49ad75',NULL,'172.18.0.1','2026-09-30 22:49:23','2026-09-30 22:49:23','en'),('8df89f05-ef60-4e53-8693-5853869537c0',NULL,'172.18.0.1','2026-09-18 02:05:36','2026-09-18 02:05:36','en'),('8dfb2be1-6aa4-4fd4-a0c3-f61e5c7c5196','e1de451e-bad5-4468-801a-25346e13730a','172.18.0.8','2026-10-14 10:47:01','2026-10-14 10:47:01','en'),('8e29b1f9-156c-41f8-9740-c3495a69d97d',NULL,'172.18.0.1','2026-10-01 01:18:28','2026-10-01 01:18:28','en'),('8e594c9f-c083-4608-aefc-e9d62468a8a8',NULL,'172.18.0.1','2026-09-24 22:08:12','2026-09-24 22:08:12','en'),('8f55c0fd-f981-47d4-bf1f-662c4e19bfa2',NULL,'172.18.0.1','2026-09-24 23:31:15','2026-09-24 23:31:15','en'),('8f791a08-a35a-499f-8e27-ddb1b1f17ced',NULL,'172.18.0.1','2026-09-17 01:14:14','2026-09-17 01:14:14','en'),('8f91a81f-af96-4477-acf8-204d1aff925e',NULL,'172.18.0.1','2026-09-18 22:19:20','2026-09-18 22:19:20','en'),('8f9c0186-8f4d-4a6b-b47e-ff1d48abf25d',NULL,'172.18.0.1','2026-09-24 22:43:04','2026-09-24 22:43:04','en'),('8fa5ea15-dd30-4f8d-af01-3358903da820',NULL,'172.18.0.1','2026-09-15 01:33:37','2026-09-15 01:33:37','en'),('8fbd2706-ba96-492e-8a56-60f754ef2eec','22e2cc70-b97f-11f1-8db5-ef537e278407','172.18.0.1','2026-09-26 20:58:13','2026-09-26 20:58:13','en'),('8fd83736-c4e5-432e-80aa-0447413f1190',NULL,'172.18.0.1','2026-09-24 23:07:05','2026-09-24 23:07:05','en'),('9080b364-2d16-4de5-aba2-8f08404490c9',NULL,'172.18.0.1','2026-09-15 17:45:27','2026-09-15 17:45:27','en'),('90981930-c5b8-4c06-93c7-042e89ffa50f',NULL,'172.18.0.1','2026-09-21 23:28:09','2026-09-21 23:28:09','en'),('90d773e7-e4ca-4aa1-9a15-4ca76a8cb76d',NULL,'172.18.0.1','2026-09-21 23:35:43','2026-09-21 23:35:43','en'),('90f4d7fe-fe95-481f-97a5-efddc1155287',NULL,'172.18.0.1','2026-09-24 23:22:39','2026-09-24 23:22:39','en'),('90fda6ce-3c4c-44e5-bac7-778b0d73af79',NULL,'172.18.0.1','2026-09-19 00:47:12','2026-09-19 00:47:12','en'),('910684a9-b43d-4a63-b2ef-4f58508c151d',NULL,'172.18.0.1','2026-10-26 11:20:34','2026-10-26 11:20:34','en'),('9117a356-3e18-4ac6-b6ee-8602cae17ef3',NULL,'172.18.0.1','2026-09-17 19:06:55','2026-09-17 19:06:55','en'),('914491e1-4a45-4e9e-addc-77c8126cb80e',NULL,'172.18.0.1','2026-10-01 02:17:12','2026-10-01 02:17:12','en'),('91d86f90-2841-4b6c-a3b8-4206e2fc0705',NULL,'172.18.0.1','2026-09-17 18:33:49','2026-09-17 18:33:49','en'),('91e0eb8c-1441-4839-a5e8-5dee671e73d6','74546110-bbf3-11f1-896a-3509cd30c05d','172.18.0.1','2026-09-30 01:04:23','2026-09-30 01:04:23','en'),('91ea0375-89c5-4846-add7-1ff547537604',NULL,'172.18.0.1','2026-09-26 20:52:00','2026-09-26 20:52:00','en'),('920270c6-2dea-48b0-9a8d-a2a3f87b7d31',NULL,'172.18.0.1','2026-09-24 22:09:29','2026-09-24 22:09:29','en'),('921c076f-4b10-4195-b63d-d1d9cdee130c',NULL,'172.18.0.1','2026-10-01 02:14:25','2026-10-01 02:14:25','en'),('928cce28-f539-4845-b468-5ab93fed85a7',NULL,'172.18.0.1','2026-09-17 20:38:49','2026-09-17 20:38:49','en'),('92d8a478-ff4d-4180-8683-c4e872fb21ae',NULL,'172.18.0.1','2026-09-24 22:37:28','2026-09-24 22:37:28','en'),('92f19ef4-148f-4fdc-8003-06625e24dd06',NULL,'172.18.0.1','2026-09-22 17:51:41','2026-09-22 17:51:41','en'),('92ff35c4-f7a2-4c31-b9ab-9f07305769bc',NULL,'172.18.0.1','2026-09-24 22:48:35','2026-09-24 22:48:35','en'),('934c128e-9d97-4bf6-be09-c802aca36d85',NULL,'172.18.0.1','2026-09-18 02:28:58','2026-09-18 02:28:58','en'),('93e2d618-9398-4f38-8c4e-b8397cdcab49',NULL,'172.18.0.1','2026-10-01 18:30:23','2026-10-01 18:30:23','en'),('9445cc11-da05-4d56-b67a-f3d831d51b63',NULL,'172.18.0.1','2026-09-18 18:15:56','2026-09-18 18:15:56','en'),('946c8e87-276e-4225-a0ec-afd99c4ff530',NULL,'172.18.0.1','2026-10-01 01:50:56','2026-10-01 01:50:56','en'),('94af4f9e-6df3-4de9-ac39-2f951eb1930d',NULL,'172.18.0.1','2026-09-18 23:31:29','2026-09-18 23:31:29','en'),('94dcf9f8-3d9a-47e5-8c70-4d44acb2c90a',NULL,'172.18.0.1','2026-10-01 02:02:39','2026-10-01 02:02:39','en'),('96067b3a-c4a7-49d0-abae-494543771a43',NULL,'172.18.0.1','2026-10-01 23:57:18','2026-10-01 23:57:18','en'),('9621f112-748f-42f0-9c19-101092b2fe50',NULL,'172.18.0.1','2026-09-17 20:37:29','2026-09-17 20:37:29','en'),('9628a592-fb58-4932-8cd3-ec5e19575360',NULL,'172.18.0.1','2026-09-26 20:55:42','2026-09-26 20:55:42','en'),('97325fd6-3586-4d99-a8ce-e1fcbf8a16b5',NULL,'172.18.0.1','2026-10-01 18:26:15','2026-10-01 18:26:15','en'),('979ddc09-4ce3-4627-9ec9-d708240f5240',NULL,'172.18.0.1','2026-09-19 00:51:36','2026-09-19 00:51:36','en'),('983dc5ae-efed-4f4c-bebb-11f836520f6e',NULL,'172.18.0.1','2026-10-01 23:28:09','2026-10-01 23:28:09','en'),('983e8c93-4db8-4337-b129-929a48c1a957',NULL,'172.18.0.1','2026-10-18 15:44:48','2026-10-18 15:44:48','en'),('984fb60a-4402-419f-ae13-1672dcae3015',NULL,'172.18.0.1','2026-10-04 07:07:54','2026-10-04 07:07:54','en'),('985a71c9-232b-402a-bda9-9e0f9d218967',NULL,'172.18.0.1','2026-09-16 01:57:49','2026-09-16 01:57:49','en'),('98cce572-0943-4df2-87ad-a04ceb5e8a1b',NULL,'172.18.0.1','2026-09-16 00:50:03','2026-09-16 00:50:03','en'),('9917529b-dc37-446d-b510-fead8dbbec9b',NULL,'172.18.0.1','2026-09-16 02:09:12','2026-09-16 02:09:12','en'),('992447b0-7341-41b0-ab4c-e4aa2dd1d6d4',NULL,'172.18.0.1','2026-09-15 20:49:19','2026-09-15 20:49:19','en'),('99380644-4857-4921-8a52-ab993b8191e5',NULL,'172.18.0.1','2026-09-19 00:23:07','2026-09-19 00:23:07','en'),('99646e60-4b25-4292-906e-c7024e116476',NULL,'172.18.0.1','2026-10-01 01:40:27','2026-10-01 01:40:27','en'),('9981fc42-e8eb-4589-be12-a0e8bf2635af',NULL,'172.18.0.1','2026-10-09 15:50:28','2026-10-09 15:50:28','en'),('9988d841-7fae-41c6-b86a-b10dbd1f8c93',NULL,'172.18.0.1','2026-09-24 20:47:14','2026-09-24 20:47:14','en'),('998bca4a-9b96-4054-94df-19c00ec99401',NULL,'172.18.0.1','2026-09-17 23:09:25','2026-09-17 23:09:25','en'),('9b5ee464-4f4e-4ed0-9ebc-754648433cbf',NULL,'172.18.0.1','2026-10-09 14:55:27','2026-10-09 14:55:27','en'),('9b7049db-af25-414c-a3bd-55dc7e3642b2',NULL,'172.18.0.1','2026-09-17 23:29:06','2026-09-17 23:29:06','en'),('9b7089cc-7e38-4cb4-bad7-967c52ac0d80',NULL,'172.18.0.1','2026-10-01 01:21:21','2026-10-01 01:21:21','en'),('9b7801de-3fa8-4143-82d9-2f2153a3ab65',NULL,'172.18.0.1','2026-09-19 02:04:54','2026-09-19 02:04:54','en'),('9bb18d94-220e-4bef-8306-9f2db96b99ac',NULL,'172.18.0.1','2026-09-17 01:21:21','2026-09-17 01:21:21','en'),('9bc9acf7-c3af-4c74-aa8e-90b58a3a2b1f',NULL,'172.18.0.1','2026-10-02 20:14:34','2026-10-02 20:14:34','en'),('9be3e95c-26e5-48c5-8ca0-4db71b368ba2',NULL,'172.18.0.1','2026-09-17 22:50:40','2026-09-17 22:50:40','en'),('9bec3f5b-8f70-41fe-b3a6-4951e1cffb30',NULL,'172.18.0.1','2026-09-18 18:09:44','2026-09-18 18:09:44','en'),('9c400f22-7c22-43df-a7ea-13792682abef',NULL,'172.18.0.1','2026-09-16 00:32:39','2026-09-16 00:32:39','en'),('9d1e3ead-9e23-479a-ab82-fadaf9669aa8',NULL,'172.18.0.1','2026-09-17 23:10:11','2026-09-17 23:10:11','en'),('9d25f117-bacf-4b42-8e8f-73a4073e6951',NULL,'172.18.0.1','2026-09-22 18:29:53','2026-09-22 18:29:53','en'),('9d28c889-a663-4409-8d78-a95b499164ec',NULL,'172.18.0.1','2026-10-02 00:18:28','2026-10-02 00:18:28','en'),('9db0ab27-81de-4b02-96ff-914c0d79a108',NULL,'172.18.0.1','2026-09-16 01:52:51','2026-09-16 01:52:51','en'),('9dc6d420-4b4a-476f-962c-1dacac86b78e',NULL,'172.18.0.1','2026-09-25 18:38:29','2026-09-25 18:38:29','en'),('9df25f11-9896-46fc-8311-fa2d7736a804',NULL,'172.18.0.1','2026-10-02 00:04:38','2026-10-02 00:04:38','en'),('9e029a93-0c4d-4081-a954-6aea31c8c701',NULL,'172.18.0.1','2026-09-24 22:09:13','2026-09-24 22:09:13','en'),('9ea5f55e-d58c-40be-ad3f-b1871f1e10f6',NULL,'172.18.0.1','2026-09-17 20:03:32','2026-09-17 20:03:32','en'),('9ed70d5a-aaf9-47e8-b9c2-ad41657b3412',NULL,'172.18.0.1','2026-10-01 01:18:27','2026-10-01 01:18:27','en'),('9f1d72c2-d0c7-48b7-a68f-144ed36dcf59',NULL,'172.18.0.1','2026-09-15 18:49:12','2026-09-15 18:49:12','en'),('a052229f-ebec-4d4f-aed8-a2c9dc6a2f12',NULL,'172.18.0.1','2026-10-01 01:04:52','2026-10-01 01:04:52','en'),('a118916d-c652-4de6-a0dc-057eb2146dda',NULL,'172.18.0.1','2026-09-15 20:49:48','2026-09-15 20:49:48','en'),('a1425907-aee2-4e5f-b9a4-350ea1c213c1',NULL,'172.18.0.1','2026-09-24 23:16:11','2026-09-24 23:16:11','en'),('a1f3ca1e-33c3-4e9b-9501-7f2a909be9d5',NULL,'172.18.0.1','2026-09-18 19:29:19','2026-09-18 19:29:19','en'),('a378ff48-9761-4bd3-9c85-fc1f6f4386f6',NULL,'172.18.0.1','2026-09-19 02:05:31','2026-09-19 02:05:31','en'),('a38ed70a-6f05-447d-b981-b8f15c4349a8',NULL,'172.18.0.1','2026-09-18 00:38:43','2026-09-18 00:38:43','en'),('a3b4380e-4607-4348-8845-ef2c45578d4d',NULL,'172.18.0.1','2026-09-17 01:52:07','2026-09-17 01:52:07','en'),('a3e91a30-a544-40d9-afd5-921260ac0b16',NULL,'172.18.0.1','2026-10-02 00:18:26','2026-10-02 00:18:26','en'),('a46ef429-09e9-40a4-bd27-552cb5dc714e',NULL,'172.18.0.1','2026-09-21 23:28:09','2026-09-21 23:28:09','en'),('a4e7d62d-cc38-4731-b04e-ee3e7305c140','18a2a9e0-c5fc-11f1-ac03-37b626f924f1','172.18.0.1','2026-10-12 12:24:05','2026-10-12 12:24:05','en'),('a50aa374-9b03-4453-9f06-0167fd8d6233',NULL,'172.18.0.1','2026-09-17 02:09:59','2026-09-17 02:09:59','en'),('a5ba810e-28bb-4084-aa34-068034f0524a',NULL,'172.18.0.1','2026-09-15 17:45:27','2026-09-15 17:45:27','en'),('a5c3ca9a-0571-4505-9043-a991db9bc1d5',NULL,'172.18.0.1','2026-09-30 20:16:30','2026-09-30 20:16:30','en'),('a5e4c4ee-5774-4692-a748-68e1b96284ab',NULL,'172.18.0.1','2026-09-18 18:43:26','2026-09-18 18:43:26','en'),('a667e150-a900-4c78-aa02-48a3bd6d31a6',NULL,'172.18.0.1','2026-09-16 01:57:38','2026-09-16 01:57:38','en'),('a6725ea7-15a0-4c83-9dc5-9eb020588065',NULL,'172.18.0.1','2026-10-01 18:00:18','2026-10-01 18:00:18','en'),('a677ef11-cae1-4bbf-bb5d-644cd3f8abca',NULL,'172.18.0.1','2026-10-01 18:26:08','2026-10-01 18:26:08','en'),('a70f71c9-16fa-4428-bd8a-604e3f2a659a',NULL,'172.18.0.1','2026-10-01 01:40:32','2026-10-01 01:40:32','en'),('a7482596-4d86-4069-87c9-f6a41c71c311',NULL,'172.18.0.1','2026-09-18 02:05:47','2026-09-18 02:05:47','en'),('a7f79639-b33b-4c9b-a557-977c8c6ee80b',NULL,'172.18.0.1','2026-09-17 23:28:26','2026-09-17 23:28:26','en'),('a8175a94-398e-45c1-84b0-444d3b43e10c',NULL,'172.18.0.1','2026-10-01 02:21:59','2026-10-01 02:21:59','en'),('a8350919-0061-414e-95db-482c75f78f82',NULL,'172.18.0.1','2026-09-19 00:47:39','2026-09-19 00:47:39','en'),('a850fb04-76bc-4b99-a389-9edbdd23ef0a',NULL,'172.18.0.1','2026-09-16 19:41:29','2026-09-16 19:41:29','en'),('a89a1a31-14cd-41a5-8412-b5505f8c6c81',NULL,'172.18.0.1','2026-10-09 15:20:27','2026-10-09 15:20:27','en'),('a92e76ad-92cb-4ff8-808a-553a9a5e7e71',NULL,'172.18.0.1','2026-09-29 23:55:28','2026-09-29 23:55:28','en'),('a939b81b-6cae-4e03-92c1-f69e4c04ecd9','74546110-bbf3-11f1-896a-3509cd30c05d','172.18.0.1','2026-09-30 01:55:31','2026-09-30 01:55:31','en'),('a9c6fb6e-8378-4924-8f94-3d1a9d33295e',NULL,'172.18.0.1','2026-09-18 20:33:39','2026-09-18 20:33:39','en'),('a9f81b4b-e3b5-476f-bd03-7a3fbfc889ea',NULL,'172.18.0.1','2026-09-16 00:49:34','2026-09-16 00:49:34','en'),('aabdb425-0cdd-4e62-aa85-ffc350b81724',NULL,'172.18.0.1','2026-10-27 10:31:53','2026-10-27 10:31:53','en'),('aacfcc5f-a506-4323-a4c9-26b53b0fb786',NULL,'172.18.0.1','2026-09-19 01:13:38','2026-09-19 01:13:38','en'),('ab3f7586-0ea5-4bbc-a194-4d49bcb58621',NULL,'172.18.0.1','2026-09-18 18:03:42','2026-09-18 18:03:42','en'),('ab544ffa-6bf3-4046-a068-53c6a61bcbf1',NULL,'172.18.0.1','2026-10-01 18:16:33','2026-10-01 18:16:33','en'),('aba2f938-d30c-4c5a-a92b-435206def656',NULL,'172.18.0.1','2026-09-24 23:24:18','2026-09-24 23:24:18','en'),('aba4885e-b089-4836-8d81-e6c97d339a3b',NULL,'172.18.0.1','2026-09-21 23:32:41','2026-09-21 23:32:41','en'),('abab128b-a6c9-4540-ad2f-6363bea93f78',NULL,'172.18.0.1','2026-09-24 23:16:12','2026-09-24 23:16:12','en'),('ac00104e-c2af-472e-9e33-2e96b6901cea',NULL,'172.18.0.1','2026-10-02 00:26:47','2026-10-02 00:26:47','en'),('ac0ceffc-0c39-4464-b814-43a1f1320862',NULL,'172.18.0.1','2026-09-26 20:55:10','2026-09-26 20:55:10','en'),('ac9f41de-a6f3-430d-90ec-79da1f41875e','18a2a9e0-c5fc-11f1-ac03-37b626f924f1','172.18.0.1','2026-10-18 15:40:14','2026-10-18 15:40:14','en'),('aca4e70d-7d7f-4c7e-b8cb-c6a704f646eb',NULL,'172.18.0.1','2026-09-25 01:36:42','2026-09-25 01:36:42','en'),('acb821e6-8709-4819-8838-747bc08b3683',NULL,'172.18.0.1','2026-09-22 00:33:54','2026-09-22 00:33:54','en'),('acca3311-7453-403b-9855-c14e220c2afa',NULL,'172.18.0.1','2026-09-18 19:25:04','2026-09-18 19:25:04','en'),('acca3b7a-1d08-4fa1-a150-1e84a70ec63e',NULL,'172.18.0.1','2026-09-28 23:01:18','2026-09-28 23:01:18','en'),('ad2c0d38-c9c4-4480-a4bf-9ee9f459f8e0',NULL,'172.18.0.1','2026-10-01 23:28:46','2026-10-01 23:28:46','en'),('add97bdb-4add-41a1-9933-6e14e0aef0e6',NULL,'172.18.0.1','2026-09-22 00:58:57','2026-09-22 00:58:57','en'),('ae1df7b5-85c5-494b-9a78-b409f63eb107',NULL,'172.18.0.1','2026-10-01 18:07:44','2026-10-01 18:07:44','en'),('ae8c9c8a-8513-4a35-bc99-968acfd96d4d',NULL,'172.18.0.1','2026-09-16 20:38:53','2026-09-16 20:38:53','en'),('aed59b6e-2b41-46b4-b495-eb75623524f7',NULL,'172.18.0.1','2026-09-16 02:27:23','2026-09-16 02:27:23','en'),('af249d9e-e995-418e-982b-787b66415c64',NULL,'172.18.0.1','2026-09-25 19:27:14','2026-09-25 19:27:14','en'),('af43b531-e966-4754-b4b4-7cdf88dbe9bf',NULL,'172.18.0.1','2026-09-16 20:04:19','2026-09-16 20:04:19','en'),('af9db46b-71a2-4825-a022-556a37b3bd84',NULL,'172.18.0.1','2026-09-19 01:13:56','2026-09-19 01:13:56','en'),('affb4f47-e25a-4ee2-a8c7-471b10d12c66',NULL,'172.18.0.1','2026-09-16 19:43:10','2026-09-16 19:43:10','en'),('b04a8af5-e4d9-4f5f-9601-70dac6426924',NULL,'172.18.0.1','2026-10-01 01:21:09','2026-10-01 01:21:09','en'),('b04b82e5-39fb-4f74-b8f4-c1c4308326c8',NULL,'172.18.0.1','2026-09-17 01:27:35','2026-09-17 01:27:35','en'),('b062aa98-7ad7-41cc-b414-fa09dbac9cbb',NULL,'172.18.0.1','2026-10-09 17:13:07','2026-10-09 17:13:07','en'),('b0bc9869-9d55-4f6d-bb44-29255498a6a9',NULL,'172.18.0.1','2026-09-15 23:20:41','2026-09-15 23:20:41','en'),('b0fad992-f011-4283-b781-ef351ae6c896',NULL,'172.18.0.1','2026-09-18 18:44:39','2026-09-18 18:44:39','en'),('b1c2e409-75a1-459e-a13c-4f025fc6f4c0',NULL,'172.18.0.1','2026-09-18 19:24:49','2026-09-18 19:24:49','en'),('b1e44f49-847d-476c-a429-a2a1aa802d81',NULL,'172.18.0.1','2026-10-01 01:15:59','2026-10-01 01:15:59','en'),('b20b0732-3ad4-44b9-93a6-89f28d87f76d',NULL,'172.18.0.1','2026-09-30 19:52:12','2026-09-30 19:52:12','en'),('b217d5ba-aaea-4fea-82f0-4b523c5aba24',NULL,'172.18.0.1','2026-09-26 20:57:49','2026-09-26 20:57:49','en'),('b221a51b-43c7-4f12-a047-67489a50dfd7',NULL,'172.18.0.1','2026-09-24 23:31:11','2026-09-24 23:31:11','en'),('b23d93cd-e652-4ded-9e9b-a0a232d48e42',NULL,'172.18.0.1','2026-09-16 19:57:47','2026-09-16 19:57:47','en'),('b2558c7c-749f-4dec-bab0-986dd0ae1e11',NULL,'172.18.0.1','2026-09-17 20:02:57','2026-09-17 20:02:57','en'),('b271390b-67e7-457f-8f1b-68dfb7e0c2ad',NULL,'172.18.0.1','2026-09-22 02:14:14','2026-09-22 02:14:14','en'),('b2ff8c5b-faa9-496b-9dcf-4d4495dae9ce',NULL,'172.18.0.1','2026-10-01 23:57:21','2026-10-01 23:57:21','en'),('b357bd3a-baee-4126-ab80-1103a6fcbded',NULL,'172.18.0.1','2026-10-26 11:29:35','2026-10-26 11:29:35','en'),('b37d787d-dc85-4b3e-9fdc-d8e55e3e44ac',NULL,'172.18.0.1','2026-09-17 20:40:45','2026-09-17 20:40:45','en'),('b38b69a5-0252-4d81-af27-d78f532e731b',NULL,'172.18.0.1','2026-10-02 00:26:47','2026-10-02 00:26:47','en'),('b3c4ed00-588c-43ba-baf1-131c60a9c0e9',NULL,'172.18.0.1','2026-09-18 22:21:10','2026-09-18 22:21:10','en'),('b434b89a-fe32-4702-b33d-9cb73f289b87',NULL,'172.18.0.1','2026-10-01 02:22:01','2026-10-01 02:22:01','en'),('b4709efe-e24d-483b-a8ca-2c541d314b80',NULL,'172.18.0.1','2026-09-24 22:55:09','2026-09-24 22:55:09','en'),('b4a6370c-d2c2-4556-9fd7-7f2e783642bb',NULL,'172.18.0.1','2026-10-01 01:52:21','2026-10-01 01:52:21','en'),('b5c27e7d-9481-428e-8517-ebadc3ae775f',NULL,'172.18.0.1','2026-09-15 20:15:18','2026-09-15 20:15:18','en'),('b5cfe040-a7ab-451e-b24e-2dad445105ba',NULL,'172.18.0.1','2026-09-26 20:55:45','2026-09-26 20:55:45','en'),('b7e565ee-aac9-4fdc-9cd3-98150306f6f0',NULL,'172.18.0.1','2026-09-15 20:42:44','2026-09-15 20:42:44','en'),('b8030922-802c-4063-945a-8924c7994eae',NULL,'172.18.0.1','2026-10-01 01:35:31','2026-10-01 01:35:31','en'),('b82ba1e4-bb7f-45e4-a118-7fee75a6a2c7',NULL,'172.18.0.1','2026-10-01 01:50:59','2026-10-01 01:50:59','en'),('b82c6357-45ce-45d1-95c6-ee10d9f35a2d',NULL,'172.18.0.1','2026-09-17 01:22:42','2026-09-17 01:22:42','en'),('b852909c-dc3c-45c2-b564-8afc9c317fb1',NULL,'172.18.0.1','2026-09-24 23:22:23','2026-09-24 23:22:23','en'),('b862b725-f0f7-48ca-aa3c-cc8654177c09',NULL,'172.18.0.1','2026-09-17 23:09:27','2026-09-17 23:09:27','en'),('b8ed227d-42f1-47ad-99f6-7b7e20e48857',NULL,'172.18.0.1','2026-09-24 22:52:17','2026-09-24 22:52:17','en'),('b8f4857a-8e70-4898-8742-0f629f119fa7',NULL,'172.18.0.1','2026-09-15 18:02:20','2026-09-15 18:02:20','en'),('b973d73d-f4a9-44dc-9d15-bff4ea207d39',NULL,'172.18.0.1','2026-10-04 07:07:48','2026-10-04 07:07:48','en'),('ba68dd87-6967-4509-8184-8b5d88eb7aba',NULL,'172.18.0.1','2026-09-16 00:50:23','2026-09-16 00:50:23','en'),('bb34ec5f-9dbf-4a50-bc1b-2531322edf61',NULL,'172.18.0.1','2026-09-18 18:43:03','2026-09-18 18:43:03','en'),('bb5d2202-98d6-476d-a7e3-7687ba70f4d7',NULL,'172.18.0.1','2026-10-02 01:24:10','2026-10-02 01:24:10','en'),('bc03a319-97c7-4aa8-accc-c43166a7fcb7',NULL,'172.18.0.1','2026-09-16 01:27:18','2026-09-16 01:27:18','en'),('bcf98f7f-7947-4187-9e16-665bfeb4d361',NULL,'172.18.0.1','2026-10-02 01:12:22','2026-10-02 01:12:22','en'),('bcfb2fbb-3d92-48fc-b8fe-94ee7b9380d5',NULL,'172.18.0.1','2026-09-24 23:34:26','2026-09-24 23:34:26','en'),('bd9c5964-eeb4-419a-a9f4-2080102f0f09',NULL,'172.18.0.1','2026-09-24 22:25:03','2026-09-24 22:25:03','en'),('be99c430-0a21-4399-9ea7-cdc694c964df',NULL,'172.18.0.1','2026-09-16 02:29:57','2026-09-16 02:29:57','en'),('bf290ba2-cf1e-478a-84ac-300e35b564e9',NULL,'172.18.0.1','2026-09-16 18:27:56','2026-09-16 18:27:56','en'),('bf31d279-407b-4987-bbc0-b68c78fbc685',NULL,'172.18.0.1','2026-09-16 20:01:03','2026-09-16 20:01:03','en'),('c0068f4e-77d4-4154-88e5-901e889af7a2',NULL,'172.18.0.1','2026-10-26 12:56:32','2026-10-26 12:56:32','en'),('c0206f4d-f47b-4a4f-abb0-0d8eccf39429',NULL,'172.18.0.1','2026-09-24 22:17:12','2026-09-24 22:17:12','en'),('c037678b-16ea-42e9-9704-da8d2e4ad615',NULL,'172.18.0.1','2026-10-01 18:26:20','2026-10-01 18:26:20','en'),('c03aff72-e59a-4aa5-b3d0-4781c05df803',NULL,'172.18.0.1','2026-09-16 01:52:42','2026-09-16 01:52:42','en'),('c054054b-f512-41f7-96d5-306326aa41dd',NULL,'172.18.0.1','2026-09-17 01:13:51','2026-09-17 01:13:51','en'),('c11c4cbd-8f96-4691-a9d3-2e97ce9a0bc9',NULL,'172.18.0.1','2026-09-14 18:13:26','2026-09-14 18:13:26','en'),('c1427006-d58c-42d2-9517-55f840b8cb2a',NULL,'172.18.0.1','2026-09-16 01:27:24','2026-09-16 01:27:24','en'),('c14b531c-0dbd-4fa8-bb34-2952fe23606f',NULL,'172.18.0.1','2026-10-01 01:05:00','2026-10-01 01:05:00','en'),('c152c25a-c7c1-46c1-b89f-128261a10bf6',NULL,'172.18.0.1','2026-09-25 01:36:48','2026-09-25 01:36:48','en'),('c1a5e685-9640-4b37-887f-ac31aa081965',NULL,'172.18.0.1','2026-10-02 00:37:25','2026-10-02 00:37:25','en'),('c292a09c-c083-477f-87dc-34391ae831b2',NULL,'172.18.0.1','2026-09-17 01:08:53','2026-09-17 01:08:53','en'),('c4090599-0391-4ca5-bd90-b5b4afa38560',NULL,'172.18.0.1','2026-09-15 01:10:39','2026-09-15 01:10:39','en'),('c42b6831-cf58-4d5a-8753-7093c294de58',NULL,'172.18.0.1','2026-09-16 00:25:11','2026-09-16 00:25:11','en'),('c42ef9aa-666b-4cd3-ae54-adc6204a6d5e',NULL,'172.18.0.1','2026-10-01 23:17:27','2026-10-01 23:17:27','en'),('c4615003-ad4c-4b5d-b89a-d34d1aa67bb1',NULL,'172.18.0.1','2026-09-15 20:15:39','2026-09-15 20:15:39','en'),('c47c9e90-5c81-413f-8bb7-a1f11696b74b',NULL,'172.18.0.1','2026-09-22 01:11:12','2026-09-22 01:11:12','en'),('c4871a7a-efd0-4716-ad06-bc5da63d4252',NULL,'172.18.0.1','2026-10-18 20:04:36','2026-10-18 20:04:36','en'),('c521a84f-41c2-4a4f-81b5-5d23b46d3407',NULL,'172.18.0.1','2026-09-17 01:28:35','2026-09-17 01:28:35','en'),('c5378fd3-0e99-4062-9d2f-23022cf9344d','80a7a9e0-b360-11f1-ac87-ad5d03a4c734','172.18.0.1','2026-09-19 02:13:47','2026-09-19 02:13:47','en'),('c5400574-1120-4e80-9930-d82cd8192f01','0c5f5d80-b59f-11f1-8d05-a13989c3aa29','172.18.0.1','2026-09-21 22:50:25','2026-09-21 22:50:25','en'),('c55f285e-17a9-4a88-8048-6a3403658d86',NULL,'172.18.0.1','2026-10-01 02:19:14','2026-10-01 02:19:14','en'),('c57895e6-6928-462b-b6f4-7ba3a820d640','c05d2ca3-4881-4060-955b-c4e48793798b','172.18.0.8','2026-10-14 10:43:50','2026-10-14 10:43:50','en'),('c5a1949e-24f0-49c8-8b9d-ea836ef8f169',NULL,'172.18.0.1','2026-09-18 02:06:35','2026-09-18 02:06:35','en'),('c6560bb6-dbe5-4a01-bbef-ebe319e08ee9',NULL,'172.18.0.1','2026-09-18 01:11:48','2026-09-18 01:11:48','en'),('c73f9f03-e2d0-46d4-a0a1-bb1eb98b8e11',NULL,'172.18.0.1','2026-10-01 01:39:36','2026-10-01 01:39:36','en'),('c7d7ea5e-1ba8-46b0-a5bd-40f48827955b',NULL,'172.18.0.1','2026-09-16 20:00:23','2026-09-16 20:00:23','en'),('c82b8889-d715-4bba-91fc-a20bb4a218bb',NULL,'172.18.0.1','2026-10-01 01:40:34','2026-10-01 01:40:34','en'),('c88937cd-eabe-4436-b23a-f2afd1a04af9',NULL,'172.18.0.1','2026-09-18 20:31:43','2026-09-18 20:31:43','en'),('c8945956-4508-4634-9bf9-228c4499ed0b',NULL,'172.18.0.1','2026-09-25 01:41:48','2026-09-25 01:41:48','en'),('c89b5d28-f17e-4fe5-809e-337040b03b71',NULL,'172.18.0.1','2026-10-01 23:05:47','2026-10-01 23:05:47','en'),('c8c371b0-023d-473d-8fb8-d0f4e79f6b8e',NULL,'172.18.0.1','2026-09-18 20:04:39','2026-09-18 20:04:39','en'),('c942a212-0e7e-4b25-a94c-09340d55fe74',NULL,'172.18.0.1','2026-09-24 23:01:36','2026-09-24 23:01:36','en'),('c987a811-088d-4f89-a933-033ca855b1af',NULL,'172.18.0.1','2026-09-16 22:27:56','2026-09-16 22:27:56','en'),('c987d4b2-0670-40dd-9565-99f51c86cd49',NULL,'172.18.0.1','2026-09-21 22:48:00','2026-09-21 22:48:00','en'),('c98ce55b-0041-4a1d-9974-099389af80ed',NULL,'172.18.0.1','2026-09-22 23:20:47','2026-09-22 23:20:47','en'),('c9d2ae4b-c79e-4e6e-bbbb-aab2dbe06c70',NULL,'172.18.0.1','2026-09-19 01:17:57','2026-09-19 01:17:57','en'),('c9fcf5c2-5ceb-4a5f-9e9a-77630888bfef',NULL,'172.18.0.1','2026-09-17 18:31:11','2026-09-17 18:31:11','en'),('cab292c3-189b-407d-875e-bccca0850100',NULL,'172.18.0.1','2026-09-21 22:41:41','2026-09-21 22:41:41','en'),('cb095bd7-822c-48f2-9bd6-7dc2bc7ba415',NULL,'172.18.0.1','2026-09-25 19:29:50','2026-09-25 19:29:50','en'),('cb1d0437-e966-43c8-a716-e6ff3063c1de',NULL,'172.18.0.1','2026-09-15 01:10:40','2026-09-15 01:10:40','en'),('ccb1827c-06f6-4cfc-8ef6-4eea8e65f970',NULL,'172.18.0.1','2026-09-16 02:28:27','2026-09-16 02:28:27','en'),('ccd5fdfa-72b0-4528-9c4d-d09ef89ed252',NULL,'172.18.0.1','2026-09-16 00:55:07','2026-09-16 00:55:07','en'),('cd7363cd-78e8-467c-9dff-cbe35896565f',NULL,'172.18.0.1','2026-09-19 02:03:20','2026-09-19 02:03:20','en'),('ce08f612-cc5d-4548-8533-7259f7a1889d',NULL,'172.18.0.1','2026-09-28 22:53:54','2026-09-28 22:53:54','en'),('ce402c01-36bf-4415-8b68-c42361468fe7',NULL,'172.18.0.1','2026-09-18 22:48:28','2026-09-18 22:48:28','en'),('ced493b5-265d-425c-acbe-e719c9deb72f',NULL,'172.18.0.1','2026-09-21 22:48:16','2026-09-21 22:48:16','en'),('ced79c81-d26d-45c6-af18-a87190f0f4a5','18a2a9e0-c5fc-11f1-ac03-37b626f924f1','172.18.0.1','2026-10-18 17:51:23','2026-10-18 17:51:23','en'),('cf0d142c-a601-4e0d-b79a-37fb060adf52',NULL,'172.18.0.1','2026-09-19 00:51:36','2026-09-19 00:51:36','en'),('cfbfb8c5-b24a-45e1-916a-9a47ec0f1ac8',NULL,'172.18.0.1','2026-09-30 01:52:58','2026-09-30 01:52:58','en'),('d03c8cd6-c86f-4920-8add-f564f7707a1b',NULL,'172.18.0.1','2026-09-16 18:28:33','2026-09-16 18:28:33','en'),('d0577d29-44ce-42d5-9d07-628fc8043fa2',NULL,'172.18.0.1','2026-09-24 22:33:29','2026-09-24 22:33:29','en'),('d06d23b2-9fbe-4cf3-afab-7f9bd878983f',NULL,'172.18.0.1','2026-09-18 18:03:16','2026-09-18 18:03:16','en'),('d0cb4ed0-006a-4ba1-a533-0c8a6a077b51',NULL,'172.18.0.1','2026-09-18 20:36:49','2026-09-18 20:36:49','en'),('d10afed7-b30f-464e-8422-508d1c31bcae',NULL,'172.18.0.1','2026-09-15 00:38:12','2026-09-15 00:38:12','en'),('d1f95350-8d0b-46f8-95a5-31af616507b4',NULL,'172.18.0.1','2026-09-15 23:20:54','2026-09-15 23:20:54','en'),('d211be48-0d0b-4aff-a817-de2f4cf11354',NULL,'172.18.0.1','2026-09-21 22:47:57','2026-09-21 22:47:57','en'),('d267f2b6-6aed-42c8-a7cb-b84827e38dd4',NULL,'172.18.0.1','2026-10-04 22:59:30','2026-10-04 22:59:30','en'),('d2e789de-5440-4b22-b6aa-c11295fe4788',NULL,'172.18.0.1','2026-10-02 00:26:39','2026-10-02 00:26:39','en'),('d32c5f94-b56f-40e3-a31f-c40b7258eb9c',NULL,'172.18.0.1','2026-10-01 01:14:17','2026-10-01 01:14:17','en'),('d32da2af-a476-4876-b599-5a18461eaddc',NULL,'172.18.0.1','2026-10-09 17:07:05','2026-10-09 17:07:05','en'),('d333933b-373b-4e0a-892f-e7fddab9875c',NULL,'172.18.0.1','2026-10-01 23:57:22','2026-10-01 23:57:22','en'),('d34c877b-6562-470f-93d5-ae7f956fd3cb',NULL,'172.18.0.1','2026-09-24 23:04:38','2026-09-24 23:04:38','en'),('d36b03e0-4ac9-4c80-b447-36ace9f81bde',NULL,'172.18.0.1','2026-09-22 23:21:18','2026-09-22 23:21:18','en'),('d373568f-7f45-4bf7-94b4-1845a4184237',NULL,'172.18.0.1','2026-10-08 17:00:31','2026-10-08 17:00:31','en'),('d4215bc1-8431-4baa-be0a-83514a5f9b24',NULL,'172.18.0.1','2026-10-08 17:15:08','2026-10-08 17:15:08','en'),('d4250ce2-e9d4-45c7-8c79-19a7051b4054',NULL,'172.18.0.1','2026-09-16 20:42:22','2026-09-16 20:42:22','en'),('d439f453-1094-4399-adf8-6075eee3b3ea',NULL,'172.18.0.1','2026-09-30 22:50:27','2026-09-30 22:50:27','en'),('d43f0a26-1e6e-467c-b22f-55f90599d3f9',NULL,'172.18.0.1','2026-09-17 20:42:20','2026-09-17 20:42:20','en'),('d4d8d979-cea5-49a3-8869-17965486f9e7',NULL,'172.18.0.1','2026-09-17 00:38:39','2026-09-17 00:38:39','en'),('d54ecb09-8c3a-4fb2-8770-51c4e2209766',NULL,'172.18.0.1','2026-10-01 23:26:42','2026-10-01 23:26:42','en'),('d6292456-ed83-48e1-82ee-6b0b7c7a5747',NULL,'172.18.0.1','2026-09-16 01:33:18','2026-09-16 01:33:18','en'),('d6a462d6-c43f-429a-9677-1022990ea581',NULL,'172.18.0.1','2026-09-17 02:13:49','2026-09-17 02:13:49','en'),('d6bd90a9-127f-4907-bf1d-47434e561c7b',NULL,'172.18.0.1','2026-09-16 19:57:32','2026-09-16 19:57:32','en'),('d6c502fe-c009-4715-8b77-98dc73136a3f',NULL,'172.18.0.1','2026-09-17 00:39:27','2026-09-17 00:39:27','en'),('d70669d3-41fd-4ffd-bc34-9ba8028d0abc',NULL,'172.18.0.1','2026-09-16 02:28:26','2026-09-16 02:28:26','en'),('d7112f9a-4455-44a1-b7fb-3dda9519f095',NULL,'172.18.0.1','2026-09-24 22:48:35','2026-09-24 22:48:35','en'),('d728f582-7163-4d2c-af1e-37c78a9d4fd8',NULL,'172.18.0.1','2026-09-29 23:50:33','2026-09-29 23:50:33','en'),('d78f6176-5ec2-4630-8ca1-b2fdf19ab2fc',NULL,'172.18.0.1','2026-09-17 02:10:58','2026-09-17 02:10:58','en'),('d7ee1b05-c718-4974-b3bd-b70f1ce6fa82',NULL,'172.18.0.1','2026-09-22 01:17:22','2026-09-22 01:17:22','en'),('d803c259-7f14-46c1-9745-b80331752a09','18a2a9e0-c5fc-11f1-ac03-37b626f924f1','172.18.0.1','2026-10-18 15:33:52','2026-10-18 15:33:52','en'),('d8141d0d-6f88-4f7f-aedc-c25046e0af1d',NULL,'172.18.0.1','2026-09-18 22:21:09','2026-09-18 22:21:09','en'),('d83b2f6c-c11b-47a5-b2e1-05020d892d29',NULL,'172.18.0.1','2026-09-25 19:19:47','2026-09-25 19:19:47','en'),('d95d66d9-b923-44fa-8e02-545bcd4c1da9',NULL,'172.18.0.1','2026-09-16 02:28:29','2026-09-16 02:28:29','en'),('d9898013-f2d7-4791-90a9-12d7d06c0c1a',NULL,'172.18.0.1','2026-09-17 02:26:57','2026-09-17 02:26:57','en'),('d99ebd69-1968-4424-9c7f-20583880fc7d',NULL,'172.18.0.1','2026-09-17 00:35:08','2026-09-17 00:35:08','en'),('d9fe2c09-37ff-4e2d-a1aa-14a6f3a04757',NULL,'172.18.0.1','2026-09-18 19:25:11','2026-09-18 19:25:11','en'),('da23e060-cdbe-475d-81d3-a6fc4bf0bec8',NULL,'172.18.0.1','2026-09-30 00:05:01','2026-09-30 00:05:01','en'),('da30cc95-bce2-45bb-b10a-f93263fe9bff',NULL,'172.18.0.1','2026-09-17 19:06:55','2026-09-17 19:06:55','en'),('da4997b4-47d0-4d9b-839a-f65e74c2eb1a',NULL,'172.18.0.1','2026-10-01 01:16:04','2026-10-01 01:16:04','en'),('da61c434-2e17-42b3-8245-8c90d1c29071',NULL,'172.18.0.1','2026-09-24 23:16:33','2026-09-24 23:16:33','en'),('da908d7f-94f7-41aa-bb93-5179e39ba1b3',NULL,'172.18.0.1','2026-09-19 02:02:38','2026-09-19 02:02:38','en'),('dada675c-7b57-4e81-b3dc-1cbfb1bae8a1',NULL,'172.18.0.1','2026-09-17 20:39:53','2026-09-17 20:39:53','en'),('db4c4675-875d-4617-ba60-3e9531b0bb57',NULL,'172.18.0.1','2026-09-19 02:05:24','2026-09-19 02:05:24','en'),('db56f8b4-0a96-4f67-85e9-ca41d948a366',NULL,'172.18.0.1','2026-09-17 20:35:50','2026-09-17 20:35:50','en'),('dc2f4698-3bb1-4f3b-a207-2bf10a1dcbed',NULL,'172.18.0.1','2026-09-17 01:09:50','2026-09-17 01:09:50','en'),('dc5a1e9f-5d31-4235-ac57-7b1786427434',NULL,'172.18.0.1','2026-09-22 17:59:10','2026-09-22 17:59:10','en'),('dc78d7a9-928e-4498-8bad-9584d0deae62',NULL,'172.18.0.1','2026-10-02 01:04:11','2026-10-02 01:04:11','en'),('dc7d60d9-6a43-4ab6-bc7d-6e292c98b3f4',NULL,'172.18.0.1','2026-09-16 01:27:13','2026-09-16 01:27:13','en'),('dc9788e2-78b1-434d-82ec-c05af9008c88',NULL,'172.18.0.1','2026-10-08 17:39:17','2026-10-08 17:39:17','en'),('dcab0eb2-7742-4979-8ceb-4dfc81654f42',NULL,'172.18.0.1','2026-09-15 00:56:58','2026-09-15 00:56:58','en'),('dcfd6fd7-9b22-42fe-a657-ac73df82de96',NULL,'172.18.0.1','2026-09-19 00:51:23','2026-09-19 00:51:23','en'),('ddf85352-32e5-4157-8f01-e0fb3d500a01',NULL,'172.18.0.1','2026-10-01 23:58:30','2026-10-01 23:58:30','en'),('def3062a-721c-4a74-8a65-1047d0544da8',NULL,'172.18.0.1','2026-09-16 19:34:10','2026-09-16 19:34:10','en'),('df3c6afc-3210-4d5e-a59b-97eb4562f49e',NULL,'172.18.0.1','2026-10-01 01:21:19','2026-10-01 01:21:19','en'),('dfd3373f-7031-41f1-a58b-965d1fd2683e',NULL,'172.18.0.1','2026-09-17 01:49:33','2026-09-17 01:49:33','en'),('dfd35a31-c98e-42cb-8f97-a49c5f63473d',NULL,'172.18.0.1','2026-10-01 01:12:21','2026-10-01 01:12:21','en'),('e026150c-b385-4a54-9bd0-17ddf2a458e2',NULL,'172.18.0.1','2026-09-28 22:59:35','2026-09-28 22:59:35','en'),('e02c75f6-3993-4722-b226-e65906f6cf37',NULL,'172.18.0.1','2026-09-25 18:38:33','2026-09-25 18:38:33','en'),('e0af43ce-2ab3-44ec-a252-534daf569ee5',NULL,'172.18.0.1','2026-10-08 17:05:38','2026-10-08 17:05:38','en'),('e10afe3a-f1cc-442e-adfb-c993748fa1c6',NULL,'172.18.0.1','2026-09-16 18:27:55','2026-09-16 18:27:55','en'),('e115dd8f-015d-41f4-b55e-1fa8e3dc0dbc',NULL,'172.18.0.1','2026-09-29 23:50:00','2026-09-29 23:50:00','en'),('e11f19bb-de08-4def-a575-d6138213f967',NULL,'172.18.0.1','2026-09-30 01:48:34','2026-09-30 01:48:34','en'),('e1478ba2-9970-42b4-b1c7-4ffa5b0b157b',NULL,'172.18.0.1','2026-09-18 20:33:40','2026-09-18 20:33:40','en'),('e1524d54-75db-4a2f-8f3a-c34ed9faf467',NULL,'172.18.0.1','2026-09-16 02:13:21','2026-09-16 02:13:21','en'),('e1b8ea80-a6ea-4a4d-96f5-caf98c7a92a4',NULL,'192.168.50.57','2024-11-19 15:49:05','2024-11-19 15:49:05','en'),('e1df36da-e69e-4426-993c-d1b8dc1e288f',NULL,'172.18.0.1','2026-10-01 18:08:49','2026-10-01 18:08:49','en'),('e280c4b7-fb2e-492e-b49a-cb95c16e9e4c',NULL,'172.18.0.1','2026-10-02 01:12:25','2026-10-02 01:12:25','en'),('e2f54e86-587b-4231-a8dd-84be20e42739',NULL,'172.18.0.1','2026-09-16 01:47:57','2026-09-16 01:47:57','en'),('e30d92e6-9ece-435e-a728-4406c8c484be',NULL,'172.18.0.1','2026-09-18 00:39:37','2026-09-18 00:39:37','en'),('e31f997f-63d7-459d-a9ec-4187c0bee35d',NULL,'172.18.0.1','2026-09-28 22:53:54','2026-09-28 22:53:54','en'),('e3ceae47-c654-411b-a82b-1a75c7319851',NULL,'172.18.0.1','2026-09-15 18:02:16','2026-09-15 18:02:16','en'),('e3fc1e5f-c9de-4184-b0d4-7ba83eeebece',NULL,'172.18.0.1','2026-09-18 18:10:30','2026-09-18 18:10:30','en'),('e4293862-e9cd-456c-a0c8-9796361d931f',NULL,'172.18.0.1','2026-10-09 17:29:58','2026-10-09 17:29:58','en'),('e43c4849-3936-4535-bd87-e2312418df98',NULL,'172.18.0.1','2026-09-28 22:59:36','2026-09-28 22:59:36','en'),('e4dc9ced-6dd2-4939-8b32-717ec0f3ca10',NULL,'172.18.0.1','2026-09-18 18:07:58','2026-09-18 18:07:58','en'),('e5034de6-3754-4b90-a3de-79cd3c193d10',NULL,'172.18.0.1','2026-09-24 23:16:32','2026-09-24 23:16:32','en'),('e56eb958-bf0c-44b2-acc7-d9a9f7e7d0e4',NULL,'172.18.0.1','2026-09-25 19:19:49','2026-09-25 19:19:49','en'),('e5bb92a4-3629-4c43-a454-6881d4ad6984',NULL,'172.18.0.1','2026-09-18 18:10:27','2026-09-18 18:10:27','en'),('e5cdbc67-95f7-4285-9ff0-586833cd65f2',NULL,'172.18.0.1','2026-09-24 20:25:02','2026-09-24 20:25:02','en'),('e5d544f9-583c-4495-a5cd-62907821ca4a',NULL,'172.18.0.1','2026-09-19 01:07:04','2026-09-19 01:07:04','en'),('e62a2750-2216-4ece-93f2-34d18c7e2401',NULL,'172.18.0.1','2026-09-17 02:25:11','2026-09-17 02:25:11','en'),('e62cf07a-c016-4a24-aece-9abe44d72553',NULL,'172.18.0.1','2026-10-01 01:35:38','2026-10-01 01:35:38','en'),('e70de2e8-8ec0-450c-9f36-6d9ea2ae39bd',NULL,'172.18.0.1','2026-09-15 19:05:50','2026-09-15 19:05:50','en'),('e726c664-4b60-47bd-81f4-1d8b5f425ddf',NULL,'172.18.0.1','2026-09-17 20:29:58','2026-09-17 20:29:58','en'),('e78a5596-4711-4365-98c8-6d206dda4eef',NULL,'172.18.0.1','2026-09-18 23:19:41','2026-09-18 23:19:41','en'),('e7ca0ba2-ecc7-4785-bef4-51d8f66fdc05',NULL,'172.18.0.1','2026-09-15 01:02:55','2026-09-15 01:02:55','en'),('e7d3b308-e0f4-4e1a-a0e5-3151ee54b47e',NULL,'172.18.0.1','2026-09-15 20:42:27','2026-09-15 20:42:27','en'),('e7ea9de3-cfc5-4769-bbea-c41719faf60d',NULL,'172.18.0.1','2026-10-01 01:18:31','2026-10-01 01:18:31','en'),('e80e87df-2bf5-41fc-8525-ca558fcdcf13',NULL,'172.18.0.1','2026-09-16 01:29:23','2026-09-16 01:29:23','en'),('e86334d3-a81d-45bc-a6b7-d62a89716d63',NULL,'172.18.0.1','2026-09-15 20:42:27','2026-09-15 20:42:27','en'),('e8b626c1-ba8e-4d48-93a6-34126f47ff62',NULL,'172.18.0.1','2026-10-01 02:02:43','2026-10-01 02:02:43','en'),('e8e62549-5315-46e5-8aa1-60d0f3cbab1c',NULL,'172.18.0.1','2026-10-08 16:41:42','2026-10-08 16:41:42','en'),('e947bef7-606f-4576-ab88-165ac8079086',NULL,'172.18.0.1','2026-10-26 17:29:45','2026-10-26 17:29:45','en'),('e95b79b8-00e1-4727-984c-98031d20a87a',NULL,'172.18.0.1','2026-09-14 18:14:26','2026-09-14 18:14:26','en'),('e98c1d2f-304d-4244-b2d0-37cb6558adf4',NULL,'172.18.0.1','2026-09-16 19:34:31','2026-09-16 19:34:31','en'),('e9a0981c-8a90-4607-bede-a0a7ffdecb37',NULL,'172.18.0.1','2026-09-24 22:02:21','2026-09-24 22:02:21','en'),('e9e63c4c-54d2-4cb1-b191-638c3f74f5cc',NULL,'172.18.0.1','2026-10-09 17:12:57','2026-10-09 17:12:57','en'),('e9fe1aba-90b3-4e37-9c7e-9eb390608406',NULL,'172.18.0.1','2026-10-01 02:01:38','2026-10-01 02:01:38','en'),('ea325cdc-48f9-439c-a48e-4b64686dc330',NULL,'172.18.0.1','2026-09-30 01:01:57','2026-09-30 01:01:57','en'),('ea94422b-5035-4a67-8a18-a459eed27a5a',NULL,'172.18.0.1','2026-09-18 20:31:26','2026-09-18 20:31:26','en'),('eaace854-2b6b-43ea-9b30-dc199c14fdc6',NULL,'172.18.0.1','2026-10-01 02:10:32','2026-10-01 02:10:32','en'),('ead151ca-d9a4-4f3b-b7d4-14a266a6b451',NULL,'172.18.0.1','2026-09-16 02:25:17','2026-09-16 02:25:17','en'),('eae1428a-080a-4f10-a681-b94904bee443',NULL,'172.18.0.1','2026-09-17 00:59:02','2026-09-17 00:59:02','en'),('eb16d386-6f7b-4e27-bfd0-b7a3a5ca82cd',NULL,'172.18.0.1','2026-09-24 20:51:33','2026-09-24 20:51:33','en'),('eb4e3e51-9fcf-459e-830c-4495cd51d087','74546110-bbf3-11f1-896a-3509cd30c05d','172.18.0.1','2026-09-30 01:05:07','2026-09-30 01:05:07','en'),('eb7af4cb-c6cc-4f2f-a754-3ad584822790',NULL,'172.18.0.1','2026-09-17 01:10:47','2026-09-17 01:10:47','en'),('ebc7e40c-3a56-4278-a687-f46baa13acad',NULL,'172.18.0.1','2026-09-24 23:22:21','2026-09-24 23:22:21','en'),('ebcf2893-ccb2-4591-a49e-b566d523da11',NULL,'172.18.0.1','2026-09-17 22:49:25','2026-09-17 22:49:25','en'),('ec3b7feb-6304-4a06-9c95-62521bf73632',NULL,'172.18.0.1','2026-09-16 19:42:10','2026-09-16 19:42:10','en'),('ec7730e7-8555-4192-99af-a2c93cd3ddb8',NULL,'172.18.0.1','2026-09-18 22:16:55','2026-09-18 22:16:55','en'),('ec7cc99e-87d1-4233-a195-1eb1d2b9e077',NULL,'172.18.0.1','2026-09-15 00:38:02','2026-09-15 00:38:02','en'),('ec90f63c-3ba4-4b3a-a7ef-1b7f300b8b6b',NULL,'172.18.0.1','2026-09-16 01:33:03','2026-09-16 01:33:03','en'),('ecc9b468-b03c-48d0-b91a-9edd93fd3a51',NULL,'172.18.0.1','2026-09-22 17:59:07','2026-09-22 17:59:07','en'),('ecedbdc1-fbc9-40cd-b0a4-b0f9cf4dd9b0',NULL,'172.18.0.1','2026-10-01 23:26:42','2026-10-01 23:26:42','en'),('ed4f2d96-7845-49aa-b206-6975f0594006',NULL,'172.18.0.1','2026-09-18 00:38:23','2026-09-18 00:38:23','en'),('ed51f0a3-4ff5-4280-b834-060bb2a28ba3',NULL,'172.18.0.1','2026-09-22 01:30:19','2026-09-22 01:30:19','en'),('edc62214-4348-416d-97e1-d909aa85d244','332c04b0-c30d-11f1-a097-2f27d9504379','172.18.0.1','2026-10-09 17:40:23','2026-10-09 17:40:23','en'),('ee28155d-728c-4d56-8623-bf59a7b79724',NULL,'172.18.0.1','2026-09-15 23:20:59','2026-09-15 23:20:59','en'),('ee320570-bfae-4946-a8c5-e51f73dd90c3',NULL,'172.18.0.1','2026-09-17 01:22:04','2026-09-17 01:22:04','en'),('ee5b22c5-2f96-4c28-83ea-daa0f11f8d01',NULL,'172.18.0.1','2026-09-18 00:38:22','2026-09-18 00:38:22','en'),('ee948917-1645-4bab-9354-1c2a37fd7299',NULL,'172.18.0.1','2026-09-16 00:28:41','2026-09-16 00:28:41','en'),('eed85787-79b3-495f-aa9c-b26e8d0887ba',NULL,'172.18.0.1','2026-09-16 20:01:02','2026-09-16 20:01:02','en'),('efd6ef55-6722-4196-96e7-a868dbb9a08a',NULL,'172.18.0.1','2026-09-16 19:43:35','2026-09-16 19:43:35','en'),('f073e889-5689-404f-a652-0dc8e8443a8c',NULL,'172.18.0.1','2026-10-26 10:31:06','2026-10-26 10:31:06','en'),('f084dfa0-7d16-418b-8723-3a3d822bd92f',NULL,'172.18.0.1','2026-09-30 00:07:31','2026-09-30 00:07:31','en'),('f1127806-1c8a-4da9-bb57-d449e45dec31',NULL,'172.18.0.1','2026-09-16 19:43:32','2026-09-16 19:43:32','en'),('f1736150-9dc1-4058-9f3b-bfa5630f443c',NULL,'172.18.0.1','2026-09-17 02:22:29','2026-09-17 02:22:29','en'),('f17ed298-8319-434b-85bc-249ff4f69bea',NULL,'172.18.0.1','2026-09-15 19:56:16','2026-09-15 19:56:16','en'),('f1b84d76-d04c-4f32-9ba4-5ff5c779a119',NULL,'172.18.0.1','2026-09-22 18:29:56','2026-09-22 18:29:56','en'),('f1c96e7b-7314-4278-b35b-624124286d60',NULL,'172.18.0.1','2026-09-30 02:25:28','2026-09-30 02:25:28','en'),('f1dd46f8-be9f-48f6-8b3d-54bf568a417a',NULL,'172.18.0.1','2026-09-16 18:02:10','2026-09-16 18:02:10','en'),('f2118cd8-fd86-4717-afbf-48f45a433bd1',NULL,'172.18.0.1','2026-09-17 18:36:45','2026-09-17 18:36:45','en'),('f23497bc-c97f-41cf-b1f9-94652caeb83c',NULL,'172.18.0.1','2026-09-19 00:23:21','2026-09-19 00:23:21','en'),('f25a2c1b-5d84-4628-a8ea-3e2afd0cf5e6',NULL,'172.18.0.1','2026-09-18 20:31:26','2026-09-18 20:31:26','en'),('f28bbe53-383b-44cb-b02b-5af14e76bccf',NULL,'172.18.0.1','2026-09-18 19:24:46','2026-09-18 19:24:46','en'),('f369ac39-c368-4438-a5b5-0fcb23916fb9',NULL,'172.18.0.1','2026-09-16 18:16:13','2026-09-16 18:16:13','en'),('f3e8372a-e745-41e1-b68c-f8b02a466ce4',NULL,'172.18.0.1','2026-09-30 19:51:22','2026-09-30 19:51:22','en'),('f409988e-575a-4b70-836a-7738c7feeb95',NULL,'172.18.0.1','2026-09-28 22:51:25','2026-09-28 22:51:25','en'),('f42a3f7e-31f6-4654-9163-1b070002af11',NULL,'172.18.0.1','2026-09-30 02:25:32','2026-09-30 02:25:32','en'),('f447a55c-8972-4930-b37e-68ca871f63fe',NULL,'172.18.0.1','2026-09-30 01:01:50','2026-09-30 01:01:50','en'),('f48c5239-bbd1-431c-b7fa-95ba0122b833',NULL,'172.18.0.1','2026-09-18 00:39:35','2026-09-18 00:39:35','en'),('f48ce5c6-9643-456d-9d9a-4b236ca10be8',NULL,'172.18.0.1','2026-09-25 19:06:37','2026-09-25 19:06:37','en'),('f5185841-35f5-4546-b83c-b085e3830cf0',NULL,'172.18.0.1','2026-10-18 19:18:56','2026-10-18 19:18:56','en'),('f60e612f-b9cc-4b05-be47-00f1de71abf6',NULL,'172.18.0.1','2026-09-16 01:28:51','2026-09-16 01:28:51','en'),('f6557156-84a1-461b-8a0e-61c9e3eba512',NULL,'172.18.0.1','2026-10-01 01:21:23','2026-10-01 01:21:23','en'),('f6abaa30-0227-46a6-8a38-f7441899552b',NULL,'172.18.0.1','2026-09-29 23:55:31','2026-09-29 23:55:31','en'),('f6c7026c-e534-4497-b850-e82cc4ec7ef5',NULL,'172.18.0.1','2026-09-16 19:41:13','2026-09-16 19:41:13','en'),('f70f1495-45d8-41e7-a997-5776fcb10e1f','5502f459-26c8-466b-9e04-4c0dbf41445e','172.18.0.8','2026-10-14 10:55:48','2026-10-14 10:55:48','en'),('f739687b-8318-49ea-b92c-4592a3a15218',NULL,'172.18.0.1','2026-09-16 01:57:43','2026-09-16 01:57:43','en'),('f7998c95-eeaf-4783-a60b-50c9bfacc724',NULL,'172.18.0.1','2026-09-24 23:24:23','2026-09-24 23:24:23','en'),('f7fb1908-4bef-4ae4-9859-91d89cf9ee71',NULL,'172.18.0.1','2026-09-16 22:29:52','2026-09-16 22:29:52','en'),('f81b3dd8-a29a-4dba-9124-8373d67533e8','2c310670-bd80-11f1-b0e8-0dfb9e6318b8','172.18.0.1','2026-10-01 23:30:12','2026-10-01 23:30:12','en'),('f828b90e-5063-487a-8018-6a0f9bd8c3a1',NULL,'172.18.0.1','2026-09-21 23:35:40','2026-09-21 23:35:40','en'),('f877325b-da9f-48af-b751-b5eec2626af6',NULL,'172.18.0.1','2026-09-24 23:00:15','2026-09-24 23:00:15','en'),('f8cce86a-0508-40a0-a7a5-02f33e29ca3e',NULL,'172.18.0.1','2026-10-08 16:41:40','2026-10-08 16:41:40','en'),('f93faa3e-ab03-4560-a457-a012af8a1698',NULL,'172.18.0.1','2026-09-22 17:51:36','2026-09-22 17:51:36','en'),('f94086fe-9194-4693-990f-149cb4a2034d',NULL,'172.18.0.1','2026-09-17 18:34:53','2026-09-17 18:34:53','en'),('f9fa010a-0782-47fa-b9e1-eead044cddf6',NULL,'172.18.0.1','2026-09-24 23:38:58','2026-09-24 23:38:58','en'),('fa09152b-7c8d-44bf-a6d8-9577123f1174',NULL,'172.18.0.1','2026-09-16 22:28:45','2026-09-16 22:28:45','en'),('fa5d28be-e69f-48c9-bfe7-9b89cbfe80cb',NULL,'172.18.0.1','2026-09-16 19:47:07','2026-09-16 19:47:07','en'),('faa7fc44-9a3c-43b1-98b6-8077a78e7419',NULL,'172.18.0.1','2026-10-01 01:52:18','2026-10-01 01:52:18','en'),('faa8530b-f628-45a9-ae68-48fe38a0dd69',NULL,'172.18.0.1','2026-09-15 01:14:10','2026-09-15 01:14:10','en'),('faab4bb3-b10b-4c4c-a75e-0982d3df4cac',NULL,'172.18.0.1','2026-09-18 02:28:03','2026-09-18 02:28:03','en'),('fae7fb56-5ae8-4237-8e8c-20c9fb4776f9',NULL,'172.18.0.1','2026-10-18 18:53:33','2026-10-18 18:53:33','en'),('fb8c5685-eb5f-41f3-add4-0ecedfee3972',NULL,'172.18.0.1','2026-09-21 22:49:42','2026-09-21 22:49:42','en'),('fbf97f4b-1d31-4c68-a09b-70e9a6d51e88',NULL,'172.18.0.1','2026-09-24 22:55:09','2026-09-24 22:55:09','en'),('fc0bacaa-18ff-4302-9a4b-8f6194ce1d37',NULL,'172.18.0.1','2026-09-17 20:42:26','2026-09-17 20:42:26','en'),('fc75f7e5-f538-40ca-8dcd-fdb38bd7d7f4',NULL,'172.18.0.1','2026-09-16 00:24:09','2026-09-16 00:24:09','en'),('fca0cee8-4ce4-4c2c-b4a9-07e008599665',NULL,'172.18.0.1','2026-09-16 19:42:11','2026-09-16 19:42:11','en'),('fe59c41c-ff7b-4991-9872-ec1fe1d5de0a',NULL,'172.18.0.1','2026-09-15 19:56:25','2026-09-15 19:56:25','en'),('feb9c986-7bee-4dc2-ad55-88c5cad01149',NULL,'172.18.0.1','2026-09-15 20:12:25','2026-09-15 20:12:25','en'),('fee1298e-5b8c-4896-b1d2-1e79ae9f1a41',NULL,'172.18.0.1','2026-10-01 02:10:33','2026-10-01 02:10:33','en'),('ff2fb5da-5d7c-4c9e-bc4f-8529f40ddeb9',NULL,'172.18.0.1','2026-09-19 02:04:39','2026-09-19 02:04:39','en'),('ff6182f8-8630-45df-8cbd-69326f5d0519',NULL,'172.18.0.1','2026-09-22 01:11:22','2026-09-22 01:11:22','en');
/*!40000 ALTER TABLE `guests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ignored_posts`
--

DROP TABLE IF EXISTS `ignored_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ignored_posts` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ignored_posts`
--

LOCK TABLES `ignored_posts` WRITE;
/*!40000 ALTER TABLE `ignored_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ignored_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `landing_page_features`
--

DROP TABLE IF EXISTS `landing_page_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `landing_page_features` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landing_page_features`
--

LOCK TABLES `landing_page_features` WRITE;
/*!40000 ALTER TABLE `landing_page_features` DISABLE KEYS */;
INSERT INTO `landing_page_features` VALUES ('12696663-098f-432a-8b1a-f192ea05c7a6','GET YOUR SERVICE 24/7','Visit our app and select your location to see available services near you','2023-08-31-64ef2e92e47c3.png','2023-08-31-64ef2e92e8b41.png','2023-12-28 14:00:58','2023-12-28 14:00:58');
/*!40000 ALTER TABLE `landing_page_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `landing_page_specialities`
--

DROP TABLE IF EXISTS `landing_page_specialities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `landing_page_specialities` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landing_page_specialities`
--

LOCK TABLES `landing_page_specialities` WRITE;
/*!40000 ALTER TABLE `landing_page_specialities` DISABLE KEYS */;
INSERT INTO `landing_page_specialities` VALUES ('dcfe3c2b-9a84-4621-ba8a-34ea95dcb21f','Speciality','Speciality description','2023-08-31-64ef3bcbbeb55.png','2023-12-28 14:00:58','2023-12-28 14:00:58');
/*!40000 ALTER TABLE `landing_page_specialities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `landing_page_testimonials`
--

DROP TABLE IF EXISTS `landing_page_testimonials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `landing_page_testimonials` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `review` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landing_page_testimonials`
--

LOCK TABLES `landing_page_testimonials` WRITE;
/*!40000 ALTER TABLE `landing_page_testimonials` DISABLE KEYS */;
INSERT INTO `landing_page_testimonials` VALUES ('455f102c-97eb-42f8-bb97-473eb6887eef','Mike','Designer','Thank you! That was very helpful! The Service men were very professionals & very caution about safety','2023-08-31-64ef36f7190ba.png','2023-12-28 14:00:58','2023-12-28 14:00:58');
/*!40000 ALTER TABLE `landing_page_testimonials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_setups`
--

DROP TABLE IF EXISTS `login_setups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_setups` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_setups`
--

LOCK TABLES `login_setups` WRITE;
/*!40000 ALTER TABLE `login_setups` DISABLE KEYS */;
INSERT INTO `login_setups` VALUES ('3512e741-650f-49da-9fc4-f35354b195a2','social_media_for_login','{\"google\":1,\"facebook\":0,\"apple\":0,\"google_web_client_id\":\"335647024618-qdibm9gco0vmk0kh2hf6kr34lj875fhq.apps.googleusercontent.com\"}','2024-08-25 14:24:01','2024-08-25 14:24:01'),('b7b6a9ef-0ea6-437e-9d67-d602971b9b9d','phone_verification','0','2024-08-25 14:24:01','2024-08-25 14:24:01'),('d39dfe35-ec95-4168-a181-f1c16ecfe7ed','email_verification','1','2024-08-25 14:24:01','2024-08-25 14:24:01'),('f5030bd4-4f1d-4e84-b66a-d7b7cdc20e86','login_options','{\"manual_login\":1,\"otp_login\":0,\"social_media_login\":1}','2024-08-25 14:24:01','2024-08-25 14:24:01');
/*!40000 ALTER TABLE `login_setups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loyalty_point_transactions`
--

DROP TABLE IF EXISTS `loyalty_point_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_point_transactions` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `credit` decimal(24,2) NOT NULL DEFAULT '0.00',
  `debit` decimal(24,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(24,2) NOT NULL DEFAULT '0.00',
  `reference` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loyalty_point_transactions`
--

LOCK TABLES `loyalty_point_transactions` WRITE;
/*!40000 ALTER TABLE `loyalty_point_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `loyalty_point_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=277 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_100000_create_password_resets_table',1),(2,'2016_06_01_000001_create_oauth_auth_codes_table',1),(3,'2016_06_01_000002_create_oauth_access_tokens_table',1),(4,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(5,'2016_06_01_000004_create_oauth_clients_table',1),(6,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),(7,'2019_12_14_000001_create_personal_access_tokens_table',1),(8,'2022_02_28_094005_create_users_table',1),(9,'2022_02_28_094802_create_roles_table',1),(10,'2022_02_28_094823_create_user_roles_table',1),(11,'2022_03_01_092248_create_modules_table',1),(12,'2022_03_01_093500_create_role_modules_table',1),(13,'2022_03_05_085155_create_zones_table',1),(14,'2022_03_06_035439_create_categories_table',1),(15,'2022_03_06_042053_create_category_zone_table',1),(16,'2022_03_06_091813_create_discounts_table',1),(17,'2022_03_06_092202_create_services_table',1),(18,'2022_03_06_094413_create_variations_table',1),(19,'2022_03_07_063157_create_discount_types_table',1),(21,'2022_03_07_065305_create_provider_sub_category_table',1),(22,'2022_03_07_090055_create_coupons_table',1),(23,'2022_03_07_110744_create_campaigns_table',1),(24,'2022_03_08_052530_create_banners_table',1),(25,'2022_03_08_090735_create_transactions_table',1),(26,'2022_03_10_074138_create_accounts_table',1),(27,'2022_05_09_122054_add_variant_key_in_variation',2),(28,'2022_05_12_100348_create_faqs_table',3),(29,'2022_05_18_041330_discount_table_col_modify',4),(30,'2022_05_21_035041_add_coupon_type',5),(31,'2022_05_22_120123_add_banner_redirection_link',6),(33,'2022_05_24_043332_remove_and_reformat_urder_table_col',8),(34,'2022_03_07_064337_create_providers_table',9),(35,'2022_05_25_054015_create_business_settings_table',10),(36,'2022_06_05_061932_create_bookings_table',11),(37,'2022_06_05_063828_create_booking_details_table',11),(38,'2022_06_05_065027_create_booking_status_histories_table',11),(39,'2022_06_05_065040_create_booking_schedule_histories_table',11),(40,'2022_06_08_070555_add_status_col_toRole',12),(41,'2022_06_11_074614_category_sub_added_booking',13),(42,'2022_06_11_110610_create_user_zones_table',13),(43,'2022_06_12_034552_create_user_addresses_table',13),(44,'2022_06_13_120346_add_column_is_approved_to_provider_table',14),(45,'2022_06_14_104816_create_bank_details_table',15),(46,'2022_06_15_025832_role_table_customization',16),(47,'2022_06_15_043227_create_subscribed_services_table',16),(48,'2022_06_16_060054_tnx_add',17),(49,'2022_06_16_060137_acc_add',18),(51,'2022_06_18_052537_create_reviews_table',19),(52,'2022_06_18_095222_create_withdraw_requests_table',20),(53,'2022_06_16_094936_create_servicemen_table',21),(54,'2022_06_19_063119_add_serviceman_col',22),(55,'2022_06_20_085647_add_col_to_serviceman',23),(56,'2022_06_22_082434_create_carts_table',24),(57,'2022_06_22_121556_create_cart_service_infos_table',24),(58,'2022_06_22_090257_column_add_to_withdraw_request_table',25),(59,'2022_07_03_065118_add_zone_id_in_providers',26),(61,'2022_07_17_064031_add_addres_type',27),(62,'2022_07_17_071324_add_addres_type1',27),(63,'2022_07_19_040550_change-col-name',28),(64,'2022_07_03_095424_create_push_notifications_table',29),(65,'2022_07_21_050907_pass_reset_table_col_add',30),(66,'2022_07_21_054008_pass_reset_table_col_add1',30),(67,'2022_07_21_104205_add_booking_id_col',31),(68,'2022_07_24_051517_add_cus_col_in_review',32),(69,'2022_07_31_093836_create_channel_lists_table',33),(70,'2022_07_31_093916_create_channel_users_table',33),(71,'2022_07_31_094036_create_channel_conversations_table',33),(72,'2022_07_31_104246_create_conversation_files_table',33),(73,'2022_07_31_113436_add_new_col_campaign',33),(74,'2022_08_02_054322_update_col_type',34),(75,'2022_08_06_031433_add_col_in_booking_table',35),(76,'2022_08_06_031649_add_col_in_booking_details_table',35),(77,'2022_08_06_045001_remove_col_from_user',36),(78,'2022_08_21_031258_add_col_to_channel_list',37),(79,'2022_08_21_033729_add_col_to_channel_user_table',37),(80,'2022_08_23_060744_col_add_to_tnx_table',38),(81,'2022_08_28_044249_col_change_to_business_settings_table',39),(82,'2022_08_31_070329_col_add_to_booking_details_table',40),(83,'2022_09_01_135800_create_user_verifications_table',41),(84,'2022_09_12_062925_col_add_to_booking_table',42),(85,'2022_09_17_185044_add_col_to_bank_destails',43),(86,'2022_09_21_235326_col_add_to_withdraw_requests_table',44),(87,'2022_10_03_175305_add_zone_id_in_address',44),(88,'2022_11_21_175412_add_col_to_withdraw_requests_table',45),(89,'2022_11_21_230747_create_withdrawal_methods_table',45),(90,'2022_11_29_232809_create_booking_details_amounts_table',45),(91,'2022_12_05_184417_col_add_to_services_table',45),(92,'2022_12_06_002432_create_recent_views_table',45),(93,'2022_12_08_201359_create_recent_searches_table',45),(94,'2022_12_26_115139_add_col_to_accounts_table',45),(95,'2023_01_16_152849_add_col_to_booking_details_amounts_table',45),(96,'2023_01_24_230519_add_col_to_users_table',46),(97,'2023_01_25_195038_add_col_to_transactions_table',46),(98,'2023_01_26_174101_Create_loyalty_point_transactions_table',46),(99,'2023_01_27_001826_add_col_to_categories_table',46),(100,'2023_01_29_011739_create_tags_table',46),(101,'2023_01_29_162753_create_table_service_tag',46),(102,'2023_02_02_231012_create_service_requests_table',46),(103,'2023_02_05_200352_create_added_to_carts_table',46),(104,'2023_02_05_214409_create_visited_services_table',46),(105,'2023_02_05_225314_create_searched_data_table',46),(106,'2023_02_08_174014_add_provider_id_to_carts_table',46),(107,'2023_04_29_185100_create_posts_table',47),(108,'2023_04_29_185107_create_post_additional_instructions_table',47),(109,'2023_04_29_185114_create_post_bids_table',47),(110,'2023_04_29_185127_create_ignored_posts_table',47),(111,'2023_05_08_161525_add_col_to_services_table',47),(112,'2023_05_16_130004_add_col_to_providers_table',47),(113,'2023_05_16_231127_create_coupon_customers_table',47),(115,'2023_05_21_095745_add_col_to_users_table',47),(116,'2023_05_21_101102_add_col_to_user_verifications_table',47),(117,'2023_05_29_184809_add_col_to_posts_table',48),(118,'2023_05_30_102205_add_additional_charge_col_to_bookings_table',48),(119,'2023_05_31_103005_add_col_to_bookings_table',49),(120,'2023_05_17_144146_add_col_to_posts_table',50),(121,'2023_06_11_221500_add_removed_coupon_amount_col_in_booking_table',51),(122,'2023_06_26_154947_add_column_to_bookings_table',51),(123,'2023_07_12_105915_add_is_guest_column_to_carts_table',51),(124,'2023_07_12_105941_add_is_guest_column_to_added_to_carts_table',51),(125,'2023_07_12_110032_add_is_guest_column_to_bookings_table',51),(126,'2023_07_13_094305_add_is_guest_column_to_transactions_table',51),(127,'2023_07_13_094337_add_is_guest_column_to_booking_schedule_histories_table',51),(128,'2023_07_13_094413_add_is_guest_column_to_booking_status_histories_table',51),(129,'2023_07_13_105419_create_guests_table',51),(130,'2023_07_13_180332_add_is_guest_column_to_added_to_user_addresses_table',51),(131,'2023_07_17_142048_add_is_verified_col_to_bookings_table',51),(132,'2023_07_17_184044_add_is_guest_col_to_posts_table',51),(133,'2023_07_19_111811_add_house_and_street_col_in_user_addresses_table',51),(134,'2023_07_29_133252_create_booking_partial_payments_table',51),(135,'2023_08_06_152659_create_offline_payments_table',51),(136,'2023_08_07_153312_create_booking_offline_payments_table',51),(137,'2023_08_08_094402_create_bonuses_table',51),(138,'2023_08_10_182955_add_fee_column_to_bookings_table',51),(139,'2023_08_24_132317_create_provider_settings_table',51),(140,'2023_10_31_171211_create_translations_table',52),(141,'2023_11_07_182712_create_landing_page_features_table',52),(142,'2023_11_08_092558_create_landing_page_specialities_table',52),(143,'2023_11_08_094847_create_landing_page_testimonials_table',52),(144,'2023_11_08_174249_add_current_language_to_users_table',52),(145,'2023_11_08_174418_add_current_language_to_guests_table',52),(146,'2023_11_16_110101_create_data_settings_table',52),(147,'2023_11_19_112426_add_is_suspended_col_to_providers_table',52),(148,'2023_11_19_155434_add_soft_deletes_to_providers_table',52),(149,'2023_12_20_135725_add_service_availability_to_providers_table',53),(150,'2024_01_28_080833_create_booking_additional_information_table',54),(151,'2024_01_29_115651_create_post_additional_information_table',54),(152,'2024_02_10_183058_rename_file_name_col_to_conversation_files_table',54),(153,'2024_02_10_184243_add_original_file_name_col_to_conversation_files_table',54),(154,'2024_02_15_143856_make_col_nullable_to_service_requests_table',54),(155,'2024_02_29_140738_add_col_to_booking_offline_payments_table',54),(156,'2024_03_20_053908_create_favorite_providers_table',55),(157,'2024_03_20_134756_create_favorite_services_table',55),(158,'2024_03_27_102042_add_total_referral_discount_amount_to_bookings_table',55),(159,'2024_04_02_102509_create_push_notification_users_table',55),(160,'2024_04_22_132349_create_advertisements_table',55),(161,'2024_04_22_134754_create_advertisement_attachments_table',55),(162,'2024_04_22_181536_create_advertisement_notes_table',55),(163,'2024_04_25_160923_create_advertisement_settings_table',55),(164,'2024_04_29_133239_create_role_accesses_table',55),(165,'2024_04_29_135809_create_role_sections_table',55),(166,'2024_05_02_114745_create_employee_role_sections_table',55),(167,'2024_05_02_114900_create_employee_role_accesses_table',55),(168,'2024_05_09_141125_drop_col_form_roles_tabel',55),(169,'2024_05_09_142158_drop_col_form_employee_role_section_tabel',55),(170,'2024_05_09_142555_drop_role_modules_tabel',55),(171,'2024_05_09_142749_drop_user_roles_tabel',55),(172,'2024_05_09_143102_drop_role_section_tabel',55),(173,'2024_05_13_112445_add_is_updated_to_advertisements_table',55),(174,'2024_05_13_155906_add_to_col_role_accesses_tabel',55),(175,'2024_05_13_162125_add_to_col_employee_role_accesses_tabel',55),(176,'2024_05_21_105847_create_subscription_packages_table',56),(177,'2024_05_21_105930_create_subscription_package_features_table',56),(178,'2024_05_21_105958_create_subscription_package_limits_table',56),(179,'2024_05_22_152625_create_storages_table',56),(180,'2024_05_26_100825_create_package_subscribers_table',56),(181,'2024_05_26_100851_create_package_subscriber_features_table',56),(182,'2024_05_26_100918_create_package_subscriber_limits_table',56),(183,'2024_05_28_170817_create_package_subscriber_logs_table',56),(184,'2024_06_02_173558_add_to_col_package_subscriber_table',56),(185,'2024_06_04_142029_rename_col_package_subscriber_features_tabel',56),(186,'2024_06_06_160149_add_to_col_transaction_id_to_package_subscriber_logs_tabel',56),(187,'2024_06_11_115322_add_to_col_package_subscription_tabel',56),(188,'2024_06_12_152132_add_is_notified_in_package_subscribers',56),(189,'2024_06_25_113732_create_subscription_booking_types_table',56),(190,'2024_07_11_130225_create_subscription_subscriber_bookings_table',57),(191,'2024_08_01_085757_create_login_setups_table',58),(192,'2024_08_04_171331_create_notification_setups_table',58),(193,'2024_08_06_204700_create_provider_notification_setups_table',58),(194,'2024_09_02_131527_create_review_replies_table',59),(195,'2024_09_02_132320_add_to_col_readable_id_in_review_table',59),(196,'2024_09_05_173819_create_seo_settings_table',59),(197,'2024_09_07_132218_create_error_logs_table',59),(198,'2024_09_21_145743_create_cron_jobs_table',59),(199,'2024_09_25_133132_add_to_col_cron_jobs_table',59),(200,'2024_10_17_123023_create_booking_repeats_table',60),(201,'2024_10_19_103658_add_to_col_bookings_table',60),(202,'2024_10_19_133157_create_booking_repeat_details_table',60),(203,'2024_10_21_141011_add_to_col_carts_table',60),(204,'2024_10_21_174902_add_to_col_booking_details_amounts_table',60),(205,'2024_10_22_115400_add_to_col_booking_schedule_histories_table',60),(206,'2024_10_22_115502_add_to_col_booking_status_histories_table',60),(207,'2024_10_24_160708_create_booking_ignores_table',60),(208,'2024_11_02_114859_create_booking_repeat_histories_table',60),(209,'2024_11_10_113216_add_to_col_transactions_table',60),(210,'2024_12_29_151439_add_payment_status_and_denied_note_to_booking_offline_payments_table',61),(211,'2025_03_04_142506_create_subscribe_newsletters_table',62),(212,'2025_03_08_135235_change_column_type_in_user_verifications_table',62),(213,'2025_03_10_122542_add_service_location_in_booking_table',62),(214,'2025_03_16_122656_create_route_search_histories_table',62),(215,'2025_03_18_112120_add_col_to_booking_repeats_table',62),(216,'2025_03_18_120858_add_col_to_bookings_table',62),(217,'2025_07_10_124538_create_business_page_settings_table',63),(218,'2025_07_14_200727_create_settings_tutorials_table',63),(219,'2025_07_15_153339_create_providers_withdraw_methods_data_table',63),(220,'2025_07_22_145850_add_cover_image_in_providers_table',63),(221,'2025_07_26_161742_add_key_type_column_in_notification_setups_table',63),(222,'2025_08_20_102246_add_response_to_route_search_histories_table',63),(223,'2025_09_03_172258_create_ai_settings_table',64),(224,'2025_09_03_202802_create_ai_setting_logs_table',64),(225,'2026_01_13_125810_add_slug_col_to_categories_table',65),(226,'2026_01_14_161318_add_slug_col_to_services_table',65),(227,'2025_09_13_000001_add_location_columns_to_users_table',66),(228,'2026_09_17_000001_add_gallery_to_services_table',67),(229,'2026_09_22_000001_add_auto_assign_to_providers_table',68),(230,'2026_09_22_000002_create_provider_booking_timers_table',68),(231,'2026_09_22_000003_add_auto_assign_to_bookings_table',68),(232,'2026_09_22_000004_add_auto_assign_to_booking_repeats_table',68),(233,'2026_09_22_000005_add_serviceman_auto_assign_to_bookings_table',68),(234,'2026_09_24_000001_add_single_provider_to_services_table',69),(235,'2026_10_02_000001_create_booking_servicemen_table',70),(236,'2026_10_02_000002_add_assignment_mode_to_bookings_table',70),(238,'2026_10_02_000003_add_zone_to_subscribed_services_table',71),(239,'2026_10_03_000001_add_category_assignment_mode_to_providers',72),(240,'2026_10_02_000004_remove_unique_constraint',73),(241,'2026_10_02_000005_add_subscription_required_to_providers_table',74),(242,'2026_10_03_000001_add_independent_commission_to_providers',74),(243,'2026_10_03_000004_add_unique_constraints',75),(244,'2026_10_03_000005_add_assign_type_to_subscribed_services_table',75),(245,'2026_10_03_000010_add_provider_service_columns_to_services_table',75),(246,'2026_10_03_000011_create_provider_service_requests_table',76),(247,'2026_10_03_000020_add_service_permission_to_providers_table',77),(248,'2026_10_03_000021_add_service_approval_required_to_providers_table',77),(249,'2026_10_03_000022_create_provider_category_requests_table',77),(250,'2026_10_04_000001_create_booking_rechecks_table',77),(251,'2026_10_04_000001_add_provider_search_radius_to_zones_table',78),(252,'2026_10_04_000002_add_max_search_radius_to_zones_table',79),(253,'2026_10_05_add_provider_booking_fee',80),(254,'2026_10_06_000001_add_custom_fees_to_providers',81),(255,'2024_01_15_create_search_radius_settings_table',82),(256,'2026_10_06_000001_create_calls_table',82),(257,'2026_10_06_000002_add_calling_enabled_to_providers',82),(258,'2026_10_10_000001_add_serviceman_assign_customer_notified_to_bookings_table',83),(259,'2026_10_10_000001_add_is_on_duty_to_servicemen_table',84),(260,'2026_10_11_000001_add_start_otp_and_extra_services_to_bookings_table',85),(261,'2026_10_11_000002_add_performance_indexes',86),(262,'2026_10_12_000001_add_cover_media_to_services_table',87),(263,'2026_10_12_000001_add_unsatisfied_window_to_providers_table',88),(264,'2026_10_12_000001_create_unsatisfied_requests_table',88),(265,'2026_10_12_000001_add_preferred_serviceman_id_to_bookings_table',89),(266,'2026_10_12_000002_add_cover_media_toggle_to_services_table',999),(267,'2026_10_13_000001_add_users_lookup_indexes',1000),(268,'2026_10_13_000002_create_failed_jobs_table',1001),(269,'2026_10_14_000001_add_serviceman_assign_provider_notified_to_bookings_table',1002),(270,'2026_10_16_000001_add_no_repeat_request_to_servicemen_table',1003),(271,'2026_10_16_000002_add_cancel_reassign_to_providers_and_bookings',1004),(272,'2026_10_16_000001_add_serviceman_id_to_reviews_table',1005),(273,'2026_10_17_000001_create_provider_registration_requests_table',1006),(274,'2026_10_17_000002_drop_unique_zone_constraints_from_subscribed_services',1007),(275,'2026_10_17_000003_create_serviceman_categories_table',1008),(276,'2026_10_21_000001_add_auto_reassign_on_cancel_to_providers_table',1009);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `module_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module_display_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_setups`
--

DROP TABLE IF EXISTS `notification_setups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_setups` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `key_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_setups`
--

LOCK TABLES `notification_setups` WRITE;
/*!40000 ALTER TABLE `notification_setups` DISABLE KEYS */;
INSERT INTO `notification_setups` VALUES ('10b69552-ad4f-45ed-9b90-5cf6a4faa567','provider','Terms & Conditions','Choose how the provider will get notified of Terms & Conditions Update by the admin','terms_&_conditions_update','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','business_page'),('13af7141-50e0-49f7-9f5d-4817868f7b74','provider','Verification','Choose how the provider will get notified of Email/Phone Verification and password recovery OTP sent via Email/Phone','verification','{\"email\":1,\"notification\":null,\"sms\":1}','2024-08-25 14:24:01','2025-08-23 16:10:54','authentication'),('2a3c95eb-7a13-4a8a-8557-1a57b3e678c0','user','Refer & earn','Choose how the customer will get notified of refer code use, first booking completion, and get cashback as a reward','refer_earn','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','wallet'),('32aa144f-0d86-43c8-93d4-8c649ef0ae30','provider','System Update','Choose how the provider will get notified of System Updates by the admin','system_update','{\"email\":1,\"notification\":null,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','system'),('3b56cfeb-7e9b-454f-8fad-813fb255b6d7','provider','Transaction','Choose how the provider will get notified of suspend on exceeding cash in hand balance','transaction','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','transaction'),('3c1757b1-21fd-42ab-9371-71a9ed4c27a6','user','Verification','Choose how the customer will get notified of Email/Phone Verification and password recovery OTP sent via Email/Phone','verification','{\"email\":1,\"notification\":null,\"sms\":1}','2024-08-25 14:24:01','2025-08-23 16:10:54','authentication'),('525804e0-4985-4ff5-8d14-dc12c72636c5','user','Privacy policy update','Choose how the customer will get notified of Privacy policy updates by the admin','privacy_policy_update','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','business_page'),('55e98f67-b05c-4419-9ba7-fd2451b346cb','user','Loyalty point','Choose how the customer will get notified of earning loyalty points as a reward','loyality_point','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','wallet'),('57afaffe-b68d-48ed-9494-a7af0000620c','provider','Booking','Choose how the providers will get notified of new bookings, Booking Edits, Booking Status updates, Schedule time changes, and withdrawal request','booking','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','booking'),('59c019e4-1f65-42e3-a1ec-ff1b0e7ae408','user','Wallet','Choose how the customer will get notified of getting a bonus & Wallet balance from admin or add funds by himself','wallet','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','wallet'),('628c0ac6-9339-48de-8ea7-03ee57333fca','serviceman','Booking','Choose how the serviceman will get notified of new booking assign, Booking Edits, Booking Status updates, Schedule time changes','booking','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','booking'),('64b779e6-835d-429c-9ad3-854e5b504385','user','Chatting','Choose how the customer will get notified of message reply, attachment received','chatting','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','message'),('69545df6-cf1a-4021-84b3-be6ed84bd294','provider','Registration','Choose how the provider will get notified of new registration approval or deny','registration','{\"email\":1,\"notification\":null,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','registration'),('8754b5d8-00a7-4926-bf4e-c993c84162ce','user','Terms & Conditions','Choose how the customer will get notified of Terms & Conditions Update by the admin','terms_&_conditions_update','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','business_page'),('8dd14f5b-331a-4b84-8721-f3d26e8d7c18','provider','Subscription','Choose how the provider will get notified of the Subscription plan subscribe, shifted, renewed, canceled & updated.','subscription','{\"email\":1,\"notification\":null,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','subscription'),('8fe761a7-7201-4942-9bf5-2797f22e37d2','user','Registration','Choose how the customer will get notified when the admin registers the customer to the system','registration','{\"email\":1,\"notification\":null,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','registration'),('9090438b-a017-4175-a97a-cc969c8c4f27','provider','Chatting','Choose how the provider will get notified of message reply, attachment received','chatting','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','message'),('9a074e1a-e3b3-4b8f-b7c4-2cc142e66170','serviceman','Verification','Choose how the serviceman will get notified of password recovery OTP sent via Email/Phone','verification','{\"email\":1,\"notification\":null,\"sms\":1}','2024-08-25 14:24:01','2025-08-23 16:10:54','authentication'),('a094b687-cafb-47d2-855e-8ec70f87aa67','provider','Advertisement','Choose how the provider will get notified of advertisement requests accept, deny, run ads, expire ads, etc.','advertisement','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','advertisement'),('b01ecf87-2912-4227-90c5-9a99c4f632db','serviceman','Privacy policy update','Choose how the serviceman  will get notified of Privacy policy updates by the admin','privacy_policy_update','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','business_page'),('d9e4cc60-afe8-4160-b536-9eecda300b92','serviceman','Terms & Conditions Update','Choose how the serviceman will get notified of Terms & Conditions Update by the admin','terms_&_conditions_update','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','business_page'),('ed11392c-cbba-468e-aeec-a6fdc28f1f5c','provider','Privacy policy update','Choose how the provider will get notified of Privacy policy updates by the admin','privacy_policy_update','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','business_page'),('edaadfd7-864e-4070-a71f-527f676df127','serviceman','Chatting','Choose how the serviceman will get notified of message reply, attachment received','chatting','{\"email\":null,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','message'),('f2e260a1-325b-4471-af26-cdc7cb43f899','user','Booking','Choose how the customer will get notified of all the bookings they placed in the system','booking','{\"email\":1,\"notification\":1,\"sms\":null}','2024-08-25 14:24:01','2025-08-23 16:10:54','booking');
/*!40000 ALTER TABLE `notification_setups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('0032a5c7d9946202f06e1bd59459347a58133f8ff3d8bb25486226d3476ceff7a5925fe32cc52446','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-11 19:04:16','2026-10-11 19:04:17','2027-10-11 19:04:16'),('0331a75eb346b7a8c8d69d0dc3153bab74a988d3c5c63d9e31be764dfa78fe36be825d7adb388268','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-30 20:22:40','2026-09-30 20:22:40','2027-09-30 20:22:40'),('044b4b670066956d25226d09713de17c730596be1767a9dd876043367b4342d8e0beef725ed46397','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-15 15:45:22','2026-10-15 15:45:22','2027-10-15 15:45:22'),('06a629119db05da4aeafa72d4b679731282ab7e5ac0a6a0d1939fcf898082b3f9e58671122d3c8c3','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-09-30 19:59:17','2026-09-30 19:59:17','2027-09-30 19:59:17'),('0761c7b2fe0e5e606fbd5928ad2b5a5320e9e93c6d8f0407374cb9285421c120adac5690abffc38e','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','flowtest','[]',0,'2026-10-14 13:31:34','2026-10-14 13:31:34','2027-10-14 13:31:34'),('0ae1d861cf5bdb9de168b5e991bf7cddb7714ef2c811fcf29e4c7d9f34b54a3a1a9ee56fb1d19504','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:54:22','2026-10-14 10:54:22','2027-10-14 10:54:22'),('0c73e33b9b6db5a229eadb8b3618480aa63f3b19c8d12cd17f86746eecd0d65c650e9822526f9987','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','api-test-s','[]',0,'2026-10-16 15:00:01','2026-10-16 15:00:01','2027-10-16 15:00:01'),('0eea96dc12ee860bcfd0c08657c26537d1aca8477b9f0c3c13e66045b15a6ca50965836bdd3300ce','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','d3','[]',0,'2026-10-13 15:41:37','2026-10-13 15:41:37','2027-10-13 15:41:37'),('11b9aa6c6ac12f51f0b8dd7b02268dfa2a95954bf82a66ce543b356b8fb5af3ea4de1313c6d9cb5b','3bd529e7-16ec-4e40-84fa-ca0306faa7f6','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-25 18:41:13','2026-09-25 18:41:13','2027-09-25 18:41:13'),('13cd3b028c1f46bbf4cf8953d66c42d953668c8bfe11f46174a95efe7292b2de5e183447ac2d14ce','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-03 20:27:41','2026-10-03 20:27:41','2027-10-03 20:27:41'),('172171fa22de625713f380fad06812f7247bc1ac587b3c09d6af8b01f7775f09e92417ed6863e578','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:37:45','2026-10-14 10:37:45','2027-10-14 10:37:45'),('17286a4ef7e323f372174eaa7d670c43d2560a1c9a07e9fe4f07c95069ce59cbff30196792b846aa','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','smoke','[]',0,'2026-10-13 15:03:27','2026-10-13 15:03:27','2027-10-13 15:03:27'),('1812d7d9cac6f9a8d14e3fe79212fc837230ee5d4d079f784dbf25666ca6cfe76f17be46cc2afb23','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','inv-test','[]',0,'2026-10-27 13:01:27','2026-10-27 13:01:27','2027-10-27 13:01:27'),('184ab78b3129e8c595f011b36ac3160d159fe5ff4b91eaa625cc9bf6b9146cc3d150cb4aa0657ae4','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','smoke-c2','[]',0,'2026-10-13 15:34:11','2026-10-13 15:34:11','2027-10-13 15:34:11'),('1ccc075efbd1e0f1a1219bed009f33ea724bef8a5a18150e52f56dd74900680ab209c82e0d4dc6cf','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-21 23:36:06','2026-09-21 23:36:07','2027-09-21 23:36:06'),('1d24c933e6267c15e02ee0ee4b9620f5c32a81517bab5b4e1715374776924915392383f27414a772','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-18 18:34:54','2026-10-18 18:34:54','2027-10-18 18:34:54'),('1d510aa99f46503754cf0951b96d0d463918e25a9aa4bc3024517bf17d3199288702760f92ac8f79','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','flowtest','[]',0,'2026-10-14 13:31:12','2026-10-14 13:31:13','2027-10-14 13:31:12'),('1d62a2d2ec37d6234293e97321878dd9e3f6123d2ccfa5a2346764dfd53d2b89951d06907d169267','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','invoice-test','[]',0,'2026-10-27 12:42:03','2026-10-27 12:42:03','2027-10-27 12:42:03'),('1e884f14703b1a46d543190f762b6443f883183710642141715676c0fe51e642a69ab339c9d88a4c','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','perf','[]',0,'2026-10-03 22:54:41','2026-10-03 22:54:41','2027-10-03 22:54:41'),('1ea57b758275417c63fd70d77ce80acb7274da46fed51797cabc674189c4a0321876086dbb7ad3fa','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-02 22:14:22','2026-10-02 22:14:22','2027-10-02 22:14:22'),('1ea652500b1a46ca034f83d84c4a1c98402ec8273ed75b5e7bc60dd946d73ab48f200837a4532613','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-02 22:27:52','2026-10-02 22:27:53','2027-10-02 22:27:52'),('1eceaff5f49ab10c4c5dd7093b4a0a5468c221d219898bf2f7be95e9fb3435085b3fbd1fce976b6a','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-18 23:32:00','2026-09-18 23:32:01','2027-09-18 23:32:00'),('1eddbe32b20564e597982f725c99fe18d312aa18bb30e095b1f9ccce1a5fa9f6078d57d5d2a039e8','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-22 18:13:22','2026-10-22 18:13:22','2027-10-22 18:13:22'),('21107ad036c52ae7422089259e9315298b94fdb98f4080fd5f5711d19a878494b3a42ce0ff874980','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-01 23:01:00','2026-10-01 23:01:00','2027-10-01 23:01:00'),('21f4f2eceab0088ed84f3060227d6a184aa5e9a865a01b6569d9ed952898c36ed9c4e39a9e394abc','sman-0001-0001-0001-000000000007','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',1,'2026-10-19 12:40:25','2026-10-19 12:40:25','2027-10-19 12:40:25'),('22fbc22bbe06d58c787054660a88b3e47c673543c6f2d7394722677bae349ddc86a85e6c6377f56c','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','tp2','[]',0,'2026-10-16 15:03:25','2026-10-16 15:03:25','2027-10-16 15:03:25'),('23dd21a4a35cad36379f46bf8567184a584a45efeebbcceef4f2c8d8f813d97238a720ef2b6c660d','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','e2e-test','[]',0,'2026-10-12 16:31:11','2026-10-12 16:31:12','2027-10-12 16:31:11'),('26384918c5bf1496536c6682a8023cfb645ca199ca77432715813964de95754455d6e153cb8c70e9','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','tc2','[]',0,'2026-10-16 15:03:28','2026-10-16 15:03:28','2027-10-16 15:03:28'),('27b0720e8b2c11cebead6eed9c8f99b6d01d0c05dfd23f499e2ecb4822c4b9aff61e9fc8e195cca6','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','tc3','[]',0,'2026-10-16 15:03:49','2026-10-16 15:03:49','2027-10-16 15:03:49'),('2a61ac3cb4def83bb65ffd809de32b03b2fc248b36ee9fe065c3b3e39515f07fd34b531c5664a53a','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','api-test','[]',0,'2026-10-03 22:52:35','2026-10-03 22:52:35','2027-10-03 22:52:35'),('2a8c29a5c148a203834af3ac35b82839efaf6b83f445453ef453e076f5794a9af60f1766cb2fadf8','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','fts1','[]',0,'2026-10-16 15:54:51','2026-10-16 15:54:51','2027-10-16 15:54:51'),('2b903d512cd13cba2220cfa7dd8cabf85f1752f60c000bc4e2132f39e3e62b50386763b82a963970','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','ftc1','[]',0,'2026-10-16 15:54:53','2026-10-16 15:54:53','2027-10-16 15:54:53'),('2e570e6238670cb068c4e93a6d6406bcb281767cb40fd07af18a3c3db2559546b5bbef3514f73e6e','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-09-22 23:01:19','2026-09-22 23:01:19','2027-09-22 23:01:19'),('307b7502f8932741f033e7e008347685432af2042efbccec6edb4d360f9e97387abb04b5d7b6f7ba','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-02 22:30:51','2026-10-02 22:30:51','2027-10-02 22:30:51'),('323696e4e168a5f5b7c6ac547a0118e129bcb2c73c7b9c8a58c594cad55e83f6e5684539289ced7f','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',1,'2026-09-14 02:08:43','2026-09-14 06:10:31','2027-09-14 02:08:43'),('337bccf7d7fe4968a0088ece7a688f303c9f18dc75a6db127c46ac1dfa881b8e43978722f63799d4','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-12 17:20:46','2026-10-12 17:20:47','2027-10-12 17:20:46'),('343d0ad5a767e9c37dae967b2ca06222b57a47d6dd758ee69385274e6656e6af41fe727cc6981178','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','zp-test','[]',0,'2026-10-22 17:38:56','2026-10-22 17:38:57','2027-10-22 17:38:56'),('3474ad90637d8c819d2847cd583ad266afcda964b391b075a36ec289ed90b42673c3eb47949c5d77','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-04 23:00:36','2026-10-04 23:00:36','2027-10-04 23:00:36'),('3838dc95c0c995d47730904418fbe6fb22585629a9aaacaf4fd16a916724ebc807ef371e1fe399d7','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-09-17 20:12:22','2026-09-17 20:12:23','2027-09-17 20:12:22'),('38fe05a512b298be98bccfa396786d6b4607b44dc0fdbadaeeabb10d704d6bf9498923d61c38991c','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-09-26 21:18:44','2026-09-26 21:18:44','2027-09-26 21:18:44'),('3a27ed3860344a30f65424e7f70dc46580ab96c554cb6260895b8096852b56c09e2efaec951510e3','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-18 19:22:24','2026-10-18 19:22:24','2027-10-18 19:22:24'),('3c1a578acd961db46790228bf2df1eae30587211e488af6485bc03c0231073160980cc23556c5059','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','inv-test','[]',0,'2026-10-27 13:01:27','2026-10-27 13:01:27','2027-10-27 13:01:27'),('3caec367615a7c558e396073940fff77207a54f9a2ec832869b0f0ab2d1fec7a8e9b5b10612c9a3d','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','flowtest','[]',0,'2026-10-14 13:31:34','2026-10-14 13:31:34','2027-10-14 13:31:34'),('3dcf01e675cbc620d5b77c20e9a3bd869c0fd070ad63d1c4f5597efb28e9e377a238d17604180810','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-09-24 01:04:19','2026-09-24 01:04:19','2027-09-24 01:04:19'),('41355531bc3c8ae2e9975bc1730b2f21204e95e25386c03c53c8475b3f1c8e0cae77e26d3d3929f4','prvd-0001-0001-0001-000000000002','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-02 18:43:27','2026-10-02 18:43:27','2027-10-02 18:43:27'),('4279c23aac1083a8567c84efca4624bc13abbcdb5cdd61ef288c620000865f4976896343199a569f','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-02 18:28:55','2026-10-02 18:28:55','2027-10-02 18:28:55'),('42b807e14dba940fff8c07e375f3e271de5fcdc998fd5372c87f3f08bf407c2a6139ab9d88119c8f','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-02 22:17:30','2026-10-02 22:17:30','2027-10-02 22:17:30'),('49e20b39551bdfaa3b20bf737256e83f304048ff6823e2c12e4d8c815cff2daeab88b59237df2d27','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-18 18:23:03','2026-10-18 18:23:03','2027-10-18 18:23:03'),('49f9dea9cb283c8409e09d22ac32f3697beada1e96c041ae3ad454dfc86a453af991cd9cda4868aa','sman-0001-0001-0001-000000000007','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',1,'2026-10-19 12:44:08','2026-10-19 12:44:08','2027-10-19 12:44:08'),('4dc7a970a3e07f714383cedd3598031e6e3f8ae8ba3d29d6ebbdc539e42c0315ded65e28b1ea792a','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','flowtest','[]',0,'2026-10-14 13:31:14','2026-10-14 13:31:15','2027-10-14 13:31:14'),('4eb0465805186321324b31224085b8a036ce2cd997b3620d238b69939dbcedecf363d4fe4a687883','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','smoke-c','[]',0,'2026-10-13 15:30:53','2026-10-13 15:30:53','2027-10-13 15:30:53'),('4ff4746c3dda8fb423a695d4f976d867c22b51f7a2a06f8bf6034788a2353221fd7946572051bf70','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-19 00:27:35','2026-09-19 00:27:35','2027-09-19 00:27:35'),('549d04b8134c80a0f9092f5b9f3039c38411c6e83b0fb09b30d30aae8f6ebd0543b98f00766359b4','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-09-17 20:12:31','2026-09-17 20:12:31','2027-09-17 20:12:31'),('54ac4eda22552140505a86cdbf8a8782feb7cf4c973c9f7692f3d15195fa3b7274e70c55b2c4b822','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','assign-test','[]',0,'2026-10-07 14:18:53','2026-10-07 14:18:53','2027-10-07 14:18:53'),('5659bd15e6959f24a295d6f732a54d2aa9f5bbc8d6fb14de97605d9216cc41e697d8e06281141b75','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-02 18:23:29','2026-10-02 18:23:29','2027-10-02 18:23:29'),('56ebb455ccc7baa4bced9e519be268905e9b76a8cbf6456bbc31b8ca5692e6d5719ed3733b4b3e72','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','d3','[]',0,'2026-10-13 15:41:57','2026-10-13 15:41:57','2027-10-13 15:41:57'),('5720284631384d57db83a1dc573d8c14f26e3088757f766944d6457a1ce54572719c3c81b90b2749','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:38:28','2026-10-14 10:38:28','2027-10-14 10:38:28'),('5acd52e3cc4cbbfee320d939447327dcca4e29b50673f38830e92bc620a454a16d326753b0099d03','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','smoke-zonefix','[]',0,'2026-10-13 16:24:26','2026-10-13 16:24:26','2027-10-13 16:24:26'),('5d78bf80238110f6cc650dbb9dff7e3ce09c4216c4f0af1bcb10cef7799ceba701985c220c35db14','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-18 20:49:28','2026-10-18 20:49:29','2027-10-18 20:49:28'),('5fb8439c840263b2dd3f0f60d58ae6099fec291ce2c3e2cebc137d1a70793266d53ff75e94a9314c','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','final2-c','[]',0,'2026-10-13 15:43:31','2026-10-13 15:43:31','2027-10-13 15:43:31'),('603700f832c22b6b76e011feb0f029041b0c257060f2468b20a60f495c28ee2b243419d3897c5fc4','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-18 20:08:03','2026-09-18 20:08:03','2027-09-18 20:08:03'),('61ec43c8086c0ba9b5c60bf7cdec0c690a59be10a1931c4c58b6714af53afa537510ea6bdd5396f2','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','inv-test','[]',0,'2026-10-27 13:01:27','2026-10-27 13:01:27','2027-10-27 13:01:27'),('636ef999c7bfad7ed27e4e88ee4cd85d66ccec6c091cbcf25bdcc54305384e53509cf8e2708e65cb','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-09-22 22:59:35','2026-09-22 22:59:35','2027-09-22 22:59:35'),('64eb8d22abd89a37419208ba1a22a6ce7096d9c1dad43dad91156ec5f489d93e81743259f9633941','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:51:20','2026-10-14 10:51:21','2027-10-14 10:51:20'),('6530bfc8d4e094183ea44db75618407e904e66cda49fa3ba14d467d6b17fdc9ba0ba6072c83f1575','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-12 12:24:48','2026-10-12 12:24:48','2027-10-12 12:24:48'),('655881c00c68176035d5b63998e88a901c44fdb5cabd235696e34d872831aa6c35886efb5bf7943c','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:36:23','2026-10-14 10:36:23','2027-10-14 10:36:23'),('656a934b4b5c071ff8c829bcf586497d28ebbfb48054763e81ff364abaa62709e498898ea73086a3','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:38:53','2026-10-14 10:38:53','2027-10-14 10:38:53'),('6788cf6152328256cd7235932a167d0271d50526b4e3b2becd60fb4e0c39b3f42eebb43be4ce3a9e','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-09-24 19:51:23','2026-09-24 19:51:23','2027-09-24 19:51:23'),('6a7cd31d7ba9653cef1a50423dea0b311b6db40f7bfccecffa8c3d9b9fa045aa6da958b3d77b58e3','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','w12-admin-mw-test','[]',0,'2026-10-13 11:24:58','2026-10-13 11:24:58','2027-10-13 11:24:58'),('6bc6195a93c5dd16336b642ea312a6709306584839dd05fa1364cb0832fdc5a870ae5eb072e0f5dc','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-09-14 19:23:05','2026-09-14 19:23:05','2027-09-14 19:23:05'),('7156a956644f66a947f0a4ef33f80f1c1c6091d0911cb63c6c59ada5d4bd2d710e9f3e1fd41fadaa','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-22 17:21:33','2026-10-22 17:21:35','2027-10-22 17:21:33'),('7258bcb152b3fdafddf384f283e7357d37fcd8e4764ce61c0896951ce375adcd14274b36f3e66b58','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-01 18:31:04','2026-10-01 18:31:04','2027-10-01 18:31:04'),('727a878d03731e4b47d32570e79b58d5c6869d474049b67cf70ad8f2882d7e9b04196fa8b96f3548','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-09-14 01:56:39','2026-09-14 01:56:41','2027-09-14 01:56:39'),('759d93c79a9c1f9a75ab5828d3be063f851e5fdc487eed5f91f0bbce9b8a3d6776aa9d8ea877704c','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-21 22:51:35','2026-09-21 22:51:36','2027-09-21 22:51:35'),('77818831e89d857425d49d99703821cbb0943fb14d691c9a8878c94ec935ba4d1f67631bdaf0600f','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','api-test-p','[]',0,'2026-10-16 15:00:01','2026-10-16 15:00:01','2027-10-16 15:00:01'),('781dcc9134a9d0c3872e905c791f9e488e56c0772d288067a472b7069daebfb3d9727c60049d61f0','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','smoke','[]',0,'2026-10-13 15:04:01','2026-10-13 15:04:01','2027-10-13 15:04:01'),('7c3758a233f738eeb8546a7d0992019d3ab07e3426a95a3d7671002fb93477b898256d8217130974','prvd-0001-0001-0001-000000000003','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','perf','[]',1,'2026-10-03 22:54:41','2026-10-05 03:19:19','2027-10-03 22:54:41'),('7d9a8417d4275afcb452adb1f3d3d0ac6d06b441cb97aac02308e1d03ab701fefc852e59498385f7','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-03 04:36:52','2026-10-03 04:36:52','2027-10-03 04:36:52'),('7dbcbc7fe7caa234259a560706e855a467d8e7dbe6ec83c81add50576da4cb824ebae3a7035be882','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-17 12:43:14','2026-10-17 12:43:14','2027-10-17 12:43:14'),('7dedba530646ac08072d13d85b16706d711c773fe1ecb251a6462302755facdab2cab1b2d1f13b28','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-09-15 00:47:53','2026-09-15 00:47:54','2027-09-15 00:47:53'),('7ec09c1784f11e7cba91df40c82e395038f91ef28142dbaf9c29a2f0bd462eadbc5448a3c76480b5','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','test-assign','[]',0,'2026-10-07 14:14:47','2026-10-07 14:14:48','2027-10-07 14:14:47'),('7f839e8a672c11eed61e5d90e66ae84bfa3048aeafbcfeec3fba80e6024549f71c4dfed4fbcafd1b','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','invoice-cust','[]',0,'2026-10-27 12:44:55','2026-10-27 12:44:55','2027-10-27 12:44:55'),('82e348c7b10a9362c3d51a43c763663d82ed9b5ef603d903e75d456972b70b63b595667ea85e4abb','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','w12-admin-mw-test2','[]',0,'2026-10-13 11:27:24','2026-10-13 11:27:24','2027-10-13 11:27:24'),('85b6c61493df356b7b10565eab4251e34bb283b5b0495bffff44ab6e415ce1fb737f1a305288d4dd','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-17 23:44:00','2026-09-17 23:44:01','2027-09-17 23:44:00'),('85b9e65e5017ded82d4be66ad04ce459f79e557212d7bf8a690cca99199d73975d408c018955a4cc','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-09-14 19:22:53','2026-09-14 19:22:54','2027-09-14 19:22:53'),('878d7441dbb8bd12bb275a2457e6deb36bfc89914dfa74dc4c00095ad4019960b7bcc1bb3c6635f4','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','dbg4','[]',0,'2026-10-23 12:57:45','2026-10-23 12:57:45','2027-10-23 12:57:45'),('880e82acaceeca6da24c4f2682dc40ccf1effed2afced8840a7edd0dc1ab803041beaf18221da231','sman-0001-0001-0001-000000000002','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-02 22:42:49','2026-10-02 22:42:49','2027-10-02 22:42:49'),('88cdf7fa74db28eaafa9b87edd198a6ad47b24a2c9575fdc86e8e691fc06d2cc87a1739665cae641','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-21 15:34:29','2026-10-21 15:34:29','2027-10-21 15:34:29'),('8a6b09526d8172ebb9ad9a40c9f887d28e074f8f1119575e7aa04b40de35869ce62c638fc99b5b84','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-01 18:09:50','2026-10-01 18:09:50','2027-10-01 18:09:50'),('8b1651585eed25ec4ba29712e1dcb24240930d1e6b9e3fb0788d831aefddc59d8e5927fde9d185ae','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-09-22 23:51:33','2026-09-22 23:51:33','2027-09-22 23:51:33'),('8bd36558c83a0730736e1d33da14d1f68b3caea5026f830d3ef08921a3c96ddd5e8cd267e72f6b61','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-12 10:33:57','2026-10-12 10:33:57','2027-10-12 10:33:57'),('8bebdbb1c3df53f5350f1667dd9d584e38cafa4da480cdcecab8446fd41f505ea341613a7ff5aad4','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','f','[]',0,'2026-10-14 13:34:07','2026-10-14 13:34:07','2027-10-14 13:34:07'),('8de36989a47d80b0ec90a13d30a0711a33984a22325e0e4ea1138559dfedbd96fca81796aa6baacd','sman-0001-0001-0001-000000000007','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',1,'2026-10-19 12:48:05','2026-10-19 12:48:06','2027-10-19 12:48:05'),('8f1591f6fcd9eeb604fe4048b6730691b99c43c2a093a18e82e5a75aec3a0782dd5071fc2409de09','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','ts2','[]',0,'2026-10-16 15:03:27','2026-10-16 15:03:27','2027-10-16 15:03:27'),('90ca555e698266739447349f7dd0c716fa293364767b4b919b32278436c07bf7ff34a05bcc4878c8','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','flowtest','[]',0,'2026-10-14 13:31:14','2026-10-14 13:31:14','2027-10-14 13:31:14'),('916e7ce4c036df3ec1e03cdda5bd3fbc8bd8230b50f1836d4ed46ade5988f037e5b4a6747bbce859','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-26 20:59:00','2026-09-26 20:59:00','2027-09-26 20:59:00'),('9213cfcdab7145b535a32a315fb4e7f8f08bffa2a23edadccc6cb8bcd7e956b9793a7e4416e1227c','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-22 17:47:49','2026-10-22 17:47:49','2027-10-22 17:47:49'),('93baa2f99c912bad3241f085cacb36070857e69aebf988e62d80fb465dfcdbc9a4209c09055ba2d8','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-18 19:40:26','2026-09-18 19:40:26','2027-09-18 19:40:26'),('95eb1d889241fb3beb11bc13031b27e4d7ef029b110384c72d3e41ed4bbaec49a7eccdf582a2ebec','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:47:02','2026-10-14 10:47:02','2027-10-14 10:47:02'),('967a09285b6fe6e0fd2c2cd0bb7591d036284b06e9c2ef3127fec2a56bf562e5deae6ee5f1510025','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-09-26 21:18:52','2026-09-26 21:18:52','2027-09-26 21:18:52'),('99dca73f8b4891793fba7ee4007c62014d6001d4c3f5371e8a846dd8566f55400ae67113d84ee652','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-27 12:04:49','2026-10-27 12:04:49','2027-10-27 12:04:49'),('9a11cd72ca17333a54e707d1daba540fdfb60cbf33f142f3d144795281c665c8ca46e4effd3f60e4','prvd-0001-0001-0001-000000000002','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','perf','[]',0,'2026-10-03 22:54:41','2026-10-03 22:54:41','2027-10-03 22:54:41'),('9c836ba013d0e28887984dee862cafb1b7bce0c779ba1e7129c64ba1d7b54e2dbde64fa4ac9850bd','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-02 18:28:35','2026-10-02 18:28:35','2027-10-02 18:28:35'),('9df0e92277565b112a9ec4361bbe8142f8c4746f78109af0f7ee401e24d31df02aebb4af6a817af8','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:55:49','2026-10-14 10:55:49','2027-10-14 10:55:49'),('9e53d4783107e950a640593ad0b9f5c3de602371f3c951b2b7afd70babd0503ddb741d9df88fbfce','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-23 11:22:49','2026-10-23 11:22:49','2027-10-23 11:22:49'),('a2b1a180559fe947a8ef1f0f0f5fcfc151df6efba9f3e3e7a183cb75984ee6534467113b5ad9ebb7','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:38:11','2026-10-14 10:38:11','2027-10-14 10:38:11'),('a34aabaf88ff1c4a6704f2377987d1ddbade2743f03d208ca5f6cd166180a4970be66742e946f3d0','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','mx2','[]',0,'2026-10-13 15:35:14','2026-10-13 15:35:14','2027-10-13 15:35:14'),('a4ebc32db911bfc4ee07c47c926102aa296e68372ad967479abca9f0c1f92969801af563b52e4eec','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-09 17:41:15','2026-10-09 17:41:15','2027-10-09 17:41:15'),('a58b4aef8f6b44915c1bf611ff79f370a76809bbdf4d8a8b8fa5503ddbb5258f182698c00331b966','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-02 22:08:32','2026-10-02 22:08:32','2027-10-02 22:08:32'),('a65704ba7bcb07ce8f5b6c1f6a32400174ea6f06ce4654bc045b05e31b342323ad2da1bdc978ff7a','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-22 17:53:13','2026-10-22 17:53:13','2027-10-22 17:53:13'),('a7747d2df2faf41bc3582004aa55038c814942f4db94c8b29b7799300599447a5c5dff0a2455f6ac','sman-0001-0001-0001-000000000007','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',1,'2026-10-19 12:39:45','2026-10-19 12:39:46','2027-10-19 12:39:45'),('ab77de3efa8d5617c4149b7d06328f2f085ff61bb9d0a2041409a44886137ead6c0ebdb965929036','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','flowtest','[]',0,'2026-10-14 13:31:34','2026-10-14 13:31:34','2027-10-14 13:31:34'),('ab8c69e7960e97c4dea8da9363055d71a7ed3b1a9a29f78256121cc2cbf56c0fc2c70c2c52d1932d','sman-0001-0001-0001-000000000007','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',1,'2026-10-19 12:38:53','2026-10-19 12:38:53','2027-10-19 12:38:53'),('ac2587e1c387f0d15105477de559459b5063dbb615f2d5742a98d159eef02e5514aea3aa33fb7906','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','e2e-provider-test','[]',0,'2026-10-12 16:39:43','2026-10-12 16:39:43','2027-10-12 16:39:43'),('ad17ba3eac9bf83b990cf688b9bc9e4ee990589cb0eccc5587f39f81a28c8181ed8e42f21cbf0357','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-09-14 06:11:02','2026-09-14 06:11:03','2027-09-14 06:11:02'),('ad65308293976321c192ce828bb13237c1ae4f34e5e2aa28c8cb9b77546b7f145d5becafab6b1c37','sman-0001-0001-0001-000000000002','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-02 22:34:47','2026-10-02 22:34:47','2027-10-02 22:34:47'),('b188fa8244c3bdbc42533a5af1e1aa324245f45af60ffeffbbb10792bccdc82db304732d278fee7b','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-26 12:12:41','2026-10-26 12:12:41','2027-10-26 12:12:41'),('b1ca515b17791bc0e20adb0e519be98b3f56bb9a79476d05ea3f1033eac54ee9b636d444dada2199','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:38:42','2026-10-14 10:38:42','2027-10-14 10:38:42'),('b2f65407164535b2ef8c6336c3a048caddd60af7d5e5969034bc025d6a13d6222b6345403e3f91f1','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-13 17:54:54','2026-10-13 17:54:54','2027-10-13 17:54:54'),('b3d8f898b399b5346aae98d32097b9d4f33e99c810b2a327db6b71218af7d3da4fe2d6260469f3ab','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','api-test','[]',0,'2026-10-03 22:53:02','2026-10-03 22:53:02','2027-10-03 22:53:02'),('b541c1fce7230660260d32f4a3045fb0c8716c36800a5965ab916b84e08440544ca3144071907c7a','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-09 18:09:51','2026-10-09 18:09:51','2027-10-09 18:09:51'),('b89e04261a16f2057926f4bffdd34ebfbe5c9e75ad2a90dfd26771911d878f63a11dca6d9e4cff0c','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-19 00:51:48','2026-09-19 00:51:48','2027-09-19 00:51:48'),('b904654f634e5e1a38932ba2654efffde975deb0bdc1bb8ea299fdbb5b833e87dae4e433e1ab0171','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','inv-test','[]',0,'2026-10-27 13:00:29','2026-10-27 13:00:29','2027-10-27 13:00:29'),('b9b0ddd8f11868028471e82d6fa2ce9233984b2cf4994ab2cb3feef366fcf0ceb1914ca25e1b90ac','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','final2-c','[]',0,'2026-10-13 15:40:12','2026-10-13 15:40:12','2027-10-13 15:40:12'),('ba0ac934e352babf6e8c4572252df46265752d2bba5a0fd42e8058b64a62f9ae3fbf6414faa4ef00','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','d2','[]',0,'2026-10-13 15:40:43','2026-10-13 15:40:43','2027-10-13 15:40:43'),('bb8f8f3216492fa742729c81656dbb4619b314fea3bf5539604380a3002dc95c6d984096003d7758','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','smoke-zonefix','[]',0,'2026-10-13 16:25:06','2026-10-13 16:25:06','2027-10-13 16:25:06'),('bbeffc241a60b243435270b99bc60dfb27ad83ec38eeab19c27283a38302baa84ebff1222f81eac5','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','dbg2','[]',0,'2026-10-23 12:44:21','2026-10-23 12:44:21','2027-10-23 12:44:21'),('bc0009fd2f6a08f31e22e7c5d593cf0f272cdf6b9f898db4ecd4c95a213fcde2517ba7e8f0c705e6','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-30 02:26:27','2026-09-30 02:26:27','2027-09-30 02:26:27'),('bcd422a4b4cdf71ad3d34e98f04efd023d874b72953a699c2dacc4925f8b056a63fd13a4c37877fe','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-22 17:12:12','2026-10-22 17:12:12','2027-10-22 17:12:12'),('bd65d4576204eabaf2f7455280f19bd48772f6f2ed2b03b33a54bf2ab1fa2f7e8365b28e7ae0ea85','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t-p','[]',0,'2026-10-16 15:00:39','2026-10-16 15:00:39','2027-10-16 15:00:39'),('be1d2993709f698fa760b5c1de525ce005d02374ec0b5f1af940ea1f40e11df2b0bec08e8a48e947','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-18 19:40:06','2026-10-18 19:40:06','2027-10-18 19:40:06'),('bfacbcc7956e3c2ee19dbb082431de781a248404c7b1d3ce78acec97861a1d9b5dbb3e25615fb8ed','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-19 02:15:16','2026-09-19 02:15:18','2027-09-19 02:15:16'),('c0da2be4b25d0c4bcfd289b77ec9763d628977a67156c79abd58254293c71485c48cb0cf1847a196','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-18 18:22:16','2026-10-18 18:22:16','2027-10-18 18:22:16'),('c1367c4797c3d2aeaf6529eef7a64524c4ddab2b4b516de52da512b8f37df56a8fcc806be022608b','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-09-26 21:01:32','2026-09-26 21:01:32','2027-09-26 21:01:32'),('c18903387a2ee56f51ac47fc4593b79a14432ffb271b042696307368a301cb515f4ed0c873b41586','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','d1','[]',0,'2026-10-13 15:37:17','2026-10-13 15:37:17','2027-10-13 15:37:17'),('c35a40ceb0bc96cced41070a0f04f99d6636fe214c1fa5845c2cb7f7e0c5a1223b1510c41720df9a','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-09-17 20:12:31','2026-09-17 20:12:31','2027-09-17 20:12:31'),('c3c144fd717729177c76be5493191a5eaaa76755f70fff5e50d262ce3357ddc7bd1c6d40388410c9','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','ftp1','[]',0,'2026-10-16 15:54:50','2026-10-16 15:54:50','2027-10-16 15:54:50'),('c5c0fb1ff7a8fa1cd11a45f2ffd3068a089b8ff134d5e774894062b648fef9b410c39604e951e110','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-22 17:59:55','2026-09-22 17:59:55','2027-09-22 17:59:55'),('c6f160e42775f4293a43bf3e5aebd11851b6d9f439f067cc68be757ee07f4c1ae1b468d9f47a9c53','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','invoice-test-4','[]',0,'2026-10-27 12:44:14','2026-10-27 12:44:14','2027-10-27 12:44:14'),('c7a56bae6ed46206385dbf42b8dafbfe4d54b244df5af62bd1fb6e1db1c47ff505b1bf54cbe44ec8','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-30 22:54:51','2026-09-30 22:54:51','2027-09-30 22:54:51'),('c8de0a14f7806089f471e56dd5eab904a20f1ced5566095de911c8a4622d66fa2ab429a4bc556190','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-22 17:58:31','2026-10-22 17:58:31','2027-10-22 17:58:31'),('cc2613f91287c45ee95b6addfabd9a6f4cb610c2e5baabd62ad80eaf4732e44dcd4afa9ade89956a','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-02 22:08:49','2026-10-02 22:08:49','2027-10-02 22:08:49'),('cfe746f7a28a908c89fb36e6281e6fe39cc8b4c5abb17d55ecb4542d855e328a3f42ea01f328a495','prvd-0001-0001-0001-000000000003','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',1,'2026-10-02 18:45:04','2026-10-05 03:19:19','2027-10-02 18:45:04'),('d1c32caefc15561d63c39c9d4ba03e1a374bff92931c3c378042201c6b4693fda8d3841e528190b9','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-12 10:34:42','2026-10-12 10:34:42','2027-10-12 10:34:42'),('d29300738df1c9d546844267b8e0f9739f8e52e112ac1dc56ee75ee459aa8bcf228b67070ed70c45','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-18 18:18:05','2026-10-18 18:18:05','2027-10-18 18:18:05'),('d3b79f1c07bb0259dedfedcdfd2af488fd501379ec3c7b09540586e94de72eec49f6a413c183a667','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','inv-test','[]',0,'2026-10-27 13:00:29','2026-10-27 13:00:29','2027-10-27 13:00:29'),('d3c48849895a1edcfcd7ad13e47d08539d542009e0990f30fdce75d6b2b75c7d96f831e661f70d25','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:43:50','2026-10-14 10:43:50','2027-10-14 10:43:50'),('d8667f2c4f07e7a3df3ee587f7046407a602cfb4a4092aacf96364d1dce43ca3cf24f82bad3d7818','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','api-test','[]',0,'2026-10-03 22:51:32','2026-10-03 22:51:32','2027-10-03 22:51:32'),('d9b066604ebd4a5de6c80adabe9d4ebc31d7ea58d23dda0276538bbbe6a84d10a689e3c738e9ff86','sman-0001-0001-0001-000000000007','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',1,'2026-10-19 12:43:49','2026-10-19 12:43:49','2027-10-19 12:43:49'),('da5281748cc15e7c1ef8e5cb5c7738f187403b57711448c82b93befe185bf4419bd86a4948d2111a','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','zp-test','[]',0,'2026-10-22 17:43:18','2026-10-22 17:43:18','2027-10-22 17:43:18'),('dad53d0f45b44f27699703ee2f09916fbfc2748394bb2b3d89e183b9c4cee0adda7459314257adb7','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','assign-test','[]',0,'2026-10-07 14:19:06','2026-10-07 14:19:11','2027-10-07 14:19:06'),('db1ae6cb279ae8cd7750fac515889d2fb93b7701e0f11970bb66126261984a25ef64561e0fc9acfe','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-18 19:59:59','2026-10-18 19:59:59','2027-10-18 19:59:59'),('dc85380020e2be2a7f890929d05a7a0f1be31d82a3567f4a47eac8fe4ad5e31abf86139101b3cde8','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-22 17:52:37','2026-10-22 17:52:37','2027-10-22 17:52:37'),('dda6ce14a5c86e332b527594d50d2b0816aacf951fecb357ace8540c1df7020f51cd6c44bd589413','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','invoice-prov','[]',0,'2026-10-27 12:44:56','2026-10-27 12:44:56','2027-10-27 12:44:56'),('df0abbaa32da9cc195edd74ff1fa43d73357183c15a05f955385feb5d3e0682b9c0c2647b1a1dd10','sman-0001-0001-0001-000000000002','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-22 17:54:32','2026-10-22 17:54:32','2027-10-22 17:54:32'),('e032f1ca51dbbe1b6944eca6ebc00c3a0007e359eb78c08c95f402615360ee0999798c1272aecd5b','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-18 19:43:34','2026-10-18 19:43:34','2027-10-18 19:43:34'),('e11fe1613fede15c6d28b89cbed61408ebf6fe285712d999440b77dd601eb209725bbf780eac7ee3','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','inv-test','[]',0,'2026-10-27 13:00:29','2026-10-27 13:00:29','2027-10-27 13:00:29'),('e1c42b06f93611f6366623c02969eb96c0753048f993e3c68b5aded5fc930c8d37f7d21cdc4a1772','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-16 09:47:20','2026-10-16 09:47:20','2027-10-16 09:47:20'),('e1e1d62282294f0e2f9e6fd69ddf81c0d7b713525cec15f6d7814faa7f2534ead553589c8f418353','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','invoice-test-3','[]',0,'2026-10-27 12:44:05','2026-10-27 12:44:05','2027-10-27 12:44:05'),('e21bc6a7cf6173f5c5de2ee156d005298c831fca3e2f51e22a72133fde216352e2227c9a299816bd','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-21 15:34:35','2026-10-21 15:34:35','2027-10-21 15:34:35'),('e589f857afb37e6e65062e50bda10fc20c48db09c05c2cc15a177a118537f81d4993ca803e97a8b4','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','f','[]',0,'2026-10-14 13:34:07','2026-10-14 13:34:07','2027-10-14 13:34:07'),('e6905e9d81371afdc49f452567d932b0b2e531dfc3896f4ff005ac15ab9347b55eb64ee008573b89','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-22 17:44:58','2026-10-22 17:44:58','2027-10-22 17:44:58'),('e851422cd8f173dfd90c0e8bcf869d2c6246b3a848d66328d54a66d0fc2dabad28a852ce5c4c8bc7','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','assign-test','[]',0,'2026-10-07 14:18:37','2026-10-07 14:18:37','2027-10-07 14:18:37'),('e8a5a25e94af2389d7d1158fecfcf1459aa2e71166542d2138355acbd6bbc2cc9b1321d2b34b096e','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t','[]',0,'2026-10-14 10:39:21','2026-10-14 10:39:21','2027-10-14 10:39:21'),('ea30ec2d09f2d5e51f989fbfa24a89dbf825de16c1bffd371ce40cd5a3eefd5e7ff2054a50e9f315','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','invoice-test-5','[]',0,'2026-10-27 12:44:34','2026-10-27 12:44:35','2027-10-27 12:44:34'),('eabb6e8788a97bb02e87021266691a340daf783c7609228e27350aadec4dc07085d40e807643508d','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','e2e-countdown','[]',0,'2026-10-14 09:53:29','2026-10-14 09:53:29','2027-10-14 09:53:29'),('ebe04108e6843e82f4e589af3ce2cdf425a767b9a05a446c6ffa0726997508e02ad7e8754947a3b7','a72401cd-34d4-4f5d-9276-3e0c860e4cab','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-25 19:23:47','2026-09-25 19:23:47','2027-09-25 19:23:47'),('ecc740f218aeb1eb269de5536e44ab1215e475e503c7317d7367a4f28f27002ea86ac7afe967a210','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-27 12:05:14','2026-10-27 12:05:14','2027-10-27 12:05:14'),('ee81bf403a509692d798145d4c07d5de368c504de2a4d01a0391751bde9c382bf2c7ad22a59a9983','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-25 20:00:01','2026-09-25 20:00:01','2027-09-25 20:00:01'),('ee853d35d6df687282aad0baf6e0da0afdba3679fc59f8505b924a999d31f6209d7bc25660e016de','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','w17-test','[]',0,'2026-10-13 12:34:40','2026-10-13 12:34:40','2027-10-13 12:34:40'),('f081f17402512d4181df151014ada64bd2e8678358547c1bcfad6dceb849f2f5dcb2d9cff4a24a24','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','final-c','[]',0,'2026-10-13 15:36:45','2026-10-13 15:36:45','2027-10-13 15:36:45'),('f181d7c4d54a1fee45556280c06be5679c9905cfa7daf7e34e65080cf2fe8499be8037f76c5acc6f','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-12 10:24:52','2026-10-12 10:24:52','2027-10-12 10:24:52'),('f52331cc6fae4e6bd8f2f1d3f9697ed5c253c2334523f6c004e9b3602ac111c11fcdfe8588e9deb0','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-23 12:44:31','2026-10-23 12:44:31','2027-10-23 12:44:31'),('f550c6646d8ab18324c4ea926b7fcf56eec48963283193b85b5a8f6d27fb9d0cddb66c574958140e','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-10-22 17:30:47','2026-10-22 17:30:47','2027-10-22 17:30:47'),('f799325ba338b4de1aac14078bd586216e1a6b58897b9eef1be35baf3fd6948c3c46913e67933de1','cust-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-02 22:08:03','2026-10-02 22:08:03','2027-10-02 22:08:03'),('f7cc8b79837ea17ed6ebce1c57df4d5dd7e5049baf8027314da142ea66eca682db04f7467583c8d9','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','t-s','[]',0,'2026-10-16 15:00:40','2026-10-16 15:00:40','2027-10-16 15:00:40'),('fa891fc945b9527e822d186b4672287fde77217498380b0184c7af6d6ea332898a0d355b87dbf99b','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','f','[]',0,'2026-10-14 13:34:07','2026-10-14 13:34:07','2027-10-14 13:34:07'),('fb07266653e45fec1804de85993e6d69f34f48c4b9377ddcdae85f6ae3391d435916792b8a157201','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-18 20:05:11','2026-10-18 20:05:11','2027-10-18 20:05:11'),('fb072b48a981b0f6b6f70b2ac415fa80bcdff62735bace28479eb7aed3de835cd48d1286b425f3c8','prvd-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToProvider','[]',0,'2026-09-30 23:02:37','2026-09-30 23:02:37','2027-09-30 23:02:37'),('fb82e1fb22fe51e52da4940b2329e367b9c1935f6d7519dc029fe744f1d93524c0e268c170bba024','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-28 23:02:42','2026-09-28 23:02:42','2027-09-28 23:02:42'),('fbdd440a24b75b0c3bd8833e3f3e90aafd14fb07ce7c4bcf866a6154b2bd354faaeaa4727a000f68','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-10-02 01:24:30','2026-10-02 01:24:30','2027-10-02 01:24:30'),('fd3deeca51741f085822de79e049be60c88fa3aa5361810d56b14e0edf45aed4b062573eb9a48217','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','smoke-c','[]',0,'2026-10-13 15:30:17','2026-10-13 15:30:17','2027-10-13 15:30:17'),('fd8de45a5b800f4eed9bbedcfb02b8e91084b6fbedc1f73b2b919ea5b9a7b00879a7c32d05f55b1f','31f1bff9-432d-48ab-8e12-dcfc38d46069','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToCustomer','[]',0,'2026-09-19 01:18:07','2026-09-19 01:18:08','2027-09-19 01:18:07'),('fdbc4e01520d580e75469a8af59549ebbc631bb14607ff3443d15e2bf8dc774331325a1368763d03','sman-0001-0001-0001-000000000001','95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','AccessToServicemanApp','[]',0,'2026-10-02 18:28:05','2026-10-02 18:28:05','2027-10-02 18:28:05');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_clients` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES ('95faaac6-c1d2-4d4c-beb1-04196dd2fa8e',NULL,'Laravel Personal Access Client','75kQskqekdipFpesfWZZv85qPo2cT8aMsyWgsIrQ',NULL,'http://localhost',1,0,0,'2022-04-04 02:13:15','2022-04-04 02:13:15'),('95faaac6-c56a-4873-a880-79d252d65ab1',NULL,'Laravel Password Grant Client','hnFqAvObupsF3BXW4T6MxD4IhvKCZPRzyIqEFciB','users','http://localhost',0,1,0,'2022-04-04 02:13:15','2022-04-04 02:13:15');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,'95faaac6-c1d2-4d4c-beb1-04196dd2fa8e','2022-04-04 02:13:15','2022-04-04 02:13:15');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offline_payments`
--

DROP TABLE IF EXISTS `offline_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offline_payments` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_information` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `customer_information` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offline_payments`
--

LOCK TABLES `offline_payments` WRITE;
/*!40000 ALTER TABLE `offline_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `offline_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_subscriber_features`
--

DROP TABLE IF EXISTS `package_subscriber_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_subscriber_features` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_subscriber_log_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_subscriber_features`
--

LOCK TABLES `package_subscriber_features` WRITE;
/*!40000 ALTER TABLE `package_subscriber_features` DISABLE KEYS */;
/*!40000 ALTER TABLE `package_subscriber_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_subscriber_limits`
--

DROP TABLE IF EXISTS `package_subscriber_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_subscriber_limits` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_package_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_limited` tinyint(1) NOT NULL DEFAULT '1',
  `limit_count` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_subscriber_limits`
--

LOCK TABLES `package_subscriber_limits` WRITE;
/*!40000 ALTER TABLE `package_subscriber_limits` DISABLE KEYS */;
/*!40000 ALTER TABLE `package_subscriber_limits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_subscriber_logs`
--

DROP TABLE IF EXISTS `package_subscriber_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_subscriber_logs` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_package_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_price` decimal(24,2) NOT NULL DEFAULT '0.00',
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `vat_percentage` double(8,2) NOT NULL DEFAULT '0.00',
  `vat_amount` double(8,2) NOT NULL DEFAULT '0.00',
  `payment_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `primary_transaction_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_subscriber_logs`
--

LOCK TABLES `package_subscriber_logs` WRITE;
/*!40000 ALTER TABLE `package_subscriber_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `package_subscriber_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_subscribers`
--

DROP TABLE IF EXISTS `package_subscribers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_subscribers` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_package_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_subscriber_log_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_price` decimal(24,2) NOT NULL DEFAULT '0.00',
  `package_start_date` timestamp NULL DEFAULT NULL,
  `package_end_date` timestamp NULL DEFAULT NULL,
  `trial_duration` int NOT NULL DEFAULT '0',
  `vat_percentage` double(8,2) NOT NULL DEFAULT '0.00',
  `vat_amount` double(8,2) NOT NULL DEFAULT '0.00',
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_canceled` tinyint NOT NULL DEFAULT '0',
  `payment_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_notified` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_pkgsub_provider_id` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_subscribers`
--

LOCK TABLES `package_subscribers` WRITE;
/*!40000 ALTER TABLE `package_subscribers` DISABLE KEYS */;
/*!40000 ALTER TABLE `package_subscribers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_requests`
--

DROP TABLE IF EXISTS `payment_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_requests` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payer_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_amount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `gateway_callback_url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `success_hook` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failure_hook` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payer_information` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `external_redirect_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_information` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `attribute_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_requests`
--

LOCK TABLES `payment_requests` WRITE;
/*!40000 ALTER TABLE `payment_requests` DISABLE KEYS */;
INSERT INTO `payment_requests` VALUES ('971440b9-2e74-4f37-8521-20aa829b894e','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,352.82,NULL,'digital_payment_success','digital_payment_fail',NULL,'USD','razor_pay','{\"access_token\":\"MzFmMWJmZjktNDMyZC00OGFiLThlMTItZGNmYzM4ZDQ2MDY5\",\"zone_id\":\"a1614dbe-4732-11ee-9702-dee6e8d77be4\",\"service_schedule\":\"2026-09-18 17:53:02\",\"service_address_id\":9,\"service_address\":\"eyJpZCI6Im51bGwiLCJhZGRyZXNzX3R5cGUiOiJvdGhlcnMiLCJhZGRyZXNzX2xhYmVsIjoiaG9tZSIsImNvbnRhY3RfcGVyc29uX25hbWUiOiJKYXNzIHNpbmdoIiwiY29udGFjdF9wZXJzb25fbnVtYmVyIjoiKzkxNjMwNDY0MjMyMSIsImFkZHJlc3MiOiJBZ3JhLCBVdHRhciBQcmFkZXNoLCAyODAwMDEsIEluZGlhIiwibGF0IjoiMjcuMTc1MjU1NCIsImxvbiI6Ijc4LjAwOTgxNjEiLCJjaXR5IjoiQWdyYSIsInppcF9jb2RlIjoiMjgwMDAxIiwiY291bnRyeSI6IkluZGlhIiwiem9uZV9pZCI6ImExNjE0ZGJlLTQ3MzItMTFlZS05NzAyLWRlZTZlOGQ3N2JlNCIsIl9tZXRob2QiOm51bGwsInN0cmVldCI6IiIsImhvdXNlIjoiIiwiZmxvb3IiOm51bGwsImF2YWlsYWJsZV9zZXJ2aWNlX2NvdW50IjoxNX0=\",\"payment_method\":\"razor_pay\",\"callback\":\"http:\\/\\/10.0.2.2:8000\",\"is_partial\":\"0\",\"payment_platform\":\"app\",\"service_location\":\"customer\",\"customer\":\"eyJmaXJzdF9uYW1lIjoiSmFzcyIsImxhc3RfbmFtZSI6InNpbmdoIiwicGhvbmUiOiIrOTE2MzA0NjQyMzIxIiwiZW1haWwiOiJpamFzc0BnbWFpbC5jb20ifQ==\"}',0,'2026-09-19 01:39:34','2026-09-19 01:39:34','{\"name\":\"Jass singh\",\"email\":\"ijass@gmail.com\",\"phone\":\"+916304642321\",\"address\":\"\"}','http://10.0.2.2:8000','{\"name\":\"receiver_name\",\"image\":\"example.png\"}','1789735173','booking_id','app'),('09f05b1e-58ff-4a79-a4a6-96a11b255695','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,10617.64,NULL,'digital_payment_success','digital_payment_fail',NULL,'USD','stripe','{\"access_token\":\"MzFmMWJmZjktNDMyZC00OGFiLThlMTItZGNmYzM4ZDQ2MDY5\",\"zone_id\":\"a1614dbe-4732-11ee-9702-dee6e8d77be4\",\"service_schedule\":\"2026-10-02 12:00:00\",\"service_address_id\":18,\"service_address\":\"eyJpZCI6Im51bGwiLCJhZGRyZXNzX3R5cGUiOiJvdGhlcnMiLCJhZGRyZXNzX2xhYmVsIjoiaG9tZSIsImNvbnRhY3RfcGVyc29uX25hbWUiOiJKYXNzIHNpbmdoIiwiY29udGFjdF9wZXJzb25fbnVtYmVyIjoiKzkxNjMwNDY0MjMyMSIsImFkZHJlc3MiOiJBZ3JhLCBVdHRhciBQcmFkZXNoLCAyODAwMDEsIEluZGlhIiwibGF0IjoiMjcuMTc2NTY0MDM1NDM2IiwibG9uIjoiNzguMDA4NTQwOTQzMTA5NSIsImNpdHkiOiJBZ3JhIiwiemlwX2NvZGUiOiIyODAwMDEiLCJjb3VudHJ5IjoiSW5kaWEiLCJ6b25lX2lkIjoiYTE2MTRkYmUtNDczMi0xMWVlLTk3MDItZGVlNmU4ZDc3YmU0IiwiX21ldGhvZCI6bnVsbCwic3RyZWV0IjoiIiwiaG91c2UiOiIiLCJmbG9vciI6bnVsbCwiYXZhaWxhYmxlX3NlcnZpY2VfY291bnQiOjE1fQ==\",\"payment_method\":\"stripe\",\"callback\":\"http:\\/\\/10.0.2.2:8000\",\"is_partial\":\"0\",\"payment_platform\":\"app\",\"service_location\":\"customer\",\"customer\":\"eyJmaXJzdF9uYW1lIjoiSmFzcyIsImxhc3RfbmFtZSI6InNpbmdoIiwicGhvbmUiOiIrOTE2MzA0NjQyMzIxIiwiZW1haWwiOiJpamFzc0BnbWFpbC5jb20ifQ==\"}',0,'2026-10-01 00:37:22','2026-10-01 00:37:22','{\"name\":\"Jass singh\",\"email\":\"ijass@gmail.com\",\"phone\":\"+916304642321\",\"address\":\"\"}','http://10.0.2.2:8000','{\"name\":\"receiver_name\",\"image\":\"example.png\"}','1790768242','booking_id','app');
/*!40000 ALTER TABLE `payment_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_additional_information`
--

DROP TABLE IF EXISTS `post_additional_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_additional_information` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_additional_information`
--

LOCK TABLES `post_additional_information` WRITE;
/*!40000 ALTER TABLE `post_additional_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_additional_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_additional_instructions`
--

DROP TABLE IF EXISTS `post_additional_instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_additional_instructions` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `post_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_additional_instructions`
--

LOCK TABLES `post_additional_instructions` WRITE;
/*!40000 ALTER TABLE `post_additional_instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_additional_instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_bids`
--

DROP TABLE IF EXISTS `post_bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_bids` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `offered_price` decimal(24,2) NOT NULL DEFAULT '0.00',
  `provider_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_bids`
--

LOCK TABLES `post_bids` WRITE;
/*!40000 ALTER TABLE `post_bids` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_bids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `booking_schedule` datetime DEFAULT NULL,
  `is_booked` tinyint(1) NOT NULL DEFAULT '0',
  `is_checked` tinyint(1) NOT NULL DEFAULT '0',
  `customer_user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_address_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_guest` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_booking_timers`
--

DROP TABLE IF EXISTS `provider_booking_timers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_booking_timers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','accepted','ignored','expired','auto_approved') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `provider_booking_timers_booking_id_index` (`booking_id`),
  KEY `provider_booking_timers_provider_id_index` (`provider_id`),
  CONSTRAINT `provider_booking_timers_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `provider_booking_timers_provider_id_foreign` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_booking_timers`
--

LOCK TABLES `provider_booking_timers` WRITE;
/*!40000 ALTER TABLE `provider_booking_timers` DISABLE KEYS */;
INSERT INTO `provider_booking_timers` VALUES (23,'1a71cd0f-8b05-4b13-9f7c-ae84a2cf7bff','prvd-0001-0001-0001-000000000001','expired','2026-10-27 12:22:04','2026-10-27 12:21:04','2026-10-27 12:22:33');
/*!40000 ALTER TABLE `provider_booking_timers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_category_requests`
--

DROP TABLE IF EXISTS `provider_category_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_category_requests` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_type` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'replace',
  `current_main_category_ids` text COLLATE utf8mb4_unicode_ci,
  `current_sub_category_ids` text COLLATE utf8mb4_unicode_ci,
  `requested_sub_category_ids` text COLLATE utf8mb4_unicode_ci,
  `note` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `admin_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_pcr_provider` (`provider_id`),
  KEY `idx_pcr_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_category_requests`
--

LOCK TABLES `provider_category_requests` WRITE;
/*!40000 ALTER TABLE `provider_category_requests` DISABLE KEYS */;
INSERT INTO `provider_category_requests` VALUES ('7ef7254e-3bc1-419b-aa62-3547255e7df5','prvd-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','replace','[\"cat-0001-0001-0001-000000000001\",\"cat-0001-0001-0001-000000000003\"]','[\"cat-0002-0001-0001-000000000001\",\"cat-0002-0001-0001-000000000002\",\"cat-0002-0001-0001-000000000003\",\"cat-0002-0001-0001-000000000004\",\"cat-0002-0001-0001-000000000009\",\"cat-0002-0001-0001-000000000010\"]','[\"cat-0002-0001-0001-000000000001\",\"cat-0002-0001-0001-000000000002\",\"cat-0002-0001-0001-000000000003\",\"cat-0002-0001-0001-000000000004\",\"cat-0002-0001-0001-000000000009\",\"cat-0002-0001-0001-000000000010\",\"cat-0002-0001-0001-000000000012\",\"cat-0002-0001-0001-000000000013\",\"cat-0002-0001-0001-000000000014\"]',NULL,'pending',NULL,'2026-10-04 05:52:39','2026-10-04 05:52:39');
/*!40000 ALTER TABLE `provider_category_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_notification_setups`
--

DROP TABLE IF EXISTS `provider_notification_setups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_notification_setups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notification_setup_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_notification_setups`
--

LOCK TABLES `provider_notification_setups` WRITE;
/*!40000 ALTER TABLE `provider_notification_setups` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_notification_setups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_registration_requests`
--

DROP TABLE IF EXISTS `provider_registration_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_registration_requests` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_person_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_person_phone` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_phone` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_phone` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identity_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identity_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identity_images` text COLLATE utf8mb4_unicode_ci,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `zone_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main_category_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_category_ids` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_provider_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `provider_registration_requests_zone_id_index` (`zone_id`),
  KEY `provider_registration_requests_main_category_id_index` (`main_category_id`),
  KEY `provider_registration_requests_created_provider_id_index` (`created_provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_registration_requests`
--

LOCK TABLES `provider_registration_requests` WRITE;
/*!40000 ALTER TABLE `provider_registration_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_registration_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_service_requests`
--

DROP TABLE IF EXISTS `provider_service_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_service_requests` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_type` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `previous_values` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `admin_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_psr_provider` (`provider_id`),
  KEY `idx_psr_service` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_service_requests`
--

LOCK TABLES `provider_service_requests` WRITE;
/*!40000 ALTER TABLE `provider_service_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_service_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_settings`
--

DROP TABLE IF EXISTS `provider_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_settings` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `test_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `settings_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'live',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_settings`
--

LOCK TABLES `provider_settings` WRITE;
/*!40000 ALTER TABLE `provider_settings` DISABLE KEYS */;
INSERT INTO `provider_settings` VALUES ('11d83c47-0f30-4ca5-9630-fb3858ae0f62','prvd-0001-0001-0001-000000000001','provider_serviceman_can_edit_booking','\"0\"','\"0\"','serviceman_config','live',1,'2026-10-23 11:22:51','2026-10-23 11:22:51'),('4df1fab1-36be-43e9-a1cd-fed8a883fe37','prvd-0001-0001-0001-000000000001','weekends','\"[\\\"saturday\\\",\\\"sunday\\\",\\\"monday\\\",\\\"tuesday\\\",\\\"wednesday\\\",\\\"thursday\\\",\\\"friday\\\"]\"','\"[\\\"saturday\\\",\\\"sunday\\\",\\\"monday\\\",\\\"tuesday\\\",\\\"wednesday\\\",\\\"thursday\\\",\\\"friday\\\"]\"','service_schedule','live',1,'2026-09-26 21:13:44','2026-09-26 21:13:44'),('9605d317-89f6-474c-98b1-8b5521a2aa1b','prvd-0001-0001-0001-000000000001','provider_serviceman_category_filter','\"0\"','\"0\"','serviceman_config','live',1,'2026-10-23 11:22:51','2026-10-23 11:22:51'),('b04102c4-c86d-4eb0-9f36-438084ab9ff5','prvd-0001-0001-0001-000000000001','provider_serviceman_can_cancel_booking','\"0\"','\"0\"','serviceman_config','live',1,'2026-10-23 11:22:51','2026-10-23 11:22:51'),('c019a667-1bc3-40e7-8231-5973877babfc','prvd-0001-0001-0001-000000000001','time_schedule','\"{\\\"start_time\\\":\\\"00:00\\\",\\\"end_time\\\":\\\"20:43\\\"}\"','\"{\\\"start_time\\\":\\\"00:00\\\",\\\"end_time\\\":\\\"20:43\\\"}\"','service_schedule','live',1,'2026-09-26 21:13:44','2026-09-26 21:13:44');
/*!40000 ALTER TABLE `provider_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_sub_category`
--

DROP TABLE IF EXISTS `provider_sub_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_sub_category` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_sub_category`
--

LOCK TABLES `provider_sub_category` WRITE;
/*!40000 ALTER TABLE `provider_sub_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_sub_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providers`
--

DROP TABLE IF EXISTS `providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `providers` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_phone` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_phone` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_count` int unsigned NOT NULL DEFAULT '0',
  `service_man_count` int unsigned NOT NULL DEFAULT '0',
  `service_capacity_per_day` int unsigned NOT NULL DEFAULT '0',
  `rating_count` int unsigned NOT NULL DEFAULT '0',
  `avg_rating` double(8,4) NOT NULL DEFAULT '0.0000',
  `commission_status` tinyint(1) NOT NULL DEFAULT '0',
  `commission_percentage` double(8,4) NOT NULL DEFAULT '0.0000',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL DEFAULT '0',
  `zone_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coordinates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `is_suspended` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `service_availability` tinyint(1) NOT NULL DEFAULT '1',
  `subscription_required` tinyint NOT NULL DEFAULT '1',
  `cover_image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auto_assign_mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = all bookings directly sent to this provider, 0 = normal nearest-provider auto assign',
  `auto_assign_wait_time` int NOT NULL DEFAULT '120' COMMENT 'seconds a provider gets to accept an auto-assigned booking',
  `auto_reassign_on_cancel` tinyint(1) NOT NULL DEFAULT '0',
  `independent_mode` tinyint NOT NULL DEFAULT '0',
  `admin_commission_percent` double NOT NULL DEFAULT '0',
  `provider_commission_percent` double NOT NULL DEFAULT '0',
  `platform_fee_amount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `platform_fee_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_assignment_mode` tinyint NOT NULL DEFAULT '0',
  `assigned_main_category_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_service_create` tinyint(1) NOT NULL DEFAULT '1',
  `allow_service_edit` tinyint(1) NOT NULL DEFAULT '1',
  `unsatisfied_window_days` int NOT NULL DEFAULT '7' COMMENT 'user app me unsatisfied section ka window (days), 0 = hidden',
  `service_approval_required` tinyint(1) NOT NULL DEFAULT '0',
  `booking_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Booking fee charged to customer for this provider',
  `custom_fees_enabled` tinyint NOT NULL DEFAULT '0' COMMENT '1 = use this provider''s own fees; 0 = global fees',
  `booking_fee_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Customer facing fee label; NULL = global label',
  `calling_enabled` tinyint NOT NULL DEFAULT '0' COMMENT '1 = allow in-app voice/video calling for this provider & its service men',
  `tax_percent` decimal(8,4) DEFAULT NULL COMMENT 'Tax % for this provider services; NULL = use service tax',
  `allowed_payment_methods` text COLLATE utf8mb4_unicode_ci COMMENT 'JSON array of allowed payment method keys; NULL = all',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providers`
--

LOCK TABLES `providers` WRITE;
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
INSERT INTO `providers` VALUES ('prvd-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','HomeCare Solutions','+919876543211','12 MG Road, New Delhi 110001','amit@provider.com',NULL,'Amit Sharma','+919876543211','amit@provider.com',45,8,20,38,4.5000,1,15.0000,1,'2026-09-12 15:45:50','2026-10-27 12:23:39',1,'6b1c8733-b0ff-4c65-a745-1f46419adc49','{\"latitude\":\"28.6139\",\"longitude\":\"77.209\"}',0,NULL,1,0,NULL,0,60,0,1,0,0,0.00,NULL,0,NULL,1,1,7,0,0.00,1,'0',1,0.0000,'[\"cash_after_service\",\"offline_payment\",\"paypal\",\"stripe\"]'),('prvd-0001-0001-0001-000000000002','prvd-0001-0001-0001-000000000002','QuickFix Plumbing','+919876543212','45 Nehru Nagar, South Delhi 110017','vikram@provider.com',NULL,'Vikram Singh','+919876543212','vikram@provider.com',32,5,15,25,4.3000,1,20.0000,1,'2026-09-12 15:45:50','2026-10-26 11:27:11',1,'6b1c8733-b0ff-4c65-a745-1f46419adc49','{\"latitude\":\"28.63\",\"longitude\":\"77.22\"}',0,NULL,1,0,NULL,0,120,0,1,5,10,10.00,'Payment fee',1,'bc250cc5-990b-4864-aac1-c8dde7b63427',1,1,7,0,0.00,0,NULL,0,NULL,'[]'),('prvd-0001-0001-0001-000000000003','prvd-0001-0001-0001-000000000003','SparkElectro Services','+919876543213','78 Andheri West, Mumbai 400058','info@sparkelectro.com',NULL,'Priya Patel','+919876543213','priya@provider.com',60,12,25,52,4.7000,1,18.0000,1,'2026-09-12 15:45:50','2026-10-05 03:19:19',1,'a1614dbe-4732-11ee-9702-dee6e8d77be4','{\"latitude\":28.65,\"longitude\":77.24}',0,NULL,1,1,NULL,0,120,0,0,0,0,0.00,NULL,0,NULL,1,1,7,0,0.00,0,NULL,0,NULL,NULL),('prvd-0001-0001-0001-000000000004','prvd-0001-0001-0001-000000000004','CleanMaster Pro','+919876543214','23 Koramangala, Bangalore 560034','info@cleanmaster.com',NULL,'Suresh Reddy','+919876543214','suresh@provider.com',78,15,30,65,4.8000,0,10.0000,1,'2026-09-12 15:45:50','2026-10-05 03:19:21',1,'a1614dbe-4732-11ee-9702-dee6e8d77be4','{\"latitude\":28.7,\"longitude\":77.1}',0,NULL,1,1,NULL,0,120,0,0,0,0,0.00,NULL,0,NULL,1,1,7,0,0.00,0,NULL,0,NULL,NULL),('prvd-0001-0001-0001-000000000005','prvd-0001-0001-0001-000000000005','AC Expert Hub','+919876543215','56 Sector 14, Gurgaon 122001','info@acexpert.com',NULL,'Neha Gupta','+919876543215','neha@provider.com',55,10,20,42,4.6000,1,12.0000,1,'2026-09-12 15:45:50','2026-10-05 03:19:26',1,'a1614dbe-4732-11ee-9702-dee6e8d77be4','{\"latitude\":28.55,\"longitude\":77.25}',0,NULL,1,1,NULL,0,120,0,0,0,0,0.00,NULL,0,NULL,1,1,7,0,0.00,0,NULL,0,NULL,NULL);
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providers_withdraw_methods_data`
--

DROP TABLE IF EXISTS `providers_withdraw_methods_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `providers_withdraw_methods_data` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `withdrawal_method_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_field_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `providers_withdraw_methods_data_provider_id_index` (`provider_id`),
  KEY `providers_withdraw_methods_data_withdrawal_method_id_index` (`withdrawal_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providers_withdraw_methods_data`
--

LOCK TABLES `providers_withdraw_methods_data` WRITE;
/*!40000 ALTER TABLE `providers_withdraw_methods_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `providers_withdraw_methods_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification_users`
--

DROP TABLE IF EXISTS `push_notification_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_notification_users` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `push_notification_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification_users`
--

LOCK TABLES `push_notification_users` WRITE;
/*!40000 ALTER TABLE `push_notification_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notification_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notifications`
--

DROP TABLE IF EXISTS `push_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_notifications` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `to_users` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '["customer"]',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notifications`
--

LOCK TABLES `push_notifications` WRITE;
/*!40000 ALTER TABLE `push_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recent_searches`
--

DROP TABLE IF EXISTS `recent_searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recent_searches` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recent_searches`
--

LOCK TABLES `recent_searches` WRITE;
/*!40000 ALTER TABLE `recent_searches` DISABLE KEYS */;
INSERT INTO `recent_searches` VALUES ('0050f9cb-1073-4062-9c09-1225d7af842f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 14:36:32','2026-10-06 14:36:32'),('0073376e-c926-49a5-9e6a-08390179c095','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 14:54:02','2026-10-15 14:54:02'),('0139ffb8-7891-4ae1-872e-e97355fbbed7','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 22:50:02','2026-10-04 22:50:02'),('023cdf8c-35ef-4faa-96de-b4faa46b2b81','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 20:33:26','2026-09-30 20:33:26'),('026a012c-3b78-4a10-a625-edea5a954516','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 18:07:28','2026-10-05 18:07:28'),('02bc398d-4464-4f10-952c-0ccf585070af','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:23:55','2026-10-06 12:23:55'),('0319082e-c754-4257-aa36-217bd2763b62','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 10:19:20','2026-10-06 10:19:20'),('042a1828-83cb-4bf7-a450-722a708ee8c2','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 12:13:57','2026-10-27 12:13:57'),('04c975d9-f9df-4055-afe5-8b3a5b776a4c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-02 01:47:46','2026-10-02 01:47:46'),('05d1a577-52b8-43d1-ade6-72af4f41d773','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 18:16:02','2026-10-16 18:16:02'),('06907b11-0ce9-431d-8251-df6a0954916f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:56:42','2026-10-06 12:56:42'),('06cacac0-2335-4183-a373-d8f2291e9f1c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 18:20:17','2026-10-06 18:20:17'),('07865bf2-a4bb-4e23-80f5-fc71a54936c0','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 15:38:04','2026-10-15 15:38:04'),('08565478-3c3d-4f11-83aa-3ed0dcee13d1','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 22:25:59','2026-10-01 22:25:59'),('09506666-8142-4294-9211-d6698de5479c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 11:01:17','2026-10-06 11:01:17'),('09cc631e-a345-42ef-aa21-f2282c66eec7','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 10:13:34','2026-10-06 10:13:34'),('0a461bc2-4c88-4349-9487-6564289e6338','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 12:54:52','2026-10-05 12:54:52'),('0cbdc526-38cf-4335-901e-9a7b2d8478a8','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 18:31:46','2026-10-01 18:31:46'),('0e194200-e402-49cc-873e-b2b09d5f3e3f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 03:44:10','2026-10-05 03:44:10'),('1020ed2b-cb94-49bb-bf80-763e99cd5ee0','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 18:43:09','2026-09-30 18:43:09'),('10e6ac04-ce57-4ea8-8686-5361dd2f733c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 18:18:40','2026-10-14 18:18:40'),('12738577-ffce-4b59-b2b5-589cf30e2315','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 14:29:17','2026-10-14 14:29:17'),('13207412-ad51-47a0-a815-294babae816d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 09:45:38','2026-10-17 09:45:38'),('138f6090-13ab-4ccb-8f04-21c214aea941','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 02:27:37','2026-09-30 02:27:37'),('1392bcaa-7275-4e66-a34f-1faba2523bcc','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:23:06','2026-10-06 12:23:06'),('139cfadd-dc16-491b-88ef-92306b857203','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 20:40:23','2026-09-30 20:40:23'),('13b911c7-7d21-4afa-9cdd-575f66f4856c','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 14:22:36','2026-10-27 14:22:36'),('146ab3b0-e2dd-440c-8d9a-877a447a2c0b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 14:22:37','2026-10-06 14:22:37'),('1548ebe1-f2c9-4674-86c0-71ec79af8a93','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 18:18:17','2026-10-06 18:18:17'),('161f3fa6-4127-47ff-8a42-5dc255b149ea','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 14:21:54','2026-10-14 14:21:54'),('169c3759-ab77-4b28-94eb-2d00522aa315','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 21:20:45','2026-10-04 21:20:45'),('16b07de8-ab18-4f64-8b84-f0ae839fb424','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-19 13:19:13','2026-10-19 13:19:13'),('16b947ce-68e2-4df4-8d2a-ead62f4aedb9','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 14:44:50','2026-10-27 14:44:50'),('1719d034-8d08-4a26-8a7d-4de578840c7e','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 14:36:05','2026-10-06 14:36:05'),('171ac74d-30a6-4c75-8921-30241597f9dc','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 20:53:37','2026-09-30 20:53:37'),('17352c6a-fe44-49f2-8a01-95c76d6f117f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:23:56','2026-10-06 12:23:56'),('19f82da7-ee4a-48ee-838d-7ae94978e296','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 10:16:30','2026-10-15 10:16:30'),('1a950771-293f-46bf-9033-3cffd65eedec','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 18:29:09','2026-10-05 18:29:09'),('1aad7861-e637-4801-aedf-61516a1b8710','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 20:52:07','2026-10-04 20:52:07'),('1bdc0fb4-315e-47b6-9912-3534adaf93f5','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 14:07:01','2026-10-12 14:07:01'),('1bfe27f3-9b1b-4cbf-9272-98e11762c10e','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:34:50','2026-10-05 14:34:50'),('1cb5cf8b-a371-4419-bccd-add3e0210225','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 14:41:45','2026-10-06 14:41:45'),('1d879859-b65d-4070-9809-d82a616aa2ea','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 11:13:31','2026-10-12 11:13:31'),('1d8d59bd-a248-4f4d-80e9-4f34eb0cc085','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 14:44:49','2026-10-27 14:44:49'),('20244e9b-5c13-468c-972a-57801ca327f6','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 16:02:31','2026-10-27 16:02:31'),('21c1bb31-a60e-4f3f-85dc-c4c0757abd3e','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 22:11:36','2026-10-01 22:11:36'),('240992dd-5bff-4061-8463-97f653dc1b72','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 18:12:12','2026-10-05 18:12:12'),('252c7d3a-aff4-4075-a6bb-d7c7470b2057','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 22:11:11','2026-10-01 22:11:11'),('25944b7f-9fde-4684-a092-3bb062c2dafe','31f1bff9-432d-48ab-8e12-dcfc38d46069','AC General Servicing',NULL,'2026-09-18 19:42:12','2026-09-18 19:42:12'),('2631c9a4-592b-48fa-b271-aa96859a6956','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 10:38:50','2026-10-12 10:38:50'),('270fa334-d663-4a1c-bfa0-d67ba3c1bcbc','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 18:18:24','2026-10-16 18:18:24'),('27524456-9f3d-402d-badc-1cb0fd5b78f5','31f1bff9-432d-48ab-8e12-dcfc38d46069','clean',NULL,'2026-10-13 15:41:37','2026-10-13 15:41:37'),('278e1158-4662-488b-8115-3049d2c0cd24','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 22:49:50','2026-10-04 22:49:50'),('27cf25f4-7063-45da-8808-e3360e57159d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-29 22:44:09','2026-09-29 22:44:09'),('27e3b0a6-08b6-46fc-ab4f-efa88e04cd8a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 20:05:36','2026-10-18 20:05:36'),('2862b6df-075b-4b8e-a113-840e9e31ad13','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 15:32:37','2026-10-27 15:32:37'),('28a786d8-b37b-439d-855a-81ef8f8beed7','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:23:16','2026-10-06 12:23:16'),('291cae2d-1e9a-4fc3-accb-1fe89503b55b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 20:53:57','2026-10-04 20:53:57'),('297ddc73-00bc-4796-ac23-05bbd46e94a8','31f1bff9-432d-48ab-8e12-dcfc38d46069','clean',NULL,'2026-10-13 15:43:31','2026-10-13 15:43:31'),('29e897d9-1f3b-44a1-90b8-7eb453136522','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 23:10:40','2026-10-04 23:10:40'),('2a30bd27-cdc6-4d7a-bbc5-6dc2d4ee6791','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 03:44:00','2026-10-05 03:44:00'),('2ac2a54b-4b92-48e9-bafc-dc098a7f472a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 17:40:23','2026-10-05 17:40:23'),('2b117956-7117-40c5-b209-1cd75b1fe759','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 14:16:58','2026-10-06 14:16:58'),('2cb50bc9-5905-44aa-a5d5-c8294581908d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 18:18:52','2026-10-14 18:18:52'),('2d18aeb7-b2a8-486d-84d7-861fc1af7c69','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 17:43:05','2026-10-06 17:43:05'),('2d3a908e-06f6-4ba9-841e-50231ae88e0c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-02 01:34:39','2026-10-02 01:34:39'),('2d3f3e0c-63e2-45b1-900e-6e1542523f08','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 20:53:07','2026-10-04 20:53:07'),('2d8ee524-e5fb-420a-b447-6e7b1b5744db','31f1bff9-432d-48ab-8e12-dcfc38d46069','Ceiling Fan Installation',NULL,'2026-09-26 21:11:59','2026-09-26 21:11:59'),('2dc70ad0-1573-4475-a6cc-6746f47229a4','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 09:49:43','2026-10-16 09:49:43'),('2e4a2170-30ef-43aa-8445-c127a93ecea7','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:11:19','2026-10-05 15:11:19'),('2ea63253-9b55-4e7d-a080-17f339472cda','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 15:47:07','2026-10-27 15:47:07'),('2fb5c4eb-ba1e-43a4-9407-a1628341e02a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 18:37:30','2026-10-18 18:37:30'),('300f8f63-07a2-4cfc-bc01-a56cc3e2b855','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 15:45:28','2026-10-14 15:45:28'),('30a4b49e-9e3b-45de-b997-21e8003b7a12','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:17:23','2026-10-05 14:17:23'),('30b39502-e18f-4066-b2b8-81d0acc3efe0','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 22:49:30','2026-10-04 22:49:30'),('31938c5d-6bc2-4fda-949e-8c8706e0a49b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 11:52:50','2026-10-06 11:52:50'),('31be635b-b17e-4bae-a31d-022b468cae25','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 17:58:27','2026-10-05 17:58:27'),('3227c9c2-01ef-4b2b-b796-ecbc07cfc396','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 18:08:00','2026-10-05 18:08:00'),('3260fddb-324f-4d12-b39c-cf7a5080662a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 11:50:42','2026-10-15 11:50:42'),('330d0bf4-7842-4682-a917-51519c3e2e4a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 10:23:47','2026-10-17 10:23:47'),('332f3cf7-6fff-4444-9fe7-ccd4ae14e37a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:20:07','2026-10-06 12:20:07'),('3363c288-725d-4a7c-b98b-31581985fcf0','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 10:48:42','2026-10-15 10:48:42'),('3483ec50-a36f-4966-9390-8b13a4a48783','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 12:13:17','2026-10-15 12:13:17'),('3578c8fb-df1b-4289-b7a9-5921c4e5f5f5','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 10:10:41','2026-10-15 10:10:41'),('35a4a31c-0c63-499c-9edc-d11631de2081','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 03:18:24','2026-10-05 03:18:24'),('35b45d1c-e36b-4ca7-a3b9-5a30888f9e59','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:54:32','2026-10-05 14:54:32'),('3635808e-f207-488d-a81e-750829c0c8fc','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 12:19:54','2026-10-27 12:19:54'),('36c05efd-6268-4624-9a41-79c9aa20de57','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 17:23:20','2026-10-14 17:23:20'),('36e17e22-dfc1-4472-8f57-b59c686b7ba6','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 12:44:52','2026-10-05 12:44:52'),('395d6444-a138-4a7b-b114-4e900706d2fe','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 16:48:44','2026-10-07 16:48:44'),('3a3c1074-5cf0-4bb9-8ba0-0e8a7f3f7107','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 20:49:41','2026-10-04 20:49:41'),('3a6a2633-baf5-4dac-b178-c81c5e62e045','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 10:24:52','2026-10-12 10:24:52'),('3d0b6c7d-7569-4cd8-a11b-5076c49b8e4c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 12:45:04','2026-10-05 12:45:04'),('407a1a05-1fb3-4c54-b76d-d77b03713503','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 18:24:00','2026-10-15 18:24:00'),('434a8f49-2a59-449c-9b50-53de65f65dbd','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 02:52:05','2026-10-05 02:52:05'),('43981275-5986-40e8-ad93-0aada0362656','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-13 18:04:05','2026-10-13 18:04:05'),('444126f7-0977-4f43-8cab-4ca7f2209346','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 11:50:40','2026-10-15 11:50:40'),('4698fc8f-19b0-4c62-ac6b-41141ce5423f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:12:29','2026-10-06 12:12:29'),('47570d0d-ee0c-4030-b696-1c6db18ee6dc','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 23:45:49','2026-09-30 23:45:49'),('4772648b-525f-47b3-a0fa-d1176b82dfec','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-13 18:04:05','2026-10-13 18:04:05'),('47c87939-beed-4424-91f8-3432133a59ef','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 15:20:11','2026-10-12 15:20:11'),('486dd9d3-1fbd-4663-8428-428bd3d2a959','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 23:02:15','2026-10-04 23:02:15'),('48a74b61-eab4-423a-90db-93fbbc6cde84','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 10:47:21','2026-10-06 10:47:21'),('48cac6df-321e-4af8-aea1-ad7f70462a38','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:00:37','2026-10-06 12:00:37'),('49f1be57-d47a-4d3a-8468-58c460acba4d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 15:52:25','2026-10-06 15:52:25'),('4b6ae243-7c57-479e-a27e-1cbaff39944a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 11:50:15','2026-10-15 11:50:15'),('4bcbaa39-ab95-445b-9909-c36be16f17f9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 17:01:38','2026-10-16 17:01:38'),('4d53f4b6-20c0-4cc4-8463-cd475e1f761e','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 14:35:08','2026-10-06 14:35:08'),('4e1208c6-48f1-4c54-8f90-3b78d26d54f0','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 22:24:12','2026-10-01 22:24:12'),('4e5185cb-1061-4888-b1a5-d8e3c2b0ee8a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 23:09:23','2026-10-04 23:09:23'),('50029d01-4f6e-417f-97d1-1b4000f5e551','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 17:19:03','2026-10-12 17:19:03'),('500fc22c-66ff-4cf6-aefb-69af69ee8063','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 14:16:25','2026-10-06 14:16:25'),('512338e2-db07-49ca-9a95-a0d44bb9c7c2','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-29 23:41:03','2026-09-29 23:41:03'),('5145798e-44a8-4991-9b39-2ab5c33419ed','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 15:16:52','2026-10-06 15:16:52'),('51555d8d-e1e7-4084-b9cb-d6d01d89b1b7','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 18:23:58','2026-10-15 18:23:58'),('51ec66dd-914c-4d0d-a85e-f673866fdd3f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:23:06','2026-10-06 12:23:06'),('52574fe5-13fd-4211-86ed-815f89071e2c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 18:18:40','2026-10-14 18:18:40'),('536ad1f7-1e25-47e5-ab30-f4f0aa4668dd','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 22:41:58','2026-10-01 22:41:58'),('537c0181-fc43-48fd-93c0-2a10ef7100b0','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 03:49:34','2026-10-05 03:49:34'),('53980aef-0d46-43f7-90dc-afe915f10f6e','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 18:23:58','2026-10-15 18:23:58'),('53a5f088-f41b-405a-ae26-1365f31faf50','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 10:17:30','2026-10-17 10:17:30'),('55a631bd-8fd2-4a47-9065-0549685cdcc7','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 17:24:14','2026-10-16 17:24:14'),('561943dd-34c2-461c-937c-56784b198c45','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 11:12:50','2026-10-17 11:12:50'),('56e42ce7-f5f6-484c-b7ef-144917b7a0dd','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 14:22:36','2026-10-27 14:22:36'),('57561ca7-7f11-4c34-88c3-4e83bf126a8f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 15:36:51','2026-10-14 15:36:51'),('579dd2a0-1e52-4bfa-9afc-4fe1756e70c3','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 17:49:35','2026-10-05 17:49:35'),('57cdb336-47b5-4e49-89f5-6e38790fafff','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 15:02:26','2026-10-06 15:02:26'),('59a50a67-5bf8-4869-86cf-7ae1f0b0adb9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:57:25','2026-10-06 12:57:25'),('5a58401a-8ced-4ff3-926e-54b17353a130','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 18:20:15','2026-10-06 18:20:15'),('5b7e42c6-d14c-4877-841e-119c593b714e','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 00:59:18','2026-10-01 00:59:18'),('5bd7e981-2395-486b-8bba-3afcdba4cb84','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 18:23:41','2026-10-05 18:23:41'),('5bfdfc8c-cfe1-4c87-b35b-89a78433d50d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 15:19:08','2026-10-12 15:19:08'),('5c93664c-e71d-4567-9257-d159ef92465f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 16:21:30','2026-10-14 16:21:30'),('5c96fe4b-94d2-4d33-821e-b0a1af39b80b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 17:19:25','2026-10-12 17:19:25'),('5cb37085-2c26-40dc-a22a-9b9601c0e1dc','31f1bff9-432d-48ab-8e12-dcfc38d46069','clean\' AND SLEEP(5)-- -',NULL,'2026-10-13 15:40:13','2026-10-13 15:40:13'),('5d1617f6-bfeb-498d-ad1b-2e30225faaf1','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 17:33:57','2026-10-15 17:33:57'),('5dd7b0bd-a388-4848-bac3-cd0efc870ca2','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 15:34:14','2026-10-07 15:34:14'),('5e03fac2-af7a-4726-8e69-3197e6bc38e0','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-29 22:51:44','2026-09-29 22:51:44'),('5f3b55d9-a679-491b-8a58-d83bd7615bb1','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:42:16','2026-10-05 15:42:16'),('5f7e666f-0a6d-48c5-b36f-a6d2d3e313ec','31f1bff9-432d-48ab-8e12-dcfc38d46069','plumb',NULL,'2026-10-13 16:25:07','2026-10-13 16:25:07'),('5fc12d30-8167-4a6d-9235-144a4f4c0a62','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-29 23:40:44','2026-09-29 23:40:44'),('606c64f7-72ce-40b3-9b69-5c794b8e2362','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 18:24:28','2026-10-18 18:24:28'),('61613d49-9d14-467b-83d0-c9f6bf677e51','31f1bff9-432d-48ab-8e12-dcfc38d46069','clean',NULL,'2026-10-13 15:41:57','2026-10-13 15:41:57'),('638cf145-5381-4dbb-8764-eb4ce6e8e4c9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 10:44:20','2026-10-12 10:44:20'),('63a86b56-f6cc-47f6-9763-af2672711364','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 18:21:19','2026-10-16 18:21:19'),('645520fe-accd-4c9b-9927-0f58cc697e45','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 11:30:50','2026-10-06 11:30:50'),('6476df7b-98fb-4193-ad57-f9e5dc35baae','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 17:13:17','2026-10-06 17:13:17'),('659b848f-f994-4cb5-8e1b-3763a8349664','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:20:23','2026-10-06 12:20:23'),('65b869e9-9702-4ed3-839d-16914d3ef6f8','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 12:19:53','2026-10-27 12:19:53'),('65e208a3-a52b-4f84-9c33-1ac50a3a05ea','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 12:14:59','2026-10-27 12:14:59'),('662a2e54-edbf-49ac-8d8b-286b284deb6e','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 10:15:59','2026-10-17 10:15:59'),('6654929f-6fd3-408e-8ac2-39c49400dd0c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 12:24:49','2026-10-12 12:24:49'),('674946ca-2d27-4ae3-8aed-0b3e9169e28d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 18:14:22','2026-10-05 18:14:22'),('68c37a52-4034-4e0a-968e-375bea4cc8ff','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:11:19','2026-10-05 15:11:19'),('68d2784b-cc80-43af-bd3d-763925df042b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 23:15:03','2026-10-04 23:15:03'),('6a39b86b-06de-4381-8bd3-6d856511fe05','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 10:41:47','2026-10-17 10:41:47'),('6a569be8-c19b-47ba-b342-c9ef9d9eb21f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 20:15:28','2026-10-18 20:15:28'),('6a5b8459-9c29-4dc7-b260-f1a70b4f18be','31f1bff9-432d-48ab-8e12-dcfc38d46069','clean\' AND SLEEP(5)-- -',NULL,'2026-10-13 15:43:31','2026-10-13 15:43:31'),('6b32c5ce-1058-4fca-a755-584e92a24b36','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 10:16:33','2026-10-15 10:16:33'),('6c1ed2c8-d3f2-4db0-ae84-48664b9c86cd','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 20:00:01','2026-10-18 20:00:01'),('6c58caf2-db52-4dd1-9e00-22ad02b74997','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 14:08:13','2026-10-18 14:08:13'),('6cb506a4-ccb2-41fa-a685-8032aa2c6c40','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-29 23:40:31','2026-09-29 23:40:31'),('6d19ba78-fd27-4ce8-a329-b05bf8dd56c0','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 17:20:56','2026-10-27 17:20:56'),('6d96beeb-c4d8-4ed1-bbb0-45bb06172d45','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 19:40:11','2026-10-18 19:40:11'),('6eac953b-0044-4e6e-a31a-9b5a4eda72e4','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 03:42:00','2026-10-05 03:42:00'),('6ed31d9c-ac59-4fdd-ae6f-20a2e6207ecc','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 17:59:12','2026-10-05 17:59:12'),('6fe0e99b-f1ff-48b6-a9ae-c64fd43de117','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 10:40:00','2026-10-12 10:40:00'),('704e6877-6a02-46fe-a4fd-c4d2f14fd8b8','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 15:41:10','2026-10-06 15:41:10'),('718928cf-46c5-4296-8242-72ff9540b971','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-29 22:44:03','2026-09-29 22:44:03'),('72073714-1a2d-4db4-b164-18b65fa404db','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 14:26:42','2026-10-06 14:26:42'),('726d9134-c5da-4e24-9e66-7f687c443aa1','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 22:12:40','2026-09-30 22:12:40'),('72a67471-ec97-49d4-ba4c-e4612b633c5f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:30:59','2026-10-05 14:30:59'),('72edb89a-5c67-43b0-a6d6-a7cd1c25351b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:32:00','2026-10-05 15:32:00'),('75b709c8-733f-4221-8a3b-a3285ff37fb9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 15:31:51','2026-10-07 15:31:51'),('75f731df-866f-4209-9a74-f08d5b2bf6a7','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 16:20:02','2026-10-14 16:20:02'),('763223b4-82b5-4fb3-bd0f-1cc3a145c547','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 22:09:25','2026-10-01 22:09:25'),('76642b8c-b905-4ff5-b26d-24170e7bb2a9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 09:58:06','2026-10-06 09:58:06'),('76d8fa9b-8c11-4124-b7ec-2004ae062876','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:57:06','2026-10-06 12:57:06'),('76ed1fd0-69eb-4f00-9969-f6faca16da0d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 10:18:11','2026-10-07 10:18:11'),('77012a26-bbf4-4c5e-9a3b-da163fe8e7e6','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 12:36:16','2026-10-15 12:36:16'),('781fd964-9a55-4c0c-b889-299b501c1ccf','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 03:17:04','2026-10-05 03:17:04'),('78f6e918-797a-4e9d-ac9e-372a8dd2aea9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:34:24','2026-10-05 14:34:24'),('7922cbcb-4016-464b-9379-da8d51963c82','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 18:20:17','2026-10-06 18:20:17'),('79765e4f-2b43-401b-ba8d-9500083fb858','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-13 10:02:08','2026-10-13 10:02:08'),('7ac568f5-2f72-4151-8495-f557aaf9f00c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 12:48:52','2026-10-05 12:48:52'),('7b12c3d9-9963-473c-8fbd-eaa7809a41c1','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:24:17','2026-10-05 14:24:17'),('7b4e054b-eb5b-48f8-bd58-d3e59942b267','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 22:17:49','2026-10-01 22:17:49'),('7c3ed8e3-5edf-4ca9-b662-e50fdd20759e','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 00:36:57','2026-10-01 00:36:57'),('7c7ca6ad-6dff-4ea2-8f17-6251e4c9edd9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 12:56:08','2026-10-05 12:56:08'),('7d3e5b09-c3c0-4564-a114-c25e9ece2aca','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 17:00:37','2026-10-27 17:00:37'),('7e5967ab-fbd9-497d-afed-74717289de22','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 12:29:09','2026-10-07 12:29:09'),('80010b3b-437c-40de-84f6-2833ce73d619','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-29 22:23:44','2026-09-29 22:23:44'),('8099e183-cfda-4139-b6b6-ddccaa352654','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 23:00:44','2026-10-04 23:00:44'),('81357f26-1bf2-4f9d-a1f4-232b77cb8715','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 14:58:51','2026-10-12 14:58:51'),('813b2393-210c-4d7a-87aa-e8eddee6d077','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 13:29:31','2026-10-27 13:29:31'),('82c25bae-ab94-4663-82b5-9b7ab0847180','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:23:16','2026-10-06 12:23:16'),('82cc2e11-d52c-4736-b9f2-30860c81c8e4','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 13:01:20','2026-10-06 13:01:20'),('839bff81-5624-4ac5-85fd-4b8baf362754','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 17:50:59','2026-10-16 17:50:59'),('8414e697-638c-48f3-829f-60b71b531b51','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 18:42:48','2026-10-01 18:42:48'),('842ccb69-bd5a-4b68-9371-a03fd181cfb5','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 14:54:24','2026-10-06 14:54:24'),('87360f94-4312-4cdf-be43-ccfd07a50b61','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 18:26:54','2026-10-06 18:26:54'),('877f11f5-9807-49ce-bcb9-c5e217fa2041','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 10:57:05','2026-10-06 10:57:05'),('8812bf22-78c0-4704-b4ec-05a92ea568f2','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:56:41','2026-10-06 12:56:41'),('882f40f6-cdce-4a0d-9bde-ebe3f3681470','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 12:05:17','2026-10-27 12:05:17'),('883ce882-6219-40a6-891f-54d043bc5b31','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 21:02:50','2026-10-01 21:02:50'),('8a209105-de3d-43c4-a2f6-c4c9f26eb9ea','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 11:12:56','2026-10-17 11:12:56'),('8a602e7e-0222-4c21-9180-93aafd7e2d9c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 12:49:18','2026-10-05 12:49:18'),('8ba0f996-985d-4541-a153-47ef91fcebaf','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-02 20:11:31','2026-10-02 20:11:31'),('8c8d813b-3df7-4da1-a8e1-a4cc8ec82665','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 20:54:45','2026-10-04 20:54:45'),('8cf05594-d638-4505-a564-792fb0faab01','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 15:57:05','2026-10-06 15:57:05'),('8d8a5a8f-38d0-46e5-8e34-6a6352008afd','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 18:24:53','2026-09-30 18:24:53'),('8d96872b-c121-4005-8883-288fbbdaefc4','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:42:17','2026-10-05 15:42:17'),('8e43307e-813a-4b45-8ac1-a2114e188a50','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 11:03:37','2026-10-06 11:03:37'),('8ea8c646-97da-4145-a8e1-0a70787f0999','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 20:05:36','2026-10-18 20:05:36'),('905bcdc6-ab4f-469f-8bc2-99f983d27a01','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 14:28:28','2026-10-14 14:28:28'),('90662f5a-e375-4dbf-9f7e-6cc57a62e325','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 16:00:27','2026-10-14 16:00:27'),('914ec50d-f5f3-45f8-b0bc-dc377d275f98','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-02 02:01:49','2026-10-02 02:01:49'),('9170d741-0983-49e8-93ef-2de220794f3a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 14:40:29','2026-10-15 14:40:29'),('92985661-70d3-48d1-b724-9bc35bfc02b8','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-19 13:19:11','2026-10-19 13:19:11'),('938541da-d1ec-4e29-b5e2-e7c26f14193c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 14:37:10','2026-10-06 14:37:10'),('93cac3ef-80a4-4a21-bf0f-7929aaafb9fc','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 18:29:05','2026-10-05 18:29:05'),('945463a8-fa0b-42c7-961a-180ff1a98c48','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 03:49:34','2026-10-05 03:49:34'),('94fc4095-8035-4997-aaa9-91c438ce7302','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 11:56:54','2026-10-06 11:56:54'),('94fcd26c-1b32-49c5-9dd1-b7e5fecf73a9','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 12:30:53','2026-10-27 12:30:53'),('95073201-bbb6-4df7-ae49-f714f1b13106','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 23:04:42','2026-10-01 23:04:42'),('9512b734-74f6-4dd6-8b51-92c79afa2029','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 22:57:26','2026-09-30 22:57:26'),('955b48d2-5a85-403e-a089-3fecdb73a75a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-02 02:04:00','2026-10-02 02:04:00'),('9566976e-15cb-4e64-bd33-8db7abe5d7b4','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 00:51:10','2026-10-01 00:51:10'),('96143d18-05d4-4827-9702-2068e74b19f8','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 15:05:10','2026-10-12 15:05:10'),('96410129-e2fa-4501-a28d-7e85cf142d23','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 18:32:37','2026-10-01 18:32:37'),('96568495-11da-49b8-aa06-246e42540a33','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 13:29:31','2026-10-27 13:29:31'),('979c6ef3-bfbd-4e62-8be8-ff627f0c0af9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 03:42:02','2026-10-05 03:42:02'),('980e7f01-9a42-4589-aaaa-816041f741b6','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 10:23:14','2026-10-17 10:23:14'),('98373389-3a92-4c97-91f9-c2e8c884d2f9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:25:14','2026-10-05 14:25:14'),('9977b10e-35e5-445d-b36c-522e2c5074ba','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-02 01:24:33','2026-10-02 01:24:33'),('99901ac0-bcce-4fe4-bfe0-101188c9c9d8','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 18:22:44','2026-10-16 18:22:44'),('9a72aafd-a28a-44ef-885c-73c0c10a6afc','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 11:35:17','2026-10-07 11:35:17'),('9a9518a5-2fa3-4495-aa71-cb0264c7cebc','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-29 22:23:38','2026-09-29 22:23:38'),('9aa298bd-7f0b-41c6-8eb4-ee54790ff2f2','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:24:17','2026-10-06 12:24:17'),('9aba1a9e-80ca-4d93-8eaa-32e04f5800da','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 19:22:25','2026-10-18 19:22:25'),('9d1b48e9-3c76-4ae0-befa-d918996930af','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 14:58:52','2026-10-12 14:58:52'),('9d54bec7-5ffd-4c55-99d1-e800c5448162','31f1bff9-432d-48ab-8e12-dcfc38d46069','clean',NULL,'2026-10-13 15:40:43','2026-10-13 15:40:43'),('9e97aaba-1f54-49d9-83d4-036200ee1117','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 11:59:34','2026-10-17 11:59:34'),('9f052dd0-b56c-41c0-b01e-f79d8edf175a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 18:34:55','2026-10-18 18:34:55'),('a01b1a39-479b-4477-9fc0-10ef63e9fa37','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 23:28:01','2026-09-30 23:28:01'),('a0a90ca9-c480-47bd-b5fa-8486fdaa91d3','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 20:53:52','2026-10-04 20:53:52'),('a20785b9-6002-409a-b299-f8bd4b0ee724','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-02 20:12:53','2026-10-02 20:12:53'),('a2807f23-b6dd-4883-99b4-06d57cd87443','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 17:59:11','2026-10-05 17:59:11'),('a3e209a7-38ff-4b0e-bfbe-881d6646cdfd','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 20:52:14','2026-10-04 20:52:14'),('a56d2846-9653-452e-b03c-a6e03391c00b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:46:36','2026-10-06 12:46:36'),('a6f52165-5b4d-4ddf-b0cc-6c33157adaa9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 22:49:36','2026-10-04 22:49:36'),('a8ade29c-5a65-47c7-8502-51f428e01b87','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:20:20','2026-10-06 12:20:20'),('a961cd66-1ff5-43a9-8ed1-48a54952c546','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 21:20:25','2026-10-04 21:20:25'),('aafa857a-0088-4631-9526-80dd6074650b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 14:33:16','2026-10-07 14:33:16'),('ae11d645-7d22-43f5-985a-3acdb3f5292c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 10:14:08','2026-10-06 10:14:08'),('ae7f6f8c-2fbc-44a5-abce-03740aac2cae','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 10:10:23','2026-10-15 10:10:23'),('aeca9460-4775-420a-8a1b-4cda8d14d30d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:17:24','2026-10-05 14:17:24'),('aed5a1aa-a9ed-4b1f-8abc-c5da34874b51','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 15:48:00','2026-10-15 15:48:00'),('af2e80ee-dc8d-4399-bd57-cc9b619c936d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 14:04:48','2026-10-18 14:04:48'),('b00d03a0-4260-44f9-a768-04b0314ad760','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 18:11:28','2026-10-14 18:11:28'),('b215f780-9e7d-4821-8c7b-048f2771a489','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 18:24:28','2026-10-18 18:24:28'),('b27c8c8d-1d78-44fa-a69a-7792384f3c98','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 15:53:59','2026-10-27 15:53:59'),('b29c63c0-53d9-4b63-885b-4dd8f1f5ddbc','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 23:19:03','2026-10-04 23:19:03'),('b323ee8b-9712-4053-9409-8191386c0151','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 15:42:53','2026-10-06 15:42:53'),('b5b29ecb-2cdf-43b4-956d-1c65de57353a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 10:46:04','2026-10-12 10:46:04'),('b5dd2b1f-cf14-4002-a1f4-dec4a8495113','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 18:02:25','2026-10-05 18:02:25'),('b66ca803-e415-4e31-839f-bd4dbac830a5','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 18:18:06','2026-10-18 18:18:06'),('b739641a-f897-4945-8720-a44d39198ecf','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 10:05:31','2026-10-17 10:05:31'),('b7f7767c-fcf0-4c79-8612-49bfb9ce11be','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:21:38','2026-10-05 14:21:38'),('b8390179-12c9-4c8a-88d4-45bd76e60e10','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 17:21:00','2026-10-27 17:21:00'),('b8b5b88c-e7f0-401a-82dc-aebc6c18a3d5','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 20:00:09','2026-10-18 20:00:09'),('b8e8d995-e6b5-4b21-871e-704e1edff08f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 11:14:20','2026-10-06 11:14:20'),('b91ab88a-b1a6-4dc4-bdfb-9dc86fd0958b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 14:58:52','2026-10-12 14:58:52'),('b97c11c3-4e82-4b4c-b3af-107e58d0f40b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 18:43:07','2026-10-01 18:43:07'),('b9adef6c-8b42-493d-9bff-0899a8542c42','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 09:47:24','2026-10-17 09:47:24'),('ba632e8c-e488-4d7a-948e-8b1c5c4c1b2f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 18:15:33','2026-10-14 18:15:33'),('ba689a9c-07cd-41de-b61b-0cf4ae08592d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 18:16:09','2026-10-16 18:16:09'),('bd26c5b8-11f1-4092-8134-2ce7cd4b8911','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:29:14','2026-10-05 15:29:14'),('bd76ee30-20de-46ba-976e-532c199accee','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 00:12:42','2026-10-01 00:12:42'),('bd9cbfd8-9a00-43fc-9a42-37ec0b3232ac','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 23:15:45','2026-09-30 23:15:45'),('bed5c6ac-fc6e-4afa-b357-e789a97bc9c2','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:13:10','2026-10-05 15:13:10'),('c1435a53-c4c0-484a-ac8b-9f6756dc8a30','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-09 17:41:19','2026-10-09 17:41:19'),('c3d3451f-a59e-407b-bdba-5ff8804aed5a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 15:38:59','2026-10-12 15:38:59'),('c460e22b-07b9-4d46-b7e4-67b4a113307c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 18:20:16','2026-10-06 18:20:16'),('c5631c68-745e-4efe-85f4-5401fbf1d00d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 15:05:07','2026-10-12 15:05:07'),('c64cb4db-31d8-4fe1-af2d-fd068b123540','31f1bff9-432d-48ab-8e12-dcfc38d46069','clean',NULL,'2026-10-13 15:40:13','2026-10-13 15:40:13'),('c6c4cfee-504b-4951-9554-93acda60be4a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:03:24','2026-10-05 15:03:24'),('c706187c-8ccc-43a6-8921-4212bc9d16d3','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:32:17','2026-10-05 15:32:17'),('c740dcc9-b360-45dd-b56e-6ef845788838','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:17:00','2026-10-05 14:17:00'),('caa1f4e6-8c18-49d9-a06d-1ed9d995cb8d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:25:04','2026-10-06 12:25:04'),('cac2d999-996a-40c8-874e-8d9a4de245ca','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 14:50:59','2026-10-27 14:50:59'),('cb3869c6-48d6-4d9a-8451-8f34c03df249','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-08 17:00:53','2026-10-08 17:00:53'),('cbbbf616-61be-4e53-bc4f-4b530aacefa2','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 20:40:15','2026-09-30 20:40:15'),('cefd5869-4b54-45f9-a67b-e173bb24cf00','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 10:41:50','2026-10-17 10:41:50'),('cfc45ca5-b4b3-4178-9e0a-a601f0130cb9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 15:52:34','2026-10-06 15:52:34'),('d0092ecc-5520-4a20-aa4c-846a4c5ab6c3','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 12:19:54','2026-10-27 12:19:54'),('d0223ffa-cc14-4956-9f1c-067f3dc9163f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 11:35:48','2026-10-07 11:35:48'),('d167f5a3-8777-4331-b582-660cb7ed753b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 17:48:56','2026-10-05 17:48:56'),('d16d9f73-8dc1-4c83-9bf4-844212958ed0','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 18:21:47','2026-10-16 18:21:47'),('d2817b01-d1e8-4508-83dc-4f72fcd01332','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 23:53:39','2026-09-30 23:53:39'),('d2b29802-838f-4e06-94ec-f2d8f3e94d76','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 23:13:40','2026-09-30 23:13:40'),('d2b3a466-36d1-47cb-8c49-3a5e23ac1fe1','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 22:42:37','2026-10-01 22:42:37'),('d2b580eb-f47c-434e-a373-f4560323cc6c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 18:06:05','2026-10-16 18:06:05'),('d343acaa-e072-4002-9c71-81f2731a4e3e','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-13 17:55:06','2026-10-13 17:55:06'),('d4767510-088c-444b-8fca-fcee0b5202d1','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 12:48:52','2026-10-05 12:48:52'),('d51920cc-23ba-4d2a-a63e-fef3bd0d3909','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 12:56:02','2026-10-05 12:56:02'),('d5785d3f-cd36-4ab5-a8fb-6e17d4c18dc5','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 18:14:29','2026-10-05 18:14:29'),('d6209051-27cc-44ba-a3aa-44a0b8d2af04','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 15:22:46','2026-10-06 15:22:46'),('d6b4ee39-5a4e-47d6-b482-3f416a9d8494','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 16:04:51','2026-10-14 16:04:51'),('d80bd1e6-f6f3-4676-89b2-fc4ba8d0a252','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 18:18:52','2026-10-14 18:18:52'),('d89f5a21-b67d-48b9-8ade-58ead6af3867','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:42:19','2026-10-05 15:42:19'),('d8b084f5-d955-47a6-ac96-0395d1438d31','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 14:36:33','2026-10-06 14:36:33'),('d947a9df-a8cd-4c86-9cf4-0bba797dc232','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 20:49:31','2026-10-18 20:49:31'),('d98c7cfb-9326-4fed-a139-a97c12f9a0ba','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 15:32:31','2026-10-07 15:32:31'),('d99332bc-59d0-4104-ba83-c5ece96f2132','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 18:18:46','2026-10-16 18:18:46'),('da495820-ab8d-4e47-9104-4799939259bd','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 15:33:58','2026-10-07 15:33:58'),('da59dee5-024b-42fa-b496-099022201f38','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 11:13:08','2026-10-05 11:13:08'),('da9d99c7-e449-4455-8b7f-0cec0c0e14cb','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 17:50:59','2026-10-16 17:50:59'),('daa271f1-5771-4104-ad96-2ac1caecd5a6','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 10:28:00','2026-10-06 10:28:00'),('dcfd829b-cf00-43de-9a21-c14669cbc51e','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 18:22:31','2026-10-16 18:22:31'),('de424640-a462-49c5-8ba8-d6ec1aeb03a1','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 20:53:08','2026-10-04 20:53:08'),('de5ee61b-f4f3-4ba5-ad35-b41486aa3c44','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 12:49:11','2026-10-05 12:49:11'),('dee6afc4-5655-414c-a3e8-20d30cc941d7','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:10:42','2026-10-05 15:10:42'),('e09e08f6-383f-4412-8bd8-6bccbe189917','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 15:34:16','2026-10-07 15:34:16'),('e0cfedaf-e694-4480-850f-08c210fd0749','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 18:14:06','2026-10-14 18:14:06'),('e137e20b-6f88-4e67-95f9-f3796335688b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 10:21:59','2026-10-06 10:21:59'),('e16020c0-0d5a-4f82-9e49-8096bef0150a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 20:05:14','2026-10-18 20:05:14'),('e1da4557-2fa7-4974-9e90-620d5e0a8114','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 14:12:31','2026-10-12 14:12:31'),('e21ca65f-1bed-4cd0-bcf9-0440488ab873','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:31:51','2026-10-05 15:31:51'),('e24119a8-96fc-4d05-9d50-b88208c777be','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 18:22:17','2026-10-18 18:22:17'),('e288be49-c12e-4a77-a123-746cf9309d4d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 18:23:03','2026-10-18 18:23:03'),('e312dad3-7707-4887-80e4-3aa3374e7cb1','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-09 17:54:20','2026-10-09 17:54:20'),('e4650e66-3e6b-48c3-a99c-c448984e3bc2','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:21:39','2026-10-05 14:21:39'),('e46dc055-45af-490e-9da9-f8b1facecac6','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 14:57:30','2026-10-05 14:57:30'),('e4803c36-3175-4474-b88d-dff14a9ad608','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 15:32:38','2026-10-27 15:32:38'),('e4b62f02-94c2-4d23-ac91-089d75e2a46c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 20:49:01','2026-10-18 20:49:01'),('e5751c74-61ae-422b-94e6-6894e2119b23','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 11:20:23','2026-10-17 11:20:23'),('e5842b22-79c8-4fa0-9dd5-54e2e326a4ec','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 20:53:53','2026-10-04 20:53:53'),('e5dae5a2-c24d-468e-b297-1dc59864f8f5','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 00:59:12','2026-10-01 00:59:12'),('e6417b63-bd3a-4a17-a4f2-e8b18a1c6106','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 21:37:02','2026-10-18 21:37:02'),('e7c56f80-85ab-4e4b-8907-482be5ee8b2a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-02 20:11:12','2026-10-02 20:11:12'),('e8a994e6-7817-4e36-b9bd-b5d7de10255c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 12:20:08','2026-10-06 12:20:08'),('e9d37770-e662-4912-976a-31373523cbe0','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 20:38:09','2026-10-01 20:38:09'),('e9dd9eda-0dff-4246-bfe2-2cda359e04ae','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 11:02:08','2026-10-06 11:02:08'),('ea0d443e-b987-4a9c-9c15-1a62d331ed5f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 11:23:10','2026-10-06 11:23:10'),('ea89ee57-1442-4be0-aa2d-8014cfe93e59','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 23:55:41','2026-09-30 23:55:41'),('eac6a76b-515f-42be-8256-758d8f57a9bd','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 10:50:11','2026-10-15 10:50:11'),('eafa1d4a-a22e-4802-bc80-215df07eedd4','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 12:31:23','2026-10-27 12:31:23'),('eb3b5137-eeb8-409c-9118-09cc33033e98','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 17:09:05','2026-10-07 17:09:05'),('ec886cbc-6928-468a-b618-2da9a18b3792','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 23:17:56','2026-10-04 23:17:56'),('ed12f53a-8615-4eaa-8c10-6d6c4c195a09','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-04 23:01:57','2026-10-04 23:01:57'),('ede2c46a-1772-4bcc-8a10-019a2c7cda9a','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 10:16:23','2026-10-06 10:16:23'),('ee2d630d-1abb-4102-8dc2-001f7f04ca23','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 18:19:48','2026-10-18 18:19:48'),('eea840ef-a850-442d-becc-ad201afecc08','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-07 15:33:58','2026-10-07 15:33:58'),('eec19421-376e-4841-a3f5-763dce37d77d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:32:06','2026-10-05 15:32:06'),('ef348031-d7fc-4845-a37e-6b3cd5223623','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-02 01:52:58','2026-10-02 01:52:58'),('ef643802-b22c-4a48-8694-62e23b05f5bc','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 18:02:29','2026-10-05 18:02:29'),('ef996d1f-a2cc-4b3b-85a7-d6c751ac290b','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-12 14:58:51','2026-10-12 14:58:51'),('f0b65984-9770-49a2-b8fe-5d69041fe1c2','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 15:52:29','2026-10-06 15:52:29'),('f1a210d5-1fa9-43db-a10a-c147e46a93fa','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 20:11:47','2026-10-18 20:11:47'),('f262d4d0-49b1-476b-8f97-60204d633025','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 18:31:11','2026-10-01 18:31:11'),('f34a58c4-cc83-425c-b246-79d9d224024c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 20:29:56','2026-09-30 20:29:56'),('f3a86f73-0010-48bd-b8f2-5a7b51e3f79c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-30 18:29:03','2026-09-30 18:29:03'),('f465bd06-5a9d-4976-8f67-c79407464816','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 13:05:15','2026-10-27 13:05:15'),('f5a3a54c-1763-4e09-b62b-683de8b71e4f','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-15 18:24:00','2026-10-15 18:24:00'),('f5f1b2b4-dc2e-43c3-be8b-aa7956aa6b05','cust-0001-0001-0001-000000000001',NULL,NULL,'2026-10-27 12:19:53','2026-10-27 12:19:53'),('f6af6b90-1b27-4942-9254-07cfbf4a30a4','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 17:58:05','2026-10-06 17:58:05'),('f6f4c32b-fba2-43af-b900-f6be4b2f6e02','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 09:49:36','2026-10-16 09:49:36'),('f7b512e2-6fa2-4a6a-9b88-5a874a80ecb2','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 20:17:14','2026-10-18 20:17:14'),('f812b2a2-04a7-4923-94f4-a171c896b94c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-17 10:06:13','2026-10-17 10:06:13'),('f8a55d5e-f3aa-4d3e-aed1-bdd78bb2d0c3','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-18 19:43:35','2026-10-18 19:43:35'),('f8e1275d-f4d5-4bb6-83cf-b977c6b00e2c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-01 22:26:26','2026-10-01 22:26:26'),('f8f01bb3-ce9f-4030-9737-27f49da026a4','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 03:15:59','2026-10-05 03:15:59'),('f9cf08ac-cd13-4861-9573-b638ba0eec52','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-13 10:02:15','2026-10-13 10:02:15'),('f9db2160-3974-464d-8289-56e9541030f9','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-06 10:32:15','2026-10-06 10:32:15'),('f9de99a4-a3a5-4ac1-8249-7ced6a9d8c70','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-16 18:06:30','2026-10-16 18:06:30'),('fa8109bc-5263-4a9f-a78e-e5069750f35c','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-09-29 23:40:25','2026-09-29 23:40:25'),('fd3b92d0-5167-4f86-9577-e585eeaba3ea','31f1bff9-432d-48ab-8e12-dcfc38d46069','plumb',NULL,'2026-10-13 16:25:07','2026-10-13 16:25:07'),('fd45940b-16af-4b53-8cbc-3c784d0cf2ba','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-02 01:58:57','2026-10-02 01:58:57'),('fdd9d6b2-59e5-4ce0-9560-719b594aa514','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-14 15:48:37','2026-10-14 15:48:37'),('fe6c2762-9960-4906-a10c-ee5d91813fa7','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 17:49:22','2026-10-05 17:49:22'),('fea3b8a1-0dd0-492e-89af-f1ac18b10e7d','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,NULL,'2026-10-05 15:42:43','2026-10-05 15:42:43');
/*!40000 ALTER TABLE `recent_searches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recent_views`
--

DROP TABLE IF EXISTS `recent_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recent_views` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_service_view` int NOT NULL DEFAULT '0',
  `category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_category_view` int NOT NULL DEFAULT '0',
  `sub_category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_sub_category_view` int NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recent_views`
--

LOCK TABLES `recent_views` WRITE;
/*!40000 ALTER TABLE `recent_views` DISABLE KEYS */;
INSERT INTO `recent_views` VALUES ('02504090-c382-4762-a3ba-02f94149166e','31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000014',1,NULL,0,NULL,0,NULL,'2026-10-05 12:54:55','2026-10-05 12:54:55'),('4d3236d9-ff14-4a42-8f81-b5363784e06c','31f1bff9-432d-48ab-8e12-dcfc38d46069','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5',20,NULL,0,NULL,0,NULL,'2026-10-04 23:02:21','2026-10-27 10:54:06'),('547c455a-b259-48ec-8c8b-f0f0bf4ba577','cust-0001-0001-0001-000000000001','513bce46-8576-413f-9809-96ba2fb8a5f2',8,NULL,0,NULL,0,NULL,'2026-10-27 12:05:57','2026-10-27 17:00:52'),('719795a8-a63b-4962-a36c-544d72d28560','31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000003',2,NULL,0,NULL,0,NULL,'2026-10-17 10:03:40','2026-10-17 11:14:07'),('74bca677-c117-4b26-a262-cab0465471b7','cust-0001-0001-0001-000000000001','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5',3,NULL,0,NULL,0,NULL,'2026-10-27 15:36:17','2026-10-27 17:28:01'),('a1355a91-0a6a-4c96-a090-159f5ab9a8e6','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,0,'bc250cc5-990b-4864-aac1-c8dde7b63427',1,NULL,0,NULL,'2026-10-06 11:59:33','2026-10-06 11:59:33'),('a4ca73b8-559c-4d18-bc4f-1d4cce078507','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,0,'cat-0001-0001-0001-000000000001',18,NULL,0,NULL,'2026-09-28 19:39:02','2026-09-30 02:27:34'),('bcfc9c77-cc93-4b0e-8cd0-48b6d483a64b','cust-0001-0001-0001-000000000001','svc-0001-0001-0001-000000000001',7,NULL,0,NULL,0,NULL,'2026-10-27 12:06:26','2026-10-27 16:02:44'),('c0cd3868-392c-430b-a76d-c27c27699829','31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000007',2,NULL,0,NULL,0,NULL,'2026-09-17 23:45:51','2026-09-19 00:52:37'),('c78599b4-cedb-4ee9-931c-9ea5efa3b4d1','31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000005',2,NULL,0,NULL,0,NULL,'2026-09-19 00:31:20','2026-09-19 01:19:32'),('cac238e8-2596-4419-8c09-13849a405ac0','31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000001',86,NULL,0,NULL,0,NULL,'2026-09-17 23:45:18','2026-10-18 20:49:45'),('e2ec5d4d-fb5f-4344-92df-3df6d84523d7','31f1bff9-432d-48ab-8e12-dcfc38d46069',NULL,0,NULL,0,'cat-0002-0001-0001-000000000002',1,NULL,'2026-09-29 22:58:47','2026-09-29 22:58:47'),('e96bec64-fe45-40b4-8229-77184279a04f','31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000009',1,NULL,0,NULL,0,NULL,'2026-10-17 11:13:55','2026-10-17 11:13:55');
/*!40000 ALTER TABLE `recent_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_replies`
--

DROP TABLE IF EXISTS `review_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_replies` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `readable_id` bigint DEFAULT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `review_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_replies`
--

LOCK TABLES `review_replies` WRITE;
/*!40000 ALTER TABLE `review_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `readable_id` bigint NOT NULL,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serviceman_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `review_rating` int NOT NULL DEFAULT '1',
  `review_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `review_images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `booking_date` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES ('546046d1-c476-480a-8914-83816dfcb24e',1029100,'92960767-886f-457e-9ca1-dd880dfed02c','svc-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','sm-0001-0001-0001-000000000001',1,'bekar hai','[]','2026-10-12 14:12:51',1,'2026-10-17 10:42:30','2026-10-17 10:42:34','31f1bff9-432d-48ab-8e12-dcfc38d46069'),('b7462c86-2c0e-471a-b1fb-6eb837308824',1028100,'7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62','svc-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','sm-0001-0001-0001-000000000001',1,NULL,'[]','2026-10-12 10:45:44',1,'2026-10-17 12:35:01','2026-10-17 12:35:01','31f1bff9-432d-48ab-8e12-dcfc38d46069'),('rev-0001-0001-0001-000000000001',1,'bkg-0001-0001-0001-000000000001','svc-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','sm-0001-0001-0001-000000000001',5,'Excellent deep cleaning! Very professional team. House has never looked this clean.','[]','2026-08-28 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000001'),('rev-0001-0001-0001-000000000002',2,'bkg-0001-0001-0001-000000000002','svc-0001-0001-0001-000000000009','prvd-0001-0001-0001-000000000003','sm-0001-0001-0001-000000000005',4,'Good fan installation. Came on time and finished quickly.','[]','2026-08-29 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000002'),('rev-0001-0001-0001-000000000003',3,'bkg-0001-0001-0001-000000000003','svc-0001-0001-0001-000000000014','prvd-0001-0001-0001-000000000004','sm-0001-0001-0001-000000000007',5,'AC servicing was top-notch. Cooling like new. Technician was knowledgeable.','[]','2026-08-31 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000003'),('rev-0001-0001-0001-000000000004',4,'bkg-0001-0001-0001-000000000004','svc-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','sm-0001-0001-0001-000000000002',4,'Very good cleaning. Used coupon for discount. Will book again.','[]','2026-09-02 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000005'),('rev-0001-0001-0001-000000000005',5,'bkg-0001-0001-0001-000000000005','svc-0001-0001-0001-000000000005','prvd-0001-0001-0001-000000000002','sm-0001-0001-0001-000000000003',5,'Plumber fixed leakage quickly. Fair pricing and quality work.','[]','2026-09-04 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000007'),('rev-0001-0001-0001-000000000006',6,'bkg-0001-0001-0001-000000000006','svc-0001-0001-0001-000000000013','prvd-0001-0001-0001-000000000005','sm-0001-0001-0001-000000000008',4,'AC gas refill done properly. Cooling improved significantly.','[]','2026-09-05 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000008'),('rev-0001-0001-0001-000000000007',7,'bkg-0001-0001-0001-000000000015','svc-0001-0001-0001-000000000007','prvd-0001-0001-0001-000000000004','sm-0001-0001-0001-000000000007',3,'Basic repair was okay. Tap still dripping slightly.','[]','2026-08-23 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000005'),('rev-0001-0001-0001-000000000008',8,'bkg-0001-0001-0001-000000000016','svc-0001-0001-0001-000000000013','prvd-0001-0001-0001-000000000005','sm-0001-0001-0001-000000000008',5,'R32 gas refill perfect. AC working at full capacity.','[]','2026-08-21 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000010'),('rev-0001-0001-0001-000000000009',9,'bkg-0001-0001-0001-000000000017','svc-0001-0001-0001-000000000007','prvd-0001-0001-0001-000000000002','sm-0001-0001-0001-000000000004',4,'Faucet replacement done quickly. Good quality parts.','[]','2026-08-18 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000001'),('rev-0001-0001-0001-000000000010',10,'bkg-0001-0001-0001-000000000018','svc-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','sm-0001-0001-0001-000000000001',5,'Amazing 3BHK deep cleaning! Every corner spotless. Worth every rupee.','[]','2026-08-15 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000008'),('rev-0001-0001-0001-000000000011',11,'bkg-0001-0001-0001-000000000019','svc-0001-0001-0001-000000000010','prvd-0001-0001-0001-000000000003','sm-0001-0001-0001-000000000005',4,'Switch replacement done efficiently. All new switches working fine.','[]','2026-08-13 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000004'),('rev-0001-0001-0001-000000000012',12,'bkg-0001-0001-0001-000000000020','svc-0001-0001-0001-000000000015','prvd-0001-0001-0001-000000000004','sm-0001-0001-0001-000000000007',5,'Best pest control! Cockroaches eliminated. 3-month guarantee given.','[]','2026-08-11 15:45:55',1,'2026-09-12 15:45:55','2026-09-12 15:45:55','cust-0001-0001-0001-000000000006');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_accesses`
--

DROP TABLE IF EXISTS `role_accesses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_accesses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `can_view` tinyint NOT NULL DEFAULT '1',
  `can_add` tinyint NOT NULL DEFAULT '0',
  `can_update` tinyint NOT NULL DEFAULT '0',
  `can_delete` tinyint NOT NULL DEFAULT '0',
  `can_export` tinyint NOT NULL DEFAULT '0',
  `can_manage_status` tinyint NOT NULL DEFAULT '0',
  `can_approve_or_deny` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `can_assign_serviceman` tinyint NOT NULL DEFAULT '0',
  `can_give_feedback` tinyint NOT NULL DEFAULT '0',
  `can_take_backup` tinyint NOT NULL DEFAULT '0',
  `can_change_status` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_accesses`
--

LOCK TABLES `role_accesses` WRITE;
/*!40000 ALTER TABLE `role_accesses` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_accesses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route_search_histories`
--

DROP TABLE IF EXISTS `route_search_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route_search_histories` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `route_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `route_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `route_full_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `response` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route_search_histories`
--

LOCK TABLES `route_search_histories` WRITE;
/*!40000 ALTER TABLE `route_search_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `route_search_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searched_data`
--

DROP TABLE IF EXISTS `searched_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `searched_data` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attribute` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `response_data_count` int NOT NULL DEFAULT '0',
  `volume` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searched_data`
--

LOCK TABLES `searched_data` WRITE;
/*!40000 ALTER TABLE `searched_data` DISABLE KEYS */;
INSERT INTO `searched_data` VALUES ('73c9e827-d541-435d-bcbf-ecdad0802848','31f1bff9-432d-48ab-8e12-dcfc38d46069','c00ed508-2bf3-43c3-b95c-8e880de67168','search','2d8ee524-e5fb-420a-b447-6e7b1b5744db',3,1,'2026-09-26 21:11:59','2026-09-26 21:11:59'),('81b624d3-cc88-4479-9bfb-216c33113555','31f1bff9-432d-48ab-8e12-dcfc38d46069','6b1c8733-b0ff-4c65-a745-1f46419adc49','search','c64cb4db-31d8-4fe1-af2d-fd068b123540',0,1,'2026-10-13 15:43:31','2026-10-13 15:43:31'),('acf4b3fc-1c5f-4fa5-b105-259774ce5865','31f1bff9-432d-48ab-8e12-dcfc38d46069','6b1c8733-b0ff-4c65-a745-1f46419adc49','search','5cb37085-2c26-40dc-a22a-9b9601c0e1dc',0,1,'2026-10-13 15:43:31','2026-10-13 15:43:31'),('bf265fbe-2951-434d-825c-cc01b2a9fc0e','31f1bff9-432d-48ab-8e12-dcfc38d46069','6b1c8733-b0ff-4c65-a745-1f46419adc49','search','5f7e666f-0a6d-48c5-b36f-a6d2d3e313ec',0,1,'2026-10-13 16:25:07','2026-10-13 16:25:07'),('cae52c28-e52d-4519-927b-99143c7e9373','cust-0001-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49','search','9a9518a5-2fa3-4495-aa71-cb0264c7cebc',132,22,'2026-10-27 12:05:18','2026-10-27 17:21:02'),('e1543189-95d6-491f-8541-571e8b97c984','31f1bff9-432d-48ab-8e12-dcfc38d46069','c00ed508-2bf3-43c3-b95c-8e880de67168','search','9a9518a5-2fa3-4495-aa71-cb0264c7cebc',2139,336,'2026-09-29 22:23:38','2026-10-19 13:19:13'),('f2fdd098-e1eb-422a-b2db-35a085242fdf','31f1bff9-432d-48ab-8e12-dcfc38d46069','a1614dbe-4732-11ee-9702-dee6e8d77be4','search','25944b7f-9fde-4684-a092-3bb062c2dafe',5,1,'2026-09-18 19:42:14','2026-09-18 19:42:14');
/*!40000 ALTER TABLE `searched_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seo_settings`
--

DROP TABLE IF EXISTS `seo_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seo_settings` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `canonicals_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `index` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_follow` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_image_index` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_archive` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_snippet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_snippet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_snippet_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_video_preview` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_video_preview_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_image_preview` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_image_preview_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seo_settings`
--

LOCK TABLES `seo_settings` WRITE;
/*!40000 ALTER TABLE `seo_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `seo_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_requests`
--

DROP TABLE IF EXISTS `service_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_requests` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:guid)',
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'pending,accepted,denied',
  `admin_feedback` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_requests`
--

LOCK TABLES `service_requests` WRITE;
/*!40000 ALTER TABLE `service_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_tag`
--

DROP TABLE IF EXISTS `service_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_tag` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_tag`
--

LOCK TABLES `service_tag` WRITE;
/*!40000 ALTER TABLE `service_tag` DISABLE KEYS */;
INSERT INTO `service_tag` VALUES (1,'svc-0001-0001-0001-000000000001','1',NULL,NULL),(2,'svc-0001-0001-0001-000000000001','2',NULL,NULL),(3,'513bce46-8576-413f-9809-96ba2fb8a5f2','6',NULL,NULL),(4,'513bce46-8576-413f-9809-96ba2fb8a5f2','7',NULL,NULL),(5,'513bce46-8576-413f-9809-96ba2fb8a5f2','8',NULL,NULL),(6,'513bce46-8576-413f-9809-96ba2fb8a5f2','9',NULL,NULL),(7,'513bce46-8576-413f-9809-96ba2fb8a5f2','10',NULL,NULL),(8,'513bce46-8576-413f-9809-96ba2fb8a5f2','11',NULL,NULL);
/*!40000 ALTER TABLE `service_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serviceman_categories`
--

DROP TABLE IF EXISTS `serviceman_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serviceman_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `serviceman_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sm_sub_cat_unique` (`serviceman_id`,`sub_category_id`),
  KEY `serviceman_categories_serviceman_id_index` (`serviceman_id`),
  KEY `serviceman_categories_sub_category_id_index` (`sub_category_id`),
  KEY `serviceman_categories_category_id_index` (`category_id`),
  CONSTRAINT `serviceman_categories_serviceman_id_foreign` FOREIGN KEY (`serviceman_id`) REFERENCES `servicemen` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serviceman_categories`
--

LOCK TABLES `serviceman_categories` WRITE;
/*!40000 ALTER TABLE `serviceman_categories` DISABLE KEYS */;
INSERT INTO `serviceman_categories` VALUES (5,'sm-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','2026-10-18 17:22:49','2026-10-18 17:22:49'),(6,'sm-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001','2026-10-18 17:22:49','2026-10-18 17:22:49'),(7,'sm-0001-0001-0001-000000000002','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','2026-10-22 08:00:06','2026-10-22 08:00:06'),(8,'sm-0001-0001-0001-000000000003','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','2026-10-22 10:17:38','2026-10-22 10:17:38'),(9,'sm-0001-0001-0001-000000000004','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','2026-10-22 10:17:38','2026-10-22 10:17:38'),(10,'sm-0001-0001-0001-000000000005','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','2026-10-22 10:17:38','2026-10-22 10:17:38'),(11,'sm-0001-0001-0001-000000000006','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','2026-10-22 10:17:38','2026-10-22 10:17:38'),(12,'sm-0001-0001-0001-000000000007','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','2026-10-22 10:17:38','2026-10-22 10:17:38'),(13,'sm-0001-0001-0001-000000000008','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','2026-10-22 10:17:38','2026-10-22 10:17:38');
/*!40000 ALTER TABLE `serviceman_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicemen`
--

DROP TABLE IF EXISTS `servicemen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicemen` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_repeat_request` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `is_on_duty` tinyint NOT NULL DEFAULT '1' COMMENT '1=ready for jobs, 0=offline',
  PRIMARY KEY (`id`),
  KEY `servicemen_provider_id_index` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicemen`
--

LOCK TABLES `servicemen` WRITE;
/*!40000 ALTER TABLE `servicemen` DISABLE KEYS */;
INSERT INTO `servicemen` VALUES ('sm-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001',0,'sman-0001-0001-0001-000000000001','2026-09-12 15:45:50','2026-10-15 17:45:59',NULL,1),('sm-0001-0001-0001-000000000002','prvd-0001-0001-0001-000000000001',0,'sman-0001-0001-0001-000000000002','2026-09-12 15:45:50','2026-09-12 15:45:50',NULL,1),('sm-0001-0001-0001-000000000003','prvd-0001-0001-0001-000000000002',0,'sman-0001-0001-0001-000000000003','2026-09-12 15:45:50','2026-09-12 15:45:50',NULL,1),('sm-0001-0001-0001-000000000004','prvd-0001-0001-0001-000000000002',0,'sman-0001-0001-0001-000000000004','2026-09-12 15:45:50','2026-09-12 15:45:50',NULL,1),('sm-0001-0001-0001-000000000005','prvd-0001-0001-0001-000000000003',0,'sman-0001-0001-0001-000000000005','2026-09-12 15:45:50','2026-09-12 15:45:50',NULL,1),('sm-0001-0001-0001-000000000006','prvd-0001-0001-0001-000000000003',0,'sman-0001-0001-0001-000000000006','2026-09-12 15:45:50','2026-09-12 15:45:50',NULL,1),('sm-0001-0001-0001-000000000007','prvd-0001-0001-0001-000000000004',0,'sman-0001-0001-0001-000000000007','2026-09-12 15:45:50','2026-09-12 15:45:50',NULL,1),('sm-0001-0001-0001-000000000008','prvd-0001-0001-0001-000000000005',0,'sman-0001-0001-0001-000000000008','2026-09-12 15:45:50','2026-09-12 15:45:50',NULL,1);
/*!40000 ALTER TABLE `servicemen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_service_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approval_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'approved',
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cover_image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gallery` text COLLATE utf8mb4_unicode_ci,
  `cover_images` text COLLATE utf8mb4_unicode_ci,
  `cover_video` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover_media_type` tinyint NOT NULL DEFAULT '0' COMMENT '0:cover_image, 1:cover_images, 2:cover_video',
  `thumbnail` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax` decimal(24,3) NOT NULL DEFAULT '0.000',
  `order_count` int unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_single_provider` tinyint(1) NOT NULL DEFAULT '0',
  `single_provider_mode` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `single_provider_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating_count` int unsigned NOT NULL DEFAULT '0',
  `avg_rating` double(8,4) NOT NULL DEFAULT '0.0000',
  `min_bidding_price` decimal(24,3) NOT NULL DEFAULT '0.000',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `services_slug_unique` (`slug`),
  KEY `services_provider_id_index` (`provider_id`),
  KEY `services_zone_id_index` (`zone_id`),
  KEY `services_parent_service_id_index` (`parent_service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES ('2e079f76-18b9-4674-bd1e-639a7ff17015','prvd-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4',NULL,'approved','Test Fan Service XYZ','test-fan-service-xyz','Test short desc','Test full description','2026-10-04-6ac0f919b3076.webp',NULL,NULL,NULL,0,NULL,'cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000009',0.000,0,1,0,NULL,NULL,0,0.0000,0.000,'2026-10-04 01:46:21','2026-10-04 01:46:17','2026-10-04 01:46:21'),('39424600-c420-42f4-a925-681ac1bf9993','prvd-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4','cd4d6231-88ca-4ab8-8611-22eb63931792','approved','Emergency Fan Repair','emergency-fan-repair-1','24x7 fan repair at your door','We diagnose and repair all ceiling and pedestal fans.',NULL,NULL,NULL,NULL,0,NULL,'cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000009',0.000,0,1,0,NULL,NULL,0,0.0000,0.000,NULL,'2026-10-04 03:26:57','2026-10-04 03:26:57'),('513bce46-8576-413f-9809-96ba2fb8a5f2',NULL,NULL,NULL,'approved','jass','jass','service','<p>badiya hai lele bhai</p>','2026-10-26-6adf22684dcd4.png','[\"2026-10-26-6adf226ebad02.png\"]','[]',NULL,0,'2026-10-26-6adf22693b6e1.png','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001',0.000,0,1,0,NULL,NULL,0,0.0000,100.000,NULL,'2026-10-26 14:50:38','2026-10-27 11:40:12'),('79796925-a923-4dac-a9f8-e1bee4ef7798','prvd-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4','svc-0001-0001-0001-000000000009','approved','Ceiling Fan Installation','ceiling-fan-installation-1','Same-day fan fitting by trained electrician','Professional ceiling fan installation including proper wiring mounting and balancing.',NULL,NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000009',18.000,0,1,0,NULL,NULL,0,0.0000,0.000,NULL,'2026-10-04 01:15:42','2026-10-04 01:45:58'),('99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5',NULL,NULL,NULL,'approved','Door Work','door-work','hi','<p>hi</p>','2026-10-12-6accab9503fea.png','[\"2026-10-12-6accd16a3d5e2.png\"]','[\"2026-10-12-6accab96967d2.png\",\"2026-10-12-6accaf4b235f6.png\",\"2026-10-12-6accd1691295a.png\"]',NULL,2,'2026-10-04-6ac21cd0d4cbf.png','bc250cc5-990b-4864-aac1-c8dde7b63427','8a904eea-a4ce-4482-8100-abd9f8cd8a69',0.000,0,1,0,NULL,NULL,0,0.0000,10.000,NULL,'2026-10-04 22:30:59','2026-10-12 17:24:11'),('cd4d6231-88ca-4ab8-8611-22eb63931792','prvd-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4',NULL,'approved','Emergency Fan Repair','emergency-fan-repair','24x7 fan repair at your door','We diagnose and repair all ceiling and pedestal fans.','2026-10-04-6ac0f37e9b821.webp',NULL,NULL,NULL,0,NULL,'cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000009',0.000,0,1,0,NULL,NULL,0,0.0000,0.000,NULL,'2026-10-04 01:22:22','2026-10-04 01:27:37'),('svc-0001-0001-0001-000000000001',NULL,NULL,NULL,'approved','Full Home Deep Cleaning','full-home-deep-cleaning','Complete deep cleaning for 2BHK/3BHK','<p>Professional deep cleaning covering all rooms kitchen bathrooms. Includes floor mopping dusting window cleaning and sanitization.</p>','2026-09-25-6ab514bfe0f83.png','[\"2026-09-25-6ab51156ec05f.png\"]',NULL,NULL,0,'2026-09-24-6ab5025d336c5.png','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',18.000,120,1,0,NULL,NULL,95,4.6000,12.000,NULL,'2026-09-12 15:45:55','2026-10-16 15:03:51'),('svc-0001-0001-0001-000000000002',NULL,NULL,NULL,'approved','Regular Home Cleaning','regular-home-cleaning','Daily or weekly maintenance cleaning','Regular cleaning service for daily or weekly maintenance. Includes sweeping mopping dusting and bathroom cleaning.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002',18.000,200,1,0,NULL,NULL,150,4.4000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000003',NULL,NULL,NULL,'approved','Sofa and Upholstery Cleaning','sofa-upholstery-cleaning','Professional sofa shampooing','Deep cleaning of sofas chairs and upholstery using professional equipment and eco-friendly solutions.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000003',18.000,85,1,0,NULL,NULL,60,4.5000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000004',NULL,NULL,NULL,'approved','Carpet and Rug Cleaning','carpet-rug-cleaning','Deep carpet and rug cleaning','Steam cleaning and shampooing for all types of carpets and rugs. Removes stains allergens and dirt.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000004',18.000,45,1,0,NULL,NULL,30,4.3000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000005',NULL,NULL,NULL,'approved','Pipe Leakage Repair','pipe-leakage-repair','Fix all types of pipe leaks','Expert repair for leaking pipes burst pipes and pipe joint issues. Quality materials for long-lasting repairs.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000002','cat-0002-0001-0001-000000000005',18.000,90,1,0,NULL,NULL,72,4.7000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000006',NULL,NULL,NULL,'approved','Toilet Repair and Installation','toilet-repair-installation','All toilet repair and new installation','Comprehensive toilet repair including flush repair seat replacement clogging and new toilet installation.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000002','cat-0002-0001-0001-000000000006',18.000,65,1,0,NULL,NULL,48,4.5000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000007',NULL,NULL,NULL,'approved','Tap and Faucet Repair','tap-faucet-repair','Fix dripping taps and replace faucets','Stop that annoying drip! We repair and replace all types of taps faucets and valves.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000002','cat-0002-0001-0001-000000000007',18.000,110,1,0,NULL,NULL,88,4.4000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000008',NULL,NULL,NULL,'approved','Water Tank Cleaning','water-tank-cleaning','Overhead and underground tank cleaning','Complete water tank cleaning and sanitization service. Removes sediment algae and bacteria.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000002','cat-0002-0001-0001-000000000008',18.000,35,1,0,NULL,NULL,28,4.6000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000009',NULL,NULL,NULL,'approved','Ceiling Fan Installation','ceiling-fan-installation','Install ceiling fans with wiring','Professional ceiling fan installation including proper wiring mounting and balancing.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000009',18.000,150,1,0,NULL,NULL,120,4.8000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000010',NULL,NULL,NULL,'approved','Switch and Socket Replacement','switch-socket-replacement','Replace faulty switches and sockets','Replace damaged or faulty switches sockets and regulators. Branded ISI certified products.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000010',18.000,95,1,0,NULL,NULL,78,4.5000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000011',NULL,NULL,NULL,'approved','Complete House Wiring','complete-house-wiring','Full house wiring and rewiring','New house wiring rewiring and modular switch installation. All safety standards followed.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000011',18.000,25,1,0,NULL,NULL,20,4.7000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000012',NULL,NULL,NULL,'approved','AC Installation Split and Window','ac-installation-split-window','Professional AC installation','Expert AC installation for split and window ACs. Includes mounting piping gas charging.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000008','cat-0002-0001-0001-000000000012',18.000,180,1,0,NULL,NULL,140,4.6000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000013',NULL,NULL,NULL,'approved','AC Gas Refill and Charging','ac-gas-refill-charging','AC gas top-up and leak detection','AC gas refill with original R22/R32/R410A gas. Includes leak detection and pressure testing.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000008','cat-0002-0001-0001-000000000013',18.000,220,1,0,NULL,NULL,180,4.5000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000014',NULL,NULL,NULL,'approved','AC General Servicing','ac-general-servicing','Complete AC servicing and cleaning','AC general servicing including filter cleaning coil washing gas check and performance testing.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000008','cat-0002-0001-0001-000000000014',18.000,300,1,0,NULL,NULL,250,4.7000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55'),('svc-0001-0001-0001-000000000015',NULL,NULL,NULL,'approved','Pest Control Service','pest-control-service','Complete home pest control','Professional pest control for cockroaches termites mosquitoes and rats. Safe eco-friendly chemicals.','2023-08-31-64ef3a3e696a2.png',NULL,NULL,NULL,0,'2023-08-31-64ef3a3e6d6c0.png','cat-0001-0001-0001-000000000007',NULL,18.000,75,1,0,NULL,NULL,55,4.4000,0.000,NULL,'2026-09-12 15:45:55','2026-09-12 15:45:55');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_tutorials`
--

DROP TABLE IF EXISTS `settings_tutorials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings_tutorials` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` json DEFAULT NULL,
  `platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `settings_tutorials_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_tutorials`
--

LOCK TABLES `settings_tutorials` WRITE;
/*!40000 ALTER TABLE `settings_tutorials` DISABLE KEYS */;
INSERT INTO `settings_tutorials` VALUES ('e1126b1d-b3d7-4ae8-9f7a-ad4e60edb0bd','prvd-0001-0001-0001-000000000001','{\"payment_information\": 1, \"business_information\": 1, \"service_availability\": 1, \"service_subscription\": 1}','app','2026-09-22 23:01:43','2026-10-04 03:18:04'),('e4c2212f-f294-4e44-89f8-421f7082eeba','prvd-0001-0001-0001-000000000002','{\"business_plan\": 1}','web','2026-09-13 22:02:32','2026-09-13 22:02:32'),('ed2b4215-48a0-43ae-83c9-665719e2638b','8be51d97-6fe0-4d46-a9c6-d77b4d2386f5','{\"login_option\": 1, \"digital_payment\": 1, \"email_configuration\": 1, \"business_information\": 1}','web','2026-09-15 18:09:06','2026-10-05 04:49:04');
/*!40000 ALTER TABLE `settings_tutorials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storages`
--

DROP TABLE IF EXISTS `storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storages` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_column` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `storage_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `storages_model_id_index` (`model_id`),
  KEY `storages_model_column_index` (`model_column`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storages`
--

LOCK TABLES `storages` WRITE;
/*!40000 ALTER TABLE `storages` DISABLE KEYS */;
/*!40000 ALTER TABLE `storages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscribe_newsletters`
--

DROP TABLE IF EXISTS `subscribe_newsletters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribe_newsletters` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscribe_newsletters_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribe_newsletters`
--

LOCK TABLES `subscribe_newsletters` WRITE;
/*!40000 ALTER TABLE `subscribe_newsletters` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscribe_newsletters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscribed_services`
--

DROP TABLE IF EXISTS `subscribed_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribed_services` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assign_type` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'specific',
  `is_subscribed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribed_services`
--

LOCK TABLES `subscribed_services` WRITE;
/*!40000 ALTER TABLE `subscribed_services` DISABLE KEYS */;
INSERT INTO `subscribed_services` VALUES ('108caa76-991f-4642-b17c-6f10cbf4a0ae','prvd-0001-0001-0001-000000000002','bc250cc5-990b-4864-aac1-c8dde7b63427','8a904eea-a4ce-4482-8100-abd9f8cd8a69','6b1c8733-b0ff-4c65-a745-1f46419adc49','complete',1,'2026-10-26 11:27:11','2026-10-26 11:27:11'),('11bb0933-8f3c-45b4-824c-65094abcf839','prvd-0001-0001-0001-000000000002','bc250cc5-990b-4864-aac1-c8dde7b63427','8a904eea-a4ce-4482-8100-abd9f8cd8a69','c00ed508-2bf3-43c3-b95c-8e880de67168','complete',0,'2026-10-05 03:49:14','2026-10-05 03:49:14'),('19305983-2418-49f0-9465-8dbaa0130fb8','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','c00ed508-2bf3-43c3-b95c-8e880de67168','specific',0,'2026-10-12 10:32:28','2026-10-12 10:32:28'),('1f6866fe-1bfb-46f8-8e1a-a9debfe2fa06','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000004','6b1c8733-b0ff-4c65-a745-1f46419adc49','specific',1,'2026-10-26 11:11:00','2026-10-26 11:11:00'),('3736b47f-0750-4d76-9469-4e17ae481f81','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49','specific',1,'2026-10-26 11:11:00','2026-10-26 11:11:00'),('6dce44cf-f73e-4317-88a5-9de1a4a84727','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168','specific',0,'2026-10-12 10:32:28','2026-10-12 10:32:28'),('8010d0db-75a5-48c4-bf5b-97b0ff589be2','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000002','6b1c8733-b0ff-4c65-a745-1f46419adc49','specific',1,'2026-10-26 11:11:00','2026-10-26 11:11:00'),('84542981-1e9d-4bd6-be91-1b21ac43cc78','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000009','c00ed508-2bf3-43c3-b95c-8e880de67168','specific',0,'2026-10-12 10:32:28','2026-10-12 10:32:28'),('9466d9d7-b5e1-448a-b22f-634438f8198e','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000004','c00ed508-2bf3-43c3-b95c-8e880de67168','specific',0,'2026-10-12 10:32:28','2026-10-12 10:32:28'),('c845b980-79fc-4b92-b33d-3abd76174141','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000003','6b1c8733-b0ff-4c65-a745-1f46419adc49','specific',1,'2026-10-26 11:11:00','2026-10-26 11:11:00'),('cf9e2620-2dbe-4de4-81aa-59cd83809620','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000010','6b1c8733-b0ff-4c65-a745-1f46419adc49','specific',1,'2026-10-26 11:11:00','2026-10-26 11:11:00'),('d4cc5df2-6058-4704-9d26-cacf89d02536','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000009','6b1c8733-b0ff-4c65-a745-1f46419adc49','specific',1,'2026-10-26 11:11:00','2026-10-26 11:11:00'),('d79d9376-15a6-4f0c-a75d-bcb108cb7c6f','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000003','c00ed508-2bf3-43c3-b95c-8e880de67168','specific',0,'2026-10-12 10:32:28','2026-10-12 10:32:28'),('ee97d5fd-6b15-4640-b848-59c6e7ff0d2a','prvd-0001-0001-0001-000000000001','cat-0001-0001-0001-000000000003','cat-0002-0001-0001-000000000010','c00ed508-2bf3-43c3-b95c-8e880de67168','specific',0,'2026-10-12 10:32:28','2026-10-12 10:32:28'),('f4fef446-fddf-4424-805e-de0ff4ec9477','prvd-0001-0001-0001-000000000005','cat-0001-0001-0001-000000000008','cat-0002-0001-0001-000000000014','a1614dbe-4732-11ee-9702-dee6e8d77be4','specific',1,'2026-10-02 18:03:35','2026-10-03 02:08:02'),('f845ebb0-9eaa-4f3b-aa28-ab35944d7018','prvd-0001-0001-0001-000000000003','cat-0001-0001-0001-000000000001','cat-0002-0001-0001-000000000003','a1614dbe-4732-11ee-9702-dee6e8d77be4','specific',1,'2026-10-02 18:03:35','2026-10-03 02:08:02'),('fe80e1d3-7602-4ef1-8b7c-284986339b63','prvd-0001-0001-0001-000000000003','cat-0001-0001-0001-000000000002','cat-0002-0001-0001-000000000006','a1614dbe-4732-11ee-9702-dee6e8d77be4','specific',1,'2026-10-02 18:03:35','2026-10-03 02:08:02');
/*!40000 ALTER TABLE `subscribed_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_booking_types`
--

DROP TABLE IF EXISTS `subscription_booking_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_booking_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_booking_types`
--

LOCK TABLES `subscription_booking_types` WRITE;
/*!40000 ALTER TABLE `subscription_booking_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_booking_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_package_features`
--

DROP TABLE IF EXISTS `subscription_package_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_package_features` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscription_package_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_package_features`
--

LOCK TABLES `subscription_package_features` WRITE;
/*!40000 ALTER TABLE `subscription_package_features` DISABLE KEYS */;
INSERT INTO `subscription_package_features` VALUES ('2985725d-c0a3-4405-af17-82f6155bf0a1','7d1e1afb-efd2-47e8-8f8b-1bc970b04354','service_request','2026-10-03 06:22:35','2026-10-03 06:22:35'),('2be510c7-6272-4e26-8f36-5acf13255253','7d1e1afb-efd2-47e8-8f8b-1bc970b04354','schedule_service','2026-10-03 06:22:35','2026-10-03 06:22:35'),('2c851601-be92-4dfd-962a-e11775e9c723','7d1e1afb-efd2-47e8-8f8b-1bc970b04354','review','2026-10-03 06:22:35','2026-10-03 06:22:35'),('63cbfd9e-7905-4d85-9e78-a2b880157a3a','7d1e1afb-efd2-47e8-8f8b-1bc970b04354','mobile_app','2026-10-03 06:22:35','2026-10-03 06:22:35'),('75c9b0a3-e70f-4a9a-9329-82070996f59c','7d1e1afb-efd2-47e8-8f8b-1bc970b04354','advertisement','2026-10-03 06:22:35','2026-10-03 06:22:35'),('7de9fb6f-5c5a-44c3-be96-c556c36d1cc1','7d1e1afb-efd2-47e8-8f8b-1bc970b04354','bidding','2026-10-03 06:22:35','2026-10-03 06:22:35'),('aba9edfb-04e6-4f3d-86a4-baf9e944aeba','7d1e1afb-efd2-47e8-8f8b-1bc970b04354','reports_&_analytics','2026-10-03 06:22:35','2026-10-03 06:22:35'),('b7c1c929-35d5-4511-be92-0c42dca0a173','7d1e1afb-efd2-47e8-8f8b-1bc970b04354','chat','2026-10-03 06:22:35','2026-10-03 06:22:35');
/*!40000 ALTER TABLE `subscription_package_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_package_limits`
--

DROP TABLE IF EXISTS `subscription_package_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_package_limits` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscription_package_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_limited` tinyint(1) NOT NULL DEFAULT '1',
  `limit_count` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_package_limits`
--

LOCK TABLES `subscription_package_limits` WRITE;
/*!40000 ALTER TABLE `subscription_package_limits` DISABLE KEYS */;
INSERT INTO `subscription_package_limits` VALUES ('9d247a33-c4a6-4acd-9d01-33821a7af6d5','7d1e1afb-efd2-47e8-8f8b-1bc970b04354','booking',0,0,'2026-10-03 06:22:35','2026-10-03 06:22:35'),('afe1d9e6-bfa9-4528-8fb8-6c29a7e6f646','7d1e1afb-efd2-47e8-8f8b-1bc970b04354','category',0,0,'2026-10-03 06:22:35','2026-10-03 06:22:35');
/*!40000 ALTER TABLE `subscription_package_limits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_packages`
--

DROP TABLE IF EXISTS `subscription_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_packages` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(24,2) NOT NULL DEFAULT '0.00',
  `duration` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_packages`
--

LOCK TABLES `subscription_packages` WRITE;
/*!40000 ALTER TABLE `subscription_packages` DISABLE KEYS */;
INSERT INTO `subscription_packages` VALUES ('7d1e1afb-efd2-47e8-8f8b-1bc970b04354','new',1500.00,30,1,'not','2026-10-03 06:22:35','2026-10-03 06:22:35');
/*!40000 ALTER TABLE `subscription_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_subscriber_bookings`
--

DROP TABLE IF EXISTS `subscription_subscriber_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_subscriber_bookings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `provider_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_subscriber_log_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_subscriber_bookings`
--

LOCK TABLES `subscription_subscriber_bookings` WRITE;
/*!40000 ALTER TABLE `subscription_subscriber_bookings` DISABLE KEYS */;
INSERT INTO `subscription_subscriber_bookings` VALUES (2,NULL,'f8a2fc22-79f2-4333-96e9-7e564a3f9246',NULL,'2026-10-02 18:35:12','2026-10-02 18:45:47'),(3,NULL,'52c8ec66-d962-40f5-84ad-4b4cd73c8631',NULL,'2026-10-02 18:39:19','2026-10-02 18:49:07'),(4,'prvd-0001-0001-0001-000000000001','7f4ba9ec-0cf5-4671-b725-89160062b3f2',NULL,'2026-10-02 18:47:06','2026-10-02 18:47:06'),(18,'prvd-0001-0001-0001-000000000001','0978aaa3-bde3-4438-a245-b9c7dbebfd62',NULL,'2026-10-04 07:06:28','2026-10-04 07:06:28'),(19,'prvd-0001-0001-0001-000000000001','793bc200-73cc-4d88-b168-8fbc6d014840',NULL,'2026-10-07 17:11:03','2026-10-07 17:11:03'),(20,'prvd-0001-0001-0001-000000000001','b88bab80-6999-4fb8-975d-2c8f0694ccb8',NULL,'2026-10-09 17:47:48','2026-10-09 17:47:48'),(21,'prvd-0001-0001-0001-000000000002','3340ac66-4cb5-47fd-abbb-945c7265642a',NULL,'2026-10-12 10:41:40','2026-10-12 10:41:40'),(22,'prvd-0001-0001-0001-000000000001','7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62',NULL,'2026-10-12 10:45:44','2026-10-12 10:45:44'),(23,'prvd-0001-0001-0001-000000000001','92960767-886f-457e-9ca1-dd880dfed02c',NULL,'2026-10-12 14:12:51','2026-10-12 14:12:51'),(24,'prvd-0001-0001-0001-000000000001','1ad4108d-50b7-4087-ae27-3a8c959c4247',NULL,'2026-10-13 18:06:00','2026-10-13 18:06:00'),(25,'prvd-0001-0001-0001-000000000001','045e05ee-79de-4f7b-8f9e-5d3e81b159b9',NULL,'2026-10-14 10:25:36','2026-10-14 10:25:36'),(26,'prvd-0001-0001-0001-000000000001','7f3678b6-f9f3-42e5-a46d-5ad9ea81a162',NULL,'2026-10-14 10:30:58','2026-10-14 10:30:58'),(27,'prvd-0001-0001-0001-000000000001','5f45385f-3e6e-433b-b1de-2f4b56143e03',NULL,'2026-10-14 10:33:25','2026-10-14 10:33:25'),(28,'prvd-0001-0001-0001-000000000001','bac3a7c1-d2b8-4e37-9901-61a4e8216c9a',NULL,'2026-10-14 10:34:42','2026-10-14 10:34:42'),(29,'prvd-0001-0001-0001-000000000001','bc86c09e-6a09-4bc8-8018-0b0528d3fcd4',NULL,'2026-10-14 10:36:56','2026-10-14 10:36:56'),(30,'prvd-0001-0001-0001-000000000001','d5925f5c-5bdb-4d34-895f-6cac40a9be7f',NULL,'2026-10-14 10:37:08','2026-10-14 10:37:08'),(31,'prvd-0001-0001-0001-000000000001','f7343c12-59cf-4ed2-8412-b100ecd83050',NULL,'2026-10-14 10:37:45','2026-10-14 10:37:45'),(32,'prvd-0001-0001-0001-000000000001','e90e21ac-aed6-45d4-b9b4-b4240f1da37d',NULL,'2026-10-14 10:38:11','2026-10-14 10:38:11'),(33,'prvd-0001-0001-0001-000000000001','0d5bfd23-a8c9-4793-8bc4-40535c29c9ee',NULL,'2026-10-14 10:38:42','2026-10-14 10:38:42'),(34,'prvd-0001-0001-0001-000000000001','4eb7f298-418b-45cd-b3d9-bb05329fbf50',NULL,'2026-10-14 10:39:21','2026-10-14 10:39:21'),(35,NULL,'0f68ead5-e564-46ee-8eab-3acded861f93',NULL,'2026-10-14 10:43:50','2026-10-14 14:11:02'),(36,'prvd-0001-0001-0001-000000000001','09aa1dcb-32ec-4230-9ef4-c71fed46410e',NULL,'2026-10-14 10:47:02','2026-10-14 10:47:02'),(37,'prvd-0001-0001-0001-000000000001','a7664860-8d72-4543-99ac-a449b68f9249',NULL,'2026-10-14 10:51:20','2026-10-14 10:51:20'),(38,'prvd-0001-0001-0001-000000000001','64b578a9-e217-4317-81db-6cce9704ba6a',NULL,'2026-10-14 10:54:22','2026-10-14 10:54:22'),(39,'prvd-0001-0001-0001-000000000001','cb068c74-9139-43a0-bd6b-19f297d537b7',NULL,'2026-10-14 10:55:49','2026-10-14 10:55:49'),(40,'prvd-0001-0001-0001-000000000001','d23f021f-76e8-46cb-886b-e629552fe499',NULL,'2026-10-14 14:30:03','2026-10-14 14:30:03'),(41,'prvd-0001-0001-0001-000000000001','d662278a-b37c-4b0c-adae-01ce044bc49d',NULL,'2026-10-14 16:41:45','2026-10-14 16:41:45'),(42,'prvd-0001-0001-0001-000000000001','ff45f9b4-4fb4-4ae4-bc34-0bde0a7e81fc',NULL,'2026-10-14 17:34:37','2026-10-14 17:34:37'),(43,'prvd-0001-0001-0001-000000000001','b8d9854d-e7c6-4e2e-9154-1509c9dbc3b4',NULL,'2026-10-14 18:19:13','2026-10-14 18:19:13'),(44,'prvd-0001-0001-0001-000000000001','44b8a2b5-a07e-407d-864c-ad75d6bd7eb9',NULL,'2026-10-15 10:17:10','2026-10-15 10:17:10'),(45,'prvd-0001-0001-0001-000000000001','dbca7d1b-7afb-4bed-9bdc-bae32d87c53c',NULL,'2026-10-15 10:50:41','2026-10-15 10:50:41'),(46,'prvd-0001-0001-0001-000000000001','b3b5a47b-29dd-4dd3-babd-7397e8935a44',NULL,'2026-10-15 11:51:10','2026-10-15 11:51:10'),(47,'prvd-0001-0001-0001-000000000001','e3948edf-bb94-4b2e-aae3-347ea82ddeb3',NULL,'2026-10-15 12:16:21','2026-10-15 12:16:21'),(48,'prvd-0001-0001-0001-000000000001','c288a76f-082e-41b1-8bd6-f21ae91729b0',NULL,'2026-10-15 12:36:34','2026-10-15 12:36:34'),(49,'prvd-0001-0001-0001-000000000001','f85b4243-7dbe-4b19-b044-ef1c99b7abb6',NULL,'2026-10-15 14:49:45','2026-10-15 14:49:45'),(50,'prvd-0001-0001-0001-000000000001','68dc44cd-8dda-4e86-be4c-b8c228da89b4',NULL,'2026-10-15 15:48:48','2026-10-15 15:48:48'),(51,'prvd-0001-0001-0001-000000000001','ee5de3cc-d7a0-4932-8320-c564d8dae66b',NULL,'2026-10-15 17:34:27','2026-10-15 17:34:27'),(52,'prvd-0001-0001-0001-000000000001','2f018e52-fdb8-4f46-9553-60eea6807e89',NULL,'2026-10-15 17:49:29','2026-10-15 17:49:29'),(53,'prvd-0001-0001-0001-000000000001','0123f3e2-f818-46c7-aca2-d229fb029299',NULL,'2026-10-16 09:50:26','2026-10-16 09:50:26'),(54,'prvd-0001-0001-0001-000000000001','d9ac8ce7-35be-45b6-a83a-dcee2fc0aaf2',NULL,'2026-10-18 20:06:51','2026-10-18 20:06:51'),(55,'prvd-0001-0001-0001-000000000001','03009368-b8e9-4122-845c-35058d02a231',NULL,'2026-10-18 20:12:55','2026-10-18 20:12:55'),(56,'prvd-0001-0001-0001-000000000001','2e667db0-22d4-4f2c-a3f3-fd6edc0ac096',NULL,'2026-10-18 20:15:49','2026-10-18 20:15:49'),(57,'prvd-0001-0001-0001-000000000001','6e5eebe2-d583-4ff4-a801-198228365253',NULL,'2026-10-18 20:50:30','2026-10-18 20:50:30'),(58,'prvd-0001-0001-0001-000000000001','5b2cf951-f94f-47ed-a3d1-2601dd4d3fb5',NULL,'2026-10-27 10:43:41','2026-10-27 10:43:41'),(59,'prvd-0001-0001-0001-000000000002','f60c0b4e-ed05-4a86-b1e0-b790ace98ca8',NULL,'2026-10-27 10:44:15','2026-10-27 10:44:15'),(60,'prvd-0001-0001-0001-000000000001','c1480fa1-ea1b-4152-b850-178e8d58c9a0',NULL,'2026-10-27 11:04:46','2026-10-27 11:04:46'),(61,'prvd-0001-0001-0001-000000000001','2e19ecfd-f3de-45b2-b22e-42f3add59ebe',NULL,'2026-10-27 12:07:19','2026-10-27 12:07:19'),(62,'prvd-0001-0001-0001-000000000001','3dbdd63f-a1a8-4969-97bd-456b677e593c',NULL,'2026-10-27 12:15:54','2026-10-27 12:15:54'),(63,'prvd-0001-0001-0001-000000000001','1a71cd0f-8b05-4b13-9f7c-ae84a2cf7bff',NULL,'2026-10-27 12:21:04','2026-10-27 12:21:04'),(64,'prvd-0001-0001-0001-000000000001','b5814625-ca70-4c33-9549-46fd4e0fd52e',NULL,'2026-10-27 12:28:32','2026-10-27 12:28:32'),(65,'prvd-0001-0001-0001-000000000001','e3421053-1718-494d-b96f-ae231ced63af',NULL,'2026-10-27 14:51:20','2026-10-27 14:51:20'),(66,'prvd-0001-0001-0001-000000000001','4a186688-74fb-45be-86ba-5ac62d7ea342',NULL,'2026-10-27 15:20:55','2026-10-27 15:20:55'),(67,'prvd-0001-0001-0001-000000000002','7f7da454-3ef2-413f-9c1d-99f868008536',NULL,'2026-10-27 15:37:21','2026-10-27 15:37:21'),(68,'prvd-0001-0001-0001-000000000001','32982b71-73c9-490f-8ad3-dc9733458339',NULL,'2026-10-27 15:38:32','2026-10-27 15:38:32'),(69,'prvd-0001-0001-0001-000000000001','eb4fefb9-aa35-42ad-bb9d-0411fd4dde39',NULL,'2026-10-27 15:47:40','2026-10-27 15:47:40'),(70,'prvd-0001-0001-0001-000000000001','b6242049-0682-4e0d-982f-c9de3f4e7ef9',NULL,'2026-10-27 15:54:17','2026-10-27 15:54:17'),(71,'prvd-0001-0001-0001-000000000001','2033219c-7431-4ac6-a51f-264abfed80eb',NULL,'2026-10-27 16:03:03','2026-10-27 16:03:03'),(72,'prvd-0001-0001-0001-000000000001','031a9851-64e3-4561-a94d-cc0b0070638d',NULL,'2026-10-27 17:01:17','2026-10-27 17:01:17'),(73,'prvd-0001-0001-0001-000000000002','e27c6207-9e5d-4549-b181-73451ad964d4',NULL,'2026-10-27 17:28:31','2026-10-27 17:28:31');
/*!40000 ALTER TABLE `subscription_subscriber_bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tag` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'new','2026-09-24 23:54:32','2026-09-24 23:54:32'),(2,'badiya','2026-09-24 23:54:32','2026-09-24 23:54:32'),(3,'hai','2026-10-12 14:31:21','2026-10-12 14:31:21'),(4,'ye','2026-10-12 14:31:21','2026-10-12 14:31:21'),(5,'bhai','2026-10-12 14:31:21','2026-10-12 14:31:21'),(6,'mnt','2026-10-26 14:50:32','2026-10-26 14:50:32'),(7,'io\'','2026-10-26 14:50:32','2026-10-26 14:50:32'),(8,'io','2026-10-26 14:50:32','2026-10-26 14:50:32'),(9,'ihko','2026-10-26 14:50:32','2026-10-26 14:50:32'),(10,'hko','2026-10-26 14:50:32','2026-10-26 14:50:32'),(11,'hokl','2026-10-26 14:50:32','2026-10-26 14:50:32');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ref_trx_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `debit` decimal(24,2) NOT NULL DEFAULT '0.00',
  `credit` decimal(24,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(24,2) NOT NULL DEFAULT '0.00',
  `from_user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `from_user_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_user_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_note` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_guest` tinyint(1) NOT NULL DEFAULT '0',
  `booking_repeat_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES ('02ae27ea-2a9f-4b76-bac6-c63ddda5b4eb','dc389a18-90bf-4d9d-95cb-9d9c52f72a34','7f4ba9ec-0cf5-4671-b725-89160062b3f2','receivable_commission',0.00,89.85,89.85,'8be51d97-6fe0-4d46-a9c6-d77b4d2386f5','prvd-0001-0001-0001-000000000001','2026-10-02 19:09:20','2026-10-02 19:09:20','account_receivable',NULL,NULL,0,NULL),('03c3c2c0-7746-478f-a09c-558ec439c263',NULL,'09aa1dcb-32ec-4230-9ef4-c71fed46410e','received_amount',0.00,1299.18,30125.26,'prvd-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','2026-10-14 14:05:52','2026-10-14 14:05:52',NULL,'received_balance',NULL,0,NULL),('1136789e-7d12-4e60-9118-0a75c2cb4e8a',NULL,'7c2388dc-9ea4-4ad6-87d2-b0c4f9577b62','received_amount',0.00,1748.18,31873.44,'prvd-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','2026-10-16 10:39:57','2026-10-16 10:39:57',NULL,'received_balance',NULL,0,NULL),('557fd614-8100-48a9-8c5e-ec8ff9266306',NULL,'2e667db0-22d4-4f2c-a3f3-fd6edc0ac096','received_amount',0.00,1299.18,33172.62,'prvd-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','2026-10-18 20:19:54','2026-10-18 20:19:54',NULL,'received_balance',NULL,0,NULL),('c354d41a-8a32-4c80-a58b-14ba5b272dd3','dc389a18-90bf-4d9d-95cb-9d9c52f72a34','7f4ba9ec-0cf5-4671-b725-89160062b3f2','payable_commission',0.00,89.85,1289.85,'prvd-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','2026-10-02 19:09:20','2026-10-02 19:09:20','account_payable',NULL,NULL,0,NULL),('dc389a18-90bf-4d9d-95cb-9d9c52f72a34',NULL,'7f4ba9ec-0cf5-4671-b725-89160062b3f2','received_amount',0.00,616.97,15616.97,'prvd-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','2026-10-02 19:09:20','2026-10-02 19:09:20',NULL,'received_balance',NULL,0,NULL),('f4bebf9a-2290-4473-8803-c22960cadee6',NULL,'92960767-886f-457e-9ca1-dd880dfed02c','received_amount',0.00,1299.18,28826.08,'prvd-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','2026-10-12 15:21:32','2026-10-12 15:21:32',NULL,'received_balance',NULL,0,NULL),('f5ca2832-3dfd-4b19-92ea-1fdb8c7cbf92',NULL,'0978aaa3-bde3-4438-a245-b9c7dbebfd62','received_amount',0.00,1299.18,27526.90,'prvd-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','2026-10-07 14:32:40','2026-10-07 14:32:40',NULL,'received_balance',NULL,0,NULL),('trx-0001-0001-0001-000000000001',NULL,'bkg-0001-0001-0001-000000000001','booking_amount',0.00,2499.00,2499.00,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000001','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1001 payment',0,NULL),('trx-0001-0001-0001-000000000002',NULL,'bkg-0001-0001-0001-000000000002','booking_amount',0.00,399.00,399.00,'cust-0001-0001-0001-000000000002','prvd-0001-0001-0001-000000000003','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1002 payment',0,NULL),('trx-0001-0001-0001-000000000003',NULL,'bkg-0001-0001-0001-000000000003','booking_amount',0.00,499.00,499.00,'cust-0001-0001-0001-000000000003','prvd-0001-0001-0001-000000000004','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1003 payment',0,NULL),('trx-0001-0001-0001-000000000004',NULL,'bkg-0001-0001-0001-000000000004','booking_amount',0.00,1299.00,1299.00,'cust-0001-0001-0001-000000000005','prvd-0001-0001-0001-000000000001','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1004 payment',0,NULL),('trx-0001-0001-0001-000000000005',NULL,'bkg-0001-0001-0001-000000000005','booking_amount',0.00,899.00,899.00,'cust-0001-0001-0001-000000000007','prvd-0001-0001-0001-000000000002','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1005 payment',0,NULL),('trx-0001-0001-0001-000000000006',NULL,'bkg-0001-0001-0001-000000000006','booking_amount',0.00,1999.00,1999.00,'cust-0001-0001-0001-000000000008','prvd-0001-0001-0001-000000000005','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1006 payment',0,NULL),('trx-0001-0001-0001-000000000007',NULL,'bkg-0001-0001-0001-000000000015','booking_amount',0.00,199.00,199.00,'cust-0001-0001-0001-000000000005','prvd-0001-0001-0001-000000000004','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1015 payment',0,NULL),('trx-0001-0001-0001-000000000008',NULL,'bkg-0001-0001-0001-000000000016','booking_amount',0.00,1200.00,1200.00,'cust-0001-0001-0001-000000000010','prvd-0001-0001-0001-000000000005','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1016 payment',0,NULL),('trx-0001-0001-0001-000000000009',NULL,'bkg-0001-0001-0001-000000000017','booking_amount',0.00,599.00,599.00,'cust-0001-0001-0001-000000000001','prvd-0001-0001-0001-000000000002','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1017 payment',0,NULL),('trx-0001-0001-0001-000000000010',NULL,'bkg-0001-0001-0001-000000000018','booking_amount',0.00,3499.00,3499.00,'cust-0001-0001-0001-000000000008','prvd-0001-0001-0001-000000000001','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1018 payment',0,NULL),('trx-0001-0001-0001-000000000011',NULL,'bkg-0001-0001-0001-000000000019','booking_amount',0.00,299.00,299.00,'cust-0001-0001-0001-000000000004','prvd-0001-0001-0001-000000000003','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1019 payment',0,NULL),('trx-0001-0001-0001-000000000012',NULL,'bkg-0001-0001-0001-000000000020','booking_amount',0.00,2499.00,2499.00,'cust-0001-0001-0001-000000000006','prvd-0001-0001-0001-000000000004','2026-09-12 15:45:55','2026-09-12 15:45:55',NULL,NULL,'Booking 1020 payment',0,NULL);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `translationable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `translationable_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `translations_translationable_id_index` (`translationable_id`),
  KEY `translations_locale_index` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` VALUES (1,'Modules\\ZoneManagement\\Entities\\Zone','c00ed508-2bf3-43c3-b95c-8e880de67168','en','zone_name','new'),(2,'Modules\\PromotionManagement\\Entities\\Advertisement','61fd0824-59e3-4045-98e4-635658f25b0d','en','title','hii'),(3,'Modules\\PromotionManagement\\Entities\\Advertisement','61fd0824-59e3-4045-98e4-635658f25b0d','en','description','hii'),(4,'Modules\\ServiceManagement\\Entities\\Service','svc-0001-0001-0001-000000000001','en','name','Full Home Deep Cleaning'),(5,'Modules\\ServiceManagement\\Entities\\Service','svc-0001-0001-0001-000000000001','en','short_description','Complete deep cleaning for 2BHK/3BHK'),(6,'Modules\\ServiceManagement\\Entities\\Service','svc-0001-0001-0001-000000000001','en','description','<p>Professional deep cleaning covering all rooms kitchen bathrooms. Includes floor mopping dusting window cleaning and sanitization.</p>'),(7,'Modules\\CategoryManagement\\Entities\\Category','bc250cc5-990b-4864-aac1-c8dde7b63427','en','name','Carpentry'),(8,'Modules\\CategoryManagement\\Entities\\Category','8a904eea-a4ce-4482-8100-abd9f8cd8a69','en','name','Door Work'),(9,'Modules\\CategoryManagement\\Entities\\Category','8a904eea-a4ce-4482-8100-abd9f8cd8a69','en','description','new'),(10,'Modules\\ServiceManagement\\Entities\\Service','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5','en','name','Door Work'),(11,'Modules\\ServiceManagement\\Entities\\Service','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5','en','short_description','hi'),(12,'Modules\\ServiceManagement\\Entities\\Service','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5','en','description','<p>hi</p>'),(13,'Modules\\ZoneManagement\\Entities\\Zone','6b1c8733-b0ff-4c65-a745-1f46419adc49','en','zone_name','2 zone'),(14,'Modules\\ServiceManagement\\Entities\\Service','513bce46-8576-413f-9809-96ba2fb8a5f2','en','name','jass'),(15,'Modules\\ServiceManagement\\Entities\\Service','513bce46-8576-413f-9809-96ba2fb8a5f2','en','short_description','service'),(16,'Modules\\ServiceManagement\\Entities\\Service','513bce46-8576-413f-9809-96ba2fb8a5f2','en','description','<p>badiya hai lele bhai</p>');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unsatisfied_requests`
--

DROP TABLE IF EXISTS `unsatisfied_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unsatisfied_requests` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serviceman_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'jo serviceman pehle kaam kar gaya tha',
  `reservice_booking_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'auto-cloned free re-service booking',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'requested',
  `reason` text COLLATE utf8mb4_unicode_ci COMMENT 'customer ki problem',
  `requested_at` timestamp NULL DEFAULT NULL,
  `due_at` timestamp NULL DEFAULT NULL COMMENT 'window ka deadline',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `unsatisfied_requests_booking_id_index` (`booking_id`),
  KEY `unsatisfied_requests_customer_id_index` (`customer_id`),
  KEY `unsatisfied_requests_provider_id_index` (`provider_id`),
  KEY `unsatisfied_requests_serviceman_id_index` (`serviceman_id`),
  KEY `unsatisfied_requests_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unsatisfied_requests`
--

LOCK TABLES `unsatisfied_requests` WRITE;
/*!40000 ALTER TABLE `unsatisfied_requests` DISABLE KEYS */;
INSERT INTO `unsatisfied_requests` VALUES ('11f54362-c71a-4048-a086-a8fe56b7a2b5','92960767-886f-457e-9ca1-dd880dfed02c','31f1bff9-432d-48ab-8e12-dcfc38d46069','prvd-0001-0001-0001-000000000001','sm-0001-0001-0001-000000000001','3164cc17-5142-4fec-9ad8-0d8630191ca6','requested','Test - technician ne AC theek se clean nahi kiya','2026-10-12 16:32:55','2026-10-19 16:32:55',NULL,'2026-10-12 16:32:55','2026-10-12 16:32:55');
/*!40000 ALTER TABLE `unsatisfied_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_addresses`
--

DROP TABLE IF EXISTS `user_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `address_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_guest` tinyint(1) NOT NULL DEFAULT '0',
  `house` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `floor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_addresses`
--

LOCK TABLES `user_addresses` WRITE;
/*!40000 ALTER TABLE `user_addresses` DISABLE KEYS */;
INSERT INTO `user_addresses` VALUES (1,'cust-0001-0001-0001-000000000001','28.6139','77.2090','New Delhi','MG Road Connaught Place','110001','India','42 MG Road Connaught Place New Delhi','2026-09-12 15:45:55','2026-09-12 15:45:55','home','Rahul Verma','+919123456780','Home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'42','3'),(2,'cust-0001-0001-0001-000000000002','19.0760','72.8777','Mumbai','Andheri West Link Road','400053','India','88 Link Road Andheri West Mumbai','2026-09-12 15:45:55','2026-09-12 15:45:55','home','Sneha Iyer','+919123456781','Home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'88','1'),(3,'cust-0001-0001-0001-000000000003','12.9716','77.5946','Bangalore','Koramangala 4th Block','560034','India','23 4th Block Koramangala Bangalore','2026-09-12 15:45:55','2026-09-12 15:45:55','home','Arjun Nair','+919123456782','Home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'23','5'),(4,'cust-0001-0001-0001-000000000004','28.4595','77.0266','Gurgaon','Sector 14 Main Market','122001','India','67 Sector 14 Main Market Gurgaon','2026-09-12 15:45:55','2026-09-12 15:45:55','home','Kavitha Rao','+919123456783','Home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'67','1'),(5,'cust-0001-0001-0001-000000000005','28.6139','77.2090','New Delhi','Karol Bagh','110005','India','34 Ajmal Khan Road Karol Bagh Delhi','2026-09-12 15:45:55','2026-09-12 15:45:55','home','Deepak Mishra','+919123456784','Home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'34','2'),(6,'cust-0001-0001-0001-000000000006','28.6280','77.2195','New Delhi','Nehru Place','110019','India','15 Nehru Place South Delhi','2026-09-12 15:45:55','2026-09-12 15:45:55','home','Pooja Desai','+919123456785','Home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'15','2'),(7,'cust-0001-0001-0001-000000000007','28.6139','77.2090','New Delhi','Rajouri Garden','110027','India','78 Najafgarh Road Rajouri Garden Delhi','2026-09-12 15:45:55','2026-09-12 15:45:55','home','Manoj Tiwari','+919123456786','Home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'78','1'),(8,'cust-0001-0001-0001-000000000008','19.0760','72.8777','Mumbai','Bandra West','400050','India','45 Hill Road Bandra West Mumbai','2026-09-12 15:45:55','2026-09-12 15:45:55','home','Anita Chopra','+919123456787','Home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'45','3'),(9,NULL,'27.1752554','78.0098161','Agra','','280001','India','Agra, Uttar Pradesh, 280001, India','2026-09-19 01:39:31','2026-09-19 01:39:31','others','Jass singh','+916304642321','home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'',NULL),(10,NULL,'27.1752554','78.0098161','Agra','','280001','India','Agra, Uttar Pradesh, 280001, India','2026-09-19 01:39:59','2026-09-19 01:39:59','others','Jass singh','+916304642321','home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'',NULL),(11,NULL,'30.9293211','75.5004841','','','','India','Punjab, India','2026-09-21 23:39:47','2026-09-21 23:39:47','others','Jass singh','+916304642321','home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'',NULL),(12,NULL,'27.177880644613197','78.00970967976555','Agra','','280001','India','Subhash Bazaar, Shahganj, Agra, Uttar Pradesh, 280001, India','2026-09-22 18:03:16','2026-09-22 18:03:16','others','Jass singh','+916304642321','home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'',NULL),(13,NULL,'27.177880644613197','78.00970967976555','Agra','','280001','India','Subhash Bazaar, Shahganj, Agra, Uttar Pradesh, 280001, India','2026-09-22 18:15:34','2026-09-22 18:15:34','others','Jass singh','+916304642321','home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'',NULL),(14,NULL,'27.177880644613197','78.00970967976555','Agra','','280001','India','Subhash Bazaar, Shahganj, Agra, Uttar Pradesh, 280001, India','2026-09-22 18:25:21','2026-09-22 18:25:21','others','Jass singh','+916304642321','home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'',NULL),(15,NULL,'28.6138954','77.2090057','New Delhi','','','India','New Delhi, Delhi, India','2026-09-26 20:59:22','2026-09-26 20:59:22','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'',NULL),(16,NULL,'11.3304967175155','78.60833548989203','','','','India','Tamil Nadu, India','2026-09-29 02:08:12','2026-09-29 02:08:12','others','Jass singh','+916304642321','home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'',NULL),(17,NULL,'27.176564035436','78.0085409431095','Agra','','280001','India','Agra, Uttar Pradesh, 280001, India','2026-09-30 22:57:06','2026-09-30 22:57:06','others','Jass singh','+916304642321','home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'',NULL),(18,NULL,'27.176564035436','78.0085409431095','Agra','','280001','India','Agra, Uttar Pradesh, 280001, India','2026-10-01 00:37:21','2026-10-01 00:37:21','others','Jass singh','+916304642321','home','a1614dbe-4732-11ee-9702-dee6e8d77be4',0,'',NULL),(19,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-02 22:20:31','2026-10-02 22:20:31','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(20,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-02 22:25:39','2026-10-02 22:25:39','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(21,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-02 22:36:09','2026-10-02 22:36:09','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(22,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-02 22:43:16','2026-10-02 22:43:16','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(23,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-02 22:44:42','2026-10-02 22:44:42','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(24,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-02 22:46:47','2026-10-02 22:46:47','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(25,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-02 23:14:49','2026-10-02 23:14:49','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(26,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-03 00:21:36','2026-10-03 00:21:36','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(27,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-03 00:22:46','2026-10-03 00:22:46','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(28,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-03 01:54:34','2026-10-03 01:54:34','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(29,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-03 01:55:42','2026-10-03 01:55:42','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(30,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-03 04:38:19','2026-10-03 04:38:19','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(31,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-03 04:42:45','2026-10-03 04:42:45','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(32,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-03 04:44:40','2026-10-03 04:44:40','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(33,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-03 20:28:52','2026-10-03 20:28:52','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(34,NULL,'28.63','77.22','Delhi','CP','110001','India','Connaught Place, Delhi','2026-10-03 20:31:06','2026-10-03 20:31:06','service','Rahul','9999999999','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'12','1'),(35,NULL,'28.614749472732026','77.20959410960275','New Delhi','','','India','New Delhi, Delhi, India','2026-10-07 17:11:03','2026-10-07 17:11:03','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'',''),(36,NULL,'28.6138954','77.2090057','New Delhi','','we','India','New Delhi, Delhi, India','2026-10-09 17:47:47','2026-10-09 17:47:47','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'',''),(37,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-12 10:41:39','2026-10-12 10:41:39','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(38,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-12 10:45:44','2026-10-12 10:45:44','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(39,NULL,'28.6138','77.209','Delhi','Test Street','110001','India','Test Street Delhi','2026-10-12 11:53:57','2026-10-12 11:53:57','service','Test User','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,'H-12','2'),(40,NULL,'28.6138','77.209','Delhi','Test Street','110001','India','Test Street Delhi','2026-10-12 12:17:54','2026-10-12 12:17:54','service','Test User','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,'H-12','2'),(41,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-12 14:12:51','2026-10-12 14:12:51','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'',''),(42,NULL,'28.6138954','77.2090057','','','','','','2026-10-12 18:15:29','2026-10-12 18:15:29','others','Jass singh','+916304642321','home',NULL,0,'',''),(43,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-13 10:04:04','2026-10-13 10:04:04','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'gf','fg'),(44,NULL,'28.6138954','77.2090057',NULL,'',NULL,NULL,'Test Street 1, New Delhi','2026-10-13 16:44:47','2026-10-13 16:44:47','service','Test Guest','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(45,NULL,'28.6138954','77.2090057',NULL,'',NULL,NULL,'Test Street 1, New Delhi','2026-10-13 17:44:00','2026-10-13 17:44:00','service','Test Guest','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(46,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-13 18:06:00','2026-10-13 18:06:00','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'sd','d'),(47,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Live Test Street, Karnal','2026-10-14 10:25:35','2026-10-14 10:25:35','service','Live Test','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(48,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Live Test Street, Karnal','2026-10-14 10:30:58','2026-10-14 10:30:58','service','Live Test','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(49,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Live Test Street, Karnal','2026-10-14 10:33:25','2026-10-14 10:33:25','service','Live Test','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(50,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Live Test Street, Karnal','2026-10-14 10:34:42','2026-10-14 10:34:42','service','Live Test','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(51,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Fresh Test','2026-10-14 10:36:56','2026-10-14 10:36:56','service','FT','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(52,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Fresh Test','2026-10-14 10:37:08','2026-10-14 10:37:08','service','FT','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(53,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Fresh Test','2026-10-14 10:37:45','2026-10-14 10:37:45','service','FT','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(54,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Fresh Test','2026-10-14 10:38:11','2026-10-14 10:38:11','service','FT','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(55,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Fresh Test','2026-10-14 10:38:42','2026-10-14 10:38:42','service','FT','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(56,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Fresh Test','2026-10-14 10:39:21','2026-10-14 10:39:21','service','FT','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(57,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Fresh Test','2026-10-14 10:43:50','2026-10-14 10:43:50','service','FT','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(58,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Fresh Test','2026-10-14 10:47:02','2026-10-14 10:47:02','service','FT','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(59,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Fresh Test','2026-10-14 10:51:20','2026-10-14 10:51:20','service','FT','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(60,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Fresh Test','2026-10-14 10:54:21','2026-10-14 10:54:21','service','FT','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(61,NULL,'28.830897557796','76.807617484353',NULL,'',NULL,NULL,'Fresh Test','2026-10-14 10:55:49','2026-10-14 10:55:49','service','FT','9876543210','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',1,NULL,NULL),(62,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-14 14:30:03','2026-10-14 14:30:03','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(63,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-14 16:41:45','2026-10-14 16:41:45','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as',''),(64,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-14 17:34:37','2026-10-14 17:34:37','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as',''),(65,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-14 18:19:13','2026-10-14 18:19:13','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(66,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-15 10:17:10','2026-10-15 10:17:10','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(67,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-15 10:50:41','2026-10-15 10:50:41','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'gf','fg'),(68,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-15 11:51:10','2026-10-15 11:51:10','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(69,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-15 12:16:21','2026-10-15 12:16:21','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(70,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-15 12:36:34','2026-10-15 12:36:34','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(71,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-15 14:49:45','2026-10-15 14:49:45','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(72,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-15 15:48:48','2026-10-15 15:48:48','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(73,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-15 17:34:27','2026-10-15 17:34:27','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(74,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-15 17:49:29','2026-10-15 17:49:29','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'as','as'),(75,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-16 09:50:26','2026-10-16 09:50:26','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'sa','as'),(76,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-18 20:06:51','2026-10-18 20:06:51','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'ne','en'),(77,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-18 20:12:55','2026-10-18 20:12:55','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'ne','en'),(78,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-18 20:15:49','2026-10-18 20:15:49','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'ne','en'),(79,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','New Delhi, Delhi, India','2026-10-18 20:50:30','2026-10-18 20:50:30','others','Jass singh','+916304642321','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'new','new'),(80,NULL,'28.6138954','77.2090057','New Delhi','Kartavya Path','110004','India','Kartavya Path, New Delhi, Delhi 110004, India','2026-10-27 10:05:57','2026-10-27 10:05:57','home','Jass singh','+916304642321','Home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,'',''),(85,NULL,'28.6138954','77.2090057',NULL,'',NULL,NULL,'Delhi test','2026-10-27 11:05:00','2026-10-27 11:05:00','service','Jass','9999999999','home','c00ed508-2bf3-43c3-b95c-8e880de67168',0,NULL,NULL),(86,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 12:07:19','2026-10-27 12:07:19','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'sa','sa'),(87,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 12:15:54','2026-10-27 12:15:54','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'as','as'),(88,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 12:16:12','2026-10-27 12:16:12','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'as','as'),(89,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 12:21:04','2026-10-27 12:21:04','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'aa','aa'),(90,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 12:28:32','2026-10-27 12:28:32','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'aa','aa'),(91,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 14:51:20','2026-10-27 14:51:20','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'se','se'),(92,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 15:20:54','2026-10-27 15:20:54','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'se','se'),(93,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 15:37:20','2026-10-27 15:37:20','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'sasa','as'),(94,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 15:38:31','2026-10-27 15:38:31','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'sasa','as'),(95,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 15:47:40','2026-10-27 15:47:40','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'sasa','as'),(96,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 15:54:17','2026-10-27 15:54:17','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'sasa','as'),(97,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 16:03:03','2026-10-27 16:03:03','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'sasa','as'),(98,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 17:01:16','2026-10-27 17:01:16','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'sasa','as'),(99,NULL,'26.8381','80.9346001','Lucknow','Station road','226027','India','Lucknow, Uttar Pradesh, 226027, India','2026-10-27 17:28:31','2026-10-27 17:28:31','others','Rahul Verma','+919123456780','home','6b1c8733-b0ff-4c65-a745-1f46419adc49',0,'sa','');
/*!40000 ALTER TABLE `user_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_verifications`
--

DROP TABLE IF EXISTS `user_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_verifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `identity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identity_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `hit_count` tinyint NOT NULL DEFAULT '0',
  `is_temp_blocked` tinyint(1) NOT NULL DEFAULT '0',
  `temp_block_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_verifications`
--

LOCK TABLES `user_verifications` WRITE;
/*!40000 ALTER TABLE `user_verifications` DISABLE KEYS */;
INSERT INTO `user_verifications` VALUES (4,'iijaspreetsiingh@gmail.com','email',NULL,'508696','2026-09-25 19:13:15','2026-09-25 19:10:15','2026-09-25 19:10:15',0,0,NULL);
/*!40000 ALTER TABLE `user_verifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_zones`
--

DROP TABLE IF EXISTS `user_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_zones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_zones`
--

LOCK TABLES `user_zones` WRITE;
/*!40000 ALTER TABLE `user_zones` DISABLE KEYS */;
INSERT INTO `user_zones` VALUES (11,'prvd-0001-0001-0001-000000000001','6b1c8733-b0ff-4c65-a745-1f46419adc49',NULL,NULL),(12,'prvd-0001-0001-0001-000000000002','6b1c8733-b0ff-4c65-a745-1f46419adc49',NULL,NULL);
/*!40000 ALTER TABLE `user_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identification_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identification_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'nid',
  `identification_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '[]',
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'male',
  `profile_image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default.png',
  `fcm_token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_phone_verified` tinyint(1) NOT NULL DEFAULT '0',
  `is_email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `phone_verified_at` timestamp NULL DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `user_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `wallet_balance` decimal(24,3) NOT NULL DEFAULT '0.000',
  `loyalty_point` decimal(24,3) NOT NULL DEFAULT '0.000',
  `ref_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referred_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_hit_count` tinyint NOT NULL DEFAULT '0',
  `is_temp_blocked` tinyint(1) NOT NULL DEFAULT '0',
  `temp_block_time` timestamp NULL DEFAULT NULL,
  `current_language_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  `current_lat` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_lng` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_location_updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique_idx` (`email`),
  KEY `users_phone_idx` (`phone`),
  KEY `users_latlng_idx` (`current_lat`,`current_lng`),
  KEY `users_type_active_idx` (`user_type`,`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('0eb668a3-bef8-41e8-a539-a005a1037075','Admin','User','admin@example.com',NULL,NULL,'nid','[]',NULL,'male','default.png',NULL,0,1,NULL,NULL,'$2y$10$Y3B5.Cja5TxZrKDhtCCj.uYxOr7CBnvvlYLCj8cCJBAjRG9qZh.m.',1,'super-admin',NULL,NULL,'2026-10-21 15:24:00','2026-10-21 15:24:00',0.000,0.000,'F7V3OD1CTK',NULL,0,0,NULL,'en',NULL,NULL,NULL),('31f1bff9-432d-48ab-8e12-dcfc38d46069','Jass','singh','ijass@gmail.com','+916304642321',NULL,'nid','[]',NULL,'male','default.png','fXkpsBmDRBepKCn7wCROBo:APA91bF-BhCUtk_V_wtpJUWr0WaFI7pBVxu33pXkrb5li_jqODcGXucAkm6isz0pm4bWcDXT_4LgnUg7tiDz6-YPQz5O_wXPXBaas7aEbBVijBa8SmuMx3o',0,1,NULL,NULL,'$2y$10$U0u3HBeaufbeZqOe8saG5.tPmC7zoWMT0VWxiKJ5HgOoH8iZ3i2wm',1,'customer',NULL,NULL,'2026-09-17 23:42:50','2026-10-13 12:04:28',0.000,0.000,'WOFTAA9TKS',NULL,4,0,NULL,'en',NULL,NULL,NULL),('3bd529e7-16ec-4e40-84fa-ca0306faa7f6','Jaspreet','user','shankygroup01@gmail.com','+919958281542',NULL,'nid','[]',NULL,'male','default.png','@',0,1,NULL,NULL,'$2y$10$rKiJrZMYzuramkEhrfggxepq7pn6YCQjVGQAtdr36v9Ro2DSVLPGS',1,'customer',NULL,NULL,'2026-09-25 18:40:09','2026-09-25 19:01:39',0.000,0.000,'AMO2JP2CCV',NULL,0,0,NULL,'en',NULL,NULL,NULL),('8be51d97-6fe0-4d46-a9c6-d77b4d2386f5','jaspreet','singh','ijaspreetsiingh@gmail.com','9716121921',NULL,'nid','[]',NULL,'male','default.png',NULL,0,0,NULL,NULL,'$2y$10$jnfS7SfgI9lqihSa45M8J.Ipv3X7hdesBDz0T7eMvnryUyalo1jz2',1,'super-admin','4Sbwe1HFI4ftTafOwr6n5rUj63HR9weS1koQmlpsmwFfFTgwnbZi8SJvkMjB',NULL,'2026-09-13 02:47:50','2026-10-21 15:24:00',0.000,0.000,'NWYASGONHQ',NULL,0,0,NULL,'en',NULL,NULL,NULL),('a1b2c3d4-e5f6-7890-abcd-ef1234567890','Test','Customer','test@customer.com','+919999999999',NULL,'nid','[]',NULL,'male','default.png',NULL,1,0,NULL,NULL,'\\.27A2y.ghT5rz0XE4CqIv9DlwqpxhBpO',1,'customer',NULL,NULL,'2026-09-14 11:54:17','2026-09-14 11:54:17',0.000,0.000,NULL,NULL,0,0,NULL,'en',NULL,NULL,NULL),('a72401cd-34d4-4f5d-9276-3e0c860e4cab','jass','singh','mobidok600@bullbaby.com','+919950284529',NULL,'nid','[]',NULL,'male','default.png','@',0,1,NULL,NULL,'$2y$10$mIeL22ceaIBWahbCtkH3Cu4sw7eQw1FzLnYOrhQPa6sl2T5UZ.g2W',1,'customer',NULL,NULL,'2026-09-25 19:22:55','2026-09-25 19:24:28',0.000,0.000,'QRNYBYNHOQ',NULL,0,0,NULL,'en',NULL,NULL,NULL),('c8a9caef-2d69-406e-9dbe-7049e62357b4','jass','singh','iijaspreetsiingh@gmail.com','+919958281541',NULL,'nid','[]',NULL,'male','default.png',NULL,0,0,NULL,NULL,'$2y$10$12AfzxUHzwW4v5plc0zMnO09bZmVGmjvA4JsrilA4Qqu78FkQAImu',1,'customer',NULL,NULL,'2026-09-25 19:10:11','2026-09-25 19:10:11',0.000,0.000,'3AA0LQNZJT',NULL,0,0,NULL,'en',NULL,NULL,NULL),('cust-0001-0001-0001-000000000001','Rahul','Verma','rahul@customer.com','+919123456780',NULL,'nid','[]',NULL,'male','default.png','cVmEJIkbSsm9IT6SRkOzfm:APA91bGgRf6VUEz8Kbqj9oyiFxOCN_ZgFg7w5aEz-RtuQHl0gq7RbIZxiiJ5QX_R6AikPmjmv2P9Jfm5f_VtlgcDvPJCNbAXh3T6gSNoaoYetYOvpj45XS8',1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','$2y$10$RyI56B0l2xE3sbWeOf027O9jBSsnW4svmSxa0CUderNfDwnIHN12S',1,'customer',NULL,NULL,'2026-09-12 15:45:50','2026-10-27 13:25:25',2500.000,45.000,'CUST001',NULL,0,0,NULL,'en',NULL,NULL,NULL),('cust-0001-0001-0001-000000000002','Sneha','Iyer','sneha@customer.com','+919123456781',NULL,'nid','[]',NULL,'female','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'customer',NULL,NULL,'2026-09-12 15:45:50','2026-09-12 15:45:50',1800.000,30.000,'CUST002',NULL,1,0,NULL,'en',NULL,NULL,NULL),('cust-0001-0001-0001-000000000003','Arjun','Nair','arjun@customer.com','+919123456782',NULL,'nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'customer',NULL,NULL,'2026-09-12 15:45:50','2026-09-12 15:45:50',3200.000,60.000,'CUST003',NULL,1,0,NULL,'en',NULL,NULL,NULL),('cust-0001-0001-0001-000000000004','Kavitha','Rao','kavitha@customer.com','+919123456783',NULL,'nid','[]',NULL,'female','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'customer',NULL,NULL,'2026-09-12 15:45:50','2026-09-12 15:45:50',950.000,15.000,'CUST004',NULL,1,0,NULL,'en',NULL,NULL,NULL),('cust-0001-0001-0001-000000000005','Deepak','Mishra','deepak@customer.com','+919123456784',NULL,'nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'customer',NULL,NULL,'2026-09-12 15:45:50','2026-09-12 15:45:50',4100.000,75.000,'CUST005',NULL,1,0,NULL,'en',NULL,NULL,NULL),('cust-0001-0001-0001-000000000006','Pooja','Desai','pooja@customer.com','+919123456785',NULL,'nid','[]',NULL,'female','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'customer',NULL,NULL,'2026-09-12 15:45:50','2026-09-12 15:45:50',700.000,10.000,'CUST006',NULL,1,0,NULL,'en',NULL,NULL,NULL),('cust-0001-0001-0001-000000000007','Manoj','Tiwari','manoj@customer.com','+919123456786',NULL,'nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'customer',NULL,NULL,'2026-09-12 15:45:50','2026-09-12 15:45:50',5500.000,90.000,'CUST007',NULL,1,0,NULL,'en',NULL,NULL,NULL),('cust-0001-0001-0001-000000000008','Anita','Chopra','anita@customer.com','+919123456787',NULL,'nid','[]',NULL,'female','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'customer',NULL,NULL,'2026-09-12 15:45:50','2026-09-12 15:45:50',1200.000,20.000,'CUST008',NULL,1,0,NULL,'en',NULL,NULL,NULL),('cust-0001-0001-0001-000000000009','Vikash','Jain','vikash@customer.com','+919123456788',NULL,'nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'customer',NULL,NULL,'2026-09-12 15:45:50','2026-09-12 15:45:50',800.000,12.000,'CUST009',NULL,1,0,NULL,'en',NULL,NULL,NULL),('cust-0001-0001-0001-000000000010','Sunita','Agarwal','sunita@customer.com','+919123456789',NULL,'nid','[]',NULL,'female','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'customer',NULL,NULL,'2026-09-12 15:45:50','2026-09-14 18:20:59',2800.000,55.000,'CUST010',NULL,3,0,NULL,'en',NULL,NULL,NULL),('prvd-0001-0001-0001-000000000001','Amit','Sharma','amit@provider.com','+919876543211','1234321','nid','[]',NULL,'male','default.png','eFSRzZQtTM-ur9xnLdffC0:APA91bECXK31_iVYKkFGqWuXa04krOMFs-mHi_QsIuuyoJFFCJkhUqfOf3al2yd-Sen50vpUB0MD_3iTN49jmgkjBozh6JSG147M4clpJMGZq8gE3_Nvihs',1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','$2y$10$FrLXUTMfYCdHmT9kim6RyeI.LB8PS8rEgfXH7Sq40zYrne.yLzcii',1,'provider-admin',NULL,NULL,'2026-09-12 15:45:50','2026-10-27 13:25:52',5000.000,150.000,'PRVD001',NULL,0,0,NULL,'en',NULL,NULL,NULL),('prvd-0001-0001-0001-000000000002','Vikram','Singh','vikram@provider.com','+919876543212','TEST-NID-9911','nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','$2y$10$LyhdSwDF/dzR5t3/c93gTOABYwMd0W5ndMWfhKQ7mNZAIkMkXe1Ze',1,'provider-admin',NULL,NULL,'2026-09-12 15:45:50','2026-10-21 15:34:22',3500.000,80.000,'PRVD002',NULL,0,0,NULL,'en',NULL,NULL,NULL),('prvd-0001-0001-0001-000000000003','Priya','Patel','priya@provider.com','+919876543213',NULL,'nid','[]',NULL,'female','default.png','',1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','$2y$10$vMdyEU2lmhq5jRZEK4C5l.PGWesOtd/uoND5GmKlfYXXDJwUQIZQi',0,'provider-admin',NULL,NULL,'2026-09-12 15:45:50','2026-10-05 03:19:19',8000.000,200.000,'PRVD003',NULL,0,0,NULL,'en',NULL,NULL,NULL),('prvd-0001-0001-0001-000000000004','Suresh','Reddy','suresh@provider.com','+919876543214',NULL,'nid','[]',NULL,'male','default.png','',1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',0,'provider-admin',NULL,NULL,'2026-09-12 15:45:50','2026-10-05 03:19:21',12000.000,320.000,'PRVD004',NULL,9,1,'2026-10-02 18:43:41','en',NULL,NULL,NULL),('prvd-0001-0001-0001-000000000005','Neha','Gupta','neha@provider.com','+919876543215',NULL,'nid','[]',NULL,'female','default.png','',1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',0,'provider-admin',NULL,NULL,'2026-09-12 15:45:50','2026-10-05 03:19:26',6500.000,180.000,'PRVD005',NULL,5,1,'2026-10-02 18:43:49','en',NULL,NULL,NULL),('sman-0001-0001-0001-000000000001','Ravi','Kumar','ravi@serviceman.com','+919234567801','1231','nid','[{\"image\":\"2026-10-18-6ad4ba1918592.webp\",\"storage\":\"public\"}]',NULL,'male','2026-10-18-6ad4ba195de26.webp','cQOToa6QSaCXuE4L-CyxyV:APA91bEjVrsbDWWLMfJnfUwysUOpT1pEWfpcbxvQ0P5baq5fsTreIJE8RTS7F0F_IsPHLFlrtUe7mXX1iWoI04j28IcIGBObQU6wm1rvjeDex9ix3m_Bk3s',1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','$2y$10$msnSWKcBveugZc/r4XDcreTQ2ukljlrENW1txjsXT6POwQ7JRZsxq',1,'provider-serviceman',NULL,NULL,'2026-09-12 15:45:50','2026-10-27 15:24:02',1500.000,25.000,'SMAN001',NULL,0,0,NULL,'en','26.8381','80.9346','2026-10-27 15:24:02'),('sman-0001-0001-0001-000000000002','Santosh','Yadav','santosh@serviceman.com','+919234567802',NULL,'nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','$2y$10$mz7CjBtAe5t2AGlmoEN2b.9Y9ZLl3ZH7tNqOaKV/a8MkEbIQFFtIK',1,'provider-serviceman',NULL,NULL,'2026-09-12 15:45:50','2026-10-02 22:34:41',2200.000,40.000,'SMAN002',NULL,2,0,NULL,'en','28.5','77.03','2026-10-02 22:05:11'),('sman-0001-0001-0001-000000000003','Mahesh','Joshi','mahesh@serviceman.com','+919234567803',NULL,'nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'provider-serviceman',NULL,NULL,'2026-09-12 15:45:50','2026-10-22 17:54:33',3100.000,55.000,'SMAN003',NULL,2,0,NULL,'en',NULL,NULL,NULL),('sman-0001-0001-0001-000000000004','Sunil','Chauhan','sunil@serviceman.com','+919234567804',NULL,'nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'provider-serviceman',NULL,NULL,'2026-09-12 15:45:50','2026-10-22 17:54:34',1800.000,30.000,'SMAN004',NULL,2,0,NULL,'en',NULL,NULL,NULL),('sman-0001-0001-0001-000000000005','Dinesh','Pandey','dinesh@serviceman.com','+919234567805',NULL,'nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'provider-serviceman',NULL,NULL,'2026-09-12 15:45:50','2026-10-22 17:54:34',2500.000,45.000,'SMAN005',NULL,2,0,NULL,'en',NULL,NULL,NULL),('sman-0001-0001-0001-000000000006','Rajesh','Thakur','rajesh.thakur@serviceman.com','+919234567806',NULL,'nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'provider-serviceman',NULL,NULL,'2026-09-12 15:45:50','2026-09-12 15:45:50',4000.000,70.000,'SMAN006',NULL,1,0,NULL,'en',NULL,NULL,NULL),('sman-0001-0001-0001-000000000007','Kamlesh','Bhatt','kamlesh@serviceman.com','+919234567807',NULL,'nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'provider-serviceman',NULL,NULL,'2026-09-12 15:45:50','2026-09-12 15:45:50',1600.000,28.000,'SMAN007',NULL,0,0,NULL,'en',NULL,NULL,NULL),('sman-0001-0001-0001-000000000008','Pankaj','Mittal','pankaj@serviceman.com','+919234567808',NULL,'nid','[]',NULL,'male','default.png',NULL,1,1,'2026-09-12 15:45:50','2026-09-12 15:45:50','\\.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',1,'provider-serviceman',NULL,NULL,'2026-09-12 15:45:50','2026-09-12 15:45:50',2800.000,50.000,'SMAN008',NULL,1,0,NULL,'en',NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variations`
--

DROP TABLE IF EXISTS `variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `variant` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(24,3) NOT NULL DEFAULT '0.000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variations`
--

LOCK TABLES `variations` WRITE;
/*!40000 ALTER TABLE `variations` DISABLE KEYS */;
INSERT INTO `variations` VALUES (1,'Variant 1','Variant-1','f4d44b69-9b28-4c3c-8956-1c223367dd3a','a1614dbe-4732-11ee-9702-dee6e8d77be4',100.000,'2023-08-30 19:46:54','2023-08-30 19:46:54'),(5,'Per Visit','Per-Visit','svc-0001-0001-0001-000000000002','a1614dbe-4732-11ee-9702-dee6e8d77be4',599.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(6,'Monthly Package','Monthly-Package','svc-0001-0001-0001-000000000002','a1614dbe-4732-11ee-9702-dee6e8d77be4',1999.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(7,'3 Seater Sofa','3-Seater-Sofa','svc-0001-0001-0001-000000000003','a1614dbe-4732-11ee-9702-dee6e8d77be4',799.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(8,'5 Seater L-Shape','5-Seater-L-Shape','svc-0001-0001-0001-000000000003','a1614dbe-4732-11ee-9702-dee6e8d77be4',1299.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(9,'Minor Fix','Minor-Fix','svc-0001-0001-0001-000000000005','a1614dbe-4732-11ee-9702-dee6e8d77be4',299.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(10,'Major Repair','Major-Repair','svc-0001-0001-0001-000000000005','a1614dbe-4732-11ee-9702-dee6e8d77be4',899.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(11,'Repair Only','Repair-Only','svc-0001-0001-0001-000000000007','a1614dbe-4732-11ee-9702-dee6e8d77be4',199.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(12,'Repair and New Faucet','Repair-New-Faucet','svc-0001-0001-0001-000000000007','a1614dbe-4732-11ee-9702-dee6e8d77be4',699.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(13,'Standard Fan','Standard-Fan','svc-0001-0001-0001-000000000009','a1614dbe-4732-11ee-9702-dee6e8d77be4',399.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(14,'Decorative Fan','Decorative-Fan','svc-0001-0001-0001-000000000009','a1614dbe-4732-11ee-9702-dee6e8d77be4',599.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(15,'Split AC 1 Ton','Split-AC-1-Ton','svc-0001-0001-0001-000000000012','a1614dbe-4732-11ee-9702-dee6e8d77be4',1499.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(16,'Split AC 1.5 Ton','Split-AC-1.5-Ton','svc-0001-0001-0001-000000000012','a1614dbe-4732-11ee-9702-dee6e8d77be4',1799.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(17,'Window AC','Window-AC','svc-0001-0001-0001-000000000012','a1614dbe-4732-11ee-9702-dee6e8d77be4',999.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(18,'R22 Gas','R22-Gas','svc-0001-0001-0001-000000000013','a1614dbe-4732-11ee-9702-dee6e8d77be4',1200.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(19,'R32 Gas','R32-Gas','svc-0001-0001-0001-000000000013','a1614dbe-4732-11ee-9702-dee6e8d77be4',1500.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(20,'Split AC Service','Split-AC-Service','svc-0001-0001-0001-000000000014','a1614dbe-4732-11ee-9702-dee6e8d77be4',499.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(21,'Window AC Service','Window-AC-Service','svc-0001-0001-0001-000000000014','a1614dbe-4732-11ee-9702-dee6e8d77be4',399.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(22,'1 BHK Basic','1-BHK-Basic','svc-0001-0001-0001-000000000015','a1614dbe-4732-11ee-9702-dee6e8d77be4',1199.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(23,'2 BHK Standard','2-BHK-Standard','svc-0001-0001-0001-000000000015','a1614dbe-4732-11ee-9702-dee6e8d77be4',1999.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(24,'3 BHK Premium','3-BHK-Premium','svc-0001-0001-0001-000000000015','a1614dbe-4732-11ee-9702-dee6e8d77be4',2799.000,'2026-09-12 15:45:55','2026-09-12 15:45:55'),(43,'2-BHK','2-BHK','svc-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168',1101.000,'2026-09-25 01:17:04','2026-09-25 01:17:04'),(44,'2-BHK','2-BHK','svc-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4',2499.000,'2026-09-25 01:17:04','2026-09-25 01:17:04'),(45,'3-BHK','3-BHK','svc-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168',1110.000,'2026-09-25 01:17:04','2026-09-25 01:17:04'),(46,'3-BHK','3-BHK','svc-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4',3499.000,'2026-09-25 01:17:04','2026-09-25 01:17:04'),(47,'4-BHK','4-BHK','svc-0001-0001-0001-000000000001','c00ed508-2bf3-43c3-b95c-8e880de67168',1011.000,'2026-09-25 01:17:04','2026-09-25 01:17:04'),(48,'4-BHK','4-BHK','svc-0001-0001-0001-000000000001','a1614dbe-4732-11ee-9702-dee6e8d77be4',4499.000,'2026-09-25 01:17:04','2026-09-25 01:17:04'),(49,'Standard Fan','Standard-Fan','79796925-a923-4dac-a9f8-e1bee4ef7798','a1614dbe-4732-11ee-9702-dee6e8d77be4',449.000,'2026-10-04 01:15:42','2026-10-04 01:45:58'),(50,'Decorative Fan','Decorative-Fan','79796925-a923-4dac-a9f8-e1bee4ef7798','a1614dbe-4732-11ee-9702-dee6e8d77be4',649.000,'2026-10-04 01:15:42','2026-10-04 01:45:58'),(51,'Standard','standard','cd4d6231-88ca-4ab8-8611-22eb63931792','a1614dbe-4732-11ee-9702-dee6e8d77be4',349.000,'2026-10-04 01:22:22','2026-10-04 01:22:22'),(52,'Standard','standard','2e079f76-18b9-4674-bd1e-639a7ff17015','a1614dbe-4732-11ee-9702-dee6e8d77be4',250.000,'2026-10-04 01:46:17','2026-10-04 01:46:17'),(53,'Standard','standard','39424600-c420-42f4-a925-681ac1bf9993','a1614dbe-4732-11ee-9702-dee6e8d77be4',349.000,'2026-10-04 03:26:57','2026-10-04 03:26:57'),(87,'new','new','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5','6b1c8733-b0ff-4c65-a745-1f46419adc49',1110.000,'2026-10-12 17:24:11','2026-10-12 17:24:11'),(88,'new','new','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5','c00ed508-2bf3-43c3-b95c-8e880de67168',0.000,'2026-10-12 17:24:11','2026-10-12 17:24:11'),(89,'new','new','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5','a1614dbe-4732-11ee-9702-dee6e8d77be4',0.000,'2026-10-12 17:24:11','2026-10-12 17:24:11'),(101,'1','1','513bce46-8576-413f-9809-96ba2fb8a5f2','6b1c8733-b0ff-4c65-a745-1f46419adc49',10.000,'2026-10-27 11:40:12','2026-10-27 11:40:12'),(102,'1','1','513bce46-8576-413f-9809-96ba2fb8a5f2','c00ed508-2bf3-43c3-b95c-8e880de67168',1000.000,'2026-10-27 11:40:12','2026-10-27 11:40:12'),(103,'1','1','513bce46-8576-413f-9809-96ba2fb8a5f2','a1614dbe-4732-11ee-9702-dee6e8d77be4',1000.000,'2026-10-27 11:40:12','2026-10-27 11:40:12');
/*!40000 ALTER TABLE `variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visited_services`
--

DROP TABLE IF EXISTS `visited_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visited_services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `count` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visited_services`
--

LOCK TABLES `visited_services` WRITE;
/*!40000 ALTER TABLE `visited_services` DISABLE KEYS */;
INSERT INTO `visited_services` VALUES (1,'31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000001',86,'2026-09-17 23:45:18','2026-10-18 20:49:45'),(2,'31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000007',2,'2026-09-17 23:45:51','2026-09-19 00:52:36'),(3,'31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000005',2,'2026-09-19 00:31:20','2026-09-19 01:19:32'),(4,'31f1bff9-432d-48ab-8e12-dcfc38d46069','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5',20,'2026-10-04 23:02:21','2026-10-27 10:54:06'),(5,'31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000014',1,'2026-10-05 12:54:55','2026-10-05 12:54:55'),(6,'31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000003',2,'2026-10-17 10:03:40','2026-10-17 11:14:07'),(7,'31f1bff9-432d-48ab-8e12-dcfc38d46069','svc-0001-0001-0001-000000000009',1,'2026-10-17 11:13:55','2026-10-17 11:13:55'),(8,'cust-0001-0001-0001-000000000001','513bce46-8576-413f-9809-96ba2fb8a5f2',8,'2026-10-27 12:05:57','2026-10-27 17:00:49'),(9,'cust-0001-0001-0001-000000000001','svc-0001-0001-0001-000000000001',7,'2026-10-27 12:06:26','2026-10-27 16:02:44'),(10,'cust-0001-0001-0001-000000000001','99cc26c2-4dd3-4998-b6d5-884bb0f9bdd5',3,'2026-10-27 15:36:17','2026-10-27 17:28:01');
/*!40000 ALTER TABLE `visited_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdraw_requests`
--

DROP TABLE IF EXISTS `withdraw_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdraw_requests` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_updated_by` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(24,2) NOT NULL DEFAULT '0.00',
  `request_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `withdrawal_method_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `withdrawal_method_fields` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdraw_requests`
--

LOCK TABLES `withdraw_requests` WRITE;
/*!40000 ALTER TABLE `withdraw_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `withdraw_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdrawal_methods`
--

DROP TABLE IF EXISTS `withdrawal_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdrawal_methods` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_fields` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdrawal_methods`
--

LOCK TABLES `withdrawal_methods` WRITE;
/*!40000 ALTER TABLE `withdrawal_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `withdrawal_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zones`
--

DROP TABLE IF EXISTS `zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zones` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coordinates` polygon DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `provider_search_radius` decimal(5,2) NOT NULL DEFAULT '5.00',
  `max_search_radius` decimal(5,2) NOT NULL DEFAULT '15.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `zones_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zones`
--

LOCK TABLES `zones` WRITE;
/*!40000 ALTER TABLE `zones` DISABLE KEYS */;
INSERT INTO `zones` VALUES ('6b1c8733-b0ff-4c65-a745-1f46419adc49','2 zone',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0¶\€!\r T@G˝\Œu;@\’\“4e¿S@\“‹´‘ñ:@ÎòñV¶?T@~\ \ŸM\œ:@≈∂7\’pÇT@≠a%u≠:@¶\€!\r T@G˝\Œu;@',1,5.00,15.00,'2026-10-04 23:12:34','2026-10-04 23:12:34'),('a1614dbe-4732-11ee-9702-dee6e8d77be4','All over the World',_binary '\0\0\0\0\0\0\0\0\0\0%\0\0\0\ﬁWyV\⁄Ef¿_˚(G\ÓQ@\ﬁWyV\e¿\Ù±\Èæ\ÁP@\ﬁWyV\"we¿TŸ•.Z≤P@\ﬁWyV<e¿YΩ\·ÃàP@\ﬁWyV:_e¿≈û˘˙cP@\ﬁWyV\Zùe¿ïåÆ\ÊA\ZP@\ﬁWyVB\Ìe¿WT©+S>P@\ﬁWyV\nCf¿¨0yç\ÒjP@\ﬁWyV\“>f¿kæ`ªdüP@\"®Ü©f@D\Ã¯¶ﬂëP@\"®Ü©\’sf@ao\Ï\È≥@P@\"®Ü©\ıbf@\'\€\√PZPO@ã1SãÇ5d@\÷\ıc~NL@ã1Sãb±b@$?˚áK\Z¿ã1Sã\‚f@\—¿èQöNC¿ã1Sã-e@\À	Ñ\€G¿ã1Sã\"òa@n<qÅ CB¿c¶Ö]@<˙^s≠@¿û\≈L-äcF@ua&™£q8¿<ãôZ+4@\Ã\”\·d∞\Â@¿1ùY\È∫1Q¿HÉ\ÈxK¿1ùY\ÈzéR¿ì}≠4)\’H¿1ùY\Èz&Q¿ƒÇ\n3¿1ùYÈ∫ßS¿+ñH	-˚ ¿\ÎúY\È∫tY¿µÑYL6\Ê2@\ÎúY\È:§^¿ëè›ù ¶C@uŒ¨täc¿.§\ﬂAM@uŒ¨t]\–d¿Äs≤T\ÁgP@uŒ¨tùÆd¿é\–\¬\–\r(Q@uŒ¨tΩèc¿•)\€$TøQ@\ÎúY\Èz\Í_¿\\\‡\ﬂsQ@1ùY\È:æS¿\Ë¯óo∂ßT@<ãôZ9@^\‚|\›\ÌS@û\≈L-ä>M@)GGU\‘¡R@c¶\≈OZ@\nCÑY\‰\ÊR@ã1Sãb˝a@R{\Ì\Ï\ıQ@\ﬁWyV\⁄Ef¿_˚(G\ÓQ@',1,5.00,15.00,'2023-08-30 12:41:41','2023-08-30 12:41:41'),('c00ed508-2bf3-43c3-b95c-8e880de67168','new',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0O≤&SêDS@	*\Èa\€t=@˛ß¶V\ \€R@¢\Û∞ê4<@¨\‘÷´ïãS@\Ò@\‹J<@˘ì\Í¡nS@4\ﬁ7WÇm=@O≤&SêDS@	*\Èa\€t=@',1,5.00,15.00,'2026-09-15 17:52:27','2026-09-15 17:52:27');
/*!40000 ALTER TABLE `zones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-28  9:51:11
