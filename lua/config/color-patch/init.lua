-- Yanky WIP to change highlight colors


local M = {}

M.setup_colors = function(highlights)
    for higroup, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, higroup, settings)
    end
end

M.parse_colors = function(hiopts)
    local parsed = {}

    for higroup, settings in pairs(hiopts) do
        parsed[higroup] = settings

        for k, v in pairs(settings) do
            if type(v) == "string" and v:sub(1, 1) == '$' and M.custom_colors[v:sub(2)] ~= nil then
                parsed[higroup][k] = M.custom_colors[v:sub(2)]
            end
        end
    end

    return hiopts
end

M.add_syntax = function(hl_group, match, synargs)
    if synargs == nil then
        synargs = ""
    end
    local command = string.format("syn match %s /%s/ %s", hl_group, match, synargs)

    vim.cmd(command)
end

M.custom_colors = {
    ["background"] = "#180B12",
    ["orange"] = "#CD9432",
}

M.setup_colors(M.parse_colors({
    -- ["Normal"] = { bg = "$background" },
    -- ["NormalNC"] = { bg = "$background" },
    -- ["EndOfBuffer"] = { bg = "$background" },

    ["TrailingSpace"]      = { fg = "#FF0000", strikethrough = true },
    ["SectionMarkings"]    = { bg = "#D8E0F3", fg = "BLACK" },
    ["DocumentationKey"]   = { fg = "#A9898F", italic = true },
    ["DocumentationValue"] = { fg = "#898FA9", italic = true, blend = 20 },

    ["LspReferenceText"]   = { underline = true, bg = "BLACK" },
    ["LspReferenceRead"]   = { underline = true, bg = "BLACK" },
    ["LspReferenceWrite"]  = { underline = true, bg = "BLACK" },

    ["SpellBad"]           = { fg = "#DDAAAA", underline = true },
}))

M.on_yank = function() pcall(vim.highlight.on_yank) end

vim.api.nvim_create_autocmd("TextYankPost", { callback = M.on_yank })

vim.api.nvim_create_augroup("HighlightSetup", { clear = true }) -- @JSD
-- vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
--     group = "HighlightSetup",
--     callback = function(args)
--         if pcall(vim.api.nvim_buf_get_var, args.buf, "HighlightSet") then return end
--
--         M.add_syntax("TrailingSpace", [[\s\+$]], "containedin=ALL, contained")
--         -- M.add_syntax("SectionMarkings", [[\(-\{3}\)\@<=[^-]\+\(-\{3}\)\@=]], "containedin=ALL, contained")
--         -- M.add_syntax("DocumentationKey", [[@[^ ]\+]], "containedin=Comment,cComment, contained")
--         -- M.add_syntax("DocumentationValue", [[\(@[^ ]\+\)\@<=.\+]], "containedin=Comment,cComment, contained")
--     end,
-- })
