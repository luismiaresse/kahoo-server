SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS `roda_bans` (
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `time` int(20) NOT NULL,
  `reason` varchar(255) NOT NULL,
  PRIMARY KEY (`license`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

