local CONFIG = {}

-- Split: "" | Justify: "left" | Merge: "" | Enter modifier
-- press s or press j or press m

function CONFIG.setup()
    local conf = {
        mappings = {
            start = ',A',
            start_with_preview = ',a',
        },

---     - Press `s` to enter split Lua pattern.
---     - Press `j` to choose justification side from available ones ("left", "center", "right", "none").
---     - Press `m` to enter merge delimiter.
---     - Press `f` to enter filter Lua expression to configure which parts will be affected (like "align only first column").
---     - Press `i` to ignore some commonly unwanted split matches.
---     - Press `p` to pair neighboring parts so they be aligned together.
---     - Press `t` to trim whitespace from parts.
---     - Press `<BS>` (backspace) to delete some last pre-step.

        -- Whether to disable showing non-error feedback
        silent = false,
    }

    require('mini.align').setup(conf)
end

return CONFIG
