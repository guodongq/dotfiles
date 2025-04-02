-- Modeline and Notes
-- ====================================================================
-- ==================== READ THIS BEFORE CONTINUING ====================
-- =====================================================================
-- ========                                    .-----.          ========
-- ========         .----------------------.   | === |          ========
-- ========         |.-""""""""""""""""""-.|   |-----|          ========
-- ========         ||                    ||   | === |          ========
-- ========         ||       NeoVim       ||   |-----|          ========
-- ========         ||                    ||   | === |          ========
-- ========         ||                    ||   |-----|          ========
-- ========         ||:Tutor              ||   |:::::|          ========
-- ========         |'-..................-'|   |____o|          ========
-- ========         `"")----------------(""`   ___________      ========
-- ========        /::::::::::|  |::::::::::\  \ no mouse \     ========
-- ========       /:::========|  |==hjkl==:::\  \ required \    ========
-- ========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
-- ========                                                     ========
-- =====================================================================
-- =====================================================================

-- This is the personal neovim config file of Bruce.
-- While much of it is beneficial for general use, I would
-- recommend picking out the parts you want and understand.

-- You can find me at http://guodongq.github.io

-- Copyright 2024 Bruce

-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at

-- http://www.apache.org/licenses/LICENSE-2.0

-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- P.S. You can delete this when you're done too. It's your config now! :)

-- General
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Setting options
require("options")

-- Basic Keymaps
require("keymaps")

-- Auto commands
require("autocmds")

-- Install `lazy.nvim` plugin manager
require("lazy-bootstrap")

-- Configure and install plugins
require("lazy-plugins")
