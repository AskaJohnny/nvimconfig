-- db_config.lua
local configs = {
    blogs_new_db = {
        driver = 'mysql',
        dataSourceName = 'root:root123456@tcp(127.0.0.1:3306)/blogs_new',
    },
    ems_dev_db = {
        driver = 'mysql',
        dataSourceName = 'root:123@abcd@tcp(nginx.dev.weiheng-tech.com:30175)/cloud',
    },
}

return configs

