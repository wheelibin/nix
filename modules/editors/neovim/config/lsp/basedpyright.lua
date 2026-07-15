-- basedpyright LSP configuration
--
-- Two problems this solves:
--
-- 1. VENV DETECTION
--    basedpyright is installed globally via Nix and has no knowledge of the
--    project's virtualenv. Without a pythonPath it analyses against the system
--    Python and reports every private-registry package as missing.
--    We detect `.venv/bin/python` at the workspace root and inject it via
--    `before_init`, which fires after `init_params` is built but before the
--    `initialize` RPC call is sent to the server.
--    Signature: before_init(init_params, config)
--
-- 2. TYPE-CHECKING MODE
--    basedpyright defaults to "recommended" (its own strict superset of
--    pyright's "strict"), which fires heavily on third-party packages that
--    lack complete stubs. "basic" matches the original pyright default and is
--    a sensible starting point. Projects that want stricter checking can add:
--      [tool.basedpyright]
--      typeCheckingMode = "standard"
--    to their pyproject.toml (or a pyrightconfig.json at the root).

return {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },

  before_init = function(init_params, _config)
    local root = init_params.rootPath
    if not root or root == vim.NIL then
      return
    end
    local venv_python = root .. "/.venv/bin/python"
    if vim.uv.fs_stat(venv_python) then
      init_params.initializationOptions = vim.tbl_deep_extend(
        "force",
        init_params.initializationOptions or {},
        { python = { pythonPath = venv_python } }
      )
    end
  end,
}
