Function Read-RPGMoneyBalanceProcess
{
    [cmdletbinding()]
    param([parameter(Mandatory=$true)][string]$fileLocation)

    $Purse = Get-Content -Path $fileLocation -Tail 1
    $Balance = Parse-Balance -InputString $purse
    $Money = New-Object -TypeName PSObject
    $Money | Add-Member -MemberType NoteProperty -Name PP -Value $Balance.pp
    $Money | Add-Member -MemberType NoteProperty -Name GP -Value $Balance.gp
    $Money | Add-Member -MemberType NoteProperty -Name SP -Value $Balance.sp
    $Money | Add-Member -MemberType NoteProperty -Name CP -Value $Balance.cp
    
    $Money
}
