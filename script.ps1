$items = (Invoke-WebRequest -Uri 'https://api.github.com/emojis').Content | ConvertFrom-Json | Get-Member -MemberType NoteProperty
foreach($item in $items)
{
    [string]::Format(":{0}: ``:{0}:``", $item.Name.ToString()) 
}