
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!50717 SELECT COUNT(*) INTO @rocksdb_has_p_s_session_variables FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'performance_schema' AND TABLE_NAME = 'session_variables' */;
/*!50717 SET @rocksdb_get_is_supported = IF (@rocksdb_has_p_s_session_variables, 'SELECT COUNT(*) INTO @rocksdb_is_supported FROM performance_schema.session_variables WHERE VARIABLE_NAME=\'rocksdb_bulk_load\'', 'SELECT 0') */;
/*!50717 PREPARE s FROM @rocksdb_get_is_supported */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;
/*!50717 SET @rocksdb_enable_bulk_load = IF (@rocksdb_is_supported, 'SET SESSION rocksdb_bulk_load = 1', 'SET @rocksdb_dummy_bulk_load = 0') */;
/*!50717 PREPARE s FROM @rocksdb_enable_bulk_load */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mautic3` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `mautic3`;
DROP TABLE IF EXISTS `asset_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_downloads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `email_id` int(10) unsigned DEFAULT NULL,
  `date_download` datetime NOT NULL,
  `code` int(11) NOT NULL,
  `referer` longtext COLLATE utf8mb4_unicode_ci,
  `tracking_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A6494C8F5DA1941` (`asset_id`),
  KEY `IDX_A6494C8FA03F5E9F` (`ip_id`),
  KEY `IDX_A6494C8F55458D` (`lead_id`),
  KEY `IDX_A6494C8FA832C1C9` (`email_id`),
  KEY `download_tracking_search` (`tracking_id`),
  KEY `download_source_search` (`source`,`source_id`),
  KEY `asset_date_download` (`date_download`),
  CONSTRAINT `FK_A6494C8F55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_A6494C8F5DA1941` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_A6494C8FA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_A6494C8FA832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `asset_downloads` WRITE;
/*!40000 ALTER TABLE `asset_downloads` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_downloads` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `alias` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `storage_location` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remote_path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `original_file_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `download_count` int(11) NOT NULL,
  `unique_download_count` int(11) NOT NULL,
  `revision` int(11) NOT NULL,
  `extension` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mime` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `disallow` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_79D17D8E12469DE2` (`category_id`),
  KEY `asset_alias_search` (`alias`),
  CONSTRAINT `FK_79D17D8E12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bundle` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `object` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `object_id` bigint(20) unsigned NOT NULL,
  `action` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `date_added` datetime NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_search` (`object`,`object_id`),
  KEY `timeline_search` (`bundle`,`object`,`action`,`object_id`),
  KEY `date_added_index` (`date_added`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-09 14:19:30','77.239.52.157'),(2,1,'Alain Habegger','config','config',0,'update','a:14:{s:6:\"locale\";s:2:\"de\";s:17:\"do_not_track_bots\";a:389:{i:0;s:6:\"MSNBOT\";i:1;s:12:\"msnbot-media\";i:2;s:7:\"bingbot\";i:3;s:9:\"Googlebot\";i:4;s:18:\"Google Web Preview\";i:5;s:20:\"Mediapartners-Google\";i:6;s:11:\"Baiduspider\";i:7;s:6:\"Ezooms\";i:8;s:11:\"YahooSeeker\";i:9;s:5:\"Slurp\";i:10;s:9:\"AltaVista\";i:11;s:8:\"AVSearch\";i:12;s:8:\"Mercator\";i:13;s:7:\"Scooter\";i:14;s:8:\"InfoSeek\";i:15;s:9:\"Ultraseek\";i:16;s:5:\"Lycos\";i:17;s:4:\"Wget\";i:18;s:9:\"YandexBot\";i:19;s:13:\"Java/1.4.1_04\";i:20;s:7:\"SiteBot\";i:21;s:6:\"Exabot\";i:22;s:9:\"AhrefsBot\";i:23;s:7:\"MJ12bot\";i:24;s:15:\"NetSeer crawler\";i:25;s:11:\"TurnitinBot\";i:26;s:14:\"magpie-crawler\";i:27;s:13:\"Nutch Crawler\";i:28;s:11:\"CMS Crawler\";i:29;s:8:\"rogerbot\";i:30;s:8:\"Domnutch\";i:31;s:11:\"ssearch_bot\";i:32;s:7:\"XoviBot\";i:33;s:9:\"digincore\";i:34;s:10:\"fr-crawler\";i:35;s:9:\"SeznamBot\";i:36;s:27:\"Seznam screenshot-generator\";i:37;s:7:\"Facebot\";i:38;s:19:\"facebookexternalhit\";i:39;s:9:\"SimplePie\";i:40;s:7:\"Riddler\";i:41;s:14:\"007ac9 Crawler\";i:42;s:9:\"360Spider\";i:43;s:10:\"A6-Indexer\";i:44;s:7:\"ADmantX\";i:45;s:3:\"AHC\";i:46;s:11:\"AISearchBot\";i:47;s:11:\"APIs-Google\";i:48;s:8:\"Aboundex\";i:49;s:7:\"AddThis\";i:50;s:8:\"Adidxbot\";i:51;s:13:\"AdsBot-Google\";i:52;s:13:\"AdsTxtCrawler\";i:53;s:6:\"AdvBot\";i:54;s:6:\"Ahrefs\";i:55;s:8:\"AlphaBot\";i:56;s:17:\"Amazon CloudFront\";i:57;s:13:\"AndersPinkBot\";i:58;s:17:\"Apache-HttpClient\";i:59;s:8:\"Apercite\";i:60;s:16:\"AppEngine-Google\";i:61;s:8:\"Applebot\";i:62;s:10:\"ArchiveBot\";i:63;s:6:\"BDCbot\";i:64;s:9:\"BIGLOTRON\";i:65;s:7:\"BLEXBot\";i:66;s:8:\"BLP_bbot\";i:67;s:11:\"BTWebClient\";i:68;s:6:\"BUbiNG\";i:69;s:15:\"Baidu-YunGuanCe\";i:70;s:10:\"Barkrowler\";i:71;s:10:\"BehloolBot\";i:72;s:11:\"BingPreview\";i:73;s:10:\"BomboraBot\";i:74;s:16:\"Bot.AraTurka.com\";i:75;s:9:\"BoxcarBot\";i:76;s:11:\"BrandVerity\";i:77;s:4:\"Buck\";i:78;s:18:\"CC Metadata Scaper\";i:79;s:5:\"CCBot\";i:80;s:14:\"CapsuleChecker\";i:81;s:8:\"Cliqzbot\";i:82;s:23:\"CloudFlare-AlwaysOnline\";i:83;s:19:\"Companybook-Crawler\";i:84;s:13:\"ContextAd Bot\";i:85;s:9:\"CrunchBot\";i:86;s:19:\"CrystalSemanticsBot\";i:87;s:11:\"CyberPatrol\";i:88;s:9:\"DareBoost\";i:89;s:13:\"Datafeedwatch\";i:90;s:4:\"Daum\";i:91;s:5:\"DeuSu\";i:92;s:21:\"developers.google.com\";i:93;s:7:\"Diffbot\";i:94;s:11:\"Digg Deeper\";i:95;s:13:\"Digincore bot\";i:96;s:10:\"Discordbot\";i:97;s:6:\"Disqus\";i:98;s:7:\"DnyzBot\";i:99;s:22:\"Domain Re-Animator Bot\";i:100;s:14:\"DomainStatsBot\";i:101;s:11:\"DuckDuckBot\";i:102;s:23:\"DuckDuckGo-Favicons-Bot\";i:103;s:4:\"EZID\";i:104;s:7:\"Embedly\";i:105;s:17:\"EveryoneSocialBot\";i:106;s:11:\"ExtLinksBot\";i:107;s:23:\"FAST Enterprise Crawler\";i:108;s:15:\"FAST-WebCrawler\";i:109;s:18:\"Feedfetcher-Google\";i:110;s:6:\"Feedly\";i:111;s:11:\"Feedspotbot\";i:112;s:14:\"FemtosearchBot\";i:113;s:5:\"Fetch\";i:114;s:5:\"Fever\";i:115;s:21:\"Flamingo_SearchEngine\";i:116;s:14:\"FlipboardProxy\";i:117;s:7:\"Fyrebot\";i:118;s:13:\"GarlikCrawler\";i:119;s:6:\"Genieo\";i:120;s:9:\"Gigablast\";i:121;s:7:\"Gigabot\";i:122;s:13:\"GingerCrawler\";i:123;s:19:\"Gluten Free Crawler\";i:124;s:13:\"GnowitNewsbot\";i:125;s:14:\"Go-http-client\";i:126;s:22:\"Google-Adwords-Instant\";i:127;s:9:\"Gowikibot\";i:128;s:16:\"GrapeshotCrawler\";i:129;s:7:\"Grobbot\";i:130;s:7:\"HTTrack\";i:131;s:6:\"Hatena\";i:132;s:11:\"IAS crawler\";i:133;s:11:\"ICC-Crawler\";i:134;s:9:\"IndeedBot\";i:135;s:15:\"InterfaxScanBot\";i:136;s:10:\"IstellaBot\";i:137;s:9:\"James BOT\";i:138;s:14:\"Jamie\'s Spider\";i:139;s:8:\"Jetslide\";i:140;s:5:\"Jetty\";i:141;s:28:\"Jugendschutzprogramm-Crawler\";i:142;s:9:\"K7MLWCBot\";i:143;s:8:\"Kemvibot\";i:144;s:9:\"KosmioBot\";i:145;s:19:\"Landau-Media-Spider\";i:146;s:12:\"Laserlikebot\";i:147;s:8:\"Leikibot\";i:148;s:11:\"Linguee Bot\";i:149;s:12:\"LinkArchiver\";i:150;s:11:\"LinkedInBot\";i:151;s:10:\"LivelapBot\";i:152;s:16:\"Luminator-robots\";i:153;s:11:\"Mail.RU_Bot\";i:154;s:8:\"Mastodon\";i:155;s:7:\"MauiBot\";i:156;s:15:\"Mediatoolkitbot\";i:157;s:9:\"MegaIndex\";i:158;s:13:\"MeltwaterNews\";i:159;s:10:\"MetaJobBot\";i:160;s:7:\"MetaURI\";i:161;s:8:\"Miniflux\";i:162;s:9:\"MojeekBot\";i:163;s:8:\"Moreover\";i:164;s:8:\"MuckRack\";i:165;s:12:\"Multiviewbot\";i:166;s:4:\"NING\";i:167;s:16:\"NerdByNature.Bot\";i:168;s:19:\"NetcraftSurveyAgent\";i:169;s:8:\"Netvibes\";i:170;s:16:\"Nimbostratus-Bot\";i:171;s:6:\"Nuzzel\";i:172;s:10:\"Ocarinabot\";i:173;s:11:\"OpenHoseBot\";i:174;s:9:\"OrangeBot\";i:175;s:12:\"OutclicksBot\";i:176;s:8:\"PR-CY.RU\";i:177;s:10:\"PaperLiBot\";i:178;s:10:\"Pcore-HTTP\";i:179;s:9:\"PhantomJS\";i:180;s:7:\"PiplBot\";i:181;s:12:\"PocketParser\";i:182;s:9:\"Primalbot\";i:183;s:15:\"PrivacyAwareBot\";i:184;s:10:\"Pulsepoint\";i:185;s:13:\"Python-urllib\";i:186;s:8:\"Qwantify\";i:187;s:17:\"RankActiveLinkBot\";i:188;s:19:\"RetrevoPageAnalyzer\";i:189;s:7:\"SBL-BOT\";i:190;s:10:\"SEMrushBot\";i:191;s:8:\"SEOkicks\";i:192;s:8:\"SWIMGBot\";i:193;s:10:\"SafeDNSBot\";i:194;s:28:\"SafeSearch microdata crawler\";i:195;s:8:\"ScoutJet\";i:196;s:6:\"Scrapy\";i:197;s:25:\"Screaming Frog SEO Spider\";i:198;s:18:\"SemanticScholarBot\";i:199;s:13:\"SimpleCrawler\";i:200;s:15:\"Siteimprove.com\";i:201;s:15:\"SkypeUriPreview\";i:202;s:14:\"Slack-ImgProxy\";i:203;s:8:\"Slackbot\";i:204;s:9:\"Snacktory\";i:205;s:15:\"SocialRankIOBot\";i:206;s:5:\"Sogou\";i:207;s:5:\"Sonic\";i:208;s:12:\"StorygizeBot\";i:209;s:9:\"SurveyBot\";i:210;s:7:\"Sysomos\";i:211;s:12:\"TangibleeBot\";i:212;s:11:\"TelegramBot\";i:213;s:5:\"Teoma\";i:214;s:8:\"Thinklab\";i:215;s:6:\"TinEye\";i:216;s:13:\"ToutiaoSpider\";i:217;s:11:\"Traackr.com\";i:218;s:5:\"Trove\";i:219;s:12:\"TweetmemeBot\";i:220;s:10:\"Twitterbot\";i:221;s:6:\"Twurly\";i:222;s:6:\"Upflow\";i:223;s:11:\"UptimeRobot\";i:224;s:20:\"UsineNouvelleCrawler\";i:225;s:8:\"Veoozbot\";i:226;s:12:\"WeSEE:Search\";i:227;s:8:\"WhatsApp\";i:228;s:16:\"Xenu Link Sleuth\";i:229;s:3:\"Y!J\";i:230;s:3:\"YaK\";i:231;s:18:\"Yahoo Link Preview\";i:232;s:4:\"Yeti\";i:233;s:11:\"YisouSpider\";i:234;s:6:\"Zabbix\";i:235;s:11:\"ZoominfoBot\";i:236;s:6:\"ZumBot\";i:237;s:12:\"ZuperlistBot\";i:238;s:4:\"^LCC\";i:239;s:7:\"acapbot\";i:240;s:8:\"acoonbot\";i:241;s:10:\"adbeat_bot\";i:242;s:9:\"adscanner\";i:243;s:8:\"aiHitBot\";i:244;s:7:\"antibot\";i:245;s:6:\"arabot\";i:246;s:15:\"archive.org_bot\";i:247;s:5:\"axios\";i:248;s:15:\"backlinkcrawler\";i:249;s:7:\"betaBot\";i:250;s:10:\"bibnum.bnf\";i:251;s:6:\"binlar\";i:252;s:8:\"bitlybot\";i:253;s:9:\"blekkobot\";i:254;s:11:\"blogmuraBot\";i:255;s:10:\"bnf.fr_bot\";i:256;s:18:\"bot-pge.chlooe.com\";i:257;s:6:\"botify\";i:258;s:9:\"brainobot\";i:259;s:7:\"buzzbot\";i:260;s:9:\"cXensebot\";i:261;s:9:\"careerbot\";i:262;s:11:\"centurybot9\";i:263;s:15:\"changedetection\";i:264;s:10:\"check_http\";i:265;s:12:\"citeseerxbot\";i:266;s:6:\"coccoc\";i:267;s:21:\"collection@infegy.com\";i:268;s:22:\"content crawler spider\";i:269;s:8:\"contxbot\";i:270;s:7:\"convera\";i:271;s:9:\"crawler4j\";i:272;s:4:\"curl\";i:273;s:12:\"datagnionbot\";i:274;s:6:\"dcrawl\";i:275;s:15:\"deadlinkchecker\";i:276;s:8:\"discobot\";i:277;s:13:\"domaincrawler\";i:278;s:6:\"dotbot\";i:279;s:7:\"drupact\";i:280;s:13:\"ec2linkfinder\";i:281;s:10:\"edisterbot\";i:282;s:12:\"electricmonk\";i:283;s:8:\"elisabot\";i:284;s:7:\"epicbot\";i:285;s:6:\"eright\";i:286;s:16:\"europarchive.org\";i:287;s:6:\"exabot\";i:288;s:6:\"ezooms\";i:289;s:16:\"filterdb.iss.net\";i:290;s:8:\"findlink\";i:291;s:12:\"findthatfile\";i:292;s:8:\"findxbot\";i:293;s:6:\"fluffy\";i:294;s:7:\"fuelbot\";i:295;s:10:\"g00g1e.net\";i:296;s:12:\"g2reader-bot\";i:297;s:16:\"gnam gnam spider\";i:298;s:14:\"google-xrawler\";i:299;s:8:\"grub.org\";i:300;s:7:\"gslfbot\";i:301;s:8:\"heritrix\";i:302;s:8:\"http_get\";i:303;s:8:\"httpunit\";i:304;s:11:\"ia_archiver\";i:305;s:6:\"ichiro\";i:306;s:6:\"imrbot\";i:307;s:11:\"integromedb\";i:308;s:12:\"intelium_bot\";i:309;s:18:\"ip-web-crawler.com\";i:310;s:9:\"ips-agent\";i:311;s:7:\"iskanie\";i:312;s:23:\"it2media-domain-crawler\";i:313;s:7:\"jyxobot\";i:314;s:9:\"lb-spider\";i:315;s:6:\"libwww\";i:316;s:13:\"linkapediabot\";i:317;s:7:\"linkdex\";i:318;s:9:\"lipperhey\";i:319;s:6:\"lssbot\";i:320;s:16:\"lssrocketcrawler\";i:321;s:5:\"ltx71\";i:322;s:9:\"mappydata\";i:323;s:9:\"memorybot\";i:324;s:9:\"mindUpBot\";i:325;s:5:\"mlbot\";i:326;s:7:\"moatbot\";i:327;s:6:\"msnbot\";i:328;s:6:\"msrbot\";i:329;s:8:\"nerdybot\";i:330;s:20:\"netEstate NE Crawler\";i:331;s:17:\"netresearchserver\";i:332;s:14:\"newsharecounts\";i:333;s:9:\"newspaper\";i:334;s:8:\"niki-bot\";i:335;s:5:\"nutch\";i:336;s:6:\"okhttp\";i:337;s:6:\"omgili\";i:338;s:15:\"openindexspider\";i:339;s:8:\"page2rss\";i:340;s:9:\"panscient\";i:341;s:8:\"phpcrawl\";i:342;s:7:\"pingdom\";i:343;s:9:\"pinterest\";i:344;s:8:\"postrank\";i:345;s:8:\"proximic\";i:346;s:5:\"psbot\";i:347;s:7:\"purebot\";i:348;s:15:\"python-requests\";i:349;s:9:\"redditbot\";i:350;s:9:\"scribdbot\";i:351;s:7:\"seekbot\";i:352;s:11:\"semanticbot\";i:353;s:6:\"sentry\";i:354;s:11:\"seoscanners\";i:355;s:9:\"seznambot\";i:356;s:15:\"sistrix crawler\";i:357;s:7:\"sitebot\";i:358;s:17:\"siteexplorer.info\";i:359;s:6:\"smtbot\";i:360;s:5:\"spbot\";i:361;s:6:\"speedy\";i:362;s:7:\"summify\";i:363;s:8:\"tagoobot\";i:364;s:10:\"toplistbot\";i:365;s:11:\"tracemyfile\";i:366;s:14:\"trendictionbot\";i:367;s:11:\"turnitinbot\";i:368;s:9:\"twengabot\";i:369;s:5:\"um-LN\";i:370;s:12:\"urlappendbot\";i:371;s:10:\"vebidoobot\";i:372;s:7:\"vkShare\";i:373;s:8:\"voilabot\";i:374;s:11:\"wbsearchbot\";i:375;s:23:\"web-archive-net.com.bot\";i:376;s:17:\"webcompanycrawler\";i:377;s:6:\"webmon\";i:378;s:4:\"wget\";i:379;s:6:\"wocbot\";i:380;s:6:\"woobot\";i:381;s:8:\"woriobot\";i:382;s:6:\"wotbox\";i:383;s:7:\"xovibot\";i:384;s:7:\"yacybot\";i:385;s:10:\"yandex.com\";i:386;s:5:\"yanga\";i:387;s:7:\"yoozBot\";i:388;s:5:\"zgrab\";}s:5:\"theme\";s:5:\"Mauve\";s:32:\"api_oauth2_access_token_lifetime\";d:60;s:33:\"api_oauth2_refresh_token_lifetime\";d:14;s:16:\"unsubscribe_text\";s:68:\"<a href=\"|URL|\">Unsubscribe</a> to no longer receive emails from us.\";s:12:\"webview_text\";s:66:\"<a href=\"|URL|\">Having trouble reading this email? Click here.</a>\";s:19:\"unsubscribe_message\";s:146:\"We are sorry to see you go! |EMAIL| will no longer receive emails from us. If this was by mistake, <a href=\"|URL|\">click here to re-subscribe</a>.\";s:19:\"resubscribe_message\";s:102:\"|EMAIL| has been re-subscribed. If this was by mistake, <a href=\"|URL|\">click here to unsubscribe</a>.\";s:22:\"default_signature_text\";s:25:\"Best regards, |FROM_NAME|\";s:13:\"sms_transport\";N;s:24:\"saml_idp_email_attribute\";s:12:\"EmailAddress\";s:28:\"saml_idp_firstname_attribute\";s:9:\"FirstName\";s:27:\"saml_idp_lastname_attribute\";s:8:\"LastName\";}','2022-05-09 14:20:06','77.239.52.157'),(3,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-09 14:20:20','77.239.52.157'),(4,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-10 12:03:29','77.239.52.157'),(5,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-10 13:57:23','77.239.52.157'),(6,1,'Alain Habegger','email','email',1,'create','a:3:{s:7:\"subject\";a:2:{i:0;N;i:1;s:11:\"hello world\";}s:7:\"utmTags\";a:2:{i:0;a:0:{}i:1;a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}}s:8:\"template\";a:2:{i:0;N;i:1;s:5:\"blank\";}}','2022-05-10 14:18:39','77.239.52.157'),(7,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-10 14:20:49','77.239.52.157'),(8,1,'Alain Habegger','config','config',0,'update','a:1:{s:8:\"site_url\";s:38:\"https://beeprotest.automationmonkey.ch\";}','2022-05-10 14:23:48','77.239.52.157'),(9,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-10 14:24:30','77.239.52.157'),(10,1,'Alain Habegger','config','config',0,'update','a:6:{s:11:\"mailer_host\";s:37:\"email-smtp.eu-central-1.amazonaws.com\";s:11:\"mailer_port\";s:3:\"587\";s:11:\"mailer_user\";s:20:\"AKIA3PJY6CWOKH7JQ5NN\";s:15:\"mailer_password\";s:44:\"BDUop0lLe8vIdVPkgjEdIRNPSPq6ZptJrWP/fk7BI0Ge\";s:17:\"mailer_encryption\";s:3:\"tls\";s:16:\"mailer_auth_mode\";s:5:\"login\";}','2022-05-10 14:28:11','77.239.52.157'),(11,1,'Alain Habegger','config','config',0,'update','a:2:{s:15:\"mailer_password\";N;s:12:\"webview_text\";s:126:\"<a style=\"color:#c6a55a; text-decoration:none;\" href=\"|URL|\">Hier klicken, falls Sie Probleme haben diese E-Mail zu lesen.</a>\";}','2022-05-10 14:35:47','77.239.52.157'),(12,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-11 14:38:37','77.239.52.157'),(13,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-12 06:43:56','77.239.52.157'),(14,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-12 14:58:04','77.239.52.157'),(15,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-12 14:58:29','77.239.52.157'),(16,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-13 08:08:02','77.239.52.157'),(17,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-13 12:26:39','77.239.52.157'),(18,1,'Alain Habegger','lead','segment',1,'create','a:5:{s:4:\"name\";a:2:{i:0;N;i:1;s:3:\"all\";}s:8:\"isGlobal\";a:2:{i:0;b:1;i:1;i:1;}s:18:\"isPreferenceCenter\";a:2:{i:0;b:0;i:1;i:0;}s:5:\"alias\";a:2:{i:0;N;i:1;s:3:\"all\";}s:10:\"publicName\";a:2:{i:0;N;i:1;s:3:\"all\";}}','2022-05-13 12:27:31','77.239.52.157'),(19,1,'Alain Habegger','lead','segment',1,'update','a:3:{s:8:\"isGlobal\";a:2:{i:0;b:1;i:1;i:1;}s:18:\"isPreferenceCenter\";a:2:{i:0;b:0;i:1;i:0;}s:12:\"dateModified\";a:2:{i:0;N;i:1;s:25:\"2022-05-13T12:27:32+00:00\";}}','2022-05-13 12:27:32','77.239.52.157'),(20,1,'Alain Habegger','lead','field',44,'create','a:6:{s:5:\"label\";a:2:{i:0;N;i:1;s:17:\"rabattcode_kambly\";}s:10:\"isRequired\";a:2:{i:0;b:0;i:1;i:0;}s:9:\"isVisible\";a:2:{i:0;b:1;i:1;i:1;}s:14:\"isShortVisible\";a:2:{i:0;b:1;i:1;i:1;}s:10:\"isListable\";a:2:{i:0;b:1;i:1;i:1;}s:5:\"alias\";a:2:{i:0;N;i:1;s:17:\"rabattcode_kambly\";}}','2022-05-13 12:28:19','77.239.52.157'),(21,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-13 15:18:09','77.239.52.157'),(22,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-05-31 14:33:08','77.239.52.157'),(23,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-06-02 07:47:02','77.239.52.157'),(24,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-06-12 06:49:33','188.154.215.66'),(25,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-06-12 07:12:18','188.154.215.66'),(26,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-06-12 07:22:57','188.154.215.66'),(27,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-06-12 08:04:56','188.154.215.66'),(28,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-06-12 08:24:40','188.154.215.66'),(29,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-06-13 06:28:52','188.154.215.66'),(30,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-06-13 15:58:59','77.239.52.157'),(31,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-06-14 09:39:51','77.239.52.157'),(32,1,'Alain Habegger','email','email',2,'create','a:3:{s:7:\"subject\";a:2:{i:0;N;i:1;s:4:\"Test\";}s:7:\"utmTags\";a:2:{i:0;a:0:{}i:1;a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}}s:8:\"template\";a:2:{i:0;N;i:1;s:5:\"blank\";}}','2022-06-14 15:21:33','77.239.52.157'),(33,1,'Alain Habegger','campaign','campaign',1,'create','a:6:{s:4:\"name\";a:2:{i:0;N;i:1;s:4:\"Test\";}s:11:\"description\";a:2:{i:0;N;i:1;s:4:\"Test\";}s:12:\"allowRestart\";a:2:{i:0;b:0;i:1;i:0;}s:11:\"isPublished\";a:2:{i:0;b:1;i:1;b:0;}s:5:\"lists\";a:1:{s:5:\"added\";a:1:{i:1;s:3:\"all\";}}s:6:\"events\";a:1:{s:5:\"added\";a:3:{s:43:\"new6e6edd47885d4dbf49e4352ab80065fbb1203dd9\";a:2:{i:0;s:43:\"new6e6edd47885d4dbf49e4352ab80065fbb1203dd9\";i:1;a:7:{s:4:\"name\";a:2:{i:0;N;i:1;s:11:\"Check Email\";}s:11:\"triggerMode\";a:2:{i:0;N;i:1;s:9:\"immediate\";}s:15:\"triggerInterval\";a:2:{i:0;i:0;i:1;d:1;}s:19:\"triggerIntervalUnit\";a:2:{i:0;N;i:1;s:1:\"d\";}s:4:\"type\";a:2:{i:0;N;i:1;s:22:\"email.validate.address\";}s:9:\"eventType\";a:2:{i:0;N;i:1;s:9:\"condition\";}s:6:\"tempId\";a:2:{i:0;N;i:1;s:43:\"new6e6edd47885d4dbf49e4352ab80065fbb1203dd9\";}}}s:43:\"newf96eb9f958f3b983802b3aae7dd73557cd6a068a\";a:2:{i:0;s:43:\"newf96eb9f958f3b983802b3aae7dd73557cd6a068a\";i:1;a:8:{s:4:\"name\";a:2:{i:0;N;i:1;s:16:\"Kontakt l??schen\";}s:11:\"triggerMode\";a:2:{i:0;N;i:1;s:9:\"immediate\";}s:15:\"triggerInterval\";a:2:{i:0;i:0;i:1;d:1;}s:19:\"triggerIntervalUnit\";a:2:{i:0;N;i:1;s:1:\"d\";}s:4:\"type\";a:2:{i:0;N;i:1;s:18:\"lead.deletecontact\";}s:9:\"eventType\";a:2:{i:0;N;i:1;s:6:\"action\";}s:6:\"tempId\";a:2:{i:0;N;i:1;s:43:\"newf96eb9f958f3b983802b3aae7dd73557cd6a068a\";}s:12:\"decisionPath\";a:2:{i:0;N;i:1;s:2:\"no\";}}}s:43:\"new838c67febb9f6b8b125b6c2badf80606d9dd7085\";a:2:{i:0;s:43:\"new838c67febb9f6b8b125b6c2badf80606d9dd7085\";i:1;a:11:{s:4:\"name\";a:2:{i:0;N;i:1;s:12:\"Email senden\";}s:11:\"triggerMode\";a:2:{i:0;N;i:1;s:9:\"immediate\";}s:15:\"triggerInterval\";a:2:{i:0;i:0;i:1;d:1;}s:19:\"triggerIntervalUnit\";a:2:{i:0;N;i:1;s:1:\"d\";}s:10:\"properties\";a:2:{i:0;a:0:{}i:1;a:21:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"732\";s:8:\"droppedY\";s:3:\"284\";}s:4:\"name\";s:12:\"Email senden\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"1\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_03c1ae6877f1de4aa4374f22183e76ca15042165\";s:6:\"_token\";s:43:\"A4_4_DMUZm4NicdRSfhaUxD-C8yy7uQg9THc5bHibQc\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:1:\"1\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}}s:4:\"type\";a:2:{i:0;N;i:1;s:10:\"email.send\";}s:9:\"eventType\";a:2:{i:0;N;i:1;s:6:\"action\";}s:6:\"tempId\";a:2:{i:0;N;i:1;s:43:\"new838c67febb9f6b8b125b6c2badf80606d9dd7085\";}s:7:\"channel\";a:2:{i:0;N;i:1;s:5:\"email\";}s:9:\"channelId\";a:2:{i:0;N;i:1;i:1;}s:12:\"decisionPath\";a:2:{i:0;N;i:1;s:3:\"yes\";}}}}}}','2022-06-14 15:22:42','77.239.52.157'),(34,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-06-15 07:23:49','77.239.52.157'),(35,1,'Alain Habegger','user','security',1,'login','a:1:{s:8:\"username\";s:5:\"admin\";}','2022-06-15 15:58:38','77.239.52.157');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `beefree_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beefree_theme` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `preview` longblob NOT NULL,
  `content` longblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `beefree_theme` WRITE;
/*!40000 ALTER TABLE `beefree_theme` DISABLE KEYS */;
INSERT INTO `beefree_theme` VALUES (1,'Test 1','Test',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}}</style></head><body \nstyle=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td></tr>\n</tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"58.333333333333336%\" \nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" \nstyle=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>',_binary '{\"page\":{\"body\":{\"container\":{\"style\":{\"background-color\":\"#d9dbdc\"}},\"content\":{\"computedStyle\":{\"align\":\"center\",\"linkColor\":\"#0068A5\",\"messageBackgroundColor\":\"#ffffff\",\"messageWidth\":\"650px\"},\"style\":{\"color\":\"#000000\",\"font-family\":\"Arial, Helvetica Neue, Helvetica, sans-serif\"}},\"type\":\"mailup-bee-page-proprerties\",\"webFonts\":[{\"family\":\"\'Roboto\', Tahoma, Verdana, Segoe, sans-serif\",\"fontFamily\":\"\'Roboto\', Tahoma, Verdana, Segoe, sans-serif\",\"fontName\":\"Roboto\",\"name\":\"Roboto\",\"url\":\"https://fonts.googleapis.com/css?family=Roboto\"}]},\"description\":\"Test template for BEE\",\"rows\":[{\"columns\":[{\"grid-columns\":12,\"modules\":[{\"descriptor\":{\"computedStyle\":{\"hideContentOnMobile\":false},\"style\":{\"padding-bottom\":\"0px\",\"padding-left\":\"10px\",\"padding-right\":\"10px\",\"padding-top\":\"10px\"},\"text\":{\"computedStyle\":{\"linkColor\":\"#0068A5\"},\"html\":\"<div class=\\\"txtTinyMce-wrapper\\\" style=\\\"font-size: 14px; line-height: 16px;\\\" data-mce-style=\\\"font-size: 14px; line-height: 16px;\\\"><p style=\\\"font-size: 14px; line-height: 16px; word-break: break-word; text-align: center;\\\" data-mce-style=\\\"font-size: 14px; line-height: 16px; word-break: break-word; text-align: center;\\\">{webview_text}</p></div>\",\"style\":{\"color\":\"#555555\",\"font-family\":\"inherit\",\"line-height\":\"120%\"}}},\"type\":\"mailup-bee-newsletter-modules-text\",\"uuid\":\"52482fa2-4b00-4e68-9a8f-42a05a1185b8\"}],\"style\":{\"background-color\":\"transparent\",\"border-bottom\":\"0px solid transparent\",\"border-left\":\"0px solid transparent\",\"border-right\":\"0px solid transparent\",\"border-top\":\"0px solid transparent\",\"padding-bottom\":\"5px\",\"padding-left\":\"0px\",\"padding-right\":\"0px\",\"padding-top\":\"5px\"},\"uuid\":\"eb252f90-0ec3-4348-b8e6-49cbd920a631\"}],\"container\":{\"style\":{\"background-color\":\"transparent\",\"background-image\":\"none\",\"background-position\":\"top left\",\"background-repeat\":\"no-repeat\"}},\"content\":{\"computedStyle\":{\"rowColStackOnMobile\":true,\"rowReverseColStackOnMobile\":false},\"style\":{\"background-color\":\"#ffffff\",\"background-image\":\"none\",\"background-position\":\"top left\",\"background-repeat\":\"no-repeat\",\"color\":\"#000000\",\"width\":\"650px\"}},\"type\":\"one-column-empty\",\"uuid\":\"07ca5fd0-dcb3-4470-979a-08484d1eaece\"},{\"columns\":[{\"grid-columns\":7,\"modules\":[{\"descriptor\":{\"computedStyle\":{\"hideContentOnMobile\":false},\"style\":{\"padding-bottom\":\"10px\",\"padding-left\":\"10px\",\"padding-right\":\"10px\",\"padding-top\":\"10px\"},\"text\":{\"computedStyle\":{\"linkColor\":\"#c6a55a\"},\"html\":\"<div class=\\\"txtTinyMce-wrapper\\\" style=\\\"font-size: 14px; line-height: 16px;\\\" data-mce-style=\\\"font-size: 14px; line-height: 16px;\\\"><p style=\\\"font-size: 14px; line-height: 16px; word-break: break-word;\\\" data-mce-style=\\\"font-size: 14px; line-height: 16px; word-break: break-word;\\\"><a href=\\\"https://kambly.com\\\" target=\\\"_blank\\\" style=\\\"text-decoration: underline;\\\" rel=\\\"noopener\\\">www.kambly.com</a></p></div>\",\"style\":{\"color\":\"#555555\",\"font-family\":\"inherit\",\"line-height\":\"120%\"}}},\"type\":\"mailup-bee-newsletter-modules-text\",\"uuid\":\"f33d516d-1e51-4aff-a089-bf2dfa504b32\"}],\"style\":{\"background-color\":\"transparent\",\"border-bottom\":\"0px solid transparent\",\"border-left\":\"0px solid transparent\",\"border-right\":\"0px solid transparent\",\"border-top\":\"0px solid transparent\",\"padding-bottom\":\"5px\",\"padding-left\":\"0px\",\"padding-right\":\"0px\",\"padding-top\":\"5px\"},\"uuid\":\"9198cbb9-a663-40c9-80ba-02db295ad10d\"},{\"grid-columns\":5,\"modules\":[{\"descriptor\":{\"computedStyle\":{\"class\":\"center autowidth\",\"hideContentOnMobile\":false,\"width\":\"180px\"},\"image\":{\"alt\":\"\",\"height\":\"86px\",\"href\":\"\",\"src\":\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\",\"width\":\"180px\"},\"style\":{\"padding-bottom\":\"0px\",\"padding-left\":\"0px\",\"padding-right\":\"0px\",\"padding-top\":\"0px\",\"width\":\"100%\"}},\"type\":\"mailup-bee-newsletter-modules-image\",\"uuid\":\"52f1c414-b2f5-44b0-9771-f659baa0dca8\"}],\"style\":{\"background-color\":\"transparent\",\"border-bottom\":\"0px solid transparent\",\"border-left\":\"0px solid transparent\",\"border-right\":\"0px solid transparent\",\"border-top\":\"0px solid transparent\",\"padding-bottom\":\"5px\",\"padding-left\":\"0px\",\"padding-right\":\"0px\",\"padding-top\":\"5px\"},\"uuid\":\"9727c8b1-8af7-414e-98d0-13b0acc8eadd\"}],\"container\":{\"style\":{\"background-color\":\"transparent\",\"background-image\":\"none\",\"background-position\":\"top left\",\"background-repeat\":\"no-repeat\"}},\"content\":{\"computedStyle\":{\"rowColStackOnMobile\":true,\"rowReverseColStackOnMobile\":false},\"style\":{\"background-color\":\"#ffffff\",\"background-image\":\"none\",\"background-position\":\"top left\",\"background-repeat\":\"no-repeat\",\"color\":\"#000000\",\"width\":\"650px\"}},\"type\":\"two-columns-empty\",\"uuid\":\"307941c5-3222-49fc-ad0f-5a058e33938d\"},{\"columns\":[{\"grid-columns\":12,\"modules\":[{\"descriptor\":{\"computedStyle\":{\"class\":\"center autowidth\",\"hideContentOnMobile\":false,\"width\":\"650px\"},\"image\":{\"alt\":\"\",\"height\":\"800px\",\"href\":\"\",\"src\":\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\",\"width\":\"1200px\"},\"style\":{\"padding-bottom\":\"0px\",\"padding-left\":\"0px\",\"padding-right\":\"0px\",\"padding-top\":\"0px\",\"width\":\"100%\"}},\"type\":\"mailup-bee-newsletter-modules-image\",\"uuid\":\"4446d8f0-ffe0-413e-a1e4-613f8217466a\"}],\"style\":{\"background-color\":\"transparent\",\"border-bottom\":\"0px solid transparent\",\"border-left\":\"0px solid transparent\",\"border-right\":\"0px solid transparent\",\"border-top\":\"0px solid transparent\",\"padding-bottom\":\"5px\",\"padding-left\":\"0px\",\"padding-right\":\"0px\",\"padding-top\":\"5px\"},\"uuid\":\"fd3e1c55-b1a5-4157-ab24-2c6633f0df20\"}],\"container\":{\"style\":{\"background-color\":\"transparent\",\"background-image\":\"none\",\"background-position\":\"top left\",\"background-repeat\":\"no-repeat\"}},\"content\":{\"computedStyle\":{\"rowColStackOnMobile\":true,\"rowReverseColStackOnMobile\":false},\"style\":{\"background-color\":\"#ffffff\",\"background-image\":\"none\",\"background-position\":\"top left\",\"background-repeat\":\"no-repeat\",\"color\":\"#000000\",\"width\":\"500px\"}},\"type\":\"one-column-empty\",\"uuid\":\"f35014fc-bc4b-48cb-be2d-0ffd94f1f88e\"},{\"columns\":[{\"grid-columns\":12,\"modules\":[{\"descriptor\":{\"computedStyle\":{\"hideContentOnMobile\":false},\"style\":{\"padding-bottom\":\"10px\",\"padding-left\":\"10px\",\"padding-right\":\"10px\",\"padding-top\":\"10px\"},\"text\":{\"computedStyle\":{\"linkColor\":\"#0068A5\"},\"html\":\"<div class=\\\"txtTinyMce-wrapper\\\" style=\\\"font-size: 14px; line-height: 16px; font-family: Tahoma, Verdana, Segoe, sans-serif;\\\" data-mce-style=\\\"font-size: 14px; line-height: 16px; font-family: Tahoma, Verdana, Segoe, sans-serif;\\\"><p style=\\\"font-size: 14px; line-height: 16px; word-break: break-word;\\\" data-mce-style=\\\"font-size: 14px; line-height: 16px; word-break: break-word;\\\">Lorem ipsum dolor sit amet</p></div>\",\"style\":{\"color\":\"#c6a55a\",\"font-family\":\"Tahoma, Verdana, Segoe, sans-serif\",\"line-height\":\"120%\"}}},\"type\":\"mailup-bee-newsletter-modules-text\",\"uuid\":\"c5e6af42-3351-40cc-a469-e4b15a9647e7\"}],\"style\":{\"background-color\":\"transparent\",\"border-bottom\":\"0px solid transparent\",\"border-left\":\"0px solid transparent\",\"border-right\":\"0px solid transparent\",\"border-top\":\"0px solid transparent\",\"padding-bottom\":\"5px\",\"padding-left\":\"0px\",\"padding-right\":\"0px\",\"padding-top\":\"5px\"},\"uuid\":\"50806757-0f1a-4b2f-8823-1d4445d7a4a6\"}],\"container\":{\"style\":{\"background-color\":\"transparent\",\"background-image\":\"none\",\"background-position\":\"top left\",\"background-repeat\":\"no-repeat\"}},\"content\":{\"computedStyle\":{\"rowColStackOnMobile\":true,\"rowReverseColStackOnMobile\":false},\"style\":{\"background-color\":\"#ffffff\",\"background-image\":\"none\",\"background-position\":\"top left\",\"background-repeat\":\"no-repeat\",\"color\":\"#000000\",\"width\":\"500px\"}},\"type\":\"one-column-empty\",\"uuid\":\"8283f7a3-6fcd-4a05-b8f6-811a40920ffe\"},{\"columns\":[{\"grid-columns\":12,\"modules\":[],\"style\":{\"background-color\":\"transparent\",\"border-bottom\":\"0px solid transparent\",\"border-left\":\"0px solid transparent\",\"border-right\":\"0px solid transparent\",\"border-top\":\"0px solid transparent\",\"padding-bottom\":\"5px\",\"padding-left\":\"0px\",\"padding-right\":\"0px\",\"padding-top\":\"5px\"},\"uuid\":\"8a18b4cb-02a5-4a73-8cdb-1455023d54a3\"}],\"container\":{\"style\":{\"background-color\":\"transparent\",\"background-image\":\"none\",\"background-position\":\"top left\",\"background-repeat\":\"no-repeat\"}},\"content\":{\"computedStyle\":{\"rowColStackOnMobile\":true,\"rowReverseColStackOnMobile\":false},\"style\":{\"background-color\":\"#ffffff\",\"background-image\":\"none\",\"background-position\":\"top left\",\"background-repeat\":\"no-repeat\",\"color\":\"#000000\",\"width\":\"500px\"}},\"type\":\"one-column-empty\",\"uuid\":\"9374adda-6fdd-4c95-9234-c5a79ae18661\"}],\"template\":{\"name\":\"template-base\",\"type\":\"basic\",\"version\":\"0.0.1\"},\"title\":\"Template Base\"},\"comments\":{}}');
/*!40000 ALTER TABLE `beefree_theme` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `beefree_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beefree_version` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `preview` longblob NOT NULL,
  `content` longblob NOT NULL,
  `json` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `object_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `beefree_version` WRITE;
/*!40000 ALTER TABLE `beefree_version` DISABLE KEYS */;
INSERT INTO `beefree_version` VALUES (1,'hello - 10/05/2022 14:18:39','email',_binary '<!DOCTYPE html><html xmlnsv=\"urn:schemas-microsoft-com:vml\" xmlnso=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" /><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!----><link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\" type=\"text/css\" /><!--<![endif]--><style>*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}}</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-top:10px;padding-right:10px;padding-left:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,\'Helvetica Neue\',Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-top:15px;padding-right:10px;padding-bottom:15px;padding-left:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,\'Helvetica Neue\',Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>',_binary '<!DOCTYPE html><html xmlnsv=\"urn:schemas-microsoft-com:vml\" xmlnso=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" /><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!----><link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\" type=\"text/css\" /><!--<![endif]--><style>*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}}</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-top:10px;padding-right:10px;padding-left:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,\'Helvetica Neue\',Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-top:15px;padding-right:10px;padding-bottom:15px;padding-left:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,\'Helvetica Neue\',Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','eyJwYWdlIjp7InRpdGxlIjoiVGVtcGxhdGUgQmFzZSIsImRlc2NyaXB0aW9uIjoiVGVzdCB0ZW1wbGF0ZSBmb3IgQkVFIiwidGVtcGxhdGUiOnsibmFtZSI6InRlbXBsYXRlLWJhc2UiLCJ0eXBlIjoiYmFzaWMiLCJ2ZXJzaW9uIjoiMC4wLjEifSwiYm9keSI6eyJ0eXBlIjoibWFpbHVwLWJlZS1wYWdlLXByb3ByZXJ0aWVzIiwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZDlkYmRjIn19LCJjb250ZW50Ijp7InN0eWxlIjp7ImZvbnQtZmFtaWx5IjoiQXJpYWwsICdIZWx2ZXRpY2EgTmV1ZScsIEhlbHZldGljYSwgc2Fucy1zZXJpZiIsImNvbG9yIjoiIzAwMDAwMCJ9LCJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiMwMDY4QTUiLCJtZXNzYWdlQmFja2dyb3VuZENvbG9yIjoiI2ZmZmZmZiIsIm1lc3NhZ2VXaWR0aCI6IjY1MHB4IiwiYWxpZ24iOiJjZW50ZXIifX0sIndlYkZvbnRzIjpbeyJmb250TmFtZSI6IlJvYm90byIsImZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwibmFtZSI6IlJvYm90byIsImZvbnRGYW1pbHkiOiInUm9ib3RvJywgVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZiIsInVybCI6Imh0dHBzOi8vZm9udHMuZ29vZ2xlYXBpcy5jb20vY3NzP2ZhbWlseT1Sb2JvdG8ifV19LCJyb3dzIjpbeyJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0In19LCJjb250ZW50Ijp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZmZmZmZmIiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJiYWNrZ3JvdW5kLXBvc2l0aW9uIjoidG9wIGxlZnQifSwiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9fSwiY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3sidHlwZSI6Im1haWx1cC1iZWUtbmV3c2xldHRlci1tb2R1bGVzLXRleHQiLCJkZXNjcmlwdG9yIjp7InRleHQiOnsiaHRtbCI6IjxkaXYgY2xhc3M9XCJ0eHRUaW55TWNlLXdyYXBwZXJcIiBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiPnt3ZWJ2aWV3X3RleHR9PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiIzU1NTU1NSIsImxpbmUtaGVpZ2h0IjoiMTIwJSIsImZvbnQtZmFtaWx5IjoiaW5oZXJpdCJ9LCJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiMwMDY4QTUifX0sInN0eWxlIjp7InBhZGRpbmctdG9wIjoiMTBweCIsInBhZGRpbmctcmlnaHQiOiIxMHB4IiwicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIxMHB4In0sImNvbXB1dGVkU3R5bGUiOnsiaGlkZUNvbnRlbnRPbk1vYmlsZSI6ZmFsc2V9fSwidXVpZCI6IjUyNDgyZmEyLTRiMDAtNGU2OC05YThmLTQyYTA1YTExODViOCJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwicGFkZGluZy10b3AiOiI1cHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50In0sInV1aWQiOiJlYjI1MmY5MC0wZWMzLTQzNDgtYjhlNi00OWNiZDkyMGE2MzEifV0sInV1aWQiOiIwN2NhNWZkMC1kY2IzLTQ0NzAtOTc5YS0wODQ4NGQxZWFlY2UifSx7ImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0In19LCJjb250ZW50Ijp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZmZmZmZmIiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJiYWNrZ3JvdW5kLXBvc2l0aW9uIjoidG9wIGxlZnQifSwiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9fSwiY29sdW1ucyI6W3sic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sIm1vZHVsZXMiOlt7InR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwiZGVzY3JpcHRvciI6eyJ0ZXh0Ijp7Imh0bWwiOiI8ZGl2IGNsYXNzPVwidHh0VGlueU1jZS13cmFwcGVyXCIgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDtcIj48cCBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQ7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiPjxhIGhyZWY9XCJodHRwczovL2thbWJseS5jb21cIiB0YXJnZXQ9XCJfYmxhbmtcIiBzdHlsZT1cInRleHQtZGVjb3JhdGlvbjogdW5kZXJsaW5lO1wiIHJlbD1cIm5vb3BlbmVyXCI+d3d3LmthbWJseS5jb208L2E+PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiIzU1NTU1NSIsImxpbmUtaGVpZ2h0IjoiMTIwJSIsImZvbnQtZmFtaWx5IjoiaW5oZXJpdCJ9LCJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiNjNmE1NWEifX0sInN0eWxlIjp7InBhZGRpbmctdG9wIjoiMTBweCIsInBhZGRpbmctcmlnaHQiOiIxMHB4IiwicGFkZGluZy1ib3R0b20iOiIxMHB4IiwicGFkZGluZy1sZWZ0IjoiMTBweCJ9LCJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfX0sInV1aWQiOiJmMzNkNTE2ZC0xZTUxLTRhZmYtYTA4OS1iZjJkZmE1MDRiMzIifV0sImdyaWQtY29sdW1ucyI6NywidXVpZCI6IjkxOThjYmI5LWE2NjMtNDBjOS04MGJhLTAyZGIyOTVhZDEwZCJ9LHsic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sIm1vZHVsZXMiOlt7InR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy1pbWFnZSIsImRlc2NyaXB0b3IiOnsiaW1hZ2UiOnsiYWx0IjoiIiwic3JjIjoiaHR0cHM6Ly9kMTVrMmQxMXI2dDZybC5jbG91ZGZyb250Lm5ldC9wdWJsaWMvdXNlcnMvSW50ZWdyYXRvcnMvY2UzMGJjMWUtYjc5YS00MDcxLWFjZjYtNzU2NTExOTMxZmM5L2JlZXByb3Rlc3QvS2FtYmx5X2RlLmpwZyIsImhyZWYiOiIiLCJ3aWR0aCI6IjE4MHB4IiwiaGVpZ2h0IjoiODZweCJ9LCJzdHlsZSI6eyJ3aWR0aCI6IjEwMCUiLCJwYWRkaW5nLXRvcCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLWJvdHRvbSI6IjBweCIsInBhZGRpbmctbGVmdCI6IjBweCJ9LCJjb21wdXRlZFN0eWxlIjp7ImNsYXNzIjoiY2VudGVyIGF1dG93aWR0aCIsIndpZHRoIjoiMTgwcHgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX19LCJ1dWlkIjoiNTJmMWM0MTQtYjJmNS00NGIwLTk3NzEtZjY1OWJhYTBkY2E4In1dLCJncmlkLWNvbHVtbnMiOjUsInV1aWQiOiI5NzI3YzhiMS04YWY3LTQxNGUtOThkMC0xM2IwYWNjOGVhZGQifV0sInR5cGUiOiJ0d28tY29sdW1ucy1lbXB0eSIsInV1aWQiOiIzMDc5NDFjNS0zMjIyLTQ5ZmMtYWQwZi01YTA1OGUzMzkzOGQifSx7ImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0In19LCJjb250ZW50Ijp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZmZmZmZmIiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJiYWNrZ3JvdW5kLXBvc2l0aW9uIjoidG9wIGxlZnQifSwiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9fSwiY29sdW1ucyI6W3sic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sIm1vZHVsZXMiOlt7InR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy1pbWFnZSIsImRlc2NyaXB0b3IiOnsiaW1hZ2UiOnsiYWx0IjoiIiwic3JjIjoiaHR0cHM6Ly9kMTVrMmQxMXI2dDZybC5jbG91ZGZyb250Lm5ldC9wdWJsaWMvdXNlcnMvSW50ZWdyYXRvcnMvY2UzMGJjMWUtYjc5YS00MDcxLWFjZjYtNzU2NTExOTMxZmM5L2JlZXByb3Rlc3QvQm94LmpwZyIsImhyZWYiOiIiLCJ3aWR0aCI6IjEyMDBweCIsImhlaWdodCI6IjgwMHB4In0sInN0eWxlIjp7IndpZHRoIjoiMTAwJSIsInBhZGRpbmctdG9wIjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4In0sImNvbXB1dGVkU3R5bGUiOnsiY2xhc3MiOiJjZW50ZXIgYXV0b3dpZHRoIiwid2lkdGgiOiI2NTBweCIsImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfX0sInV1aWQiOiI0NDQ2ZDhmMC1mZmUwLTQxM2UtYTFlNC02MTNmODIxNzQ2NmEifV0sImdyaWQtY29sdW1ucyI6MTIsInV1aWQiOiJmZDNlMWM1NS1iMWE1LTQxNTctYWIyNC0yYzY2MzNmMGRmMjAifV0sInR5cGUiOiJvbmUtY29sdW1uLWVtcHR5IiwidXVpZCI6ImYzNTAxNGZjLWJjNGItNDhjYi1iZTJkLTBmZmQ5NGYxZjg4ZSJ9LHsiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJiYWNrZ3JvdW5kLXBvc2l0aW9uIjoidG9wIGxlZnQifX0sImNvbnRlbnQiOnsic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4IiwiYmFja2dyb3VuZC1pbWFnZSI6Im5vbmUiLCJiYWNrZ3JvdW5kLXJlcGVhdCI6Im5vLXJlcGVhdCIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCJ9LCJjb21wdXRlZFN0eWxlIjp7InJvd0NvbFN0YWNrT25Nb2JpbGUiOnRydWUsInJvd1JldmVyc2VDb2xTdGFja09uTW9iaWxlIjpmYWxzZX19LCJjb2x1bW5zIjpbeyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwibW9kdWxlcyI6W3sidHlwZSI6Im1haWx1cC1iZWUtbmV3c2xldHRlci1tb2R1bGVzLXRleHQiLCJkZXNjcmlwdG9yIjp7InRleHQiOnsiaHRtbCI6IjxkaXYgY2xhc3M9XCJ0eHRUaW55TWNlLXdyYXBwZXJcIiBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IGZvbnQtZmFtaWx5OiBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgZm9udC1mYW1pbHk6IFRhaG9tYSwgVmVyZGFuYSwgU2Vnb2UsIHNhbnMtc2VyaWY7XCI+PHAgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDtcIj5Mb3JlbSBpcHN1bSBkb2xvciBzaXQgYW1ldDwvcD48L2Rpdj4iLCJzdHlsZSI6eyJjb2xvciI6IiNjNmE1NWEiLCJsaW5lLWhlaWdodCI6IjEyMCUiLCJmb250LWZhbWlseSI6IlRhaG9tYSwgVmVyZGFuYSwgU2Vnb2UsIHNhbnMtc2VyaWYifSwiY29tcHV0ZWRTdHlsZSI6eyJsaW5rQ29sb3IiOiIjMDA2OEE1In19LCJzdHlsZSI6eyJwYWRkaW5nLXRvcCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgifSwiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX19LCJ1dWlkIjoiYzVlNmFmNDItMzM1MS00MGNjLWE0NjktZTRiMTVhOTY0N2U3In1dLCJncmlkLWNvbHVtbnMiOjEyLCJ1dWlkIjoiNTA4MDY3NTctMGYxYS00YjJmLTg4MjMtMWQ0NDQ1ZDdhNGE2In1dLCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiI4MjgzZjdhMy02ZmNkLTRhMDUtYjhmNi04MTFhNDA5MjBmZmUifSx7ImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0In19LCJjb250ZW50Ijp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZmZmZmZmIiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJiYWNrZ3JvdW5kLXBvc2l0aW9uIjoidG9wIGxlZnQifSwiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9fSwiY29sdW1ucyI6W3sic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sIm1vZHVsZXMiOltdLCJncmlkLWNvbHVtbnMiOjEyLCJ1dWlkIjoiOGExOGI0Y2ItMDJhNS00YTczLThjZGItMTQ1NTAyM2Q1NGEzIn1dLCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiI5Mzc0YWRkYS02ZmRkLTRjOTUtOTIzNC1jNWE3OWFlMTg2NjEifV19LCJjb21tZW50cyI6e319',1),(2,'hello - 10/05/2022 14:29:24','email',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}}</style></head><body \r\nstyle=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" \r\nwidth=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div \r\nclass=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}}</style></head><body \r\nstyle=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" \r\nwidth=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div \r\nclass=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','eyJwYWdlIjp7ImJvZHkiOnsiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZDlkYmRjIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsiYWxpZ24iOiJjZW50ZXIiLCJsaW5rQ29sb3IiOiIjMDA2OEE1IiwibWVzc2FnZUJhY2tncm91bmRDb2xvciI6IiNmZmZmZmYiLCJtZXNzYWdlV2lkdGgiOiI2NTBweCJ9LCJzdHlsZSI6eyJjb2xvciI6IiMwMDAwMDAiLCJmb250LWZhbWlseSI6IkFyaWFsLCBIZWx2ZXRpY2EgTmV1ZSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1wYWdlLXByb3ByZXJ0aWVzIiwid2ViRm9udHMiOlt7ImZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udEZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udE5hbWUiOiJSb2JvdG8iLCJuYW1lIjoiUm9ib3RvIiwidXJsIjoiaHR0cHM6Ly9mb250cy5nb29nbGVhcGlzLmNvbS9jc3M/ZmFtaWx5PVJvYm90byJ9XX0sImRlc2NyaXB0aW9uIjoiVGVzdCB0ZW1wbGF0ZSBmb3IgQkVFIiwicm93cyI6W3siY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIxMHB4IiwicGFkZGluZy1yaWdodCI6IjEwcHgiLCJwYWRkaW5nLXRvcCI6IjEwcHgifSwidGV4dCI6eyJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiNjNmE1NWEifSwiaHRtbCI6IjxkaXYgY2xhc3M9XCJ0eHRUaW55TWNlLXdyYXBwZXJcIiBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiPnt3ZWJ2aWV3X3RleHR9PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiaW5oZXJpdCIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6IjUyNDgyZmEyLTRiMDAtNGU2OC05YThmLTQyYTA1YTExODViOCJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiJlYjI1MmY5MC0wZWMzLTQzNDgtYjhlNi00OWNiZDkyMGE2MzEifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiMDdjYTVmZDAtZGNiMy00NDcwLTk3OWEtMDg0ODRkMWVhZWNlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjcsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCI+PHAgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIj48YSBocmVmPVwiaHR0cHM6Ly9rYW1ibHkuY29tXCIgdGFyZ2V0PVwiX2JsYW5rXCIgc3R5bGU9XCJ0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTtcIiByZWw9XCJub29wZW5lclwiPnd3dy5rYW1ibHkuY29tPC9hPjwvcD48L2Rpdj4iLCJzdHlsZSI6eyJjb2xvciI6IiM1NTU1NTUiLCJmb250LWZhbWlseSI6ImluaGVyaXQiLCJsaW5lLWhlaWdodCI6IjEyMCUifX19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtdGV4dCIsInV1aWQiOiJmMzNkNTE2ZC0xZTUxLTRhZmYtYTA4OS1iZjJkZmE1MDRiMzIifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiOTE5OGNiYjktYTY2My00MGM5LTgwYmEtMDJkYjI5NWFkMTBkIn0seyJncmlkLWNvbHVtbnMiOjUsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiIxODBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJoZWlnaHQiOiI4NnB4IiwiaHJlZiI6IiIsInNyYyI6Imh0dHBzOi8vZDE1azJkMTFyNnQ2cmwuY2xvdWRmcm9udC5uZXQvcHVibGljL3VzZXJzL0ludGVncmF0b3JzL2NlMzBiYzFlLWI3OWEtNDA3MS1hY2Y2LTc1NjUxMTkzMWZjOS9iZWVwcm90ZXN0L0thbWJseV9kZS5qcGciLCJ3aWR0aCI6IjE4MHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNTJmMWM0MTQtYjJmNS00NGIwLTk3NzEtZjY1OWJhYTBkY2E4In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6Ijk3MjdjOGIxLThhZjctNDE0ZS05OGQwLTEzYjBhY2M4ZWFkZCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjY1MHB4In19LCJ0eXBlIjoidHdvLWNvbHVtbnMtZW1wdHkiLCJ1dWlkIjoiMzA3OTQxYzUtMzIyMi00OWZjLWFkMGYtNWEwNThlMzM5MzhkIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbeyJkZXNjcmlwdG9yIjp7ImNvbXB1dGVkU3R5bGUiOnsiY2xhc3MiOiJjZW50ZXIgYXV0b3dpZHRoIiwiaGlkZUNvbnRlbnRPbk1vYmlsZSI6ZmFsc2UsIndpZHRoIjoiNjUwcHgifSwiaW1hZ2UiOnsiYWx0IjoiIiwiaGVpZ2h0IjoiODAwcHgiLCJocmVmIjoiIiwic3JjIjoiaHR0cHM6Ly9kMTVrMmQxMXI2dDZybC5jbG91ZGZyb250Lm5ldC9wdWJsaWMvdXNlcnMvSW50ZWdyYXRvcnMvY2UzMGJjMWUtYjc5YS00MDcxLWFjZjYtNzU2NTExOTMxZmM5L2JlZXByb3Rlc3QvQm94LmpwZyIsIndpZHRoIjoiMTIwMHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNDQ0NmQ4ZjAtZmZlMC00MTNlLWExZTQtNjEzZjgyMTc0NjZhIn1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6ImZkM2UxYzU1LWIxYTUtNDE1Ny1hYjI0LTJjNjYzM2YwZGYyMCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiJmMzUwMTRmYy1iYzRiLTQ4Y2ItYmUyZC0wZmZkOTRmMWY4OGUifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiIzAwNjhBNSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgZm9udC1mYW1pbHk6IFRhaG9tYSwgVmVyZGFuYSwgU2Vnb2UsIHNhbnMtc2VyaWY7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBmb250LWZhbWlseTogVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZjtcIj48cCBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQ7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiPkxvcmVtIGlwc3VtIGRvbG9yIHNpdCBhbWV0PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZiIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6ImM1ZTZhZjQyLTMzNTEtNDBjYy1hNDY5LWU0YjE1YTk2NDdlNyJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI1MDgwNjc1Ny0wZjFhLTRiMmYtODgyMy0xZDQ0NDVkN2E0YTYifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiODI4M2Y3YTMtNmZjZC00YTA1LWI4ZjYtODExYTQwOTIwZmZlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbXSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI4YTE4YjRjYi0wMmE1LTRhNzMtOGNkYi0xNDU1MDIzZDU0YTMifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiOTM3NGFkZGEtNmZkZC00Yzk1LTkyMzQtYzVhNzlhZTE4NjYxIn1dLCJ0ZW1wbGF0ZSI6eyJuYW1lIjoidGVtcGxhdGUtYmFzZSIsInR5cGUiOiJiYXNpYyIsInZlcnNpb24iOiIwLjAuMSJ9LCJ0aXRsZSI6IlRlbXBsYXRlIEJhc2UifSwiY29tbWVudHMiOnt9fQ==',1),(3,'hello - 10/05/2022 14:30:16','email',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}}</style></head><body \r\nstyle=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" \r\nwidth=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div \r\nclass=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}}</style></head><body \r\nstyle=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" \r\nwidth=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div \r\nclass=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','eyJwYWdlIjp7ImJvZHkiOnsiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZDlkYmRjIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsiYWxpZ24iOiJjZW50ZXIiLCJsaW5rQ29sb3IiOiIjMDA2OEE1IiwibWVzc2FnZUJhY2tncm91bmRDb2xvciI6IiNmZmZmZmYiLCJtZXNzYWdlV2lkdGgiOiI2NTBweCJ9LCJzdHlsZSI6eyJjb2xvciI6IiMwMDAwMDAiLCJmb250LWZhbWlseSI6IkFyaWFsLCBIZWx2ZXRpY2EgTmV1ZSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1wYWdlLXByb3ByZXJ0aWVzIiwid2ViRm9udHMiOlt7ImZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udEZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udE5hbWUiOiJSb2JvdG8iLCJuYW1lIjoiUm9ib3RvIiwidXJsIjoiaHR0cHM6Ly9mb250cy5nb29nbGVhcGlzLmNvbS9jc3M/ZmFtaWx5PVJvYm90byJ9XX0sImRlc2NyaXB0aW9uIjoiVGVzdCB0ZW1wbGF0ZSBmb3IgQkVFIiwicm93cyI6W3siY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIxMHB4IiwicGFkZGluZy1yaWdodCI6IjEwcHgiLCJwYWRkaW5nLXRvcCI6IjEwcHgifSwidGV4dCI6eyJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiNjNmE1NWEifSwiaHRtbCI6IjxkaXYgY2xhc3M9XCJ0eHRUaW55TWNlLXdyYXBwZXJcIiBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiPnt3ZWJ2aWV3X3RleHR9PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiaW5oZXJpdCIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6IjUyNDgyZmEyLTRiMDAtNGU2OC05YThmLTQyYTA1YTExODViOCJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiJlYjI1MmY5MC0wZWMzLTQzNDgtYjhlNi00OWNiZDkyMGE2MzEifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiMDdjYTVmZDAtZGNiMy00NDcwLTk3OWEtMDg0ODRkMWVhZWNlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjcsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCI+PHAgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIj48YSBocmVmPVwiaHR0cHM6Ly9rYW1ibHkuY29tXCIgdGFyZ2V0PVwiX2JsYW5rXCIgc3R5bGU9XCJ0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTtcIiByZWw9XCJub29wZW5lclwiPnd3dy5rYW1ibHkuY29tPC9hPjwvcD48L2Rpdj4iLCJzdHlsZSI6eyJjb2xvciI6IiM1NTU1NTUiLCJmb250LWZhbWlseSI6ImluaGVyaXQiLCJsaW5lLWhlaWdodCI6IjEyMCUifX19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtdGV4dCIsInV1aWQiOiJmMzNkNTE2ZC0xZTUxLTRhZmYtYTA4OS1iZjJkZmE1MDRiMzIifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiOTE5OGNiYjktYTY2My00MGM5LTgwYmEtMDJkYjI5NWFkMTBkIn0seyJncmlkLWNvbHVtbnMiOjUsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiIxODBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJoZWlnaHQiOiI4NnB4IiwiaHJlZiI6IiIsInNyYyI6Imh0dHBzOi8vZDE1azJkMTFyNnQ2cmwuY2xvdWRmcm9udC5uZXQvcHVibGljL3VzZXJzL0ludGVncmF0b3JzL2NlMzBiYzFlLWI3OWEtNDA3MS1hY2Y2LTc1NjUxMTkzMWZjOS9iZWVwcm90ZXN0L0thbWJseV9kZS5qcGciLCJ3aWR0aCI6IjE4MHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNTJmMWM0MTQtYjJmNS00NGIwLTk3NzEtZjY1OWJhYTBkY2E4In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6Ijk3MjdjOGIxLThhZjctNDE0ZS05OGQwLTEzYjBhY2M4ZWFkZCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjY1MHB4In19LCJ0eXBlIjoidHdvLWNvbHVtbnMtZW1wdHkiLCJ1dWlkIjoiMzA3OTQxYzUtMzIyMi00OWZjLWFkMGYtNWEwNThlMzM5MzhkIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbeyJkZXNjcmlwdG9yIjp7ImNvbXB1dGVkU3R5bGUiOnsiY2xhc3MiOiJjZW50ZXIgYXV0b3dpZHRoIiwiaGlkZUNvbnRlbnRPbk1vYmlsZSI6ZmFsc2UsIndpZHRoIjoiNjUwcHgifSwiaW1hZ2UiOnsiYWx0IjoiIiwiaGVpZ2h0IjoiODAwcHgiLCJocmVmIjoiIiwic3JjIjoiaHR0cHM6Ly9kMTVrMmQxMXI2dDZybC5jbG91ZGZyb250Lm5ldC9wdWJsaWMvdXNlcnMvSW50ZWdyYXRvcnMvY2UzMGJjMWUtYjc5YS00MDcxLWFjZjYtNzU2NTExOTMxZmM5L2JlZXByb3Rlc3QvQm94LmpwZyIsIndpZHRoIjoiMTIwMHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNDQ0NmQ4ZjAtZmZlMC00MTNlLWExZTQtNjEzZjgyMTc0NjZhIn1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6ImZkM2UxYzU1LWIxYTUtNDE1Ny1hYjI0LTJjNjYzM2YwZGYyMCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiJmMzUwMTRmYy1iYzRiLTQ4Y2ItYmUyZC0wZmZkOTRmMWY4OGUifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiIzAwNjhBNSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgZm9udC1mYW1pbHk6IFRhaG9tYSwgVmVyZGFuYSwgU2Vnb2UsIHNhbnMtc2VyaWY7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBmb250LWZhbWlseTogVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZjtcIj48cCBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQ7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiPkxvcmVtIGlwc3VtIGRvbG9yIHNpdCBhbWV0PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZiIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6ImM1ZTZhZjQyLTMzNTEtNDBjYy1hNDY5LWU0YjE1YTk2NDdlNyJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI1MDgwNjc1Ny0wZjFhLTRiMmYtODgyMy0xZDQ0NDVkN2E0YTYifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiODI4M2Y3YTMtNmZjZC00YTA1LWI4ZjYtODExYTQwOTIwZmZlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbXSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI4YTE4YjRjYi0wMmE1LTRhNzMtOGNkYi0xNDU1MDIzZDU0YTMifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiOTM3NGFkZGEtNmZkZC00Yzk1LTkyMzQtYzVhNzlhZTE4NjYxIn1dLCJ0ZW1wbGF0ZSI6eyJuYW1lIjoidGVtcGxhdGUtYmFzZSIsInR5cGUiOiJiYXNpYyIsInZlcnNpb24iOiIwLjAuMSJ9LCJ0aXRsZSI6IlRlbXBsYXRlIEJhc2UifSwiY29tbWVudHMiOnt9fQ==',1),(4,'hello - 10/05/2022 14:31:46','email',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}}</style></head><body \r\nstyle=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" \r\nwidth=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div \r\nclass=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}}</style></head><body \r\nstyle=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" \r\nwidth=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div \r\nclass=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','eyJwYWdlIjp7ImJvZHkiOnsiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZDlkYmRjIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsiYWxpZ24iOiJjZW50ZXIiLCJsaW5rQ29sb3IiOiIjYzZhNTVhIiwibWVzc2FnZUJhY2tncm91bmRDb2xvciI6IiNmZmZmZmYiLCJtZXNzYWdlV2lkdGgiOiI2NTBweCJ9LCJzdHlsZSI6eyJjb2xvciI6IiMwMDAwMDAiLCJmb250LWZhbWlseSI6IkFyaWFsLCBIZWx2ZXRpY2EgTmV1ZSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1wYWdlLXByb3ByZXJ0aWVzIiwid2ViRm9udHMiOlt7ImZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udEZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udE5hbWUiOiJSb2JvdG8iLCJuYW1lIjoiUm9ib3RvIiwidXJsIjoiaHR0cHM6Ly9mb250cy5nb29nbGVhcGlzLmNvbS9jc3M/ZmFtaWx5PVJvYm90byJ9XX0sImRlc2NyaXB0aW9uIjoiVGVzdCB0ZW1wbGF0ZSBmb3IgQkVFIiwicm93cyI6W3siY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIxMHB4IiwicGFkZGluZy1yaWdodCI6IjEwcHgiLCJwYWRkaW5nLXRvcCI6IjEwcHgifSwidGV4dCI6eyJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiNjNmE1NWEifSwiaHRtbCI6IjxkaXYgY2xhc3M9XCJ0eHRUaW55TWNlLXdyYXBwZXJcIiBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiPnt3ZWJ2aWV3X3RleHR9PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiaW5oZXJpdCIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6IjUyNDgyZmEyLTRiMDAtNGU2OC05YThmLTQyYTA1YTExODViOCJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiJlYjI1MmY5MC0wZWMzLTQzNDgtYjhlNi00OWNiZDkyMGE2MzEifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiMDdjYTVmZDAtZGNiMy00NDcwLTk3OWEtMDg0ODRkMWVhZWNlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjcsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCI+PHAgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIj48YSBocmVmPVwiaHR0cHM6Ly9rYW1ibHkuY29tXCIgdGFyZ2V0PVwiX2JsYW5rXCIgc3R5bGU9XCJ0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTtcIiByZWw9XCJub29wZW5lclwiPnd3dy5rYW1ibHkuY29tPC9hPjwvcD48L2Rpdj4iLCJzdHlsZSI6eyJjb2xvciI6IiM1NTU1NTUiLCJmb250LWZhbWlseSI6ImluaGVyaXQiLCJsaW5lLWhlaWdodCI6IjEyMCUifX19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtdGV4dCIsInV1aWQiOiJmMzNkNTE2ZC0xZTUxLTRhZmYtYTA4OS1iZjJkZmE1MDRiMzIifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiOTE5OGNiYjktYTY2My00MGM5LTgwYmEtMDJkYjI5NWFkMTBkIn0seyJncmlkLWNvbHVtbnMiOjUsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiIxODBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJoZWlnaHQiOiI4NnB4IiwiaHJlZiI6IiIsInNyYyI6Imh0dHBzOi8vZDE1azJkMTFyNnQ2cmwuY2xvdWRmcm9udC5uZXQvcHVibGljL3VzZXJzL0ludGVncmF0b3JzL2NlMzBiYzFlLWI3OWEtNDA3MS1hY2Y2LTc1NjUxMTkzMWZjOS9iZWVwcm90ZXN0L0thbWJseV9kZS5qcGciLCJ3aWR0aCI6IjE4MHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNTJmMWM0MTQtYjJmNS00NGIwLTk3NzEtZjY1OWJhYTBkY2E4In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6Ijk3MjdjOGIxLThhZjctNDE0ZS05OGQwLTEzYjBhY2M4ZWFkZCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjY1MHB4In19LCJ0eXBlIjoidHdvLWNvbHVtbnMtZW1wdHkiLCJ1dWlkIjoiMzA3OTQxYzUtMzIyMi00OWZjLWFkMGYtNWEwNThlMzM5MzhkIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbeyJkZXNjcmlwdG9yIjp7ImNvbXB1dGVkU3R5bGUiOnsiY2xhc3MiOiJjZW50ZXIgYXV0b3dpZHRoIiwiaGlkZUNvbnRlbnRPbk1vYmlsZSI6ZmFsc2UsIndpZHRoIjoiNjUwcHgifSwiaW1hZ2UiOnsiYWx0IjoiIiwiaGVpZ2h0IjoiODAwcHgiLCJocmVmIjoiIiwic3JjIjoiaHR0cHM6Ly9kMTVrMmQxMXI2dDZybC5jbG91ZGZyb250Lm5ldC9wdWJsaWMvdXNlcnMvSW50ZWdyYXRvcnMvY2UzMGJjMWUtYjc5YS00MDcxLWFjZjYtNzU2NTExOTMxZmM5L2JlZXByb3Rlc3QvQm94LmpwZyIsIndpZHRoIjoiMTIwMHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNDQ0NmQ4ZjAtZmZlMC00MTNlLWExZTQtNjEzZjgyMTc0NjZhIn1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6ImZkM2UxYzU1LWIxYTUtNDE1Ny1hYjI0LTJjNjYzM2YwZGYyMCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiJmMzUwMTRmYy1iYzRiLTQ4Y2ItYmUyZC0wZmZkOTRmMWY4OGUifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgZm9udC1mYW1pbHk6IFRhaG9tYSwgVmVyZGFuYSwgU2Vnb2UsIHNhbnMtc2VyaWY7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBmb250LWZhbWlseTogVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZjtcIj48cCBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQ7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiPkxvcmVtIGlwc3VtIGRvbG9yIHNpdCBhbWV0PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZiIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6ImM1ZTZhZjQyLTMzNTEtNDBjYy1hNDY5LWU0YjE1YTk2NDdlNyJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI1MDgwNjc1Ny0wZjFhLTRiMmYtODgyMy0xZDQ0NDVkN2E0YTYifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiODI4M2Y3YTMtNmZjZC00YTA1LWI4ZjYtODExYTQwOTIwZmZlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbXSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI4YTE4YjRjYi0wMmE1LTRhNzMtOGNkYi0xNDU1MDIzZDU0YTMifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiOTM3NGFkZGEtNmZkZC00Yzk1LTkyMzQtYzVhNzlhZTE4NjYxIn1dLCJ0ZW1wbGF0ZSI6eyJuYW1lIjoidGVtcGxhdGUtYmFzZSIsInR5cGUiOiJiYXNpYyIsInZlcnNpb24iOiIwLjAuMSJ9LCJ0aXRsZSI6IlRlbXBsYXRlIEJhc2UifSwiY29tbWVudHMiOnt9fQ==',1),(5,'hello - 12/06/2022 07:22:19','email',_binary '<!DOCTYPE html><html xmlnsv=\"urn:schemas-microsoft-com:vml\" xmlnso=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" /><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!----><link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\" type=\"text/css\" /><!--<![endif]--><style>*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}}</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>',_binary '<!DOCTYPE html><html xmlnsv=\"urn:schemas-microsoft-com:vml\" xmlnso=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" /><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!----><link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\" type=\"text/css\" /><!--<![endif]--><style>*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}}</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','eyJwYWdlIjp7ImJvZHkiOnsiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZDlkYmRjIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsiYWxpZ24iOiJjZW50ZXIiLCJsaW5rQ29sb3IiOiIjYzZhNTVhIiwibWVzc2FnZUJhY2tncm91bmRDb2xvciI6IiNmZmZmZmYiLCJtZXNzYWdlV2lkdGgiOiI2NTBweCJ9LCJzdHlsZSI6eyJjb2xvciI6IiMwMDAwMDAiLCJmb250LWZhbWlseSI6IkFyaWFsLCBIZWx2ZXRpY2EgTmV1ZSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1wYWdlLXByb3ByZXJ0aWVzIiwid2ViRm9udHMiOlt7ImZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udEZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udE5hbWUiOiJSb2JvdG8iLCJuYW1lIjoiUm9ib3RvIiwidXJsIjoiaHR0cHM6Ly9mb250cy5nb29nbGVhcGlzLmNvbS9jc3M/ZmFtaWx5PVJvYm90byJ9XX0sImRlc2NyaXB0aW9uIjoiVGVzdCB0ZW1wbGF0ZSBmb3IgQkVFIiwicm93cyI6W3siY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIxMHB4IiwicGFkZGluZy1yaWdodCI6IjEwcHgiLCJwYWRkaW5nLXRvcCI6IjEwcHgifSwidGV4dCI6eyJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiNjNmE1NWEifSwiaHRtbCI6IjxkaXYgY2xhc3M9XCJ0eHRUaW55TWNlLXdyYXBwZXJcIiBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiPnt3ZWJ2aWV3X3RleHR9PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiaW5oZXJpdCIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6IjUyNDgyZmEyLTRiMDAtNGU2OC05YThmLTQyYTA1YTExODViOCJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiJlYjI1MmY5MC0wZWMzLTQzNDgtYjhlNi00OWNiZDkyMGE2MzEifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiMDdjYTVmZDAtZGNiMy00NDcwLTk3OWEtMDg0ODRkMWVhZWNlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjcsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCI+PHAgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIj48YSBocmVmPVwiaHR0cHM6Ly9rYW1ibHkuY29tXCIgdGFyZ2V0PVwiX2JsYW5rXCIgc3R5bGU9XCJ0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTtcIiByZWw9XCJub29wZW5lclwiPnd3dy5rYW1ibHkuY29tPC9hPjwvcD48L2Rpdj4iLCJzdHlsZSI6eyJjb2xvciI6IiM1NTU1NTUiLCJmb250LWZhbWlseSI6ImluaGVyaXQiLCJsaW5lLWhlaWdodCI6IjEyMCUifX19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtdGV4dCIsInV1aWQiOiJmMzNkNTE2ZC0xZTUxLTRhZmYtYTA4OS1iZjJkZmE1MDRiMzIifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiOTE5OGNiYjktYTY2My00MGM5LTgwYmEtMDJkYjI5NWFkMTBkIn0seyJncmlkLWNvbHVtbnMiOjUsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiIxODBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJoZWlnaHQiOiI4NnB4IiwiaHJlZiI6IiIsInNyYyI6Imh0dHBzOi8vZDE1azJkMTFyNnQ2cmwuY2xvdWRmcm9udC5uZXQvcHVibGljL3VzZXJzL0ludGVncmF0b3JzL2NlMzBiYzFlLWI3OWEtNDA3MS1hY2Y2LTc1NjUxMTkzMWZjOS9iZWVwcm90ZXN0L0thbWJseV9kZS5qcGciLCJ3aWR0aCI6IjE4MHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNTJmMWM0MTQtYjJmNS00NGIwLTk3NzEtZjY1OWJhYTBkY2E4In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6Ijk3MjdjOGIxLThhZjctNDE0ZS05OGQwLTEzYjBhY2M4ZWFkZCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjY1MHB4In19LCJ0eXBlIjoidHdvLWNvbHVtbnMtZW1wdHkiLCJ1dWlkIjoiMzA3OTQxYzUtMzIyMi00OWZjLWFkMGYtNWEwNThlMzM5MzhkIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbeyJkZXNjcmlwdG9yIjp7ImNvbXB1dGVkU3R5bGUiOnsiY2xhc3MiOiJjZW50ZXIgYXV0b3dpZHRoIiwiaGlkZUNvbnRlbnRPbk1vYmlsZSI6ZmFsc2UsIndpZHRoIjoiNjUwcHgifSwiaW1hZ2UiOnsiYWx0IjoiIiwiaGVpZ2h0IjoiODAwcHgiLCJocmVmIjoiIiwic3JjIjoiaHR0cHM6Ly9kMTVrMmQxMXI2dDZybC5jbG91ZGZyb250Lm5ldC9wdWJsaWMvdXNlcnMvSW50ZWdyYXRvcnMvY2UzMGJjMWUtYjc5YS00MDcxLWFjZjYtNzU2NTExOTMxZmM5L2JlZXByb3Rlc3QvQm94LmpwZyIsIndpZHRoIjoiMTIwMHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNDQ0NmQ4ZjAtZmZlMC00MTNlLWExZTQtNjEzZjgyMTc0NjZhIn1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6ImZkM2UxYzU1LWIxYTUtNDE1Ny1hYjI0LTJjNjYzM2YwZGYyMCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiJmMzUwMTRmYy1iYzRiLTQ4Y2ItYmUyZC0wZmZkOTRmMWY4OGUifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgZm9udC1mYW1pbHk6IFRhaG9tYSwgVmVyZGFuYSwgU2Vnb2UsIHNhbnMtc2VyaWY7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBmb250LWZhbWlseTogVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZjtcIj48cCBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQ7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiPkxvcmVtIGlwc3VtIGRvbG9yIHNpdCBhbWV0PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZiIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6ImM1ZTZhZjQyLTMzNTEtNDBjYy1hNDY5LWU0YjE1YTk2NDdlNyJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI1MDgwNjc1Ny0wZjFhLTRiMmYtODgyMy0xZDQ0NDVkN2E0YTYifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiODI4M2Y3YTMtNmZjZC00YTA1LWI4ZjYtODExYTQwOTIwZmZlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbXSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI4YTE4YjRjYi0wMmE1LTRhNzMtOGNkYi0xNDU1MDIzZDU0YTMifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiOTM3NGFkZGEtNmZkZC00Yzk1LTkyMzQtYzVhNzlhZTE4NjYxIn1dLCJ0ZW1wbGF0ZSI6eyJuYW1lIjoidGVtcGxhdGUtYmFzZSIsInR5cGUiOiJiYXNpYyIsInZlcnNpb24iOiIwLjAuMSJ9LCJ0aXRsZSI6IlRlbXBsYXRlIEJhc2UifSwiY29tbWVudHMiOnt9fQ==',1),(6,'hello - 12/06/2022 07:22:27','email',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" \r\nwidth=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div \r\nclass=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" \r\nwidth=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div \r\nclass=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','eyJwYWdlIjp7ImJvZHkiOnsiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZDlkYmRjIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsiYWxpZ24iOiJjZW50ZXIiLCJsaW5rQ29sb3IiOiIjYzZhNTVhIiwibWVzc2FnZUJhY2tncm91bmRDb2xvciI6IiNmZmZmZmYiLCJtZXNzYWdlV2lkdGgiOiI2NTBweCJ9LCJzdHlsZSI6eyJjb2xvciI6IiMwMDAwMDAiLCJmb250LWZhbWlseSI6IkFyaWFsLCBIZWx2ZXRpY2EgTmV1ZSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1wYWdlLXByb3ByZXJ0aWVzIiwid2ViRm9udHMiOlt7ImZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udEZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udE5hbWUiOiJSb2JvdG8iLCJuYW1lIjoiUm9ib3RvIiwidXJsIjoiaHR0cHM6Ly9mb250cy5nb29nbGVhcGlzLmNvbS9jc3M/ZmFtaWx5PVJvYm90byJ9XX0sImRlc2NyaXB0aW9uIjoiVGVzdCB0ZW1wbGF0ZSBmb3IgQkVFIiwicm93cyI6W3siY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIxMHB4IiwicGFkZGluZy1yaWdodCI6IjEwcHgiLCJwYWRkaW5nLXRvcCI6IjEwcHgifSwidGV4dCI6eyJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiNjNmE1NWEifSwiaHRtbCI6IjxkaXYgY2xhc3M9XCJ0eHRUaW55TWNlLXdyYXBwZXJcIiBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiPnt3ZWJ2aWV3X3RleHR9PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiaW5oZXJpdCIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6IjUyNDgyZmEyLTRiMDAtNGU2OC05YThmLTQyYTA1YTExODViOCJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiJlYjI1MmY5MC0wZWMzLTQzNDgtYjhlNi00OWNiZDkyMGE2MzEifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiMDdjYTVmZDAtZGNiMy00NDcwLTk3OWEtMDg0ODRkMWVhZWNlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjcsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCI+PHAgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIj48YSBocmVmPVwiaHR0cHM6Ly9rYW1ibHkuY29tXCIgdGFyZ2V0PVwiX2JsYW5rXCIgc3R5bGU9XCJ0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTtcIiByZWw9XCJub29wZW5lclwiPnd3dy5rYW1ibHkuY29tPC9hPjwvcD48L2Rpdj4iLCJzdHlsZSI6eyJjb2xvciI6IiM1NTU1NTUiLCJmb250LWZhbWlseSI6ImluaGVyaXQiLCJsaW5lLWhlaWdodCI6IjEyMCUifX19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtdGV4dCIsInV1aWQiOiJmMzNkNTE2ZC0xZTUxLTRhZmYtYTA4OS1iZjJkZmE1MDRiMzIifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiOTE5OGNiYjktYTY2My00MGM5LTgwYmEtMDJkYjI5NWFkMTBkIn0seyJncmlkLWNvbHVtbnMiOjUsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiIxODBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJoZWlnaHQiOiI4NnB4IiwiaHJlZiI6IiIsInNyYyI6Imh0dHBzOi8vZDE1azJkMTFyNnQ2cmwuY2xvdWRmcm9udC5uZXQvcHVibGljL3VzZXJzL0ludGVncmF0b3JzL2NlMzBiYzFlLWI3OWEtNDA3MS1hY2Y2LTc1NjUxMTkzMWZjOS9iZWVwcm90ZXN0L0thbWJseV9kZS5qcGciLCJ3aWR0aCI6IjE4MHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNTJmMWM0MTQtYjJmNS00NGIwLTk3NzEtZjY1OWJhYTBkY2E4In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6Ijk3MjdjOGIxLThhZjctNDE0ZS05OGQwLTEzYjBhY2M4ZWFkZCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjY1MHB4In19LCJ0eXBlIjoidHdvLWNvbHVtbnMtZW1wdHkiLCJ1dWlkIjoiMzA3OTQxYzUtMzIyMi00OWZjLWFkMGYtNWEwNThlMzM5MzhkIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbeyJkZXNjcmlwdG9yIjp7ImNvbXB1dGVkU3R5bGUiOnsiY2xhc3MiOiJjZW50ZXIgYXV0b3dpZHRoIiwiaGlkZUNvbnRlbnRPbk1vYmlsZSI6ZmFsc2UsIndpZHRoIjoiNjUwcHgifSwiaW1hZ2UiOnsiYWx0IjoiIiwiaGVpZ2h0IjoiODAwcHgiLCJocmVmIjoiIiwic3JjIjoiaHR0cHM6Ly9kMTVrMmQxMXI2dDZybC5jbG91ZGZyb250Lm5ldC9wdWJsaWMvdXNlcnMvSW50ZWdyYXRvcnMvY2UzMGJjMWUtYjc5YS00MDcxLWFjZjYtNzU2NTExOTMxZmM5L2JlZXByb3Rlc3QvQm94LmpwZyIsIndpZHRoIjoiMTIwMHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNDQ0NmQ4ZjAtZmZlMC00MTNlLWExZTQtNjEzZjgyMTc0NjZhIn1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6ImZkM2UxYzU1LWIxYTUtNDE1Ny1hYjI0LTJjNjYzM2YwZGYyMCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiJmMzUwMTRmYy1iYzRiLTQ4Y2ItYmUyZC0wZmZkOTRmMWY4OGUifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgZm9udC1mYW1pbHk6IFRhaG9tYSwgVmVyZGFuYSwgU2Vnb2UsIHNhbnMtc2VyaWY7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBmb250LWZhbWlseTogVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZjtcIj48cCBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQ7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiPkxvcmVtIGlwc3VtIGRvbG9yIHNpdCBhbWV0PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZiIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6ImM1ZTZhZjQyLTMzNTEtNDBjYy1hNDY5LWU0YjE1YTk2NDdlNyJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI1MDgwNjc1Ny0wZjFhLTRiMmYtODgyMy0xZDQ0NDVkN2E0YTYifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiODI4M2Y3YTMtNmZjZC00YTA1LWI4ZjYtODExYTQwOTIwZmZlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbXSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI4YTE4YjRjYi0wMmE1LTRhNzMtOGNkYi0xNDU1MDIzZDU0YTMifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiOTM3NGFkZGEtNmZkZC00Yzk1LTkyMzQtYzVhNzlhZTE4NjYxIn1dLCJ0ZW1wbGF0ZSI6eyJuYW1lIjoidGVtcGxhdGUtYmFzZSIsInR5cGUiOiJiYXNpYyIsInZlcnNpb24iOiIwLjAuMSJ9LCJ0aXRsZSI6IlRlbXBsYXRlIEJhc2UifSwiY29tbWVudHMiOnt9fQ==',1),(7,'hello - 12/06/2022 07:39:10','email',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;background-size:auto;width:650px\" width=\"650\"><tbody><tr><td \r\nclass=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div \r\nstyle=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;background-size:auto;width:650px\" width=\"650\"><tbody><tr><td \r\nclass=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div \r\nstyle=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','eyJwYWdlIjp7ImJvZHkiOnsiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZDlkYmRjIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsiYWxpZ24iOiJjZW50ZXIiLCJsaW5rQ29sb3IiOiIjYzZhNTVhIiwibWVzc2FnZUJhY2tncm91bmRDb2xvciI6IiNmZmZmZmYiLCJtZXNzYWdlV2lkdGgiOiI2NTBweCJ9LCJzdHlsZSI6eyJjb2xvciI6IiMwMDAwMDAiLCJmb250LWZhbWlseSI6IkFyaWFsLCBIZWx2ZXRpY2EgTmV1ZSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1wYWdlLXByb3ByZXJ0aWVzIiwid2ViRm9udHMiOlt7ImZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udEZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udE5hbWUiOiJSb2JvdG8iLCJuYW1lIjoiUm9ib3RvIiwidXJsIjoiaHR0cHM6Ly9mb250cy5nb29nbGVhcGlzLmNvbS9jc3M/ZmFtaWx5PVJvYm90byJ9XX0sImRlc2NyaXB0aW9uIjoiVGVzdCB0ZW1wbGF0ZSBmb3IgQkVFIiwicm93cyI6W3siY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIxMHB4IiwicGFkZGluZy1yaWdodCI6IjEwcHgiLCJwYWRkaW5nLXRvcCI6IjEwcHgifSwidGV4dCI6eyJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiNjNmE1NWEifSwiaHRtbCI6IjxkaXYgY2xhc3M9XCJ0eHRUaW55TWNlLXdyYXBwZXJcIiBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiPnt3ZWJ2aWV3X3RleHR9PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiaW5oZXJpdCIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6IjUyNDgyZmEyLTRiMDAtNGU2OC05YThmLTQyYTA1YTExODViOCJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiJlYjI1MmY5MC0wZWMzLTQzNDgtYjhlNi00OWNiZDkyMGE2MzEifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiMDdjYTVmZDAtZGNiMy00NDcwLTk3OWEtMDg0ODRkMWVhZWNlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjcsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCI+PHAgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIj48YSBocmVmPVwiaHR0cHM6Ly9rYW1ibHkuY29tXCIgdGFyZ2V0PVwiX2JsYW5rXCIgc3R5bGU9XCJ0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTtcIiByZWw9XCJub29wZW5lclwiPnd3dy5rYW1ibHkuY29tPC9hPjwvcD48L2Rpdj4iLCJzdHlsZSI6eyJjb2xvciI6IiM1NTU1NTUiLCJmb250LWZhbWlseSI6ImluaGVyaXQiLCJsaW5lLWhlaWdodCI6IjEyMCUifX19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtdGV4dCIsInV1aWQiOiJmMzNkNTE2ZC0xZTUxLTRhZmYtYTA4OS1iZjJkZmE1MDRiMzIifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiOTE5OGNiYjktYTY2My00MGM5LTgwYmEtMDJkYjI5NWFkMTBkIn0seyJncmlkLWNvbHVtbnMiOjUsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiIxODBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJoZWlnaHQiOiI4NnB4IiwiaHJlZiI6IiIsInNyYyI6Imh0dHBzOi8vZDE1azJkMTFyNnQ2cmwuY2xvdWRmcm9udC5uZXQvcHVibGljL3VzZXJzL0ludGVncmF0b3JzL2NlMzBiYzFlLWI3OWEtNDA3MS1hY2Y2LTc1NjUxMTkzMWZjOS9iZWVwcm90ZXN0L0thbWJseV9kZS5qcGciLCJ3aWR0aCI6IjE4MHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNTJmMWM0MTQtYjJmNS00NGIwLTk3NzEtZjY1OWJhYTBkY2E4In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6Ijk3MjdjOGIxLThhZjctNDE0ZS05OGQwLTEzYjBhY2M4ZWFkZCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJiYWNrZ3JvdW5kLXNpemUiOiJhdXRvIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCIsImJhY2tncm91bmQtc2l6ZSI6ImF1dG8ifX0sInR5cGUiOiJ0d28tY29sdW1ucy1lbXB0eSIsInV1aWQiOiIzMDc5NDFjNS0zMjIyLTQ5ZmMtYWQwZi01YTA1OGUzMzkzOGQifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiI2NTBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJoZWlnaHQiOiI4MDBweCIsImhyZWYiOiIiLCJzcmMiOiJodHRwczovL2QxNWsyZDExcjZ0NnJsLmNsb3VkZnJvbnQubmV0L3B1YmxpYy91c2Vycy9JbnRlZ3JhdG9ycy9jZTMwYmMxZS1iNzlhLTQwNzEtYWNmNi03NTY1MTE5MzFmYzkvYmVlcHJvdGVzdC9Cb3guanBnIiwid2lkdGgiOiIxMjAwcHgiLCJkeW5hbWljU3JjIjpudWxsfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiIwcHgiLCJ3aWR0aCI6IjEwMCUifX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy1pbWFnZSIsInV1aWQiOiI0NDQ2ZDhmMC1mZmUwLTQxM2UtYTFlNC02MTNmODIxNzQ2NmEifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiZmQzZTFjNTUtYjFhNS00MTU3LWFiMjQtMmM2NjMzZjBkZjIwIn1dLCJjb250YWluZXIiOnsic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYmFja2dyb3VuZC1pbWFnZSI6Im5vbmUiLCJiYWNrZ3JvdW5kLXBvc2l0aW9uIjoidG9wIGxlZnQiLCJiYWNrZ3JvdW5kLXJlcGVhdCI6Im5vLXJlcGVhdCJ9fSwiY29udGVudCI6eyJjb21wdXRlZFN0eWxlIjp7InJvd0NvbFN0YWNrT25Nb2JpbGUiOnRydWUsInJvd1JldmVyc2VDb2xTdGFja09uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZmZmZmZmIiwiYmFja2dyb3VuZC1pbWFnZSI6Im5vbmUiLCJiYWNrZ3JvdW5kLXBvc2l0aW9uIjoidG9wIGxlZnQiLCJiYWNrZ3JvdW5kLXJlcGVhdCI6Im5vLXJlcGVhdCIsImNvbG9yIjoiIzAwMDAwMCIsIndpZHRoIjoiNTAwcHgifX0sInR5cGUiOiJvbmUtY29sdW1uLWVtcHR5IiwidXVpZCI6ImYzNTAxNGZjLWJjNGItNDhjYi1iZTJkLTBmZmQ5NGYxZjg4ZSJ9LHsiY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIxMHB4IiwicGFkZGluZy1sZWZ0IjoiMTBweCIsInBhZGRpbmctcmlnaHQiOiIxMHB4IiwicGFkZGluZy10b3AiOiIxMHB4In0sInRleHQiOnsiY29tcHV0ZWRTdHlsZSI6eyJsaW5rQ29sb3IiOiIjYzZhNTVhIn0sImh0bWwiOiI8ZGl2IGNsYXNzPVwidHh0VGlueU1jZS13cmFwcGVyXCIgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBmb250LWZhbWlseTogVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZjtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IGZvbnQtZmFtaWx5OiBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmO1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQ7XCI+TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQ8L3A+PC9kaXY+Iiwic3R5bGUiOnsiY29sb3IiOiIjYzZhNTVhIiwiZm9udC1mYW1pbHkiOiJUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwibGluZS1oZWlnaHQiOiIxMjAlIn19fSwidHlwZSI6Im1haWx1cC1iZWUtbmV3c2xldHRlci1tb2R1bGVzLXRleHQiLCJ1dWlkIjoiYzVlNmFmNDItMzM1MS00MGNjLWE0NjktZTRiMTVhOTY0N2U3In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6IjUwODA2NzU3LTBmMWEtNGIyZi04ODIzLTFkNDQ0NWQ3YTRhNiJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiI4MjgzZjdhMy02ZmNkLTRhMDUtYjhmNi04MTFhNDA5MjBmZmUifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOltdLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6IjhhMThiNGNiLTAyYTUtNGE3My04Y2RiLTE0NTUwMjNkNTRhMyJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiI5Mzc0YWRkYS02ZmRkLTRjOTUtOTIzNC1jNWE3OWFlMTg2NjEifV0sInRlbXBsYXRlIjp7Im5hbWUiOiJ0ZW1wbGF0ZS1iYXNlIiwidHlwZSI6ImJhc2ljIiwidmVyc2lvbiI6IjAuMC4xIn0sInRpdGxlIjoiVGVtcGxhdGUgQmFzZSJ9LCJjb21tZW50cyI6e319',1),(8,'hello - 12/06/2022 08:10:13','email',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td \r\nclass=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div \r\nstyle=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td \r\nclass=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div \r\nstyle=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','eyJwYWdlIjp7ImJvZHkiOnsiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZDlkYmRjIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsiYWxpZ24iOiJjZW50ZXIiLCJsaW5rQ29sb3IiOiIjYzZhNTVhIiwibWVzc2FnZUJhY2tncm91bmRDb2xvciI6IiNmZmZmZmYiLCJtZXNzYWdlV2lkdGgiOiI2NTBweCJ9LCJzdHlsZSI6eyJjb2xvciI6IiMwMDAwMDAiLCJmb250LWZhbWlseSI6IkFyaWFsLCBIZWx2ZXRpY2EgTmV1ZSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1wYWdlLXByb3ByZXJ0aWVzIiwid2ViRm9udHMiOlt7ImZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udEZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udE5hbWUiOiJSb2JvdG8iLCJuYW1lIjoiUm9ib3RvIiwidXJsIjoiaHR0cHM6Ly9mb250cy5nb29nbGVhcGlzLmNvbS9jc3M/ZmFtaWx5PVJvYm90byJ9XX0sImRlc2NyaXB0aW9uIjoiVGVzdCB0ZW1wbGF0ZSBmb3IgQkVFIiwicm93cyI6W3siY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIxMHB4IiwicGFkZGluZy1yaWdodCI6IjEwcHgiLCJwYWRkaW5nLXRvcCI6IjEwcHgifSwidGV4dCI6eyJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiNjNmE1NWEifSwiaHRtbCI6IjxkaXYgY2xhc3M9XCJ0eHRUaW55TWNlLXdyYXBwZXJcIiBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiPnt3ZWJ2aWV3X3RleHR9PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiaW5oZXJpdCIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6IjUyNDgyZmEyLTRiMDAtNGU2OC05YThmLTQyYTA1YTExODViOCJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiJlYjI1MmY5MC0wZWMzLTQzNDgtYjhlNi00OWNiZDkyMGE2MzEifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiMDdjYTVmZDAtZGNiMy00NDcwLTk3OWEtMDg0ODRkMWVhZWNlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjcsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCI+PHAgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIj48YSBocmVmPVwiaHR0cHM6Ly9rYW1ibHkuY29tXCIgdGFyZ2V0PVwiX2JsYW5rXCIgc3R5bGU9XCJ0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTtcIiByZWw9XCJub29wZW5lclwiPnd3dy5rYW1ibHkuY29tPC9hPjwvcD48L2Rpdj4iLCJzdHlsZSI6eyJjb2xvciI6IiM1NTU1NTUiLCJmb250LWZhbWlseSI6ImluaGVyaXQiLCJsaW5lLWhlaWdodCI6IjEyMCUifX19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtdGV4dCIsInV1aWQiOiJmMzNkNTE2ZC0xZTUxLTRhZmYtYTA4OS1iZjJkZmE1MDRiMzIifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiOTE5OGNiYjktYTY2My00MGM5LTgwYmEtMDJkYjI5NWFkMTBkIn0seyJncmlkLWNvbHVtbnMiOjUsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiIxODBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJoZWlnaHQiOiI4NnB4IiwiaHJlZiI6IiIsInNyYyI6Imh0dHBzOi8vZDE1azJkMTFyNnQ2cmwuY2xvdWRmcm9udC5uZXQvcHVibGljL3VzZXJzL0ludGVncmF0b3JzL2NlMzBiYzFlLWI3OWEtNDA3MS1hY2Y2LTc1NjUxMTkzMWZjOS9iZWVwcm90ZXN0L0thbWJseV9kZS5qcGciLCJ3aWR0aCI6IjE4MHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNTJmMWM0MTQtYjJmNS00NGIwLTk3NzEtZjY1OWJhYTBkY2E4In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6Ijk3MjdjOGIxLThhZjctNDE0ZS05OGQwLTEzYjBhY2M4ZWFkZCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJiYWNrZ3JvdW5kLXNpemUiOiJhdXRvIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiYmFja2dyb3VuZC1zaXplIjoiYXV0byIsImNvbG9yIjoiIzAwMDAwMCIsIndpZHRoIjoiNjUwcHgifX0sInR5cGUiOiJ0d28tY29sdW1ucy1lbXB0eSIsInV1aWQiOiIzMDc5NDFjNS0zMjIyLTQ5ZmMtYWQwZi01YTA1OGUzMzkzOGQifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiI2NTBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJkeW5hbWljU3JjIjpudWxsLCJoZWlnaHQiOiI4MDBweCIsImhyZWYiOiIiLCJzcmMiOiJodHRwczovL2QxNWsyZDExcjZ0NnJsLmNsb3VkZnJvbnQubmV0L3B1YmxpYy91c2Vycy9JbnRlZ3JhdG9ycy9jZTMwYmMxZS1iNzlhLTQwNzEtYWNmNi03NTY1MTE5MzFmYzkvYmVlcHJvdGVzdC9Cb3guanBnIiwid2lkdGgiOiIxMjAwcHgifSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiIwcHgiLCJ3aWR0aCI6IjEwMCUifX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy1pbWFnZSIsInV1aWQiOiI0NDQ2ZDhmMC1mZmUwLTQxM2UtYTFlNC02MTNmODIxNzQ2NmEifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiZmQzZTFjNTUtYjFhNS00MTU3LWFiMjQtMmM2NjMzZjBkZjIwIn1dLCJjb250YWluZXIiOnsic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYmFja2dyb3VuZC1pbWFnZSI6Im5vbmUiLCJiYWNrZ3JvdW5kLXBvc2l0aW9uIjoidG9wIGxlZnQiLCJiYWNrZ3JvdW5kLXJlcGVhdCI6Im5vLXJlcGVhdCJ9fSwiY29udGVudCI6eyJjb21wdXRlZFN0eWxlIjp7InJvd0NvbFN0YWNrT25Nb2JpbGUiOnRydWUsInJvd1JldmVyc2VDb2xTdGFja09uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZmZmZmZmIiwiYmFja2dyb3VuZC1pbWFnZSI6Im5vbmUiLCJiYWNrZ3JvdW5kLXBvc2l0aW9uIjoidG9wIGxlZnQiLCJiYWNrZ3JvdW5kLXJlcGVhdCI6Im5vLXJlcGVhdCIsImNvbG9yIjoiIzAwMDAwMCIsIndpZHRoIjoiNTAwcHgifX0sInR5cGUiOiJvbmUtY29sdW1uLWVtcHR5IiwidXVpZCI6ImYzNTAxNGZjLWJjNGItNDhjYi1iZTJkLTBmZmQ5NGYxZjg4ZSJ9LHsiY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIxMHB4IiwicGFkZGluZy1sZWZ0IjoiMTBweCIsInBhZGRpbmctcmlnaHQiOiIxMHB4IiwicGFkZGluZy10b3AiOiIxMHB4In0sInRleHQiOnsiY29tcHV0ZWRTdHlsZSI6eyJsaW5rQ29sb3IiOiIjYzZhNTVhIn0sImh0bWwiOiI8ZGl2IGNsYXNzPVwidHh0VGlueU1jZS13cmFwcGVyXCIgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBmb250LWZhbWlseTogVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZjtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IGZvbnQtZmFtaWx5OiBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmO1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQ7XCI+TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQ8L3A+PC9kaXY+Iiwic3R5bGUiOnsiY29sb3IiOiIjYzZhNTVhIiwiZm9udC1mYW1pbHkiOiJUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwibGluZS1oZWlnaHQiOiIxMjAlIn19fSwidHlwZSI6Im1haWx1cC1iZWUtbmV3c2xldHRlci1tb2R1bGVzLXRleHQiLCJ1dWlkIjoiYzVlNmFmNDItMzM1MS00MGNjLWE0NjktZTRiMTVhOTY0N2U3In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6IjUwODA2NzU3LTBmMWEtNGIyZi04ODIzLTFkNDQ0NWQ3YTRhNiJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiI4MjgzZjdhMy02ZmNkLTRhMDUtYjhmNi04MTFhNDA5MjBmZmUifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOltdLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6IjhhMThiNGNiLTAyYTUtNGE3My04Y2RiLTE0NTUwMjNkNTRhMyJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiI5Mzc0YWRkYS02ZmRkLTRjOTUtOTIzNC1jNWE3OWFlMTg2NjEifV0sInRlbXBsYXRlIjp7Im5hbWUiOiJ0ZW1wbGF0ZS1iYXNlIiwidHlwZSI6ImJhc2ljIiwidmVyc2lvbiI6IjAuMC4xIn0sInRpdGxlIjoiVGVtcGxhdGUgQmFzZSJ9LCJjb21tZW50cyI6e319',1),(9,'hello - 12/06/2022 08:15:36','email',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td \r\nclass=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div \r\nstyle=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>',_binary '<!DOCTYPE html><html xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Roboto\" \r\nrel=\"stylesheet\" type=\"text/css\"><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table \r\nclass=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" \r\ncellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td \r\nclass=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div \r\nstyle=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img \r\nsrc=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" \r\nalign=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" \r\ncellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\"></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table \r\nclass=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" \r\nstyle=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" \r\nstyle=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" \r\nborder=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" \r\nrole=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','eyJwYWdlIjp7ImJvZHkiOnsiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZDlkYmRjIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsiYWxpZ24iOiJjZW50ZXIiLCJsaW5rQ29sb3IiOiIjYzZhNTVhIiwibWVzc2FnZUJhY2tncm91bmRDb2xvciI6IiNmZmZmZmYiLCJtZXNzYWdlV2lkdGgiOiI2NTBweCJ9LCJzdHlsZSI6eyJjb2xvciI6IiMwMDAwMDAiLCJmb250LWZhbWlseSI6IkFyaWFsLCBIZWx2ZXRpY2EgTmV1ZSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1wYWdlLXByb3ByZXJ0aWVzIiwid2ViRm9udHMiOlt7ImZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udEZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udE5hbWUiOiJSb2JvdG8iLCJuYW1lIjoiUm9ib3RvIiwidXJsIjoiaHR0cHM6Ly9mb250cy5nb29nbGVhcGlzLmNvbS9jc3M/ZmFtaWx5PVJvYm90byJ9XX0sImRlc2NyaXB0aW9uIjoiVGVzdCB0ZW1wbGF0ZSBmb3IgQkVFIiwicm93cyI6W3siY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIxMHB4IiwicGFkZGluZy1yaWdodCI6IjEwcHgiLCJwYWRkaW5nLXRvcCI6IjEwcHgifSwidGV4dCI6eyJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiNjNmE1NWEifSwiaHRtbCI6IjxkaXYgY2xhc3M9XCJ0eHRUaW55TWNlLXdyYXBwZXJcIiBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiPnt3ZWJ2aWV3X3RleHR9PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiaW5oZXJpdCIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6IjUyNDgyZmEyLTRiMDAtNGU2OC05YThmLTQyYTA1YTExODViOCJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiJlYjI1MmY5MC0wZWMzLTQzNDgtYjhlNi00OWNiZDkyMGE2MzEifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiMDdjYTVmZDAtZGNiMy00NDcwLTk3OWEtMDg0ODRkMWVhZWNlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjcsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCI+PHAgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIj48YSBocmVmPVwiaHR0cHM6Ly9rYW1ibHkuY29tXCIgdGFyZ2V0PVwiX2JsYW5rXCIgc3R5bGU9XCJ0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTtcIiByZWw9XCJub29wZW5lclwiPnd3dy5rYW1ibHkuY29tPC9hPjwvcD48L2Rpdj4iLCJzdHlsZSI6eyJjb2xvciI6IiM1NTU1NTUiLCJmb250LWZhbWlseSI6ImluaGVyaXQiLCJsaW5lLWhlaWdodCI6IjEyMCUifX19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtdGV4dCIsInV1aWQiOiJmMzNkNTE2ZC0xZTUxLTRhZmYtYTA4OS1iZjJkZmE1MDRiMzIifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiOTE5OGNiYjktYTY2My00MGM5LTgwYmEtMDJkYjI5NWFkMTBkIn0seyJncmlkLWNvbHVtbnMiOjUsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiIxODBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJoZWlnaHQiOiI4NnB4IiwiaHJlZiI6IiIsInNyYyI6Imh0dHBzOi8vZDE1azJkMTFyNnQ2cmwuY2xvdWRmcm9udC5uZXQvcHVibGljL3VzZXJzL0ludGVncmF0b3JzL2NlMzBiYzFlLWI3OWEtNDA3MS1hY2Y2LTc1NjUxMTkzMWZjOS9iZWVwcm90ZXN0L0thbWJseV9kZS5qcGciLCJ3aWR0aCI6IjE4MHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNTJmMWM0MTQtYjJmNS00NGIwLTk3NzEtZjY1OWJhYTBkY2E4In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6Ijk3MjdjOGIxLThhZjctNDE0ZS05OGQwLTEzYjBhY2M4ZWFkZCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJiYWNrZ3JvdW5kLXNpemUiOiJhdXRvIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiYmFja2dyb3VuZC1zaXplIjoiYXV0byIsImNvbG9yIjoiIzAwMDAwMCIsIndpZHRoIjoiNjUwcHgifX0sInR5cGUiOiJ0d28tY29sdW1ucy1lbXB0eSIsInV1aWQiOiIzMDc5NDFjNS0zMjIyLTQ5ZmMtYWQwZi01YTA1OGUzMzkzOGQifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiI2NTBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJkeW5hbWljU3JjIjpudWxsLCJoZWlnaHQiOiI4MDBweCIsImhyZWYiOiIiLCJzcmMiOiJodHRwczovL2QxNWsyZDExcjZ0NnJsLmNsb3VkZnJvbnQubmV0L3B1YmxpYy91c2Vycy9JbnRlZ3JhdG9ycy9jZTMwYmMxZS1iNzlhLTQwNzEtYWNmNi03NTY1MTE5MzFmYzkvYmVlcHJvdGVzdC9Cb3guanBnIiwid2lkdGgiOiIxMjAwcHgifSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiIwcHgiLCJ3aWR0aCI6IjEwMCUifX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy1pbWFnZSIsInV1aWQiOiI0NDQ2ZDhmMC1mZmUwLTQxM2UtYTFlNC02MTNmODIxNzQ2NmEifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiZmQzZTFjNTUtYjFhNS00MTU3LWFiMjQtMmM2NjMzZjBkZjIwIn1dLCJjb250YWluZXIiOnsic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYmFja2dyb3VuZC1pbWFnZSI6Im5vbmUiLCJiYWNrZ3JvdW5kLXBvc2l0aW9uIjoidG9wIGxlZnQiLCJiYWNrZ3JvdW5kLXJlcGVhdCI6Im5vLXJlcGVhdCJ9fSwiY29udGVudCI6eyJjb21wdXRlZFN0eWxlIjp7InJvd0NvbFN0YWNrT25Nb2JpbGUiOnRydWUsInJvd1JldmVyc2VDb2xTdGFja09uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZmZmZmZmIiwiYmFja2dyb3VuZC1pbWFnZSI6Im5vbmUiLCJiYWNrZ3JvdW5kLXBvc2l0aW9uIjoidG9wIGxlZnQiLCJiYWNrZ3JvdW5kLXJlcGVhdCI6Im5vLXJlcGVhdCIsImNvbG9yIjoiIzAwMDAwMCIsIndpZHRoIjoiNTAwcHgifX0sInR5cGUiOiJvbmUtY29sdW1uLWVtcHR5IiwidXVpZCI6ImYzNTAxNGZjLWJjNGItNDhjYi1iZTJkLTBmZmQ5NGYxZjg4ZSJ9LHsiY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIxMHB4IiwicGFkZGluZy1sZWZ0IjoiMTBweCIsInBhZGRpbmctcmlnaHQiOiIxMHB4IiwicGFkZGluZy10b3AiOiIxMHB4In0sInRleHQiOnsiY29tcHV0ZWRTdHlsZSI6eyJsaW5rQ29sb3IiOiIjYzZhNTVhIn0sImh0bWwiOiI8ZGl2IGNsYXNzPVwidHh0VGlueU1jZS13cmFwcGVyXCIgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBmb250LWZhbWlseTogVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZjtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IGZvbnQtZmFtaWx5OiBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmO1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQ7XCI+TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQ8L3A+PC9kaXY+Iiwic3R5bGUiOnsiY29sb3IiOiIjYzZhNTVhIiwiZm9udC1mYW1pbHkiOiJUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwibGluZS1oZWlnaHQiOiIxMjAlIn19fSwidHlwZSI6Im1haWx1cC1iZWUtbmV3c2xldHRlci1tb2R1bGVzLXRleHQiLCJ1dWlkIjoiYzVlNmFmNDItMzM1MS00MGNjLWE0NjktZTRiMTVhOTY0N2U3In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6IjUwODA2NzU3LTBmMWEtNGIyZi04ODIzLTFkNDQ0NWQ3YTRhNiJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiI4MjgzZjdhMy02ZmNkLTRhMDUtYjhmNi04MTFhNDA5MjBmZmUifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOltdLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6IjhhMThiNGNiLTAyYTUtNGE3My04Y2RiLTE0NTUwMjNkNTRhMyJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiI5Mzc0YWRkYS02ZmRkLTRjOTUtOTIzNC1jNWE3OWFlMTg2NjEifV0sInRlbXBsYXRlIjp7Im5hbWUiOiJ0ZW1wbGF0ZS1iYXNlIiwidHlwZSI6ImJhc2ljIiwidmVyc2lvbiI6IjAuMC4xIn0sInRpdGxlIjoiVGVtcGxhdGUgQmFzZSJ9LCJjb21tZW50cyI6e319',1),(10,'Test - 14/06/2022 15:21:33','email',_binary '<!DOCTYPE html><html xmlnsv=\"urn:schemas-microsoft-com:vml\" xmlnso=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" /><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!----><link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\" type=\"text/css\" /><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td></tr>\r\n</tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>',_binary '<!DOCTYPE html><html xmlnsv=\"urn:schemas-microsoft-com:vml\" xmlnso=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" /><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!----><link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\" type=\"text/css\" /><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td></tr>\r\n</tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','eyJwYWdlIjp7ImJvZHkiOnsiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiIjZDlkYmRjIn19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsiYWxpZ24iOiJjZW50ZXIiLCJsaW5rQ29sb3IiOiIjMDA2OEE1IiwibWVzc2FnZUJhY2tncm91bmRDb2xvciI6IiNmZmZmZmYiLCJtZXNzYWdlV2lkdGgiOiI2NTBweCJ9LCJzdHlsZSI6eyJjb2xvciI6IiMwMDAwMDAiLCJmb250LWZhbWlseSI6IkFyaWFsLCBIZWx2ZXRpY2EgTmV1ZSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1wYWdlLXByb3ByZXJ0aWVzIiwid2ViRm9udHMiOlt7ImZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udEZhbWlseSI6IidSb2JvdG8nLCBUYWhvbWEsIFZlcmRhbmEsIFNlZ29lLCBzYW5zLXNlcmlmIiwiZm9udE5hbWUiOiJSb2JvdG8iLCJuYW1lIjoiUm9ib3RvIiwidXJsIjoiaHR0cHM6Ly9mb250cy5nb29nbGVhcGlzLmNvbS9jc3M/ZmFtaWx5PVJvYm90byJ9XX0sImRlc2NyaXB0aW9uIjoiVGVzdCB0ZW1wbGF0ZSBmb3IgQkVFIiwicm93cyI6W3siY29sdW1ucyI6W3siZ3JpZC1jb2x1bW5zIjoxMiwibW9kdWxlcyI6W3siZGVzY3JpcHRvciI6eyJjb21wdXRlZFN0eWxlIjp7ImhpZGVDb250ZW50T25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsicGFkZGluZy1ib3R0b20iOiIwcHgiLCJwYWRkaW5nLWxlZnQiOiIxMHB4IiwicGFkZGluZy1yaWdodCI6IjEwcHgiLCJwYWRkaW5nLXRvcCI6IjEwcHgifSwidGV4dCI6eyJjb21wdXRlZFN0eWxlIjp7ImxpbmtDb2xvciI6IiMwMDY4QTUifSwiaHRtbCI6IjxkaXYgY2xhc3M9XCJ0eHRUaW55TWNlLXdyYXBwZXJcIiBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4O1wiPjxwIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDsgdGV4dC1hbGlnbjogY2VudGVyO1wiPnt3ZWJ2aWV3X3RleHR9PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiIzU1NTU1NSIsImZvbnQtZmFtaWx5IjoiaW5oZXJpdCIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6IjUyNDgyZmEyLTRiMDAtNGU2OC05YThmLTQyYTA1YTExODViOCJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiJlYjI1MmY5MC0wZWMzLTQzNDgtYjhlNi00OWNiZDkyMGE2MzEifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI2NTBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiMDdjYTVmZDAtZGNiMy00NDcwLTk3OWEtMDg0ODRkMWVhZWNlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjcsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiI2M2YTU1YSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDtcIiBkYXRhLW1jZS1zdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7XCI+PHAgc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiIGRhdGEtbWNlLXN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgd29yZC1icmVhazogYnJlYWstd29yZDtcIj48YSBocmVmPVwiaHR0cHM6Ly9rYW1ibHkuY29tXCIgdGFyZ2V0PVwiX2JsYW5rXCIgc3R5bGU9XCJ0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTtcIiByZWw9XCJub29wZW5lclwiPnd3dy5rYW1ibHkuY29tPC9hPjwvcD48L2Rpdj4iLCJzdHlsZSI6eyJjb2xvciI6IiM1NTU1NTUiLCJmb250LWZhbWlseSI6ImluaGVyaXQiLCJsaW5lLWhlaWdodCI6IjEyMCUifX19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtdGV4dCIsInV1aWQiOiJmMzNkNTE2ZC0xZTUxLTRhZmYtYTA4OS1iZjJkZmE1MDRiMzIifV0sInN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJvcmRlci1ib3R0b20iOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItbGVmdCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1yaWdodCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci10b3AiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJwYWRkaW5nLWJvdHRvbSI6IjVweCIsInBhZGRpbmctbGVmdCI6IjBweCIsInBhZGRpbmctcmlnaHQiOiIwcHgiLCJwYWRkaW5nLXRvcCI6IjVweCJ9LCJ1dWlkIjoiOTE5OGNiYjktYTY2My00MGM5LTgwYmEtMDJkYjI5NWFkMTBkIn0seyJncmlkLWNvbHVtbnMiOjUsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJjbGFzcyI6ImNlbnRlciBhdXRvd2lkdGgiLCJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZSwid2lkdGgiOiIxODBweCJ9LCJpbWFnZSI6eyJhbHQiOiIiLCJoZWlnaHQiOiI4NnB4IiwiaHJlZiI6IiIsInNyYyI6Imh0dHBzOi8vZDE1azJkMTFyNnQ2cmwuY2xvdWRmcm9udC5uZXQvcHVibGljL3VzZXJzL0ludGVncmF0b3JzL2NlMzBiYzFlLWI3OWEtNDA3MS1hY2Y2LTc1NjUxMTkzMWZjOS9iZWVwcm90ZXN0L0thbWJseV9kZS5qcGciLCJ3aWR0aCI6IjE4MHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNTJmMWM0MTQtYjJmNS00NGIwLTk3NzEtZjY1OWJhYTBkY2E4In1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6Ijk3MjdjOGIxLThhZjctNDE0ZS05OGQwLTEzYjBhY2M4ZWFkZCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjY1MHB4In19LCJ0eXBlIjoidHdvLWNvbHVtbnMtZW1wdHkiLCJ1dWlkIjoiMzA3OTQxYzUtMzIyMi00OWZjLWFkMGYtNWEwNThlMzM5MzhkIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbeyJkZXNjcmlwdG9yIjp7ImNvbXB1dGVkU3R5bGUiOnsiY2xhc3MiOiJjZW50ZXIgYXV0b3dpZHRoIiwiaGlkZUNvbnRlbnRPbk1vYmlsZSI6ZmFsc2UsIndpZHRoIjoiNjUwcHgifSwiaW1hZ2UiOnsiYWx0IjoiIiwiaGVpZ2h0IjoiODAwcHgiLCJocmVmIjoiIiwic3JjIjoiaHR0cHM6Ly9kMTVrMmQxMXI2dDZybC5jbG91ZGZyb250Lm5ldC9wdWJsaWMvdXNlcnMvSW50ZWdyYXRvcnMvY2UzMGJjMWUtYjc5YS00MDcxLWFjZjYtNzU2NTExOTMxZmM5L2JlZXByb3Rlc3QvQm94LmpwZyIsIndpZHRoIjoiMTIwMHB4In0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMHB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiMHB4Iiwid2lkdGgiOiIxMDAlIn19LCJ0eXBlIjoibWFpbHVwLWJlZS1uZXdzbGV0dGVyLW1vZHVsZXMtaW1hZ2UiLCJ1dWlkIjoiNDQ0NmQ4ZjAtZmZlMC00MTNlLWExZTQtNjEzZjgyMTc0NjZhIn1dLCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJib3JkZXItYm90dG9tIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLWxlZnQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItcmlnaHQiOiIwcHggc29saWQgdHJhbnNwYXJlbnQiLCJib3JkZXItdG9wIjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwicGFkZGluZy1ib3R0b20iOiI1cHgiLCJwYWRkaW5nLWxlZnQiOiIwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMHB4IiwicGFkZGluZy10b3AiOiI1cHgifSwidXVpZCI6ImZkM2UxYzU1LWIxYTUtNDE1Ny1hYjI0LTJjNjYzM2YwZGYyMCJ9XSwiY29udGFpbmVyIjp7InN0eWxlIjp7ImJhY2tncm91bmQtY29sb3IiOiJ0cmFuc3BhcmVudCIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQifX0sImNvbnRlbnQiOnsiY29tcHV0ZWRTdHlsZSI6eyJyb3dDb2xTdGFja09uTW9iaWxlIjp0cnVlLCJyb3dSZXZlcnNlQ29sU3RhY2tPbk1vYmlsZSI6ZmFsc2V9LCJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoiI2ZmZmZmZiIsImJhY2tncm91bmQtaW1hZ2UiOiJub25lIiwiYmFja2dyb3VuZC1wb3NpdGlvbiI6InRvcCBsZWZ0IiwiYmFja2dyb3VuZC1yZXBlYXQiOiJuby1yZXBlYXQiLCJjb2xvciI6IiMwMDAwMDAiLCJ3aWR0aCI6IjUwMHB4In19LCJ0eXBlIjoib25lLWNvbHVtbi1lbXB0eSIsInV1aWQiOiJmMzUwMTRmYy1iYzRiLTQ4Y2ItYmUyZC0wZmZkOTRmMWY4OGUifSx7ImNvbHVtbnMiOlt7ImdyaWQtY29sdW1ucyI6MTIsIm1vZHVsZXMiOlt7ImRlc2NyaXB0b3IiOnsiY29tcHV0ZWRTdHlsZSI6eyJoaWRlQ29udGVudE9uTW9iaWxlIjpmYWxzZX0sInN0eWxlIjp7InBhZGRpbmctYm90dG9tIjoiMTBweCIsInBhZGRpbmctbGVmdCI6IjEwcHgiLCJwYWRkaW5nLXJpZ2h0IjoiMTBweCIsInBhZGRpbmctdG9wIjoiMTBweCJ9LCJ0ZXh0Ijp7ImNvbXB1dGVkU3R5bGUiOnsibGlua0NvbG9yIjoiIzAwNjhBNSJ9LCJodG1sIjoiPGRpdiBjbGFzcz1cInR4dFRpbnlNY2Utd3JhcHBlclwiIHN0eWxlPVwiZm9udC1zaXplOiAxNHB4OyBsaW5lLWhlaWdodDogMTZweDsgZm9udC1mYW1pbHk6IFRhaG9tYSwgVmVyZGFuYSwgU2Vnb2UsIHNhbnMtc2VyaWY7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyBmb250LWZhbWlseTogVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZjtcIj48cCBzdHlsZT1cImZvbnQtc2l6ZTogMTRweDsgbGluZS1oZWlnaHQ6IDE2cHg7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQ7XCIgZGF0YS1tY2Utc3R5bGU9XCJmb250LXNpemU6IDE0cHg7IGxpbmUtaGVpZ2h0OiAxNnB4OyB3b3JkLWJyZWFrOiBicmVhay13b3JkO1wiPkxvcmVtIGlwc3VtIGRvbG9yIHNpdCBhbWV0PC9wPjwvZGl2PiIsInN0eWxlIjp7ImNvbG9yIjoiI2M2YTU1YSIsImZvbnQtZmFtaWx5IjoiVGFob21hLCBWZXJkYW5hLCBTZWdvZSwgc2Fucy1zZXJpZiIsImxpbmUtaGVpZ2h0IjoiMTIwJSJ9fX0sInR5cGUiOiJtYWlsdXAtYmVlLW5ld3NsZXR0ZXItbW9kdWxlcy10ZXh0IiwidXVpZCI6ImM1ZTZhZjQyLTMzNTEtNDBjYy1hNDY5LWU0YjE1YTk2NDdlNyJ9XSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI1MDgwNjc1Ny0wZjFhLTRiMmYtODgyMy0xZDQ0NDVkN2E0YTYifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiODI4M2Y3YTMtNmZjZC00YTA1LWI4ZjYtODExYTQwOTIwZmZlIn0seyJjb2x1bW5zIjpbeyJncmlkLWNvbHVtbnMiOjEyLCJtb2R1bGVzIjpbXSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6InRyYW5zcGFyZW50IiwiYm9yZGVyLWJvdHRvbSI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsImJvcmRlci1sZWZ0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXJpZ2h0IjoiMHB4IHNvbGlkIHRyYW5zcGFyZW50IiwiYm9yZGVyLXRvcCI6IjBweCBzb2xpZCB0cmFuc3BhcmVudCIsInBhZGRpbmctYm90dG9tIjoiNXB4IiwicGFkZGluZy1sZWZ0IjoiMHB4IiwicGFkZGluZy1yaWdodCI6IjBweCIsInBhZGRpbmctdG9wIjoiNXB4In0sInV1aWQiOiI4YTE4YjRjYi0wMmE1LTRhNzMtOGNkYi0xNDU1MDIzZDU0YTMifV0sImNvbnRhaW5lciI6eyJzdHlsZSI6eyJiYWNrZ3JvdW5kLWNvbG9yIjoidHJhbnNwYXJlbnQiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0In19LCJjb250ZW50Ijp7ImNvbXB1dGVkU3R5bGUiOnsicm93Q29sU3RhY2tPbk1vYmlsZSI6dHJ1ZSwicm93UmV2ZXJzZUNvbFN0YWNrT25Nb2JpbGUiOmZhbHNlfSwic3R5bGUiOnsiYmFja2dyb3VuZC1jb2xvciI6IiNmZmZmZmYiLCJiYWNrZ3JvdW5kLWltYWdlIjoibm9uZSIsImJhY2tncm91bmQtcG9zaXRpb24iOiJ0b3AgbGVmdCIsImJhY2tncm91bmQtcmVwZWF0Ijoibm8tcmVwZWF0IiwiY29sb3IiOiIjMDAwMDAwIiwid2lkdGgiOiI1MDBweCJ9fSwidHlwZSI6Im9uZS1jb2x1bW4tZW1wdHkiLCJ1dWlkIjoiOTM3NGFkZGEtNmZkZC00Yzk1LTkyMzQtYzVhNzlhZTE4NjYxIn1dLCJ0ZW1wbGF0ZSI6eyJuYW1lIjoidGVtcGxhdGUtYmFzZSIsInR5cGUiOiJiYXNpYyIsInZlcnNpb24iOiIwLjAuMSJ9LCJ0aXRsZSI6IlRlbXBsYXRlIEJhc2UifSwiY29tbWVudHMiOnt9fQ==',2);
/*!40000 ALTER TABLE `beefree_version` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `bundle_grapesjsbuilder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bundle_grapesjsbuilder` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` int(10) unsigned DEFAULT NULL,
  `custom_mjml` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_56A1EB07A832C1C9` (`email_id`),
  CONSTRAINT `FK_56A1EB07A832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `bundle_grapesjsbuilder` WRITE;
/*!40000 ALTER TABLE `bundle_grapesjsbuilder` DISABLE KEYS */;
/*!40000 ALTER TABLE `bundle_grapesjsbuilder` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `cache_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_items` (
  `item_id` varbinary(255) NOT NULL,
  `item_data` longblob NOT NULL,
  `item_lifetime` int(10) unsigned DEFAULT NULL,
  `item_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cache_items` WRITE;
/*!40000 ALTER TABLE `cache_items` DISABLE KEYS */;
INSERT INTO `cache_items` VALUES (_binary 'email|1|pending',_binary 'i:0;',NULL,1652192319),(_binary 'email|1|queued',_binary 'i:0;',NULL,1652192324),(_binary 'email|2|pending',_binary 's:1:\"0\";',NULL,1655220093),(_binary 'email|2|queued',_binary 'i:0;',NULL,1655220116);
/*!40000 ALTER TABLE `cache_items` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `campaign_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_order` int(11) NOT NULL,
  `properties` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `trigger_date` datetime DEFAULT NULL,
  `trigger_interval` int(11) DEFAULT NULL,
  `trigger_interval_unit` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trigger_hour` time DEFAULT NULL,
  `trigger_restricted_start_hour` time DEFAULT NULL,
  `trigger_restricted_stop_hour` time DEFAULT NULL,
  `trigger_restricted_dow` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `trigger_mode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decision_path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temp_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8EC42EE7F639F774` (`campaign_id`),
  KEY `IDX_8EC42EE7727ACA70` (`parent_id`),
  KEY `campaign_event_search` (`type`,`event_type`),
  KEY `campaign_event_type` (`event_type`),
  KEY `campaign_event_channel` (`channel`,`channel_id`),
  CONSTRAINT `FK_8EC42EE7727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `campaign_events` (`id`),
  CONSTRAINT `FK_8EC42EE7F639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `campaign_events` WRITE;
/*!40000 ALTER TABLE `campaign_events` DISABLE KEYS */;
INSERT INTO `campaign_events` VALUES (1,1,NULL,'Check Email',NULL,'email.validate.address','condition',1,'a:0:{}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new6e6edd47885d4dbf49e4352ab80065fbb1203dd9',NULL,NULL),(2,1,1,'Kontakt l??schen',NULL,'lead.deletecontact','action',2,'a:0:{}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','newf96eb9f958f3b983802b3aae7dd73557cd6a068a',NULL,NULL),(3,1,1,'Email senden',NULL,'email.send','action',2,'a:21:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"732\";s:8:\"droppedY\";s:3:\"284\";}s:4:\"name\";s:12:\"Email senden\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"1\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_03c1ae6877f1de4aa4374f22183e76ca15042165\";s:6:\"_token\";s:43:\"A4_4_DMUZm4NicdRSfhaUxD-C8yy7uQg9THc5bHibQc\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:1:\"1\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','yes','new838c67febb9f6b8b125b6c2badf80606d9dd7085','email',1);
/*!40000 ALTER TABLE `campaign_events` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `campaign_form_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_form_xref` (
  `campaign_id` int(10) unsigned NOT NULL,
  `form_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`campaign_id`,`form_id`),
  KEY `IDX_3048A8B2F639F774` (`campaign_id`),
  KEY `IDX_3048A8B25FF69B7D` (`form_id`),
  CONSTRAINT `FK_3048A8B25FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_3048A8B2F639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `campaign_form_xref` WRITE;
/*!40000 ALTER TABLE `campaign_form_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_form_xref` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `campaign_lead_event_failed_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_lead_event_failed_log` (
  `log_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `reason` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`log_id`),
  KEY `campaign_event_failed_date` (`date_added`),
  CONSTRAINT `FK_E50614D2EA675D86` FOREIGN KEY (`log_id`) REFERENCES `campaign_lead_event_log` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `campaign_lead_event_failed_log` WRITE;
/*!40000 ALTER TABLE `campaign_lead_event_failed_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_lead_event_failed_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `campaign_lead_event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_lead_event_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `campaign_id` int(10) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `rotation` int(11) NOT NULL,
  `date_triggered` datetime DEFAULT NULL,
  `is_scheduled` tinyint(1) NOT NULL,
  `trigger_date` datetime DEFAULT NULL,
  `system_triggered` tinyint(1) NOT NULL,
  `metadata` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `channel` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `non_action_path_taken` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `campaign_rotation` (`event_id`,`lead_id`,`rotation`),
  KEY `IDX_B7420BA171F7E88B` (`event_id`),
  KEY `IDX_B7420BA155458D` (`lead_id`),
  KEY `IDX_B7420BA1F639F774` (`campaign_id`),
  KEY `IDX_B7420BA1A03F5E9F` (`ip_id`),
  KEY `campaign_event_upcoming_search` (`is_scheduled`,`lead_id`),
  KEY `campaign_event_schedule_counts` (`campaign_id`,`is_scheduled`,`trigger_date`),
  KEY `campaign_date_triggered` (`date_triggered`),
  KEY `campaign_leads` (`lead_id`,`campaign_id`,`rotation`),
  KEY `campaign_log_channel` (`channel`,`channel_id`,`lead_id`),
  KEY `campaign_actions` (`campaign_id`,`event_id`,`date_triggered`),
  KEY `campaign_stats` (`campaign_id`,`date_triggered`,`event_id`,`non_action_path_taken`),
  KEY `campaign_trigger_date_order` (`trigger_date`),
  CONSTRAINT `FK_B7420BA155458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B7420BA171F7E88B` FOREIGN KEY (`event_id`) REFERENCES `campaign_events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B7420BA1A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_B7420BA1F639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `campaign_lead_event_log` WRITE;
/*!40000 ALTER TABLE `campaign_lead_event_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_lead_event_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `campaign_leadlist_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_leadlist_xref` (
  `campaign_id` int(10) unsigned NOT NULL,
  `leadlist_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`campaign_id`,`leadlist_id`),
  KEY `IDX_6480052EF639F774` (`campaign_id`),
  KEY `IDX_6480052EB9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_6480052EB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `lead_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6480052EF639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `campaign_leadlist_xref` WRITE;
/*!40000 ALTER TABLE `campaign_leadlist_xref` DISABLE KEYS */;
INSERT INTO `campaign_leadlist_xref` VALUES (1,1);
/*!40000 ALTER TABLE `campaign_leadlist_xref` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `campaign_leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_leads` (
  `campaign_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `manually_removed` tinyint(1) NOT NULL,
  `manually_added` tinyint(1) NOT NULL,
  `date_last_exited` datetime DEFAULT NULL,
  `rotation` int(11) NOT NULL,
  PRIMARY KEY (`campaign_id`,`lead_id`),
  KEY `IDX_5995213DF639F774` (`campaign_id`),
  KEY `IDX_5995213D55458D` (`lead_id`),
  KEY `campaign_leads_date_added` (`date_added`),
  KEY `campaign_leads_date_exited` (`date_last_exited`),
  KEY `campaign_leads` (`campaign_id`,`manually_removed`,`lead_id`,`rotation`),
  CONSTRAINT `FK_5995213D55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_5995213DF639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `campaign_leads` WRITE;
/*!40000 ALTER TABLE `campaign_leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_leads` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaigns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `canvas_settings` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `allow_restart` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E373747012469DE2` (`category_id`),
  CONSTRAINT `FK_E373747012469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
INSERT INTO `campaigns` VALUES (1,NULL,0,'2022-06-14 15:22:42',1,'Alain Habegger',NULL,NULL,NULL,'2022-06-15 07:27:07',1,'Alain Habegger','Test','Test',NULL,NULL,'a:2:{s:5:\"nodes\";a:4:{i:0;a:3:{s:2:\"id\";s:1:\"1\";s:9:\"positionX\";s:3:\"832\";s:9:\"positionY\";s:3:\"179\";}i:1;a:3:{s:2:\"id\";s:1:\"2\";s:9:\"positionX\";s:4:\"1019\";s:9:\"positionY\";s:3:\"283\";}i:2;a:3:{s:2:\"id\";s:1:\"3\";s:9:\"positionX\";s:3:\"716\";s:9:\"positionY\";s:3:\"285\";}i:3;a:3:{s:2:\"id\";s:5:\"lists\";s:9:\"positionX\";s:3:\"860\";s:9:\"positionY\";s:2:\"50\";}}s:11:\"connections\";a:3:{i:0;a:3:{s:8:\"sourceId\";s:5:\"lists\";s:8:\"targetId\";s:1:\"1\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:1;a:3:{s:8:\"sourceId\";s:1:\"1\";s:8:\"targetId\";s:1:\"2\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:2;a:3:{s:8:\"sourceId\";s:1:\"1\";s:8:\"targetId\";s:1:\"3\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}}}',0);
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `alias` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bundle` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_alias_search` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `channel_url_trackables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `channel_url_trackables` (
  `channel_id` int(11) NOT NULL,
  `redirect_id` bigint(20) unsigned NOT NULL,
  `channel` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hits` int(11) NOT NULL,
  `unique_hits` int(11) NOT NULL,
  PRIMARY KEY (`redirect_id`,`channel_id`),
  KEY `IDX_2F81A41DB42D874D` (`redirect_id`),
  KEY `channel_url_trackable_search` (`channel`,`channel_id`),
  CONSTRAINT `FK_2F81A41DB42D874D` FOREIGN KEY (`redirect_id`) REFERENCES `page_redirects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `channel_url_trackables` WRITE;
/*!40000 ALTER TABLE `channel_url_trackables` DISABLE KEYS */;
/*!40000 ALTER TABLE `channel_url_trackables` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_cache` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `score` int(11) DEFAULT NULL,
  `companyemail` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companyaddress1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companyaddress2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companyphone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companycity` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companystate` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companyzipcode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companycountry` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companyname` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companywebsite` longtext COLLATE utf8mb4_unicode_ci,
  `companyindustry` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companydescription` longtext COLLATE utf8mb4_unicode_ci,
  `companynumber_of_employees` double DEFAULT NULL,
  `companyfax` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companyannual_revenue` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8244AA3A7E3C61F9` (`owner_id`),
  KEY `companyaddress1_search` (`companyaddress1`),
  KEY `companyaddress2_search` (`companyaddress2`),
  KEY `companyemail_search` (`companyemail`),
  KEY `companyphone_search` (`companyphone`),
  KEY `companycity_search` (`companycity`),
  KEY `companystate_search` (`companystate`),
  KEY `companyzipcode_search` (`companyzipcode`),
  KEY `companycountry_search` (`companycountry`),
  KEY `companyname_search` (`companyname`),
  KEY `companynumber_of_employees_search` (`companynumber_of_employees`),
  KEY `companyfax_search` (`companyfax`),
  KEY `companyannual_revenue_search` (`companyannual_revenue`),
  KEY `companyindustry_search` (`companyindustry`),
  KEY `company_filter` (`companyname`,`companyemail`),
  KEY `company_match` (`companyname`,`companycity`,`companycountry`,`companystate`),
  CONSTRAINT `FK_8244AA3A7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `companies_leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies_leads` (
  `company_id` int(11) NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `is_primary` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`company_id`,`lead_id`),
  KEY `IDX_F4190AB6979B1AD6` (`company_id`),
  KEY `IDX_F4190AB655458D` (`lead_id`),
  CONSTRAINT `FK_F4190AB655458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_F4190AB6979B1AD6` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `companies_leads` WRITE;
/*!40000 ALTER TABLE `companies_leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `companies_leads` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `contact_merge_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_merge_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `merged_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D9B4F2BFE7A1254A` (`contact_id`),
  KEY `contact_merge_date_added` (`date_added`),
  KEY `contact_merge_ids` (`merged_id`),
  CONSTRAINT `FK_D9B4F2BFE7A1254A` FOREIGN KEY (`contact_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `contact_merge_records` WRITE;
/*!40000 ALTER TABLE `contact_merge_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_merge_records` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `dynamic_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dynamic_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `translation_parent_id` int(10) unsigned DEFAULT NULL,
  `variant_parent_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `sent_count` int(11) NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `utm_tags` json DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `lang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `variant_settings` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `variant_start_date` datetime DEFAULT NULL,
  `filters` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `is_campaign_based` tinyint(1) NOT NULL DEFAULT '1',
  `slot_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_20B9DEB212469DE2` (`category_id`),
  KEY `IDX_20B9DEB29091A2FB` (`translation_parent_id`),
  KEY `IDX_20B9DEB291861123` (`variant_parent_id`),
  KEY `is_campaign_based_index` (`is_campaign_based`),
  KEY `slot_name_index` (`slot_name`),
  CONSTRAINT `FK_20B9DEB212469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_20B9DEB29091A2FB` FOREIGN KEY (`translation_parent_id`) REFERENCES `dynamic_content` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_20B9DEB291861123` FOREIGN KEY (`variant_parent_id`) REFERENCES `dynamic_content` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `dynamic_content` WRITE;
/*!40000 ALTER TABLE `dynamic_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_content` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `dynamic_content_lead_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dynamic_content_lead_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `dynamic_content_id` int(10) unsigned DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `slot` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_515B221B55458D` (`lead_id`),
  KEY `IDX_515B221BD9D0CD7` (`dynamic_content_id`),
  CONSTRAINT `FK_515B221B55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_515B221BD9D0CD7` FOREIGN KEY (`dynamic_content_id`) REFERENCES `dynamic_content` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `dynamic_content_lead_data` WRITE;
/*!40000 ALTER TABLE `dynamic_content_lead_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_content_lead_data` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `dynamic_content_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dynamic_content_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dynamic_content_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `sent_count` int(11) DEFAULT NULL,
  `last_sent` datetime DEFAULT NULL,
  `sent_details` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_E48FBF80D9D0CD7` (`dynamic_content_id`),
  KEY `IDX_E48FBF8055458D` (`lead_id`),
  KEY `stat_dynamic_content_search` (`dynamic_content_id`,`lead_id`),
  KEY `stat_dynamic_content_source_search` (`source`,`source_id`),
  CONSTRAINT `FK_E48FBF8055458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_E48FBF80D9D0CD7` FOREIGN KEY (`dynamic_content_id`) REFERENCES `dynamic_content` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `dynamic_content_stats` WRITE;
/*!40000 ALTER TABLE `dynamic_content_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_content_stats` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `email_assets_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_assets_xref` (
  `email_id` int(10) unsigned NOT NULL,
  `asset_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`email_id`,`asset_id`),
  KEY `IDX_CA315778A832C1C9` (`email_id`),
  KEY `IDX_CA3157785DA1941` (`asset_id`),
  CONSTRAINT `FK_CA3157785DA1941` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_CA315778A832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `email_assets_xref` WRITE;
/*!40000 ALTER TABLE `email_assets_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_assets_xref` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `email_copies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_copies` (
  `id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci,
  `subject` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `email_copies` WRITE;
/*!40000 ALTER TABLE `email_copies` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_copies` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `email_list_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_list_xref` (
  `email_id` int(10) unsigned NOT NULL,
  `leadlist_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`email_id`,`leadlist_id`),
  KEY `IDX_2E24F01CA832C1C9` (`email_id`),
  KEY `IDX_2E24F01CB9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_2E24F01CA832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2E24F01CB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `lead_lists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `email_list_xref` WRITE;
/*!40000 ALTER TABLE `email_list_xref` DISABLE KEYS */;
INSERT INTO `email_list_xref` VALUES (2,1);
/*!40000 ALTER TABLE `email_list_xref` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `email_stat_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_stat_replies` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:guid)',
  `stat_id` bigint(20) unsigned NOT NULL,
  `date_replied` datetime NOT NULL,
  `message_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_11E9F6E09502F0B` (`stat_id`),
  KEY `email_replies` (`stat_id`,`message_id`),
  KEY `date_email_replied` (`date_replied`),
  CONSTRAINT `FK_11E9F6E09502F0B` FOREIGN KEY (`stat_id`) REFERENCES `email_stats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `email_stat_replies` WRITE;
/*!40000 ALTER TABLE `email_stat_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_stat_replies` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `email_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` int(10) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `copy_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_sent` datetime NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `is_failed` tinyint(1) NOT NULL,
  `viewed_in_browser` tinyint(1) NOT NULL,
  `date_read` datetime DEFAULT NULL,
  `tracking_hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `open_count` int(11) DEFAULT NULL,
  `last_opened` datetime DEFAULT NULL,
  `open_details` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `generated_sent_date` date GENERATED ALWAYS AS (concat(year(`date_sent`),'-',lpad(month(`date_sent`),2,'0'),'-',lpad(dayofmonth(`date_sent`),2,'0'))) VIRTUAL COMMENT '(DC2Type:generated)',
  PRIMARY KEY (`id`),
  KEY `IDX_CA0A2625A832C1C9` (`email_id`),
  KEY `IDX_CA0A262555458D` (`lead_id`),
  KEY `IDX_CA0A26253DAE168B` (`list_id`),
  KEY `IDX_CA0A2625A03F5E9F` (`ip_id`),
  KEY `IDX_CA0A2625A8752772` (`copy_id`),
  KEY `stat_email_search` (`email_id`,`lead_id`),
  KEY `stat_email_search2` (`lead_id`,`email_id`),
  KEY `stat_email_failed_search` (`is_failed`),
  KEY `is_read_date_sent` (`is_read`,`date_sent`),
  KEY `stat_email_hash_search` (`tracking_hash`),
  KEY `stat_email_source_search` (`source`,`source_id`),
  KEY `email_date_sent` (`date_sent`),
  KEY `email_date_read_lead` (`date_read`,`lead_id`),
  KEY `generated_sent_date_email_id` (`generated_sent_date`,`email_id`),
  CONSTRAINT `FK_CA0A26253DAE168B` FOREIGN KEY (`list_id`) REFERENCES `lead_lists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_CA0A262555458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_CA0A2625A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_CA0A2625A832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_CA0A2625A8752772` FOREIGN KEY (`copy_id`) REFERENCES `email_copies` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `email_stats` WRITE;
/*!40000 ALTER TABLE `email_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_stats` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `email_stats_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_stats_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) unsigned DEFAULT NULL,
  `stat_id` bigint(20) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_opened` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7A8A1C6F94A4C7D4` (`device_id`),
  KEY `IDX_7A8A1C6F9502F0B` (`stat_id`),
  KEY `IDX_7A8A1C6FA03F5E9F` (`ip_id`),
  KEY `date_opened_search` (`date_opened`),
  CONSTRAINT `FK_7A8A1C6F94A4C7D4` FOREIGN KEY (`device_id`) REFERENCES `lead_devices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_7A8A1C6F9502F0B` FOREIGN KEY (`stat_id`) REFERENCES `email_stats` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_7A8A1C6FA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `email_stats_devices` WRITE;
/*!40000 ALTER TABLE `email_stats_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_stats_devices` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `translation_parent_id` int(10) unsigned DEFAULT NULL,
  `variant_parent_id` int(10) unsigned DEFAULT NULL,
  `unsubscribeform_id` int(10) unsigned DEFAULT NULL,
  `preference_center_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `subject` longtext COLLATE utf8mb4_unicode_ci,
  `from_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_to_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bcc_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `use_owner_as_mailer` tinyint(1) DEFAULT NULL,
  `template` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `utm_tags` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `plain_text` longtext COLLATE utf8mb4_unicode_ci,
  `custom_html` longtext COLLATE utf8mb4_unicode_ci,
  `email_type` longtext COLLATE utf8mb4_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `read_count` int(11) NOT NULL,
  `sent_count` int(11) NOT NULL,
  `variant_sent_count` int(11) NOT NULL,
  `variant_read_count` int(11) NOT NULL,
  `revision` int(11) NOT NULL,
  `lang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `variant_settings` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `variant_start_date` datetime DEFAULT NULL,
  `dynamic_content` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `headers` json NOT NULL COMMENT '(DC2Type:json_array)',
  `public_preview` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4C81E85212469DE2` (`category_id`),
  KEY `IDX_4C81E8529091A2FB` (`translation_parent_id`),
  KEY `IDX_4C81E85291861123` (`variant_parent_id`),
  KEY `IDX_4C81E8522DC494F6` (`unsubscribeform_id`),
  KEY `IDX_4C81E852834F9C5B` (`preference_center_id`),
  CONSTRAINT `FK_4C81E85212469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_4C81E8522DC494F6` FOREIGN KEY (`unsubscribeform_id`) REFERENCES `forms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_4C81E852834F9C5B` FOREIGN KEY (`preference_center_id`) REFERENCES `pages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_4C81E8529091A2FB` FOREIGN KEY (`translation_parent_id`) REFERENCES `emails` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_4C81E85291861123` FOREIGN KEY (`variant_parent_id`) REFERENCES `emails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
INSERT INTO `emails` VALUES (1,NULL,NULL,NULL,NULL,NULL,1,'2022-05-10 14:18:39',1,'Alain Habegger',NULL,1,'Alain Habegger','2022-06-15 15:58:43',1,'Alain Habegger','hello',NULL,'hello world',NULL,NULL,NULL,NULL,0,'blank','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html><html xmlnsv=\"urn:schemas-microsoft-com:vml\" xmlnso=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" /><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!----><link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\" type=\"text/css\" /><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td>\r\n</tr></tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-size:auto;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','template',NULL,NULL,0,0,0,0,9,'en','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',1),(2,NULL,NULL,NULL,NULL,NULL,1,'2022-06-14 15:21:33',1,'Alain Habegger',NULL,NULL,NULL,NULL,NULL,'Alain Habegger','Test',NULL,'Test',NULL,NULL,NULL,NULL,0,'blank','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html><html xmlnsv=\"urn:schemas-microsoft-com:vml\" xmlnso=\"urn:schemas-microsoft-com:office:office\" lang=\"en\"><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" /><!--[if mso]><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch><o:AllowPNG/></o:OfficeDocumentSettings></xml><![endif]--><!--[if !mso]><!----><link href=\"https://fonts.googleapis.com/css?family=Roboto\" rel=\"stylesheet\" type=\"text/css\" /><!--<![endif]--><style>\r\n*{box-sizing:border-box}body{margin:0;padding:0}a[x-apple-data-detectors]{color:inherit!important;text-decoration:inherit!important}#MessageViewBody a{color:inherit;text-decoration:none}p{line-height:inherit}.desktop_hide,.desktop_hide table{mso-hide:all;display:none;max-height:0;overflow:hidden}@media (max-width:670px){.row-content{width:100%!important}.image_block img.big{width:auto!important}.column .border,.mobile_hide{display:none}table{table-layout:fixed!important}.stack .column{width:100%;display:block}.mobile_hide{min-height:0;max-height:0;max-width:0;overflow:hidden;font-size:0}.desktop_hide,.desktop_hide table{display:table!important;max-height:none!important}}\r\n</style></head><body style=\"background-color:#d9dbdc;margin:0;padding:0;-webkit-text-size-adjust:none;text-size-adjust:none\"><table class=\"nl-container\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#d9dbdc\"><tbody><tr><td><table class=\"row row-1\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-left:10px;padding-right:10px;padding-top:10px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px;text-align:center\">{webview_text}</p></div></div></td></tr></table></td></tr>\r\n</tbody></table></td></tr></tbody></table><table class=\"row row-2\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"58.333333333333336%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td style=\"padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px\"><div style=\"font-family:sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;mso-line-height-alt:16.8px;color:#555;line-height:1.2;font-family:Arial,Helvetica Neue,Helvetica,sans-serif\"><p style=\"margin:0;font-size:14px\"><a href=\"https://kambly.com\" target=\"_blank\" style=\"text-decoration: underline; color: #c6a55a;\" rel=\"noopener\">www.kambly.com</a></p></div></div></td></tr></table></td><td class=\"column column-2\" width=\"41.666666666666664%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0;padding-top:5px;padding-bottom:5px\"><div align=\"center\" style=\"line-height:10px\"><img src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Kambly_de.jpg\" style=\"display:block;height:auto;border:0;width:180px;max-width:100%\" width=\"180\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-3\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"image_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td style=\"width:100%;padding-right:0;padding-left:0\"><div align=\"center\" style=\"line-height:10px\"><img class=\"big\" src=\"https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/ce30bc1e-b79a-4071-acf6-756511931fc9/beeprotest/Box.jpg\" style=\"display:block;height:auto;border:0;width:650px;max-width:100%\" width=\"650\" /></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-4\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"text_block\" width=\"100%\" border=\"0\" cellpadding=\"10\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;word-break:break-word\"><tr><td><div style=\"font-family:Tahoma,Verdana,sans-serif\"><div class=\"txtTinyMce-wrapper\" style=\"font-size:14px;font-family:Tahoma,Verdana,Segoe,sans-serif;mso-line-height-alt:16.8px;color:#c6a55a;line-height:1.2\"><p style=\"margin:0;font-size:14px\">Lorem ipsum dolor sit amet</p></div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table><table class=\"row row-5\" align=\"center\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tbody><tr><td><table class=\"row-content stack\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0;background-color:#fff;color:#000;width:650px\" width=\"650\"><tbody><tr><td class=\"column column-1\" width=\"100%\" style=\"mso-table-lspace:0;mso-table-rspace:0;font-weight:400;text-align:left;vertical-align:top;padding-top:5px;padding-bottom:5px;border-top:0;border-right:0;border-bottom:0;border-left:0\"><table class=\"empty_block\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"mso-table-lspace:0;mso-table-rspace:0\"><tr><td><div></div></td></tr></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table><!-- End --></body></html>','list',NULL,NULL,0,0,0,0,1,'en','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',1);
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `focus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `focus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `focus_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `style` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `properties` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `utm_tags` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `form_id` int(11) DEFAULT NULL,
  `cache` longtext COLLATE utf8mb4_unicode_ci,
  `html_mode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `editor` longtext COLLATE utf8mb4_unicode_ci,
  `html` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_62C04AE912469DE2` (`category_id`),
  KEY `focus_type` (`focus_type`),
  KEY `focus_style` (`style`),
  KEY `focus_form` (`form_id`),
  CONSTRAINT `FK_62C04AE912469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `focus` WRITE;
/*!40000 ALTER TABLE `focus` DISABLE KEYS */;
/*!40000 ALTER TABLE `focus` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `focus_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `focus_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `focus_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C36970DC51804B42` (`focus_id`),
  KEY `IDX_C36970DC55458D` (`lead_id`),
  KEY `focus_type` (`type`),
  KEY `focus_type_id` (`type`,`type_id`),
  KEY `focus_date_added` (`date_added`),
  CONSTRAINT `FK_C36970DC51804B42` FOREIGN KEY (`focus_id`) REFERENCES `focus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C36970DC55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `focus_stats` WRITE;
/*!40000 ALTER TABLE `focus_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `focus_stats` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `form_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_actions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_order` int(11) NOT NULL,
  `properties` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_342491D45FF69B7D` (`form_id`),
  KEY `form_action_type_search` (`type`),
  CONSTRAINT `FK_342491D45FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `form_actions` WRITE;
/*!40000 ALTER TABLE `form_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_actions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `form_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(10) unsigned NOT NULL,
  `label` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `show_label` tinyint(1) DEFAULT NULL,
  `alias` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_custom` tinyint(1) NOT NULL,
  `custom_parameters` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `default_value` longtext COLLATE utf8mb4_unicode_ci,
  `is_required` tinyint(1) NOT NULL,
  `validation_message` longtext COLLATE utf8mb4_unicode_ci,
  `help_message` longtext COLLATE utf8mb4_unicode_ci,
  `field_order` int(11) DEFAULT NULL,
  `properties` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `validation` json DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `label_attr` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `input_attr` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `container_attr` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead_field` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `save_result` tinyint(1) DEFAULT NULL,
  `is_auto_fill` tinyint(1) DEFAULT NULL,
  `show_when_value_exists` tinyint(1) DEFAULT NULL,
  `show_after_x_submissions` int(11) DEFAULT NULL,
  `always_display` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7C0B37265FF69B7D` (`form_id`),
  KEY `form_field_type_search` (`type`),
  CONSTRAINT `FK_7C0B37265FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `form_fields` WRITE;
/*!40000 ALTER TABLE `form_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_fields` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `form_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_submissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(10) unsigned NOT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `page_id` int(10) unsigned DEFAULT NULL,
  `tracking_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_submitted` datetime NOT NULL,
  `referer` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C80AF9E65FF69B7D` (`form_id`),
  KEY `IDX_C80AF9E6A03F5E9F` (`ip_id`),
  KEY `IDX_C80AF9E655458D` (`lead_id`),
  KEY `IDX_C80AF9E6C4663E4` (`page_id`),
  KEY `form_submission_tracking_search` (`tracking_id`),
  KEY `form_date_submitted` (`date_submitted`),
  CONSTRAINT `FK_C80AF9E655458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_C80AF9E65FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C80AF9E6A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_C80AF9E6C4663E4` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `form_submissions` WRITE;
/*!40000 ALTER TABLE `form_submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_submissions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `alias` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `form_attr` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cached_html` longtext COLLATE utf8mb4_unicode_ci,
  `post_action` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_action_property` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `template` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_kiosk_mode` tinyint(1) DEFAULT NULL,
  `render_style` tinyint(1) DEFAULT NULL,
  `form_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_index` tinyint(1) DEFAULT NULL,
  `progressive_profiling_limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FD3F1BF712469DE2` (`category_id`),
  CONSTRAINT `FK_FD3F1BF712469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `forms` WRITE;
/*!40000 ALTER TABLE `forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `forms` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_count` int(11) NOT NULL,
  `inserted_count` int(11) NOT NULL,
  `updated_count` int(11) NOT NULL,
  `ignored_count` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `date_started` datetime DEFAULT NULL,
  `date_ended` datetime DEFAULT NULL,
  `object` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `properties` json DEFAULT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `import_object` (`object`),
  KEY `import_status` (`status`),
  KEY `import_priority` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `imports` WRITE;
/*!40000 ALTER TABLE `imports` DISABLE KEYS */;
/*!40000 ALTER TABLE `imports` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `integration_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integration_entity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_added` datetime NOT NULL,
  `integration` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `integration_entity` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `integration_entity_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `internal_entity` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `internal_entity_id` int(11) DEFAULT NULL,
  `last_sync_date` datetime DEFAULT NULL,
  `internal` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `integration_external_entity` (`integration`,`integration_entity`,`integration_entity_id`),
  KEY `integration_internal_entity` (`integration`,`internal_entity`,`internal_entity_id`),
  KEY `integration_entity_match` (`integration`,`internal_entity`,`integration_entity`),
  KEY `integration_last_sync_date` (`integration`,`last_sync_date`),
  KEY `internal_integration_entity` (`internal_entity_id`,`integration_entity_id`,`internal_entity`,`integration_entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `integration_entity` WRITE;
/*!40000 ALTER TABLE `integration_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `integration_entity` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `ip_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_addresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_details` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `ip_search` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `ip_addresses` WRITE;
/*!40000 ALTER TABLE `ip_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_addresses` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `manually_removed` tinyint(1) NOT NULL,
  `manually_added` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_12685DF412469DE2` (`category_id`),
  KEY `IDX_12685DF455458D` (`lead_id`),
  CONSTRAINT `FK_12685DF412469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_12685DF455458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_categories` WRITE;
/*!40000 ALTER TABLE `lead_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_categories` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_companies_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_companies_change_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `type` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A034C81B55458D` (`lead_id`),
  KEY `company_date_added` (`date_added`),
  CONSTRAINT `FK_A034C81B55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_companies_change_log` WRITE;
/*!40000 ALTER TABLE `lead_companies_change_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_companies_change_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `client_info` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `device` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_os_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_os_shortname` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_os_version` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_os_platform` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_model` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tracking_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_48C912F47D05ABBE` (`tracking_id`),
  KEY `IDX_48C912F455458D` (`lead_id`),
  KEY `date_added_search` (`date_added`),
  KEY `device_search` (`device`),
  KEY `device_os_name_search` (`device_os_name`),
  KEY `device_os_shortname_search` (`device_os_shortname`),
  KEY `device_os_version_search` (`device_os_version`),
  KEY `device_os_platform_search` (`device_os_platform`),
  KEY `device_brand_search` (`device_brand`),
  KEY `device_model_search` (`device_model`),
  CONSTRAINT `FK_48C912F455458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_devices` WRITE;
/*!40000 ALTER TABLE `lead_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_devices` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_donotcontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_donotcontact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `reason` smallint(6) NOT NULL,
  `channel` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `comments` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_71DC0B1D55458D` (`lead_id`),
  KEY `dnc_reason_search` (`reason`),
  CONSTRAINT `FK_71DC0B1D55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_donotcontact` WRITE;
/*!40000 ALTER TABLE `lead_donotcontact` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_donotcontact` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_event_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bundle` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `object` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `properties` json DEFAULT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `lead_id_index` (`lead_id`),
  KEY `lead_object_index` (`object`,`object_id`),
  KEY `lead_timeline_index` (`bundle`,`object`,`action`,`object_id`),
  KEY `lead_timeline_action_index` (`action`),
  KEY `lead_date_added_index` (`date_added`),
  CONSTRAINT `FK_753AF2E55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_event_log` WRITE;
/*!40000 ALTER TABLE `lead_event_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_event_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_group` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_fixed` tinyint(1) NOT NULL,
  `is_visible` tinyint(1) NOT NULL,
  `is_short_visible` tinyint(1) NOT NULL,
  `is_listable` tinyint(1) NOT NULL,
  `is_publicly_updatable` tinyint(1) NOT NULL,
  `is_unique_identifer` tinyint(1) DEFAULT NULL,
  `field_order` int(11) DEFAULT NULL,
  `object` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `properties` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `column_is_not_created` tinyint(1) NOT NULL,
  `original_is_published_value` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `search_by_object` (`object`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_fields` WRITE;
/*!40000 ALTER TABLE `lead_fields` DISABLE KEYS */;
INSERT INTO `lead_fields` VALUES (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Title','title','lookup','core',NULL,0,1,1,0,1,0,0,2,'lead','a:1:{s:4:\"list\";a:3:{i:0;s:2:\"Mr\";i:1;s:3:\"Mrs\";i:2;s:4:\"Miss\";}}',0,0),(2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'First Name','firstname','text','core',NULL,0,1,1,1,1,0,0,4,'lead','a:0:{}',0,0),(3,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Last Name','lastname','text','core',NULL,0,1,1,1,1,0,0,6,'lead','a:0:{}',0,0),(4,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Primary company','company','text','core',NULL,0,1,1,0,1,0,0,8,'lead','a:0:{}',0,0),(5,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Position','position','text','core',NULL,0,1,1,0,1,0,0,10,'lead','a:0:{}',0,0),(6,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Email','email','email','core',NULL,0,1,1,1,1,0,1,12,'lead','a:0:{}',0,0),(7,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mobile','mobile','tel','core',NULL,0,1,1,0,1,0,0,14,'lead','a:0:{}',0,0),(8,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Phone','phone','tel','core',NULL,0,1,1,0,1,0,0,16,'lead','a:0:{}',0,0),(9,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Points','points','number','core','0',0,1,1,0,1,0,0,18,'lead','a:0:{}',0,0),(10,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fax','fax','tel','core',NULL,0,0,1,0,1,0,0,20,'lead','a:0:{}',0,0),(11,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Address Line 1','address1','text','core',NULL,0,1,1,0,1,0,0,22,'lead','a:0:{}',0,0),(12,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Address Line 2','address2','text','core',NULL,0,1,1,0,1,0,0,24,'lead','a:0:{}',0,0),(13,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'City','city','text','core',NULL,0,1,1,0,1,0,0,26,'lead','a:0:{}',0,0),(14,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'State','state','region','core',NULL,0,1,1,0,1,0,0,28,'lead','a:0:{}',0,0),(15,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Zip Code','zipcode','text','core',NULL,0,1,1,0,1,0,0,30,'lead','a:0:{}',0,0),(16,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Country','country','country','core',NULL,0,1,1,0,1,0,0,32,'lead','a:0:{}',0,0),(17,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Preferred Locale','preferred_locale','locale','core',NULL,0,1,1,0,1,0,0,33,'lead','a:0:{}',0,0),(18,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Preferred Timezone','timezone','timezone','core',NULL,0,1,1,0,1,0,0,34,'lead','a:0:{}',0,0),(19,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Date Last Active','last_active','datetime','core',NULL,0,1,1,0,1,0,0,35,'lead','a:0:{}',0,0),(20,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Attribution Date','attribution_date','datetime','core',NULL,0,1,1,0,1,0,0,36,'lead','a:0:{}',0,0),(21,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Attribution','attribution','number','core',NULL,0,1,1,0,1,0,0,37,'lead','a:2:{s:9:\"roundmode\";i:4;s:5:\"scale\";i:2;}',0,0),(22,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Website','website','url','core',NULL,0,0,1,0,1,0,0,38,'lead','a:0:{}',0,0),(23,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Facebook','facebook','text','social',NULL,0,0,1,0,1,0,0,39,'lead','a:0:{}',0,0),(24,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Foursquare','foursquare','text','social',NULL,0,0,1,0,1,0,0,40,'lead','a:0:{}',0,0),(25,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Instagram','instagram','text','social',NULL,0,0,1,0,1,0,0,41,'lead','a:0:{}',0,0),(26,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'LinkedIn','linkedin','text','social',NULL,0,0,1,0,1,0,0,42,'lead','a:0:{}',0,0),(27,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Skype','skype','text','social',NULL,0,0,1,0,1,0,0,43,'lead','a:0:{}',0,0),(28,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Twitter','twitter','text','social',NULL,0,0,1,0,1,0,0,44,'lead','a:0:{}',0,0),(29,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Address 1','companyaddress1','text','core',NULL,0,1,1,0,1,0,0,3,'company','a:0:{}',0,0),(30,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Address 2','companyaddress2','text','core',NULL,0,1,1,0,1,0,0,5,'company','a:0:{}',0,0),(31,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Company Email','companyemail','email','core',NULL,0,1,1,0,1,0,1,7,'company','a:0:{}',0,0),(32,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Phone','companyphone','tel','core',NULL,0,1,1,0,1,0,0,9,'company','a:0:{}',0,0),(33,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'City','companycity','text','core',NULL,0,1,1,0,1,0,0,11,'company','a:0:{}',0,0),(34,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'State','companystate','region','core',NULL,0,1,1,0,1,0,0,13,'company','a:0:{}',0,0),(35,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Zip Code','companyzipcode','text','core',NULL,0,1,1,0,1,0,0,15,'company','a:0:{}',0,0),(36,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Country','companycountry','country','core',NULL,0,1,1,0,1,0,0,17,'company','a:0:{}',0,0),(37,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Company Name','companyname','text','core',NULL,1,1,1,0,1,0,0,19,'company','a:0:{}',0,0),(38,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Website','companywebsite','url','core',NULL,0,1,1,0,1,0,0,21,'company','a:0:{}',0,0),(39,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Number of Employees','companynumber_of_employees','number','professional',NULL,0,0,1,0,1,0,0,23,'company','a:2:{s:9:\"roundmode\";i:4;s:5:\"scale\";i:0;}',0,0),(40,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fax','companyfax','tel','professional',NULL,0,0,1,0,1,0,0,25,'company','a:0:{}',0,0),(41,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Annual Revenue','companyannual_revenue','number','professional',NULL,0,0,1,0,1,0,0,27,'company','a:2:{s:9:\"roundmode\";i:4;s:5:\"scale\";i:2;}',0,0),(42,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Industry','companyindustry','select','professional',NULL,0,1,1,0,1,0,0,29,'company','a:1:{s:4:\"list\";a:31:{i:0;a:2:{s:5:\"label\";s:11:\"Agriculture\";s:5:\"value\";s:11:\"Agriculture\";}i:1;a:2:{s:5:\"label\";s:7:\"Apparel\";s:5:\"value\";s:7:\"Apparel\";}i:2;a:2:{s:5:\"label\";s:7:\"Banking\";s:5:\"value\";s:7:\"Banking\";}i:3;a:2:{s:5:\"label\";s:13:\"Biotechnology\";s:5:\"value\";s:13:\"Biotechnology\";}i:4;a:2:{s:5:\"label\";s:9:\"Chemicals\";s:5:\"value\";s:9:\"Chemicals\";}i:5;a:2:{s:5:\"label\";s:14:\"Communications\";s:5:\"value\";s:14:\"Communications\";}i:6;a:2:{s:5:\"label\";s:12:\"Construction\";s:5:\"value\";s:12:\"Construction\";}i:7;a:2:{s:5:\"label\";s:9:\"Education\";s:5:\"value\";s:9:\"Education\";}i:8;a:2:{s:5:\"label\";s:11:\"Electronics\";s:5:\"value\";s:11:\"Electronics\";}i:9;a:2:{s:5:\"label\";s:6:\"Energy\";s:5:\"value\";s:6:\"Energy\";}i:10;a:2:{s:5:\"label\";s:11:\"Engineering\";s:5:\"value\";s:11:\"Engineering\";}i:11;a:2:{s:5:\"label\";s:13:\"Entertainment\";s:5:\"value\";s:13:\"Entertainment\";}i:12;a:2:{s:5:\"label\";s:13:\"Environmental\";s:5:\"value\";s:13:\"Environmental\";}i:13;a:2:{s:5:\"label\";s:7:\"Finance\";s:5:\"value\";s:7:\"Finance\";}i:14;a:2:{s:5:\"label\";s:15:\"Food & Beverage\";s:5:\"value\";s:15:\"Food & Beverage\";}i:15;a:2:{s:5:\"label\";s:10:\"Government\";s:5:\"value\";s:10:\"Government\";}i:16;a:2:{s:5:\"label\";s:10:\"Healthcare\";s:5:\"value\";s:10:\"Healthcare\";}i:17;a:2:{s:5:\"label\";s:11:\"Hospitality\";s:5:\"value\";s:11:\"Hospitality\";}i:18;a:2:{s:5:\"label\";s:9:\"Insurance\";s:5:\"value\";s:9:\"Insurance\";}i:19;a:2:{s:5:\"label\";s:9:\"Machinery\";s:5:\"value\";s:9:\"Machinery\";}i:20;a:2:{s:5:\"label\";s:13:\"Manufacturing\";s:5:\"value\";s:13:\"Manufacturing\";}i:21;a:2:{s:5:\"label\";s:5:\"Media\";s:5:\"value\";s:5:\"Media\";}i:22;a:2:{s:5:\"label\";s:14:\"Not for Profit\";s:5:\"value\";s:14:\"Not for Profit\";}i:23;a:2:{s:5:\"label\";s:10:\"Recreation\";s:5:\"value\";s:10:\"Recreation\";}i:24;a:2:{s:5:\"label\";s:6:\"Retail\";s:5:\"value\";s:6:\"Retail\";}i:25;a:2:{s:5:\"label\";s:8:\"Shipping\";s:5:\"value\";s:8:\"Shipping\";}i:26;a:2:{s:5:\"label\";s:10:\"Technology\";s:5:\"value\";s:10:\"Technology\";}i:27;a:2:{s:5:\"label\";s:18:\"Telecommunications\";s:5:\"value\";s:18:\"Telecommunications\";}i:28;a:2:{s:5:\"label\";s:14:\"Transportation\";s:5:\"value\";s:14:\"Transportation\";}i:29;a:2:{s:5:\"label\";s:9:\"Utilities\";s:5:\"value\";s:9:\"Utilities\";}i:30;a:2:{s:5:\"label\";s:5:\"Other\";s:5:\"value\";s:5:\"Other\";}}}',0,0),(43,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Description','companydescription','text','professional',NULL,0,1,1,0,1,0,0,31,'company','a:0:{}',0,0),(44,1,'2022-05-13 12:28:19',1,'Alain Habegger',NULL,NULL,NULL,NULL,NULL,'Alain Habegger','rabattcode_kambly','rabattcode_kambly','text','core',NULL,0,0,1,1,1,1,0,1,'lead','a:0:{}',0,0);
/*!40000 ALTER TABLE `lead_fields` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_frequencyrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_frequencyrules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `frequency_number` smallint(6) DEFAULT NULL,
  `frequency_time` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `preferred_channel` tinyint(1) NOT NULL,
  `pause_from_date` datetime DEFAULT NULL,
  `pause_to_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AA8A57F455458D` (`lead_id`),
  KEY `channel_frequency` (`channel`),
  CONSTRAINT `FK_AA8A57F455458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_frequencyrules` WRITE;
/*!40000 ALTER TABLE `lead_frequencyrules` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_frequencyrules` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_ips_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_ips_xref` (
  `lead_id` bigint(20) unsigned NOT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`lead_id`,`ip_id`),
  KEY `IDX_9EED7E6655458D` (`lead_id`),
  KEY `IDX_9EED7E66A03F5E9F` (`ip_id`),
  CONSTRAINT `FK_9EED7E6655458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_9EED7E66A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_ips_xref` WRITE;
/*!40000 ALTER TABLE `lead_ips_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_ips_xref` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_lists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `alias` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filters` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `is_global` tinyint(1) NOT NULL,
  `is_preference_center` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6EC1522A12469DE2` (`category_id`),
  CONSTRAINT `FK_6EC1522A12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_lists` WRITE;
/*!40000 ALTER TABLE `lead_lists` DISABLE KEYS */;
INSERT INTO `lead_lists` VALUES (1,NULL,1,'2022-05-13 12:27:31',1,'Alain Habegger','2022-05-13 12:27:32',1,'Alain Habegger',NULL,NULL,'Alain Habegger','all',NULL,'all','all','a:0:{}',1,0);
/*!40000 ALTER TABLE `lead_lists` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_lists_leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_lists_leads` (
  `leadlist_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `manually_removed` tinyint(1) NOT NULL,
  `manually_added` tinyint(1) NOT NULL,
  PRIMARY KEY (`leadlist_id`,`lead_id`),
  KEY `IDX_F5F47C7CB9FC8874` (`leadlist_id`),
  KEY `IDX_F5F47C7C55458D` (`lead_id`),
  KEY `manually_removed` (`manually_removed`),
  CONSTRAINT `FK_F5F47C7C55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_F5F47C7CB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `lead_lists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_lists_leads` WRITE;
/*!40000 ALTER TABLE `lead_lists_leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_lists_leads` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_67FC6B0355458D` (`lead_id`),
  CONSTRAINT `FK_67FC6B0355458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_notes` WRITE;
/*!40000 ALTER TABLE `lead_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_notes` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_points_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_points_change_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  `type` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delta` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_949C2CCC55458D` (`lead_id`),
  KEY `IDX_949C2CCCA03F5E9F` (`ip_id`),
  KEY `point_date_added` (`date_added`),
  CONSTRAINT `FK_949C2CCC55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_949C2CCCA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_points_change_log` WRITE;
/*!40000 ALTER TABLE `lead_points_change_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_points_change_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_stages_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_stages_change_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `stage_id` int(10) unsigned DEFAULT NULL,
  `event_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_73B42EF355458D` (`lead_id`),
  KEY `IDX_73B42EF32298D193` (`stage_id`),
  CONSTRAINT `FK_73B42EF32298D193` FOREIGN KEY (`stage_id`) REFERENCES `stages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_73B42EF355458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_stages_change_log` WRITE;
/*!40000 ALTER TABLE `lead_stages_change_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_stages_change_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lead_tag_search` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_tags` WRITE;
/*!40000 ALTER TABLE `lead_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_tags` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_tags_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_tags_xref` (
  `lead_id` bigint(20) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`lead_id`,`tag_id`),
  KEY `IDX_F2E51EB655458D` (`lead_id`),
  KEY `IDX_F2E51EB6BAD26311` (`tag_id`),
  CONSTRAINT `FK_F2E51EB655458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_F2E51EB6BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `lead_tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_tags_xref` WRITE;
/*!40000 ALTER TABLE `lead_tags_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_tags_xref` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `lead_utmtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_utmtags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `query` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `referer` longtext COLLATE utf8mb4_unicode_ci,
  `remote_host` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` longtext COLLATE utf8mb4_unicode_ci,
  `user_agent` longtext COLLATE utf8mb4_unicode_ci,
  `utm_campaign` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `utm_content` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `utm_medium` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `utm_source` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `utm_term` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C51BCB8D55458D` (`lead_id`),
  CONSTRAINT `FK_C51BCB8D55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `lead_utmtags` WRITE;
/*!40000 ALTER TABLE `lead_utmtags` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_utmtags` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` int(10) unsigned DEFAULT NULL,
  `stage_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `points` int(11) NOT NULL,
  `last_active` datetime DEFAULT NULL,
  `internal` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `social_cache` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `date_identified` datetime DEFAULT NULL,
  `preferred_profile_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zipcode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timezone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferred_locale` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribution_date` datetime DEFAULT NULL COMMENT '(DC2Type:datetime)',
  `attribution` double DEFAULT NULL,
  `website` longtext COLLATE utf8mb4_unicode_ci,
  `facebook` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foursquare` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instagram` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkedin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `skype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rabattcode_kambly` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_179045527E3C61F9` (`owner_id`),
  KEY `IDX_179045522298D193` (`stage_id`),
  KEY `lead_date_added` (`date_added`),
  KEY `date_identified` (`date_identified`),
  KEY `title_search` (`title`),
  KEY `firstname_search` (`firstname`),
  KEY `lastname_search` (`lastname`),
  KEY `company_search` (`company`),
  KEY `position_search` (`position`),
  KEY `email_search` (`email`),
  KEY `mobile_search` (`mobile`),
  KEY `phone_search` (`phone`),
  KEY `points_search` (`points`),
  KEY `fax_search` (`fax`),
  KEY `address1_search` (`address1`),
  KEY `address2_search` (`address2`),
  KEY `city_search` (`city`),
  KEY `state_search` (`state`),
  KEY `zipcode_search` (`zipcode`),
  KEY `country_search` (`country`),
  KEY `preferred_locale_search` (`preferred_locale`),
  KEY `timezone_search` (`timezone`),
  KEY `last_active_search` (`last_active`),
  KEY `attribution_date_search` (`attribution_date`),
  KEY `attribution_search` (`attribution`),
  KEY `facebook_search` (`facebook`),
  KEY `foursquare_search` (`foursquare`),
  KEY `instagram_search` (`instagram`),
  KEY `linkedin_search` (`linkedin`),
  KEY `skype_search` (`skype`),
  KEY `twitter_search` (`twitter`),
  KEY `contact_attribution` (`attribution`,`attribution_date`),
  KEY `date_added_country_index` (`date_added`,`country`),
  KEY `rabattcode_kambly_search` (`rabattcode_kambly`),
  CONSTRAINT `FK_179045522298D193` FOREIGN KEY (`stage_id`) REFERENCES `stages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_179045527E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `leads` WRITE;
/*!40000 ALTER TABLE `leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `leads` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `message_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_channels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` int(10) unsigned NOT NULL,
  `channel` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `properties` json NOT NULL COMMENT '(DC2Type:json_array)',
  `is_enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `channel_index` (`message_id`,`channel`),
  KEY `IDX_FA3226A7537A1329` (`message_id`),
  KEY `channel_entity_index` (`channel`,`channel_id`),
  KEY `channel_enabled_index` (`channel`,`is_enabled`),
  CONSTRAINT `FK_FA3226A7537A1329` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `message_channels` WRITE;
/*!40000 ALTER TABLE `message_channels` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_channels` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `message_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_queue` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `channel` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel_id` int(11) NOT NULL,
  `priority` smallint(6) NOT NULL,
  `max_attempts` smallint(6) NOT NULL,
  `attempts` smallint(6) NOT NULL,
  `success` tinyint(1) NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_published` datetime DEFAULT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `last_attempt` datetime DEFAULT NULL,
  `date_sent` datetime DEFAULT NULL,
  `options` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_805B808871F7E88B` (`event_id`),
  KEY `IDX_805B808855458D` (`lead_id`),
  KEY `message_status_search` (`status`),
  KEY `message_date_sent` (`date_sent`),
  KEY `message_scheduled_date` (`scheduled_date`),
  KEY `message_priority` (`priority`),
  KEY `message_success` (`success`),
  KEY `message_channel_search` (`channel`,`channel_id`),
  CONSTRAINT `FK_805B808855458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_805B808871F7E88B` FOREIGN KEY (`event_id`) REFERENCES `campaign_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `message_queue` WRITE;
/*!40000 ALTER TABLE `message_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_queue` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DB021E9612469DE2` (`category_id`),
  KEY `date_message_added` (`date_added`),
  CONSTRAINT `FK_DB021E9612469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `monitor_post_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_post_count` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monitor_id` int(10) unsigned DEFAULT NULL,
  `post_date` date NOT NULL,
  `post_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E3AC20CA4CE1C902` (`monitor_id`),
  CONSTRAINT `FK_E3AC20CA4CE1C902` FOREIGN KEY (`monitor_id`) REFERENCES `monitoring` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `monitor_post_count` WRITE;
/*!40000 ALTER TABLE `monitor_post_count` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitor_post_count` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `lists` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `network_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revision` int(11) NOT NULL,
  `stats` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `properties` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BA4F975D12469DE2` (`category_id`),
  CONSTRAINT `FK_BA4F975D12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `monitoring` WRITE;
/*!40000 ALTER TABLE `monitoring` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitoring` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `monitoring_leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring_leads` (
  `monitor_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`monitor_id`,`lead_id`),
  KEY `IDX_45207A4A4CE1C902` (`monitor_id`),
  KEY `IDX_45207A4A55458D` (`lead_id`),
  CONSTRAINT `FK_45207A4A4CE1C902` FOREIGN KEY (`monitor_id`) REFERENCES `monitoring` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_45207A4A55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `monitoring_leads` WRITE;
/*!40000 ALTER TABLE `monitoring_leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitoring_leads` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `header` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_added` datetime NOT NULL,
  `icon_class` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6000B0D3A76ED395` (`user_id`),
  KEY `notification_read_status` (`is_read`),
  KEY `notification_type` (`type`),
  KEY `notification_user_read_status` (`is_read`,`user_id`),
  CONSTRAINT `FK_6000B0D3A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `oauth1_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth1_access_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C33AC86237FDBD6D` (`consumer_id`),
  KEY `IDX_C33AC862A76ED395` (`user_id`),
  KEY `oauth1_access_token_search` (`token`),
  CONSTRAINT `FK_C33AC86237FDBD6D` FOREIGN KEY (`consumer_id`) REFERENCES `oauth1_consumers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C33AC862A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `oauth1_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth1_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth1_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `oauth1_consumers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth1_consumers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `consumer_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `consumer_secret` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `callback` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `consumer_search` (`consumer_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `oauth1_consumers` WRITE;
/*!40000 ALTER TABLE `oauth1_consumers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth1_consumers` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `oauth1_nonces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth1_nonces` (
  `nonce` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`nonce`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `oauth1_nonces` WRITE;
/*!40000 ALTER TABLE `oauth1_nonces` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth1_nonces` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `oauth1_request_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth1_request_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `verifier` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_80F3C6EA37FDBD6D` (`consumer_id`),
  KEY `IDX_80F3C6EAA76ED395` (`user_id`),
  KEY `oauth1_request_token_search` (`token`),
  CONSTRAINT `FK_80F3C6EA37FDBD6D` FOREIGN KEY (`consumer_id`) REFERENCES `oauth1_consumers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_80F3C6EAA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `oauth1_request_tokens` WRITE;
/*!40000 ALTER TABLE `oauth1_request_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth1_request_tokens` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `oauth2_accesstokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_accesstokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  `scope` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_3A18CA5A5F37A13B` (`token`),
  KEY `IDX_3A18CA5A19EB6921` (`client_id`),
  KEY `IDX_3A18CA5AA76ED395` (`user_id`),
  KEY `oauth2_access_token_search` (`token`),
  CONSTRAINT `FK_3A18CA5A19EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_3A18CA5AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `oauth2_accesstokens` WRITE;
/*!40000 ALTER TABLE `oauth2_accesstokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_accesstokens` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `oauth2_authcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_authcodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  `scope` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect_uri` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D2B4847B5F37A13B` (`token`),
  KEY `IDX_D2B4847B19EB6921` (`client_id`),
  KEY `IDX_D2B4847BA76ED395` (`user_id`),
  CONSTRAINT `FK_D2B4847B19EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D2B4847BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `oauth2_authcodes` WRITE;
/*!40000 ALTER TABLE `oauth2_authcodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_authcodes` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `oauth2_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `random_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect_uris` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `allowed_grant_types` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `client_id_search` (`random_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `oauth2_clients` WRITE;
/*!40000 ALTER TABLE `oauth2_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_clients` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `oauth2_refreshtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_refreshtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  `scope` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_328C5B1B5F37A13B` (`token`),
  KEY `IDX_328C5B1B19EB6921` (`client_id`),
  KEY `IDX_328C5B1BA76ED395` (`user_id`),
  KEY `oauth2_refresh_token_search` (`token`),
  CONSTRAINT `FK_328C5B1B19EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_328C5B1BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `oauth2_refreshtokens` WRITE;
/*!40000 ALTER TABLE `oauth2_refreshtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_refreshtokens` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `oauth2_user_client_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_user_client_xref` (
  `client_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`client_id`,`user_id`),
  KEY `IDX_1AE3441319EB6921` (`client_id`),
  KEY `IDX_1AE34413A76ED395` (`user_id`),
  CONSTRAINT `FK_1AE3441319EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_1AE34413A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `oauth2_user_client_xref` WRITE;
/*!40000 ALTER TABLE `oauth2_user_client_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_user_client_xref` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `page_hits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_hits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(10) unsigned DEFAULT NULL,
  `redirect_id` bigint(20) unsigned DEFAULT NULL,
  `email_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  `device_id` bigint(20) unsigned DEFAULT NULL,
  `date_hit` datetime NOT NULL,
  `date_left` datetime DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isp` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` int(11) NOT NULL,
  `referer` longtext COLLATE utf8mb4_unicode_ci,
  `url` longtext COLLATE utf8mb4_unicode_ci,
  `url_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` longtext COLLATE utf8mb4_unicode_ci,
  `remote_host` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_language` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser_languages` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `tracking_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `query` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_9D4B70F1C4663E4` (`page_id`),
  KEY `IDX_9D4B70F1B42D874D` (`redirect_id`),
  KEY `IDX_9D4B70F1A832C1C9` (`email_id`),
  KEY `IDX_9D4B70F155458D` (`lead_id`),
  KEY `IDX_9D4B70F1A03F5E9F` (`ip_id`),
  KEY `IDX_9D4B70F194A4C7D4` (`device_id`),
  KEY `page_hit_tracking_search` (`tracking_id`),
  KEY `page_hit_code_search` (`code`),
  KEY `page_hit_source_search` (`source`,`source_id`),
  KEY `date_hit_left_index` (`date_hit`,`date_left`),
  KEY `page_hit_url` (`url`(128)),
  CONSTRAINT `FK_9D4B70F155458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_9D4B70F194A4C7D4` FOREIGN KEY (`device_id`) REFERENCES `lead_devices` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_9D4B70F1A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_9D4B70F1A832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_9D4B70F1B42D874D` FOREIGN KEY (`redirect_id`) REFERENCES `page_redirects` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_9D4B70F1C4663E4` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `page_hits` WRITE;
/*!40000 ALTER TABLE `page_hits` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_hits` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `page_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_redirects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect_id` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `hits` int(11) NOT NULL,
  `unique_hits` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `page_redirects` WRITE;
/*!40000 ALTER TABLE `page_redirects` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_redirects` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `translation_parent_id` int(10) unsigned DEFAULT NULL,
  `variant_parent_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `template` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_html` longtext COLLATE utf8mb4_unicode_ci,
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `hits` int(11) NOT NULL,
  `unique_hits` int(11) NOT NULL,
  `variant_hits` int(11) NOT NULL,
  `revision` int(11) NOT NULL,
  `meta_description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect_url` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_preference_center` tinyint(1) DEFAULT NULL,
  `no_index` tinyint(1) DEFAULT NULL,
  `lang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `variant_settings` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `variant_start_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2074E57512469DE2` (`category_id`),
  KEY `IDX_2074E5759091A2FB` (`translation_parent_id`),
  KEY `IDX_2074E57591861123` (`variant_parent_id`),
  KEY `page_alias_search` (`alias`),
  CONSTRAINT `FK_2074E57512469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_2074E5759091A2FB` FOREIGN KEY (`translation_parent_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2074E57591861123` FOREIGN KEY (`variant_parent_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `bundle` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bitwise` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_perm` (`bundle`,`name`,`role_id`),
  KEY `IDX_2DEDCC6FD60322AC` (`role_id`),
  CONSTRAINT `FK_2DEDCC6FD60322AC` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `plugin_citrix_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_citrix_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `product` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_desc` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D77731055458D` (`lead_id`),
  KEY `citrix_event_email` (`product`,`email`),
  KEY `citrix_event_name` (`product`,`event_name`,`event_type`),
  KEY `citrix_event_type` (`product`,`event_type`,`event_date`),
  KEY `citrix_event_product` (`product`,`email`,`event_type`),
  KEY `citrix_event_product_name` (`product`,`email`,`event_type`,`event_name`),
  KEY `citrix_event_product_name_lead` (`product`,`event_type`,`event_name`,`lead_id`),
  KEY `citrix_event_product_type_lead` (`product`,`event_type`,`lead_id`),
  KEY `citrix_event_date` (`event_date`),
  CONSTRAINT `FK_D77731055458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `plugin_citrix_events` WRITE;
/*!40000 ALTER TABLE `plugin_citrix_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin_citrix_events` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `plugin_crm_pipedrive_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_crm_pipedrive_owners` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `plugin_crm_pipedrive_owners` WRITE;
/*!40000 ALTER TABLE `plugin_crm_pipedrive_owners` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin_crm_pipedrive_owners` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `plugin_integration_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_integration_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `supported_features` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `api_keys` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `feature_settings` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_941A2CE0EC942BCF` (`plugin_id`),
  CONSTRAINT `FK_941A2CE0EC942BCF` FOREIGN KEY (`plugin_id`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `plugin_integration_settings` WRITE;
/*!40000 ALTER TABLE `plugin_integration_settings` DISABLE KEYS */;
INSERT INTO `plugin_integration_settings` VALUES (1,NULL,'OneSignal',0,'a:4:{i:0;s:6:\"mobile\";i:1;s:20:\"landing_page_enabled\";i:2;s:28:\"welcome_notification_enabled\";i:3;s:21:\"tracking_page_enabled\";}','a:0:{}','a:0:{}'),(2,NULL,'Twilio',0,'a:0:{}','a:0:{}','a:0:{}'),(3,2,'Outlook',0,'a:0:{}','a:0:{}','a:0:{}'),(4,14,'Beefree',1,'a:0:{}','a:0:{}','a:6:{s:17:\"beefree_user_name\";s:10:\"beeprotest\";s:15:\"beefree_api_key\";s:36:\"88cd9886-1221-4272-b099-159d8872d30d\";s:18:\"beefree_api_secret\";s:52:\"vlPPjwy3VcSRV2yDteYBjG0laIF0sATfzzqozPelK2GoNZnMKvX6\";s:20:\"beefree_api_key_page\";s:36:\"f1076d15-d694-4fe3-a81a-a355f9498233\";s:23:\"beefree_api_secret_page\";s:52:\"Q8CuWWYg7RQ0QnewNTkG0fxVUZxsU9ZD4cvnsU50c4HssTO7fdUD\";s:17:\"beefree_image_get\";i:0;}'),(5,4,'Clearbit',0,'a:0:{}','a:0:{}','a:0:{}'),(6,5,'GrapesJsBuilder',0,'a:0:{}','a:0:{}','a:0:{}'),(7,6,'Gmail',0,'a:0:{}','a:0:{}','a:0:{}'),(8,7,'Connectwise',0,'a:2:{i:0;s:9:\"push_lead\";i:1;s:9:\"get_leads\";}','a:0:{}','a:0:{}'),(9,7,'Dynamics',0,'a:3:{i:0;s:9:\"push_lead\";i:1;s:9:\"get_leads\";i:2;s:10:\"push_leads\";}','a:0:{}','a:0:{}'),(10,7,'Hubspot',0,'a:2:{i:0;s:9:\"push_lead\";i:1;s:9:\"get_leads\";}','a:0:{}','a:0:{}'),(11,7,'Salesforce',0,'a:3:{i:0;s:9:\"push_lead\";i:1;s:9:\"get_leads\";i:2;s:10:\"push_leads\";}','a:0:{}','a:0:{}'),(12,7,'Pipedrive',0,'a:1:{i:0;s:9:\"push_lead\";}','a:0:{}','a:0:{}'),(13,7,'Vtiger',0,'a:1:{i:0;s:9:\"push_lead\";}','a:0:{}','a:0:{}'),(14,7,'Sugarcrm',0,'a:3:{i:0;s:9:\"push_lead\";i:1;s:9:\"get_leads\";i:2;s:10:\"push_leads\";}','a:0:{}','a:0:{}'),(15,7,'Zoho',0,'a:3:{i:0;s:9:\"push_lead\";i:1;s:9:\"get_leads\";i:2;s:10:\"push_leads\";}','a:0:{}','a:0:{}'),(16,8,'FullContact',0,'a:0:{}','a:0:{}','a:0:{}'),(17,9,'AmazonS3',0,'a:1:{i:0;s:13:\"cloud_storage\";}','a:0:{}','a:0:{}'),(18,10,'Instagram',0,'a:2:{i:0;s:14:\"public_profile\";i:1;s:15:\"public_activity\";}','a:0:{}','a:0:{}'),(19,10,'Foursquare',0,'a:2:{i:0;s:14:\"public_profile\";i:1;s:15:\"public_activity\";}','a:0:{}','a:0:{}'),(20,10,'LinkedIn',0,'a:3:{i:0;s:12:\"share_button\";i:1;s:12:\"login_button\";i:2;s:14:\"public_profile\";}','a:0:{}','a:0:{}'),(21,10,'Facebook',0,'a:3:{i:0;s:12:\"share_button\";i:1;s:12:\"login_button\";i:2;s:14:\"public_profile\";}','a:0:{}','a:0:{}'),(22,10,'Twitter',0,'a:4:{i:0;s:14:\"public_profile\";i:1;s:15:\"public_activity\";i:2;s:12:\"share_button\";i:3;s:12:\"login_button\";}','a:0:{}','a:0:{}'),(23,12,'Icontact',0,'a:1:{i:0;s:9:\"push_lead\";}','a:0:{}','a:0:{}'),(24,12,'Mailchimp',0,'a:1:{i:0;s:9:\"push_lead\";}','a:0:{}','a:0:{}'),(25,12,'ConstantContact',0,'a:1:{i:0;s:9:\"push_lead\";}','a:0:{}','a:0:{}'),(26,13,'Gotowebinar',0,'a:0:{}','a:0:{}','a:0:{}'),(27,13,'Gotoassist',0,'a:0:{}','a:0:{}','a:0:{}'),(28,13,'Gototraining',0,'a:0:{}','a:0:{}','a:0:{}'),(29,13,'Gotomeeting',0,'a:0:{}','a:0:{}','a:0:{}'),(30,15,'TwigTemplates',1,'a:0:{}','a:0:{}','a:0:{}');
/*!40000 ALTER TABLE `plugin_integration_settings` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `is_missing` tinyint(1) NOT NULL,
  `bundle` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_bundle` (`bundle`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
INSERT INTO `plugins` VALUES (1,'Mautic Marketing Monkeys Contact Limiter','Allow to limit leads amount per one user',0,'MauticMarketingMonkeysContactsLimiterBundle','1.0.0','Viktor Troian'),(2,'Outlook','Enables integrations with Outlook for email tracking',0,'MauticOutlookBundle','1.0','Mautic'),(3,'Zapier Integration','Zapier lets you connect Mautic with 1100+ other apps\n---\nLearn more about Zapier integration in the <a href=\"https://mautic.org/docs/en/plugins/zapier.html\">docs</a>. Make sure Mautic API and Basic Auth is enabled in the <a href=\"config/edit\" target=\"_blank\">configuration</a>.\n<br>\n<br>\nUse these predefined Zap templates as a starting point:\n<div id=\"zaps\"></div>\n<script src=\"https://zapier.com/apps/embed/widget.js?services=mautic&html_id=zaps\"></script>',0,'MauticZapierBundle','1.0','Mautic'),(4,'Clearbit','Enables integration with Clearbit for contact and company lookup',0,'MauticClearbitBundle','1.0','Werner Garcia'),(5,'Builder','GrapesJS Builder with MJML support for Mautic',0,'GrapesJsBuilderBundle','1.0.0','Webmecanik'),(6,'Gmail','Enables integrations with Gmail for email tracking',0,'MauticGmailBundle','1.0','Mautic'),(7,'CRM','Enables integration with Mautic supported CRMs.',0,'MauticCrmBundle','1.0','Mautic'),(8,'FullContact','Enables integration with FullContact for contact and company lookup',0,'MauticFullContactBundle','1.0','Mautic'),(9,'Cloud Storage','Enables integrations with Mautic supported cloud storage services.',0,'MauticCloudStorageBundle','1.0','Mautic'),(10,'Social Media','Enables integrations with Mautic supported social media services.',0,'MauticSocialBundle','1.0','Mautic'),(11,'Mautic Focus','Drive visitor\'s focus on your website with Mautic Focus',0,'MauticFocusBundle','1.0','Mautic, Inc'),(12,'Email Marketing','Enables integration with Mautic supported email marketing services.',0,'MauticEmailMarketingBundle','1.0','Mautic'),(13,'Citrix','Enables integration with Mautic supported Citrix collaboration products.',0,'MauticCitrixBundle','1.0','Mautic'),(14,'Beefree plugin','BeeFree integration for Mautic',0,'MauticBeefreeBundle','1.0.0','Enguerr'),(15,'TwigTemplates','Twig templates for Mautic',0,'MauticTwigTemplatesBundle','1.0.0','mtcextendee.com');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `point_lead_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point_lead_action_log` (
  `point_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_fired` datetime NOT NULL,
  PRIMARY KEY (`point_id`,`lead_id`),
  KEY `IDX_6DF94A56C028CEA2` (`point_id`),
  KEY `IDX_6DF94A5655458D` (`lead_id`),
  KEY `IDX_6DF94A56A03F5E9F` (`ip_id`),
  CONSTRAINT `FK_6DF94A5655458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6DF94A56A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_6DF94A56C028CEA2` FOREIGN KEY (`point_id`) REFERENCES `points` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `point_lead_action_log` WRITE;
/*!40000 ALTER TABLE `point_lead_action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `point_lead_action_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `point_lead_event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point_lead_event_log` (
  `event_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_fired` datetime NOT NULL,
  PRIMARY KEY (`event_id`,`lead_id`),
  KEY `IDX_C2A3BDBA71F7E88B` (`event_id`),
  KEY `IDX_C2A3BDBA55458D` (`lead_id`),
  KEY `IDX_C2A3BDBAA03F5E9F` (`ip_id`),
  CONSTRAINT `FK_C2A3BDBA55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C2A3BDBA71F7E88B` FOREIGN KEY (`event_id`) REFERENCES `point_trigger_events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C2A3BDBAA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `point_lead_event_log` WRITE;
/*!40000 ALTER TABLE `point_lead_event_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `point_lead_event_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `point_trigger_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point_trigger_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `trigger_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_order` int(11) NOT NULL,
  `properties` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_D5669585FDDDCD6` (`trigger_id`),
  KEY `trigger_type_search` (`type`),
  CONSTRAINT `FK_D5669585FDDDCD6` FOREIGN KEY (`trigger_id`) REFERENCES `point_triggers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `point_trigger_events` WRITE;
/*!40000 ALTER TABLE `point_trigger_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `point_trigger_events` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `point_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point_triggers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `points` int(11) NOT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_existing_leads` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9CABD32F12469DE2` (`category_id`),
  CONSTRAINT `FK_9CABD32F12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `point_triggers` WRITE;
/*!40000 ALTER TABLE `point_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `point_triggers` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `points` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `repeatable` tinyint(1) NOT NULL,
  `delta` int(11) NOT NULL,
  `properties` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_27BA8E2912469DE2` (`category_id`),
  KEY `point_type_search` (`type`),
  CONSTRAINT `FK_27BA8E2912469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `points` WRITE;
/*!40000 ALTER TABLE `points` DISABLE KEYS */;
/*!40000 ALTER TABLE `points` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `push_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_ids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `push_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `mobile` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4F2393E855458D` (`lead_id`),
  CONSTRAINT `FK_4F2393E855458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `push_ids` WRITE;
/*!40000 ALTER TABLE `push_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_ids` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `push_notification_list_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_list_xref` (
  `notification_id` int(10) unsigned NOT NULL,
  `leadlist_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`notification_id`,`leadlist_id`),
  KEY `IDX_473919EFEF1A9D84` (`notification_id`),
  KEY `IDX_473919EFB9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_473919EFB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `lead_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_473919EFEF1A9D84` FOREIGN KEY (`notification_id`) REFERENCES `push_notifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `push_notification_list_xref` WRITE;
/*!40000 ALTER TABLE `push_notification_list_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notification_list_xref` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `push_notification_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `notification_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` int(10) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `date_read` datetime DEFAULT NULL,
  `is_clicked` tinyint(1) NOT NULL,
  `date_clicked` datetime DEFAULT NULL,
  `tracking_hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `click_count` int(11) DEFAULT NULL,
  `last_clicked` datetime DEFAULT NULL,
  `click_details` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_DE63695EEF1A9D84` (`notification_id`),
  KEY `IDX_DE63695E55458D` (`lead_id`),
  KEY `IDX_DE63695E3DAE168B` (`list_id`),
  KEY `IDX_DE63695EA03F5E9F` (`ip_id`),
  KEY `stat_notification_search` (`notification_id`,`lead_id`),
  KEY `stat_notification_clicked_search` (`is_clicked`),
  KEY `stat_notification_hash_search` (`tracking_hash`),
  KEY `stat_notification_source_search` (`source`,`source_id`),
  CONSTRAINT `FK_DE63695E3DAE168B` FOREIGN KEY (`list_id`) REFERENCES `lead_lists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DE63695E55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DE63695EA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_DE63695EEF1A9D84` FOREIGN KEY (`notification_id`) REFERENCES `push_notifications` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `push_notification_stats` WRITE;
/*!40000 ALTER TABLE `push_notification_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notification_stats` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `push_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `lang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` longtext COLLATE utf8mb4_unicode_ci,
  `heading` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `button` longtext COLLATE utf8mb4_unicode_ci,
  `utm_tags` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `notification_type` longtext COLLATE utf8mb4_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `read_count` int(11) NOT NULL,
  `sent_count` int(11) NOT NULL,
  `mobile` tinyint(1) NOT NULL,
  `mobileSettings` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_5B9B7E4F12469DE2` (`category_id`),
  CONSTRAINT `FK_5B9B7E4F12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `push_notifications` WRITE;
/*!40000 ALTER TABLE `push_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notifications` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `system` tinyint(1) NOT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `columns` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `filters` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `table_order` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `graphs` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `group_by` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `aggregators` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `settings` json DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `is_scheduled` tinyint(1) NOT NULL,
  `schedule_unit` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `schedule_day` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `schedule_month_frequency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Visits published Pages',NULL,1,'page.hits','a:7:{i:0;s:11:\"ph.date_hit\";i:1;s:6:\"ph.url\";i:2;s:12:\"ph.url_title\";i:3;s:10:\"ph.referer\";i:4;s:12:\"i.ip_address\";i:5;s:7:\"ph.city\";i:6;s:10:\"ph.country\";}','a:2:{i:0;a:3:{s:6:\"column\";s:7:\"ph.code\";s:9:\"condition\";s:2:\"eq\";s:5:\"value\";s:3:\"200\";}i:1;a:3:{s:6:\"column\";s:14:\"p.is_published\";s:9:\"condition\";s:2:\"eq\";s:5:\"value\";s:1:\"1\";}}','a:1:{i:0;a:2:{s:6:\"column\";s:11:\"ph.date_hit\";s:9:\"direction\";s:3:\"ASC\";}}','a:8:{i:0;s:35:\"mautic.page.graph.line.time.on.site\";i:1;s:27:\"mautic.page.graph.line.hits\";i:2;s:38:\"mautic.page.graph.pie.new.vs.returning\";i:3;s:31:\"mautic.page.graph.pie.languages\";i:4;s:34:\"mautic.page.graph.pie.time.on.site\";i:5;s:27:\"mautic.page.table.referrers\";i:6;s:30:\"mautic.page.table.most.visited\";i:7;s:37:\"mautic.page.table.most.visited.unique\";}','a:0:{}','a:0:{}','[]',0,NULL,NULL,NULL,NULL),(2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Downloads of all Assets',NULL,1,'asset.downloads','a:7:{i:0;s:16:\"ad.date_download\";i:1;s:7:\"a.title\";i:2;s:12:\"i.ip_address\";i:3;s:11:\"l.firstname\";i:4;s:10:\"l.lastname\";i:5;s:7:\"l.email\";i:6;s:4:\"a.id\";}','a:1:{i:0;a:3:{s:6:\"column\";s:14:\"a.is_published\";s:9:\"condition\";s:2:\"eq\";s:5:\"value\";s:1:\"1\";}}','a:1:{i:0;a:2:{s:6:\"column\";s:16:\"ad.date_download\";s:9:\"direction\";s:3:\"ASC\";}}','a:4:{i:0;s:33:\"mautic.asset.graph.line.downloads\";i:1;s:31:\"mautic.asset.graph.pie.statuses\";i:2;s:34:\"mautic.asset.table.most.downloaded\";i:3;s:32:\"mautic.asset.table.top.referrers\";}','a:0:{}','a:0:{}','[]',0,NULL,NULL,NULL,NULL),(3,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Submissions of published Forms',NULL,1,'form.submissions','a:0:{}','a:1:{i:1;a:3:{s:6:\"column\";s:14:\"f.is_published\";s:9:\"condition\";s:2:\"eq\";s:5:\"value\";s:1:\"1\";}}','a:0:{}','a:3:{i:0;s:34:\"mautic.form.graph.line.submissions\";i:1;s:32:\"mautic.form.table.most.submitted\";i:2;s:31:\"mautic.form.table.top.referrers\";}','a:0:{}','a:0:{}','[]',0,NULL,NULL,NULL,NULL),(4,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'All Emails',NULL,1,'email.stats','a:5:{i:0;s:12:\"es.date_sent\";i:1;s:12:\"es.date_read\";i:2;s:9:\"e.subject\";i:3;s:16:\"es.email_address\";i:4;s:4:\"e.id\";}','a:1:{i:0;a:3:{s:6:\"column\";s:14:\"e.is_published\";s:9:\"condition\";s:2:\"eq\";s:5:\"value\";s:1:\"1\";}}','a:1:{i:0;a:2:{s:6:\"column\";s:12:\"es.date_sent\";s:9:\"direction\";s:3:\"ASC\";}}','a:6:{i:0;s:29:\"mautic.email.graph.line.stats\";i:1;s:42:\"mautic.email.graph.pie.ignored.read.failed\";i:2;s:35:\"mautic.email.table.most.emails.read\";i:3;s:35:\"mautic.email.table.most.emails.sent\";i:4;s:43:\"mautic.email.table.most.emails.read.percent\";i:5;s:37:\"mautic.email.table.most.emails.failed\";}','a:0:{}','a:0:{}','[]',0,NULL,NULL,NULL,NULL),(5,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Leads and Points',NULL,1,'lead.pointlog','a:7:{i:0;s:13:\"lp.date_added\";i:1;s:7:\"lp.type\";i:2;s:13:\"lp.event_name\";i:3;s:11:\"l.firstname\";i:4;s:10:\"l.lastname\";i:5;s:7:\"l.email\";i:6;s:8:\"lp.delta\";}','a:0:{}','a:1:{i:0;a:2:{s:6:\"column\";s:13:\"lp.date_added\";s:9:\"direction\";s:3:\"ASC\";}}','a:6:{i:0;s:29:\"mautic.lead.graph.line.points\";i:1;s:29:\"mautic.lead.table.most.points\";i:2;s:29:\"mautic.lead.table.top.actions\";i:3;s:28:\"mautic.lead.table.top.cities\";i:4;s:31:\"mautic.lead.table.top.countries\";i:5;s:28:\"mautic.lead.table.top.events\";}','a:0:{}','a:0:{}','[]',0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `reports_schedulers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports_schedulers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `report_id` int(10) unsigned NOT NULL,
  `schedule_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C74CA6B84BD2A4C0` (`report_id`),
  CONSTRAINT `FK_C74CA6B84BD2A4C0` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `reports_schedulers` WRITE;
/*!40000 ALTER TABLE `reports_schedulers` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports_schedulers` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `is_admin` tinyint(1) NOT NULL,
  `readable_permissions` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Administrator','Full system access',1,'N;');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `saml_id_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saml_id_entry` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiryTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `saml_id_entry` WRITE;
/*!40000 ALTER TABLE `saml_id_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `saml_id_entry` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sms_message_list_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_message_list_xref` (
  `sms_id` int(10) unsigned NOT NULL,
  `leadlist_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sms_id`,`leadlist_id`),
  KEY `IDX_B032FC2EBD5C7E60` (`sms_id`),
  KEY `IDX_B032FC2EB9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_B032FC2EB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `lead_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B032FC2EBD5C7E60` FOREIGN KEY (`sms_id`) REFERENCES `sms_messages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sms_message_list_xref` WRITE;
/*!40000 ALTER TABLE `sms_message_list_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_message_list_xref` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sms_message_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_message_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sms_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` int(10) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `is_failed` tinyint(1) DEFAULT NULL,
  `tracking_hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `details` json NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `IDX_FE1BAE9BD5C7E60` (`sms_id`),
  KEY `IDX_FE1BAE955458D` (`lead_id`),
  KEY `IDX_FE1BAE93DAE168B` (`list_id`),
  KEY `IDX_FE1BAE9A03F5E9F` (`ip_id`),
  KEY `stat_sms_search` (`sms_id`,`lead_id`),
  KEY `stat_sms_hash_search` (`tracking_hash`),
  KEY `stat_sms_source_search` (`source`,`source_id`),
  KEY `stat_sms_failed_search` (`is_failed`),
  CONSTRAINT `FK_FE1BAE93DAE168B` FOREIGN KEY (`list_id`) REFERENCES `lead_lists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_FE1BAE955458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_FE1BAE9A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_FE1BAE9BD5C7E60` FOREIGN KEY (`sms_id`) REFERENCES `sms_messages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sms_message_stats` WRITE;
/*!40000 ALTER TABLE `sms_message_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_message_stats` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sms_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `lang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `sms_type` longtext COLLATE utf8mb4_unicode_ci,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `sent_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BDF43F9712469DE2` (`category_id`),
  CONSTRAINT `FK_BDF43F9712469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sms_messages` WRITE;
/*!40000 ALTER TABLE `sms_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_messages` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `stage_lead_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stage_lead_action_log` (
  `stage_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_fired` datetime NOT NULL,
  PRIMARY KEY (`stage_id`,`lead_id`),
  KEY `IDX_A506AFBE2298D193` (`stage_id`),
  KEY `IDX_A506AFBE55458D` (`lead_id`),
  KEY `IDX_A506AFBEA03F5E9F` (`ip_id`),
  CONSTRAINT `FK_A506AFBE2298D193` FOREIGN KEY (`stage_id`) REFERENCES `stages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_A506AFBE55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_A506AFBEA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `stage_lead_action_log` WRITE;
/*!40000 ALTER TABLE `stage_lead_action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `stage_lead_action_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `stages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `weight` int(11) NOT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2FA26A6412469DE2` (`category_id`),
  CONSTRAINT `FK_2FA26A6412469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `stages` WRITE;
/*!40000 ALTER TABLE `stages` DISABLE KEYS */;
/*!40000 ALTER TABLE `stages` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sync_object_field_change_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_object_field_change_report` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `integration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `object_id` bigint(20) unsigned NOT NULL,
  `object_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modified_at` datetime NOT NULL,
  `column_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_value` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_composite_key` (`object_type`,`object_id`,`column_name`),
  KEY `integration_object_composite_key` (`integration`,`object_type`,`object_id`,`column_name`),
  KEY `integration_object_type_modification_composite_key` (`integration`,`object_type`,`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sync_object_field_change_report` WRITE;
/*!40000 ALTER TABLE `sync_object_field_change_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_object_field_change_report` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sync_object_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_object_mapping` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `integration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `internal_object_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `internal_object_id` bigint(20) unsigned NOT NULL,
  `integration_object_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `integration_object_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_sync_date` datetime NOT NULL,
  `internal_storage` json NOT NULL COMMENT '(DC2Type:json_array)',
  `is_deleted` tinyint(1) NOT NULL,
  `integration_reference_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `integration_object` (`integration`,`integration_object_name`,`integration_object_id`,`integration_reference_id`),
  KEY `integration_reference` (`integration`,`integration_object_name`,`integration_reference_id`,`integration_object_id`),
  KEY `integration_last_sync_date` (`integration`,`last_sync_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sync_object_mapping` WRITE;
/*!40000 ALTER TABLE `sync_object_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_object_mapping` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `tweet_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tweet_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tweet_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `twitter_tweet_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `handle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_sent` datetime DEFAULT NULL,
  `is_failed` tinyint(1) DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `favorite_count` int(11) DEFAULT NULL,
  `retweet_count` int(11) DEFAULT NULL,
  `response_details` json DEFAULT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `IDX_CB8CBAE51041E39B` (`tweet_id`),
  KEY `IDX_CB8CBAE555458D` (`lead_id`),
  KEY `stat_tweet_search` (`tweet_id`,`lead_id`),
  KEY `stat_tweet_search2` (`lead_id`,`tweet_id`),
  KEY `stat_tweet_failed_search` (`is_failed`),
  KEY `stat_tweet_source_search` (`source`,`source_id`),
  KEY `favorite_count_index` (`favorite_count`),
  KEY `retweet_count_index` (`retweet_count`),
  KEY `tweet_date_sent` (`date_sent`),
  KEY `twitter_tweet_id_index` (`twitter_tweet_id`),
  CONSTRAINT `FK_CB8CBAE51041E39B` FOREIGN KEY (`tweet_id`) REFERENCES `tweets` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_CB8CBAE555458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tweet_stats` WRITE;
/*!40000 ALTER TABLE `tweet_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `tweet_stats` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `tweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tweets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `page_id` int(10) unsigned DEFAULT NULL,
  `asset_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `media_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media_path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sent_count` int(11) DEFAULT NULL,
  `favorite_count` int(11) DEFAULT NULL,
  `retweet_count` int(11) DEFAULT NULL,
  `lang` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AA38402512469DE2` (`category_id`),
  KEY `IDX_AA384025C4663E4` (`page_id`),
  KEY `IDX_AA3840255DA1941` (`asset_id`),
  KEY `sent_count_index` (`sent_count`),
  KEY `favorite_count_index` (`favorite_count`),
  KEY `retweet_count_index` (`retweet_count`),
  CONSTRAINT `FK_AA38402512469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_AA3840255DA1941` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_AA384025C4663E4` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tweets` WRITE;
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tweets` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `twig_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twig_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL COMMENT '(DC2Type:datetime)',
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL COMMENT '(DC2Type:datetime)',
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL COMMENT '(DC2Type:datetime)',
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `template` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E8D55E8212469DE2` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `twig_templates` WRITE;
/*!40000 ALTER TABLE `twig_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `twig_templates` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `authorizator` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` datetime DEFAULT NULL,
  `one_time_only` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CF080AB35CA2E8E5` (`secret`),
  KEY `IDX_CF080AB3A76ED395` (`user_id`),
  CONSTRAINT `FK_CF080AB3A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_tokens` WRITE;
/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
INSERT INTO `user_tokens` VALUES (1,1,'reset-password','meu4jwaba1ukfhbcvknszua1lne6tv7h2oxphcwc2vrwtwmdgm6wizwrs1undly2','2022-05-11 12:03:00',1);
/*!40000 ALTER TABLE `user_tokens` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timezone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_active` datetime DEFAULT NULL,
  `preferences` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `signature` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1483A5E9F85E0677` (`username`),
  UNIQUE KEY `UNIQ_1483A5E9E7927C74` (`email`),
  KEY `IDX_1483A5E9D60322AC` (`role_id`),
  CONSTRAINT `FK_1483A5E9D60322AC` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin','$2y$13$bfWnJILKtxzUFsVrvfhbB.Dt4ZZh4XMRIn8IVHw3eoAfWEbP0fT6C','Alain','Habegger','alain@marketingmonkeys.ch',NULL,'','','2022-06-15 15:58:38','2022-06-15 15:58:38','a:0:{}',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `video_hits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_hits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  `date_hit` datetime NOT NULL,
  `date_left` datetime DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isp` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` int(11) NOT NULL,
  `referer` longtext COLLATE utf8mb4_unicode_ci,
  `url` longtext COLLATE utf8mb4_unicode_ci,
  `user_agent` longtext COLLATE utf8mb4_unicode_ci,
  `remote_host` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_language` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser_languages` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  `channel` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `time_watched` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `query` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_1D1831F755458D` (`lead_id`),
  KEY `IDX_1D1831F7A03F5E9F` (`ip_id`),
  KEY `video_date_hit` (`date_hit`),
  KEY `video_channel_search` (`channel`,`channel_id`),
  KEY `video_guid_lead_search` (`guid`,`lead_id`),
  CONSTRAINT `FK_1D1831F755458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_1D1831F7A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `video_hits` WRITE;
/*!40000 ALTER TABLE `video_hits` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_hits` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `webhook_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `webhook_id` int(10) unsigned NOT NULL,
  `event_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7AD44E375C9BA60B` (`webhook_id`),
  CONSTRAINT `FK_7AD44E375C9BA60B` FOREIGN KEY (`webhook_id`) REFERENCES `webhooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `webhook_events` WRITE;
/*!40000 ALTER TABLE `webhook_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_events` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `webhook_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `webhook_id` int(10) unsigned NOT NULL,
  `status_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `runtime` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_45A353475C9BA60B` (`webhook_id`),
  CONSTRAINT `FK_45A353475C9BA60B` FOREIGN KEY (`webhook_id`) REFERENCES `webhooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `webhook_logs` WRITE;
/*!40000 ALTER TABLE `webhook_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_logs` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `webhook_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `webhook_id` int(10) unsigned NOT NULL,
  `event_id` int(10) unsigned NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F52D9A1A5C9BA60B` (`webhook_id`),
  KEY `IDX_F52D9A1A71F7E88B` (`event_id`),
  CONSTRAINT `FK_F52D9A1A5C9BA60B` FOREIGN KEY (`webhook_id`) REFERENCES `webhooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_F52D9A1A71F7E88B` FOREIGN KEY (`event_id`) REFERENCES `webhook_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `webhook_queue` WRITE;
/*!40000 ALTER TABLE `webhook_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_queue` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `webhook_url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `events_orderby_dir` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_998C4FDD12469DE2` (`category_id`),
  CONSTRAINT `FK_998C4FDD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `webhooks` WRITE;
/*!40000 ALTER TABLE `webhooks` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhooks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `cache_timeout` int(11) DEFAULT NULL,
  `ordering` int(11) DEFAULT NULL,
  `params` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,1,'2022-05-09 14:19:30',1,'Alain Habegger','2022-05-09 14:19:30',NULL,NULL,NULL,NULL,NULL,'Contacts Created','created.leads.in.time',100,330,NULL,0,'a:1:{s:5:\"lists\";s:21:\"identifiedVsAnonymous\";}'),(2,1,'2022-05-09 14:19:30',1,'Alain Habegger','2022-05-09 14:19:30',NULL,NULL,NULL,NULL,NULL,'Page Visits','page.hits.in.time',50,330,NULL,1,'a:1:{s:4:\"flag\";s:6:\"unique\";}'),(3,1,'2022-05-09 14:19:30',1,'Alain Habegger','2022-05-09 14:19:30',NULL,NULL,NULL,NULL,NULL,'Form Submissions','submissions.in.time',50,330,NULL,2,'a:0:{}'),(4,1,'2022-05-09 14:19:30',1,'Alain Habegger','2022-05-09 14:19:30',NULL,NULL,NULL,NULL,NULL,'Recent Activity','recent.activity',50,330,NULL,3,'a:0:{}'),(5,1,'2022-05-09 14:19:30',1,'Alain Habegger','2022-05-09 14:19:30',NULL,NULL,NULL,NULL,NULL,'Upcoming Emails','upcoming.emails',50,330,NULL,4,'a:0:{}');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!50112 SET @disable_bulk_load = IF (@is_rocksdb_supported, 'SET SESSION rocksdb_bulk_load = @old_rocksdb_bulk_load', 'SET @dummy_rocksdb_bulk_load = 0') */;
/*!50112 PREPARE s FROM @disable_bulk_load */;
/*!50112 EXECUTE s */;
/*!50112 DEALLOCATE PREPARE s */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

