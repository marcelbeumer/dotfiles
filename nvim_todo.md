
* Experiment with auto pair plugins, does it make a better editing experience or not?
* Experiment with diagnostics settings, to manage virtual_text better, it's very noisy now (especially errors flashing on InsertLeave) 

```
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = {
            spacing = 5,
            severity_limit = 'Warning',
        },
        update_in_insert = true,
    }
)
```
