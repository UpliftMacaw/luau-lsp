<#
    Patching submodules:
    git --no-pager diff --no-color --submodule=diff > example.patch
#>

$patches = Get-ChildItem "./patches"

Write-Host "Applying Patches..."

foreach ($patch in $patches) {
    Write-Host "  - $($patch.Name)" 
    git apply $patch.FullName --quiet
}

Write-Host "Patching Done."
