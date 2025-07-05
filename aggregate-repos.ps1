# PowerShell script to aggregate multiple repos using sparse checkout

# Configuration
$targetDir = "aggregated-repo"
$repos = @(
    @{
        url = "https://github.com/owner1/repo1.git"
        branch = "main"
        sparsePaths = @("src/components", "docs")
        targetSubdir = "repo1"
    },
    @{
        url = "https://github.com/owner2/repo2.git"
        branch = "main"
        sparsePaths = @("lib", "examples")
        targetSubdir = "repo2"
    }
)

# Create target directory
if (Test-Path $targetDir) {
    Remove-Item -Recurse -Force $targetDir
}
New-Item -ItemType Directory -Path $targetDir
Set-Location $targetDir

# Initialize new git repo
git init
git config core.sparseCheckout true

# Function to add sparse checkout from a repository
function Add-SparseCheckout {
    param(
        [string]$RepoUrl,
        [string]$Branch,
        [string[]]$SparsePaths,
        [string]$TargetSubdir
    )
    
    Write-Host "Processing $RepoUrl..." -ForegroundColor Green
    
    # Add remote
    $remoteName = "remote-$TargetSubdir"
    git remote add $remoteName $RepoUrl
    
    # Configure sparse checkout for this remote
    $sparseCheckoutFile = ".git/info/sparse-checkout"
    foreach ($path in $SparsePaths) {
        "$TargetSubdir/$path" | Add-Content $sparseCheckoutFile
    }
    
    # Fetch and checkout
    git fetch $remoteName $Branch
    git checkout $remoteName/$Branch -- $TargetSubdir
}

# Process each repository
foreach ($repo in $repos) {
    # Create temporary directory for this repo
    $tempDir = "temp-$($repo.targetSubdir)"
    New-Item -ItemType Directory -Path $tempDir -Force
    Set-Location $tempDir
    
    # Clone with sparse checkout
    git clone --filter=blob:none --sparse $repo.url .
    git sparse-checkout set $repo.sparsePaths
    
    # Copy files to target structure
    Set-Location ..
    foreach ($sparsePath in $repo.sparsePaths) {
        $sourcePath = "$tempDir/$sparsePath"
        $targetPath = "$($repo.targetSubdir)/$sparsePath"
        if (Test-Path $sourcePath) {
            $targetPathDir = Split-Path $targetPath -Parent
            if (!(Test-Path $targetPathDir)) {
                New-Item -ItemType Directory -Path $targetPathDir -Force
            }
            Copy-Item -Recurse $sourcePath $targetPath
        }
    }
    
    # Clean up temp directory
    Remove-Item -Recurse -Force $tempDir
}

# Create aggregated commit
git add .
git commit -m "Initial aggregation of multiple repositories"

Write-Host "Aggregation complete! Check the '$targetDir' directory." -ForegroundColor Green
