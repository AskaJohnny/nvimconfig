local M = {}

-- 定义一个处理 Java 文件的方法
function M.handle_java_file(data)
    vim.cmd("edit " .. data.fname)
    local buf_index = vim.fn.bufnr("%")
    -- 假设你的包名根目录是 "src/main/java"，移除之前的部分
    local package_path = data.fname:match(".*/src/main/java/(.*)/.*%.java")
    if package_path then
        -- 替换路径分隔符 '/' 为 '.'
        local package_name = package_path:gsub("/", ".")
        local filename_base = vim.fn.expand("%:t:r")
        local code = "package "
            .. package_name
            .. [[;

public class ]]
            .. filename_base
            .. [[ {
    public static void main(String[] args) {

    }
}
]]

        local lines = vim.split(code, "\n")
        vim.api.nvim_buf_set_lines(buf_index, 0, -1, false, lines)
    end
end

return M

