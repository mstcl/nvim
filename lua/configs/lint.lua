local present, lint = pcall(require, "lint")
if not present then
    return
end

lint.linters_by_ft = {
    markdown = { "vale", "proselint" },
    tex = { "proselint", "chktex" },
    python = { "pylint" },
    cpp = { "cppcheck" },
    vim = { "vint" },
    bash = { "shellcheck" },
    sh = { "shellcheck" }
}

