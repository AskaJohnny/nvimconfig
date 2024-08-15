local api = vim.api
local fn = vim.fn

-- 自定义函数插入模板
local function insert_java_template()
    local buf = api.nvim_get_current_buf()
    local file_name = api.nvim_buf_get_name(buf)

    -- 检查是否是 Java 文件
    if file_name:match("%.java$") then
        local template_file = fn.expand("~/.config/nvim/ftpplugin/templates/JavaTemplate.java")
        local template_content = fn.readfile(template_file)
        local class_name = fn.expand("%:t:r") -- 获取文件名作为类名
        local package_name = "default.package" -- 你可以根据需要设置或自动获取 package 名称

        -- 替换模板中的占位符
        template_content = vim.fn.join(
            vim.fn.map(template_content, function(line)
                line = line:gsub("${1:package_name}", package_name)
                line = line:gsub("${2:ClassName}", class_name)
                return line
            end),
            "\n"
        )
        api.nvim_buf_set_lines(buf, 0, -1, false, template_content)
    end
end

-- 注册自动命令
api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.java",
    callback = insert_java_template,
})
