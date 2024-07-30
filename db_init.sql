-- Create databases if they do not exist
CREATE DATABASE IF NOT EXISTS `codo-admin` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS `codo-cmdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS `codo-flow` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS `codo-kerrigan` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS `codo-agent-server` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create a user and grant privileges
CREATE USER IF NOT EXISTS 'codo'@'%' IDENTIFIED WITH mysql_native_password BY 'ss1917';
GRANT ALL PRIVILEGES ON *.* TO 'codo'@'%' WITH GRANT OPTION;

-- Flush privileges
FLUSH PRIVILEGES;

