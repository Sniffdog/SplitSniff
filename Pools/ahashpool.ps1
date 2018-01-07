. .\Include.ps1

try
{
    $ahashpool_Request = Invoke-WebRequest "https://www.ahashpool.com/api/status" -UseBasicParsing | ConvertFrom-Json
}
catch
{
    return
}

if(-not $ahashpool_Request){return}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Location = "US"

$ahashpool_Request | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | foreach {
    $ahashpool_Host = "$_.mine.ahashpool.com"
    $ahashpool_Port = $ahashpool_Request.$_.port
    $ahashpool_Algorithm = Get-Algorithm $ahashpool_Request.$_.name
    $ahashpool_Coin = "Unknown"

    $Divisor = 1000000
	
    switch($ahashpool_Algorithm)
    {
        "equihash"{$Divisor /= 1000}
        "blake2s"{$Divisor *= 1000}
		"blakecoin"{$Divisor *= 1000}
        "decred"{$Divisor *= 1000}
        "x11"{$Divisor *= 100}
    }

    if((Get-Stat -Name "$($Name)_$($ahashpool_Algorithm)_Profit") -eq $null){$Stat = Set-Stat -Name "$($Name)_$($ahashpool_Algorithm)_Profit" -Value ([Double]$ahashpool_Request.$_.estimate_last24h/$Divisor)}
    else{$Stat = Set-Stat -Name "$($Name)_$($ahashpool_Algorithm)_Profit" -Value ([Double]$ahashpool_Request.$_.estimate_current/$Divisor)}
	
    if($Wallet)
    {
        [PSCustomObject]@{
            Algorithm = $ahashpool_Algorithm
            Info = $ahashpool_Coin
            Price = $Stat.Live
            StablePrice = $Stat.Week
            MarginOfError = $Stat.Fluctuation
            Protocol = "stratum+tcp"
            Host = $ahashpool_Host
            Port = $ahashpool_Port
            User0 = $Wallet0
	    User1 = $Wallet1
	    User2 = $Wallet2
	    User3 = $Wallet3
	    User4 = $Wallet4
	    User5 = $Wallet5
	    User6 = $Wallet6
            User7 = $Wallet7
            Pass = "ID=$Workername,c=$Passwordcurrency"
            Location = $Location
            SSL = $false
        }
    }
}
