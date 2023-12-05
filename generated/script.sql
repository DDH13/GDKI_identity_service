-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS `IdentityRequest`;
DROP TABLE IF EXISTS `GramaDivision`;

CREATE TABLE `GramaDivision` (
	`id` VARCHAR(191) NOT NULL,
	`province` VARCHAR(191) NOT NULL,
	`district` VARCHAR(191) NOT NULL,
	`DS_division` VARCHAR(191) NOT NULL,
	`GN_division` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `IdentityRequest` (
	`id` VARCHAR(191) NOT NULL,
	`initials_fullname` VARCHAR(191) NOT NULL,
	`fullname` VARCHAR(191) NOT NULL,
	`NIC` VARCHAR(191) NOT NULL,
	`gender` VARCHAR(191) NOT NULL,
	`contact_num` VARCHAR(191) NOT NULL,
	`email` VARCHAR(191) NOT NULL,
	`address` VARCHAR(191) NOT NULL,
	`DOB` TIMESTAMP NOT NULL,
	`applied_date` TIMESTAMP NOT NULL,
	`approved_date` TIMESTAMP,
	`approved_by` VARCHAR(191) NOT NULL,
	`status` VARCHAR(191) NOT NULL,
	`grama_divisionId` VARCHAR(191) NOT NULL,
	FOREIGN KEY(`grama_divisionId`) REFERENCES `GramaDivision`(`id`),
	PRIMARY KEY(`id`)
);
