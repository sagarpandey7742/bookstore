/*
SQLyog Community v9.30 
MySQL - 5.6.25-log : Database - bookstore
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bookstore` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `bookstore`;

/*Table structure for table `bs_book` */

DROP TABLE IF EXISTS `bs_book`;

CREATE TABLE `bs_book` (
  `ID` bigint(20) NOT NULL,
  `name` varchar(225) DEFAULT NULL,
  `saleType` varchar(225) DEFAULT NULL,
  `description` varchar(755) DEFAULT NULL,
  `imageName` varchar(225) DEFAULT NULL,
  `pdfName` varchar(225) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `modifiedBy` varchar(225) DEFAULT NULL,
  `createdDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modifiedDatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bs_book` */

insert  into `bs_book`(`ID`,`name`,`saleType`,`description`,`imageName`,`pdfName`,`price`,`createdBy`,`modifiedBy`,`createdDatetime`,`modifiedDatetime`) values (3,'Lila Bowman','Free','dfbsdrebvewasca','cb2c7a07-8628-4e3c-b46e-160fd237b0001559300974859-Indian-Women-Beige--Red-Poly-Silk-Embroidered-Saree-80615593-1.jpg','dummy.pdf',0,'Admin@gmail.com','Admin@gmail.com','2019-08-31 17:38:14','2019-09-01 00:21:49'),(4,'AIR INDIAN','Paid','afcwevwev','MV5BOTRiYzExNWItNDk4ZS00Y2RiLTgTE@._V1_.jpg','Lipschutz, Lipson - Schaum\'s Outline of Theory and Problems of Discrete Math, 2e.pdf',1300,'Admin@gmail.com','Admin@gmail.com','2019-08-31 18:33:23','2019-08-31 18:33:23'),(5,'PHP','Paid','scsacxs','cb2c7a07-8628-4e3c-b46e-160fd237b0001559300974859-Indian-Women-Beige--Red-Poly-Silk-Embroidered-Saree-80615593-1.jpg','dummy.pdf',1500,'Admin@gmail.com','Admin@gmail.com','2019-09-01 00:26:45','2019-09-01 00:27:27'),(6,'Test','Paid','xbdfbvfv','cb2c7a07-8628-4e3c-b46e-160fd237b0001559300974859-Indian-Women-Beige--Red-Poly-Silk-Embroidered-Saree-80615593-1.jpg','dummy.pdf',1200,'Admin@gmail.com','Admin@gmail.com','2019-09-01 00:41:05','2019-09-01 00:41:05'),(7,'Tes','Free','ascas','istockphoto-809275266-612x612.jpg','dummy.pdf',0,'Admin@gmail.com','Admin@gmail.com','2019-09-01 00:45:16','2019-09-01 00:45:16');

/*Table structure for table `bs_booked` */

DROP TABLE IF EXISTS `bs_booked`;

CREATE TABLE `bs_booked` (
  `ID` bigint(20) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `bookId` bigint(20) DEFAULT NULL,
  `image` varchar(225) DEFAULT NULL,
  `pdf` varchar(225) DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `modifiedBy` varchar(225) DEFAULT NULL,
  `createdDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modifiedDatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`),
  KEY `FK_bs_booked` (`bookId`),
  KEY `userId` (`userId`),
  CONSTRAINT `FK_bs_booked` FOREIGN KEY (`bookId`) REFERENCES `bs_book` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bs_booked_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `bs_user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bs_booked` */

insert  into `bs_booked`(`ID`,`userId`,`bookId`,`image`,`pdf`,`createdBy`,`modifiedBy`,`createdDatetime`,`modifiedDatetime`) values (1,5,5,'cb2c7a07-8628-4e3c-b46e-160fd237b0001559300974859-Indian-Women-Beige--Red-Poly-Silk-Embroidered-Saree-80615593-1.jpg','dummy.pdf',NULL,NULL,'2019-09-21 12:08:09','2019-09-21 12:08:09'),(2,7,5,'cb2c7a07-8628-4e3c-b46e-160fd237b0001559300974859-Indian-Women-Beige--Red-Poly-Silk-Embroidered-Saree-80615593-1.jpg','dummy.pdf',NULL,NULL,'2019-09-21 12:11:32','2019-09-21 12:11:32'),(3,8,6,'cb2c7a07-8628-4e3c-b46e-160fd237b0001559300974859-Indian-Women-Beige--Red-Poly-Silk-Embroidered-Saree-80615593-1.jpg','dummy.pdf',NULL,NULL,'2019-09-21 12:16:16','2019-09-21 12:16:16'),(4,5,5,'cb2c7a07-8628-4e3c-b46e-160fd237b0001559300974859-Indian-Women-Beige--Red-Poly-Silk-Embroidered-Saree-80615593-1.jpg','dummy.pdf',NULL,NULL,'2019-09-29 09:03:28','2019-09-29 09:03:28');

/*Table structure for table `bs_user` */

DROP TABLE IF EXISTS `bs_user`;

CREATE TABLE `bs_user` (
  `ID` bigint(20) NOT NULL,
  `firstName` varchar(225) DEFAULT NULL,
  `lastName` varchar(225) DEFAULT NULL,
  `login` varchar(225) DEFAULT NULL,
  `password` varchar(225) DEFAULT NULL,
  `mobileNo` varchar(225) DEFAULT NULL,
  `roleId` bigint(20) DEFAULT NULL,
  `emailId` varchar(225) DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `modifiedBy` varchar(225) DEFAULT NULL,
  `createdDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modifiedDatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bs_user` */

insert  into `bs_user`(`ID`,`firstName`,`lastName`,`login`,`password`,`mobileNo`,`roleId`,`emailId`,`createdBy`,`modifiedBy`,`createdDatetime`,`modifiedDatetime`) values (1,'Admin','lastAdmin','tautumelo100@gmail.com','Tau','9545856522',1,'Admin@gmail.com',NULL,NULL,'2020-08-11 10:49:01','2019-08-25 13:13:04'),(2,'Hariom','Mukati',NULL,NULL,'9165415598',2,'Hariom@gmail.com','root','root','2019-08-31 18:33:47','2019-08-31 18:33:47'),(3,'Hello','Hello','Hello@gmail.com','123','9654565855',2,'hello85@gmail.com','root','root','2019-09-21 11:08:34','2019-09-21 11:06:36'),(4,'Gogo','gogo','GoGO@gmail.com','Gogo@123','9654565855',2,'hello86@gmail.com','root','root','2019-09-21 12:01:55','2019-09-21 12:01:55'),(5,'NewUSerq','ln','New@gmail.com','New@123','8586548585',2,'asd@gmail.com','root','root','2019-09-21 12:08:08','2019-09-21 12:08:08'),(6,'Test','Test','Test@gmail.com','Test@123','9695654565',2,'Test555@gmail.com','root','root','2019-09-21 12:10:48','2019-09-21 12:10:48'),(7,'Nice','Nice','Nice@gmail.com','Nice@123','9695654565',2,'demo552@gmail.com','root','root','2019-09-21 12:11:32','2019-09-21 12:11:32'),(8,'Hello','Hello','Hello@gmail.com','Hello@123','8586548585',2,'hello87@gmail.co','root','root','2019-09-21 12:16:16','2019-09-21 12:16:16');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
