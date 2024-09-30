--Creating table customer_service_kpi
CREATE TABLE `customer_service_kpi` (
`customer_service_KPI_timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
`customer_service_KPI_average_waiting_time_minutes` INT NOT NULL,
`ticket_created` INT NOT NULL,
PRIMARY KEY (`customer_service_KPI_timestamp`));

-- CREATE EVN_average_customer_waiting_time_every_1_hour
CREATE EVENT EVN_average_customer_waiting_time_every_1_hour
ON
--Creating an execution after every one hour
SCHEDULE EVERY 1 HOUR
DO
--Inserting a new record in the customer_service_kpi table
INSERT INTO `customer_service_kpi`
(`customer_service_KPI_timestamp`)
--Computing the average
SELECT AVG (`customer_service_KPI_average_waiting_time_minutes`) 
FROM `customer_service_kpi`
WHERE `ticket_created` >= NOW() - INTERVAL 1 HOUR;

--Ensuring the global event scheduler is running
SET GLOBAL event_scheduler = ON;