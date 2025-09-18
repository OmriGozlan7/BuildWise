-- CreateTable
CREATE TABLE `Project` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NULL,
    `startDate` DATETIME(3) NULL,
    `endDatePlanned` DATETIME(3) NULL,
    `endDateActual` DATETIME(3) NULL,
    `notes` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Unit` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `projectId` INTEGER NOT NULL,
    `unitCode` VARCHAR(191) NOT NULL,
    `floor` INTEGER NULL,
    `rooms` DECIMAL(65, 30) NULL,
    `areaSqm` DECIMAL(65, 30) NULL,
    `priceList` DECIMAL(65, 30) NULL,
    `status` ENUM('available', 'sold', 'on_hold') NOT NULL DEFAULT 'available',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Unit_projectId_unitCode_key`(`projectId`, `unitCode`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Buyer` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `idNumber` VARCHAR(191) NULL,
    `notes` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BuyerContract` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `buyerId` INTEGER NOT NULL,
    `unitId` INTEGER NOT NULL,
    `contractDate` DATETIME(3) NOT NULL,
    `basePrice` DECIMAL(65, 30) NOT NULL,
    `cpiBaseMonth` DATETIME(3) NOT NULL,
    `paymentTerms` VARCHAR(191) NULL,
    `status` ENUM('active', 'cancelled', 'completed') NOT NULL DEFAULT 'active',
    `versionLabel` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BuyerPayment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `contractId` INTEGER NOT NULL,
    `dueDate` DATETIME(3) NOT NULL,
    `paidDate` DATETIME(3) NULL,
    `amountNominal` DECIMAL(65, 30) NOT NULL,
    `cpiFactor` DECIMAL(65, 30) NOT NULL DEFAULT 1.0,
    `amountIndexed` DECIMAL(65, 30) NOT NULL,
    `method` ENUM('bank_transfer', 'cheque', 'cash', 'other') NOT NULL DEFAULT 'bank_transfer',
    `reference` VARCHAR(191) NULL,
    `notes` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `BuyerPayment_contractId_dueDate_idx`(`contractId`, `dueDate`),
    INDEX `BuyerPayment_paidDate_idx`(`paidDate`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Unit` ADD CONSTRAINT `Unit_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BuyerContract` ADD CONSTRAINT `BuyerContract_buyerId_fkey` FOREIGN KEY (`buyerId`) REFERENCES `Buyer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BuyerContract` ADD CONSTRAINT `BuyerContract_unitId_fkey` FOREIGN KEY (`unitId`) REFERENCES `Unit`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BuyerPayment` ADD CONSTRAINT `BuyerPayment_contractId_fkey` FOREIGN KEY (`contractId`) REFERENCES `BuyerContract`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
