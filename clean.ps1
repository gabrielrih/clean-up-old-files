<#
    It deletes old files on a list of folder
#>

# Delete all Files in a specific directory that are older than X day(s)
param (
    [string[]]$Pathes = $(throw "Missing parameter: Pass the path list (-Pathes)"),
    [int]$DaysBack = 60
)
# Put Daysback on negative form
$DaysBack = $DaysBack - ($DaysBack * 2)

function deleteFiles {
    param($Path, $DateToDelete)
    # Avoid accidentally delete
    if (-not($Path -Or $DateToDelete)) {
        break
    }
    try {
        Get-ChildItem "$Path" -Recurse | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item
    } catch {
        Throw "Exception:", $_.Exception.Message
    }
}

$CurrentDate = Get-Date
$DateToDelete = $CurrentDate.AddDays($DaysBack)
Write-Host("Starting deleting before", $dateToDelete.ToString("yyyy-MM-dd"))
foreach ($Path in $Pathes) {
    if (-not(Test-Path $Path)) {
        Write-Host "(-) Path $path doesn't exist."
        continue
    }
    Write-Host("(+) Deleting files on $Path")
    deleteFiles -Path $Path -DateToDelete $DateToDelete
}
Write-Host("Done.")