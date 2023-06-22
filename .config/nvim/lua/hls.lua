function whichHls()
    handle = io.popen("which haskell-language-server")
    which = handle:read("*a")
    which = which:gsub('%s+', '')
    io.close(handle)
    return which;
end

require('lspconfig').hls.setup{
    cmd = { whichHls(), "--lsp" },
    settings = {
        haskell = {
            hlintOn = true
        }
    }
}
