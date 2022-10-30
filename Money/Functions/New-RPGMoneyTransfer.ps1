Function New-RPGMoneyTransfer
{
    [cmdletbinding()]
    param()
    Write-Host -Object "A new transfer is being created.  Use Positive Numbers"
    Write-Host -Object "From Which Account: PC, PCBank, PartyFund, Tax" -ForegroundColor Black -BackgroundColor Green
    [string]$FromAccount = Read-Host
    Write-Host -Object "To Which Account: PC, PCBank, PartyFund, Tax" -ForegroundColor Black -BackgroundColor Green
    [string]$ToAccount = Read-Host
    Write-Host -Object "Note:"
    [string]$note = Read-Host
    write-host -Object "How many Platinum Pieces?" -ForegroundColor Black -BackgroundColor white
    [int]$pp = read-host 
    Write-Host -Object "How many Gold Pieces?" -ForegroundColor Black -BackgroundColor Yellow
    [int]$gp = read-host
    write-host -object "How many Silver Pieces?" -ForegroundColor black -BackgroundColor Gray
    [int]$sp = Read-Host
    Write-host -Object "How many Copper Pieces?" -ForegroundColor Black -BackgroundColor DarkYellow
    [int]$cp = Read-Host

    $FromMoney = New-Object -TypeName psobject
    $FromMoney | Add-Member -MemberType NoteProperty -Name PP -Value "-$pp"
    $FromMoney | Add-Member -MemberType NoteProperty -Name GP -Value "-$gp"
    $FromMoney | Add-Member -MemberType NoteProperty -Name SP -Value "-$sp"
    $FromMoney | Add-Member -MemberType NoteProperty -Name CP -Value "-$cp"
    $FromMoney | Add-Member -MemberType NoteProperty -Name Account -Value $FromAccount
    $FromMoney | Add-Member -MemberType NoteProperty -Name Note -Value $note
    
    $ToMoney = New-Object -TypeName psobject
    $ToMoney | Add-Member -MemberType NoteProperty -Name PP -Value $pp
    $ToMoney | Add-Member -MemberType NoteProperty -Name GP -Value $gp
    $ToMoney | Add-Member -MemberType NoteProperty -Name SP -Value $sp
    $ToMoney | Add-Member -MemberType NoteProperty -Name CP -Value $cp
    $ToMoney | Add-Member -MemberType NoteProperty -Name Account -Value $ToAccount
    $ToMoney | Add-Member -MemberType NoteProperty -Name Note -Value $note
    
    #display balances
    Write-host -Object "`nOld Balance of $FromAccount" -ForegroundColor Green -BackgroundColor Black
    Get-Balance -BalanceName $FromAccount
    Write-host -Object "Old Balance of $ToAccount" -ForegroundColor Green -BackgroundColor Black
    Get-Balance -BalanceName $ToAccount

    #subtract from From Account
    Write-host -Object "`nNew Balance of $FromAccount" -ForegroundColor Green -BackgroundColor Black
    Write-Transaction -Transaction $Frommoney

    #add to To Account
    Write-host -Object "New Balance of $ToAccount" -ForegroundColor Green -BackgroundColor Black
    Write-Transaction -Transaction $ToMoney
}
