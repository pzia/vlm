#Nettoyages pour le dev
DROP TABLE IF EXISTS players_pending;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS playerstousers;

#Tables de gestion des PLAYERS
CREATE TABLE `players_pending` (
  `idplayers_pending` bigint(20) NOT NULL auto_increment,
  `email` varchar(50) NOT NULL,
  `password` varchar(64) NOT NULL,
  `playername` varchar(20) NOT NULL,
  `updated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `seed` bigint default 0,
  PRIMARY KEY  (`idplayers_pending`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='players_pending validation';

CREATE TABLE `players` (
  `idplayers` bigint(20) NOT NULL auto_increment,
  `email` varchar(50) NOT NULL, 
  `password` varchar(64) NOT NULL,
  `playername` varchar(20) NOT NULL,
  `permissions` varchar(20) NOT NULL default 'player',
  `description` text default NULL,
  `updated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`idplayers`),
  UNIQUE KEY `email` (`email`),
  KEY `email_password` (`email`,`password`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='players (not boats)';

#Tables players <-> boats
CREATE TABLE `playerstousers` (
  `idplayerstousers` bigint(20) NOT NULL auto_increment,
  `idplayers` bigint(20) NOT NULL,
  `idusers` bigint(20) NOT NULL,
  `linktype` int NOT NULL DEFAULT 1,
  `updated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`idplayerstousers`),
  UNIQUE KEY `boatsitting` (`idplayers`, `idusers`, `linktype`),
  KEY `players` (`idplayers`),
  KEY `players` (`idusers`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='link beween players and users';
