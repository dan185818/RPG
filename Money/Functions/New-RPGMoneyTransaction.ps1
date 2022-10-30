Function New-RPGMoneyTransaction
{
    #region Collect Information
    Write-Host -Object "A new transaction is being created.  Use negatives for withdrawls, and positive for deposits"
    Write-Host -Object "Which Account: PC, PCBank, PartyFund, Tax" -ForegroundColor Black -BackgroundColor Green
    [string]$Account = Read-Host
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
    
   
    #endregion

    #region Create object
    $Money = New-Object -TypeName psobject
    $Money | Add-Member -MemberType NoteProperty -Name PP -Value $pp
    $Money | Add-Member -MemberType NoteProperty -Name GP -Value $gp
    $Money | Add-Member -MemberType NoteProperty -Name SP -Value $sp
    $Money | Add-Member -MemberType NoteProperty -Name CP -Value $cp
    $Money | Add-Member -MemberType NoteProperty -Name Account -Value $Account
    $Money | Add-Member -MemberType NoteProperty -Name Note -Value $note

    Write-Transaction -Transaction $money
    
}
