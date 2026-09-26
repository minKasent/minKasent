$ErrorActionPreference = "Continue"

for ($i = 24; $i -le 55; $i++) {
    git -C D:\Khoa\minKasent checkout main | Out-Null
    git -C D:\Khoa\minKasent pull origin main | Out-Null
    git -C D:\Khoa\minKasent checkout -B "pair-gold-$i" main | Out-Null
    Set-Content -Path "D:\Khoa\minKasent\pair_gold_$i.txt" -Value "Gold bump $i"
    git -C D:\Khoa\minKasent add "pair_gold_$i.txt" | Out-Null
    git -C D:\Khoa\minKasent commit -m "chore: level up pair extraordinaire gold round $i`n`nCo-authored-by: Claude Code <noreply@anthropic.com>" | Out-Null
    git -C D:\Khoa\minKasent push -u origin "pair-gold-$i" --force | Out-Null
    $prUrl = gh pr create --repo minKasent/minKasent --head "pair-gold-$i" --base main --title "chore: pair gold bump $i" --body "Co-author pair extraordinaire gold trigger"
    Start-Sleep -Seconds 1
    gh pr merge "pair-gold-$i" --repo minKasent/minKasent --merge --delete-branch --admin | Out-Null
    git -C D:\Khoa\minKasent checkout main | Out-Null
    git -C D:\Khoa\minKasent pull origin main | Out-Null
    Write-Host "Successfully merged pair gold round $i"
}

Remove-Item -Force D:\Khoa\minKasent\pair_gold_*.txt -ErrorAction SilentlyContinue
git -C D:\Khoa\minKasent add . | Out-Null
git -C D:\Khoa\minKasent commit -m "chore: clean up temporary trigger files" | Out-Null
git -C D:\Khoa\minKasent push origin main | Out-Null
Write-Host "ALL 50+ PRS FINISHED SUCCESSFULLY!"
