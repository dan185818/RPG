Function Display-RPGMoneyPurse
{
    [cmdletbinding()]
    param([parameter(Mandatory=$true,ValueFromPipeline=$true)]$purse)
    
    Write-Host -Object "Platinum:`t$($purse.pp)" -ForegroundColor Black -BackgroundColor White
    Write-host -Object "Gold:`t`t$($Purse.gp)" -ForegroundColor black -BackgroundColor Yellow
    write-host -Object "Silver:`t`t$($Purse.SP)" -ForegroundColor Black -BackgroundColor Gray
    write-host -object "Copper:`t`t$($Purse.cp)" -ForegroundColor Black -BackgroundColor DarkYellow
    $Weight = [int]$($Purse.pp) + [int]$($Purse.gp) + [int]$($Purse.sp) + [int]$($Purse.cp)
    $weight = $weight/50
    Write-host -Object "Coin Weight:$Weight lbs" -ForegroundColor Black -BackgroundColor Green
}
