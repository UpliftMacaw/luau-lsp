if (Test-Path -PathType Container "./build") {
    Write-Host "Removing old build/ directory..."
    Remove-Item -Recurse build
}

Write-Host "Creating new build/ directory"
New-Item -ItemType Directory -Path "./build" | Out-Null

Set-Location "./build"

Write-Host "Configuring cmake"
cmake .. -DCMAKE_BUILD_TYPE=Release

Write-Host "Building project"
cmake --build . --config Release --target Luau.LanguageServer.CLI -j 3

Set-Location ..

Write-Host "Copying binary"
New-Item -ItemType Directory -Force "./editors/code/bin" | Out-Null
Copy-Item "./build/Release/luau-lsp.exe" -Destination "./editors/code/bin/server.exe"

Write-Host "Packaging extension"
Set-Location "./editors/code"
Copy-Item -Force "../../LICENSE.md" -Destination "./"
Copy-Item -Force "../../README.md" -Destination "./"
Copy-Item -Force "../../CHANGELOG.md" -Destination "./"
npx vsce package

Set-Location "../.."

Write-Host "Done :)"
