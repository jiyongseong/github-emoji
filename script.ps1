# Fetch GitHub emoji data
$emojis = (Invoke-WebRequest -Uri 'https://api.github.com/emojis').Content | ConvertFrom-Json | Get-Member -MemberType NoteProperty

# Build the README content with modern design
$readme = @"
# 🎨 GitHub Emoji Reference

> A comprehensive, auto-updated collection of all GitHub emojis

## 📊 Statistics

- **Total Emojis:** $($emojis.Count)
- **Last Updated:** $(Get-Date -Format "MMMM dd, yyyy 'at' HH:mm 'UTC'") ⏰

---

## 🔍 Quick Search Tips

- Use **Ctrl+F** (Windows/Linux) or **Cmd+F** (Mac) to find specific emojis
- All emoji codes use the format `:emoji_name:`

---

## 📝 Emoji List

| Preview | Code | Name |
|---------|------|------|
"@

foreach($item in $emojis) {
    $emojiName = $item.Name.ToString()
    $readme += "`n| :$emojiName`: | ``:$emojiName``: | $emojiName |"
}

$readme += @"

---

## 💡 How to Use

Simply copy the emoji code (e.g., ``:smile:``) and paste it into:
- GitHub Issues
- Pull Requests
- Comments
- Commit messages
- Markdown files

## 🔄 Auto-Update

This document is automatically generated. To update:

``````powershell
.\script.ps1
``````

## 📚 Resources

- [GitHub Emoji API](https://api.github.com/emojis)
- [GitHub Emoji Cheat Sheet](https://github.com/ikatyang/emoji-cheat-sheet)

---

<div align="center">
  
**Made with ❤️ using PowerShell**
  
*Last sync: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss") UTC*

</div>
"@

# Write to README.md
$readme | Out-File -FilePath "README.md" -Encoding UTF8
Write-Host "✅ README.md has been updated successfully!" -ForegroundColor Green
Write-Host "📊 Total emojis: $($emojis.Count)" -ForegroundColor Cyan
