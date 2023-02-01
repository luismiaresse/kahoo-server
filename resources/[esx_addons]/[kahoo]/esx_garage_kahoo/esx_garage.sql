DROP TABLE `user_parkings`;
ALTER TABLE `owned_vehicles` ADD `model` VARCHAR(30) NULL AFTER `owner`;
ALTER TABLE `owned_vehicles` ADD `parking` VARCHAR(60) NULL AFTER `stored`;
ALTER TABLE `owned_vehicles` ADD `pound` VARCHAR(60) NULL AFTER `parking`;
ALTER TABLE `owned_vehicles` ADD `time` TIMESTAMP NOT NULL;
