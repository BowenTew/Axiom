-- ============================================================================
-- 发行版更新管理
-- 提供版本冻结、更新、回滚等功能
-- ============================================================================

local M = {}

local config = {
  snapshot_file = "lazy_snapshot.lua",
  backup_dir = vim.fn.stdpath("cache") .. "/aeonvim_backups",
}

-- 确保备份目录存在
local function ensure_backup_dir()
  if vim.fn.isdirectory(config.backup_dir) == 0 then
    vim.fn.mkdir(config.backup_dir, "p")
  end
end

-- 获取配置目录
local function get_config_dir()
  return vim.fn.stdpath("config")
end

-- 获取快照文件路径
local function get_snapshot_path()
  return get_config_dir() .. "/lua/" .. config.snapshot_file
end

--- 读取当前 lazy-lock.json 并生成快照
function M.freeze_plugin_versions()
  local lockfile = vim.fn.stdpath("cache") .. "/lazy-lock.json"
  
  if vim.fn.filereadable(lockfile) == 0 then
    vim.notify("No lazy-lock.json found. Run :Lazy sync first.", vim.log.levels.ERROR)
    return
  end
  
  local content = vim.fn.readfile(lockfile)
  local ok, lock = pcall(vim.json.decode, table.concat(content, "\n"))
  
  if not ok then
    vim.notify("Failed to parse lazy-lock.json", vim.log.levels.ERROR)
    return
  end
  
  -- 生成快照内容
  local lines = {
    "-- ============================================================================",
    "-- 插件版本快照",
    "-- 生成时间: " .. os.date("%Y-%m-%d %H:%M:%S"),
    "-- 由 :DistroFreezePluginVersions 命令生成",
    "-- ============================================================================",
    "",
    "return {",
  }
  
  -- 按名称排序
  local sorted_plugins = {}
  for name, info in pairs(lock) do
    table.insert(sorted_plugins, { name = name, info = info })
  end
  table.sort(sorted_plugins, function(a, b) return a.name < b.name end)
  
  for _, plugin in ipairs(sorted_plugins) do
    local line = string.format('  { "%s", commit = "%s" },', 
      plugin.name, 
      plugin.info.commit or "unknown"
    )
    table.insert(lines, line)
  end
  
  table.insert(lines, "}")
  
  -- 备份旧快照
  ensure_backup_dir()
  local snapshot_path = get_snapshot_path()
  if vim.fn.filereadable(snapshot_path) == 1 then
    local backup_name = config.backup_dir .. "/lazy_snapshot_" .. os.date("%Y%m%d_%H%M%S") .. ".lua"
    vim.fn.copy(snapshot_path, backup_name)
  end
  
  -- 写入新快照
  vim.fn.writefile(lines, snapshot_path)
  vim.notify("Plugin versions frozen to " .. config.snapshot_file, vim.log.levels.INFO)
end

--- 更新发行版（git pull）
function M.update()
  local config_dir = get_config_dir()
  
  -- 检查是否是 git 仓库
  local git_dir = config_dir .. "/.git"
  if vim.fn.isdirectory(git_dir) == 0 then
    vim.notify("Not a git repository. Cannot update.", vim.log.levels.ERROR)
    return
  end
  
  -- 创建备份
  ensure_backup_dir()
  local backup_file = config.backup_dir .. "/pre_update_" .. os.date("%Y%m%d_%H%M%S") .. ".tar.gz"
  
  vim.notify("Creating backup...", vim.log.levels.INFO)
  vim.fn.system({
    "tar", "-czf", backup_file,
    "-C", config_dir,
    "--exclude=.git",
    "."
  })
  
  -- 执行 git pull
  vim.notify("Updating AeonVim...", vim.log.levels.INFO)
  local output = vim.fn.system({ "git", "-C", config_dir, "pull", "origin" })
  
  if vim.v.shell_error ~= 0 then
    vim.notify("Update failed:\n" .. output, vim.log.levels.ERROR)
    return
  end
  
  vim.notify("AeonVim updated successfully!\nPlease restart Neovim.", vim.log.levels.INFO)
  vim.notify("Backup saved to: " .. backup_file, vim.log.levels.INFO)
end

--- 回滚到上次更新前
function M.revert()
  -- 查找最新的备份
  local backups = vim.fn.glob(config.backup_dir .. "/pre_update_*.tar.gz", false, true)
  
  if #backups == 0 then
    vim.notify("No backup found to revert to.", vim.log.levels.ERROR)
    return
  end
  
  table.sort(backups)
  local latest_backup = backups[#backups]
  
  local config_dir = get_config_dir()
  
  vim.notify("Reverting from: " .. vim.fn.fnamemodify(latest_backup, ":t"), vim.log.levels.WARN)
  
  -- 解压备份
  local output = vim.fn.system({
    "tar", "-xzf", latest_backup,
    "-C", config_dir
  })
  
  if vim.v.shell_error ~= 0 then
    vim.notify("Revert failed:\n" .. output, vim.log.levels.ERROR)
    return
  end
  
  vim.notify("AeonVim reverted successfully!\nPlease restart Neovim.", vim.log.levels.INFO)
end

--- 读取当前版本信息
function M.read_version()
  local version = AeonVim and AeonVim.version or "unknown"
  vim.notify("AeonVim version: " .. version, vim.log.levels.INFO)
  
  -- 检查更新通道
  local channel = "stable"
  local snapshot_exists = vim.fn.filereadable(get_snapshot_path()) == 1
  if not snapshot_exists then
    channel = "nightly (no snapshot)"
  end
  vim.notify("Update channel: " .. channel, vim.log.levels.INFO)
  
  -- 显示快照信息
  if snapshot_exists then
    local stat = vim.uv.fs_stat(get_snapshot_path())
    if stat then
      vim.notify("Snapshot last modified: " .. os.date("%Y-%m-%d %H:%M:%S", stat.mtime.sec), vim.log.levels.INFO)
    end
  end
end

--- 读取更新日志
function M.read_changelog()
  local config_dir = get_config_dir()
  local changelog = config_dir .. "/CHANGELOG.md"
  
  if vim.fn.filereadable(changelog) == 0 then
    vim.notify("No CHANGELOG.md found.", vim.log.levels.WARN)
    return
  end
  
  vim.cmd("edit " .. changelog)
end

-- 注册命令
vim.api.nvim_create_user_command("DistroFreezePluginVersions", function()
  M.freeze_plugin_versions()
end, { desc = "Freeze current plugin versions to lazy_snapshot.lua" })

vim.api.nvim_create_user_command("DistroUpdate", function()
  M.update()
end, { desc = "Update AeonVim from git origin" })

vim.api.nvim_create_user_command("DistroUpdateRevert", function()
  M.revert()
end, { desc = "Revert last DistroUpdate" })

vim.api.nvim_create_user_command("DistroReadVersion", function()
  M.read_version()
end, { desc = "Read current AeonVim version" })

vim.api.nvim_create_user_command("DistroReadChangelog", function()
  M.read_changelog()
end, { desc = "Read AeonVim changelog" })

-- 快捷键
vim.keymap.set("n", "<leader>pU", "<cmd>DistroUpdate<CR>", { desc = "Distro update" })
vim.keymap.set("n", "<leader>pR", "<cmd>DistroUpdateRevert<CR>", { desc = "Distro revert" })
vim.keymap.set("n", "<leader>pF", "<cmd>DistroFreezePluginVersions<CR>", { desc = "Freeze plugin versions" })
vim.keymap.set("n", "<leader>pV", "<cmd>DistroReadVersion<CR>", { desc = "Read distro version" })

return M
