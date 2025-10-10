function Dos2Unix
{
    param ($Path)
    Get-ChildItem -File -Recurse -Path $Path | ForEach-Object {
        Write-Host "Converting DOS to UNIX: $($_.Fullname)"
        [IO.File]::WriteAllText($_.Fullname, $([IO.File]::ReadAllText($_.Fullname) -replace "`r", ""))
    }
}

Dos2Unix -Path ".\build"

# Build the image
docker build -t act-utils:test .\build

# Tag the image
docker tag act-utils:test grayfrost/act-utils:test

# Push the image
docker push grayfrost/act-utils:test