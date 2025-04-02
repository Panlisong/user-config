local M = {}

M.config = {
    close_tag_window_on_jump = true,
}

-- map: tag --> line
M.tags = {}

-- tag a line
function M.TagLine(input)
    local tag = input:match("^(%S+)")
    local brief = input:match("%S+%s+(.+)") or ""
    if not tag or tag == "" then
        print("[tag-jump] plz input a tag name!")
        return
    end
    if brief == "" then
        brief = "(No description)"
    end
    local file = vim.fn.expand("%:~:.")
    local line = vim.api.nvim_win_get_cursor(0)[1]
    M.tags[tag] = { file = file, line = line, brief = brief }
end

-- jump to the line of tag
function M.TagJump(tag)
    local tag_info = M.tags[tag]
    if not tag_info then
        print("[tag-jump] no tag: " .. tag)
        return
    end

    local current_file = vim.fn.expand("%:~:.")
    if current_file ~= tag_info.file then
        vim.cmd("edit " .. vim.fn.fnameescape(tag_info.file))
    end

    if M.config.close_tag_window_on_jump and M.tag_win_id then
        pcall(vim.api.nvim_win_close, M.tag_win_id, true)
        pcall(vim.api.nvim_win_close, M.context_win_id, true)
        M.tag_win_id = nil
        M.context_win_id = nil
    end

    vim.api.nvim_win_set_cursor(0, { tag_info.line, 0 })
end

-- show all tags and corresponding context
function M.Tags()
    if vim.tbl_isempty(M.tags) then
        print("[tag-jump] Not tags Now!")
        return
    end

    if M.tag_win_id then
        pcall(vim.api.nvim_win_close, M.tag_win_id, true)
        pcall(vim.api.nvim_win_close, M.context_win_id, true)
        M.tag_win_id = nil
        M.context_win_id = nil
        return
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.7)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- left window with tags
    local tag_buf = vim.api.nvim_create_buf(false, true)
    local tag_win_opts = {
        relative = "editor",
        width = math.floor(width * 0.4),
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    }
    M.tag_win_id= vim.api.nvim_open_win(tag_buf, true, tag_win_opts)

    -- right window with text context
    local context_buf = vim.api.nvim_create_buf(false, true)
    local context_win_opts = {
        relative = "editor",
        width = math.floor(width * 0.6),
        height = height,
        row = row,
        col = col + math.ceil(width * 0.4) + 1,
        style = "minimal",
        border = "rounded",
    }
    M.context_win_id = vim.api.nvim_open_win(context_buf, true, context_win_opts)

    -- contents of left window
    local tag_lines = { "Tags:" }
    local tag_list = {}
    for tag, tag_info in pairs(M.tags) do
        table.insert(tag_list, { tag, tag_info })
    end

    table.sort(tag_list, function(a, b)
        return a[1] < b[1]
    end)

    for _, tag_data in ipairs(tag_list) do
        local tag, tag_info = tag_data[1], tag_data[2]
        table.insert(tag_lines, tag)
        table.insert(tag_lines, string.format("    %s:%d", tag_info.file, tag_info.line))
        table.insert(tag_lines, "    " .. tag_info.brief)
    end
    vim.api.nvim_buf_set_lines(tag_buf, 0, -1, false, tag_lines)

    vim.api.nvim_set_current_win(M.tag_win_id)

    vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = tag_buf,
        callback = function()
            M.UpdateContextWindow(tag_buf, context_buf)
        end,
    })
end

-- update text contents by tag
function M.UpdateContextWindow(tag_buf, context_buf)
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(tag_buf, 0, -1, false)
    local tag_name = nil

    for i = cursor_line, 1, -1 do
        local line = lines[i]
        if M.tags[line] then
            tag_name = line
            break
        end
    end

    if not tag_name then
        return
    end

    local tag_info = M.tags[tag_name]
    local file = tag_info.file
    local line = tag_info.line

    local context_lines = {}
    local file_bufnr = vim.fn.bufnr(file, true)

    if file_bufnr ~= -1 then
        context_lines = vim.api.nvim_buf_get_lines(file_bufnr, math.max(0, line - 25), line + 24 , false)
    else
        context_lines = { "[Cannot load file: " .. file .. "]" }
    end

    vim.api.nvim_buf_set_lines(context_buf, 0, -1, false, context_lines)
    vim.api.nvim_buf_add_highlight(context_buf, -1, "Visual", 24, 0, -1)
end

function M.setup()
    vim.api.nvim_create_user_command("TagLine", function(opts)
        M.TagLine(opts.args)
    end, { nargs = 1 })
    vim.api.nvim_create_user_command("TagJump", function(opts)
        M.TagJump(opts.args)
    end, { nargs = 1 })
    vim.api.nvim_create_user_command("Tags", function()
        M.Tags()
    end, {})
end

return M
