function RunEslintProject()
    -- Clear the quickfix list
    vim.fn.setqflist({})

    -- Run ESLint and capture the output
    local handle = io.popen('yarn lint-unix')
    local eslint_output = handle:read("*a")
    handle:close()

    -- Parse the ESLint output and add it to the quickfix list
    local qf_list = {}
    for line in eslint_output:gmatch("[^\r\n]+") do
        local parts = {}
        for part in line:gmatch("[^:]+") do
            table.insert(parts, part)
        end
        if #parts >= 4 then
            local item = {
                filename = parts[1],
                lnum = tonumber(parts[2]),
                col = tonumber(parts[3]),
                text = table.concat({unpack(parts, 4)}, ":"),
                type = string.match(parts[4], "^%s*(.)")
            }
            table.insert(qf_list, item)
        end
    end
    vim.fn.setqflist(qf_list)

    -- Open the quickfix list
    vim.cmd('copen')
end

-- Create a command to run the function
vim.api.nvim_create_user_command('EslintProject', RunEslintProject, {})
