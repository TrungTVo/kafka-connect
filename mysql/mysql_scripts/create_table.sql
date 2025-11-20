CREATE TABLE IF NOT EXISTS `author` (
    `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each author',
    `firstName` VARCHAR(255) NOT NULL COMMENT 'First name of the author',
    `lastName` VARCHAR(255) NOT NULL COMMENT 'Last name of the author',
    `age` INT COMMENT 'Age of the author',
    `email` VARCHAR(255) NOT NULL COMMENT 'Email address of the author',
    `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when the record was created',
    `updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when the record was last updated',
    `deletedAt` TIMESTAMP NULL DEFAULT NULL COMMENT 'Timestamp when the record was soft deleted (NULL if not deleted)'
) COMMENT = 'Table to store author information';
