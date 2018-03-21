<## Scrape web request #########################>

foreach($line in Get-Content .\hosts) {
    $hostname = $line.toUpper()
        $link = Invoke-Webrequest -uri "https://$url?reqid=$hostname" -UseDefaultCredential
        $result = $link.AllElements | Where Class -eq "hostTD" | Select -First 2 -ExpandProperty innerText
        write-Host $result.replace("`n", " ")
}

<## Scan list of ports #########################>

if ($args[0] -eq $null) {
        write-Host "$Usage ./ports.ps1 <host>"
        exit
}

$reader = [System.IO.File]::OpenText("h:\ports.lst")

while($null -ne ($line = $reader.ReadLine())) {
        if (test-NetConnection -InformationLevel Quiet -ComputerName $args[0] -Port $line) {
                write-Host "$line is open" -ForegroundColor Green
        }
}
$reader.Close()

<## Ping a list ################################>

$reader = [System.IO.File]::OpenText("ping.lst")
while($null -ne ($line = $reader.ReadLine())) {
        if (test-Connection -ComputerName $line -Count 1 -Quiet) {
                write-Host "$line is alive" -ForegroundColor Green } else {
                write-Host "$line no reply" -ForegroundColor Yellow -BackgroundColor Black
        }
}
$reader.Close()

<## Goofing around ##############################>

cls
$C = @("Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White")
while($true){ $rand = -join ((65..90) + (97..122) | Get-Random -Count 1 | % {[char]$_}); Write-Host -NoNewline $rand -foregroundcolor $C[(Get-Random ([array]$C).count)]  -backgroundcolor $C[(Get-Random ([array]$C).count)]; }

<## Process list ################################>

$ProcArray = @()
$Processes = get-process | Group-Object -Property ProcessName
foreach($Process in $Processes)
{
    $prop = @(
            @{n='Count';e={$Process.Count}}
            @{n='Name';e={$Process.Name}}
            @{n='Memory';e={($Process.Group|Measure WorkingSet -Sum).Sum}}
            )
    $ProcArray += "" | select $prop
}
$ProcArray | sort -Descending Memory | select Count,Name,@{n='Memory usage(Total)';e={"$(($_.Memory).ToString('N0'))Kb"}}

