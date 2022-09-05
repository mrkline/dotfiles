require('lspconfig').hls.setup{
    on_attach = on_attach,
    settings = {
        haskell = {
            hlintOn = true
        }
    }
}
