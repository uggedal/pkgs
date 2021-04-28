local M = {}

local root = '~/src/notes/diary'
local datefmt = '%Y-%m-%d'
local headerdatefmt = '%Y-%m-%d %A'
local ext = 'md'

function get_file(dt)
	return vim.fn.expand(root .. '/' .. dt .. '.' .. ext, true)
end

function previous_day()
	local i = 1
	while i < 100 do
		local prev = get_file(os.date(datefmt, os.time() - i*24*60*60))
		local exists = io.open(prev, 'r')
		if exists ~= nil then
			io.close(exists)
			return prev
		end
		i = i + 1
	end
	return nil
end

function M.open_today()
	local today = get_file(os.date(datefmt))

	local exists = io.open(today, 'r')
	if exists ~= nil then
		io.close(exists)
	else
		local f = assert(io.open(today, 'w'))

		io.output(f)
		io.write('# ' .. os.date(headerdatefmt) .. '\n\n')
		io.write('## Tasks\n\n')

		local prev = previous_day()
		print(prev)

		if prev ~= nil then
			for line in io.lines(prev) do
				if string.find(line, '^ *[-*] %[ %]') ~= nil then
					io.write(line .. '\n')
				end
			end
		end

		io.write('\n\n## 09:00 Meeting\n\n')

		io.close(f)
	end

	vim.cmd(':edit ' .. today)
end

function M.setup()
	vim.api.nvim_set_keymap(
		'n',
		'<leader>w<leader>w',
		':lua require"diary".open_today()<CR>',
		{
			noremap = true,
			silent = true,
		}
	)
end

return M
