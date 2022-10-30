Function Parse-RPGMoneyBalance
{
    [cmdletbinding()]
    param([parameter(mandatory=$true)]$InputString)
   
   
    $parts = $InputString -split ","
    $OutputObject = New-Object -TypeName psobject
    $outputObject | Add-Member -MemberType NoteProperty -name PP -Value $parts[0]
    $outputObject | Add-Member -MemberType NoteProperty -name GP -Value $parts[1]
    $outputObject | Add-Member -MemberType NoteProperty -name SP -Value $parts[2]
    $outputObject | Add-Member -MemberType NoteProperty -name CP -Value $parts[3]
    $outputObject | Add-Member -MemberType NoteProperty -name Notes -Value $parts[4]

    $outputObject
}
