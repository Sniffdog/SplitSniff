﻿$Path = '.\Bin\NVIDIA-Alexis\ccminer.exe'
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
    Keccak = 'keccak'
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
    #Nist5 = 'nist5'
}

$Optimizations = [PSCustomObject]@{
    Lyra2z = ''
    Equihash = ''
    Cryptonight = ''
    Ethash = ''
    Sia = ''
    Yescrypt = ''
    BlakeVanilla = ''
    Lyra2RE2 = ''
    Skein = ' -d $SplitSniffCC'
    Qubit = ''
    NeoScrypt = ''
    X11 = ' -d $SplitSniffCC'
    MyriadGroestl = ' -d $SplitSniffCC'
    Groestl = ''
    Keccak = ' -d $SplitSniffCC'
    Scrypt = ''
    Bitcore = ''
    Blake2s = ' -d $SplitSniffCC'
    Sib = ' -d $SplitSniffCC'
    X17 = ' -d $SplitSniffCC'
    Quark = ''
    Hmq1725 = ''
    Veltor = ' -d $SplitSniffCC'
    X11evo = ''
    Timetravel = ''
    Blakecoin = ' -d $SplitSniffCC'
    Lbry = ' -d $SplitSniffCC'
    C11 = ' -d $SplitSniffCC'
    Nist5 = ''
}

$Algorithms | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = 'NVIDIA'
        Path = $Path
        Arguments = -Join ('-a ', $Algorithms.$_, ' -o stratum+tcp://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -u $($Pools.', $_, '.User) -p $($Pools.', $_, '.Pass)', $Optimizations.$_)
        HashRates = [PSCustomObject]@{$_ = -Join ('$($Stats.', $Name, '_', $_, '_HashRate.Week)')}
        API = 'Ccminer'
        Port = 4068
        Wrap = $false
        URI = $Uri
    }
}
