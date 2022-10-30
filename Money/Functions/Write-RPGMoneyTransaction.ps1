Function Write-RPGMoneyTransaction
{
    [cmdletbinding()]
    param([parameter(Mandatory=$true,ValueFromPipeline=$true)]$Transaction)
    
    #Get account file
     switch($transaction.account)
    {
        "PC" {$FilePath = $files.pc}
        "PCBank" {$FilePath = $Files.pcbank}
        "PartyFund" {$FilePath = $files.partyfund}
        "Tax" {$FilePath = $files.tax}
    }
    
    #get balance
    $Balance = Read-BalanceProcess -fileLocation $filepath
        
    #add together
    [int]$NewBalancepp = [int]$Balance.pp + $Transaction.pp
    [int]$NewBalancegp = [int]$Balance.gp + $transaction.gp
    [int]$NewBalancesp = [int]$Balance.sp + $Transaction.sp
    [int]$NewBalancecp = [int]$Balance.cp + $Transaction.cp

    #write out
    Out-File -FilePath $filepath -Encoding ascii -append -force -InputObject "$($Transaction.pp),$($Transaction.gp),$($Transaction.sp),$($Transaction.cp),$($Transaction.note)`n$NewBalancepp,$NewBalancegp,$NewBalancesp,$NewBalancecp,Balance"

    #show new balance
    Get-Balance -BalanceName "$($transaction.account)"
}
