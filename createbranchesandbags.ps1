# Git Branch and Tag Creator Script
# Creates 2000 branches with 2 tags each

# Configuration
$repoPath = "C:\Temp\testrepobig"  # Change this to your repo path
$baseBranch = "main"    # Change this to your base branch name
$branchPrefix = "branch-"
$tagPrefix = "tag-"

# Initialize or clear the repository directory
if (Test-Path $repoPath) {
    Remove-Item $repoPath -Recurse -Force
}
New-Item -ItemType Directory -Path $repoPath | Out-Null
Set-Location $repoPath

# Initialize git repository
git init
Write-Host "Initialized new Git repository"

# Create initial commit
$null > README.md
git add README.md
git commit -m "Initial commit"
git branch -M $baseBranch
Write-Host "Created initial commit on $baseBranch branch"

# Create 2000 branches with 2 tags each
for ($i = 1; $i -le 2000; $i++) {
    $branchName = "$branchPrefix$i"
    
    # Create and checkout new branch
    git checkout -b $branchName $baseBranch
    
    # Make a small change (optional)
    Add-Content -Path "README.md" -Value "Branch $i"
    git add README.md
    git commit -m "Commit for branch $i"
    
    # Create two tags
    git tag "$tagPrefix$i-1"
    git tag "$tagPrefix$i-2"
    
    # Progress reporting
    if ($i % 100 -eq 0) {
        Write-Host "Created branch $i of 2000 with tags"
    }
}

# Return to base branch
git checkout $baseBranch

Write-Host "Script completed successfully!"
Write-Host "Created 2000 branches with 2 tags each in $repoPath"