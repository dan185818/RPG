Function Select-RPGMoneyCampaign
{
    [cmdletbinding()]
    param()

    

    Write-Output "Choose the Index of the campaign`n1: Partharia (Elric)`n2: Roman god (Marcus Flaminius Cincinatus)`n3: Partheria (Gaelei Mahannen)"
    [int]$Index = Read-Host "Index?"

    switch ($index)
    {
        1
        {
            $Files = New-Object -TypeName psobject 
            $Files | add-member -Name "PC" -Value "$env:OneDriveConsumer\RPGs\Campaigns\Partheria\Money\PC.txt" -MemberType NoteProperty
            $Files | add-member -Name "PCBank" -value "$env:OneDriveConsumer\RPGs\Campaigns\Partheria\Money\PCBank.txt" -MemberType NoteProperty
            $Files | add-member -Name "PartyFund" -value "$env:OneDriveConsumer\RPGs\Campaigns\Partheria\Money\PartyFund.txt" -MemberType NoteProperty
            $Files | add-member -Name "Tax" -Value "$env:OneDriveConsumer\RPGs\Campaigns\Partheria\Money\Tax.txt" -MemberType NoteProperty
        }
        2
        {
            $Files = New-Object -TypeName psobject 
            $Files | add-member -Name "PC" -Value "$env:OneDriveConsumer\RPGs\Campaigns\Roman Ragnarok\Money\PC.txt" -MemberType NoteProperty
            $Files | add-member -Name "PCBank" -value "$env:OneDriveConsumer\RPGs\Campaigns\Roman Ragnarok\Money\PCBank.txt" -MemberType NoteProperty
            $Files | add-member -Name "PartyFund" -value "$env:OneDriveConsumer\RPGs\Campaigns\Roman Ragnarok\Money\PartyFund.txt" -MemberType NoteProperty
            $Files | add-member -Name "Tax" -Value "$env:OneDriveConsumer\RPGs\Campaigns\Roman Ragnarok\Money\Tax.txt" -MemberType NoteProperty
        }
        3
        {
            $Files = New-Object -TypeName psobject 
            $Files | add-member -Name "PC" -Value "E:\OneDrive\OneDrive\RPGs\Campaigns\Partheria2\Money\PC.txt" -MemberType NoteProperty
            $Files | add-member -Name "PCBank" -value "E:\OneDrive\OneDrive\RPGs\Campaigns\Partheria2\Money\PCBank.txt" -MemberType NoteProperty
            $Files | add-member -Name "PartyFund" -value "E:\OneDrive\OneDrive\RPGs\Campaigns\Partheria2\Money\PartyFund.txt" -MemberType NoteProperty
            $Files | add-member -Name "Tax" -Value "E:\OneDrive\OneDrive\RPGs\Campaigns\Partheria2\Money\Tax.txt" -MemberType NoteProperty
        }
    }

    $Files
}
