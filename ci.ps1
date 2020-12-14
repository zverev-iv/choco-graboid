Param (
	[Parameter(Mandatory=$false, Position=1)]
	[bool] $staticAnalysis = $false,
	[Parameter(Mandatory=$false, Position=2)]
	[bool] $build = $false,
	[Parameter(Mandatory=$false, Position=3)]
	[bool] $deploy = $false
)

if(!$staticAnalysis -and !$build -and $deploy) {
	Write-Output "Nothing to do."
	return 0
}

if($staticAnalysis) {
	Invoke-ScriptAnalyzer "$((Get-ChildItem .\*\tools\*.ps1).FullName)"
}

if($build) {
	choco pack "$((Get-ChildItem .\*\*.nuspec).FullName)"
}

if($deploy) {
	choco apikey --key $CHOCOAPIKEY --source https://push.chocolatey.org/
	choco push
}
