Function Get-RPGMoneyAllBalances
{
    [cmdletbinding()]
    param()

    Write-host -Object "Balances"
    Write-host -Object "PC Balance" -ForegroundColor Green -BackgroundColor Black
    Read-BalanceProcess -fileLocation $files.pc | display-purse

    Write-host -Object "PC Bank Balance" -ForegroundColor Green -BackgroundColor Black
    Read-BalanceProcess -fileLocation $files.pcbank | display-purse

    Write-host -Object "Party Fund" -ForegroundColor Green -BackgroundColor Black
    Read-BalanceProcess -fileLocation $files.PartyFund | display-purse

    Write-host -Object "Unpaid Tax" -ForegroundColor Green -BackgroundColor Black
    Read-BalanceProcess -fileLocation $files.tax | display-purse
}
