function Display-RPGMoneyShare
{
    [cmdletbinding()]
    param([parameter(Mandatory=$true,ValueFromPipeline=$true)]$purse)

    Write-Host -Object "`r`nTax Paid"
    Write-Host -Object "Platinum:`t$($purse.pptax)" -ForegroundColor Black -BackgroundColor White
    Write-host -Object "Gold:`t`t$($Purse.gptax)" -ForegroundColor black -BackgroundColor Yellow
    write-host -Object "Silver:`t`t$($Purse.SPTax)" -ForegroundColor Black -BackgroundColor Gray
    write-host -object "Copper:`t`t$($Purse.cptax)" -ForegroundColor Black -BackgroundColor DarkYellow
    write-host -Object "`r`nPlayer Shares"
    Write-Host -Object "Platinum:`t$($purse.Netsharepp)" -ForegroundColor Black -BackgroundColor White
    Write-host -Object "Gold:`t`t$($Purse.netsharegp)" -ForegroundColor black -BackgroundColor Yellow
    write-host -Object "Silver:`t`t$($Purse.netsharesp)" -ForegroundColor Black -BackgroundColor Gray
    write-host -object "Copper:`t`t$($Purse.netsharecp)" -ForegroundColor Black -BackgroundColor DarkYellow
    if ($purse.PartyShareNum -ne 0)
    {
        write-host -Object "`r`nParty Fund"
        Write-Host -Object "Platinum:`t$($purse.Netsharepp)" -ForegroundColor Black -BackgroundColor White
        Write-host -Object "Gold:`t`t$($Purse.netsharegp)" -ForegroundColor black -BackgroundColor Yellow
        write-host -Object "Silver:`t`t$($Purse.netsharesp)" -ForegroundColor Black -BackgroundColor Gray
        write-host -object "Copper:`t`t$($Purse.Partysharecp)" -ForegroundColor Black -BackgroundColor DarkYellow
    }
    if (($purse.PartyShareNum -eq 0) -and ($Purse.PartySharecp -ne $Purse.netsharecp))
    {
        $PartyShare = $purse.PartyShareCP - $Purse.NetshareCP
        write-host -Object "The money didn't split evenly.  Add this back to the party fund"
        Write-host -Object "Copper: `t$PartyShare" -ForegroundColor Black -BackgroundColor DarkYellow
    }
}
