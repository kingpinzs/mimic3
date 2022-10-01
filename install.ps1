param(
    [Parameter()]
    [Switch]$develop
)

# Directory of *this* script
$this_dir = (Get-Location).Path

# Path to virtual environment
$venv = $this_dir + "\venv"
$activateVenv = $venv + "\Scripts\activate.ps1"

#Python binary to use
$PYTHON = 'python'
$pythonVersion = $PYTHON + ' --version'
# pip install command
if (!$PIP_INSTALL) {
    $PIP_INSTALL="install -f "+$this_dir+"\wheels -f https://synesthesiam.github.io/prebuilt-apps/"
}

$python_version = Invoke-expression $pythonVersion
$activateVenv = $venv + "\Scripts\activate.ps1"

# Create virtual environment
echo "Creating virtual environment at" $venv $python_version
if (Test-Path $venv) {
   rm $venv -r -fo
}
$createenv = $PYTHON + " -m venv " + $venv
Invoke-expression $createenv 

if (Test-Path $venv) {
    # Activate virtual environment if available
    Invoke-expression  $activateVenv
}

# Install Python dependencies
echo 'Installing Python dependencies'
$upgradepip = "pip "+$PIP_INSTALL + " --upgrade pip"
$upgradetools = "pip " + $PIP_INSTALL + " --upgrade wheel setuptools"
Invoke-expression $upgradepip
Invoke-expression $upgradetools

# Install Mimic 3
# pushd "${this_dir}/" 2>/dev/null
#                      send errors to dev null
$this_dir = $this_dir + "/"
Push-Location $this_dir
$installmimic3 = "pip " + $PIP_INSTALL + " -e .[all]"
Invoke-expression $installmimic3

if ($develop) {
    pip install -r requirements_dev.txt
}

echo "Ok"