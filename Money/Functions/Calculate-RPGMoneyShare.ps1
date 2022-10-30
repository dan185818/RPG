function Calculate-RPGMoneyShare
{
    <#
    .SYNOPSIS
    Calculates the individual and group fund portion of coins found/received.
    .DESCRIPTION
    This takes either a pre-formatted Powershell Object with the reqiured data or each individual type of coin, the number to split it by, the party fund share factor, and the tax rate.
    It then calculates the share for each person and the party fund, with any indivisible money (copper pieces) going to the party fund.
    .EXAMPLE
    Caclulate-Share 15 14 13 18
    This uses the positional parameters for PP, GP, SP, CP, using the default party members, Party Fund share, and tax rate

    .EXAMPLE
    Calculate-Share -PPin 15 -GPin 14 -SPin 13 -PartyMembersIn 4 -PartyFundShareIn 2 -TaxRateIn 0.1
    This specifies more data.  It changes the Party Member count, and the portion the Party Fund gets.  
    
    .EXAMPLE
    $Purse | Calculate-Share
    This passes in a psObject to Calculate-Share
    #>
   
    [cmdletbinding()]
    param([parameter(ParameterSetName='Manual',Position=0)][int]$PPin = 0,
          [parameter(ParameterSetName='Manual',Position=1)][int]$GPin = 0,
          [parameter(ParameterSetName='Manual',Position=2)][int]$SPin = 0,
          [parameter(ParameterSetName='Manual',Position=3)][int]$CPin = 0,
          [parameter(ParameterSetName='Manual')][int]$PartyMembersIn = 4,
          [parameter(ParameterSetName='Manual')][int]$PartyFundShareIn = 1,
          [parameter(ParameterSetName='Manual')][decimal]$TaxRateIn = 0.0,
          [parameter(ParameterSetName='Function',valuefrompipeline=$true)]$PSObjectIn
          )
          
    #region determine if data is a psobject or individual
    if ($PSObjectIn)
    {
        $pp = $PSObjectIn.PP
        $gp = $PSObjectIn.GP
        $sp = $PSObjectIn.SP
        $CP = $PSObjectIn.CP
        $PartyMembers = $PSObjectIn.PartyMembers
        $PartyFundShare = $PSObjectIn.PartyFundShare
        $TaxRate = $PSObjectIn.TaxRate 
        $Shares = $PartyMembers + $PartyFundShare
    }
    else
    {
        $pp = $ppin
        $gp = $gpin
        $sp = $spin
        $cp = $cpin
        $PartyMembers = $PartyMembersin
        $PartyFundShare = $PartyFundShareIn
        $TaxRate = $TaxRateIn
        $shares = $partyMembers + $PartyFundShare
    }
    #endregion
    
    #region create object and put original purse values in
    $Purse = New-Object -TypeName psobject
    $Purse | Add-Member -MemberType NoteProperty -name TotalPP -Value $pp
    $Purse | Add-Member -MemberType NoteProperty -name TotalGP -Value $gp
    $Purse | Add-Member -MemberType NoteProperty -name TotalSP -Value $sp
    $Purse | Add-Member -MemberType NoteProperty -name TotalCP -Value $cp
    $purse | Add-Member -MemberType NoteProperty -name Shares -Value $shares
    #endregion

    #region Determine Tax due and add to the object
    #figure tax for each.
    $taxpp = $($purse.Totalpp) * $TAXRATE
    $taxgp = $($purse.Totalgp) * $TAXRATE
    $taxsp = $($purse.Totalsp) * $TAXRATE
    $taxcp = $($purse.Totalcp) * $TAXRATE
   
    #Find out how much is left after taxes.
    #PP Tax breakdown name is platinum pieces paid for taxpp, gold pieces paid for taxpp
    $pptaxpp = [int]([math]::truncate($taxpp))
    $gptaxpp = [int]([math]::truncate((($taxpp % 1) *10)))
    $sptaxpp = [int]([math]::truncate((($taxpp %1) *100) - ($gptaxpp*10)))
    $cptaxpp = [int]([math]::truncate((($taxpp % 1) * 1000) - ($gptaxpp * 100) - ($sptaxpp *10)))

    #gp tax breakdown
    $gptaxgp = [int]([math]::truncate($taxgp))
    $sptaxgp = [int]([math]::truncate((($taxgp % 1)*10)))
    $cptaxgp = [int]([math]::truncate((($taxgp % 1)*100) - ($sptaxgp*10)))
        
    #sp tax breakdown
    $sptaxsp = [int]([math]::Truncate($taxsp)) 
    $cptaxsp = [int]([math]::truncate((($taxsp % 1)*10)))

    #cp tax (round to nearest using bankers rounding)
    $cptaxcp = [int]$taxcp

    $totalPPTax = $pptaxpp
    $totalGPTax = $gptaxpp + $gptaxgp
    $totalSPTax = $sptaxpp + $sptaxgp + $sptaxsp
    $totalCPTax = $cptaxpp + $cptaxgp + $cpTaxsp + $cptaxcp
    

    #Add tax
    $purse | Add-Member -MemberType NoteProperty -Name PPTax -Value $totalPPTax
    $purse | Add-Member -MemberType NoteProperty -Name GPTax -Value $totalGPTax
    $purse | Add-Member -MemberType NoteProperty -Name SPTax -Value $totalSPTax
    $purse | Add-Member -MemberType NoteProperty -name CPTax -Value $totalCPTax
    #endregion

    #region determine net money and add to object
    if ($gp-$totalGPTax -lt 0)
    {
        $pp--
        $gp += 10
    }

    if ($sp-$totalSPTax -lt 0)
    {
        $gp--
        $sp += 10
    }

    if ($cp-$totalCPTax -lt 0)
    {
        $sp--
        $cp += 10
    }

    #apply net money
    $purse | Add-Member -MemberType NoteProperty -Name NetPP -Value ($pp - $totalPPTax)
    $purse | Add-Member -MemberType NoteProperty -Name NetGP -value ($gp - $totalGPTax)
    $purse | Add-Member -MemberType NoteProperty -name NetSP -Value ($sp - $totalSPTax)
    $purse | Add-Member -MemberType NoteProperty -Name NetCP -Value ($cp - $totalCPTax)
    #endregion 

    #Region find each share - uneven portions go to party fund
    #platinum
    $ppsharepp = [int][math]::Truncate($($purse.netpp) / $($Purse.shares))
    $extraPP = ($($Purse.netpp) - ($ppsharepp * $($purse.shares)))
    
    $GPToSplit = $($purse.netgp) + ($extraPP *10)
    $gpsharegp = [int][math]::Truncate($gptosplit / $($Purse.shares))
    $extraGP = ($GPToSplit - ($gpsharegp * $($purse.shares)))

    $SPToSplit = $($purse.netsp) + ($extraGP * 10)
    $spsharesp = [int][math]::Truncate($SPToSplit / $($Purse.Shares))
    $ExtraSP = ($SPToSplit - ($spsharesp * $($purse.shares)))
    
    $CPToSplit = $($purse.netcp) + ($extraSP*10)
    $cpsharecp = [int][math]::Truncate($CPToSplit / $($Purse.Shares))
    $ExtraCP = ($CPToSplit - ($cpsharecp * $($purse.shares)))
    
    $PartyCPShare = $cpsharecp + $extracp
        
    $purse | Add-Member -MemberType NoteProperty -Name NetSharePP -Value $ppsharepp
    $purse | Add-Member -MemberType NoteProperty -name NetShareGP -value $gpsharegp
    $purse | Add-Member -MemberType NoteProperty -Name NetShareSP -Value $spsharesp
    $purse | Add-Member -MemberType NoteProperty -Name NetShareCP -Value $cpsharecp
    $purse | Add-Member -MemberType NoteProperty -Name PartyShareCP -value $PartyCPShare
    $purse | Add-Member -MemberType NoteProperty -Name PartyShareNum -value $PartyFundShareIn
    #endregion

    #region output
    $purse
    #endregion
}
