<#
    It deletes old files on a list of folder
#>
param($Pathes, $Daysback)
if (-not $Pathes) {
    $Pathes = @('C:\temp',"$HOME\OneDrive - Anheuser-Busch InBev\Desktop\temp")
}
if (-not $Daysback) {
    $Daysback = "-30"
}

# Delete all Files in a specific directory that are older than X day(s)
function deleteFiles {
    param($Path, $CurrentDate, $Daysback)
    $DateToDelete = $CurrentDate.AddDays($Daysback)
    Get-ChildItem "$Path" -Recurse | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item
}

Write-Host("Starting deleting before $DateToDelete...")
foreach ($Path in $Pathes) {
    $CurrentDate = Get-Date
    if (-not(Test-Path $Path)) {
        Write-Host "(-) Path $path doesn't exist."
        continue
    }
    Write-Host("(+) Deleting files on $Path")
    deleteFiles -Path $Path -CurrentDate $CurrentDate -Daysback $Daysback
}