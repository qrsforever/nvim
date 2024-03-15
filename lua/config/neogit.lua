local CONFIG = {}

-- table.insert(_G.ignore_filetypes, 'NeogitStatus')

function CONFIG.setup()
	local conf = {
		disable_signs = false,
		disable_hint = false,
		disable_context_highlighting = true,
		disable_commit_confirmation = false,
		auto_refresh = true,
		sort_branches = "-committerdate",
		disable_builtin_notifications = false,
		use_magit_keybindings = false,
		-- Change the default way of opening neogit
		-- kind = "vsplit",
		-- The time after which an output console is shown for slow running commands
		console_timeout = 2000,
		-- Automatically show console if a command takes more than console_timeout milliseconds
		auto_show_console = true,
		-- Persist the values of switches/options within and across sessions
		remember_settings = true,
		-- Scope persisted settings on a per-project basis
		use_per_project_settings = true,
		-- Array-like table of settings to never persist. Uses format "Filetype--cli-value"
		--   ie: `{ "NeogitCommitPopup--author", "NeogitCommitPopup--no-verify" }`
		ignored_settings = {},
		-- Change the default way of opening the commit popup
		commit_popup = {
			kind = "split",
		},
		-- Change the default way of opening the preview buffer
		preview_buffer = {
			kind = "split",
		},
		-- Change the default way of opening popups
		popup = {
			kind = "split",
		},
		-- customize displayed signs
		signs = {
			-- { CLOSED, OPENED }
			section = { "▸", "▾" },
			item = { "▸", "▾" },
			hunk = { "▸", "▾" },
		},
		integrations = {
			diffview = true,
		},
		-- Setting any section to `false` will make the section not render at all
		sections = {
			untracked = {
				folded = false,
                hidden = false,
			},
			unstaged = {
				folded = false,
                hidden = false,
			},
			staged = {
				folded = false,
                hidden = false,
			},
			stashes = {
				folded = true,
                hidden = false,
			},
			unpulled = {
				folded = true,
                hidden = false,
			},
			unmerged = {
				folded = false,
                hidden = false,
			},
			recent = {
				folded = true,
                hidden = false,
			},
		},
		-- override/add mappings
		mappings = {
			-- modify status buffer mappings
			status = {
                ["q"] = "Close",
			}
		}
	}
    local hi = vim.api.nvim_set_hl
    hi(0, "NeogitCursorLine", { link = "CursorLine" })
    hi(0, "NeogitDiffAdd", { fg = "#3E63CA", bg = "NONE" })
    hi(0, "NeogitDiffDelete", { fg = "#54929E", bg = "NONE" })
    hi(0, "NeogitDiffContext", { link = "Normal" })
    require("neogit").setup(conf)
end

return CONFIG
