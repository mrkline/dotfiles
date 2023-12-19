function whichHls()
    handle = io.popen("which haskell-language-server")
    which = handle:read("*a")
    which = which:gsub('%s+', '')
    io.close(handle)
    return which;
end

hls = whichHls()
if hls ~= "" then
    require('lspconfig').hls.setup{
        cmd = { hls, "--lsp" },
        settings = {
            haskell = {
                hlintOn = true
            }
        }
    }
end
