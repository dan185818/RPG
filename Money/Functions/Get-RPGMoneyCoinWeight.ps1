Function Get-RPGMoneyCoinWeight
{
    write-host -Object "How many Platinum Pieces?" -ForegroundColor Black -BackgroundColor white
    [int]$pp = read-host 
    Write-Host -Object "How many Gold Pieces?" -ForegroundColor Black -BackgroundColor Yellow
    [int]$gp = read-host
    write-host -object "How many Silver Pieces?" -ForegroundColor black -BackgroundColor Gray
    [int]$sp = Read-Host
    Write-host -Object "How many Copper Pieces?" -ForegroundColor Black -BackgroundColor DarkYellow
    [int]$cp = Read-Host
    
    $Weight = [int]$pp + [int]$gp + [int]$sp + [int]$cp
    $weight = $weight/50
    Write-host -Object "Coin Weight:$Weight lbs" -ForegroundColor Black -BackgroundColor Green
}