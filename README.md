# neovim_conf
Llevo una puta semana de pelea con Neovim. El caso es que estoy acostumbrado ya a usar Neovim y es verdad que tiene unas posibilidades impresionantes, pero hasta ahora ha sido un dolor de huevos a la hora de instalar los plugins.

Empecé con Packer y conseguí que funcionaran, aunque nunca llegué a enterarme bien de cómo funcionaba. Además, como hay que actualizar los plugins a mano, cada vez que me acordaba de actualizar tenía que buscar en internet cómo se hacía porque se me había olvidado.

Resultado: al carajo.

También he probado Lazyvim, pero viene con tantos plugins y configuraciones por defecto que si no tienes una ingeniería informática y un par de másters no hay cristo que se entere de qué tocar para dejarlo todo más o menos a tu gusto.

Resultado: Un IDE pesado con ventanas molestas y un montón de cosas que no voy a utilizar en la puta vida.

Al final he optado por liarme la manta a la cabeza y configurar lazy.nvim a pelo, desde cero, buscando las cosas que necesito una a una para conseguir un Neovim ligero y con el que me encuentre cómodo.

Lo primero es instalar lazy.nvim siguiendo las instrucciones de su página en [github](https://github.com/folke/lazy.nvim):

- Añadimos este trozo de código al archivo `~/.config/nvim/init.lua` con su correspondiente línea `require` apuntando al archivo donde guardaremos la configuración de lazy:

```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require('config.lazy')
```
- Creamos el directorio `~/.config/nvim/lua/config`, donde vamos a guardar las configuraciones de los plugins, y dentro el archivo `lazy.lua`,donde pondremos la configuración por defecto de lazy.nvim para poder cambiarla cuando queramos:
```lua
-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
})
```
- Ahora vamos a configurar algunas variables de entorno. Creamos el archivo `~/.config/nvim/lua/config/settings.lua` y le colocamos dentro nuestras preferencias. Yo tengo esto:
```lua
vim.opt.mouse = 'a'             --Activa las funciones del ratón para poder usarlo.
vim.opt.wrap = true             --Dobla las líneas que se salen de la pantalla para que se puedan leer.
vim.opt.breakindent = true      --Aplica la misma indentación que tiene la línea a la parte doblada.
vim.opt.expandtab = false       --Si el valor es true, convierte los tabuladores en espacios.
vim.opt.number = true           --Activa la numeración de líneas.
vim.opt.relativenumber = true   --Activa los números de línea relativos.
vim.opt.ignorecase = true       --Ignora las mayúsculas en las búsquedas.
vim.opt.smartcase = true        --Ignora las mayúsculas excepto si están en el término de búsqueda.
vim.opt.hlsearch = false        --Resalta los resultados de la búsqueda anterior.
vim.opt.tabstop = 2             --Tabulado.
vim.opt.shiftwidth = 2          --Espacios que se usarán en el autoindentado.
vim.opt.showmode = false        --Quitamos el que neovim nos informe del modo en el que estamos porque ya sale en la barra inferior.
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
```
No hay que olvidar agregar el correspondiente `require('config.settings')` en el archivo `init.lua` para usar estas preferencias.
- Y llegó la hora de instalar los complementos. Para ello sólo hay que colocar los enlaces a github de los mismos en el archivo `lazy.lua` para que este se encargue de instalarlos e ir actualizándolos cuando toque.
```lua
{
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },    --El esquema de color.
	{'nvim-lualine/lualine.nvim'},  --La barrainferior.
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, --Para que vaya marcando con una línea las indentaciones.
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}, --Sirve para el resaltado de sintaxis.
	{'lewis6991/gitsigns.nvim'},    --Muestra una barra para indicar qué cambia en un archivo monitoreado con git.
	{'windwp/nvim-autopairs',   --Sirve para autocompletar comillas, corchetes, etc.
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
	}
```
Colocamos los require correspondientes en `init.lua` y creamos los archivos de configuración necesarios para que todo funcione.
Lazy se encarga de descargar e instalarlo todo.
- Ahora toca el corrector ortográfico. Este viene integrado en neovim, así que no hay que instalar ningún plugin, sólo activarlo en `settings.lua`.
Lo he configurado para que sólo se active cuando es un archivo markdown, porque si no es un tostón ver todo de rallitas rojas en los archivos de código.
```lua
vim.api.nvim_exec ([[
    augroup markdownSpell
        autocmd!
        autocmd FileType markdown setlocal spell spelllang=es
        autocmd BufRead,BufNewFile *.md setlocal spell spelllang=es
    augroup END
  ]], false)
```
Después de poner esto, te preguntará si quieres instalar los diccionarios necesarios. Aceptas y listo.

Y ya está. Con esto tengo (de momento) neovim configurado a mi flujo de trabajo.

Se pueden ver las opciones y el estado de los plugins ejecutando `:Lazy` en el prompt de neovim.


