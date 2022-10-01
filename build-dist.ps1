# Directory of *this* script
$this_dir = (Get-Location).Path
$dist_dir = $this_dir + "\dist"
$mak_dir = "mkdir -p " + $dist_dir

Invoke-expression $mak_dir

Push-Location $this_dir
python setup.py sdist --formats=zip