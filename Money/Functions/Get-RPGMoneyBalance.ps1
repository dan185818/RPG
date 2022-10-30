Function Get-RPGMoneyBalance
{
    [cmdletbinding()]
    param([parameter(Mandatory=$true)][ValidateSet('PC','PCBank','PartyFund','Tax')][string]$BalanceName)

    #pick balance balances
    switch($BalanceName)
    {
        "PC" {$purse = Read-BalanceProcess -fileLocation $files.pc}
        "PCBank" {$purse = Read-BalanceProcess -fileLocation $Files.pcbank}
        "PartyFund" {$purse = Read-BalanceProcess -fileLocation $files.partyfund}
        "Tax" {$purse = Read-BalanceProcess -fileLocation $files.tax}
    }
    #show balance 
    Display-Purse -purse $purse
}
