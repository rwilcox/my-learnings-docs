---
path: /learnings/powershell
title: 'Learnings: Powershell'
---
# Table Of Contents

<!-- toc -->

- [Basics](#basics)
- [Running code when shell starts](#running-code-when-shell-starts)
- [Help](#help)
- [Tweaking Theme](#tweaking-theme)
  * [And problems with a light mode terminal emulator](#and-problems-with-a-light-mode-terminal-emulator)
    + [Theme Tweaking](#theme-tweaking)
      - ["Any hyphen items are hard to read because it's gray on light"](#any-hyphen-items-are-hard-to-read-because-its-gray-on-light)
      - [Warnings and Errors are hard to read](#warnings-and-errors-are-hard-to-read)
      - [Getting the current colors](#getting-the-current-colors)
- [Markdown](#markdown)

<!-- tocstop -->

# Basics

    $ pwsh

# Running code when shell starts

Edit file at `$profile`, creating folders if they don't already exist.

# Help

`Get-Help CMDLET`

# Tweaking Theme

## And problems with a light mode terminal emulator

Seems by default the color output really wants you to run your terminal app with a dark theme.

Seems to tweak some items (foreground, some items on the PS read line) BUT some colors can be fundamentally just hard to read (gray) and there’s no way on PS Core to change the value of gray.

May have to just deal and use a dark terminal emulator theme.

Some hints are below but there are still problems (ie I can’t find the right place to tweak the color of even the syntax literals in the below commands)

But if you want to try...

### Theme Tweaking

#### "Any hyphen items are hard to read because it's gray on light"

`Set-PSReadLineOption -Colors @{Parameter = "Red"}`

[Source](https://stackoverflow.com/questions/44978897/powershell-hyphen-argument-color#comment95962959_44979367)

#### Warnings and Errors are hard to read

See [an article from MS on how to set these colors properly](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-powershell-1.0/ee692799(v=technet.10)?redirectedfrom=MSDN)

`Set-PSReadLineOption -Colors @{Member = "DarkBlue"} `

the word Member here IS the member

`$host.UI.RawUI.Backgroundcolor="White"  `
`$host.UI.RawUI.Foregroundcolor="Black"  `

#### Getting the current colors

`Get-PSReadLineOption`

But NOTE: this command will suffix color to everything, but you do **not** want the color prefix when you use `Set-PSReadLineOption` !!!

# Markdown

`Show-Markdown -Path filename -UseBrowser`
