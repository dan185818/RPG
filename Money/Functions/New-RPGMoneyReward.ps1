Function New-RPGMoneyReward
{
    [cmdletbinding()]
    param()
    #gather the inputs
    Write-Host -Object "Put the total reward in. This will add the amount to the PC account and the Party Fund account after separating it out"
    $notes = Read-Host -Prompt "Notes for ledger"
    $Shares = Gather-Money | Calculate-Share

    #write share for each
    $shares | Display-Share
    
    
    #Get old balances
    Write-host -object "`nOldBalances"
    write-host -Object "Tax:" -ForegroundColor Green -BackgroundColor Black
    Get-Balance -BalanceName "Tax"

    write-host -Object "Party Fund:" -ForegroundColor Green -BackgroundColor Black
    Get-Balance -BalanceName "PartyFund"

    write-host -Object "PC:" -ForegroundColor Green -BackgroundColor Black
    Get-Balance -BalanceName "PC"

   


    #write tax to tax file
    $Tax = New-Object -TypeName psobject
    $Tax | Add-Member -MemberType NoteProperty -Name pp -Value $shares.pptax
    $Tax | Add-Member -MemberType NoteProperty -Name gp -Value $shares.pptax
    $Tax | Add-Member -MemberType NoteProperty -Name sp -Value $shares.pptax
    $Tax | Add-Member -MemberType NoteProperty -Name cp -Value $shares.pptax
    $Tax | Add-Member -MemberType NoteProperty -Name Account -Value "Tax"
    $tax | Add-Member -MemberType NoteProperty -Name Note -value $notes
    
    write-host -Object "`nNew Balances"
    write-host -Object "Tax:" -ForegroundColor Green -BackgroundColor Black
    Write-Transaction -Transaction $Tax

    #Write to Party Fund
    
    $PF = New-Object -TypeName psobject
    $PF | Add-Member -MemberType NoteProperty -Name pp -Value $shares.NetSharePP
    $PF | Add-Member -MemberType NoteProperty -Name gp -Value $shares.NetShareGP
    $PF | Add-Member -MemberType NoteProperty -Name sp -Value $shares.NetShareSP
    $PF | Add-Member -MemberType NoteProperty -Name cp -Value $shares.PartyShareCP
    $PF | Add-Member -MemberType NoteProperty -Name Account -Value "PartyFund"
    $PF | Add-Member -MemberType NoteProperty -Name Note -value $notes
    
    write-host -Object "Party Fund:" -ForegroundColor Green -BackgroundColor Black
    Write-Transaction -Transaction $PF

    #write to PC
    $PC = New-Object -TypeName psobject
    $PC | Add-Member -MemberType NoteProperty -Name pp -Value $shares.NetSharePP
    $PC | Add-Member -MemberType NoteProperty -Name gp -Value $shares.NetShareGP
    $PC | Add-Member -MemberType NoteProperty -Name sp -Value $shares.NetShareSP
    $PC | Add-Member -MemberType NoteProperty -Name cp -Value $shares.NetShareCP
    $PC | Add-Member -MemberType NoteProperty -Name Account -Value "PC"
    $PC | Add-Member -MemberType NoteProperty -Name Note -value $notes
    write-host -Object "PC:" -ForegroundColor Green -BackgroundColor Black
    Write-Transaction -Transaction $PC


}
