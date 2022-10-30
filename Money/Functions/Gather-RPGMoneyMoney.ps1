function Gather-RPGMoneyMoney
{
    #region Collect Information
    write-host -Object "How many Platinum Pieces?" -ForegroundColor Black -BackgroundColor white
    [int]$pp = read-host 
    Write-Host -Object "How many Gold Pieces?" -ForegroundColor Black -BackgroundColor Yellow
    [int]$gp = read-host
    write-host -object "How many Silver Pieces?" -ForegroundColor black -BackgroundColor Gray
    [int]$sp = Read-Host
    Write-host -Object "How many Copper Pieces?" -ForegroundColor Black -BackgroundColor DarkYellow
    [int]$cp = Read-Host
    write-host -Object "How many players? Do not include the party fund."
    [int]$PartyMembers = Read-Host
    write-host -Object "How many shares does the party fund get?"
    [int]$PartyFundShare = Read-Host
    write-host -object "What is the tax rate, in decimal?"
    [decimal]$TaxRate = Read-Host
    #endregion

    #region Create object
    $Money = New-Object -TypeName psobject
    $Money | Add-Member -MemberType NoteProperty -Name PP -Value $pp
    $Money | Add-Member -MemberType NoteProperty -Name GP -Value $gp
    $Money | Add-Member -MemberType NoteProperty -Name SP -Value $sp
    $Money | Add-Member -MemberType NoteProperty -Name CP -Value $cp
    $Money | Add-Member -MemberType NoteProperty -Name PartyMembers -Value $PartyMembers
    $Money | Add-Member -MemberType NoteProperty -Name PartyFundShare -Value $PartyFundShare
    $Money | Add-Member -MemberType NoteProperty -Name TaxRate -Value $TaxRate
    #endregion

    #region Output
    $Money
    #endregion
}
