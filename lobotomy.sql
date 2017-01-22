/*
SQLyog Community v11.31 (32 bit)
MySQL - 5.6.28-0ubuntu0.15.04.1 : Database - lobotomy
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`lobotomy` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `lobotomy`;

/*Table structure for table `aliases` */

DROP TABLE IF EXISTS `aliases`;

CREATE TABLE `aliases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(40) COLLATE utf8mb4_bin DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `alias` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniek` (`type`,`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

/*Data for the table `aliases` */

/*Table structure for table `attempts` */

DROP TABLE IF EXISTS `attempts`;

CREATE TABLE `attempts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(39) NOT NULL,
  `count` int(11) NOT NULL,
  `expiredate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `attempts` */

/*Table structure for table `cases` */

DROP TABLE IF EXISTS `cases`;

CREATE TABLE `cases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `creator` varchar(255) COLLATE utf8_bin NOT NULL,
  `added` datetime NOT NULL,
  `ownerid` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `cases` */

/*insert  into `cases`(`id`,`name`,`description`,`creator`,`added`,`ownerid`) values (1,'Lobotomy','Lobotomy','0','2016-07-23 12:37:02',0);*/

/*Table structure for table `cases_acl` */

DROP TABLE IF EXISTS `cases_acl`;

CREATE TABLE `cases_acl` (
  `caseid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `rw` enum('r','w') COLLATE utf8mb4_bin DEFAULT 'r',
  PRIMARY KEY (`caseid`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

/*Data for the table `cases_acl` */


/*Table structure for table `config` */

DROP TABLE IF EXISTS `config`;

CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `setting` varchar(100) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `config` */

insert  into `config`(`id`,`setting`,`value`) values (1,'site_name','Lobotomy'),(3,'site_email','no-reply@lobotomy.nl'),(4,'cookie_name','authID'),(5,'cookie_path','/'),(6,'cookie_domain',NULL),(7,'cookie_secure','0'),(8,'cookie_http','0'),(10,'cookie_remember','+1 month'),(11,'cookie_forget','+30 minutes'),(12,'bcrypt_cost','10'),(13,'table_attempts','attempts'),(14,'table_requests','requests'),(15,'table_sessions','sessions'),(16,'table_users','users'),(17,'site_timezone','Europe/Amsterdam'),(18,'site_activation_page','activate.php'),(19,'site_password_reset_page','reset'),(20,'site_key','bla');

/*Table structure for table `dumps` */

DROP TABLE IF EXISTS `dumps`;

CREATE TABLE `dumps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) COLLATE utf8_bin NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL,
  `added` datetime NOT NULL,
  `case_assigned` int(11) NOT NULL DEFAULT '7',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `dumps` */



/*Table structure for table `good_hashes` */

DROP TABLE IF EXISTS `good_hashes`;

CREATE TABLE `good_hashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `md5hash` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `added` datetime DEFAULT NULL,
  `comment` text COLLATE utf8_bin,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashes` (`md5hash`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `good_hashes` */

/*Table structure for table `ioc` */

DROP TABLE IF EXISTS `ioc`;

CREATE TABLE `ioc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iocid` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `short_description` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `description` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL,
  `keywords` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `authored_by` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `authored_date` datetime DEFAULT NULL,
  `links` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

/*Data for the table `ioc` */



/*Table structure for table `ioc_definitions` */

DROP TABLE IF EXISTS `ioc_definitions`;

CREATE TABLE `ioc_definitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iocid` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `Indicator_operator` varchar(8) COLLATE utf8mb4_bin DEFAULT NULL,
  `Indicator_id` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `IndicatorItem_id` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `condition` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `Context_document` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `search` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `type` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `Content_type` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

/*Data for the table `ioc_definitions` */

/*Table structure for table `queue` */

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `command` varchar(255) COLLATE utf8_bin NOT NULL,
  `priority` int(11) NOT NULL DEFAULT '3',
  `added` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `queue` */

/*Table structure for table `queue_archive` */

DROP TABLE IF EXISTS `queue_archive`;

CREATE TABLE `queue_archive` (
  `id` int(11) NOT NULL,
  `command` varchar(255) COLLATE utf8_bin NOT NULL,
  `priority` int(11) NOT NULL DEFAULT '3',
  `added` datetime NOT NULL,
  `finished` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `queue_archive` */

/*Table structure for table `requests` */

DROP TABLE IF EXISTS `requests`;

CREATE TABLE `requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `rkey` varchar(20) NOT NULL,
  `expire` datetime NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*Data for the table `requests` */



/*Table structure for table `requirements` */

DROP TABLE IF EXISTS `requirements`;

CREATE TABLE `requirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `packet` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `omschrijving` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `command` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `requirements` */


/*Table structure for table `selection` */

DROP TABLE IF EXISTS `selection`;

CREATE TABLE `selection` (
  `userid` int(11) NOT NULL,
  `caseid` int(11) DEFAULT '0',
  `imageid` int(11) DEFAULT '0',
  `pluginname` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  UNIQUE KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

/*Data for the table `selection` */




/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `hash` varchar(40) NOT NULL,
  `expiredate` datetime NOT NULL,
  `ip` varchar(39) NOT NULL,
  `agent` varchar(200) NOT NULL,
  `cookie_crc` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*Data for the table `sessions` */

/*Data for the table `bad_hashes` */

DROP TABLE IF EXISTS `bad_hashes`;

create table `bad_hashes` (
	`id` int (11),
	`md5hash` varchar (96),
	`added` datetime ,
	`comment` blob ,
	`case` int (11)
); 

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `salt` varchar(120) DEFAULT NULL,
  `isactive` tinyint(1) NOT NULL DEFAULT '0',
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*Data for the table `users` */

insert  into `users`(`id`,`email`,`password`,`salt`,`isactive`,`dt`) values (1,'guest@lobotomy.local','$2y$10$V/dpUFqbO4nO/1aypQceAuv8HNQ2cziAKHZo8PJUj.moEx2d1xQjC',NULL,1,'2016-12-12 00:00:00');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
