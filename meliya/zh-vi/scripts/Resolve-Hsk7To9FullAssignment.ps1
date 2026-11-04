param(
    [Parameter(Mandatory = $true)] [string] $RepositoryRoot
)

$ErrorActionPreference = 'Stop'
$drafts = Join-Path $RepositoryRoot 'meliya/zh-vi/drafts'
$source = Get-Content (Join-Path $RepositoryRoot 'wordlists/exclusive/new/7.json') -Raw | ConvertFrom-Json
$manifest = Get-Content (Join-Path $drafts 'hsk7_9_full_source_assignment.json') -Raw | ConvertFrom-Json

$byWord = @{}
foreach ($entry in $source) {
    if (-not $byWord.ContainsKey($entry.simplified) -or $entry.frequency -lt $byWord[$entry.simplified].frequency) {
        $byWord[$entry.simplified] = $entry
    }
}

$explicit = @{}
foreach ($file in $manifest.explicitCandidateFiles) {
    $candidate = Get-Content (Join-Path $drafts $file) -Raw | ConvertFrom-Json
    foreach ($category in $candidate.categories) {
        foreach ($word in $category.words) {
            if (-not $explicit.ContainsKey($word)) { $explicit[$word] = $category.key }
        }
    }
}

$ranked = @($byWord.Values | Sort-Object frequency, simplified)
$assignments = @{}
for ($index = 0; $index -lt $ranked.Count; $index++) {
    $entry = $ranked[$index]
    $word = $entry.simplified
    if ($explicit.ContainsKey($word)) {
        $assignments[$word] = $explicit[$word]
        continue
    }
    $level = if ($index -lt 1870) { 7 } elseif ($index -lt 3737) { 8 } else { 9 }
    $pos = @($entry.pos) -join ','
    $suffix = if ($pos -match '(^|,)(n|ng|nr|ns|nt|nz)(,|$)') { 'lexical-nouns' } elseif ($pos -match '(^|,)(v|vn)(,|$)') { 'lexical-verbs' } else { 'lexical-modifiers' }
    $assignments[$word] = "hsk$level-c$($(if ($suffix -eq 'lexical-nouns') {'19'} elseif ($suffix -eq 'lexical-verbs') {'20'} else {'21'}))-$suffix"
}

$missing = @($byWord.Keys | Where-Object { -not $assignments.ContainsKey($_) })
$catalogKeys = @()
foreach ($level in 7..9) {
    $catalog = Get-Content (Join-Path $drafts "hsk$level`_category_catalog.json") -Raw | ConvertFrom-Json
    $catalogKeys += @($catalog.categories | ForEach-Object { $_.key })
}
$unknownCategories = @($assignments.Values | Where-Object { $_ -notin $catalogKeys } | Sort-Object -Unique)
[pscustomobject]@{
    sourceUniqueWords = $byWord.Count
    explicitUniqueWords = $explicit.Count
    resolvedAssignments = $assignments.Count
    unassignedWords = $missing.Count
    unknownCategories = $unknownCategories
    categoryCounts = @($assignments.Values | Group-Object | Sort-Object Name | ForEach-Object { [pscustomobject]@{ categoryKey = $_.Name; wordCount = $_.Count } })
} | ConvertTo-Json -Depth 5

if ($missing.Count -gt 0 -or $unknownCategories.Count -gt 0) { exit 1 }
