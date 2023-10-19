function whichHls()
    handle = io.popen("which haskell-language-server")
    which = handle:read("*a")
    which = which:gsub('%s+', '')
    io.close(handle)
    return which;
end

res, hls = pcall(whichHls)
if res then
    require('lspconfig').hls.setup{
        cmd = { hls, "--lsp" },
        settings = {
            haskell = {
                hlintOn = true,
            },
        },
    }
-- else
--    error(hls)
end
