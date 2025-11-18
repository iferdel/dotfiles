#####################################################################
# Dotfiles Bootstrap Script for Windows PowerShell
#
# IMPORTANT: This script has a bash equivalent at:
#            bootstrap.sh
#
# When modifying this script, please update bootstrap.sh to
# maintain feature parity between platforms.
#####################################################################

# Get the dotfiles directory (where this script is located)
$DOTFILES_DIR = $PSScriptRoot

#####################################################################
# 1. Symlink Setup
#####################################################################

# Define symlink pairs: Source -> Destination
$SYMLINK_PAIRS = @(
    @{
        Src = Join-Path $DOTFILES_DIR "nvim"
        Dest = Join-Path $env:LOCALAPPDATA "nvim.iferdel.git"
    },
    @{
        Src = Join-Path $DOTFILES_DIR "git\.gitconfig"
        Dest = Join-Path $env:USERPROFILE ".gitconfig"
    },
    @{
        Src = Join-Path $DOTFILES_DIR "kitty"
        Dest = Join-Path $env:USERPROFILE ".config\kitty"
    },
    @{
        Src = Join-Path $DOTFILES_DIR "ghostty"
        Dest = Join-Path $env:USERPROFILE ".config\ghostty"
    }
)

foreach ($Pair in $SYMLINK_PAIRS) {
    $Src = $Pair.Src
    $Dest = $Pair.Dest
    $DestDir = Split-Path -Parent $Dest

    # Create destination directory if it doesn't exist
    if (-not (Test-Path $DestDir)) {
        Write-Host "Creating directory: $DestDir"
        New-Item -ItemType Directory -Path $DestDir -Force | Out-Null
    }

    # Debugging output
    Write-Host "SRC:  $Src"
    Write-Host "DEST: $Dest"

    # Check if source exists
    if (-not (Test-Path $Src)) {
        Write-Host "Error: Source '$Src' does not exist. Skipping..." -ForegroundColor Red
        continue
    }

    # Check if destination already exists
    if (Test-Path $Dest) {
        Write-Host "Warning: Destination '$Dest' already exists. Skipping..." -ForegroundColor Yellow
        continue
    }

    # Create symlink
    try {
        New-Item -ItemType SymbolicLink -Path $Dest -Target $Src -ErrorAction Stop | Out-Null
        Write-Host "Linked '$Src' -> '$Dest'" -ForegroundColor Green
    }
    catch {
        Write-Host "Error creating symlink: $_" -ForegroundColor Red
        Write-Host "Note: Symlinks require Administrator privileges or Developer Mode enabled in Windows Settings." -ForegroundColor Yellow
    }
}

#####################################################################
# 2. Copy Aliases from Dotfiles to PowerShell Profile
#####################################################################

# Note: PowerShell uses a different aliasing system than bash
# We'll convert bash aliases to PowerShell format and add to profile

$DOTFILES_ALIASES = Join-Path $DOTFILES_DIR "bash\aliases"
$POWERSHELL_PROFILE = $PROFILE.CurrentUserCurrentHost

# Ensure the dotfiles' aliases file exists
if (-not (Test-Path $DOTFILES_ALIASES)) {
    Write-Host "Dotfiles aliases file ($DOTFILES_ALIASES) does not exist. Skipping alias setup..." -ForegroundColor Yellow
}
else {
    # Ensure PowerShell profile directory exists
    $ProfileDir = Split-Path -Parent $POWERSHELL_PROFILE
    if (-not (Test-Path $ProfileDir)) {
        Write-Host "Creating PowerShell profile directory: $ProfileDir"
        New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null
    }

    # Ensure PowerShell profile exists
    if (-not (Test-Path $POWERSHELL_PROFILE)) {
        Write-Host "Creating PowerShell profile: $POWERSHELL_PROFILE"
        New-Item -ItemType File -Path $POWERSHELL_PROFILE -Force | Out-Null
    }

    # Add nvimf function to PowerShell profile
    $nvimfFunction = @"

# Dotfiles: nvimf wrapper for custom Neovim config
function nvimf {
    `$env:NVIM_APPNAME = "nvim.iferdel.git"
    & nvim @args
}
"@

    $profileContent = Get-Content $POWERSHELL_PROFILE -Raw -ErrorAction SilentlyContinue
    if ($profileContent -notmatch "function nvimf") {
        Write-Host "Adding nvimf function to PowerShell profile..."
        Add-Content -Path $POWERSHELL_PROFILE -Value $nvimfFunction
        Write-Host "nvimf function added to profile." -ForegroundColor Green
    }
    else {
        Write-Host "nvimf function already exists in PowerShell profile."
    }
}

#####################################################################
# 2b. Copy PostgreSQL Config (.psqlrc)
#####################################################################

$DOTFILES_PSQLRC = Join-Path $DOTFILES_DIR "psql\.psqlrc"
$HOME_PSQLRC = Join-Path $env:USERPROFILE ".psqlrc"

# Only copy if the source file exists
if (Test-Path $DOTFILES_PSQLRC) {
    # Check if files are different before copying
    $needsCopy = $false
    if (-not (Test-Path $HOME_PSQLRC)) {
        $needsCopy = $true
    }
    else {
        $srcHash = (Get-FileHash $DOTFILES_PSQLRC).Hash
        $destHash = (Get-FileHash $HOME_PSQLRC).Hash
        if ($srcHash -ne $destHash) {
            $needsCopy = $true
        }
    }

    if ($needsCopy) {
        Write-Host "Copying .psqlrc from $DOTFILES_PSQLRC to $HOME_PSQLRC..."
        Copy-Item -Path $DOTFILES_PSQLRC -Destination $HOME_PSQLRC -Force
        Write-Host "PostgreSQL config (.psqlrc) updated." -ForegroundColor Green
    }
    else {
        Write-Host "PostgreSQL config (.psqlrc) is already up to date."
    }
}
else {
    Write-Host "PostgreSQL config file ($DOTFILES_PSQLRC) not found. Skipping..."
}

#####################################################################
# 3. Set Git Editor to nvimf
#####################################################################

# Check if Git core.editor is already set
$gitEditor = git config --global core.editor 2>$null
if ($gitEditor) {
    Write-Host "Git core.editor is already set to: $gitEditor"
    Write-Host "Skipping Git editor configuration..."
}
else {
    # For Windows, we need to ensure nvim is in PATH or use full path
    # The nvimf function in PowerShell profile will handle NVIM_APPNAME
    # But Git needs a direct command, so we'll set it to nvim directly
    # and document that users should use nvimf in PowerShell

    Write-Host "Setting Git core.editor to nvim..."
    git config --global core.editor "nvim"
    Write-Host "Git core.editor set to nvim" -ForegroundColor Green
    Write-Host "Note: Use 'nvimf' in PowerShell to get custom config, or set NVIM_APPNAME=nvim.iferdel.git" -ForegroundColor Yellow
}

#####################################################################
# 4. Completed Setup
#####################################################################

Write-Host "`nDotfiles setup completed!" -ForegroundColor Green
Write-Host "`nIMPORTANT: Reload your PowerShell profile to apply changes:" -ForegroundColor Cyan
Write-Host "  . `$PROFILE" -ForegroundColor Cyan
Write-Host "`nIf symlinks failed, you may need to:" -ForegroundColor Yellow
Write-Host "  1. Run PowerShell as Administrator, OR" -ForegroundColor Yellow
Write-Host "  2. Enable Developer Mode in Windows Settings > Update & Security > For developers" -ForegroundColor Yellow
