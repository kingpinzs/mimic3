# Directory of *this* script
$this_dir = (Get-Location).Path

# Path to virtual environment
$venv = $this_dir + "\venv"
$activateVenv = $venv + "\Scripts\activate.ps1"

if (Test-Path $venv) {
    # Activate virtual environment if available
    Invoke-expression  $activateVenv
}

$testFiles = $this_dir + "\tests"

#get all python files in directory
Get-ChildItem -Path $testFiles -Filter *.py -Recurse | Select-Object -ExpandProperty $python_files

$python_files

$modules = @('mimic3_tts', 'mimic3_http', 'opentts_abc')

foreach ($module_name in $modules) {
    $python_files += $module_name
}

$python_files

<#
for module_name in 'mimic3_tts' 'mimic3_http' 'opentts_abc'; do
    python_files+=("${module_name}")
done

# Format code
black "${python_files[@]}"
isort "${python_files[@]}"

# Check
flake8 "${python_files[@]}"
pylint "${python_files[@]}"
mypy "${python_files[@]}" #>