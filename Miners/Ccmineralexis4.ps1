﻿$Path = '.\Bin\NVIDIA-Alexis4\ccminer.exe'
$Uri = 'https://github.com/nemosminer/ccminer-Alexis78/releases/download/ccminer-alexis78/ccminer-alexis78-ms2013-cuda7.5.7z'

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Algorithms = [PSCustomObject]@{
    #Lyra2z = 'lyra2z'
    #Equihash = 'equihash' #not supported
    #Cryptonight = 'cryptonight'
    #Ethash = 'ethash' #not supported
    #Sia = 'sia'
    #Yescrypt = 'yescrypt'
    #BlakeVanilla = 'vanilla'
    #Lyra2RE2 = 'lyra2v2'
    Skein = 'skein'
    #Qubit = 'qubit'
    #NeoScrypt = 'neoscrypt'
    X11 = 'x11'
    MyriadGroestl = 'myr-gr'
    #Groestl = 'groestl'
    #Keccak = 'keccak'
    #Scrypt = 'scrypt'
    #Bitcore = 'bitcore'
    Blake2s = 'blake2s'
    Sib = 'sib'
    X17 = 'x17'
    #Quark = 'quark'
    #Hmq1725 = 'hmq1725'
    Veltor = 'veltor'
    #X11evo = 'x11evo'
    #Timetravel = 'timetravel'
    Blakecoin = 'blakecoin'
    Lbry = 'lbry'
    C11 = 'c11'
    Nist5 = 'nist5'
}

$Optimizations = [PSCustomObject]@{
    Lyra2z = ''
    Equihash = ''
    Cryptonight = ''
    Ethash = ''
    Sia = ''
    Yescrypt = ''
    BlakeVanilla = ''
    Lyra2RE2 = ' -i 25 -d $SplitSniffCC4'
    Skein = ' -i 28 -d $SplitSniffCC4'
    Qubit = ''
    NeoScrypt = ''
    X11 = ' -d $SplitSniffCC4'
    MyriadGroestl = ' -d $SplitSniffCC4'
    Groestl = ''
    Keccak = ' -d $SplitSniffCC4'
    Scrypt = ''
    Bitcore = ''
    Blake2s = ' -d $SplitSniffCC4'
    Sib = ' -i 21 -d $SplitSniffCC4'
    X17 = ' -i 21.5 -d $SplitSniffCC4'
    Quark = ''
    Hmq1725 = ''
    Veltor = ' -d $SplitSniffCC4'
    X11evo = ''
    Timetravel = ''
    Blakecoin = ' -d $SplitSniffCC4'
    Lbry = ' -i 28 -d $SplitSniffCC4'
    C11 = ' -d $SplitSniffCC4'
    Nist5 = ' -i 25 -d $SplitSniffCC4'
}

$Algorithms | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = 'NVIDIA4'
        Path = $Path
        Arguments = -Join ('-a ', $Algorithms.$_, ' -o stratum+tcp://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -b 0.0.0.0:4072 -u $($Pools.', $_, '.User4) -p $($Pools.', $_, '.Pass)', $Optimizations.$_)
        HashRates = [PSCustomObject]@{$_ = -Join ('$($Stats.', $Name, '_', $_, '_HashRate.Week)')}
        API = 'Ccminer'
        Port = 4072
        Wrap = $false
        URI = $Uri
    }
}
